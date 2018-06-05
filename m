Content-Type: multipart/mixed; boundary="===============0330711575193127935=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [RFC PATCH v2 17/19] mptcp: Rework handling of the MPTCP
 sub-options
Date: Tue, 05 Jun 2018 16:40:36 -0700
Message-ID: <20180605234038.28497-18-mathew.j.martineau@linux.intel.com>
In-Reply-To: 20180605234038.28497-1-mathew.j.martineau@linux.intel.com
X-Status: 
X-Keywords:                  
X-UID: 660

--===============0330711575193127935==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Peter Krystad <peter.krystad(a)intel.com>

Signed-off-by: Peter Krystad <peter.krystad(a)intel.com>
---
 net/ipv4/tcp_output.c | 230 +++++++++++++++++++++++-------------------
 1 file changed, 124 insertions(+), 106 deletions(-)

diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
index 5e1e724b92b6..524233f25c35 100644
--- a/net/ipv4/tcp_output.c
+++ b/net/ipv4/tcp_output.c
@@ -413,9 +413,116 @@ static inline bool tcp_urg_mode(const struct tcp_sock=
 *tp)
 #define OPTION_FAST_OPEN_COOKIE	(1 << 8)
 #define OPTION_SMC		(1 << 9)
 #define OPTION_MPTCP		(1 << 10)
-#define OPTION_MPTCP_ACK	(1 << 11)
-#define OPTION_MPTCP_DSS_MAP	(1 << 12)
-#define OPTION_MPTCP_DSS_ACK	(1 << 13)
+
+/* MPTCP option subtypes */
+#define OPTION_MPTCP_MPC_SYN	(1 << 0)
+#define OPTION_MPTCP_MPC_SYNACK	(1 << 1)
+#define OPTION_MPTCP_MPC_ACK	(1 << 2)
+#define OPTION_MPTCP_DSS_ACK	(1 << 7)
+#define OPTION_MPTCP_DSS_MAP	(1 << 8)
+
+struct tcp_out_options {
+	u16 options;		/* bit field of OPTION_* */
+	u16 mss;		/* 0 to disable */
+	u8 ws;			/* window scale, 0 to disable */
+	u8 num_sack_blocks;	/* number of SACK blocks to include */
+	u8 hash_size;		/* bytes in hash_location */
+	__u8 *hash_location;	/* temporary pointer, overloaded */
+	__u32 tsval, tsecr;	/* need to include OPTION_TS */
+	struct tcp_fastopen_cookie *fastopen_cookie;	/* Fast open cookie */
+	u16 suboptions;         /* MPTCP sub-options */
+	u64 sndr_key;
+	u64 rcvr_key;
+};
+
+static void mptcp_options_write(__be32 *ptr, struct sk_buff *skb, struct t=
cp_out_options *opts)
+{
+	if (!(OPTION_MPTCP & opts->options))
+		return;
+
+	if ((OPTION_MPTCP_MPC_SYN |
+	     OPTION_MPTCP_MPC_SYNACK |
+	     OPTION_MPTCP_MPC_ACK) & opts->suboptions) {
+		u8 len;
+		u8 *p =3D (u8 *)ptr;
+
+		if (OPTION_MPTCP_MPC_SYN & opts->suboptions)
+			len =3D TCPOLEN_MPTCP_MPC_SYN;
+		else
+			len =3D TCPOLEN_MPTCP_MPC_SYNACK;
+
+		*p++ =3D 0x1e; // TCP option: Multipath TCP
+		*p++ =3D len;  // length
+		*p++ =3D 0;    // subtype=3DMP_CAPABLE | version=3D0
+		*p++ =3D 0x1;  // flags=3DHMAC-SHA1
+		memcpy(p, &opts->sndr_key, 8);
+		if (OPTION_MPTCP_MPC_SYNACK & opts->suboptions) {
+			p +=3D 8;
+			memcpy(p, &opts->rcvr_key, 8);
+		}
+	}
+
+	if ((OPTION_MPTCP_DSS_MAP |
+	     OPTION_MPTCP_DSS_ACK) & opts->suboptions) {
+		struct mptcp_skb_ext_cb *ecb =3D mptcp_skb_ecb(skb);
+		bool write_ack =3D (OPTION_MPTCP_DSS_ACK & opts->suboptions) && ecb->use=
_ack;
+		bool write_map =3D (OPTION_MPTCP_DSS_MAP & opts->suboptions) && ecb->use=
_map;
+		u8 flags =3D 0;
+		u8 len =3D 4;
+		u8 *p =3D (u8 *)ptr;
+
+		BUG_ON(!skb_shinfo(skb)->is_ext);
+		BUG_ON(!write_ack && !write_map);
+
+		if (write_ack) {
+			len +=3D 8;
+			flags =3D 0x03;
+		}
+
+		if (write_map) {
+			len +=3D 14;
+
+			if (ecb->use_checksum)
+				len +=3D 2;
+
+			/* Use only 64-bit mapping flags for now, add
+			 * support for optional 32-bit mappings later.
+			 */
+			flags |=3D 0x0c;
+			if (ecb->data_fin)
+				flags |=3D 0x10;
+		}
+
+		*p++ =3D 0x1e; // TCP option: Multipath TCP
+		*p++ =3D len;  // length
+		*p++ =3D 0x20; // subtype=3DDSS
+		*p++ =3D flags;
+
+		if (write_ack) {
+			*(__be64 *)p =3D cpu_to_be64(ecb->data_ack);
+			p +=3D 8;
+		}
+
+		if (write_map) {
+			*(__be64 *)p =3D cpu_to_be64(ecb->data_seq);
+			p +=3D 8;
+
+			*(__be32 *)p =3D htonl(ecb->subflow_seq);
+			p +=3D 4;
+
+			*(__be16 *)p =3D htons(ecb->data_level_len);
+			p +=3D 2;
+
+			if (ecb->use_checksum) {
+				*(__be16 *)p =3D htons(ecb->checksum);
+				p +=3D 2;
+			} else {
+				*p++ =3D TCPOPT_NOP;
+				*p++ =3D TCPOPT_NOP;
+			}
+		}
+	}
+}
 =

 static void smc_options_write(__be32 *ptr, u16 *options)
 {
@@ -432,19 +539,6 @@ static void smc_options_write(__be32 *ptr, u16 *option=
s)
 #endif
 }
 =

-struct tcp_out_options {
-	u16 options;		/* bit field of OPTION_* */
-	u16 mss;		/* 0 to disable */
-	u8 ws;			/* window scale, 0 to disable */
-	u8 num_sack_blocks;	/* number of SACK blocks to include */
-	u8 hash_size;		/* bytes in hash_location */
-	__u8 *hash_location;	/* temporary pointer, overloaded */
-	__u32 tsval, tsecr;	/* need to include OPTION_TS */
-	struct tcp_fastopen_cookie *fastopen_cookie;	/* Fast open cookie */
-	u64 sndr_key;
-	u64 rcvr_key;
-};
-
 /* Write previously computed TCP options to the packet.
  *
  * Beware: Something in the Internet is very sensitive to the ordering of
@@ -554,88 +648,7 @@ static void tcp_options_write(__be32 *ptr, struct sk_b=
uff *skb,
 =

 	smc_options_write(ptr, &options);
 =

-	if (OPTION_MPTCP & options) {
-		u8 *p =3D (u8 *)ptr;
-		*p++ =3D 0x1e; // TCP option: Multipath TCP
-		*p++ =3D 12;   // length
-		*p++ =3D 0;    // subtype=3DMP_CAPABLE | version=3D0
-		*p++ =3D 0x1;  // flags=3DHMAC-SHA1
-		memcpy(p, &opts->sndr_key, 8);
-		pr_debug("tcp_options_write: opts->sndr_key=3D%llu", opts->sndr_key);
-	}
-
-	if (OPTION_MPTCP_ACK & options) {
-		u8 *p =3D (u8 *)ptr;
-		*p++ =3D 0x1e; // TCP option: Multipath TCP
-		*p++ =3D 20;   // length
-		*p++ =3D 0;    // subtype=3DMP_CAPABLE | version=3D0
-		*p++ =3D 0x1;  // flags=3DHMAC-SHA1
-		memcpy(p, &opts->sndr_key, 8);
-		pr_debug("tcp_options_write: opts->sndr_key=3D%llu", opts->sndr_key);
-		p +=3D 8;
-		memcpy(p, &opts->rcvr_key, 8);
-		pr_debug("tcp_options_write: opts->rcvr_key=3D%llu", opts->rcvr_key);
-	}
-
-	if ((OPTION_MPTCP_DSS_MAP | OPTION_MPTCP_DSS_ACK) & options) {
-		struct mptcp_skb_ext_cb *ecb =3D mptcp_skb_ecb(skb);
-		bool write_ack =3D (OPTION_MPTCP_DSS_ACK & options) && ecb->use_ack;
-		bool write_map =3D (OPTION_MPTCP_DSS_MAP & options) && ecb->use_map;
-		u8 flags =3D 0;
-		u8 len =3D 4;
-		u8 *p =3D (u8 *)ptr;
-
-		BUG_ON(!skb_shinfo(skb)->is_ext);
-		BUG_ON(!write_ack && !write_map);
-
-		if (write_ack) {
-			len +=3D 8;
-			flags =3D 0x03;
-		}
-
-		if (write_map) {
-			len +=3D 14;
-
-			if (ecb->use_checksum)
-				len +=3D 2;
-
-			/* Use only 64-bit mapping flags for now, add
-			 * support for optional 32-bit mappings later.
-			 */
-			flags |=3D 0x0c;
-			if (ecb->data_fin)
-				flags |=3D 0x10;
-		}
-
-		*p++ =3D 0x1e; // TCP option: Multipath TCP
-		*p++ =3D len;  // length
-		*p++ =3D 0x20; // subtype=3DDSS
-		*p++ =3D flags;
-
-		if (write_ack) {
-			*(__be64 *)p =3D cpu_to_be64(ecb->data_ack);
-			p +=3D 8;
-		}
-
-		if (write_map) {
-			*(__be64 *)p =3D cpu_to_be64(ecb->data_seq);
-			p +=3D 8;
-
-			*(__be32 *)p =3D htonl(ecb->subflow_seq);
-			p +=3D 4;
-
-			*(__be16 *)p =3D htons(ecb->data_level_len);
-			p +=3D 2;
-
-			if (ecb->use_checksum) {
-				*(__be16 *)p =3D htons(ecb->checksum);
-				p +=3D 2;
-			} else {
-				*p++ =3D TCPOPT_NOP;
-				*p++ =3D TCPOPT_NOP;
-			}
-		}
-	}
+	mptcp_options_write(ptr, skb, opts);
 }
 =

 static void smc_set_option(const struct tcp_sock *tp,
@@ -743,6 +756,7 @@ static unsigned int tcp_syn_options(struct sock *sk, st=
ruct sk_buff *skb,
 		u64 local_key;
 		if (mptcp_syn_options(sk, &local_key)) {
 			opts->options |=3D OPTION_MPTCP;
+			opts->suboptions |=3D OPTION_MPTCP_MPC_SYN;
 			opts->sndr_key =3D local_key;
 			remaining -=3D TCPOLEN_MPTCP_MPC_SYN;
 		}
@@ -813,7 +827,8 @@ static unsigned int tcp_synack_options(const struct soc=
k *sk,
 		u64 remote_key;
 		if (mptcp_synack_options(req, &local_key, &remote_key)) {
 			if (remaining >=3D TCPOLEN_MPTCP_MPC_SYNACK) {
-				opts->options |=3D OPTION_MPTCP_ACK;
+				opts->options |=3D OPTION_MPTCP;
+				opts->suboptions |=3D OPTION_MPTCP_MPC_SYNACK;
 				opts->sndr_key =3D local_key;
 				opts->rcvr_key =3D remote_key;
 				remaining -=3D TCPOLEN_MPTCP_MPC_SYNACK;
@@ -859,14 +874,17 @@ static unsigned int tcp_established_options(struct so=
ck *sk, struct sk_buff *skb
 =

 	if (tp->is_mptcp) {
 		struct subflow_sock *subflow =3D subflow_sk(sk);
+
 		pr_debug("tcp_established_options: subflow=3D%p", subflow);
+		opts->suboptions =3D 0;
 		if (subflow->mp_capable) {
 			unsigned int remaining =3D MAX_TCP_OPTION_SPACE - size;
 			pr_debug("tcp_established_options: remaining=3D%d", remaining);
 			if (!subflow->fourth_ack) {
-				pr_debug("tcp_established_options: OPTION_MPTCP_ACK");
+				pr_debug("tcp_established_options: OPTION_MPTCP_MPC_ACK");
 				if (remaining >=3D 20) {
-					opts->options |=3D OPTION_MPTCP_ACK;
+					opts->options |=3D OPTION_MPTCP;
+					opts->suboptions |=3D OPTION_MPTCP_MPC_ACK;
 					opts->sndr_key =3D subflow->local_key;
 					opts->rcvr_key =3D subflow->remote_key;
 					size +=3D 20;
@@ -876,7 +894,7 @@ static unsigned int tcp_established_options(struct sock=
 *sk, struct sk_buff *skb
 			} else if (skb && skb_shinfo(skb)->is_ext) {
 				struct mptcp_skb_ext_cb *ecb;
 				unsigned int dss_size =3D 0;
-				u16 options =3D 0;
+				u16 suboptions =3D 0;
 =

 				ecb =3D mptcp_skb_ecb(skb);
 =

@@ -889,7 +907,7 @@ static unsigned int tcp_established_options(struct sock=
 *sk, struct sk_buff *skb
 					if (map_size <=3D remaining) {
 						remaining -=3D map_size;
 						dss_size =3D map_size;
-						options =3D OPTION_MPTCP_DSS_MAP;
+						suboptions =3D OPTION_MPTCP_DSS_MAP;
 					} else {
 						WARN(1, "MPTCP: Map dropped");
 					}
@@ -906,7 +924,7 @@ static unsigned int tcp_established_options(struct sock=
 *sk, struct sk_buff *skb
 =

 					if (ack_size <=3D remaining) {
 						dss_size +=3D ack_size;
-						options |=3D OPTION_MPTCP_DSS_ACK;
+						suboptions |=3D OPTION_MPTCP_DSS_ACK;
 					} else {
 						WARN(1, "MPTCP: Ack dropped");
 					}
@@ -914,8 +932,8 @@ static unsigned int tcp_established_options(struct sock=
 *sk, struct sk_buff *skb
 =

 				if (dss_size) {
 					size +=3D ALIGN(dss_size, 4);
-					opts->options |=3D options;
-					pr_debug("dss_size=3D%u size=3D%u", dss_size, size);
+					opts->options |=3D OPTION_MPTCP;
+					opts->suboptions =3D suboptions;
 				}
 			}
 		}
-- =

2.17.1


--===============0330711575193127935==--
