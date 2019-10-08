Content-Type: multipart/mixed; boundary="===============4358915324108711663=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH 2/2] selftests: test setsockopt(..., TCP_ULP,
 "mptcp", ...)
Date: Tue, 08 Oct 2019 22:21:27 +0200
Message-ID: <7cec08b00730e72fba12eb7839f1d3a075b96a4e.camel@redhat.com>
In-Reply-To: 8a320766-d38e-8073-b0e8-cc08ba256be3@tessares.net
X-Status: 
X-Keywords:                  
X-UID: 2060

--===============4358915324108711663==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Tue, 2019-10-08 at 17:00 +0200, Matthieu Baerts wrote:
> Hi Davide,
> =

> On 08/10/2019 16:43, Davide Caratti wrote:
> > add a selftest to verify that the kernel forbids attaching MPTCP subflo=
ws
> > to userspace TCP sockets with setsockopt(..., IPPROTO_TCP, TCP_ULP, ...=
).
> =

> Good idea to have a test for that!
> =

> > Signed-off-by: Davide Caratti <dcaratti(a)redhat.com>
> > ---
> >  .../selftests/net/mptcp/mptcp_connect.c       | 49 +++++++++++++++++--
> >  .../selftests/net/mptcp/mptcp_connect.sh      | 19 +++++++
> >  2 files changed, 65 insertions(+), 3 deletions(-)
> > =

> > diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect.c b/tools/=
testing/selftests/net/mptcp/mptcp_connect.c
> > index cac71f0ac8f8..12a722e0c527 100644
> > --- a/tools/testing/selftests/net/mptcp/mptcp_connect.c
> > +++ b/tools/testing/selftests/net/mptcp/mptcp_connect.c
> =

> [...]
> =

> > @@ -114,6 +116,41 @@ static int sock_listen_mptcp(const char * const li=
stenaddr,
> >  	return sock;
> >  }
> >  =

> > +static bool sock_test_tcpulp(const char * const remoteaddr,
> > +			     const char * const port)
> > +{
> > +
> > +	struct addrinfo hints =3D {
> > +		.ai_protocol =3D IPPROTO_TCP,
> > +		.ai_socktype =3D SOCK_STREAM,
> > +	};
> > +	struct addrinfo *a, *addr;
> > +	int sock =3D -1, ret =3D 0;
> > +	bool test_pass =3D false;
> > +
> > +	hints.ai_family =3D AF_INET;
> > +
> > +	xgetaddrinfo(remoteaddr, port, &hints, &addr);
> > +	for (a =3D addr; a; a =3D a->ai_next) {
> > +		sock =3D socket(a->ai_family, a->ai_socktype, IPPROTO_TCP);
> > +		if (sock < 0) {
> > +			perror("socket");
> =

> Why could we have an error here? It is just to avoid error message in
> the output for something we don't consider as an error.

It can fail e.g. due to memory pressure, or ulimits. Should never
happen in normal circumstances, but I think it's better to catch this
up, as this patch does.

> > +			continue;
> > +		}
> > +
> > +		ret =3D setsockopt(sock, IPPROTO_TCP, TCP_ULP, "mptcp",
> > +				 sizeof("mptcp"));
> > +		close(sock);
> > +		if (ret =3D=3D -1) {
> =

> Should we check errno as well? Just to be sure we are not "blocked" for
> another reason.

I agree additionally checking errno =3D=3D -EOPNOTSUPP would be better.

Otherwise LGTM.

In the longer run we may consider moving this test and ev. diag, MIB,
etc to a separate, functional-test binary/script, but I think this is
good for now.

Cheers,

Paolo

--===============4358915324108711663==--
