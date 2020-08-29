Content-Type: multipart/mixed; boundary="===============2756612772022209300=="
MIME-Version: 1.0
From: YueHaibing <yuehaibing at huawei.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH net-next] mptcp: Remove unused macro MPTCP_SAME_STATE
Date: Sat, 29 Aug 2020 19:42:26 +0800
Message-ID: <20200829114226.17976-1-yuehaibing@huawei.com>
X-Status: 
X-Keywords:                  
X-UID: 5665

--===============2756612772022209300==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

There is no caller in tree any more.

Signed-off-by: YueHaibing <yuehaibing(a)huawei.com>
---
 net/mptcp/protocol.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 1aad411a0e46..e6216c4f308c 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -24,8 +24,6 @@
 #include "protocol.h"
 #include "mib.h"
 =

-#define MPTCP_SAME_STATE TCP_MAX_STATES
-
 #if IS_ENABLED(CONFIG_MPTCP_IPV6)
 struct mptcp6_sock {
 	struct mptcp_sock msk;
-- =

2.17.1


--===============2756612772022209300==--
