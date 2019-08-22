Content-Type: multipart/mixed; boundary="===============5949019801345524438=="
MIME-Version: 1.0
From: Peter Krystad <peter.krystad at linux.intel.com>
To: mptcp at lists.01.org
Subject: Re: [MPTCP] [RFC PATCH] mptcp: extends interim path manager
Date: Thu, 22 Aug 2019 13:28:34 -0700
Message-ID: <e3e8e0249172c4a5759047db184d8fc60e8a6bed.camel@linux.intel.com>
In-Reply-To: 437bd7a3-8da9-776c-d06a-6c328b74dbb6@tessares.net
X-Status: 
X-Keywords:                  
X-UID: 1681

--===============5949019801345524438==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Thu, 2019-08-22 at 16:11 +0200, Matthieu Baerts wrote:
> Hi Paolo,
> =

> On 22/08/2019 15:57, Paolo Abeni wrote:
> > On Thu, 2019-08-22 at 15:29 +0200, Matthieu Baerts wrote:
> > > Hi Paolo,
> > > =

> > > On 22/08/2019 15:19, Paolo Abeni wrote:
> > > > This is on top of "mptcp: Implement interim path manager" and exten=
ds
> > > > the infrastructure there so that local address is configurable per =
ns
> > > > via sysctl.
> > > =

> > > I guess you have missed this other patch:
> > > https://lists.01.org/pipermail/mptcp/2019-August/001661.html
> > > Or is it to replace it? :)
> > =

> > Oops - almost mid-air collision! I looked at the ML after sending out
> > my patch, sorry.
> > =

> > I'm fine with your as I missed *pton helpers availability inside the
> > kernel and I likely abused the sysctl table already there.
> =

> All good, thank you for having looked at the other patch!
> =

> > I'd like to retain the ability to additionally bind the 2nd subflow on
> > the specified local address, so that we could do another step towards a
> > working active backup implementation (Should not be that far on top of
> > all pending bugs, modulo pending bugs ;)
> =

> Good idea! I only did the modification for the server side but it sounds
> good to modify create_subflow_worker() as well!
> Yeah, it would just be an RFC on top of an RFC, also on top of an RFC
> that would be included in a whole RFC patch-set :-D

I concur that using the address value for bind() in the outgoing direction =
is
a good idea. Probably need to use 'net.mptcp.pm.local_address' (or possibly =

net.mptcp.pm.second_address?) since it would no longer be just the
'announce_addr' as in Matthieu's patch.

Peter.



> Cheers,
> Matt
> =

> > Cheers,
> > =

> > Paolo
> > =



--===============5949019801345524438==--
