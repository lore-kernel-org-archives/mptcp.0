Content-Type: multipart/mixed; boundary="===============6709317738599139565=="
MIME-Version: 1.0
From: Florian Westphal <fw at strlen.de>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH net-next 8/8] mptcp: defer work schedule until
 mptcp lock is released
Date: Tue, 25 Feb 2020 17:18:21 +0100
Message-ID: <20200225161821.GM19559@breakpoint.cc>
In-Reply-To: 134191ed6e2bbd67ee36a7ac415ee54ef4f9f505.camel@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 3789

--===============6709317738599139565==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Paolo Abeni <pabeni(a)redhat.com> wrote:
> On Tue, 2020-02-25 at 13:54 +0100, Florian Westphal wrote:
> > Paolo Abeni <pabeni(a)redhat.com> wrote:
> > > I think the trylock in patch 6 from different subflows can collide wi=
th
> > > each other, so a try lock can fail even with !sk->sk_lock.owned
> > =

> > Not following, sorry.
> =

> I mean something alike
> =

> CPU0 (subflow 0)		CPU1 (subflow 1)
> trylock				trylock
> // enqueue the			// lock busy =

> // data	=

> 				test_and_set_bit(TCP_DELACK_TIMER_DEFERRED)
> =

> but nobody will call mptcp_release_cb() soon.

This would only happen if both subflows have in-sequence data
at the time they enter this function.

Even if it happens, then:
1. We enqueued new data (mptcp->ack_seq update)
2. We unblock/notify userspace there is new data to read

If userspaces goes sleep(3600);

then its possible that we leave 'unacked' data behind
in case the 'losing' subflow had more data than that.

If thats a concern, the fix is simple:

get rid of TCP_DELACK_TIMER_DEFERRED/release_cb and
schedule work directly.

I will do that in next series.
--===============6709317738599139565==--
