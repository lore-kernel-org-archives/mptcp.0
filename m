Content-Type: multipart/mixed; boundary="===============4310310006274133111=="
MIME-Version: 1.0
From: Geliang Tang <geliangtang at gmail.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [MPTCP][PATCH v3 mptcp-next 5/7] mptcp: drop
 MPTCP_ADDR_IPVERSION_4/6
Date: Wed, 17 Mar 2021 15:36:20 +0800
Message-ID: <5842d55dd4413d694cf9c871261dac4fb99e5ab7.1615966219.git.geliangtang@gmail.com>
In-Reply-To: 5b55310e5e6682adfc02b6cc47480eae20612b83.1615966219.git.geliangtang@gmail.com
X-Status: 
X-Keywords:                  
X-UID: 8184

--===============4310310006274133111==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Since the type of the address family in struct mptcp_options_received
became sa_family_t, we should set AF_INET/AF_INET6 to it, instead of
using MPTCP_ADDR_IPVERSION_4/6.

Signed-off-by: Geliang Tang <geliangtang(a)gmail.com>
---
 net/mptcp/options.c  | 14 +++++++-------
 net/mptcp/protocol.h |  2 --
 2 files changed, 7 insertions(+), 9 deletions(-)

diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index 0bc5eb0f835c..5c6437c90859 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -220,22 +220,22 @@ static void mptcp_parse_option(const struct sk_buff *=
skb,
 		if (!mp_opt->echo) {
 			if (opsize =3D=3D TCPOLEN_MPTCP_ADD_ADDR ||
 			    opsize =3D=3D TCPOLEN_MPTCP_ADD_ADDR_PORT)
-				mp_opt->addr.family =3D MPTCP_ADDR_IPVERSION_4;
+				mp_opt->addr.family =3D AF_INET;
 #if IS_ENABLED(CONFIG_MPTCP_IPV6)
 			else if (opsize =3D=3D TCPOLEN_MPTCP_ADD_ADDR6 ||
 				 opsize =3D=3D TCPOLEN_MPTCP_ADD_ADDR6_PORT)
-				mp_opt->addr.family =3D MPTCP_ADDR_IPVERSION_6;
+				mp_opt->addr.family =3D AF_INET6;
 #endif
 			else
 				break;
 		} else {
 			if (opsize =3D=3D TCPOLEN_MPTCP_ADD_ADDR_BASE ||
 			    opsize =3D=3D TCPOLEN_MPTCP_ADD_ADDR_BASE_PORT)
-				mp_opt->addr.family =3D MPTCP_ADDR_IPVERSION_4;
+				mp_opt->addr.family =3D AF_INET;
 #if IS_ENABLED(CONFIG_MPTCP_IPV6)
 			else if (opsize =3D=3D TCPOLEN_MPTCP_ADD_ADDR6_BASE ||
 				 opsize =3D=3D TCPOLEN_MPTCP_ADD_ADDR6_BASE_PORT)
-				mp_opt->addr.family =3D MPTCP_ADDR_IPVERSION_6;
+				mp_opt->addr.family =3D AF_INET6;
 #endif
 			else
 				break;
@@ -243,7 +243,7 @@ static void mptcp_parse_option(const struct sk_buff *sk=
b,
 =

 		mp_opt->add_addr =3D 1;
 		mp_opt->addr.id =3D *ptr++;
-		if (mp_opt->addr.family =3D=3D MPTCP_ADDR_IPVERSION_4) {
+		if (mp_opt->addr.family =3D=3D AF_INET) {
 			memcpy((u8 *)&mp_opt->addr.addr.s_addr, (u8 *)ptr, 4);
 			ptr +=3D 4;
 			if (opsize =3D=3D TCPOLEN_MPTCP_ADD_ADDR_PORT ||
@@ -268,7 +268,7 @@ static void mptcp_parse_option(const struct sk_buff *sk=
b,
 			ptr +=3D 8;
 		}
 		pr_debug("ADD_ADDR%s: id=3D%d, ahmac=3D%llu, echo=3D%d, port=3D%d",
-			 (mp_opt->addr.family =3D=3D MPTCP_ADDR_IPVERSION_6) ? "6" : "",
+			 (mp_opt->addr.family =3D=3D AF_INET6) ? "6" : "",
 			 mp_opt->addr.id, mp_opt->ahmac, mp_opt->echo, ntohs(mp_opt->addr.port)=
);
 		break;
 =

@@ -991,7 +991,7 @@ static bool add_addr_hmac_valid(struct mptcp_sock *msk,
 	if (mp_opt->echo)
 		return true;
 =

-	if (mp_opt->addr.family =3D=3D MPTCP_ADDR_IPVERSION_4)
+	if (mp_opt->addr.family =3D=3D AF_INET)
 		hmac =3D add_addr_generate_hmac(msk->remote_key,
 					      msk->local_key,
 					      mp_opt->addr.id, &mp_opt->addr.addr,
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 7a2686ca7a0d..14f0114be17a 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -90,8 +90,6 @@
 =

 /* MPTCP ADD_ADDR flags */
 #define MPTCP_ADDR_ECHO		BIT(0)
-#define MPTCP_ADDR_IPVERSION_4	4
-#define MPTCP_ADDR_IPVERSION_6	6
 =

 /* MPTCP MP_PRIO flags */
 #define MPTCP_PRIO_BKUP		BIT(0)
-- =

2.30.2

--===============4310310006274133111==--
