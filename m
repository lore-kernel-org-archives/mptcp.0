Content-Type: multipart/mixed; boundary="===============1113819082649372239=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH 2/6] topmsg: mptcp: queue data for mptcp level
 retransmission
Date: Fri, 27 Mar 2020 16:53:23 +0100
Message-ID: <20200327155327.605375-3-matthieu.baerts@tessares.net>
In-Reply-To: 20200327155327.605375-1-matthieu.baerts@tessares.net
X-Status: 
X-Keywords:                  
X-UID: 4088

--===============1113819082649372239==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Add ChangeLog + add missing capital letters.

Signed-off-by: Matthieu Baerts <matthieu.baerts(a)tessares.net>
---
 .topmsg | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/.topmsg b/.topmsg
index cf9740a54b08..4ca75d24c88e 100644
--- a/.topmsg
+++ b/.topmsg
@@ -1,8 +1,8 @@
 From: Paolo Abeni <pabeni(a)redhat.com>
 Subject: [PATCH] mptcp: queue data for mptcp level retransmission
 =

-keep the send page fragment on an MPTCP level retransmission queue.
-the queue entries are allocated inside the page frag allocator,
+Keep the send page fragment on an MPTCP level retransmission queue.
+The queue entries are allocated inside the page frag allocator,
 acquiring an additional reference to the page for each list entry.
 =

 Also switch to a custom page frag refill function, to ensure that
@@ -13,5 +13,8 @@ The MPTCP rtx queue is flushed at disconnect() and close(=
) time
 Note that now we need to call __mptcp_init_sock() regardless of mptcp
 enable status, as the destructor will try to walk the rtx_queue.
 =

+v2 -> v3:
+ - remove 'inline' in foo.c files (David S. Miller)
+
 Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>
 Signed-off-by: Mat Martineau <mathew.j.martineau(a)linux.intel.com>
-- =

2.25.1

--===============1113819082649372239==--
