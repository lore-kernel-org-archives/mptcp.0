Content-Type: multipart/mixed; boundary="===============2393444051654994551=="
MIME-Version: 1.0
From: Florian Westphal <fw at strlen.de>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [RFC PATCH 6/6] mptcp: add netlink based PM
Date: Wed, 12 Feb 2020 15:33:19 +0100
Message-ID: <20200212143319.GM2991@breakpoint.cc>
In-Reply-To: 88c03932daa25595c8507dbfc1166328e8fb7941.1581444138.git.pabeni@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 3628

--===============2393444051654994551==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Paolo Abeni <pabeni(a)redhat.com> wrote:
> Expose to U/S a netlink family to control the PM, setting:
> =

>  - list of local addresses to be signaled.
>  - list of local addresses used to created subflows.
>  - maximum number of add_addr option to react
> =

> When the msk is fully established, the PM netlink attempts to
> create subflow for each addr in 'local' list, waiting for each
> connection to be completed before attempting the next one.
> =

> After exausting the 'local' list, the PM tries to announce the
> 'signal' list via the ADD_ADDR option. Since we currenlty lack
> the ADD_ADDR echo (and related event) only the first addr is sent.

> Idea is to add an additional PM hook for ADD_ADDR echo, to allow
> the PM netlink announcing multiple addresses, in sequence.

Makes sense, thanks!

> +static const struct nla_policy mptcp_pm_addr_policy[MPTCP_PM_ADDR_ATTR_M=
AX + 1] =3D {
> +	[MPTCP_PM_ADDR_ATTR_FAMILY]	=3D { .type	=3D NLA_U16,	},
> +	[MPTCP_PM_ADDR_ATTR_ADDR4]	=3D { .type	=3D NLA_U32,	},
> +	[MPTCP_PM_ADDR_ATTR_ADDR6]	=3D { .type	=3D NLA_BINARY,

	NLA_EXACT_LEN?

NLA_BINARY is weird (it allows shorter sizes...).
--===============2393444051654994551==--
