Content-Type: multipart/mixed; boundary="===============4204612787181721613=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH 10/13] mptcp: allow creating non-backup subflows
Date: Wed, 05 Aug 2020 19:57:09 +0200
Message-ID: <9c56d32d58e4d507564cc764c3cb4f84f562ade4.1596649926.git.pabeni@redhat.com>
In-Reply-To: cover.1596649926.git.pabeni@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 5489

--===============4204612787181721613==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Currently the 'backup' attribute of local endpoint
is ignored. Let's use it for the MP_JOIN handshake

Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>
---
 net/mptcp/subflow.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index 00cab7d3dbae..587e3b653930 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -20,6 +20,7 @@
 #include <net/ip6_route.h>
 #endif
 #include <net/mptcp.h>
+#include <uapi/linux/mptcp.h>
 #include "protocol.h"
 #include "mib.h"
 =

@@ -1097,7 +1098,7 @@ int __mptcp_subflow_connect(struct sock *sk, const st=
ruct mptcp_addr_info *loc,
 	subflow->remote_token =3D remote_token;
 	subflow->local_id =3D local_id;
 	subflow->request_join =3D 1;
-	subflow->request_bkup =3D 1;
+	subflow->request_bkup =3D !!(loc->flags & MPTCP_PM_ADDR_FLAG_BACKUP);
 	mptcp_info2sockaddr(remote, &addr);
 =

 	err =3D kernel_connect(sf, (struct sockaddr *)&addr, addrlen, O_NONBLOCK);
-- =

2.26.2

--===============4204612787181721613==--
