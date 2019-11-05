Content-Type: multipart/mixed; boundary="===============2159189597920720270=="
MIME-Version: 1.0
From: Peter Krystad <peter.krystad at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH 2/5] mptcp: Switch to CONFIG_MPTCP_IPV6
Date: Tue, 05 Nov 2019 11:05:54 -0800
Message-ID: <20191105190557.6405-2-peter.krystad@linux.intel.com>
In-Reply-To: 20191105190557.6405-1-peter.krystad@linux.intel.com
X-Status: 
X-Keywords:                  
X-UID: 2402

--===============2159189597920720270==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

squashto: Add handling of outgoing MP_JOIN requests

Signed-off-by: Peter Krystad <peter.krystad(a)linux.intel.com>
---
 net/mptcp/subflow.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index 7bae7c35ea6b..704dfc49f0d5 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -646,7 +646,7 @@ int mptcp_subflow_connect(struct sock *sk, struct socka=
ddr *local,
 	release_sock(sk);
 =

 	addrlen =3D sizeof(struct sockaddr_in);
-#if IS_ENABLED(CONFIG_IPV6)
+#if IS_ENABLED(CONFIG_MPTCP_IPV6)
 	if (local->sa_family =3D=3D AF_INET6)
 		addrlen =3D sizeof(struct sockaddr_in6);
 #endif
-- =

2.17.2

--===============2159189597920720270==--
