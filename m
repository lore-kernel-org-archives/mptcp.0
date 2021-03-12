Content-Type: multipart/mixed; boundary="===============1429145221628274082=="
MIME-Version: 1.0
From: Davide Caratti <dcaratti at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH net] mptcp: fix ADD_ADDR HMAC in case port is specified
Date: Fri, 12 Mar 2021 22:32:18 +0100
Message-ID: <74f12b1cf1e60fbfba1b737b8949526346afb983.1615584629.git.dcaratti@redhat.com>
X-Status: 
X-Keywords:                  
X-UID: 8128

--===============1429145221628274082==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Currently, Linux computes the HMAC contained in ADD_ADDR sub-option using
the Address Id and the IP Address, and hardcodes a destination port equal
to zero. This is not ok for ADD_ADDR with port: ensure to account for the
endpoint port when computing the HMAC, in compliance with RFC8684 =C2=A73.4=
.1.

Fixes: 22fb85ffaefb ("mptcp: add port support for ADD_ADDR suboption writin=
g")
Signed-off-by: Davide Caratti <dcaratti(a)redhat.com>
---
 net/mptcp/options.c | 24 ++++++++++++++----------
 1 file changed, 14 insertions(+), 10 deletions(-)

diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index 444a38681e93..89a4225ed321 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -567,15 +567,15 @@ static bool mptcp_established_options_dss(struct sock=
 *sk, struct sk_buff *skb,
 }
 =

 static u64 add_addr_generate_hmac(u64 key1, u64 key2, u8 addr_id,
-				  struct in_addr *addr)
+				  struct in_addr *addr, u16 port)
 {
 	u8 hmac[SHA256_DIGEST_SIZE];
 	u8 msg[7];
 =

 	msg[0] =3D addr_id;
 	memcpy(&msg[1], &addr->s_addr, 4);
-	msg[5] =3D 0;
-	msg[6] =3D 0;
+	msg[5] =3D port >> 8;
+	msg[6] =3D port & 0xFF;
 =

 	mptcp_crypto_hmac_sha(key1, key2, msg, 7, hmac);
 =

@@ -584,15 +584,15 @@ static u64 add_addr_generate_hmac(u64 key1, u64 key2,=
 u8 addr_id,
 =

 #if IS_ENABLED(CONFIG_MPTCP_IPV6)
 static u64 add_addr6_generate_hmac(u64 key1, u64 key2, u8 addr_id,
-				   struct in6_addr *addr)
+				   struct in6_addr *addr, u16 port)
 {
 	u8 hmac[SHA256_DIGEST_SIZE];
 	u8 msg[19];
 =

 	msg[0] =3D addr_id;
 	memcpy(&msg[1], &addr->s6_addr, 16);
-	msg[17] =3D 0;
-	msg[18] =3D 0;
+	msg[17] =3D port >> 8;
+	msg[18] =3D port & 0xFF;
 =

 	mptcp_crypto_hmac_sha(key1, key2, msg, 19, hmac);
 =

@@ -646,7 +646,8 @@ static bool mptcp_established_options_add_addr(struct s=
ock *sk, struct sk_buff *
 			opts->ahmac =3D add_addr_generate_hmac(msk->local_key,
 							     msk->remote_key,
 							     opts->addr_id,
-							     &opts->addr);
+							     &opts->addr,
+							     opts->port);
 		}
 	}
 #if IS_ENABLED(CONFIG_MPTCP_IPV6)
@@ -657,7 +658,8 @@ static bool mptcp_established_options_add_addr(struct s=
ock *sk, struct sk_buff *
 			opts->ahmac =3D add_addr6_generate_hmac(msk->local_key,
 							      msk->remote_key,
 							      opts->addr_id,
-							      &opts->addr6);
+							      &opts->addr6,
+							      opts->port);
 		}
 	}
 #endif
@@ -962,12 +964,14 @@ static bool add_addr_hmac_valid(struct mptcp_sock *ms=
k,
 	if (mp_opt->family =3D=3D MPTCP_ADDR_IPVERSION_4)
 		hmac =3D add_addr_generate_hmac(msk->remote_key,
 					      msk->local_key,
-					      mp_opt->addr_id, &mp_opt->addr);
+					      mp_opt->addr_id, &mp_opt->addr,
+					      mp_opt->port);
 #if IS_ENABLED(CONFIG_MPTCP_IPV6)
 	else
 		hmac =3D add_addr6_generate_hmac(msk->remote_key,
 					       msk->local_key,
-					       mp_opt->addr_id, &mp_opt->addr6);
+					       mp_opt->addr_id, &mp_opt->addr6,
+					       mp_opt->port);
 #endif
 =

 	pr_debug("msk=3D%p, ahmac=3D%llu, mp_opt->ahmac=3D%llu\n",
-- =

2.29.2

--===============1429145221628274082==--
