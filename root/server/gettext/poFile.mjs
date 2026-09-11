/*
 * @flow strict
 * Copyright (C) 2015-2018 MetaBrainz Foundation
 *
 * This file is part of MusicBrainz, the open internet music database,
 * and is licensed under the GPL version 2, or (at your option) any
 * later version: http://www.gnu.org/licenses/gpl-2.0.txt
 */

import type {JedOptions} from 'jed';
import fs from 'node:fs';
import path from 'node:path';
import {parseFileSync} from 'po2json';

import MB_SERVER_ROOT from '../../utility/serverRootDir.mjs';

const LOCALE_EXT = /_[a-zA-Z0-9]+\.po$/;
const PO_DIR = path.resolve(MB_SERVER_ROOT, 'po');

function getPath(domain: string, locale: string) {
  return path.resolve(PO_DIR, `${domain}.${locale}.po`);
}

/*
 * Locales that read the catalogs of another locale. zh_TW has no .po files
 * of its own, so it reads the zh_Hant files.
 */
export const LOCALE_ALIASES: {+[locale: string]: string} = {
  zh_TW: 'zh_Hant',
};

function exists(fpath: string): boolean {
  try {
    fs.statSync(fpath);
    return true;
  } catch (err) {
    if (err.code === 'ENOENT') {
      return false;
    }
    throw err;
  }
}

export function find(domain: string, locale: string): string {
  const fpath = getPath(domain, locale);

  if (exists(fpath)) {
    return fpath;
  }

  const alias = LOCALE_ALIASES[locale];
  if (alias != null) {
    const aliased = getPath(domain, alias);
    if (exists(aliased)) {
      return aliased;
    }
  }

  if (/_/.test(locale)) {
    const fallback = fpath.replace(LOCALE_EXT, '.po');

    console.warn(`Warning: ${fpath} does not exist, trying ${fallback}`);

    return fallback;
  }

  // There is no other file to try. This stat throws the original ENOENT.
  fs.statSync(fpath);
  return fpath;
}

export function loadFromPath(fpath: string, domain: string): JedOptions {
  return parseFileSync(fpath, {domain, format: 'jed'});
}

export function load(
  name: string,
  locale: string,
  domain: string = name,
): JedOptions {
  return loadFromPath(find(name, locale), domain);
}
