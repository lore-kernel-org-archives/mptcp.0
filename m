Content-Type: multipart/mixed; boundary="===============5161243040057005257=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH net-next 8/8] mptcp: defer work schedule until
 mptcp lock is released
Date: Tue, 25 Feb 2020 17:35:14 +0100
Message-ID: <3c37d7e7a4adb61b6733a076eb3f79657a8bed45.camel@redhat.com>
In-Reply-To: 20200225161821.GM19559@breakpoint.cc
X-Status: 
X-Keywords:                  
X-UID: 3791

--===============5161243040057005257==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Tue, 2020-02-25 at 17:18 +0100, Florian Westphal wrote:
> Paolo Abeni <pabeni(a)redhat.com> wrote:
> > On Tue, 2020-02-25 at 13:54 +0100, Florian Westphal wrote:
> > > Paolo Abeni <pabeni(a)redhat.com> wrote:
> > > > I think the trylock in patch 6 from different subflows can collide =
with
> > > > each other, so a try lock can fail even with !sk->sk_lock.owned
> > > =

> > > Not following, sorry.
> > =

> > I mean something alike
> > =

> > CPU0 (subflow 0)		CPU1 (subflow 1)
> > trylock				trylock
> > // enqueue the			// lock busy =

> > // data	=

> > 				test_and_set_bit(TCP_DELACK_TIMER_DEFERRED)
> > =

> > but nobody will call mptcp_release_cb() soon.
> =

> This would only happen if both subflows have in-sequence data
> at the time they enter this function.
> =

> Even if it happens, then:
> 1. We enqueued new data (mptcp->ack_seq update)
> 2. We unblock/notify userspace there is new data to read
> =

> If userspaces goes sleep(3600);
> =

> then its possible that we leave 'unacked' data behind
> in case the 'losing' subflow had more data than that.

Yep, I see. This looks like a non existing issue. =


I think the posted code is fine.

Thanks for the explaination.

Paolo

--===============5161243040057005257==--
