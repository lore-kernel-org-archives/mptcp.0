Content-Type: multipart/mixed; boundary="===============2710310274146009156=="
MIME-Version: 1.0
From: Davide Caratti <dcaratti at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH 1/2] net: mptcp: remove useless #includes in crypto.c
Date: Thu, 11 Jul 2019 19:12:19 +0200
Message-ID: <c2944b5217b1e143df835aeb1067d3ec9d75d342.1562864862.git.dcaratti@redhat.com>
In-Reply-To: cover.1562864862.git.dcaratti@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 1487

--===============2710310274146009156==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

- crypto.c doesn't need module.h (that was included twice)
- crypto.c does'nt need netdevice.h
- remove duplicate include of kernel.h

Signed-off-by: Davide Caratti <dcaratti(a)redhat.com>
---
 net/mptcp/crypto.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/net/mptcp/crypto.c b/net/mptcp/crypto.c
index 26a68aa1933a..e8644590690f 100644
--- a/net/mptcp/crypto.c
+++ b/net/mptcp/crypto.c
@@ -21,10 +21,6 @@
  */
 =

 #include <linux/kernel.h>
-#include <linux/module.h>
-#include <linux/netdevice.h>
-#include <linux/kernel.h>
-#include <linux/module.h>
 #include <linux/cryptohash.h>
 #include <linux/random.h>
 #include <linux/siphash.h>
-- =

2.20.1


--===============2710310274146009156==--
