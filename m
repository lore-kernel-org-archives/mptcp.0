Content-Type: multipart/mixed; boundary="===============6963573024783400187=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH mptcp-iproute2] mptcp: show all endpoints when no
 ID is specified
Date: Thu, 23 Jul 2020 08:13:12 -0700
Message-ID: <alpine.OSX.2.23.453.2007230812480.5636@mlemay-mobl.amr.corp.intel.com>
In-Reply-To: 20200713114609.251267-1-matthieu.baerts@tessares.net
X-Status: 
X-Keywords:                  
X-UID: 5249

--===============6963573024783400187==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Mon, 13 Jul 2020, Matthieu Baerts wrote:

> According to 'ip mptcp help', 'endpoint show' can accept no argument:
>
>  ip mptcp endpoint show [ id ID ]
>
> It makes sense to print all endpoints when no filter is used.
>
> So here if the following command is used, all endpoints are printed:
>
>  ip mptcp endpoint show
>
> Same as:
>
>  ip mptcp endpoint
>
> Fixes: 7e0767cd ("add support for mptcp netlink interface")
> Signed-off-by: Matthieu Baerts <matthieu.baerts(a)tessares.net>
> ---
> ip/ipmptcp.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/ip/ipmptcp.c b/ip/ipmptcp.c
> index bc12418b..e1ffafb3 100644
> --- a/ip/ipmptcp.c
> +++ b/ip/ipmptcp.c
> @@ -273,7 +273,7 @@ static int mptcp_addr_show(int argc, char **argv)
> 	struct nlmsghdr *answer;
> 	int ret;
>
> -	if (!argv)
> +	if (argc <=3D 0)
> 		return mptcp_addr_dump();
>
> 	ret =3D mptcp_parse_opt(argc, argv, &req.n, false);
> -- =

> 2.27.0

Looks good to send upstream, thanks Matthieu!

--
Mat Martineau
Intel
--===============6963573024783400187==--
