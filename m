Content-Type: multipart/mixed; boundary="===============0410310418662505946=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [RFC PATCH 05/16] tcp: Add IPPROTO_SUBFLOW
Date: Wed, 28 Mar 2018 16:18:29 -0700
Message-ID: <20180328231840.12410-6-mathew.j.martineau@linux.intel.com>
In-Reply-To: 20180328231840.12410-1-mathew.j.martineau@linux.intel.com
X-Status: 
X-Keywords:                  
X-UID: 449

--===============0410310418662505946==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Peter Krystad <peter.krystad(a)intel.com>

IANA protocol numbers fit in a single byte, however the protocol field
of struct inet_protosw is an unsigned short so defining IPPROTO_SUBFLOW
as a 16-bit value greater than 0xFF with the same LSB as IPPROTO_TCP is
convenient for registering a unique protocol with inet_register_protosw()
that still transmits packets with IPPROTO_TCP as the protocol number.

Signed-off-by: Peter Krystad <peter.krystad(a)intel.com>
---
 include/uapi/linux/in.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/uapi/linux/in.h b/include/uapi/linux/in.h
index f65975c801e5..6986aecd0f46 100644
--- a/include/uapi/linux/in.h
+++ b/include/uapi/linux/in.h
@@ -78,6 +78,8 @@ enum {
 #define IPPROTO_MPLS		IPPROTO_MPLS
   IPPROTO_RAW =3D 255,		/* Raw IP packets			*/
 #define IPPROTO_RAW		IPPROTO_RAW
+  IPPROTO_SUBFLOW =3D 262,	/* Multipath TCP (IPPROTO_TCP | 0x100)	*/
+#define IPPROTO_SUBFLOW		IPPROTO_SUBFLOW
   IPPROTO_MAX
 };
 #endif
-- =

2.16.3


--===============0410310418662505946==--
