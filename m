Content-Type: multipart/mixed; boundary="===============8777007931394370936=="
MIME-Version: 1.0
From: Davide Caratti <dcaratti at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH RFC 2/2] net: mptcp: remove useless #includes in
 crypto.c
Date: Fri, 14 Jun 2019 22:57:08 +0200
Message-ID: <b505ec07436140e15b3c7749a9ca9db862249e4c.1560544900.git.dcaratti@redhat.com>
In-Reply-To: cover.1560544900.git.dcaratti@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 1381

--===============8777007931394370936==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

- crypto.c doesn't need module.h (that was included twice)
- crypto.c doesn't need netdevice.h
- remove duplicate include of kernel.h

Signed-off-by: Davide Caratti <dcaratti(a)redhat.com>
---
 net/mptcp/crypto.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/net/mptcp/crypto.c b/net/mptcp/crypto.c
index 48b6748a8d25..117f2dd9e70a 100644
--- a/net/mptcp/crypto.c
+++ b/net/mptcp/crypto.c
@@ -22,10 +22,6 @@
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


--===============8777007931394370936==--
