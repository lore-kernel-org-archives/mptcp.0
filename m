Content-Type: multipart/mixed; boundary="===============3159778672288659239=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: general protection fault in sock_recvmsg
Date: Mon, 25 May 2020 12:02:31 +0200
Message-ID: <cba982dc5d280f43406200e3186b8bce76159617.camel@redhat.com>
In-Reply-To: CACT4Y+Ya2K+h=TXQEdCUag9P2TcVQV5YP8rF7u+wTuar40SP4A@mail.gmail.com
X-Status: 
X-Keywords:                  
X-UID: 4477

--===============3159778672288659239==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Mon, 2020-05-25 at 11:36 +0200, Dmitry Vyukov wrote:
> On Mon, May 25, 2020 at 11:07 AM Paolo Abeni <pabeni(a)redhat.com> wrote:
> > #syz test: git://git.kernel.org/pub/scm/linux/kernel/git/davem/net.git =
master
> > =

> > I don't easily see how we can reach sock_recvmsg() without first
> > splatting on selinux_socket_recvmsg()
> =

> This instance uses smack.

Thank you for the prompt reply! Is that configuration somehow visible
in the syzbot report? if so, where/how? (the only differences I see in
.config are related to the used compiler).

Thanks!

Paolo

--===============3159778672288659239==--
