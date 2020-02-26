Content-Type: multipart/mixed; boundary="===============2064124147161446355=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH v4 7/9] mptcp: add netlink based PM
Date: Wed, 26 Feb 2020 12:36:47 +0100
Message-ID: <8096c62ca92b5ca5e16fc7caa3e60fedb2beb2fb.camel@redhat.com>
In-Reply-To: fda264ac4e8825c54ae893188f9b58563abab1ce.1582558805.git.pabeni@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 3809

--===============2064124147161446355==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Mon, 2020-02-24 at 16:51 +0100, Paolo Abeni wrote:
> +enum {
> +	MPTCP_PM_CMD_UNSPEC,
> +
> +	MPTCP_PM_CMD_ADD_ADDR,
> +	MPTCP_PM_CMD_DEL_ADDR,
> +	MPTCP_PM_CMD_GET_ADDR,
> +	MPTCP_PM_CMD_FLUSH_ADDRS,
> +	MPTCP_PM_CMD_SET_RCV_ADD_ADDRS,
> +	MPTCP_PM_CMD_GET_RCV_ADD_ADDRS,

To enforce the server subflow limits, the idea would be to change (in a
separated series) the above 2 commands to:
	MPTCP_PM_CMD_SET_LIMITS,
	MPTCP_PM_CMD_GET_LIMITS,

and add a new attribute for the max subflow limits

Plus the core infrastructure/hooks to let the PM really enforce such
limit.

WDYT?

Cheers,

Paolo

--===============2064124147161446355==--
