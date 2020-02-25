Content-Type: multipart/mixed; boundary="===============2883364173071349815=="
MIME-Version: 1.0
From: Florian Westphal <fw at strlen.de>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH net-next v2 5/7] mptcp: remove mptcp_read_actor
Date: Tue, 25 Feb 2020 18:16:57 +0100
Message-ID: <20200225171659.4807-6-fw@strlen.de>
In-Reply-To: 20200225171659.4807-1-fw@strlen.de
X-Status: 
X-Keywords:                  
X-UID: 3797

--===============2883364173071349815==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Only used to discard stale data from the subflow, so move
it where needed.

Signed-off-by: Florian Westphal <fw(a)strlen.de>
---
 net/mptcp/protocol.c | 27 ---------------------------
 net/mptcp/protocol.h |  7 -------
 net/mptcp/subflow.c  | 18 +++++++++++++-----
 3 files changed, 13 insertions(+), 39 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 381d5647a95b..b781498e69b4 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -430,33 +430,6 @@ static int mptcp_sendmsg(struct sock *sk, struct msghd=
r *msg, size_t len)
 	return ret;
 }
 =

-int mptcp_read_actor(read_descriptor_t *desc, struct sk_buff *skb,
-		     unsigned int offset, size_t len)
-{
-	struct mptcp_read_arg *arg =3D desc->arg.data;
-	size_t copy_len;
-
-	copy_len =3D min(desc->count, len);
-
-	if (likely(arg->msg)) {
-		int err;
-
-		err =3D skb_copy_datagram_msg(skb, offset, arg->msg, copy_len);
-		if (err) {
-			pr_debug("error path");
-			desc->error =3D err;
-			return err;
-		}
-	} else {
-		pr_debug("Flushing skb payload");
-	}
-
-	desc->count -=3D copy_len;
-
-	pr_debug("consumed %zu bytes, %zu left", copy_len, desc->count);
-	return copy_len;
-}
-
 static void mptcp_wait_data(struct sock *sk, long *timeo)
 {
 	DEFINE_WAIT_FUNC(wait, woken_wake_function);
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 6e6e162d25f1..d06170c5f191 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -191,13 +191,6 @@ void mptcp_proto_init(void);
 int mptcp_proto_v6_init(void);
 #endif
 =

-struct mptcp_read_arg {
-	struct msghdr *msg;
-};
-
-int mptcp_read_actor(read_descriptor_t *desc, struct sk_buff *skb,
-		     unsigned int offset, size_t len);
-
 void mptcp_get_options(const struct sk_buff *skb,
 		       struct tcp_options_received *opt_rx);
 =

diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index 3dad662840aa..37a4767db441 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -408,6 +408,18 @@ static enum mapping_status get_mapping_status(struct s=
ock *ssk)
 	return MAPPING_OK;
 }
 =

+static int subflow_read_actor(read_descriptor_t *desc,
+			      struct sk_buff *skb,
+			      unsigned int offset, size_t len)
+{
+	size_t copy_len =3D min(desc->count, len);
+
+	desc->count -=3D copy_len;
+
+	pr_debug("flushed %zu bytes, %zu left", copy_len, desc->count);
+	return copy_len;
+}
+
 static bool subflow_check_data_avail(struct sock *ssk)
 {
 	struct mptcp_subflow_context *subflow =3D mptcp_subflow_ctx(ssk);
@@ -482,16 +494,12 @@ static bool subflow_check_data_avail(struct sock *ssk)
 		pr_debug("discarding %zu bytes, current map len=3D%d", delta,
 			 map_remaining);
 		if (delta) {
-			struct mptcp_read_arg arg =3D {
-				.msg =3D NULL,
-			};
 			read_descriptor_t desc =3D {
 				.count =3D delta,
-				.arg.data =3D &arg,
 			};
 			int ret;
 =

-			ret =3D tcp_read_sock(ssk, &desc, mptcp_read_actor);
+			ret =3D tcp_read_sock(ssk, &desc, subflow_read_actor);
 			if (ret < 0) {
 				ssk->sk_err =3D -ret;
 				goto fatal;
-- =

2.24.1

--===============2883364173071349815==--
