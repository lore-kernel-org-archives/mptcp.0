Content-Type: multipart/mixed; boundary="===============0825238036559437477=="
MIME-Version: 1.0
From: Geliang Tang <geliangtang at gmail.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [MPTCP][PATCH v3 mptcp-next 6/7] mptcp: unify
 add_addr(6)_generate_hmac
Date: Wed, 17 Mar 2021 15:36:21 +0800
Message-ID: <a88ce5ec915018139620a53cfbda4693c39ed5ff.1615966219.git.geliangtang@gmail.com>
In-Reply-To: 5842d55dd4413d694cf9c871261dac4fb99e5ab7.1615966219.git.geliangtang@gmail.com
X-Status: 
X-Keywords:                  
X-UID: 8185

--===============0825238036559437477==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The length of the IPv4 address is 4 octets and IPv6 is 16. That's the only
difference between add_addr_generate_hmac and add_addr6_generate_hmac.

This patch dropped the duplicate code and unify them into one.

Signed-off-by: Geliang Tang <geliangtang(a)gmail.com>
---
 net/mptcp/options.c | 80 ++++++++++++++-------------------------------
 1 file changed, 24 insertions(+), 56 deletions(-)

diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index 5c6437c90859..e3fcd2b0ffd7 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -583,39 +583,31 @@ static bool mptcp_established_options_dss(struct sock=
 *sk, struct sk_buff *skb,
 	return true;
 }
 =

-static u64 add_addr_generate_hmac(u64 key1, u64 key2, u8 addr_id,
-				  struct in_addr *addr, u16 port)
-{
-	u8 hmac[SHA256_DIGEST_SIZE];
-	u8 msg[7];
-
-	msg[0] =3D addr_id;
-	memcpy(&msg[1], &addr->s_addr, 4);
-	msg[5] =3D port >> 8;
-	msg[6] =3D port & 0xFF;
-
-	mptcp_crypto_hmac_sha(key1, key2, msg, 7, hmac);
-
-	return get_unaligned_be64(&hmac[SHA256_DIGEST_SIZE - sizeof(u64)]);
-}
-
-#if IS_ENABLED(CONFIG_MPTCP_IPV6)
-static u64 add_addr6_generate_hmac(u64 key1, u64 key2, u8 addr_id,
-				   struct in6_addr *addr, u16 port)
+static u64 add_addr_generate_hmac(u64 key1, u64 key2,
+				  struct mptcp_addr_info *addr)
 {
 	u8 hmac[SHA256_DIGEST_SIZE];
 	u8 msg[19];
+	int i =3D 0;
 =

-	msg[0] =3D addr_id;
-	memcpy(&msg[1], &addr->s6_addr, 16);
-	msg[17] =3D port >> 8;
-	msg[18] =3D port & 0xFF;
+	msg[i++] =3D addr->id;
+	if (addr->family =3D=3D AF_INET) {
+		memcpy(&msg[i], &addr->addr.s_addr, 4);
+		i +=3D 4;
+	}
+#if IS_ENABLED(CONFIG_MPTCP_IPV6)
+	else if (addr->family =3D=3D AF_INET6) {
+		memcpy(&msg[i], &addr->addr6.s6_addr, 16);
+		i +=3D 16;
+	}
+#endif
+	msg[i++] =3D addr->port >> 8;
+	msg[i++] =3D addr->port & 0xFF;
 =

-	mptcp_crypto_hmac_sha(key1, key2, msg, 19, hmac);
+	mptcp_crypto_hmac_sha(key1, key2, msg, i, hmac);
 =

 	return get_unaligned_be64(&hmac[SHA256_DIGEST_SIZE - sizeof(u64)]);
 }
-#endif
 =

 static bool mptcp_established_options_add_addr(struct sock *sk, struct sk_=
buff *skb,
 					       unsigned int *size,
@@ -653,26 +645,11 @@ static bool mptcp_established_options_add_addr(struct=
 sock *sk, struct sk_buff *
 	if (drop_other_suboptions)
 		*size -=3D opt_size;
 	opts->suboptions |=3D OPTION_MPTCP_ADD_ADDR;
-	if (opts->addr.family =3D=3D AF_INET) {
-		if (!echo) {
-			opts->ahmac =3D add_addr_generate_hmac(msk->local_key,
-							     msk->remote_key,
-							     opts->addr.id,
-							     &opts->addr.addr,
-							     opts->addr.port);
-		}
+	if (!echo) {
+		opts->ahmac =3D add_addr_generate_hmac(msk->local_key,
+						     msk->remote_key,
+						     &opts->addr);
 	}
-#if IS_ENABLED(CONFIG_MPTCP_IPV6)
-	else if (opts->addr.family =3D=3D AF_INET6) {
-		if (!echo) {
-			opts->ahmac =3D add_addr6_generate_hmac(msk->local_key,
-							      msk->remote_key,
-							      opts->addr.id,
-							      &opts->addr.addr6,
-							      opts->addr.port);
-		}
-	}
-#endif
 	pr_debug("addr_id=3D%d, ahmac=3D%llu, echo=3D%d, port=3D%d",
 		 opts->addr.id, opts->ahmac, echo, ntohs(opts->addr.port));
 =

@@ -991,18 +968,9 @@ static bool add_addr_hmac_valid(struct mptcp_sock *msk,
 	if (mp_opt->echo)
 		return true;
 =

-	if (mp_opt->addr.family =3D=3D AF_INET)
-		hmac =3D add_addr_generate_hmac(msk->remote_key,
-					      msk->local_key,
-					      mp_opt->addr.id, &mp_opt->addr.addr,
-					      mp_opt->addr.port);
-#if IS_ENABLED(CONFIG_MPTCP_IPV6)
-	else
-		hmac =3D add_addr6_generate_hmac(msk->remote_key,
-					       msk->local_key,
-					       mp_opt->addr.id, &mp_opt->addr.addr6,
-					       mp_opt->addr.port);
-#endif
+	hmac =3D add_addr_generate_hmac(msk->remote_key,
+				      msk->local_key,
+				      &mp_opt->addr);
 =

 	pr_debug("msk=3D%p, ahmac=3D%llu, mp_opt->ahmac=3D%llu\n",
 		 msk, (unsigned long long)hmac,
-- =

2.30.2

--===============0825238036559437477==--
