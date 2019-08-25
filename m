Content-Type: multipart/mixed; boundary="===============8034700780504660023=="
MIME-Version: 1.0
From: Florian Westphal <fw at strlen.de>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH RFC 01/10] mptcp: token: remove token_init
Date: Sun, 25 Aug 2019 20:59:30 +0200
Message-ID: <20190825185939.21596-2-fw@strlen.de>
In-Reply-To: 20190825185939.21596-1-fw@strlen.de
X-Status: 
X-Keywords:                  
X-UID: 1698

--===============8034700780504660023==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Its not needed, just use the static initialisers.

Signed-off-by: Florian Westphal <fw(a)strlen.de>
---
 net/mptcp/protocol.c |  1 -
 net/mptcp/protocol.h |  1 -
 net/mptcp/token.c    | 15 ++++-----------
 3 files changed, 4 insertions(+), 13 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 7c12920bed48..847e5c3133ba 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1146,7 +1146,6 @@ void mptcp_proto_init(void)
 	mptcp_stream_ops.listen =3D mptcp_listen;
 	mptcp_stream_ops.shutdown =3D mptcp_shutdown;
 =

-	token_init();
 	subflow_init();
 	pm_init();
 =

diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 68877e952780..e97ac14115a2 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -225,7 +225,6 @@ void mptcp_get_options(const struct sk_buff *skb,
 void mptcp_finish_connect(struct sock *sk, int mp_capable);
 void mptcp_finish_join(struct sock *sk);
 =

-void token_init(void);
 void token_new_request(struct request_sock *req, const struct sk_buff *skb=
);
 int token_join_request(struct request_sock *req, const struct sk_buff *skb=
);
 int token_join_response(struct sock *sk);
diff --git a/net/mptcp/token.c b/net/mptcp/token.c
index 506665da8b2d..10d0c2341792 100644
--- a/net/mptcp/token.c
+++ b/net/mptcp/token.c
@@ -31,10 +31,10 @@
 #include <net/mptcp.h>
 #include "protocol.h"
 =

-static struct radix_tree_root token_tree;
-static struct radix_tree_root token_req_tree;
-static spinlock_t token_tree_lock;
-static int token_used;
+static RADIX_TREE(token_tree, GFP_ATOMIC);
+static RADIX_TREE(token_req_tree, GFP_ATOMIC);
+static DEFINE_SPINLOCK(token_tree_lock);
+static int token_used __read_mostly;
 =

 static bool find_req_token(u32 token)
 {
@@ -392,10 +392,3 @@ void token_destroy(u32 token)
 		sock_put(conn);
 	spin_unlock_bh(&token_tree_lock);
 }
-
-void token_init(void)
-{
-	INIT_RADIX_TREE(&token_tree, GFP_ATOMIC);
-	INIT_RADIX_TREE(&token_req_tree, GFP_ATOMIC);
-	spin_lock_init(&token_tree_lock);
-}
-- =

2.21.0


--===============8034700780504660023==--
