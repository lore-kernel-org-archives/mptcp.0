Content-Type: multipart/mixed; boundary="===============7749556427685610612=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: possible deadlock in mptcp_push_pending
Date: Thu, 18 Feb 2021 13:41:44 +0100
Message-ID: <639082dd7bddce31122200cc0e587c482379d1a7.camel@redhat.com>
In-Reply-To: 000000000000787b8805bb8b96ce@google.com
X-Status: 
X-Keywords:                  
X-UID: 7842

--===============7749556427685610612==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Wed, 2021-02-17 at 09:31 -0800, syzbot wrote:
> syzbot found the following issue on:
> =

> HEAD commit:    c48f8607 Merge branch 'PTP-for-DSA-tag_ocelot_8021q'
> git tree:       net-next
> console output: https://syzkaller.appspot.com/x/log.txt?x=3D16525cb0d00000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=3Ddbc1ca9e55dc1=
f9f
> dashboard link: https://syzkaller.appspot.com/bug?extid=3Dd1b1723faccb7a4=
3f6d1
> =

> Unfortunately, I don't have any reproducer for this issue yet.
> =

> IMPORTANT: if you fix the issue, please add the following tag to the comm=
it:
> Reported-by: syzbot+d1b1723faccb7a43f6d1(a)syzkaller.appspotmail.com
> =

> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> WARNING: possible recursive locking detected
> 5.11.0-rc7-syzkaller #0 Not tainted
> --------------------------------------------
> syz-executor.1/15600 is trying to acquire lock:
> ffff888057303220 (sk_lock-AF_INET6){+.+.}-{0:0}, at: lock_sock include/ne=
t/sock.h:1598 [inline]
> ffff888057303220 (sk_lock-AF_INET6){+.+.}-{0:0}, at: mptcp_push_pending+0=
x28b/0x650 net/mptcp/protocol.c:1466

Even this one is suspected to be a dup of 'WARNING in dst_release': the
subflow socket lock family is reported to be 'sk_lock-AF_INET6', but
subflows are created in kernel, and get 'k-sk_lock-AF_INET6'. This
looks like [re]use after free, likely via msk->first, as in the
suspected dup issue. Lacking a repro, I'm not 110% sure.

@Dmitry, I'm wondering which is the preferred course of action here:
tentatively marking this one as a dup, or leaving it alone till we get
a reproducer?

Thanks!

Paolo

--===============7749556427685610612==--
