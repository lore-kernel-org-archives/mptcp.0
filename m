Content-Type: multipart/mixed; boundary="===============8092267081715921168=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH 6/6] topmsg: mptcp: add and use MIB counter
 infrastructure
Date: Fri, 27 Mar 2020 16:53:27 +0100
Message-ID: <20200327155327.605375-7-matthieu.baerts@tessares.net>
In-Reply-To: 20200327155327.605375-1-matthieu.baerts@tessares.net
X-Status: 
X-Keywords:                  
X-UID: 4093

--===============8092267081715921168==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Add ChangeLog.

Signed-off-by: Matthieu Baerts <matthieu.baerts(a)tessares.net>
---
 .topmsg | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/.topmsg b/.topmsg
index a1260cccb9e2..c7f8e6f5fe79 100644
--- a/.topmsg
+++ b/.topmsg
@@ -16,6 +16,9 @@ The MIB counter list is taken from the multipath-tcp.org =
kernel, but
 only a few counters have been picked up so far.  The counter list can
 be increased at any time later on.
 =

+v2 -> v3:
+ - remove 'inline' in foo.c files (David S. Miller)
+
 Co-developed-by: Paolo Abeni <pabeni(a)redhat.com>
 Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>
 Signed-off-by: Florian Westphal <fw(a)strlen.de>
-- =

2.25.1

--===============8092267081715921168==--
