Content-Type: multipart/mixed; boundary="===============2562235273042322104=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH net-next 10/13] mptcp: allow creating non-backup
 subflows
Date: Fri, 11 Sep 2020 15:52:05 +0200
Message-ID: <c85687bfad852a7d23ba52b96cbb1b7dc85c3b2a.1599832097.git.pabeni@redhat.com>
In-Reply-To: cover.1599832097.git.pabeni@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 5817

--===============2562235273042322104==
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
index 9edcce21715b..58f2349930a5 100644
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

@@ -1090,7 +1091,7 @@ int __mptcp_subflow_connect(struct sock *sk, const st=
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

--===============2562235273042322104==--
