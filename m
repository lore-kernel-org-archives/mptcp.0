Content-Type: multipart/mixed; boundary="===============5556493846339819958=="
MIME-Version: 1.0
From: Christoph Paasch <cpaasch at apple.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: BUG: KASAN: slab-out-of-bounds in
 subflow_ulp_init+0xa6/0x190
Date: Tue, 10 Mar 2020 13:45:49 -0700
Message-ID: <20200310204549.GB5362@MacBook-Pro-64.local>
In-Reply-To: 8e9ba8f08d0dde89bd35c4228c11439439406028.camel@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 3904

--===============5556493846339819958==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On 10/03/20 - 18:48:06, Paolo Abeni wrote:
> On Tue, 2020-03-10 at 09:15 -0700, Christoph Paasch wrote:
> > Should the following be correct?
> > =

> > r0 =3D socket$netlink(0x10, 0x3, 0x0)
> > r1 =3D syz_genetlink_get_family_id$mptcp(&(0x7f0000000100)=3D'mptcp_pm\=
x00')
> > sendmsg$MPTCP_PM_CMD_ADD_ADDR(r0, &(0x7f0000000200)=3D{0x0, 0x0,
> > &(0x7f00000001c0)=3D{&(0x7f0000000140)=3D{0x20, r1, 0x1, 0x0, 0x0, {0x1,
> > 0x2}, [@MPTCP_PM_ATTR_ADDR=3D{0xc, 0x1,
> > @MPTCP_PM_ADDR_ATTR_FAMILY=3D{0x5}}]}, 0x20}}, 0x0)
> =

> I'm unsure I parse correctly the syzkaller syntax... are you creating a
> NL attr, type nested, id MPTCP_PM_ATTR_ADDR, with a single nested
> attribute type uint8, id MPTCP_PM_ADDR_ATTR_FAMILY, value 5?
> =

> if so, than is correct ;)

Thanks! I might not be getting very far in the coverage because syzkaller is
not chaining a family followed by an address. I need to find out how to do
this.


Christoph

--===============5556493846339819958==--
