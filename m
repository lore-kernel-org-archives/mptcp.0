Content-Type: multipart/mixed; boundary="===============4075110214965004128=="
MIME-Version: 1.0
From: Dmitry Vyukov <dvyukov at google.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: general protection fault in sock_recvmsg
Date: Mon, 25 May 2020 12:13:44 +0200
Message-ID: <CACT4Y+YPRy0Yu2sSnoGyMFqXERoD9WKzKitdRBduhBTgD3GS+w@mail.gmail.com>
In-Reply-To: cba982dc5d280f43406200e3186b8bce76159617.camel@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 4478

--===============4075110214965004128==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Mon, May 25, 2020 at 12:02 PM Paolo Abeni <pabeni(a)redhat.com> wrote:
>
> On Mon, 2020-05-25 at 11:36 +0200, Dmitry Vyukov wrote:
> > On Mon, May 25, 2020 at 11:07 AM Paolo Abeni <pabeni(a)redhat.com> wrot=
e:
> > > #syz test: git://git.kernel.org/pub/scm/linux/kernel/git/davem/net.gi=
t master
> > >
> > > I don't easily see how we can reach sock_recvmsg() without first
> > > splatting on selinux_socket_recvmsg()
> >
> > This instance uses smack.
>
> Thank you for the prompt reply! Is that configuration somehow visible
> in the syzbot report? if so, where/how? (the only differences I see in
> .config are related to the used compiler).

Hi Paolo,

It's visible, but some implicitly and not officially.
On the dashboard you may see the Manager column:
https://syzkaller.appspot.com/bug?extid=3Dd7cface3f90b13edf5b0
for this crash it says "ci-upstream-kasan-gce-smack-root".
For other bugs you may also see "ci-upstream-kasan-gce-selinux-root".
But for some there is not lsm in the name, that's generally apparmour.
These instances use these command line presents:
https://github.com/google/syzkaller/blob/master/dashboard/config/upstream-s=
elinux.cmdline
https://github.com/google/syzkaller/blob/master/dashboard/config/upstream-s=
mack.cmdline
https://github.com/google/syzkaller/blob/master/dashboard/config/upstream-a=
pparmor.cmdline
--===============4075110214965004128==--
