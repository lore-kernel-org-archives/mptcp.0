Content-Type: multipart/mixed; boundary="===============2582958862180592399=="
MIME-Version: 1.0
From: Peter Krystad <peter.krystad at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH 3/3] Rename lookup_token() to __token_lookup
Date: Wed, 07 Aug 2019 16:44:26 -0700
Message-ID: <20190807234426.13691-4-peter.krystad@linux.intel.com>
In-Reply-To: 20190807234426.13691-1-peter.krystad@linux.intel.com
X-Status: 
X-Keywords:                  
X-UID: 1608

--===============2582958862180592399==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Naming better aligns with token_lookup_get().

squashto: Implement path manager interface commands

Signed-off-by: Peter Krystad <peter.krystad(a)linux.intel.com>
---
 net/mptcp/token.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/mptcp/token.c b/net/mptcp/token.c
index b5b233859c09..9bdd9b97724c 100644
--- a/net/mptcp/token.c
+++ b/net/mptcp/token.c
@@ -355,7 +355,7 @@ struct sock *token_lookup_get(u32 token)
 	struct sock *conn;
 =

 	spin_lock_bh(&token_tree_lock);
-	conn =3D lookup_token(token);
+	conn =3D __token_lookup(token);
 	if (conn)
 		sock_hold(conn);
 	spin_unlock_bh(&token_tree_lock);
-- =

2.17.2


--===============2582958862180592399==--
