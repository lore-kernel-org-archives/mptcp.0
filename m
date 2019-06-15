Content-Type: multipart/mixed; boundary="===============5673464072861826999=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH 7/16] mptcp: fix checkpatch issues
Date: Sat, 15 Jun 2019 12:52:50 +0200
Message-ID: <20190615105259.15151-8-matthieu.baerts@tessares.net>
In-Reply-To: 20190615105259.15151-1-matthieu.baerts@tessares.net
X-Status: 
X-Keywords:                  
X-UID: 1392

--===============5673464072861826999==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

What has been fixed:

 - Possible unwrapped commit description (prefer a maximum 75 chars per
   line)

What has not been fixed:

 - /

Fixes: b806ddc89578 (tcp: Prevent coalesce/collapse when skb has MPTCP exte=
nsions)
Signed-off-by: Matthieu Baerts <matthieu.baerts(a)tessares.net>
---
 .topmsg | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/.topmsg b/.topmsg
index 033cbc06077c..6f250b71a2e1 100644
--- a/.topmsg
+++ b/.topmsg
@@ -1,8 +1,9 @@
 From: Mat Martineau <mathew.j.martineau(a)linux.intel.com>
 Subject: [PATCH] tcp: Prevent coalesce/collapse when skb has MPTCP extensi=
ons
 =

-The MPTCP extension data needs to be preserved as it passes through the TCP
-stack. Make sure that these skbs are not appended to others during coalesc=
e or
-collapse, so the data remains associated with the payload of the given skb.
+The MPTCP extension data needs to be preserved as it passes through the
+TCP stack. Make sure that these skbs are not appended to others during
+coalesce or collapse, so the data remains associated with the payload of
+the given skb.
 =

 Signed-off-by: Mat Martineau <mathew.j.martineau(a)linux.intel.com>
-- =

2.20.1


--===============5673464072861826999==--
