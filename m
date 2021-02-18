Content-Type: multipart/mixed; boundary="===============6482535787872490595=="
MIME-Version: 1.0
From: Dmitry Vyukov <dvyukov at google.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: possible deadlock in mptcp_push_pending
Date: Thu, 18 Feb 2021 15:04:02 +0100
Message-ID: <CACT4Y+b3nZ=SXbRo7FUV5BO4r1kyPyPSUXG9=TNWBtOzLRFa_g@mail.gmail.com>
In-Reply-To: 639082dd7bddce31122200cc0e587c482379d1a7.camel@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 7844

--===============6482535787872490595==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 18, 2021 at 1:41 PM Paolo Abeni <pabeni(a)redhat.com> wrote:
>
> On Wed, 2021-02-17 at 09:31 -0800, syzbot wrote:
> > syzbot found the following issue on:
> >
> > HEAD commit:    c48f8607 Merge branch 'PTP-for-DSA-tag_ocelot_8021q'
> > git tree:       net-next
> > console output: https://syzkaller.appspot.com/x/log.txt?x=3D16525cb0d00=
000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=3Ddbc1ca9e55d=
c1f9f
> > dashboard link: https://syzkaller.appspot.com/bug?extid=3Dd1b1723faccb7=
a43f6d1
> >
> > Unfortunately, I don't have any reproducer for this issue yet.
> >
> > IMPORTANT: if you fix the issue, please add the following tag to the co=
mmit:
> > Reported-by: syzbot+d1b1723faccb7a43f6d1(a)syzkaller.appspotmail.com
> >
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > WARNING: possible recursive locking detected
> > 5.11.0-rc7-syzkaller #0 Not tainted
> > --------------------------------------------
> > syz-executor.1/15600 is trying to acquire lock:
> > ffff888057303220 (sk_lock-AF_INET6){+.+.}-{0:0}, at: lock_sock include/=
net/sock.h:1598 [inline]
> > ffff888057303220 (sk_lock-AF_INET6){+.+.}-{0:0}, at: mptcp_push_pending=
+0x28b/0x650 net/mptcp/protocol.c:1466
>
> Even this one is suspected to be a dup of 'WARNING in dst_release': the
> subflow socket lock family is reported to be 'sk_lock-AF_INET6', but
> subflows are created in kernel, and get 'k-sk_lock-AF_INET6'. This
> looks like [re]use after free, likely via msk->first, as in the
> suspected dup issue. Lacking a repro, I'm not 110% sure.
>
> @Dmitry, I'm wondering which is the preferred course of action here:
> tentatively marking this one as a dup, or leaving it alone till we get
> a reproducer?

Hi Paolo,

I don't have a strong opinion. Either way will work, especially since
this seems to happen regularly. Or, submit a fix and wait to see if
this stops happening or not.
--===============6482535787872490595==--
