INSERT INTO editor (id, name, password, privs, email, website, bio, member_since, email_confirm_date, last_login_date, edits_accepted, edits_rejected, auto_edits_accepted, edits_failed, ha1) VALUES (1, 'autoeditor1', '{CLEARTEXT}password', 1, 'autoeditor1@email.com', 'http://test.website', 'biography', '1989-07-23', '2005-10-20', now(), 12, 2, 59, 9, 'deea5e52f725bc948b235708ae795c0d'), (2, 'autoeditor2', '{CLEARTEXT}password', 1, 'autoeditor2@email.com', 'http://test.website', 'biography', '1989-07-23', '2005-10-20', now(), 12, 2, 59, 9, '83a90735621cd5c21135844a765cada6'), (3, 'autoeditor3', '{CLEARTEXT}password', 1, 'autoeditor3@email.com', 'http://test.website', 'biography', '1989-07-23', '2005-10-20', now(), 12, 2, 59, 9, 'a6b5ec377150ddfe23fbe4e852b3ff10'), (5, 'noob1', '{CLEARTEXT}password', 0, 'noob1@email.com', 'http://test.website', 'biography', '1989-07-23', '2005-10-20', now(), 12, 2, 59, 9, 'e0f6eda39b0af93a47ad3ba8f1bccdbf'), (6, 'noob2', '{CLEARTEXT}password', 0, 'noob2@email.com', 'http://test.website', 'biography', '1989-07-23', '2005-10-20', now(), 12, 2, 59, 9, '4c1b6d0776572a47ce3a424efbdea6f6'), (7, 'autoeditor4', '{CLEARTEXT}password', 1, 'autoeditor4@email.com', 'http://test.website', 'biography', '1989-07-23', '2005-10-20', now(), 12, 2, 59, 9, 'e548c5e2e91c72a124b27e6ff2f2942c'), (8, 'autoeditor5', '{CLEARTEXT}password', 1, 'autoeditor5@email.com', 'http://test.website', 'biography', '1989-07-23', '2005-10-20', now(), 12, 2, 59, 9, 'df934bf45e1f89f425ee2c345bf7f228'), (4, 'ModBot', '{CLEARTEXT}mb', 0, '', 'http://musicbrainz.org/doc/ModBot', 'See the above link for more information.', NULL, NULL, NULL, 2, 1, 99951, 3560, '03503a81a03bdbb6055f4a6c8b86b5b8');
