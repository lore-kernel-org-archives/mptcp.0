Content-Type: multipart/mixed; boundary="===============0424003722388359069=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: WARNING in mptcp_reset_timer
Date: Wed, 18 Nov 2020 17:05:02 +0100
Message-ID: <567c4530b1cf5c387391b3527e08c5f2215dc8c0.camel@redhat.com>
In-Reply-To: 89d3320227621447393b2ad33890770b6b7711af.camel@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 6776

--===============0424003722388359069==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Wed, 2020-11-18 at 16:44 +0100, Paolo Abeni wrote:
> On Wed, 2020-11-18 at 02:59 -0800, syzbot wrote:
> > Hello,
> > =

> > syzbot found the following issue on:
> > =

> > HEAD commit:    7c8ca812 Add linux-next specific files for 20201117
> > git tree:       linux-next
> > console output: https://syzkaller.appspot.com/x/log.txt?x=3D14ccfce2500=
000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=3Dff4bc71371d=
c5b13
> > dashboard link: https://syzkaller.appspot.com/bug?extid=3D42aa53dafb66a=
07e5a24
> > compiler:       gcc (GCC) 10.1.0-syz 20200507
> > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=3D1342e36e5=
00000
> > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=3D17f29bba500=
000
> > =

> > IMPORTANT: if you fix the issue, please add the following tag to the co=
mmit:
> > Reported-by: syzbot+42aa53dafb66a07e5a24(a)syzkaller.appspotmail.com
> =

> #syz test: https://github.com/multipath-tcp/mptcp_net-next.git master

whooops... wrong git repo! Should be plain net-next instead. I'll
resend another reply for syzbot.

@syzbot team: you can stop whatever task my previous mail has
triggered, thanks!

I'm sorry for the waste of resources.

Paolo

--===============0424003722388359069==--
