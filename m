Content-Type: multipart/mixed; boundary="===============4998906121325341583=="
MIME-Version: 1.0
From: Christoph Paasch <cpaasch at apple.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH net-next] mptcp: Use 32-bit DATA_ACK when possible
Date: Thu, 14 May 2020 08:53:03 -0700
Message-ID: <20200514155303.14360-1-cpaasch@apple.com>
X-Status: 
X-Keywords:                  
X-UID: 4384

--===============4998906121325341583==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

RFC8684 allows to send 32-bit DATA_ACKs as long as the peer is not
sending 64-bit data-sequence numbers. The 64-bit DSN is only there for
extreme scenarios when a very high throughput subflow is combined with a
long-RTT subflow such that the high-throughput subflow wraps around the
32-bit sequence number space within an RTT of the high-RTT subflow.

It is thus a rare scenario and we should try to use the 32-bit DATA_ACK
instead as long as possible. It allows to reduce the TCP-option overhead
by 4 bytes, thus makes space for an additional SACK-block. It also makes
tcpdumps much easier to read when the DSN and DATA_ACK are both either
32 or 64-bit.

Signed-off-by: Christoph Paasch <cpaasch(a)apple.com>
---
 include/net/mptcp.h  |  5 ++++-
 net/mptcp/options.c  | 33 ++++++++++++++++++++++++---------
 net/mptcp/protocol.h |  1 +
 net/mptcp/subflow.c  |  2 ++
 4 files changed, 31 insertions(+), 10 deletions(-)

diff --git a/include/net/mptcp.h b/include/net/mptcp.h
index e60275659de6..339eb36cf508 100644
--- a/include/net/mptcp.h
+++ b/include/net/mptcp.h
@@ -16,7 +16,10 @@ struct seq_file;
 =

 /* MPTCP sk_buff extension data */
 struct mptcp_ext {
-	u64		data_ack;
+	union {
+		u64	data_ack;
+		u32	data_ack32;
+	};
 	u64		data_seq;
 	u32		subflow_seq;
 	u16		data_len;
diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index 45497af23906..ece6f92cf7d1 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -516,7 +516,16 @@ static bool mptcp_established_options_dss(struct sock =
*sk, struct sk_buff *skb,
 		return ret;
 	}
 =

-	ack_size =3D TCPOLEN_MPTCP_DSS_ACK64;
+	if (subflow->use_64bit_ack) {
+		ack_size =3D TCPOLEN_MPTCP_DSS_ACK64;
+		opts->ext_copy.data_ack =3D msk->ack_seq;
+		opts->ext_copy.ack64 =3D 1;
+	} else {
+		ack_size =3D TCPOLEN_MPTCP_DSS_ACK32;
+		opts->ext_copy.data_ack32 =3D (uint32_t)(msk->ack_seq);
+		opts->ext_copy.ack64 =3D 0;
+	}
+	opts->ext_copy.use_ack =3D 1;
 =

 	/* Add kind/length/subtype/flag overhead if mapping is not populated */
 	if (dss_size =3D=3D 0)
@@ -524,10 +533,6 @@ static bool mptcp_established_options_dss(struct sock =
*sk, struct sk_buff *skb,
 =

 	dss_size +=3D ack_size;
 =

-	opts->ext_copy.data_ack =3D msk->ack_seq;
-	opts->ext_copy.ack64 =3D 1;
-	opts->ext_copy.use_ack =3D 1;
-
 	*size =3D ALIGN(dss_size, 4);
 	return true;
 }
@@ -986,8 +991,13 @@ void mptcp_write_options(__be32 *ptr, struct mptcp_out=
_options *opts)
 		u8 flags =3D 0;
 =

 		if (mpext->use_ack) {
-			len +=3D TCPOLEN_MPTCP_DSS_ACK64;
-			flags =3D MPTCP_DSS_HAS_ACK | MPTCP_DSS_ACK64;
+			flags =3D MPTCP_DSS_HAS_ACK;
+			if (mpext->ack64) {
+				len +=3D TCPOLEN_MPTCP_DSS_ACK64;
+				flags |=3D MPTCP_DSS_ACK64;
+			} else {
+				len +=3D TCPOLEN_MPTCP_DSS_ACK32;
+			}
 		}
 =

 		if (mpext->use_map) {
@@ -1004,8 +1014,13 @@ void mptcp_write_options(__be32 *ptr, struct mptcp_o=
ut_options *opts)
 		*ptr++ =3D mptcp_option(MPTCPOPT_DSS, len, 0, flags);
 =

 		if (mpext->use_ack) {
-			put_unaligned_be64(mpext->data_ack, ptr);
-			ptr +=3D 2;
+			if (mpext->ack64) {
+				put_unaligned_be64(mpext->data_ack, ptr);
+				ptr +=3D 2;
+			} else {
+				put_unaligned_be32(mpext->data_ack32, ptr);
+				ptr +=3D 1;
+			}
 		}
 =

 		if (mpext->use_map) {
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index e4ca6320ce76..f5adca93e8fb 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -290,6 +290,7 @@ struct mptcp_subflow_context {
 		data_avail : 1,
 		rx_eof : 1,
 		data_fin_tx_enable : 1,
+		use_64bit_ack : 1, /* Set when we received a 64-bit DSN */
 		can_ack : 1;	    /* only after processing the remote a key */
 	u64	data_fin_tx_seq;
 	u32	remote_nonce;
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index 009d5c478062..f22dad482cd4 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -661,9 +661,11 @@ static enum mapping_status get_mapping_status(struct s=
ock *ssk)
 	if (!mpext->dsn64) {
 		map_seq =3D expand_seq(subflow->map_seq, subflow->map_data_len,
 				     mpext->data_seq);
+		subflow->use_64bit_ack =3D 0;
 		pr_debug("expanded seq=3D%llu", subflow->map_seq);
 	} else {
 		map_seq =3D mpext->data_seq;
+		subflow->use_64bit_ack =3D 1;
 	}
 =

 	if (subflow->map_valid) {
-- =

2.23.0

--===============4998906121325341583==--
