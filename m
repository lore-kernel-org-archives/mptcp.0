Content-Type: multipart/mixed; boundary="===============4628980627100090767=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: INFO: task hung in lock_sock_nested (3)
Date: Mon, 05 Oct 2020 16:29:28 +0200
Message-ID: <4404dbb2e925c97518f2aa1c828a7392e916e012.camel@redhat.com>
In-Reply-To: CACT4Y+ba4LROZp8pCS6qh49gs-=GevgLrSbzdK7yCQ2nCh3sgA@mail.gmail.com
X-Status: 
X-Keywords:                  
X-UID: 6202

--===============4628980627100090767==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, 2020-10-05 at 15:21 +0200, Dmitry Vyukov wrote:
> On Mon, Oct 5, 2020 at 3:17 PM Paolo Abeni <pabeni(a)redhat.com> wrote:
> > On Fri, 2020-10-02 at 08:48 -0700, syzbot wrote:
> > > Hello,
> > > =

> > > syzbot found the following issue on:
> > > =

> > > HEAD commit:    87d5034d Merge tag 'mlx5-updates-2020-09-30' of git:/=
/git...
> > > git tree:       net-next
> > > console output: https://syzkaller.appspot.com/x/log.txt?x=3D1377fb379=
00000
> > > kernel config:  https://syzkaller.appspot.com/x/.config?x=3D7b5cc8ec2=
218e99d
> > > dashboard link: https://syzkaller.appspot.com/bug?extid=3Dfcf8ca5817d=
6e92c6567
> > > compiler:       gcc (GCC) 10.1.0-syz 20200507
> > > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=3D1456626=
7900000
> > > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=3D14458a4d9=
00000
> > > =

> > > The issue was bisected to:
> > > =

> > > commit ab174ad8ef76276cadfdae98731d31797d265927
> > > Author: Paolo Abeni <pabeni(a)redhat.com>
> > > Date:   Mon Sep 14 08:01:12 2020 +0000
> > > =

> > >     mptcp: move ooo skbs into msk out of order queue.
> > > =

> > =

> > I can't easily reproduce the issue with the above c repro. I think it's
> > just a matter of timing - slower CPU will make the races harder to
> > reproduce right? Can I expect/hope more success with the syz-repro
> > instead? I'm asking beforehands because the local setup is less
> > immediate for that one.
> =

> Hard to say. Maybe.
> That would be syz-execprog that replays syzkaller programs.

Thank you for the kind and prompt reply - as usual ;)

My guess/hope is based on the fact that some race-based bugs discovered
by syzkaller have only syz-execprog repro, with no c-repro.

I'm using (so far without success):

syz-execprog --threaded=3Dtrue --repeat=3D0 --procs=3D6 --fault_call=3D-1 -=
-enable=3Dtun,net_dev,close_fds -sandbox=3Dnone ./repro.syz

the syz repro also contains a "segv":true annotation which I could not
map to 'syz-execprog' command line arguments. Is there any automated
way to do such mapping?

Thanks!

Paolo

--===============4628980627100090767==--
