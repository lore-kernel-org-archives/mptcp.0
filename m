Content-Type: multipart/mixed; boundary="===============0744762579560754999=="
MIME-Version: 1.0
From: Peter Krystad <peter.krystad at linux.intel.com>
To: mptcp at lists.01.org
Subject: Re: [MPTCP] [PATCH selftests 0/5] selftests: prepare for mptcp ipv6
 support
Date: Tue, 17 Sep 2019 14:23:42 -0700
Message-ID: <32a588753e2b70d7eca3aa14da329bf0f2735936.camel@linux.intel.com>
In-Reply-To: bdf327acdf5a9111936d9215a516bee48e0be962.camel@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 1870

--===============0744762579560754999==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Tue, 2019-09-17 at 11:28 +0200, Paolo Abeni wrote:
> Hi,
> =

> On Mon, 2019-09-16 at 13:50 -0700, Peter Krystad wrote:
> > On Fri, 2019-09-13 at 11:45 +0200, Florian Westphal wrote:
> > > This patch series inceases self test coverage:
> > > =

> > > 1. ipv6 support.  So all someone needs to do is actually implement ip=
v6
> > >    support in mptcp.  Then, set ipv6=3Dtrue in the selftest script an=
d it
> > >    should 'just work'.
> > =

> > I am planning to begin work on IPv6 support, unless someone else wants =
to
> > arm-wrestle me for it....
> =

> Thank you for doing that! =

> =

> I was also planning to try to estimate the effort there, but I sure do
> not want to arm-wrestle you! I'll fallback to other tasks - recvmsg
> cleanup? mp_join debug? - but please let me know if I can help somehow!
> =

Well, if we are going to go with v1 for our initial submission, maybe it ma=
kes
sense for me to work on the v1 MP_CAPABLE exchange since I did the original
MP_CAPABLE work and leave IPv6 for you or....

Peter.


> Thanks,
> =

> Paolo
> =



--===============0744762579560754999==--
