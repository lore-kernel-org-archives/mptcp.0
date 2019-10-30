Content-Type: multipart/mixed; boundary="===============8392390062911404443=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH] self-tests: catch poll errors
Date: Wed, 30 Oct 2019 15:09:26 +0100
Message-ID: <79784142105b1a14839021864e21f451cf86578f.camel@redhat.com>
In-Reply-To: 20191030104344.GD876@breakpoint.cc
X-Status: 
X-Keywords:                  
X-UID: 2351

--===============8392390062911404443==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Wed, 2019-10-30 at 11:43 +0100, Florian Westphal wrote:
> Paolo Abeni <pabeni(a)redhat.com> wrote:
> > Otherwise in case of a poll error, we end-up looping forever.
> =

> Did you see this happen in practice?

I got stuck a couple of times while testing buggy patches.

> > +		if (fds.revents & (POLLERR | POLLNVAL)) {
> > +			perror("poll");
> =

> errno should be 0 in this case, as poll had revents, i.e. this shows
> "poll: success"
> =

> Maybe fprintf(stderr, "Unexpected revents: POLLERR/POLLNVAL (%x)\n",
> fds.revents); or similar?

Yep, will do on v2.

Thanks,

Paolo

--===============8392390062911404443==--
