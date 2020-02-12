Content-Type: multipart/mixed; boundary="===============8368208090677179573=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [RFC PATCH 6/6] mptcp: add netlink based PM
Date: Wed, 12 Feb 2020 15:56:35 +0100
Message-ID: <d00f63f7aa40ed0f9f24240d7b3b75ce5c8e76c5.camel@redhat.com>
In-Reply-To: 20200212143319.GM2991@breakpoint.cc
X-Status: 
X-Keywords:                  
X-UID: 3630

--===============8368208090677179573==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Wed, 2020-02-12 at 15:33 +0100, Florian Westphal wrote:
> > +static const struct nla_policy mptcp_pm_addr_policy[MPTCP_PM_ADDR_ATTR=
_MAX + 1] =3D {
> > +	[MPTCP_PM_ADDR_ATTR_FAMILY]	=3D { .type	=3D NLA_U16,	},
> > +	[MPTCP_PM_ADDR_ATTR_ADDR4]	=3D { .type	=3D NLA_U32,	},
> > +	[MPTCP_PM_ADDR_ATTR_ADDR6]	=3D { .type	=3D NLA_BINARY,
> =

> 	NLA_EXACT_LEN?
> =

> NLA_BINARY is weird (it allows shorter sizes...).

yup, thanks! I'm diving into the netlink APIs for the first time ;)

Will fix in the next iteration.

Thanks,

Paolo

--===============8368208090677179573==--
