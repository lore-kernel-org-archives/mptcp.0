Content-Type: multipart/mixed; boundary="===============5547367619435349180=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH iproute2-next] mptcp: add support for port based
 endpoint
Date: Thu, 18 Feb 2021 18:04:46 -0800
Message-ID: <20f33013-56aa-cfda-f02a-a8512ae33836@linux.intel.com>
In-Reply-To: 868cfad6ab2fbd7f4b2ac6522b3ec62fce858fed.1613663358.git.pabeni@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 7855

--===============5547367619435349180==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Thu, 18 Feb 2021, Paolo Abeni wrote:

> The feature is supported by the kernel since 5.11-net-next,
> let's allow user-space to use it.
>
> Just parse and dump an additional, per endpoint, u16 attribute
>
> Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>
> ---

Built this and tried it out - works for me with latest export branch.


Mat


> ip/ipmptcp.c        | 16 ++++++++++++++--
> man/man8/ip-mptcp.8 |  8 ++++++++
> 2 files changed, 22 insertions(+), 2 deletions(-)
>
> diff --git a/ip/ipmptcp.c b/ip/ipmptcp.c
> index e1ffafb3..5f659b59 100644
> --- a/ip/ipmptcp.c
> +++ b/ip/ipmptcp.c
> @@ -17,7 +17,7 @@ static void usage(void)
> {
> 	fprintf(stderr,
> 		"Usage:	ip mptcp endpoint add ADDRESS [ dev NAME ] [ id ID ]\n"
> -		"				      [ FLAG-LIST ]\n"
> +		"				      [ port NR ] [ FLAG-LIST ]\n"
> 		"	ip mptcp endpoint delete id ID\n"
> 		"	ip mptcp endpoint show [ id ID ]\n"
> 		"	ip mptcp endpoint flush\n"
> @@ -97,6 +97,7 @@ static int mptcp_parse_opt(int argc, char **argv, struc=
t nlmsghdr *n,
> 	bool id_set =3D false;
> 	__u32 index =3D 0;
> 	__u32 flags =3D 0;
> +	__u16 port =3D 0;
> 	__u8 id =3D 0;
>
> 	ll_init_map(&rth);
> @@ -123,6 +124,10 @@ static int mptcp_parse_opt(int argc, char **argv, st=
ruct nlmsghdr *n,
> 			if (!index)
> 				invarg("device does not exist\n", ifname);
>
> +		} else if (matches(*argv, "port") =3D=3D 0) {
> +			NEXT_ARG();
> +			if (get_u16(&port, *argv, 0))
> +				invarg("expected port", *argv);
> 		} else if (get_addr(&address, *argv, AF_UNSPEC) =3D=3D 0) {
> 			addr_set =3D true;
> 		} else {
> @@ -145,6 +150,8 @@ static int mptcp_parse_opt(int argc, char **argv, str=
uct nlmsghdr *n,
> 		addattr32(n, MPTCP_BUFLEN, MPTCP_PM_ADDR_ATTR_FLAGS, flags);
> 	if (index)
> 		addattr32(n, MPTCP_BUFLEN, MPTCP_PM_ADDR_ATTR_IF_IDX, index);
> +	if (port)
> +		addattr16(n, MPTCP_BUFLEN, MPTCP_PM_ADDR_ATTR_PORT, port);
> 	if (addr_set) {
> 		int type;
>
> @@ -181,8 +188,8 @@ static int print_mptcp_addrinfo(struct rtattr *addrin=
fo)
> 	__u8 family =3D AF_UNSPEC, addr_attr_type;
> 	const char *ifname;
> 	unsigned int flags;
> +	__u16 id, port;
> 	int index;
> -	__u16 id;
>
> 	parse_rtattr_nested(tb, MPTCP_PM_ADDR_ATTR_MAX, addrinfo);
>
> @@ -196,6 +203,11 @@ static int print_mptcp_addrinfo(struct rtattr *addri=
nfo)
> 		print_string(PRINT_ANY, "address", "%s ",
> 			     format_host_rta(family, tb[addr_attr_type]));
> 	}
> +	if (tb[MPTCP_PM_ADDR_ATTR_PORT]) {
> +		port =3D rta_getattr_u16(tb[MPTCP_PM_ADDR_ATTR_PORT]);
> +		if (port)
> +			print_uint(PRINT_ANY, "port", "port %u ", port);
> +	}
> 	if (tb[MPTCP_PM_ADDR_ATTR_ID]) {
> 		id =3D rta_getattr_u8(tb[MPTCP_PM_ADDR_ATTR_ID]);
> 		print_uint(PRINT_ANY, "id", "id %u ", id);
> diff --git a/man/man8/ip-mptcp.8 b/man/man8/ip-mptcp.8
> index ef8409ea..98cb93b9 100644
> --- a/man/man8/ip-mptcp.8
> +++ b/man/man8/ip-mptcp.8
> @@ -20,6 +20,8 @@ ip-mptcp \- MPTCP path manager configuration
> .ti -8
> .BR "ip mptcp endpoint add "
> .IR IFADDR
> +.RB "[ " port
> +.IR PORT " ]"
> .RB "[ " dev
> .IR IFNAME " ]"
> .RB "[ " id
> @@ -87,6 +89,12 @@ ip mptcp endpoint flush	flush all existing MPTCP endpo=
ints
> .TE
>
> .TP
> +.IR PORT
> +When a port number is specified, incoming MPTCP subflows for already
> +established MPTCP sockets will be accepted on the specified port, regard=
less
> +the original listener port accepting the first MPTCP subflow and/or
> +this peer being actually on the client side.
> +
> .IR ID
> is a unique numeric identifier for the given endpoint
>
> -- =

> 2.26.2
> _______________________________________________
> mptcp mailing list -- mptcp(a)lists.01.org
> To unsubscribe send an email to mptcp-leave(a)lists.01.org
>

--
Mat Martineau
Intel
--===============5547367619435349180==--
