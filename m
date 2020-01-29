Content-Type: multipart/mixed; boundary="===============8525937692699390913=="
MIME-Version: 1.0
From: Geert Uytterhoeven <geert at linux-m68k.org>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH] mptcp: Fix incorrect IPV6 dependency check
Date: Wed, 29 Jan 2020 19:01:17 +0100
Message-ID: <20200129180117.545-1-geert@linux-m68k.org>
X-Status: 
X-Keywords:                  
X-UID: 3553

--===============8525937692699390913==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

If CONFIG_MPTCP=3Dy, CONFIG_MPTCP_IPV6=3Dn, and CONFIG_IPV6=3Dm:

    net/mptcp/protocol.o: In function `__mptcp_tcp_fallback':
    protocol.c:(.text+0x786): undefined reference to `inet6_stream_ops'

Fix this by checking for CONFIG_MPTCP_IPV6 instead of CONFIG_IPV6, like
is done in all other places in the mptcp code.

Fixes: 8ab183deb26a3b79 ("mptcp: cope with later TCP fallback")
Signed-off-by: Geert Uytterhoeven <geert(a)linux-m68k.org>
---
 net/mptcp/protocol.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 39fdca79ce90137e..096dfd1074540c8a 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -28,7 +28,7 @@ static void __mptcp_close(struct sock *sk, long timeout);
 =

 static const struct proto_ops *tcp_proto_ops(struct sock *sk)
 {
-#if IS_ENABLED(CONFIG_IPV6)
+#if IS_ENABLED(CONFIG_MPTCP_IPV6)
 	if (sk->sk_family =3D=3D AF_INET6)
 		return &inet6_stream_ops;
 #endif
-- =

2.17.1

--===============8525937692699390913==--
