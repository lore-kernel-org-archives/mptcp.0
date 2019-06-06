Content-Type: multipart/mixed; boundary="===============7618766080743054879=="
MIME-Version: 1.0
From: Peter Krystad <peter.krystad at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH 7/7] mptcp: Refactor mptcp_established_options() to
 single hook
Date: Wed, 05 Jun 2019 17:36:32 -0700
Message-ID: <20190606003632.2863-8-peter.krystad@linux.intel.com>
In-Reply-To: 20190606003632.2863-1-peter.krystad@linux.intel.com
X-Status: 
X-Keywords:                  
X-UID: 1301

--===============7618766080743054879==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Make there only be one callout from tcp_output.c for this.
Includes refactoring from the first patch in the MP_JOIN RFC.

squash to: Write MPTCP DSS headers

Signed-off-by: Peter Krystad <peter.krystad(a)linux.intel.com>
---
 include/net/mptcp.h   | 21 ++++++---------------
 net/ipv4/tcp_output.c | 21 ++++++---------------
 net/mptcp/options.c   | 36 ++++++++++++++++++++++++++++++------
 3 files changed, 42 insertions(+), 36 deletions(-)

diff --git a/include/net/mptcp.h b/include/net/mptcp.h
index d84489adbd86..ec3d7f7e5f45 100644
--- a/include/net/mptcp.h
+++ b/include/net/mptcp.h
@@ -57,13 +57,11 @@ void mptcp_parse_option(const unsigned char *ptr, int o=
psize,
 bool mptcp_syn_options(struct sock *sk, unsigned int *size,
 			       struct mptcp_out_options* opts);
 void mptcp_rcv_synsent(struct sock *sk);
-bool mptcp_established_options_dss(struct sock *sk, struct sk_buff *skb,
-				   unsigned int *size, unsigned int remaining,
-				   struct mptcp_out_options* opts);
 bool mptcp_synack_options(const struct request_sock *req, unsigned int *si=
ze,
 			  struct mptcp_out_options *opts);
-bool mptcp_established_options(struct sock *sk, unsigned int *size,
-				       struct mptcp_out_options *opts);
+bool mptcp_established_options(struct sock *sk, struct sk_buff *skb,
+			       unsigned int *size, unsigned int remaining,
+			       struct mptcp_out_options* opts);
 =

 void mptcp_attach_dss(struct sock *sk, struct sk_buff *skb,
 		      struct tcp_options_received *opt_rx);
@@ -106,15 +104,6 @@ static inline void mptcp_rcv_synsent(struct sock *sk)
 {
 }
 =

-static inline bool mptcp_established_options_dss(struct sock *sk,
-						 struct sk_buff *skb,
-						 unsigned int *size,
-						 unsigned int remaining,
-						 struct mptcp_out_options* opts)
-{
-	return false;
-}
-
 static inline bool mptcp_synack_options(const struct request_sock *req,
 					unsigned int *size,
 					struct mptcp_out_options *opts)
@@ -123,8 +112,10 @@ static inline bool mptcp_synack_options(const struct r=
equest_sock *req,
 }
 =

 static inline bool mptcp_established_options(struct sock *sk,
+					     struct sk_buff *skb,
 					     unsigned int *size,
-					     struct mptcp_out_options *opts)
+					     unsigned int remaining,
+					     struct mptcp_out_options* opts);
 {
 	return false;
 }
diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
index 0b4865c55e4e..6ad88b70de6c 100644
--- a/net/ipv4/tcp_output.c
+++ b/net/ipv4/tcp_output.c
@@ -443,6 +443,7 @@ struct tcp_out_options {
 =

 static void mptcp_options_write(__be32 *ptr, struct tcp_out_options *opts)
 {
+	pr_debug("entered");
 #if IS_ENABLED(CONFIG_MPTCP)
 	if (unlikely(OPTION_MPTCP & opts->options))
 		mptcp_write_options(ptr, &opts->mptcp);
@@ -796,22 +797,12 @@ static unsigned int tcp_established_options(struct so=
ck *sk, struct sk_buff *skb
 	 */
 	if (sk_is_mptcp(sk)) {
 		unsigned int remaining =3D MAX_TCP_OPTION_SPACE - size;
-		unsigned int opt_size;
+		unsigned int opt_size =3D 0;
 =

-		if (mptcp_established_options(sk, &opt_size, &opts->mptcp)) {
-			if (remaining >=3D opt_size) {
-				opts->options |=3D OPTION_MPTCP;
-				size +=3D opt_size;
-			}
-		} else {
-			unsigned int dss_size;
-
-			if (mptcp_established_options_dss(sk, skb, &dss_size,
-							  remaining,
-							  &opts->mptcp)) {
-				opts->options |=3D OPTION_MPTCP;
-				size +=3D dss_size;
-			}
+		if (mptcp_established_options(sk, skb, &opt_size, remaining,
+					      &opts->mptcp)) {
+			opts->options |=3D OPTION_MPTCP;
+			size +=3D opt_size;
 		}
 	}
 =

diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index 98d582207cb0..f06ca0c48e57 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -249,12 +249,14 @@ void mptcp_rcv_synsent(struct sock *sk)
 	}
 }
 =

-bool mptcp_established_options(struct sock *sk, unsigned int *size,
-			       struct mptcp_out_options *opts)
+static bool mptcp_established_options_mp(struct sock *sk, unsigned int *si=
ze,
+					 unsigned int remaining,
+					 struct mptcp_out_options *opts)
 {
 	struct subflow_context *subflow =3D subflow_ctx(sk);
 =

-	if (subflow->mp_capable && !subflow->fourth_ack) {
+	if (subflow->mp_capable && !subflow->fourth_ack &&
+	    remaining >=3D TCPOLEN_MPTCP_MPC_ACK) {
 		opts->suboptions =3D OPTION_MPTCP_MPC_ACK;
 		opts->sndr_key =3D subflow->local_key;
 		opts->rcvr_key =3D subflow->remote_key;
@@ -267,9 +269,10 @@ bool mptcp_established_options(struct sock *sk, unsign=
ed int *size,
 	return false;
 }
 =

-bool mptcp_established_options_dss(struct sock *sk, struct sk_buff *skb,
-				   unsigned int *size, unsigned int remaining,
-				   struct mptcp_out_options *opts)
+static bool mptcp_established_options_dss(struct sock *sk, struct sk_buff =
*skb,
+					  unsigned int *size,
+					  unsigned int remaining,
+					  struct mptcp_out_options *opts)
 {
 	unsigned int dss_size =3D 0;
 	struct mptcp_ext *mpext;
@@ -338,6 +341,27 @@ bool mptcp_established_options_dss(struct sock *sk, st=
ruct sk_buff *skb,
 	return true;
 }
 =

+bool mptcp_established_options(struct sock *sk, struct sk_buff *skb,
+			       unsigned int *size, unsigned int remaining,
+			       struct mptcp_out_options *opts)
+{
+	unsigned int opt_size =3D 0;
+
+	if (mptcp_established_options_mp(sk, &opt_size, remaining, opts)) {
+		*size +=3D opt_size;
+		remaining -=3D opt_size;
+		return true;
+	}
+	else if (mptcp_established_options_dss(sk, skb, &opt_size, remaining,
+					       opts)) {
+		*size +=3D opt_size;
+		remaining -=3D opt_size;
+		return true;
+	}
+
+	return false;
+}
+
 bool mptcp_synack_options(const struct request_sock *req, unsigned int *si=
ze,
 			  struct mptcp_out_options *opts)
 {
-- =

2.17.2


--===============7618766080743054879==--
