Content-Type: multipart/mixed; boundary="===============8193702405731871545=="
MIME-Version: 1.0
From: Geliang Tang <geliangtang at gmail.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [MPTCP][PATCH v2 mptcp-next] Squash-to: "mptcp: remove addr
 and subflow in PM netlink v9" Part 2
Date: Thu, 17 Sep 2020 17:19:31 +0800
Message-ID: <57ece514d409fce62437ab651c91e48565376746.1600334143.git.geliangtang@gmail.com>
X-Status: 
X-Keywords:                  
X-UID: 5911

--===============8193702405731871545==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This patch fixed BUG in mptcp_pm_free_anno_list(). mptcp_pm_free_anno_list
may be called when PM has not been inited, then we'll get the "NULL pointer
dereference" BUG.

This patch moved __mptcp_init_sock call before the !mptcp_is_enabled()
check in mptcp_init_sock(). No matter mptcp is enabled or not, we all
called __mptcp_init_sock to init the mptcp socket.

Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/90
Signed-off-by: Geliang Tang <geliangtang(a)gmail.com>
---
 net/mptcp/protocol.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 5fe9bfc3c76f..5f9a073f3813 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1833,16 +1833,16 @@ static int mptcp_init_sock(struct sock *sk)
 	struct net *net =3D sock_net(sk);
 	int ret;
 =

+	ret =3D __mptcp_init_sock(sk);
+	if (ret)
+		return ret;
+
 	if (!mptcp_is_enabled(net))
 		return -ENOPROTOOPT;
 =

 	if (unlikely(!net->mib.mptcp_statistics) && !mptcp_mib_alloc(net))
 		return -ENOMEM;
 =

-	ret =3D __mptcp_init_sock(sk);
-	if (ret)
-		return ret;
-
 	ret =3D __mptcp_socket_create(mptcp_sk(sk));
 	if (ret)
 		return ret;
-- =

2.26.2

--===============8193702405731871545==--
