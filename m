Content-Type: multipart/mixed; boundary="===============2659847669094343031=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: mptcp diag interface weirdness
Date: Thu, 06 Aug 2020 15:26:50 +0200
Message-ID: <1d1540a1518996533bffae7effb092cc6ae6eace.camel@redhat.com>
In-Reply-To: 20200806115353.GB26394@breakpoint.cc
X-Status: 
X-Keywords:                  
X-UID: 5499

--===============2659847669094343031==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Thu, 2020-08-06 at 13:53 +0200, Florian Westphal wrote:
> Paolo Abeni <pabeni(a)redhat.com> wrote:
> > Since the older kernel does not know 'INET_DIAG_REQ_PROTOCOL', it will
> > ignore it and will call the tcp diag, which in turn will look into the
> > TCP table. Even the filter will usually match, as we will likely have a
> > TCP subflow matching the MPTCP socket 4 tuple.
> > =

> > In the end 'ss' will get back a TCP diag info, but will interpret it as
> > an MPTCP one, dumping quite weird values.
> > =

> > The only solution I can think is changing 'ss' to
> > override 'sdiag_protocol' with 255 when setting INET_DIAG_REQ_PROTOCOL.
> > =

> > 255 is reserver from IANA, so no diag handler is expected, and the
> > kernel should report (correctly) a protocol unknown error.
> > =

> > WDYT?
> =

> What about echoing INET_DIAG_REQ_PROTOCOL back in the reply?
> Make ss check for its presence, if its not there -> old kernel.

what should 'ss' do if INET_DIAG_REQ_PROTOCOL is not present in the
reply? consider the reply invalid/plain TCP? The current vanilla tree
does not include INET_DIAG_REQ_PROTOCOL in the reply, but it supports
mptcp_diag.

/P

--===============2659847669094343031==--
