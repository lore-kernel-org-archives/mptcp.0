Content-Type: multipart/mixed; boundary="===============2372220580457184925=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH 1/2] squash-to: Define IPPROTO_MPTCP
Date: Wed, 12 Jun 2019 10:16:42 -0700
Message-ID: <20190612171643.21861-2-mathew.j.martineau@linux.intel.com>
In-Reply-To: 20190612171643.21861-1-mathew.j.martineau@linux.intel.com
X-Status: 
X-Keywords:                  
X-UID: 1348

--===============2372220580457184925==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Signed-off-by: Mat Martineau <mathew.j.martineau(a)linux.intel.com>
---
 include/uapi/linux/in.h       | 4 ++--
 tools/include/uapi/linux/in.h | 2 ++
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/include/uapi/linux/in.h b/include/uapi/linux/in.h
index 649d8cd41b80..44df6dc1ff1d 100644
--- a/include/uapi/linux/in.h
+++ b/include/uapi/linux/in.h
@@ -64,8 +64,6 @@ enum {
 #define IPPROTO_BEETPH		IPPROTO_BEETPH
   IPPROTO_ENCAP =3D 98,		/* Encapsulation Header			*/
 #define IPPROTO_ENCAP		IPPROTO_ENCAP
-  IPPROTO_MPTCP =3D 99,		/* Multipath TCP connection 		*/
-#define IPPROTO_MPTCP		IPPROTO_MPTCP
   IPPROTO_PIM =3D 103,		/* Protocol Independent Multicast	*/
 #define IPPROTO_PIM		IPPROTO_PIM
   IPPROTO_COMP =3D 108,		/* Compression Header Protocol		*/
@@ -78,6 +76,8 @@ enum {
 #define IPPROTO_MPLS		IPPROTO_MPLS
   IPPROTO_RAW =3D 255,		/* Raw IP packets			*/
 #define IPPROTO_RAW		IPPROTO_RAW
+  IPPROTO_MPTCP =3D 262,		/* Multipath TCP connection 		*/
+#define IPPROTO_MPTCP		IPPROTO_MPTCP
   IPPROTO_MAX
 };
 #endif
diff --git a/tools/include/uapi/linux/in.h b/tools/include/uapi/linux/in.h
index e7ad9d350a28..44df6dc1ff1d 100644
--- a/tools/include/uapi/linux/in.h
+++ b/tools/include/uapi/linux/in.h
@@ -76,6 +76,8 @@ enum {
 #define IPPROTO_MPLS		IPPROTO_MPLS
   IPPROTO_RAW =3D 255,		/* Raw IP packets			*/
 #define IPPROTO_RAW		IPPROTO_RAW
+  IPPROTO_MPTCP =3D 262,		/* Multipath TCP connection 		*/
+#define IPPROTO_MPTCP		IPPROTO_MPTCP
   IPPROTO_MAX
 };
 #endif
-- =

2.22.0


--===============2372220580457184925==--
