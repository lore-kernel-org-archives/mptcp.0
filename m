Content-Type: multipart/mixed; boundary="===============1311982964187312899=="
MIME-Version: 1.0
From: Florian Westphal <fw at strlen.de>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH v2 4/6] mptcp: remove mptcp_read_actor
Date: Mon, 17 Feb 2020 16:00:59 +0100
Message-ID: <20200217150101.13603-5-fw@strlen.de>
In-Reply-To: 20200217150101.13603-1-fw@strlen.de
X-Status: 
X-Keywords:                  
X-UID: 3673

--===============1311982964187312899==
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
index df8a9dd84b6a..fe5504994fbd 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -616,33 +616,6 @@ static int mptcp_sendmsg(struct sock *sk, struct msghd=
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
index d676b7b6bbd3..c6f955f0fd0b 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -304,13 +304,6 @@ void mptcp_proto_init(void);
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
index c448a622e4c2..773f8dd422bb 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -577,6 +577,18 @@ static enum mapping_status get_mapping_status(struct s=
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
@@ -651,16 +663,12 @@ static bool subflow_check_data_avail(struct sock *ssk)
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

--===============1311982964187312899==--
