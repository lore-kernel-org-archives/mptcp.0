Content-Type: multipart/mixed; boundary="===============3516195919647187189=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] [GIT] Sync with net-next on 20190710: 1 conflict
Date: Wed, 10 Jul 2019 16:28:27 +0200
Message-ID: <5d60bf71-0ce9-6e27-7a30-efeea6b7f50e@tessares.net>
X-Status: 
X-Keywords:                  
X-UID: 1478

--===============3516195919647187189==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hello,

Just to inform you that we got a conflict when integrating last changes
from net-next:


diff --cc net/core/skbuff.c
index 6f1e31f674a3,710177270ff0..000000000000
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@@ -67,7 -66,7 +67,11 @@@
  #include <net/checksum.h>
  #include <net/ip6_checksum.h>
  #include <net/xfrm.h>
++<<<<<<< t/mptcp-Add-MPTCP-to-skb-extensions base content
 +#include <net/mpls.h>
++=3D=3D=3D=3D=3D=3D=3D
+ #include <net/mptcp.h>
++>>>>>>> remotes/origin/t/mptcp-Add-MPTCP-to-skb-extensions

  #include <linux/uaccess.h>
  #include <trace/events/skb.h>


Very easy to fix, it is due to 8822e270d697 (net: core: move push MPLS
functionality from OvS to core helper).

Our new "include" is now after mpls.h, see 3b4c08939994 for more details.

Only one small conflict over so many other changes:

 747 files changed, 30130 insertions(+), 9260 deletions(-)

Tests are still OK!

Cheers,
Matt
-- =

Matthieu Baerts | R&D Engineer
matthieu.baerts(a)tessares.net
Tessares SA | Hybrid Access Solutions
www.tessares.net
1 Avenue Jean Monnet, 1348 Louvain-la-Neuve, Belgium

--===============3516195919647187189==--
