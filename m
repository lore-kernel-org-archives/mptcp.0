Content-Type: multipart/mixed; boundary="===============0933361590213268398=="
MIME-Version: 1.0
From: Florian Westphal <fw at strlen.de>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH 1/9] token: handle join-before-accept-completion
 case
Date: Mon, 02 Dec 2019 17:57:44 +0100
Message-ID: <20191202165744.GQ795@breakpoint.cc>
In-Reply-To: 09c7e48261b8c9040eb8d8864e42257b03894939.camel@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 2744

--===============0933361590213268398==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Paolo Abeni <pabeni(a)redhat.com> wrote:
> On Mon, 2019-12-02 at 14:31 +0100, Florian Westphal wrote:
> > Paolo Abeni <pabeni(a)redhat.com> wrote:
> > > Note, with MPTCP v1, we will probably have to add additional checks
> > > here (e.g. con->fourth_ack must be true). Perhaps we can add that
> > > already?
> > =

> > I'm not sure this is the right location.  Should that check not
> > be done where we add the ssk to the conn_list?
> =

> My [mis?]understanding is that MP_JOIN should not be attemped before
> the msk is fully established (fourth_ack), so I thought it would be
> nice to catch that erroneous condition ASAP.

I see.  What would that buy us though wrt. error handling?
--===============0933361590213268398==--
