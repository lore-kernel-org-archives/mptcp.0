Content-Type: multipart/mixed; boundary="===============7278467368707417918=="
MIME-Version: 1.0
From: Florian Westphal <fw at strlen.de>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [RFC PATCH 09/12] mptcp: move address attribute into
 mptcp_addr_info
Date: Sun, 02 Aug 2020 01:22:22 +0200
Message-ID: <20200801232222.GH29169@breakpoint.cc>
In-Reply-To: 0bcf53173f0d86cd035f94e51226cc1a27998ac2.1596216310.git.pabeni@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 5427

--===============7278467368707417918==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Paolo Abeni <pabeni(a)redhat.com> wrote:
> diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
> index dfcd7eab35ad..5467eb1adebd 100644
> --- a/net/mptcp/protocol.h
> +++ b/net/mptcp/protocol.h
> @@ -140,6 +140,8 @@ struct mptcp_addr_info {
>  	sa_family_t		family;
>  	__be16			port;
>  	u8			id;
> +	unsigned int		flags;
> +	int			ifindex;

Nit: u8 flags?  There are only 3 so far AFAICS.
--===============7278467368707417918==--
