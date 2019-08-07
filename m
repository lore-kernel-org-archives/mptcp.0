Content-Type: multipart/mixed; boundary="===============7520194654637515412=="
MIME-Version: 1.0
From: Peter Krystad <peter.krystad at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH 2/3] Rename lookup_token() to __token_lookup
Date: Wed, 07 Aug 2019 16:44:25 -0700
Message-ID: <20190807234426.13691-3-peter.krystad@linux.intel.com>
In-Reply-To: 20190807234426.13691-1-peter.krystad@linux.intel.com
X-Status: 
X-Keywords:                  
X-UID: 1607

--===============7520194654637515412==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Naming better aligns with token_lookup_get().

squashto: Add handling of outgoing MP_JOIN requests

Signed-off-by: Peter Krystad <peter.krystad(a)linux.intel.com>
---
 net/mptcp/token.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/mptcp/token.c b/net/mptcp/token.c
index df7a35aa580e..b5b233859c09 100644
--- a/net/mptcp/token.c
+++ b/net/mptcp/token.c
@@ -300,7 +300,7 @@ void token_new_subflow(struct sock *sk)
 	pr_debug("subflow=3D%p", subflow);
 =

 	spin_lock_bh(&token_tree_lock);
-	conn =3D lookup_token(subflow->token);
+	conn =3D __token_lookup(subflow->token);
 	if (conn)
 		sock_hold(conn);
 	spin_unlock_bh(&token_tree_lock);
-- =

2.17.2


--===============7520194654637515412==--
