Content-Type: multipart/mixed; boundary="===============7034636788849794176=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: general protection fault in sock_recvmsg
Date: Mon, 25 May 2020 11:07:31 +0200
Message-ID: <f82cedb30d32f24f962360f96d7bef633792a401.camel@redhat.com>
In-Reply-To: 000000000000b5f39305a6705fd3@google.com
X-Status: 
X-Keywords:                  
X-UID: 4475

--===============7034636788849794176==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

#syz test: git://git.kernel.org/pub/scm/linux/kernel/git/davem/net.git mast=
er

I don't easily see how we can reach sock_recvmsg() without first
splatting on selinux_socket_recvmsg(), anyhow this really looks like a
duplicate of syzbot+c6bfc3db991edc918432(a)syzkaller.appspotmail.com.

Just be pedantic and check the same fix for both.

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
-               if (unlikely(__mptcp_tcp_fallback(msk)))
+               ssock =3D __mptcp_tcp_fallback(msk);
+               if (unlikely(ssock))
                        goto fallback;
        }
=20

--===============7034636788849794176==--
