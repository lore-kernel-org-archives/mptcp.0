Content-Type: multipart/mixed; boundary="===============4954393025902725670=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH 1/16] mptcp: fix checkpatch issues
Date: Sat, 15 Jun 2019 12:52:44 +0200
Message-ID: <20190615105259.15151-2-matthieu.baerts@tessares.net>
In-Reply-To: 20190615105259.15151-1-matthieu.baerts@tessares.net
X-Status: 
X-Keywords:                  
X-UID: 1386

--===============4954393025902725670==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

What has been fixed:

 - networking block comments don't use an empty /* line, use /*
   Comment...

What has not been fixed:

 - added, moved or deleted file(s), does MAINTAINERS need updating?
   > TBD later

Fixes: 5eced96906af (mptcp: Add MPTCP socket stubs)
Signed-off-by: Matthieu Baerts <matthieu.baerts(a)tessares.net>
---
 net/mptcp/protocol.c | 3 +--
 net/mptcp/protocol.h | 3 +--
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 20f84dc8af9a..86db17af8c05 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1,6 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
-/*
- * Multipath TCP
+/* Multipath TCP
  *
  * Copyright (c) 2017 - 2019, Intel Corporation.
  */
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 795b7a6a899e..972204835421 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -1,6 +1,5 @@
 /* SPDX-License-Identifier: GPL-2.0 */
-/*
- * Multipath TCP
+/* Multipath TCP
  *
  * Copyright (c) 2017 - 2019, Intel Corporation.
  */
-- =

2.20.1


--===============4954393025902725670==--
