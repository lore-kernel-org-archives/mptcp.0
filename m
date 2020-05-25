Content-Type: multipart/mixed; boundary="===============4161024553262692050=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: general protection fault in selinux_socket_recvmsg
Date: Mon, 25 May 2020 10:58:46 +0200
Message-ID: <724312f087f459f0318e3edb862e415b3e8b94f6.camel@redhat.com>
In-Reply-To: 000000000000a1a76d05a668ccbb@google.com
X-Status: 
X-Keywords:                  
X-UID: 4474

--===============4161024553262692050==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

#syz test: git://git.kernel.org/pub/scm/linux/kernel/git/davem/net.git mast=
er

---
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 1f52a0fa31ed..69b66423305b 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -954,7 +954,8 @@ static int mptcp_recvmsg(struct sock *sk, struct msghdr=
 *msg, size_t len,
 =

 		pr_debug("block timeout %ld", timeo);
 		mptcp_wait_data(sk, &timeo);
-		if (unlikely(__mptcp_tcp_fallback(msk)))
+		ssock =3D __mptcp_tcp_fallback(msk);
+		if (unlikely(ssock))
 			goto fallback;
 	}
=20

--===============4161024553262692050==--
