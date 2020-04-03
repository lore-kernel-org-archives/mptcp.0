Content-Type: multipart/mixed; boundary="===============1241744102575242051=="
MIME-Version: 1.0
From: Geliang Tang <geliangtang at gmail.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH] mptcp: move pr_fmt defining to protocol.h
Date: Fri, 03 Apr 2020 15:57:25 +0800
Message-ID: <34c83a5fe561739c7b85a3c4959eb44c3155d075.1585899578.git.geliangtang@gmail.com>
X-Status: 
X-Keywords:                  
X-UID: 4132

--===============1241744102575242051==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Some of the mptcp logs didn't print out the format string "MPTCP":

[  129.185774] DSS
[  129.185774] data_fin=3D0 dsn64=3D1 use_map=3D1 ack64=3D1 use_ack=3D1
[  129.185774] data_ack=3D5481534886531492085
[  129.185775] data_seq=3D15725204003114694615 subflow_seq=3D1425409 data_l=
en=3D5216
[  129.185776] subflow=3D0000000093526a92 fully established=3D1 seq=3D0:0 r=
emaining=3D28
[  129.185776] MPTCP: msk=3D00000000d5a704a6 ssk=3D00000000b5aabc31 data_av=
ail=3D0 skb=3D0000000088f05424
[  129.185777] MPTCP: seq=3D15725204003114694615 is64=3D1 ssn=3D1425409 dat=
a_len=3D5216 data_fin=3D0
[  129.185777] MPTCP: msk=3D00000000d5a704a6 ssk=3D00000000b5aabc31 status=
=3D0
[  129.185778] MPTCP: msk ack_seq=3Dda3b25b9a233c2c7 subflow ack_seq=3Dda3b=
25b9a233c2c7
[  129.185778] MPTCP: msk=3D00000000d5a704a6 ssk=3D00000000b5aabc31 data_av=
ail=3D1 skb=3D000000000caed2cc
[  129.185779] subflow=3D0000000093526a92 fully established=3D1 seq=3D0:0 r=
emaining=3D28

So this patch moves the pr_fmt defining from protocol.c to protocol.h, which
is included by all the C files. Then we can get the same format string
"MPTCP" in all mptcp logs like this:

[  141.854787] MPTCP: DSS
[  141.854788] MPTCP: data_fin=3D0 dsn64=3D1 use_map=3D1 ack64=3D1 use_ack=
=3D1
[  141.854788] MPTCP: data_ack=3D18028325517710311871
[  141.854788] MPTCP: data_seq=3D6163976859259356786 subflow_seq=3D3309569 =
data_len=3D8192
[  141.854789] MPTCP: msk=3D000000005847a66a ssk=3D0000000022469903 data_av=
ail=3D0 skb=3D00000000dd95efc3
[  141.854789] MPTCP: seq=3D6163976859259356786 is64=3D1 ssn=3D3309569 data=
_len=3D8192 data_fin=3D0
[  141.854790] MPTCP: msk=3D000000005847a66a ssk=3D0000000022469903 status=
=3D0
[  141.854790] MPTCP: msk ack_seq=3D558ad84b9be1d162 subflow ack_seq=3D558a=
d84b9be1d162
[  141.854791] MPTCP: msk=3D000000005847a66a ssk=3D0000000022469903 data_av=
ail=3D1 skb=3D000000000b8926f6
[  141.854791] MPTCP: subflow=3D00000000e4e4579c fully established=3D1 seq=
=3D0:0 remaining=3D28
[  141.854792] MPTCP: subflow=3D00000000e4e4579c fully established=3D1 seq=
=3D0:dcdf2f3b remaining=3D28

Signed-off-by: Geliang Tang <geliangtang(a)gmail.com>
---
 net/mptcp/protocol.c | 2 --
 net/mptcp/protocol.h | 2 ++
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 72f3176dc924..cc86137cd04f 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -4,8 +4,6 @@
  * Copyright (c) 2017 - 2019, Intel Corporation.
  */
 =

-#define pr_fmt(fmt) "MPTCP: " fmt
-
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/netdevice.h>
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 67448002a2d7..3eff041eeccf 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -7,6 +7,8 @@
 #ifndef __MPTCP_PROTOCOL_H
 #define __MPTCP_PROTOCOL_H
 =

+#define pr_fmt(fmt) "MPTCP: " fmt
+
 #include <linux/random.h>
 #include <net/tcp.h>
 #include <net/inet_connection_sock.h>
-- =

2.17.1

--===============1241744102575242051==--
