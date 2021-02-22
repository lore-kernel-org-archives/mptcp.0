Content-Type: multipart/mixed; boundary="===============8310827594217394718=="
MIME-Version: 1.0
From: Florian Westphal <fw at strlen.de>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH] mptcp: reset 'first' and ack_hint on subflow close
Date: Mon, 22 Feb 2021 09:28:59 +0100
Message-ID: <20210222082859.GJ22944@breakpoint.cc>
In-Reply-To: 4b24aff6aee0a095f295e0c44fdd708a28e7914d.camel@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 7888

--===============8310827594217394718==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Paolo Abeni <pabeni(a)redhat.com> wrote:
> On Thu, 2021-02-18 at 16:59 +0100, Florian Westphal wrote:
> > Just like with last_snd, we have to NULL 'first' on subflow close.
> > =

> > ack_hint isn't strictly required (its never dereferenced), but better to
> > clear this as well.
> > =

> > msk->first is dereferenced unconditionally at accept time, but
> > at that point the ssk is not on the conn_list yet -- this means
> > worker can't see it when iterating the conn_list.
> =

> There is a __mptcp_flush_join_list() before __mptcp_close_subflow(),
> could that matter? IIRC even the PM can move the subflow from join_list
> to conn_list to take some actions.

AFAICS msk->first gets set/used to avoid use of join_list.
The latter is only used for incoming mp_join, not mp_capable.

I guess we can use the join_list but we whould have to stop splicing it
to the conn_list unconditionally -- we would need to keep mp_capable one
on the join_list until accept() time.

I think its better to apply this as-is at the moment, removing of
->first seems possible but the naive approach un-does several fixes
you made to avoid exposure of the first subflow to the work queue.
--===============8310827594217394718==--
