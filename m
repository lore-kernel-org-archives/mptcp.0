Content-Type: multipart/mixed; boundary="===============2875395142136624811=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [RFC PATCH 2/2] add support for mptcp netlink interface.
Date: Thu, 09 Apr 2020 12:56:19 +0200
Message-ID: <1498339d66eabf2a8669c102da401b4ed7caedfe.camel@redhat.com>
In-Reply-To: alpine.OSX.2.22.394.2003292048590.5396@shyampra-mobl1.amr.corp.intel.com
X-Status: 
X-Keywords:                  
X-UID: 4146

--===============2875395142136624811==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

[me is still somewhat alive]

On Sun, 2020-03-29 at 21:02 -0700, Mat Martineau wrote:
> On Fri, 27 Mar 2020, Paolo Abeni wrote:
> =

> > On Thu, 2020-03-26 at 16:45 -0700, Mat Martineau wrote:
> > > To avoid confusion with 'ip address', what about using "ip mptcp
> > > adv-address" (or "advertise-addr"?) to clarify that these are address=
es to
> > > be advertised, rather than something that creates new addresses?
> > =

> > ok to rename, but the addresses specified here could be used for
> > advertise but also as source address for additional flows, so we would
> > need something more generic (and nothing come to my mind beyond
> > 'address').
> =

> Good point. Would something like "default-addr" be generic for that =

> purpose while still getting the point across that we expect these IP =

> addresses to exist already, and are telling MPTCP to use them for any =

> connection?

I'm wondering if something quite different, alike 'endpoint' would fit
better ?!? in (distant) future we could add even port numbers to
announced address.

Cheers,

Paolo

--===============2875395142136624811==--
