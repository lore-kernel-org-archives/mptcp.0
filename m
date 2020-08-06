Content-Type: multipart/mixed; boundary="===============6829274419559725548=="
MIME-Version: 1.0
From: Florian Westphal <fw at strlen.de>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: mptcp diag interface weirdness
Date: Thu, 06 Aug 2020 13:53:53 +0200
Message-ID: <20200806115353.GB26394@breakpoint.cc>
In-Reply-To: d721c9c89256ae6c5dc7c3a268f1e2165a8edf7c.camel@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 5498

--===============6829274419559725548==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Paolo Abeni <pabeni(a)redhat.com> wrote:
> Since the older kernel does not know 'INET_DIAG_REQ_PROTOCOL', it will
> ignore it and will call the tcp diag, which in turn will look into the
> TCP table. Even the filter will usually match, as we will likely have a
> TCP subflow matching the MPTCP socket 4 tuple.
> =

> In the end 'ss' will get back a TCP diag info, but will interpret it as
> an MPTCP one, dumping quite weird values.
> =

> The only solution I can think is changing 'ss' to
> override 'sdiag_protocol' with 255 when setting INET_DIAG_REQ_PROTOCOL.
> =

> 255 is reserver from IANA, so no diag handler is expected, and the
> kernel should report (correctly) a protocol unknown error.
> =

> WDYT?

What about echoing INET_DIAG_REQ_PROTOCOL back in the reply?
Make ss check for its presence, if its not there -> old kernel.
--===============6829274419559725548==--
