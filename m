Content-Type: multipart/mixed; boundary="===============7730335999878224255=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH] Squash-to: "mptcp: Add key generation and token tree"
Date: Tue, 17 Dec 2019 16:00:40 +0100
Message-ID: <76824b27ccb24f9ee350679be7bf1887eb62b748.1576594763.git.pabeni@redhat.com>
X-Status: 
X-Keywords:                  
X-UID: 3114

--===============7730335999878224255==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

include net/tcp.h instead of linux/tcp.h

We will switch to the latter header later in part 4, but
in between, and after "mptcp: new sysctl to control the activation per NS"
we get some sparse warning due to missing ipv6-related fuction declaration.

Alternativelly we add an include for "net/tcp.h" in ctrl.c in patch
"mptcp: new sysctl to control the activation per NS".

Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>
---
 net/mptcp/protocol.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 4cf9620d19ec..5f43fa0275c0 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -8,7 +8,7 @@
 #define __MPTCP_PROTOCOL_H
 =

 #include <linux/random.h>
-#include <linux/tcp.h>
+#include <net/tcp.h>
 #include <net/inet_connection_sock.h>
 =

 #define MPTCP_SUPPORTED_VERSION	0
-- =

2.21.0

--===============7730335999878224255==--
