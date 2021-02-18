Content-Type: multipart/mixed; boundary="===============0316986479053167810=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH] mptcp: reset 'first' and ack_hint on subflow close
Date: Thu, 18 Feb 2021 17:32:51 +0100
Message-ID: <91d1ee0b9652cb8e81de9e1cc4a0788f97f13cb1.camel@redhat.com>
In-Reply-To: 20210218162343.GE22944@breakpoint.cc
X-Status: 
X-Keywords:                  
X-UID: 7850

--===============0316986479053167810==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Thu, 2021-02-18 at 17:23 +0100, Florian Westphal wrote:
> Paolo Abeni <pabeni(a)redhat.com> wrote:
> > On Thu, 2021-02-18 at 16:59 +0100, Florian Westphal wrote:
> > > Just like with last_snd, we have to NULL 'first' on subflow close.
> > > =

> > > ack_hint isn't strictly required (its never dereferenced), but better=
 to
> > > clear this as well.
> > > =

> > > msk->first is dereferenced unconditionally at accept time, but
> > > at that point the ssk is not on the conn_list yet -- this means
> > > worker can't see it when iterating the conn_list.
> > =

> > There is a __mptcp_flush_join_list() before __mptcp_close_subflow(),
> > could that matter? IIRC even the PM can move the subflow from join_list
> > to conn_list to take some actions.
> > =

> > not 110% related, we have a couple of !msk->first in =

> > mptcp_update_rcv_data_fin() and mptcp_check_data_fin() which are likely
> > obsoleted/to be removed.
> =

> Hmm, if those are redunant, what exactly do we need msk->first for?
> Fallback mode could just fetch the subflow off conn_list.

AFAICS it mostly avoids traversing the conn_list in some scenarios ;)
IIRC I added that thing as early optimization (=3D=3D root of all evil)

> =

> Matthieu, please ignore this patch for now, I'd prefer to remove
> msk->first completely if possible.

I would love this latter option!

(in the long term I think it would be nice also remote ->subflow)

Thanks!

Paolo

--===============0316986479053167810==--
