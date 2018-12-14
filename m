Content-Type: multipart/mixed; boundary="===============6634546069547414915=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [RFC PATCH v5 02/17] tcp: Define IPPROTO_MPTCP
Date: Fri, 14 Dec 2018 14:27:00 -0800
Message-ID: <20181214222715.23766-3-mathew.j.martineau@linux.intel.com>
In-Reply-To: 20181214222715.23766-1-mathew.j.martineau@linux.intel.com
X-Status: 
X-Keywords:                  
X-UID: 903

--===============6634546069547414915==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

To open a MPTCP socket with socket(AF_INET, SOCK_STREAM, IPPROTO_MPTCP),
IPPROTO_MPTCP needs a value that differs from IPPROTO_TCP. The existing
IPPROTO numbers mostly map directly to IANA-specified protocol numbers.
MPTCP does not have a protocol number allocated because MPTCP packets
use the TCP protocol number. Use private number not used OTA.

Signed-off-by: Mat Martineau <mathew.j.martineau(a)linux.intel.com>
---
 include/uapi/linux/in.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/uapi/linux/in.h b/include/uapi/linux/in.h
index 48e8a225b985..f65975c801e5 100644
--- a/include/uapi/linux/in.h
+++ b/include/uapi/linux/in.h
@@ -64,6 +64,8 @@ enum {
 #define IPPROTO_BEETPH		IPPROTO_BEETPH
   IPPROTO_ENCAP =3D 98,		/* Encapsulation Header			*/
 #define IPPROTO_ENCAP		IPPROTO_ENCAP
+  IPPROTO_MPTCP =3D 99,		/* Multipath TCP connection 		*/
+#define IPPROTO_MPTCP		IPPROTO_MPTCP
   IPPROTO_PIM =3D 103,		/* Protocol Independent Multicast	*/
 #define IPPROTO_PIM		IPPROTO_PIM
   IPPROTO_COMP =3D 108,		/* Compression Header Protocol		*/
-- =

2.20.0


--===============6634546069547414915==--
