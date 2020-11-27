Content-Type: multipart/mixed; boundary="===============1692484948986582689=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: Address ID assignment in netlink PM
Date: Fri, 27 Nov 2020 17:18:23 +0100
Message-ID: <2897e20eaa066829586e55846c96ab199bb1baa3.camel@redhat.com>
In-Reply-To: e8943d8b731245c5952890dec805fa65@intel.com
X-Status: 
X-Keywords:                  
X-UID: 6966

--===============1692484948986582689==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Wed, 2020-11-25 at 21:48 +0000, Othman, Ossama wrote:
> Hi Paolo,
> =

> While debugging a netlink PM "get addr" issue I was having in mptcpd
> I found that the address ID assigned by mptcpd was being overridden
> by the kernel.  Based on the code in pm_nl_ctl.c in the MPTCP self
> tests, and the code in pm_netlink.c in the kernel, the
> MPTCP_PM_CMD_ADD_ADDR command accepts an optional address ID
> attribute.  When that attribute is available the ID is stored in the
> corresponding mptcp_pm_addr_entry instance by mptcp_pm_parse_addr():
> =

> 	if (tb[MPTCP_PM_ADDR_ATTR_ID])
> 		entry->addr.id =3D nla_get_u8(tb[MPTCP_PM_ADDR_ATTR_ID]);
> =

> However, that value is later overridden in mptcp_pm_nl_append_new_local_a=
ddr():
> =

> 	entry->addr.id =3D pernet->next_id++;
> =

> That causes the userspace to lose track of an address it added with a
> specific ID, at which point the only way to find out the new ID is to
> dump the addrs to find the new ID corresponding to local address in
> question.  Is this the intended behavior?  =


This is indended. In the current status 'id' is used only for endpoint
selection while dumping (IIRC).

The 'id' override allows for very easy book-keeping on the kernel side,
otherwise we would need something more complex (alike IDR) to keep
track of IDs usage.

> It seems like userspace- and kernel-based address ID assignment
> should be mutually exclusive.  Otherwise we run into this sort of
> scenario.  Is there a need for the kernel to assign IDs in the
> netlink PM case?

Not really, it was just to keep the kernel-side implementation easy.
Since need arise, we can as well swap to a more complete/complex
schema.

I just filed:

https://github.com/multipath-tcp/mptcp_net-next/issues/117

for that. Any volonteer willing to pick the task more than welcome!

Cheers,

Paolo




--===============1692484948986582689==--
