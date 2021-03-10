Content-Type: multipart/mixed; boundary="===============0164691570607115577=="
MIME-Version: 1.0
From: Geliang Tang <geliangtang at gmail.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [MPTCP][RFC PATCH 1/2] mptcp: DSS checksum support
Date: Wed, 10 Mar 2021 20:39:33 +0800
Message-ID: <cc7e44b081dc7b02f9b7b9d14175acad361ea18e.1615378283.git.geliangtang@gmail.com>
In-Reply-To: cover.1615378283.git.geliangtang@gmail.com
X-Status: 
X-Keywords:                  
X-UID: 8089

--===============0164691570607115577==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Add DSS checksum support.

Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/134

Signed-off-by: Geliang Tang <geliangtang(a)gmail.com>
---
 include/net/mptcp.h  |  1 +
 net/mptcp/options.c  | 61 ++++++++++++++++++++++++++++++++++++++------
 net/mptcp/protocol.h |  8 ++++++
 net/mptcp/subflow.c  | 38 ++++++++++++++++++++++++++-
 4 files changed, 99 insertions(+), 9 deletions(-)

diff --git a/include/net/mptcp.h b/include/net/mptcp.h
index 16fe34d139c3..de88f38e60b1 100644
--- a/include/net/mptcp.h
+++ b/include/net/mptcp.h
@@ -32,6 +32,7 @@ struct mptcp_ext {
 			frozen:1,
 			reset_transient:1;
 	u8		reset_reason:4;
+	u16		csum;
 };
 =

 #define MPTCP_RM_IDS_MAX	8
diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index bf1b8497e091..9df26291cf9a 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -69,11 +69,9 @@ static void mptcp_parse_option(const struct sk_buff *skb,
 		 * "If a checksum is not present when its use has been
 		 * negotiated, the receiver MUST close the subflow with a RST as
 		 * it is considered broken."
-		 *
-		 * We don't implement DSS checksum - fall back to TCP.
 		 */
 		if (flags & MPTCP_CAP_CHECKSUM_REQD)
-			break;
+			;
 =

 		mp_opt->mp_capable =3D 1;
 		if (opsize >=3D TCPOLEN_MPTCP_MPC_SYNACK) {
@@ -208,9 +206,14 @@ static void mptcp_parse_option(const struct sk_buff *s=
kb,
 			mp_opt->data_len =3D get_unaligned_be16(ptr);
 			ptr +=3D 2;
 =

-			pr_debug("data_seq=3D%llu subflow_seq=3D%u data_len=3D%u",
+			if (opsize =3D=3D expected_opsize + TCPOLEN_MPTCP_DSS_CHECKSUM) {
+				mp_opt->csum =3D get_unaligned_be16(ptr);
+				ptr +=3D 2;
+			}
+
+			pr_debug("%s data_seq=3D%llu subflow_seq=3D%u data_len=3D%u csum=3D%u",=
 __func__,
 				 mp_opt->data_seq, mp_opt->subflow_seq,
-				 mp_opt->data_len);
+				 mp_opt->data_len, mp_opt->csum);
 		}
 =

 		break;
@@ -340,6 +343,7 @@ void mptcp_get_options(const struct sk_buff *skb,
 	mp_opt->dss =3D 0;
 	mp_opt->mp_prio =3D 0;
 	mp_opt->reset =3D 0;
+	mp_opt->csum =3D 0;
 =

 	length =3D (th->doff * 4) - sizeof(struct tcphdr);
 	ptr =3D (const unsigned char *)(th + 1);
@@ -520,6 +524,34 @@ static void mptcp_write_data_fin(struct mptcp_subflow_=
context *subflow,
 	}
 }
 =

+static u16 mptcp_generate_dss_csum(struct sk_buff *skb)
+{
+	struct mptcp_ext *mpext;
+
+	if (!skb)
+		return 0;
+
+	mpext =3D mptcp_get_ext(skb);
+	if (mpext && mpext->use_map) {
+		struct csum_pseudo_header header;
+		__wsum csum;
+
+		header.data_seq =3D mpext->data_seq;
+		header.subflow_seq =3D mpext->subflow_seq;
+		header.data_len =3D mpext->data_len;
+		header.csum =3D 0;
+
+		csum =3D skb_checksum(skb, 0, skb->len, 0);
+		csum =3D csum_partial(&header, sizeof(header), csum);
+
+		pr_debug("%s data_seq=3D%llu subflow_seq=3D%u data_len=3D%u csum=3D%u\n",
+			 __func__, header.data_seq, header.subflow_seq, header.data_len, csum_f=
old(csum));
+		return csum_fold(csum);
+	}
+
+	return 0;
+}
+
 static bool mptcp_established_options_dss(struct sock *sk, struct sk_buff =
*skb,
 					  bool snd_data_fin_enable,
 					  unsigned int *size,
@@ -543,8 +575,10 @@ static bool mptcp_established_options_dss(struct sock =
*sk, struct sk_buff *skb,
 =

 		remaining -=3D map_size;
 		dss_size =3D map_size;
-		if (mpext)
+		if (mpext) {
+			mpext->csum =3D mptcp_generate_dss_csum(skb);
 			opts->ext_copy =3D *mpext;
+		}
 =

 		if (skb && snd_data_fin_enable)
 			mptcp_write_data_fin(subflow, skb, &opts->ext_copy);
@@ -1141,6 +1175,9 @@ void mptcp_incoming_options(struct sock *sk, struct s=
k_buff *skb)
 		}
 		mpext->data_len =3D mp_opt.data_len;
 		mpext->use_map =3D 1;
+
+		if (!subflow->mpc_map)
+			mpext->csum =3D mp_opt.csum;
 	}
 }
 =

@@ -1349,6 +1386,9 @@ void mptcp_write_options(__be32 *ptr, const struct tc=
p_sock *tp,
 			flags |=3D MPTCP_DSS_HAS_MAP | MPTCP_DSS_DSN64;
 			if (mpext->data_fin)
 				flags |=3D MPTCP_DSS_DATA_FIN;
+
+			if (mpext->csum)
+				len +=3D TCPOLEN_MPTCP_DSS_CHECKSUM;
 		}
 =

 		*ptr++ =3D mptcp_option(MPTCPOPT_DSS, len, 0, flags);
@@ -1368,8 +1408,13 @@ void mptcp_write_options(__be32 *ptr, const struct t=
cp_sock *tp,
 			ptr +=3D 2;
 			put_unaligned_be32(mpext->subflow_seq, ptr);
 			ptr +=3D 1;
-			put_unaligned_be32(mpext->data_len << 16 |
-					   TCPOPT_NOP << 8 | TCPOPT_NOP, ptr);
+			if (mpext->csum) {
+				put_unaligned_be32(mpext->data_len << 16 |
+						   mpext->csum, ptr);
+			} else {
+				put_unaligned_be32(mpext->data_len << 16 |
+						   TCPOPT_NOP << 8 | TCPOPT_NOP, ptr);
+			}
 		}
 	}
 =

diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index f9dcf49ffe33..24b4e1f6d23f 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -126,6 +126,7 @@ struct mptcp_options_received {
 	u64	data_seq;
 	u32	subflow_seq;
 	u16	data_len;
+	u16	csum;
 	u16	mp_capable : 1,
 		mp_join : 1,
 		fastclose : 1,
@@ -356,6 +357,13 @@ static inline struct mptcp_data_frag *mptcp_rtx_head(c=
onst struct sock *sk)
 	return list_first_entry_or_null(&msk->rtx_queue, struct mptcp_data_frag, =
list);
 }
 =

+struct csum_pseudo_header {
+	u64 data_seq;
+	u32 subflow_seq;
+	u16 data_len;
+	u16 csum;
+};
+
 struct mptcp_subflow_request_sock {
 	struct	tcp_request_sock sk;
 	u16	mp_capable : 1,
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index bedbae99df2c..b597811a2f8d 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -796,6 +796,42 @@ static bool skb_is_fully_mapped(struct sock *ssk, stru=
ct sk_buff *skb)
 					  mptcp_subflow_get_map_offset(subflow);
 }
 =

+static bool validate_dss_csum(struct sock *ssk, struct sk_buff *skb)
+{
+	struct mptcp_subflow_context *subflow =3D mptcp_subflow_ctx(ssk);
+	struct csum_pseudo_header header;
+	struct mptcp_ext *mpext;
+	__wsum csum;
+
+	if (subflow->mpc_map)
+		goto out;
+	if (!skb)
+		goto out;
+
+	mpext =3D mptcp_get_ext(skb);
+	if (mpext && mpext->use_map && mpext->csum) {
+		header.data_seq =3D subflow->map_seq;
+		header.subflow_seq =3D subflow->map_subflow_seq;
+		header.data_len =3D subflow->map_data_len;
+		header.csum =3D mpext->csum;
+
+		csum =3D skb_checksum(skb, 0, skb->len, 0);
+		csum =3D csum_partial(&header, sizeof(header), csum);
+
+		pr_debug("%s data_seq=3D%llu subflow_seq=3D%u data_len=3D%u csum=3D%u",
+			 __func__, header.data_seq, header.subflow_seq, header.data_len, header=
.csum);
+
+		if (csum_fold(csum)) {
+			pr_err("%s DSS checksum error csum=3D%u!", __func__, csum_fold(csum));
+			return true; //false;
+		}
+		pr_debug("%s DSS checksum done", __func__);
+	}
+
+out:
+	return true;
+}
+
 static bool validate_mapping(struct sock *ssk, struct sk_buff *skb)
 {
 	struct mptcp_subflow_context *subflow =3D mptcp_subflow_ctx(ssk);
@@ -814,7 +850,7 @@ static bool validate_mapping(struct sock *ssk, struct s=
k_buff *skb)
 		warn_bad_map(subflow, ssn + skb->len);
 		return false;
 	}
-	return true;
+	return validate_dss_csum(ssk, skb);
 }
 =

 static enum mapping_status get_mapping_status(struct sock *ssk,
-- =

2.29.2

--===============0164691570607115577==--
