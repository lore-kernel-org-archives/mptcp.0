Content-Type: multipart/mixed; boundary="===============7187936237213379756=="
MIME-Version: 1.0
From: Florian Westphal <fw at strlen.de>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [RFC PATCH 11/12] mptcp: allow picking different xmit
 subflows
Date: Mon, 03 Aug 2020 15:49:48 +0200
Message-ID: <20200803134948.GQ29169@breakpoint.cc>
In-Reply-To: dbf14c6b78109e62f17388217de97eb9a88ee9a4.camel@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 5443

--===============7187936237213379756==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Paolo Abeni <pabeni(a)redhat.com> wrote:
> > Checking 'fallback' made no sense to me.  Why do we need to check for t=
his?
> =

> In teory we should not have additional subflows in the fallback status,
> but we can have an MPJ handskake and fallback racing togethar, so we
> end-up with msk in fallback status and one or more fully established
> subflows. If/when that happen we must avoid picking mpj subflows. =


That sounds bad.  I'd suggest to make sure that we only use
msk->first if msk is marked fallback.

> Perhaps is just easier/clearer add an explict (unlikely???) case
> in mptcp_subflow_get_send() and mptcp_subflow_get_retrans()

Agree, its easier to understand, at least.

> > > > Hmm, should this be a separate bug fix (prevent non-fully-establish=
ed-join)?
> > > =

> > > I think the bug is only apparent after we have non backup subflows
> > > and/or remove addr support ?!?
> > =

> > What about other mptcp stack peer?  Couldn't they create a non-backup f=
low?
> > =

> > [ I don't mind if you don't want a separate patch for this, it just
> > looked like a small fix to me that could be applied already ]
> =

> yep, we can have non backup subflows with mptcp.org peers. I still
> would opt for a single patch ;)

Ok, fair enough, I thought you could split that from the series and
get it merged already.
--===============7187936237213379756==--
