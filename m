Content-Type: multipart/mixed; boundary="===============2423023911439757704=="
MIME-Version: 1.0
From: Florian Westphal <fw at strlen.de>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH 1/9] token: handle join-before-accept-completion case
Date: Sat, 30 Nov 2019 23:48:52 +0100
Message-ID: <20191130224900.8694-2-fw@strlen.de>
In-Reply-To: 20191130224900.8694-1-fw@strlen.de
X-Status: 
X-Keywords:                  
X-UID: 2714

--===============2423023911439757704==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

squashto: mptcp: Add handling of incoming MP_JOIN requests

If we get a join request while the socket hasn't been accepted yet,
the tree still contains the dummy reserved value.  Return NULL in
this case, the token is still invalid.

Only alternative would be to serialize such request into a work queue
to replay it at a future data when the address might have become
available.

Signed-off-by: Florian Westphal <fw(a)strlen.de>
---
 net/mptcp/token.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/net/mptcp/token.c b/net/mptcp/token.c
index 56f1bd2641f6..15cd71a33205 100644
--- a/net/mptcp/token.c
+++ b/net/mptcp/token.c
@@ -182,8 +182,13 @@ struct mptcp_sock *mptcp_token_get_sock(u32 token)
 =

 	spin_lock_bh(&token_tree_lock);
 	conn =3D radix_tree_lookup(&token_tree, token);
-	if (conn)
-		sock_hold(conn);
+	if (conn) {
+		/* token still reserved? */
+		if (conn =3D=3D (struct sock *)&token_used)
+			conn =3D NULL;
+		else
+			sock_hold(conn);
+	}
 	spin_unlock_bh(&token_tree_lock);
 =

 	return mptcp_sk(conn);
-- =

2.23.0

--===============2423023911439757704==--
