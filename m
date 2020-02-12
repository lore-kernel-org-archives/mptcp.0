Content-Type: multipart/mixed; boundary="===============6991243785498105147=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [RFC PATCH 6/6] mptcp: add netlink based PM
Date: Wed, 12 Feb 2020 11:21:54 +0100
Message-ID: <43a4d59d6ce25cac0638c0cc5f825e16819135d2.camel@redhat.com>
In-Reply-To: 88c03932daa25595c8507dbfc1166328e8fb7941.1581444138.git.pabeni@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 3625

--===============6991243785498105147==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Tue, 2020-02-11 at 19:12 +0100, Paolo Abeni wrote:
> +/*
> + * ATTR types defined for MPTCP
> + */
> +enum mptcp_pm_attrs {
> +	MPTCP_PM_ATTR_UNSPEC,
> +
> +	MPTCP_PM_ATTR_ADDR_LIST,			/* nested list */
> +	MPTCP_PM_ATTR_ADD_ADDR_MAX,			/* u32 */
> +
> +	__MPTCP_PM_ATTR_MAX
> +};
> +
> +#define MPTCP_PM_ATTR_MAX (__MPTCP_PM_ATTR_MAX - 1)
> +
> +enum mptcp_pm_addr_addrs {
> +	MPTCP_PM_ADDR_ATTR_UNSPEC,
> +
> +	MPTCP_PM_ADDR_ATTR_FAMILY,			/* u16 */
> +	MPTCP_PM_ADDR_ATTR_ADDR4,			/* u32 */
> +	MPTCP_PM_ADDR_ATTR_ADDR6,			/* struct in6_addr */
> +
> +	__MPTCP_PM_ADDR_ATTR_MAX
> +};
> +
> +#define MPTCP_PM_ADDR_ATTR_MAX (__MPTCP_PM_ADDR_ATTR_MAX - 1)
> +
> +enum {
> +	MPTCP_CMD_UNSPEC,
> +
> +	MPTCP_CMD_NS_SIGNAL,
> +	MPTCP_CMD_NS_LOCAL,
> +	MPTCP_CMD_NS_ADD_ADDR_MAX,

Starting the self-test implementation, I noticed changing the above ABI
a bit would make things simpler:

instead of MPTCP_CMD_NS_SIGNAL,

	MPTCP_CMD_SIGNAL_ADD // adds a single addr to the 'signal' list

	MPTCP_CMD_SIGNAL_DEL // remote an address from 'signal' list
				by id
	MPTCP_CMD_SIGNAL_GET	// 'doit' get a single address from =

				//	list, by id
				// 'dumpit' dump the whole list. =

 	MPTCP_CMD_SIGNAL_FLUSH	// remove all addresses from 'signal'
				// list

And similar changes for 'MPTCP_CMD_NS_LOCAL'
Also, I'dd an additional addr MPTCP_PM_ADDR_ATTR_ID =


Any feedback welcome!

Thanks,

Paolo

--===============6991243785498105147==--
