Content-Type: multipart/mixed; boundary="===============3416011764163551214=="
MIME-Version: 1.0
From: Davide Caratti <dcaratti at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH RFC 1/2] net: mptcp: randomness improvements for
 crypto.c
Date: Fri, 14 Jun 2019 22:57:07 +0200
Message-ID: <fa10c90788df7e31a8c79a1e7c6683c9c3a2f5d6.1560544900.git.dcaratti@redhat.com>
In-Reply-To: cover.1560544900.git.dcaratti@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 1380

--===============3416011764163551214==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

- use net_get_random_once() to defer initialization of the crypto secret,
  instead of computing it at boot time, and remove 'crypto_init()'.

- don't use siphash for nonces, and also remove crypto_get_nonce_v{4,6}.
  They are not used on current MPTCP, and future users should suffice

     get_random_bytes(&nonce, sizeof(u32));

  like it's done by other protocols in the Linux kernel (like SCTP).

- use tcp_cookie_time() instead of 'seed', like it's done in syncookies,
  so that the initial value of 'seed' is time-dependent (not always 0).

CC: Florian Westphal <fwestpha(a)redhat.com>
CC: Paolo Abeni <pabeni(a)redhat.com>
Signed-off-by: Davide Caratti <dcaratti(a)redhat.com>
---
 net/mptcp/crypto.c   | 47 +++++---------------------------------------
 net/mptcp/protocol.c |  1 -
 net/mptcp/protocol.h |  6 ------
 3 files changed, 5 insertions(+), 49 deletions(-)

diff --git a/net/mptcp/crypto.c b/net/mptcp/crypto.c
index 2dc453d1d5ab..48b6748a8d25 100644
--- a/net/mptcp/crypto.c
+++ b/net/mptcp/crypto.c
@@ -29,47 +29,18 @@
 #include <linux/cryptohash.h>
 #include <linux/random.h>
 #include <linux/siphash.h>
+#include <net/tcp.h>
 #include <asm/unaligned.h>
 =

 static siphash_key_t crypto_key_secret __read_mostly;
-static hsiphash_key_t crypto_nonce_secret __read_mostly;
-static u32 crypto_seed;
-
-u32 crypto_v4_get_nonce(__be32 saddr, __be32 daddr, __be16 sport, __be16 d=
port)
-{
-	return hsiphash_4u32((__force u32)saddr, (__force u32)daddr,
-			    (__force u32)sport << 16 | (__force u32)dport,
-			    crypto_seed++, &crypto_nonce_secret);
-}
 =

 u64 crypto_v4_get_key(__be32 saddr, __be32 daddr, __be16 sport, __be16 dpo=
rt)
 {
 	pr_debug("src=3D%x:%d, dst=3D%x:%d", saddr, sport, daddr, dport);
+	net_get_random_once(&crypto_key_secret, sizeof(crypto_key_secret));
 	return siphash_4u32((__force u32)saddr, (__force u32)daddr,
 			    (__force u32)sport << 16 | (__force u32)dport,
-			    crypto_seed++, &crypto_key_secret);
-}
-
-u32 crypto_v6_get_nonce(const struct in6_addr *saddr,
-			const struct in6_addr *daddr,
-			__be16 sport, __be16 dport)
-{
-	const struct {
-		struct in6_addr saddr;
-		struct in6_addr daddr;
-		u32 seed;
-		__be16 sport;
-		__be16 dport;
-	} __aligned(SIPHASH_ALIGNMENT) combined =3D {
-		.saddr =3D *saddr,
-		.daddr =3D *daddr,
-		.seed =3D crypto_seed++,
-		.sport =3D sport,
-		.dport =3D dport,
-	};
-
-	return hsiphash(&combined, offsetofend(typeof(combined), dport),
-			&crypto_nonce_secret);
+			    tcp_cookie_time(), &crypto_key_secret);
 }
 =

 u64 crypto_v6_get_key(const struct in6_addr *saddr,
@@ -85,11 +56,12 @@ u64 crypto_v6_get_key(const struct in6_addr *saddr,
 	} __aligned(SIPHASH_ALIGNMENT) combined =3D {
 		.saddr =3D *saddr,
 		.daddr =3D *daddr,
-		.seed =3D crypto_seed++,
+		.seed =3D tcp_cookie_time(),
 		.sport =3D sport,
 		.dport =3D dport,
 	};
 =

+	net_get_random_once(&crypto_key_secret, sizeof(crypto_key_secret));
 	return siphash(&combined, offsetofend(typeof(combined), dport),
 		       &crypto_key_secret);
 }
@@ -196,12 +168,3 @@ void crypto_hmac_sha1(u64 key1, u64 key2, u32 *hash_ou=
t,
 	for (i =3D 0; i < 5; i++)
 		hash_out[i] =3D (__force u32)cpu_to_be32(hash_out[i]);
 }
-
-void crypto_init(void)
-{
-	get_random_bytes((void *)&crypto_key_secret,
-			 sizeof(crypto_key_secret));
-	get_random_bytes((void *)&crypto_nonce_secret,
-			 sizeof(crypto_nonce_secret));
-	crypto_seed =3D 0;
-}
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 941988387ea0..1bff0d2556d5 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1008,7 +1008,6 @@ void __init mptcp_init(void)
 	mptcp_stream_ops.shutdown =3D mptcp_shutdown;
 =

 	token_init();
-	crypto_init();
 	subflow_init();
 =

 	if (proto_register(&mptcp_prot, 1) !=3D 0)
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index a4f0e7d3bd62..471b885bb2db 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -131,17 +131,11 @@ void token_new_accept(struct sock *sk);
 void token_update_accept(struct sock *sk, struct sock *conn);
 void token_destroy(u32 token);
 =

-void crypto_init(void);
-u32 crypto_v4_get_nonce(__be32 saddr, __be32 daddr,
-			__be16 sport, __be16 dport);
 u64 crypto_v4_get_key(__be32 saddr, __be32 daddr,
 			__be16 sport, __be16 dport);
 u64 crypto_v6_get_key(const struct in6_addr *saddr,
 		      const struct in6_addr *daddr,
 		      __be16 sport, __be16 dport);
-u32 crypto_v6_get_nonce(const struct in6_addr *saddr,
-			const struct in6_addr *daddr,
-			__be16 sport, __be16 dport);
 void crypto_key_sha1(u64 key, u32 *token, u64 *idsn);
 void crypto_hmac_sha1(u64 key1, u64 key2, u32 *hash_out,
 		     int arg_num, ...);
-- =

2.20.1


--===============3416011764163551214==--
