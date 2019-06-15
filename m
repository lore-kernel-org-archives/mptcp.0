Content-Type: multipart/mixed; boundary="===============4484609360676881569=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH 2/16] mptcp: fix checkpatch issues
Date: Sat, 15 Jun 2019 12:52:45 +0200
Message-ID: <20190615105259.15151-3-matthieu.baerts@tessares.net>
In-Reply-To: 20190615105259.15151-1-matthieu.baerts@tessares.net
X-Status: 
X-Keywords:                  
X-UID: 1387

--===============4484609360676881569==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

What has been fixed:

 - networking block comments don't use an empty /* line, use /*
   Comment...

What has not been fixed:

 - multiple assignments should be avoided in include/linux/tcp.h:124
   > Did just above for other TCP options
 - Prefer using the BIT macro in net/ipv4/tcp_output.c:415
   > Done like that just above
 - added, moved or deleted file(s), does MAINTAINERS need updating?
   > TBD later
 - line over 80 characters in net/mptcp/options.c:36
   > Florian is OK with that.

Fixes: 4ef12a2d401e (mptcp: Handle MPTCP TCP options)
Signed-off-by: Matthieu Baerts <matthieu.baerts(a)tessares.net>
---
 net/mptcp/options.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index a643a3c966c0..42626cd0a9f7 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -1,6 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
-/*
- * Multipath TCP
+/* Multipath TCP
  *
  * Copyright (c) 2017 - 2019, Intel Corporation.
  */
-- =

2.20.1


--===============4484609360676881569==--
