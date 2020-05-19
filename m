Content-Type: multipart/mixed; boundary="===============3426753112554194047=="
MIME-Version: 1.0
From: Todd Malsbary <todd.malsbary at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH net] mptcp: use rightmost 64 bits in ADD_ADDR HMAC
Date: Tue, 19 May 2020 09:45:34 -0700
Message-ID: <20200519164534.147058-1-todd.malsbary@linux.intel.com>
X-Status: 
X-Keywords:                  
X-UID: 4421

--===============3426753112554194047==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This changes the HMAC used in the ADD_ADDR option from the leftmost 64
bits to the rightmost 64 bits as described in RFC 8684, section 3.4.1.

This issue was discovered while adding support to packetdrill for the
ADD_ADDR v1 option.

Fixes: 3df523ab582c ("mptcp: Add ADD_ADDR handling")
Signed-off-by: Todd Malsbary <todd.malsbary(a)linux.intel.com>
Acked-by: Christoph Paasch <cpaasch(a)apple.com>
Reviewed-by: Matthieu Baerts <matthieu.baerts(a)tessares.net>
---
 net/mptcp/options.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index ece6f92cf7d1..0e11fb3d908f 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -550,7 +550,7 @@ static u64 add_addr_generate_hmac(u64 key1, u64 key2, u=
8 addr_id,
 =

 	mptcp_crypto_hmac_sha(key1, key2, msg, 7, hmac);
 =

-	return get_unaligned_be64(hmac);
+	return get_unaligned_be64(&hmac[MPTCP_ADDR_HMAC_LEN - sizeof(u64)]);
 }
 =

 #if IS_ENABLED(CONFIG_MPTCP_IPV6)
@@ -567,7 +567,7 @@ static u64 add_addr6_generate_hmac(u64 key1, u64 key2, =
u8 addr_id,
 =

 	mptcp_crypto_hmac_sha(key1, key2, msg, 19, hmac);
 =

-	return get_unaligned_be64(hmac);
+	return get_unaligned_be64(&hmac[MPTCP_ADDR_HMAC_LEN - sizeof(u64)]);
 }
 #endif
 =

-- =

2.25.4

--===============3426753112554194047==--
