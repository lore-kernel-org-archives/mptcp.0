Content-Type: multipart/mixed; boundary="===============0884165427752152513=="
MIME-Version: 1.0
From: Florian Westphal <fw at strlen.de>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH v3 7/9] mptcp: add netlink based PM
Date: Wed, 26 Feb 2020 10:51:34 +0100
Message-ID: <20200226095134.GO19559@breakpoint.cc>
In-Reply-To: f9a33bca90c3c5f2ea6af11427f512d30ea31f6f.camel@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 3807

--===============0884165427752152513==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Paolo Abeni <pabeni(a)redhat.com> wrote:
> On Wed, 2020-02-26 at 10:36 +0100, Florian Westphal wrote:
> > Paolo Abeni <pabeni(a)redhat.com> wrote:
> > > I see! Yes, currently we can't limit the number of subflows created f=
or
> > > a single mptcp socket on a server. I'm unsure how bad that is, as
> > > usually we allow each client to create an arbitrary high number of TCP
> > > connection to the server (modulo syn flood).
> > > =

> > > Still I think adding the ability to impose such limit could be nice. =
It
> > > requires an additional hook (from subflow_syn_recv_sock() towards the
> > > PM). If we agree on that, I can try to cover in a separate
> > > patch/series.
> > =

> > I think its a must-have, as file descriptor limits don't apply.
> =

> Ok I'll work on that! =

> =

> Can we still merge the series without this feature to unblock Peter ?

No objections, I did not mean that as a veto.
--===============0884165427752152513==--
