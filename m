Content-Type: multipart/mixed; boundary="===============8321301350476500751=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH 2/2] selftests: test setsockopt(..., TCP_ULP,
 "mptcp", ...)
Date: Tue, 08 Oct 2019 17:00:03 +0200
Message-ID: <8a320766-d38e-8073-b0e8-cc08ba256be3@tessares.net>
In-Reply-To: bcf0f12a631a334f98e59a5b9302695db4854066.1570545679.git.dcaratti@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 2053

--===============8321301350476500751==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Davide,

On 08/10/2019 16:43, Davide Caratti wrote:
> add a selftest to verify that the kernel forbids attaching MPTCP subflows
> to userspace TCP sockets with setsockopt(..., IPPROTO_TCP, TCP_ULP, ...).

Good idea to have a test for that!

> Signed-off-by: Davide Caratti <dcaratti(a)redhat.com>
> ---
>  .../selftests/net/mptcp/mptcp_connect.c       | 49 +++++++++++++++++--
>  .../selftests/net/mptcp/mptcp_connect.sh      | 19 +++++++
>  2 files changed, 65 insertions(+), 3 deletions(-)
> =

> diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect.c b/tools/te=
sting/selftests/net/mptcp/mptcp_connect.c
> index cac71f0ac8f8..12a722e0c527 100644
> --- a/tools/testing/selftests/net/mptcp/mptcp_connect.c
> +++ b/tools/testing/selftests/net/mptcp/mptcp_connect.c

[...]

> @@ -114,6 +116,41 @@ static int sock_listen_mptcp(const char * const list=
enaddr,
>  	return sock;
>  }
>  =

> +static bool sock_test_tcpulp(const char * const remoteaddr,
> +			     const char * const port)
> +{
> +
> +	struct addrinfo hints =3D {
> +		.ai_protocol =3D IPPROTO_TCP,
> +		.ai_socktype =3D SOCK_STREAM,
> +	};
> +	struct addrinfo *a, *addr;
> +	int sock =3D -1, ret =3D 0;
> +	bool test_pass =3D false;
> +
> +	hints.ai_family =3D AF_INET;
> +
> +	xgetaddrinfo(remoteaddr, port, &hints, &addr);
> +	for (a =3D addr; a; a =3D a->ai_next) {
> +		sock =3D socket(a->ai_family, a->ai_socktype, IPPROTO_TCP);
> +		if (sock < 0) {
> +			perror("socket");

Why could we have an error here? It is just to avoid error message in
the output for something we don't consider as an error.

> +			continue;
> +		}
> +
> +		ret =3D setsockopt(sock, IPPROTO_TCP, TCP_ULP, "mptcp",
> +				 sizeof("mptcp"));
> +		close(sock);
> +		if (ret =3D=3D -1) {

Should we check errno as well? Just to be sure we are not "blocked" for
another reason.

> +			test_pass =3D true;
> +			break;
> +		}
> +
> +		perror("setsockopt(TCP_ULP)");
> +	}
> +	return test_pass;
> +}
> +
>  static int sock_connect_mptcp(const char * const remoteaddr,
>  			      const char * const port, int proto)
>  {

Cheers,
Matt
-- =

Matthieu Baerts | R&D Engineer
matthieu.baerts(a)tessares.net
Tessares SA | Hybrid Access Solutions
www.tessares.net
1 Avenue Jean Monnet, 1348 Louvain-la-Neuve, Belgium
--===============8321301350476500751==--
