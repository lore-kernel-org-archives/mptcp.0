Content-Type: multipart/mixed; boundary="===============8890512512690637548=="
MIME-Version: 1.0
From: Davide Caratti <dcaratti at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH] squash-to: "mptcp: add basic kselftest for mptcp"
Date: Fri, 13 Dec 2019 17:36:08 +0100
Message-ID: <63dce84a00eee7a89472188ec17f7ab0b68cf5e9.camel@redhat.com>
In-Reply-To: 38e178e5be44697a6168b72c6ef25f59cd0ddcd2.camel@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 2964

--===============8890512512690637548==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Fri, 2019-12-13 at 17:15 +0100, Paolo Abeni wrote:
> On Fri, 2019-12-13 at 17:05 +0100, Davide Caratti wrote:
> > checkpatch fixes
> > =

> > Signed-off-by: Davide Caratti <dcaratti(a)redhat.com>
> > ---
> >  .../selftests/net/mptcp/mptcp_connect.c       | 28 +++++++++----------
> >  1 file changed, 14 insertions(+), 14 deletions(-)
> > =


[...]

> >  =

> >  static void check_getpeername(int fd, struct sockaddr_storage *ss, soc=
klen_t salen)
> > @@ -746,15 +746,15 @@ int parse_sndbuf(const char *size)
> >  =

> >  	if (errno) {
> >  		fprintf(stderr, "Invalid sndbuf size %s (%s)\n",
> > -				size,
> > -				strerror(errno));
> > +			size,
> > +			strerror(errno));
> =

> I think here we can have:
> 			size, strerror(errno));

sure, will resend a v2 in minutes!


--===============8890512512690637548==--
