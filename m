Content-Type: multipart/mixed; boundary="===============4186942717725820828=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH v2] squash-to: "mptcp: add basic kselftest for
 mptcp"
Date: Fri, 13 Dec 2019 17:48:40 +0100
Message-ID: <e5d0d2e6682dc8d6b45fc8f597cf852d9c8a9de3.camel@redhat.com>
In-Reply-To: 7e3bd531e4e10878c9fb009595a4721d77c6993c.1576255051.git.dcaratti@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 2967

--===============4186942717725820828==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Fri, 2019-12-13 at 17:38 +0100, Davide Caratti wrote:
> checkpatch fixes
> =

> Signed-off-by: Davide Caratti <dcaratti(a)redhat.com>
> ---
>  .../selftests/net/mptcp/mptcp_connect.c       | 26 +++++++++----------
>  1 file changed, 12 insertions(+), 14 deletions(-)
> =

> diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect.c b/tools/te=
sting/selftests/net/mptcp/mptcp_connect.c
> index 8b8718e150d1..a3dccd816ae4 100644
> --- a/tools/testing/selftests/net/mptcp/mptcp_connect.c
> +++ b/tools/testing/selftests/net/mptcp/mptcp_connect.c
> @@ -71,7 +71,8 @@ static void xgetnameinfo(const struct sockaddr *addr, s=
ocklen_t addrlen,
>  			 char *serv, socklen_t servlen)
>  {
>  	int flags =3D NI_NUMERICHOST | NI_NUMERICSERV;
> -	int err =3D getnameinfo(addr, addrlen, host, hostlen, serv, servlen, fl=
ags);
> +	int err =3D getnameinfo(addr, addrlen, host, hostlen, serv, servlen,
> +			      flags);
>  =

>  	if (err) {
>  		const char *errstr =3D getxinfo_strerr(err);
> @@ -161,7 +162,6 @@ static int sock_listen_mptcp(const char * const liste=
naddr,
>  static bool sock_test_tcpulp(const char * const remoteaddr,
>  			     const char * const port)
>  {
> -
>  	struct addrinfo hints =3D {
>  		.ai_protocol =3D IPPROTO_TCP,
>  		.ai_socktype =3D SOCK_STREAM,
> @@ -281,11 +281,12 @@ static ssize_t do_rnd_read(const int fd, char *buf,=
 const size_t len)
>  =

>  static void set_nonblock(int fd)
>  {
> -        int flags =3D fcntl(fd, F_GETFL);
> -        if (flags =3D=3D -1)
> -                return;
> +	int flags =3D fcntl(fd, F_GETFL);
> +
> +	if (flags =3D=3D -1)
> +		return;
>  =

> -        fcntl(fd, F_SETFL, flags | O_NONBLOCK);
> +	fcntl(fd, F_SETFL, flags | O_NONBLOCK);
>  }
>  =

>  static int copyfd_io_poll(int infd, int peerfd, int outfd)
> @@ -478,7 +479,7 @@ static int do_sendfile(int infd, int outfd, unsigned =
int count)
>  }
>  =

>  static int copyfd_io_mmap(int infd, int peerfd, int outfd,
> -			      unsigned int size)
> +			  unsigned int size)
>  {
>  	int err;
>  =

> @@ -501,7 +502,6 @@ static int copyfd_io_mmap(int infd, int peerfd, int o=
utfd,
>  	return err;
>  }
>  =

> -
>  static int copyfd_io_sendfile(int infd, int peerfd, int outfd,
>  			      unsigned int size)
>  {
> @@ -575,11 +575,11 @@ static void check_sockaddr(int pf, struct sockaddr_=
storage *ss,
>  =

>  	if (salen !=3D wanted_size)
>  		fprintf(stderr, "accept: size mismatch, got %d expected %d\n",
> -				(int)salen, wanted_size);
> +			(int)salen, wanted_size);
>  =

>  	if (ss->ss_family !=3D pf)
>  		fprintf(stderr, "accept: pf mismatch, expect %d, ss_family is %d\n",
> -				(int)ss->ss_family, pf);
> +			(int)ss->ss_family, pf);
>  }
>  =

>  static void check_getpeername(int fd, struct sockaddr_storage *ss, sockl=
en_t salen)
> @@ -746,15 +746,13 @@ int parse_sndbuf(const char *size)
>  =

>  	if (errno) {
>  		fprintf(stderr, "Invalid sndbuf size %s (%s)\n",
> -				size,
> -				strerror(errno));
> +			size, strerror(errno));
>  		die_usage();
>  	}
>  =

>  	if (s > INT_MAX) {
>  		fprintf(stderr, "Invalid sndbuf size %s (%s)\n",
> -				size,
> -				strerror(ERANGE));
> +			size, strerror(ERANGE));
>  		die_usage();
>  	}
>  =


ACK!

/P

--===============4186942717725820828==--
