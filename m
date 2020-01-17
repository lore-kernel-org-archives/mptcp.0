Content-Type: multipart/mixed; boundary="===============3969981951441541915=="
MIME-Version: 1.0
From: Peter Krystad <peter.krystad at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH] mptcp: Optimize ADD_ADDR fields in
 mptcp_options_received
Date: Thu, 16 Jan 2020 23:01:12 -0800
Message-ID: <20200117070112.5887-1-peter.krystad@linux.intel.com>
X-Status: 
X-Keywords:                  
X-UID: 3389

--===============3969981951441541915==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Use union to minimize space used in structure.

Allow IPv4 ADD_ADDR to be received in the same header as a MP_CAPABLE.
Remove unneeded family field. Ensure that mixed 32 and 64-bit ACKs and
sequence numbers can still be received.

squashto: Add ADD_ADDR handling

Signed-off-by: Peter Krystad <peter.krystad(a)linux.intel.com>
---
 include/linux/tcp.h | 34 +++++++++++++++++++++-------------
 net/mptcp/options.c | 18 ++++++++++--------
 2 files changed, 31 insertions(+), 21 deletions(-)

diff --git a/include/linux/tcp.h b/include/linux/tcp.h
index ec4dd8c01742..3d9cb3ae7228 100644
--- a/include/linux/tcp.h
+++ b/include/linux/tcp.h
@@ -84,19 +84,36 @@ struct mptcp_options_received {
 		struct {
 			u64	sndr_key;
 			u64	rcvr_key;
-			u32	data_ack32;
-			u32	data_seq32;
+			union {
+				struct {
+					u32	data_ack32;
+					u32	data_seq32;
+				};
+				struct {
+					struct in_addr	addr;
+					u8	addr_id;
+				};
+			};
 		};
 		struct {
 			u64	data_ack;
 			u64	data_seq;
 		};
+#if IS_ENABLED(CONFIG_MPTCP_IPV6)
+		struct {
+			struct in6_addr	addr6;
+			u8	addr6_id;
+		};
+#endif
 	};
 	u32	subflow_seq;
 	u16	data_len;
 	u8	mp_capable : 1,
 		mp_join : 1,
-		dss : 1;
+		dss : 1,
+		add_addr : 1,
+		add_addr6 : 1,
+		rm_addr : 1;
 	u8	use_map:1,
 		dsn64:1,
 		data_fin:1,
@@ -104,16 +121,6 @@ struct mptcp_options_received {
 		ack64:1,
 		mpc_map:1,
 		__unused:2;
-	u8	add_addr : 1,
-		rm_addr : 1,
-		family : 4;
-	u8	addr_id;
-	union {
-		struct	in_addr	addr;
-#if IS_ENABLED(CONFIG_IPV6)
-		struct	in6_addr addr6;
-#endif
-	};
 };
 #endif
 =

@@ -150,6 +157,7 @@ static inline void tcp_clear_options(struct tcp_options=
_received *rx_opt)
 	rx_opt->mptcp.mp_capable =3D 0;
 	rx_opt->mptcp.mp_join =3D 0;
 	rx_opt->mptcp.add_addr =3D 0;
+	rx_opt->mptcp.add_addr6 =3D 0;
 	rx_opt->mptcp.rm_addr =3D 0;
 	rx_opt->mptcp.dss =3D 0;
 #endif
diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index 819416bd601a..5712dddc9ec5 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -21,6 +21,7 @@ void mptcp_parse_option(const struct sk_buff *skb, const =
unsigned char *ptr,
 	u8 subtype =3D *ptr >> 4;
 	int expected_opsize;
 	u8 version;
+	u8 family;
 	u8 flags;
 =

 	switch (subtype) {
@@ -222,21 +223,21 @@ void mptcp_parse_option(const struct sk_buff *skb, co=
nst unsigned char *ptr,
 		if (opsize !=3D TCPOLEN_MPTCP_ADD_ADDR &&
 		    opsize !=3D TCPOLEN_MPTCP_ADD_ADDR6)
 			break;
-		mp_opt->family =3D *ptr++ & MPTCP_ADDR_FAMILY_MASK;
-		if (mp_opt->family !=3D MPTCP_ADDR_IPVERSION_4 &&
-		    mp_opt->family !=3D MPTCP_ADDR_IPVERSION_6)
+		family =3D *ptr++ & MPTCP_ADDR_FAMILY_MASK;
+		if (family !=3D MPTCP_ADDR_IPVERSION_4 &&
+		    family !=3D MPTCP_ADDR_IPVERSION_6)
 			break;
 =

-		if (mp_opt->family =3D=3D MPTCP_ADDR_IPVERSION_4 &&
+		if (family =3D=3D MPTCP_ADDR_IPVERSION_4 &&
 		    opsize !=3D TCPOLEN_MPTCP_ADD_ADDR)
 			break;
 #if IS_ENABLED(CONFIG_MPTCP_IPV6)
-		if (mp_opt->family =3D=3D MPTCP_ADDR_IPVERSION_6 &&
+		if (family =3D=3D MPTCP_ADDR_IPVERSION_6 &&
 		    opsize !=3D TCPOLEN_MPTCP_ADD_ADDR6)
 			break;
 #endif
-		mp_opt->addr_id =3D *ptr++;
-		if (mp_opt->family =3D=3D MPTCP_ADDR_IPVERSION_4) {
+		if (family =3D=3D MPTCP_ADDR_IPVERSION_4) {
+			mp_opt->addr_id =3D *ptr++;
 			mp_opt->add_addr =3D 1;
 			memcpy((u8 *)&mp_opt->addr.s_addr, (u8 *)ptr, 4);
 			pr_debug("ADD_ADDR: addr=3D%x, id=3D%d",
@@ -244,9 +245,10 @@ void mptcp_parse_option(const struct sk_buff *skb, con=
st unsigned char *ptr,
 		}
 #if IS_ENABLED(CONFIG_MPTCP_IPV6)
 		else {
+			mp_opt->addr6_id =3D *ptr++;
 			mp_opt->add_addr =3D 1;
 			memcpy(mp_opt->addr6.s6_addr, (u8 *)ptr, 16);
-			pr_debug("ADD_ADDR: addr6=3D, id=3D%d", mp_opt->addr_id);
+			pr_debug("ADD_ADDR: addr6=3D, id=3D%d", mp_opt->addr6_id);
 		}
 #endif
 		break;
-- =

2.17.2

--===============3969981951441541915==--
