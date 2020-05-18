Content-Type: multipart/mixed; boundary="===============5816432770085121184=="
MIME-Version: 1.0
From: Todd Malsbary <todd.malsbary at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH mptcp-next] mptcp: use rightmost 64 bits in ADD_ADDR
 HMAC
Date: Mon, 18 May 2020 15:29:16 -0700
Message-ID: <20200518222916.108513-1-todd.malsbary@linux.intel.com>
X-Status: 
X-Keywords:                  
X-UID: 4411

--===============5816432770085121184==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This changes the HMAC used in the ADD_ADDR option from the leftmost 64
bits to the rightmost 64 bits as described in RFC 8684, section 3.4.1.

Signed-off-by: Todd Malsbary <todd.malsbary(a)linux.intel.com>
---

I found this while adding support to packetdrill for the ADD_ADDR v1
option.  The computation I used for the HMAC in the pending
packetdrill work gave a different result than what was being computed
by the kernel.

It appears that the usage of the leftmost bits has been in place since
at least 2016 in the out-of-tree code (commit de09a83186666).  Given
that, is the issue in the implementation or the RFC?

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

--===============5816432770085121184==--
