Content-Type: multipart/mixed; boundary="===============3445819547518689488=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH 0/3] mptcp: fix "fn parameter not described" warnings
Date: Tue, 24 Mar 2020 17:57:06 +0100
Message-ID: <20200324165709.2024557-1-matthieu.baerts@tessares.net>
X-Status: 
X-Keywords:                  
X-UID: 4056

--===============3445819547518689488==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

When checking for extra warnings using 'make W=3D1' [1], I saw this:

  $ make W=3D1 net/mptcp/token.o
  net/mptcp/token.c:53: warning: Function parameter or member 'req' not des=
cribed in 'mptcp_token_new_request'
  net/mptcp/token.c:98: warning: Function parameter or member 'sk' not desc=
ribed in 'mptcp_token_new_connect'
  net/mptcp/token.c:133: warning: Function parameter or member 'conn' not d=
escribed in 'mptcp_token_new_accept'
  net/mptcp/token.c:153: warning: Function parameter or member 'token' not =
described in 'mptcp_token_get_sock'
  net/mptcp/token.c:178: warning: Function parameter or member 'token' not =
described in 'mptcp_token_destroy_request'
  net/mptcp/token.c:191: warning: Function parameter or member 'token' not =
described in 'mptcp_token_destroy'

This doesn't stop the build if KCFLAGS=3D'-Werror' is used but better to fi=
x them.

One of these warnings has been introduced in commits from the 'export' bran=
ch
but the rest is from two already published commits.

[1] https://github.com/multipath-tcp/mptcp_net-next/commit/2069cff66f186b0d=
4edf23af5ca02977d8806dc1

Matthieu Baerts (3):
  mptcp: fix "fn parameter not described" warning
  mptcp: fix "fn parameter not described" warnings
  mptcp: fix "fn parameter not described" warning

 net/mptcp/token.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

-- =

2.25.1

--===============3445819547518689488==--
