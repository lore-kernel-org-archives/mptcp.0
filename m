Content-Type: multipart/mixed; boundary="===============7261697090143967227=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH 1/3] mptcp: move some helper into the header file
Date: Tue, 15 Oct 2019 17:44:42 +0200
Message-ID: <b5e048bf96434a6fc40e05b07d509e33d31b423b.1571152990.git.pabeni@redhat.com>
In-Reply-To: cover.1571152990.git.pabeni@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 2153

--===============7261697090143967227==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

and add scope prefix, where needed. This is apreparatory work
to make the next patch smaller.

The split is very arbitrary, likely a different one will be needed
to simplify merging the patches.

Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>
---
 net/mptcp/protocol.c | 25 +++++--------------------
 net/mptcp/protocol.h | 21 +++++++++++++++++++++
 2 files changed, 26 insertions(+), 20 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 29e2d3c525c5..a69872baf038 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -387,10 +387,6 @@ static int mptcp_sendmsg(struct sock *sk, struct msghd=
r *msg, size_t len)
 	return ret;
 }
 =

-struct mptcp_read_arg {
-	struct msghdr *msg;
-};
-
 static u64 expand_seq(u64 old_seq, u16 old_data_len, u64 seq)
 {
 	if ((u32)seq =3D=3D (u32)old_seq)
@@ -400,19 +396,7 @@ static u64 expand_seq(u64 old_seq, u16 old_data_len, u=
64 seq)
 	return seq | ((old_seq + old_data_len + 1) & GENMASK_ULL(63, 32));
 }
 =

-static u64 get_map_offset(struct mptcp_subflow_context *subflow)
-{
-	return tcp_sk(mptcp_subflow_tcp_socket(subflow)->sk)->copied_seq -
-		      subflow->ssn_offset -
-		      subflow->map_subflow_seq;
-}
-
-static u64 get_mapped_dsn(struct mptcp_subflow_context *subflow)
-{
-	return subflow->map_seq + get_map_offset(subflow);
-}
-
-static int mptcp_read_actor(read_descriptor_t *desc, struct sk_buff *skb,
+int mptcp_read_actor(read_descriptor_t *desc, struct sk_buff *skb,
 			    unsigned int offset, size_t len)
 {
 	struct mptcp_read_arg *arg =3D desc->arg.data;
@@ -666,8 +650,9 @@ static int mptcp_recvmsg(struct sock *sk, struct msghdr=
 *msg, size_t len,
 			break;
 		}
 =

-		ack_seq =3D get_mapped_dsn(subflow);
-		map_remaining =3D subflow->map_data_len - get_map_offset(subflow);
+		ack_seq =3D mptcp_subflow_get_mapped_dsn(subflow);
+		map_remaining =3D subflow->map_data_len -
+				mptcp_subflow_get_map_offset(subflow);
 =

 		if (before64(ack_seq, old_ack)) {
 			/* Mapping covers data already received, discard data
@@ -689,7 +674,7 @@ static int mptcp_recvmsg(struct sock *sk, struct msghdr=
 *msg, size_t len,
 			break;
 =

 		/* Refresh current MPTCP sequence number based on subflow seq */
-		ack_seq =3D get_mapped_dsn(subflow);
+		ack_seq =3D mptcp_subflow_get_mapped_dsn(subflow);
 =

 		if (before64(old_ack, ack_seq))
 			msk->ack_seq =3D ack_seq;
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 991182578b22..d1978c27d557 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -245,6 +245,20 @@ mptcp_subflow_tcp_socket(const struct mptcp_subflow_co=
ntext *subflow)
 	return subflow->tcp_sock;
 }
 =

+static inline u64
+mptcp_subflow_get_map_offset(struct mptcp_subflow_context *subflow)
+{
+	return tcp_sk(mptcp_subflow_tcp_socket(subflow)->sk)->copied_seq -
+		      subflow->ssn_offset -
+		      subflow->map_subflow_seq;
+}
+
+static inline u64
+mptcp_subflow_get_mapped_dsn(struct mptcp_subflow_context *subflow)
+{
+	return subflow->map_seq + mptcp_subflow_get_map_offset(subflow);
+}
+
 int mptcp_is_enabled(struct net *net);
 =

 void mptcp_subflow_init(void);
@@ -256,6 +270,13 @@ extern const struct inet_connection_sock_af_ops ipv4_s=
pecific;
 =

 void mptcp_proto_init(void);
 =

+struct mptcp_read_arg {
+	struct msghdr *msg;
+};
+
+int mptcp_read_actor(read_descriptor_t *desc, struct sk_buff *skb,
+		     unsigned int offset, size_t len);
+
 void mptcp_get_options(const struct sk_buff *skb,
 		       struct tcp_options_received *opt_rx);
 =

-- =

2.21.0

--===============7261697090143967227==--
