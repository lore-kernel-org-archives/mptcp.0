Content-Type: multipart/mixed; boundary="===============5471837304029622600=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH net] mptcp: be careful on subflow creation
Date: Wed, 05 Aug 2020 11:10:52 +0200
Message-ID: <e197f22c62d4f1b78cee4f8a2a9b55a6bc807ede.camel@redhat.com>
In-Reply-To: 4f2a74b9-d728-fa76-7b0f-f70c256077ee@tessares.net
X-Status: 
X-Keywords:                  
X-UID: 5475

--===============5471837304029622600==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Tue, 2020-08-04 at 21:25 +0200, Matthieu Baerts wrote:
> Hi Paolo,
> =

> On 04/08/2020 18:31, Paolo Abeni wrote:
> > Nicolas reported the following oops:
> =

> (...)
> =

> > on some unconventional configuration.
> > =

> > The MPTCP protocol is trying to create a subflow for an
> > unaccepted server socket. That is allowed by the RFC, even
> > if subflow creation will likely fail.
> > Unaccepted sockets have still a NULL sk_socket field,
> > avoid the issue by failing earlier.
> > =

> > Reported-and-tested-by: Nicolas Rybowski <nicolas.rybowski(a)tessares.n=
et>
> > Fixes: 7d14b0d2b9b3 ("mptcp: set correct vfs info for subflows")
> =

> Thank you for the patch, the addition in the code looks very good to me!
> =

> But are you sure the commit you mention introduces the issue you fix here?

AFAICS, the oops can be observed only with the mentioned commit - which
unconditioanlly de-reference a NULL sk->sk_socket. [try to] create a
subflow on server unaccepted socket is not a bug per-se, so I would not
send the fix to older trees.

Thanks,

Paolo

--===============5471837304029622600==--
