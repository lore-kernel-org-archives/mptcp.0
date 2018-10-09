Content-Type: multipart/mixed; boundary="===============9078848726009715058=="
MIME-Version: 1.0
From: Christoph Paasch <cpaasch at apple.com>
To: mptcp at lists.01.org
Subject: Re: [MPTCP] MPTCP layer processing overhead?!
Date: Tue, 09 Oct 2018 15:44:16 -0700
Message-ID: <20181009224416.GT36310@MacBook-Pro-19.local>
In-Reply-To: CAG40BEKwSNDtYoo8Q-SVsRa-5Dd3UQcOvF-hB2UYnbvvfoSRVA@mail.gmail.com
X-Status: 
X-Keywords:                  
X-UID: 803

--===============9078848726009715058==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

(adding back the mailing-list in CC)

On 10/10/18 - 00:25:55, Dejene Boru wrote:
> CPU does not seem to be the bottleneck because I have core i7 and is only
> running iperf on the server and client. The throughput is 935 Mbps with
> MPTCP disabled and 922Mbps with MPTCP enabled. By the way I have repeated
> the same test setting the congestion control to Reno and obtained similar
> result.  I compiled MPTCP from source v94 (kernel 4.14.73).

Ok, that's not a 10% reduction but rather a 1.3% reduction :)

MPTCP adds additional TCP-options in the header. These are consuming
20 bytes. If you take a 1500 MTU, that means you are effectively adding a
20 / 1500 =3D 1.3% overhead compared to the payload.

Thus, a 1.3% throughput reduction is expected here.


MPTCP's benefit is mostly visible when pooling resources across multiple
interfaces (or paths) or when in mobility scenarios.


Christoph


> =

> Dejene Boru
> =

> =

> On Wed, Oct 10, 2018 at 12:17 AM Christoph Paasch <cpaasch(a)apple.com> w=
rote:
> =

> > On 09/10/18 - 23:59:19, Dejene Boru wrote:
> > > Hi all,
> > >
> > > My understanding from MPTCP protocol is that, if MPTCP has only one
> > subflow
> > > it behaves almost similar to regular TCP with Reno  congestion contro=
l.
> > > This means that if I enable MPTCP but set the  congestion control for
> > > example to BBR or DCTCP configuring the parameters required for the
> > > respective congestion control, it should be able to achieve the same
> > > throughput as when MPTCP is disabled and the corresponding congestion
> > > control is configured. I have tested MPTCP with  one subflow  using D=
CTCP
> > > congestion control and obtained a 10% reduced throughput compared with
> > > MPTCP disabled.  Which part of the MPTCP code does result in this kin=
d of
> > > overhead?
> >
> > Are you CPU-limited here in this scenario?
> >
> > What throughput are you getting exactly?
> >
> >
> > Christoph
> >
> >

--===============9078848726009715058==--
