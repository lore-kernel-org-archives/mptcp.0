Content-Type: multipart/mixed; boundary="===============2325030462774246329=="
MIME-Version: 1.0
From: Dmitry Vyukov <dvyukov at google.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: INFO: task hung in lock_sock_nested (3)
Date: Fri, 09 Oct 2020 15:23:14 +0200
Message-ID: <CACT4Y+YodEDgAT2eogOL6VsWx5CAyKTD+HLTeT+Sn3z9pkLvDQ@mail.gmail.com>
In-Reply-To: 4404dbb2e925c97518f2aa1c828a7392e916e012.camel@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 6270

--===============2325030462774246329==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 5, 2020 at 4:29 PM Paolo Abeni <pabeni(a)redhat.com> wrote:
>
> Hi,
>
> On Mon, 2020-10-05 at 15:21 +0200, Dmitry Vyukov wrote:
> > On Mon, Oct 5, 2020 at 3:17 PM Paolo Abeni <pabeni(a)redhat.com> wrote:
> > > On Fri, 2020-10-02 at 08:48 -0700, syzbot wrote:
> > > > Hello,
> > > >
> > > > syzbot found the following issue on:
> > > >
> > > > HEAD commit:    87d5034d Merge tag 'mlx5-updates-2020-09-30' of git=
://git...
> > > > git tree:       net-next
> > > > console output: https://syzkaller.appspot.com/x/log.txt?x=3D1377fb3=
7900000
> > > > kernel config:  https://syzkaller.appspot.com/x/.config?x=3D7b5cc8e=
c2218e99d
> > > > dashboard link: https://syzkaller.appspot.com/bug?extid=3Dfcf8ca581=
7d6e92c6567
> > > > compiler:       gcc (GCC) 10.1.0-syz 20200507
> > > > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=3D14566=
267900000
> > > > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=3D14458a4=
d900000
> > > >
> > > > The issue was bisected to:
> > > >
> > > > commit ab174ad8ef76276cadfdae98731d31797d265927
> > > > Author: Paolo Abeni <pabeni(a)redhat.com>
> > > > Date:   Mon Sep 14 08:01:12 2020 +0000
> > > >
> > > >     mptcp: move ooo skbs into msk out of order queue.
> > > >
> > >
> > > I can't easily reproduce the issue with the above c repro. I think it=
's
> > > just a matter of timing - slower CPU will make the races harder to
> > > reproduce right? Can I expect/hope more success with the syz-repro
> > > instead? I'm asking beforehands because the local setup is less
> > > immediate for that one.
> >
> > Hard to say. Maybe.
> > That would be syz-execprog that replays syzkaller programs.
>
> Thank you for the kind and prompt reply - as usual ;)
>
> My guess/hope is based on the fact that some race-based bugs discovered
> by syzkaller have only syz-execprog repro, with no c-repro.
>
> I'm using (so far without success):
>
> syz-execprog --threaded=3Dtrue --repeat=3D0 --procs=3D6 --fault_call=3D-1=
 --enable=3Dtun,net_dev,close_fds -sandbox=3Dnone ./repro.syz
>
> the syz repro also contains a "segv":true annotation which I could not
> map to 'syz-execprog' command line arguments. Is there any automated
> way to do such mapping?

This should be about right.

Some of these flags are the default, so this can be reduced to:
syz-execprog --repeat=3D0 --procs=3D6 ./repro.syz

But I see you still weren't able to reproduce it.
Looking at the comment in the patch, may it be because it's hard to
trigger race condition?

Anyway, I think restoring to syzbot testing in such cases is the
easiest solution.
--===============2325030462774246329==--
