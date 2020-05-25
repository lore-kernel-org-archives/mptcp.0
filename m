Content-Type: multipart/mixed; boundary="===============8453272375810037052=="
MIME-Version: 1.0
From: Dmitry Vyukov <dvyukov at google.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: general protection fault in sock_recvmsg
Date: Mon, 25 May 2020 11:36:07 +0200
Message-ID: <CACT4Y+Ya2K+h=TXQEdCUag9P2TcVQV5YP8rF7u+wTuar40SP4A@mail.gmail.com>
In-Reply-To: f82cedb30d32f24f962360f96d7bef633792a401.camel@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 4476

--===============8453272375810037052==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Mon, May 25, 2020 at 11:07 AM Paolo Abeni <pabeni(a)redhat.com> wrote:
>
> #syz test: git://git.kernel.org/pub/scm/linux/kernel/git/davem/net.git ma=
ster
>
> I don't easily see how we can reach sock_recvmsg() without first
> splatting on selinux_socket_recvmsg()

This instance uses smack.

>, anyhow this really looks like a
> duplicate of syzbot+c6bfc3db991edc918432(a)syzkaller.appspotmail.com.
>
> Just be pedantic and check the same fix for both.
>
> ---
> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index 1f52a0fa31ed..69b66423305b 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -954,7 +954,8 @@ static int mptcp_recvmsg(struct sock *sk, struct msgh=
dr *msg, size_t len,
>
>                 pr_debug("block timeout %ld", timeo);
>                 mptcp_wait_data(sk, &timeo);
> -               if (unlikely(__mptcp_tcp_fallback(msk)))
> +               ssock =3D __mptcp_tcp_fallback(msk);
> +               if (unlikely(ssock))
>                         goto fallback;
>         }
>
>
> --
> You received this message because you are subscribed to the Google Groups=
 "syzkaller-bugs" group.
> To unsubscribe from this group and stop receiving emails from it, send an=
 email to syzkaller-bugs+unsubscribe(a)googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgi=
d/syzkaller-bugs/f82cedb30d32f24f962360f96d7bef633792a401.camel%40redhat.co=
m.
--===============8453272375810037052==--
