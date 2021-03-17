Content-Type: multipart/mixed; boundary="===============1164761134509317786=="
MIME-Version: 1.0
From: Geliang Tang <geliangtang at gmail.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [MPTCP][PATCH v3 mptcp-next 4/7] mptcp: use mptcp_addr_info
 in mptcp_options_received
Date: Wed, 17 Mar 2021 15:36:19 +0800
Message-ID: <5b55310e5e6682adfc02b6cc47480eae20612b83.1615966219.git.geliangtang@gmail.com>
In-Reply-To: 666cf05ae98c7be040adeac64c10c0e348723ff6.1615966219.git.geliangtang@gmail.com
X-Status: 
X-Keywords:                  
X-UID: 8183

--===============1164761134509317786==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This patch added a new struct mptcp_addr_info member addr in struct
mptcp_options_received, and dropped the original family, addr_id, addr,
addr6 and port fields in it. Then we can pass the parameter mp_opt.addr
directly to mptcp_pm_add_addr_received and mptcp_pm_add_addr_echoed.

Since the port number became as a big-endian order now, use ntohs to
convert it before printing it out.

Signed-off-by: Geliang Tang <geliangtang(a)gmail.com>
---
 net/mptcp/options.c  | 58 +++++++++++++++++---------------------------
 net/mptcp/protocol.h | 10 +-------
 2 files changed, 23 insertions(+), 45 deletions(-)

diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index 5b8103668e9a..0bc5eb0f835c 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -220,45 +220,45 @@ static void mptcp_parse_option(const struct sk_buff *=
skb,
 		if (!mp_opt->echo) {
 			if (opsize =3D=3D TCPOLEN_MPTCP_ADD_ADDR ||
 			    opsize =3D=3D TCPOLEN_MPTCP_ADD_ADDR_PORT)
-				mp_opt->family =3D MPTCP_ADDR_IPVERSION_4;
+				mp_opt->addr.family =3D MPTCP_ADDR_IPVERSION_4;
 #if IS_ENABLED(CONFIG_MPTCP_IPV6)
 			else if (opsize =3D=3D TCPOLEN_MPTCP_ADD_ADDR6 ||
 				 opsize =3D=3D TCPOLEN_MPTCP_ADD_ADDR6_PORT)
-				mp_opt->family =3D MPTCP_ADDR_IPVERSION_6;
+				mp_opt->addr.family =3D MPTCP_ADDR_IPVERSION_6;
 #endif
 			else
 				break;
 		} else {
 			if (opsize =3D=3D TCPOLEN_MPTCP_ADD_ADDR_BASE ||
 			    opsize =3D=3D TCPOLEN_MPTCP_ADD_ADDR_BASE_PORT)
-				mp_opt->family =3D MPTCP_ADDR_IPVERSION_4;
+				mp_opt->addr.family =3D MPTCP_ADDR_IPVERSION_4;
 #if IS_ENABLED(CONFIG_MPTCP_IPV6)
 			else if (opsize =3D=3D TCPOLEN_MPTCP_ADD_ADDR6_BASE ||
 				 opsize =3D=3D TCPOLEN_MPTCP_ADD_ADDR6_BASE_PORT)
-				mp_opt->family =3D MPTCP_ADDR_IPVERSION_6;
+				mp_opt->addr.family =3D MPTCP_ADDR_IPVERSION_6;
 #endif
 			else
 				break;
 		}
 =

 		mp_opt->add_addr =3D 1;
-		mp_opt->addr_id =3D *ptr++;
-		if (mp_opt->family =3D=3D MPTCP_ADDR_IPVERSION_4) {
-			memcpy((u8 *)&mp_opt->addr.s_addr, (u8 *)ptr, 4);
+		mp_opt->addr.id =3D *ptr++;
+		if (mp_opt->addr.family =3D=3D MPTCP_ADDR_IPVERSION_4) {
+			memcpy((u8 *)&mp_opt->addr.addr.s_addr, (u8 *)ptr, 4);
 			ptr +=3D 4;
 			if (opsize =3D=3D TCPOLEN_MPTCP_ADD_ADDR_PORT ||
 			    opsize =3D=3D TCPOLEN_MPTCP_ADD_ADDR_BASE_PORT) {
-				mp_opt->port =3D get_unaligned_be16(ptr);
+				mp_opt->addr.port =3D get_unaligned_be16(ptr);
 				ptr +=3D 2;
 			}
 		}
 #if IS_ENABLED(CONFIG_MPTCP_IPV6)
 		else {
-			memcpy(mp_opt->addr6.s6_addr, (u8 *)ptr, 16);
+			memcpy(mp_opt->addr.addr6.s6_addr, (u8 *)ptr, 16);
 			ptr +=3D 16;
 			if (opsize =3D=3D TCPOLEN_MPTCP_ADD_ADDR6_PORT ||
 			    opsize =3D=3D TCPOLEN_MPTCP_ADD_ADDR6_BASE_PORT) {
-				mp_opt->port =3D get_unaligned_be16(ptr);
+				mp_opt->addr.port =3D get_unaligned_be16(ptr);
 				ptr +=3D 2;
 			}
 		}
@@ -268,8 +268,8 @@ static void mptcp_parse_option(const struct sk_buff *sk=
b,
 			ptr +=3D 8;
 		}
 		pr_debug("ADD_ADDR%s: id=3D%d, ahmac=3D%llu, echo=3D%d, port=3D%d",
-			 (mp_opt->family =3D=3D MPTCP_ADDR_IPVERSION_6) ? "6" : "",
-			 mp_opt->addr_id, mp_opt->ahmac, mp_opt->echo, mp_opt->port);
+			 (mp_opt->addr.family =3D=3D MPTCP_ADDR_IPVERSION_6) ? "6" : "",
+			 mp_opt->addr.id, mp_opt->ahmac, mp_opt->echo, ntohs(mp_opt->addr.port)=
);
 		break;
 =

 	case MPTCPOPT_RM_ADDR:
@@ -335,7 +335,7 @@ void mptcp_get_options(const struct sk_buff *skb,
 	mp_opt->add_addr =3D 0;
 	mp_opt->ahmac =3D 0;
 	mp_opt->fastclose =3D 0;
-	mp_opt->port =3D 0;
+	mp_opt->addr.port =3D 0;
 	mp_opt->rm_addr =3D 0;
 	mp_opt->dss =3D 0;
 	mp_opt->mp_prio =3D 0;
@@ -991,17 +991,17 @@ static bool add_addr_hmac_valid(struct mptcp_sock *ms=
k,
 	if (mp_opt->echo)
 		return true;
 =

-	if (mp_opt->family =3D=3D MPTCP_ADDR_IPVERSION_4)
+	if (mp_opt->addr.family =3D=3D MPTCP_ADDR_IPVERSION_4)
 		hmac =3D add_addr_generate_hmac(msk->remote_key,
 					      msk->local_key,
-					      mp_opt->addr_id, &mp_opt->addr,
-					      mp_opt->port);
+					      mp_opt->addr.id, &mp_opt->addr.addr,
+					      mp_opt->addr.port);
 #if IS_ENABLED(CONFIG_MPTCP_IPV6)
 	else
 		hmac =3D add_addr6_generate_hmac(msk->remote_key,
 					       msk->local_key,
-					       mp_opt->addr_id, &mp_opt->addr6,
-					       mp_opt->port);
+					       mp_opt->addr.id, &mp_opt->addr.addr6,
+					       mp_opt->addr.port);
 #endif
 =

 	pr_debug("msk=3D%p, ahmac=3D%llu, mp_opt->ahmac=3D%llu\n",
@@ -1043,30 +1043,16 @@ void mptcp_incoming_options(struct sock *sk, struct=
 sk_buff *skb)
 	}
 =

 	if (mp_opt.add_addr && add_addr_hmac_valid(msk, &mp_opt)) {
-		struct mptcp_addr_info addr;
-
-		addr.port =3D htons(mp_opt.port);
-		addr.id =3D mp_opt.addr_id;
-		if (mp_opt.family =3D=3D MPTCP_ADDR_IPVERSION_4) {
-			addr.family =3D AF_INET;
-			addr.addr =3D mp_opt.addr;
-		}
-#if IS_ENABLED(CONFIG_MPTCP_IPV6)
-		else if (mp_opt.family =3D=3D MPTCP_ADDR_IPVERSION_6) {
-			addr.family =3D AF_INET6;
-			addr.addr6 =3D mp_opt.addr6;
-		}
-#endif
 		if (!mp_opt.echo) {
-			mptcp_pm_add_addr_received(msk, &addr);
+			mptcp_pm_add_addr_received(msk, &mp_opt.addr);
 			MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_ADDADDR);
 		} else {
-			mptcp_pm_add_addr_echoed(msk, &addr);
-			mptcp_pm_del_add_timer(msk, &addr);
+			mptcp_pm_add_addr_echoed(msk, &mp_opt.addr);
+			mptcp_pm_del_add_timer(msk, &mp_opt.addr);
 			MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_ECHOADD);
 		}
 =

-		if (mp_opt.port)
+		if (mp_opt.addr.port)
 			MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_PORTADD);
 =

 		mp_opt.add_addr =3D 0;
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index f004fcbfec11..7a2686ca7a0d 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -133,7 +133,6 @@ struct mptcp_options_received {
 		add_addr : 1,
 		rm_addr : 1,
 		mp_prio : 1,
-		family : 4,
 		echo : 1,
 		backup : 1;
 	u32	token;
@@ -148,16 +147,9 @@ struct mptcp_options_received {
 		ack64:1,
 		mpc_map:1,
 		__unused:2;
-	u8	addr_id;
+	struct mptcp_addr_info addr;
 	struct mptcp_rm_list rm_list;
-	union {
-		struct in_addr	addr;
-#if IS_ENABLED(CONFIG_MPTCP_IPV6)
-		struct in6_addr	addr6;
-#endif
-	};
 	u64	ahmac;
-	u16	port;
 	u8	reset_reason:4;
 	u8	reset_transient:1;
 };
-- =

2.30.2

--===============1164761134509317786==--
