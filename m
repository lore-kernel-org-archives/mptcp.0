Content-Type: multipart/mixed; boundary="===============4869324935298814449=="
MIME-Version: 1.0
From: Geliang Tang <geliangtang at gmail.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH v2] mptcp: add some missing pr_fmt defines
Date: Fri, 03 Apr 2020 17:14:08 +0800
Message-ID: <f66ab0b7dfcc895d901e6e85b30f2a21842d2b2c.1585904950.git.geliangtang@gmail.com>
In-Reply-To: 34c83a5fe561739c7b85a3c4959eb44c3155d075.1585899578.git.geliangtang@gmail.com
X-Status: 
X-Keywords:                  
X-UID: 4133

--===============4869324935298814449==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Some of the mptcp logs didn't print out the format string:

[  185.651493] DSS
[  185.651494] data_fin=3D0 dsn64=3D0 use_map=3D0 ack64=3D1 use_ack=3D1
[  185.651494] data_ack=3D13792750332298763796
[  185.651495] MPTCP: msk=3D00000000c4b81cfc ssk=3D000000009743af53 data_av=
ail=3D0 skb=3D0000000063dc595d
[  185.651495] MPTCP: msk=3D00000000c4b81cfc ssk=3D000000009743af53 status=
=3D0
[  185.651495] MPTCP: msk ack_seq=3D9bbc894565aa2f9a subflow ack_seq=3D9bbc=
894565aa2f9a
[  185.651496] MPTCP: msk=3D00000000c4b81cfc ssk=3D000000009743af53 data_av=
ail=3D1 skb=3D0000000012e809e1

So this patch added these missing pr_fmt defines. Then we can get the same
format string "MPTCP" in all mptcp logs like this:

[  142.795829] MPTCP: DSS
[  142.795829] MPTCP: data_fin=3D0 dsn64=3D0 use_map=3D0 ack64=3D1 use_ack=
=3D1
[  142.795829] MPTCP: data_ack=3D8089704603109242421
[  142.795830] MPTCP: msk=3D00000000133a24e0 ssk=3D000000002e508c64 data_av=
ail=3D0 skb=3D00000000d5f230df
[  142.795830] MPTCP: msk=3D00000000133a24e0 ssk=3D000000002e508c64 status=
=3D0
[  142.795831] MPTCP: msk ack_seq=3D66790290f1199d9b subflow ack_seq=3D6679=
0290f1199d9b
[  142.795831] MPTCP: msk=3D00000000133a24e0 ssk=3D000000002e508c64 data_av=
ail=3D1 skb=3D00000000de5aca2e

Signed-off-by: Geliang Tang <geliangtang(a)gmail.com>

---
Changes in v2:
 - add pr_fmt to C files, not headers. =

---
 net/mptcp/options.c    | 2 ++
 net/mptcp/pm.c         | 2 ++
 net/mptcp/pm_netlink.c | 2 ++
 3 files changed, 6 insertions(+)

diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index bd220ee4aac9..faf57585b892 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -4,6 +4,8 @@
  * Copyright (c) 2017 - 2019, Intel Corporation.
  */
 =

+#define pr_fmt(fmt) "MPTCP: " fmt
+
 #include <linux/kernel.h>
 #include <net/tcp.h>
 #include <net/mptcp.h>
diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index 064639f72487..977d9c8b1453 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -3,6 +3,8 @@
  *
  * Copyright (c) 2019, Intel Corporation.
  */
+#define pr_fmt(fmt) "MPTCP: " fmt
+
 #include <linux/kernel.h>
 #include <net/tcp.h>
 #include <net/mptcp.h>
diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index a0ce7f324499..86d61ab34c7c 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -4,6 +4,8 @@
  * Copyright (c) 2020, Red Hat, Inc.
  */
 =

+#define pr_fmt(fmt) "MPTCP: " fmt
+
 #include <linux/inet.h>
 #include <linux/kernel.h>
 #include <net/tcp.h>
-- =

2.17.1

--===============4869324935298814449==--
