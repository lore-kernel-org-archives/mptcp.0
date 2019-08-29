Content-Type: multipart/mixed; boundary="===============1789066737325425623=="
MIME-Version: 1.0
From: Florian Westphal <fw at strlen.de>
To: mptcp at lists.01.org
Subject: Re: [MPTCP] [PATCH v2] mptcp: sockopt: pass whitelisted setsockopt to
 subflows
Date: Fri, 30 Aug 2019 00:44:51 +0200
Message-ID: <20190829224451.GN20113@breakpoint.cc>
In-Reply-To: alpine.OSX.2.21.1908291520520.34555@mjmartin-mac01.local
X-Status: 
X-Keywords:                  
X-UID: 1765

--===============1789066737325425623==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Mat Martineau <mathew.j.martineau(a)linux.intel.com> wrote:
> On Fri, 16 Aug 2019, Florian Westphal wrote:
> =

> > This allows to set tcp congestion control algorithm on all subflows.
> > =

> > In the future we could keep a record of sockopts so we can "replay"
> > them when another subflow is added at a later point in time.
> > =

> > Only TCP_CONGESTION is allowed at the moment, as some available
> > TCP knobs either have undesireable behaviour or should be later
> > implemented at the mptcp level rather than passing them through to
> > the subflows (TCP_CORK for example).
> > =

> > getsockopt is disabled for the time being to not expose a particular
> > behaviour ("first subflow on list") at this time.
> > =

> > v2: disable getsockopt, restrict setsockopt via whitelist.
> =

> As Florian mentioned on the call today, we definitely want to merge the
> getsockopt fix.
> =

> As for the setsockopt part, if TCP_CONGESTION is sufficiently useful to
> enough users, we could consider merging it. My slight hesitation is that =
the
> potential "replay" behavior change in the future could come as a surprise,
> and if we start out with this ability to set options on all subflows then=
 we
> have to be careful and consistent about how it interacts with per-subflow
> options later. Anyone know if TCP_CONGESTION is a priority?

Its not.

Lets drop this, I will respin with the getsockopt fix only.

Alternatively, Matthieu -- if you can just apply the getsockopt part
of this patch that works for me too.

--===============1789066737325425623==--
