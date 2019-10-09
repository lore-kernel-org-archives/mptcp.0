Content-Type: multipart/mixed; boundary="===============7427398768503671279=="
MIME-Version: 1.0
From: Davide Caratti <dcaratti at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH 2/2] selftests: test setsockopt(..., TCP_ULP,
 "mptcp", ...)
Date: Wed, 09 Oct 2019 18:07:40 +0200
Message-ID: <dc66438b337cbb36b4b13625ef514aa8475c05b2.camel@redhat.com>
In-Reply-To: 80aa086a-a1bd-7c26-65df-af3b26a35801@tessares.net
X-Status: 
X-Keywords:                  
X-UID: 2072

--===============7427398768503671279==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Wed, 2019-10-09 at 09:52 +0200, Matthieu Baerts wrote:
> Hi Paolo,
> =

> On 08/10/2019 22:21, Paolo Abeni wrote:
> > On Tue, 2019-10-08 at 17:00 +0200, Matthieu Baerts wrote:
> > > Hi Davide,
> > > =

> > > On 08/10/2019 16:43, Davide Caratti wrote:
> > > > add a selftest to verify that the kernel forbids attaching MPTCP su=
bflows
> > > > to userspace TCP sockets with setsockopt(..., IPPROTO_TCP, TCP_ULP,=
 ...).

[...]

> > > > +	xgetaddrinfo(remoteaddr, port, &hints, &addr);
> > > > +	for (a =3D addr; a; a =3D a->ai_next) {
> > > > +		sock =3D socket(a->ai_family, a->ai_socktype, IPPROTO_TCP);
> > > > +		if (sock < 0) {
> > > > +			perror("socket");
> > > =

> > > Why could we have an error here? It is just to avoid error message in
> > > the output for something we don't consider as an error.
> > =

> > It can fail e.g. due to memory pressure, or ulimits. Should never
> > happen in normal circumstances, but I think it's better to catch this
> > up, as this patch does.
> =

> Sorry, I should have added my comment at the next line. My question was
> also: should we not "break" here in case of error?
> But if should never fail, I guess we can still go to the next address.
> As long as we don't have "useless" error messages each time we execute
> the tests, I am then fine with both "break" and "continue" here.

speaking of this, I see that I redirected the standard error of the test
to /dev/null. This makes both "perror()" useless. Unless you object,
I will remove redirections from the shellscript.

> > > > +			continue;
> > > > +		}
> > > > +
> > > > +		ret =3D setsockopt(sock, IPPROTO_TCP, TCP_ULP, "mptcp",
> > > > +				 sizeof("mptcp"));
> > > > +		close(sock);
> > > > +		if (ret =3D=3D -1) {
> > > =

> > > Should we check errno as well? Just to be sure we are not "blocked" f=
or
> > > another reason.
> > =

> > I agree additionally checking errno =3D=3D -EOPNOTSUPP would be better.

sure, will do that in v2.

-- =

davide


--===============7427398768503671279==--
