Content-Type: multipart/mixed; boundary="===============3272410896652142594=="
MIME-Version: 1.0
From: Peter Krystad <peter.krystad at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [RFC 1/3] mptcp: Slightly refactor
 mptcp_established_options_xxx()
Date: Wed, 22 May 2019 14:38:23 -0700
Message-ID: <20190522213825.4057-2-peter.krystad@linux.intel.com>
In-Reply-To: 20190522213825.4057-1-peter.krystad@linux.intel.com
X-Status: 
X-Keywords:                  
X-UID: 1223

--===============3272410896652142594==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Make mptcp_established_options_xxx() take the same
parameter list and remove the restriction that MP_CAPABLE
and DSS options may not be sent in the same header.

Split and squash to "Handle MP_CAPABLE options" and
"Write MPTCP DSS headers".

Signed-off-by: Peter Krystad <peter.krystad(a)linux.intel.com>
---
 include/net/mptcp.h   |  7 +++++--
 net/ipv4/tcp_output.c | 26 +++++++++++++-------------
 net/mptcp/options.c   |  6 ++++--
 3 files changed, 22 insertions(+), 17 deletions(-)

diff --git a/include/net/mptcp.h b/include/net/mptcp.h
index ed67b140af33..0f66dab1c444 100644
--- a/include/net/mptcp.h
+++ b/include/net/mptcp.h
@@ -69,8 +69,9 @@ bool mptcp_established_options_dss(struct sock *sk, struc=
t sk_buff *skb,
 				   struct mptcp_out_options* opts);
 bool mptcp_synack_options(const struct request_sock *req, unsigned int *si=
ze,
 			  struct mptcp_out_options *opts);
-bool mptcp_established_options(struct sock *sk, unsigned int *size,
-				       struct mptcp_out_options *opts);
+bool mptcp_established_options(struct sock *sk, struct sk_buff *skb,
+			       unsigned int *size, unsigned int remaining,
+			       struct mptcp_out_options *opts);
 =

 void mptcp_attach_dss(struct sock *sk, struct sk_buff *skb,
 		      struct tcp_options_received *opt_rx);
@@ -126,7 +127,9 @@ static inline bool mptcp_synack_options(const struct re=
quest_sock *req,
 }
 =

 static inline bool mptcp_established_options(struct sock *sk,
+					     struct sk_buff *skb,
 					     unsigned int *size,
+					     unsigned int remaining,
 					     struct mptcp_out_options *opts)
 {
 	return false;
diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
index 1cd915890ce5..68a2311b56d4 100644
--- a/net/ipv4/tcp_output.c
+++ b/net/ipv4/tcp_output.c
@@ -797,20 +797,20 @@ static unsigned int tcp_established_options(struct so=
ck *sk, struct sk_buff *skb
 		unsigned int remaining =3D MAX_TCP_OPTION_SPACE - size;
 		unsigned int opt_size;
 =

-		if (mptcp_established_options(sk, &opt_size, &opts->mptcp)) {
-			if (remaining >=3D opt_size) {
-				opts->options |=3D OPTION_MPTCP;
-				size +=3D opt_size;
-			}
-		} else {
-			unsigned int dss_size;
+		if (mptcp_established_options(sk, skb, &opt_size,
+					      remaining, &opts->mptcp)) {
+			opts->options |=3D OPTION_MPTCP;
+			size +=3D opt_size;
+			remaining -=3D opt_size;
+		}
+
+		if (mptcp_established_options_dss(sk, skb, &opt_size,
+						  remaining, &opts->mptcp)) {
+			opts->options |=3D OPTION_MPTCP;
+			size +=3D opt_size;
+			remaining -=3D opt_size;
+		}
 =

-			if (mptcp_established_options_dss(sk, skb, &dss_size,
-							  remaining,
-							  &opts->mptcp)) {
-				opts->options |=3D OPTION_MPTCP;
-				size +=3D dss_size;
-			}
 		}
 	}
 =

diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index c71e40f6f06a..47d7507a2f2a 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -240,13 +240,15 @@ void mptcp_rcv_synsent(struct sock *sk)
 	}
 }
 =

-bool mptcp_established_options(struct sock *sk, unsigned int *size,
+bool mptcp_established_options(struct sock *sk, struct sk_buff *skb,
+			       unsigned int *size, unsigned int remaining,
 			       struct mptcp_out_options *opts)
 {
 	struct subflow_context *subflow =3D subflow_ctx(sk);
 =

 	pr_debug("subflow=3D%p", subflow);
-	if (subflow->mp_capable && !subflow->fourth_ack) {
+	if (subflow->mp_capable && !subflow->fourth_ack &&
+	    remaining >=3D TCPOLEN_MPTCP_MPC_ACK) {
 		opts->suboptions =3D OPTION_MPTCP_MPC_ACK;
 		opts->sndr_key =3D subflow->local_key;
 		opts->rcvr_key =3D subflow->remote_key;
-- =

2.17.2


--===============3272410896652142594==--
