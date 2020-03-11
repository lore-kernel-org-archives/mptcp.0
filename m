Content-Type: multipart/mixed; boundary="===============7925568133256972567=="
MIME-Version: 1.0
From: Peter Krystad <peter.krystad at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH v4 2/5] mptcp: v1 ADD_ADDR changes: options and parsing
Date: Wed, 11 Mar 2020 10:25:57 -0700
Message-ID: <20200311172600.4185-3-peter.krystad@linux.intel.com>
In-Reply-To: 20200311172600.4185-1-peter.krystad@linux.intel.com
X-Status: 
X-Keywords:                  
X-UID: 3920

--===============7925568133256972567==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Remove family field and add hmac and echo fields to struct
mptcp_options_received. Parse incoming hmac on ADD_ADDR option,
and send hmac with outgoing option.

squashto: Add ADD_ADDR handling

Signed-off-by: Peter Krystad <peter.krystad(a)linux.intel.com>
---
 include/linux/tcp.h  |  19 ++++---
 include/net/mptcp.h  |   2 +
 net/mptcp/options.c  | 132 +++++++++++++++++++++++++++++++++----------
 net/mptcp/protocol.h |  16 ++++--
 4 files changed, 128 insertions(+), 41 deletions(-)

diff --git a/include/linux/tcp.h b/include/linux/tcp.h
index 1e733f9fb4ab..2fa145aae5ae 100644
--- a/include/linux/tcp.h
+++ b/include/linux/tcp.h
@@ -86,9 +86,13 @@ struct mptcp_options_received {
 	u64	data_seq;
 	u32	subflow_seq;
 	u16	data_len;
-	u8	mp_capable : 1,
+	u16	mp_capable : 1,
 		mp_join : 1,
-		dss : 1;
+		dss : 1,
+		add_addr : 1,
+		rm_addr : 1,
+		family : 4,
+		echo : 1;
 	u8	use_map:1,
 		dsn64:1,
 		data_fin:1,
@@ -96,16 +100,15 @@ struct mptcp_options_received {
 		ack64:1,
 		mpc_map:1,
 		__unused:2;
-	u8	add_addr : 1,
-		rm_addr : 1,
-		family : 4;
 	u8	addr_id;
 	union {
-		struct	in_addr	addr;
-#if IS_ENABLED(CONFIG_IPV6)
-		struct	in6_addr addr6;
+		struct in_addr	addr;
+#if IS_ENABLED(CONFIG_MPTCP_IPV6)
+		struct in6_addr	addr6;
 #endif
 	};
+	u64	ahmac;
+	u8	rm_id;
 };
 #endif
 =

diff --git a/include/net/mptcp.h b/include/net/mptcp.h
index 2d7e478f0380..0d5ea71dd3d0 100644
--- a/include/net/mptcp.h
+++ b/include/net/mptcp.h
@@ -40,6 +40,8 @@ struct mptcp_out_options {
 #endif
 	};
 	u8 addr_id;
+	u64 ahmac;
+	u8 rm_id;
 	struct mptcp_ext ext_copy;
 #endif
 };
diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index 00aa3c8db85e..15139a51d0e3 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -179,45 +179,56 @@ void mptcp_parse_option(const struct sk_buff *skb, co=
nst unsigned char *ptr,
 		break;
 =

 	case MPTCPOPT_ADD_ADDR:
-		if (opsize !=3D TCPOLEN_MPTCP_ADD_ADDR &&
-		    opsize !=3D TCPOLEN_MPTCP_ADD_ADDR6)
-			break;
-		mp_opt->family =3D *ptr++ & MPTCP_ADDR_FAMILY_MASK;
-		if (mp_opt->family !=3D MPTCP_ADDR_IPVERSION_4 &&
-		    mp_opt->family !=3D MPTCP_ADDR_IPVERSION_6)
-			break;
-
-		if (mp_opt->family =3D=3D MPTCP_ADDR_IPVERSION_4 &&
-		    opsize !=3D TCPOLEN_MPTCP_ADD_ADDR)
-			break;
+		mp_opt->echo =3D (*ptr++) & MPTCP_ADDR_ECHO;
+		if (!mp_opt->echo) {
+			if (opsize =3D=3D TCPOLEN_MPTCP_ADD_ADDR ||
+			    opsize =3D=3D TCPOLEN_MPTCP_ADD_ADDR_PORT)
+				mp_opt->family =3D MPTCP_ADDR_IPVERSION_4;
 #if IS_ENABLED(CONFIG_MPTCP_IPV6)
-		if (mp_opt->family =3D=3D MPTCP_ADDR_IPVERSION_6 &&
-		    opsize !=3D TCPOLEN_MPTCP_ADD_ADDR6)
-			break;
+			else if (opsize =3D=3D TCPOLEN_MPTCP_ADD_ADDR6 ||
+				 opsize =3D=3D TCPOLEN_MPTCP_ADD_ADDR6_PORT)
+				mp_opt->family =3D MPTCP_ADDR_IPVERSION_6;
+#endif
+			else
+				break;
+		} else {
+			if (opsize =3D=3D TCPOLEN_MPTCP_ADD_ADDR_BASE ||
+			    opsize =3D=3D TCPOLEN_MPTCP_ADD_ADDR_BASE_PORT)
+				mp_opt->family =3D MPTCP_ADDR_IPVERSION_4;
+#if IS_ENABLED(CONFIG_MPTCP_IPV6)
+			else if (opsize =3D=3D TCPOLEN_MPTCP_ADD_ADDR6_BASE ||
+				 opsize =3D=3D TCPOLEN_MPTCP_ADD_ADDR6_BASE_PORT)
+				mp_opt->family =3D MPTCP_ADDR_IPVERSION_6;
 #endif
+			else
+				break;
+		}
+
 		mp_opt->addr_id =3D *ptr++;
+		pr_debug("ADD_ADDR: id=3D%d", mp_opt->addr_id);
 		if (mp_opt->family =3D=3D MPTCP_ADDR_IPVERSION_4) {
-			mp_opt->add_addr =3D 1;
 			memcpy((u8 *)&mp_opt->addr.s_addr, (u8 *)ptr, 4);
-			pr_debug("ADD_ADDR: addr=3D%x, id=3D%d",
-				 mp_opt->addr.s_addr, mp_opt->addr_id);
+			ptr +=3D 4;
 		}
 #if IS_ENABLED(CONFIG_MPTCP_IPV6)
 		else {
-			mp_opt->add_addr =3D 1;
 			memcpy(mp_opt->addr6.s6_addr, (u8 *)ptr, 16);
-			pr_debug("ADD_ADDR: addr6=3D, id=3D%d", mp_opt->addr_id);
+			ptr +=3D 16;
 		}
 #endif
+		if (!mp_opt->echo) {
+			mp_opt->ahmac =3D get_unaligned_be64(ptr);
+			ptr +=3D 8;
+		}
 		break;
 =

 	case MPTCPOPT_RM_ADDR:
-		if (opsize !=3D TCPOLEN_MPTCP_RM_ADDR)
+		if (opsize !=3D TCPOLEN_MPTCP_RM_ADDR_BASE)
 			break;
 =

 		mp_opt->rm_addr =3D 1;
-		mp_opt->addr_id =3D *ptr++;
-		pr_debug("RM_ADDR: id=3D%d", mp_opt->addr_id);
+		mp_opt->rm_id =3D *ptr++;
+		pr_debug("RM_ADDR: id=3D%d", mp_opt->rm_id);
 		break;
 =

 	default:
@@ -425,6 +436,38 @@ static bool mptcp_established_options_dss(struct sock =
*sk, struct sk_buff *skb,
 	return true;
 }
 =

+static u64 add_addr_generate_hmac(u64 key1, u64 key2, u8 addr_id,
+				  struct in_addr *addr)
+{
+	u8 hmac[MPTCP_ADDR_HMAC_LEN];
+	u8 msg[7];
+
+	msg[0] =3D addr_id;
+	memcpy(&msg[1], &addr->s_addr, 4);
+	msg[5] =3D 0;
+	msg[6] =3D 0;
+
+	mptcp_crypto_hmac_sha(key1, key2, msg, 7, hmac);
+
+	return get_unaligned_be64(hmac);
+}
+
+static u64 add_addr6_generate_hmac(u64 key1, u64 key2, u8 addr_id,
+				   struct in6_addr *addr)
+{
+	u8 hmac[MPTCP_ADDR_HMAC_LEN];
+	u8 msg[19];
+
+	msg[0] =3D addr_id;
+	memcpy(&msg[1], &addr->s6_addr, 16);
+	msg[17] =3D 0;
+	msg[18] =3D 0;
+
+	mptcp_crypto_hmac_sha(key1, key2, msg, 19, hmac);
+
+	return get_unaligned_be64(hmac);
+}
+
 static bool mptcp_established_options_addr(struct sock *sk,
 					   unsigned int *size,
 					   unsigned int remaining,
@@ -447,6 +490,10 @@ static bool mptcp_established_options_addr(struct sock=
 *sk,
 		opts->suboptions |=3D OPTION_MPTCP_ADD_ADDR;
 		opts->addr_id =3D id;
 		opts->addr =3D ((struct sockaddr_in *)&saddr)->sin_addr;
+		opts->ahmac =3D add_addr_generate_hmac(subflow->local_key,
+						     subflow->remote_key,
+						     opts->addr_id,
+						     &opts->addr);
 		*size =3D TCPOLEN_MPTCP_ADD_ADDR;
 	}
 #if IS_ENABLED(CONFIG_MPTCP_IPV6)
@@ -455,10 +502,15 @@ static bool mptcp_established_options_addr(struct soc=
k *sk,
 			return false;
 		opts->suboptions |=3D OPTION_MPTCP_ADD_ADDR6;
 		opts->addr_id =3D id;
+		opts->ahmac =3D add_addr6_generate_hmac(subflow->local_key,
+						      subflow->remote_key,
+						      opts->addr_id,
+						      &opts->addr6);
 		opts->addr6 =3D ((struct sockaddr_in6 *)&saddr)->sin6_addr;
 		*size =3D TCPOLEN_MPTCP_ADD_ADDR6;
 	}
 #endif
+	pr_debug("addr_id=3D%d, ahmac=3D%llu", opts->addr_id, opts->ahmac);
 =

 	return true;
 }
@@ -630,25 +682,47 @@ void mptcp_write_options(__be32 *ptr, struct mptcp_ou=
t_options *opts)
 =

 mp_capable_done:
 	if (OPTION_MPTCP_ADD_ADDR & opts->suboptions) {
-		*ptr++ =3D mptcp_option(MPTCPOPT_ADD_ADDR, TCPOLEN_MPTCP_ADD_ADDR,
-				      MPTCP_ADDR_IPVERSION_4, opts->addr_id);
+		if (opts->ahmac)
+			*ptr++ =3D mptcp_option(MPTCPOPT_ADD_ADDR,
+					      TCPOLEN_MPTCP_ADD_ADDR, 0,
+					      opts->addr_id);
+		else
+			*ptr++ =3D mptcp_option(MPTCPOPT_ADD_ADDR,
+					      TCPOLEN_MPTCP_ADD_ADDR_BASE,
+					      MPTCP_ADDR_ECHO,
+					      opts->addr_id);
 		memcpy((u8 *)ptr, (u8 *)&opts->addr.s_addr, 4);
 		ptr +=3D 1;
+		if (opts->ahmac) {
+			put_unaligned_be64(opts->ahmac, ptr);
+			ptr +=3D 2;
+		}
 	}
 =

 #if IS_ENABLED(CONFIG_MPTCP_IPV6)
 	if (OPTION_MPTCP_ADD_ADDR6 & opts->suboptions) {
-		*ptr++ =3D mptcp_option(MPTCPOPT_ADD_ADDR,
-				      TCPOLEN_MPTCP_ADD_ADDR6,
-				      MPTCP_ADDR_IPVERSION_6, opts->addr_id);
+		if (opts->ahmac)
+			*ptr++ =3D mptcp_option(MPTCPOPT_ADD_ADDR,
+					      TCPOLEN_MPTCP_ADD_ADDR6, 0,
+					      opts->addr_id);
+		else
+			*ptr++ =3D mptcp_option(MPTCPOPT_ADD_ADDR,
+					      TCPOLEN_MPTCP_ADD_ADDR6_BASE,
+					      MPTCP_ADDR_ECHO,
+					      opts->addr_id);
 		memcpy((u8 *)ptr, opts->addr6.s6_addr, 16);
 		ptr +=3D 4;
+		if (opts->ahmac) {
+			put_unaligned_be64(opts->ahmac, ptr);
+			ptr +=3D 2;
+		}
 	}
 #endif
 =

 	if (OPTION_MPTCP_RM_ADDR & opts->suboptions) {
-		*ptr++ =3D mptcp_option(MPTCPOPT_RM_ADDR, TCPOLEN_MPTCP_RM_ADDR,
-				      0, opts->addr_id);
+		*ptr++ =3D mptcp_option(MPTCPOPT_RM_ADDR,
+				      TCPOLEN_MPTCP_RM_ADDR_BASE,
+				      0, opts->rm_id);
 	}
 =

 	if (opts->ext_copy.use_ack || opts->ext_copy.use_map) {
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 39b36fe1c337..63136193c5b7 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -42,9 +42,16 @@
 #define TCPOLEN_MPTCP_DSS_MAP32		10
 #define TCPOLEN_MPTCP_DSS_MAP64		14
 #define TCPOLEN_MPTCP_DSS_CHECKSUM	2
-#define TCPOLEN_MPTCP_ADD_ADDR		8
-#define TCPOLEN_MPTCP_ADD_ADDR6		20
-#define TCPOLEN_MPTCP_RM_ADDR		4
+#define TCPOLEN_MPTCP_ADD_ADDR		16
+#define TCPOLEN_MPTCP_ADD_ADDR_PORT	18
+#define TCPOLEN_MPTCP_ADD_ADDR_BASE	8
+#define TCPOLEN_MPTCP_ADD_ADDR_BASE_PORT	10
+#define TCPOLEN_MPTCP_ADD_ADDR6		28
+#define TCPOLEN_MPTCP_ADD_ADDR6_PORT	30
+#define TCPOLEN_MPTCP_ADD_ADDR6_BASE	20
+#define TCPOLEN_MPTCP_ADD_ADDR6_BASE_PORT	22
+#define TCPOLEN_MPTCP_PORT_LEN		2
+#define TCPOLEN_MPTCP_RM_ADDR_BASE	4
 =

 /* MPTCP MP_CAPABLE flags */
 #define MPTCP_VERSION_MASK	(0x0F)
@@ -62,7 +69,8 @@
 #define MPTCP_DSS_FLAG_MASK	(0x1F)
 =

 /* MPTCP ADD_ADDR flags */
-#define MPTCP_ADDR_FAMILY_MASK	(0x0F)
+#define MPTCP_ADDR_ECHO		BIT(0)
+#define MPTCP_ADDR_HMAC_LEN	20
 #define MPTCP_ADDR_IPVERSION_4	4
 #define MPTCP_ADDR_IPVERSION_6	6
 =

-- =

2.17.2

--===============7925568133256972567==--
