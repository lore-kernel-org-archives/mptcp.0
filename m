Content-Type: multipart/mixed; boundary="===============8487916740176732020=="
MIME-Version: 1.0
From: Davide Caratti <dcaratti at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH v2 1/2] net: mptcp: remove useless #includes in
 crypto.c
Date: Tue, 23 Jul 2019 19:47:19 +0200
Message-ID: <6add1090f50c81552b3cabefb6ec16c8eac639e7.1563903620.git.dcaratti@redhat.com>
In-Reply-To: cover.1563903620.git.dcaratti@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 1547

--===============8487916740176732020==
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


--===============8487916740176732020==--
