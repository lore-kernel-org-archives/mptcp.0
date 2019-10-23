Content-Type: multipart/mixed; boundary="===============1888554429242988887=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH v3 2/7] selftests: mptcp: add accept/getpeer checks
Date: Wed, 23 Oct 2019 15:15:16 -0700
Message-ID: <alpine.OSX.2.21.1910231503070.37761@rjszuste-mobl.amr.corp.intel.com>
In-Reply-To: 20191023131325.18895-3-fw@strlen.de
X-Status: 
X-Keywords:                  
X-UID: 2299

--===============1888554429242988887==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable


On Wed, 23 Oct 2019, Florian Westphal wrote:

> Check that the result coming from accept matches that of getpeername.
> For initiator side, check getpeername matches address passed to connect().
>
> At this time, kernel returns the address of the first subflow in the list.
> Right now, we do not yet implement fate-sharing, i.e. if the original
> subflow goes away, the result of getpeername would change.
>
> There are different ways to fix that.  One would be to copy the quadruple
> from the first subflow socket to the mptcp socket.
>
> If we do that, this test should catch a possible bug (such as accidental
> reversal of saddr/daddr).
>
> Signed-off-by: Florian Westphal <fw(a)strlen.de>
> ---
> .../selftests/net/mptcp/mptcp_connect.c       | 107 ++++++++++++++++++
> 1 file changed, 107 insertions(+)
>
> diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect.c b/tools/te=
sting/selftests/net/mptcp/mptcp_connect.c
> index 987a8411756e..c9738a8dcc7f 100644
> --- a/tools/testing/selftests/net/mptcp/mptcp_connect.c
> +++ b/tools/testing/selftests/net/mptcp/mptcp_connect.c
> @@ -54,6 +54,21 @@ static const char *getxinfo_strerr(int err)
> 	return gai_strerror(err);
> }
>
> +static void xgetnameinfo(const struct sockaddr *addr, socklen_t addrlen,
> +			 char *host, socklen_t hostlen,
> +			 char *serv, socklen_t servlen)
> +{
> +	int flags =3D NI_NUMERICHOST | NI_NUMERICSERV;
> +	int err =3D getnameinfo(addr, addrlen, host, hostlen, serv, servlen, fl=
ags);
> +
> +	if (err) {
> +		const char *errstr =3D getxinfo_strerr(err);
> +
> +		fprintf(stderr, "Fatal: getnameinfo: %s\n", errstr);
> +		exit(1);
> +	}
> +}
> +
> static void xgetaddrinfo(const char *node, const char *service,
> 			 const struct addrinfo *hints,
> 			 struct addrinfo **res)
> @@ -327,6 +342,94 @@ static int copyfd_io(int infd, int peerfd, int outfd)
> 	return 0;
> }
>
> +static void check_sockaddr(int pf, struct sockaddr_storage *ss,
> +			   socklen_t salen)
> +{
> +	char addr[INET6_ADDRSTRLEN];
> +	char serv[INET6_ADDRSTRLEN];

addr and serv are not used and cause a compile warning.

The rest of the patch looks good to me.

--
Mat Martineau
Intel
--===============1888554429242988887==--
