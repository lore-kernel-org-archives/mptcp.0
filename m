Content-Type: multipart/mixed; boundary="===============1617448242188160257=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH 3/3] mptcp: fix "fn parameter not described" warning
Date: Tue, 24 Mar 2020 17:57:09 +0100
Message-ID: <20200324165709.2024557-4-matthieu.baerts@tessares.net>
In-Reply-To: 20200324165709.2024557-1-matthieu.baerts@tessares.net
X-Status: 
X-Keywords:                  
X-UID: 4058

--===============1617448242188160257==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Obtained with:

  $ make W=3D1 net/mptcp/token.o
  net/mptcp/token.c:133: warning: Function parameter or member 'conn' not d=
escribed in 'mptcp_token_new_accept'

Fixes: 58b09919626b (mptcp: create msk early)
Signed-off-by: Matthieu Baerts <matthieu.baerts(a)tessares.net>
---
 net/mptcp/token.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/mptcp/token.c b/net/mptcp/token.c
index ed7dc73c80eb..33352dd99d4d 100644
--- a/net/mptcp/token.c
+++ b/net/mptcp/token.c
@@ -125,6 +125,7 @@ int mptcp_token_new_connect(struct sock *sk)
 /**
  * mptcp_token_new_accept - insert token for later processing
  * @token: the token to insert to the tree
+ * @conn: the just cloned socket linked to the new connection
  *
  * Called when a SYN packet creates a new logical connection, i.e.
  * is not a join request.
-- =

2.25.1

--===============1617448242188160257==--
