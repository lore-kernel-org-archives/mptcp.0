Content-Type: multipart/mixed; boundary="===============7110889725385641920=="
MIME-Version: 1.0
From: Davide Caratti <dcaratti at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH] squash-to: "tcp: Define IPPROTO_MPTCP"
Date: Fri, 13 Dec 2019 17:06:01 +0100
Message-ID: <fd9848c19b14b56061bdf660e55b9f3ddb443736.1576252967.git.dcaratti@redhat.com>
X-Status: 
X-Keywords:                  
X-UID: 2950

--===============7110889725385641920==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

checkpatch fixes

Signed-off-by: Davide Caratti <dcaratti(a)redhat.com>
---
 include/uapi/linux/in.h       | 2 +-
 tools/include/uapi/linux/in.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/uapi/linux/in.h b/include/uapi/linux/in.h
index 44df6dc1ff1d..1521073b6348 100644
--- a/include/uapi/linux/in.h
+++ b/include/uapi/linux/in.h
@@ -76,7 +76,7 @@ enum {
 #define IPPROTO_MPLS		IPPROTO_MPLS
   IPPROTO_RAW =3D 255,		/* Raw IP packets			*/
 #define IPPROTO_RAW		IPPROTO_RAW
-  IPPROTO_MPTCP =3D 262,		/* Multipath TCP connection 		*/
+  IPPROTO_MPTCP =3D 262,		/* Multipath TCP connection		*/
 #define IPPROTO_MPTCP		IPPROTO_MPTCP
   IPPROTO_MAX
 };
diff --git a/tools/include/uapi/linux/in.h b/tools/include/uapi/linux/in.h
index 44df6dc1ff1d..1521073b6348 100644
--- a/tools/include/uapi/linux/in.h
+++ b/tools/include/uapi/linux/in.h
@@ -76,7 +76,7 @@ enum {
 #define IPPROTO_MPLS		IPPROTO_MPLS
   IPPROTO_RAW =3D 255,		/* Raw IP packets			*/
 #define IPPROTO_RAW		IPPROTO_RAW
-  IPPROTO_MPTCP =3D 262,		/* Multipath TCP connection 		*/
+  IPPROTO_MPTCP =3D 262,		/* Multipath TCP connection		*/
 #define IPPROTO_MPTCP		IPPROTO_MPTCP
   IPPROTO_MAX
 };
-- =

2.23.0

--===============7110889725385641920==--
