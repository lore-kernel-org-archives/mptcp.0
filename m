Content-Type: multipart/mixed; boundary="===============2476333012050794565=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH v1 2/3] Squash-to: "mptcp: add netlink based PM"
Date: Wed, 18 Mar 2020 10:21:01 +0100
Message-ID: <a8c8e101994ddf45f578307ab5185138ca996d61.camel@redhat.com>
In-Reply-To: alpine.OSX.2.22.394.2003171538090.25711@fvaldivi-mobl1.amr.corp.intel.com
X-Status: 
X-Keywords:                  
X-UID: 3976

--===============2476333012050794565==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, 2020-03-17 at 15:57 -0700, Mat Martineau wrote:
> On Mon, 16 Mar 2020, Paolo Abeni wrote:
> =

> > update pm netlink hook to previous patch -
> > locks are already held.
> > =

> > Additionally fixes wrong status counter update on address
> > announcement.
> > =

> > Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>
> > ---
> > net/mptcp/pm_netlink.c | 23 +++++++----------------
> > 1 file changed, 7 insertions(+), 16 deletions(-)
> > =

> > diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
> > index d74dc813f4a6..5fb65770c0d2 100644
> > --- a/net/mptcp/pm_netlink.c
> > +++ b/net/mptcp/pm_netlink.c
> > @@ -176,13 +176,10 @@ static void mptcp_pm_create_subflow_or_signal_add=
r(struct mptcp_sock *msk)
> > =

> > 	pernet =3D net_generic(sock_net((struct sock *)msk), pm_nl_pernet_id);
> > =

> > -	lock_sock(sk);
> > -
> > -	spin_lock_bh(&msk->pm.lock);
> > -	msk->pm.status =3D MPTCP_PM_IDLE;
> > -	pr_debug("local %d:%d signal %d:%d\n",
> > +	pr_debug("local %d:%d signal %d:%d subflows %d:%d\n",
> > 		 msk->pm.local_addr_used, msk->pm.local_addr_max,
> > -		 msk->pm.add_addr_signaled, msk->pm.add_addr_signal_max);
> > +		 msk->pm.add_addr_signaled, msk->pm.add_addr_signal_max,
> > +		 msk->pm.subflows, msk->pm.subflows_max);
> > =

> > 	/* check first for announce */
> > 	if (msk->pm.add_addr_signaled < msk->pm.add_addr_signal_max) {
> > @@ -190,7 +187,7 @@ static void mptcp_pm_create_subflow_or_signal_addr(=
struct mptcp_sock *msk)
> > 					      msk->pm.add_addr_signaled);
> > =

> > 		if (local) {
> > -			msk->pm.local_addr_used++;
> > +			msk->pm.add_addr_signaled++;
> > 			mptcp_pm_announce_addr(msk, &local->addr);
> > 		} else {
> > 			/* pick failed, avoid fourther attempts later */
> > @@ -213,7 +210,7 @@ static void mptcp_pm_create_subflow_or_signal_addr(=
struct mptcp_sock *msk)
> > 			spin_unlock_bh(&msk->pm.lock);
> > 			__mptcp_subflow_connect(sk, local->ifindex,
> > 						&local->addr, &remote);
> > -			release_sock(sk);
> > +			spin_lock_bh(&msk->pm.lock);
> > 			return;
> > 		}
> > =

> > @@ -221,9 +218,6 @@ static void mptcp_pm_create_subflow_or_signal_addr(=
struct mptcp_sock *msk)
> > 		msk->pm.local_addr_used =3D msk->pm.local_addr_max;
> > 		check_work_pending(msk);
> > 	}
> > -
> > -	spin_unlock_bh(&msk->pm.lock);
> > -	release_sock(sk);
> > }
> > =

> > void mptcp_pm_nl_fully_established(struct mptcp_sock *msk)
> > @@ -245,8 +239,6 @@ void mptcp_pm_nl_add_addr_received(struct mptcp_soc=
k *msk)
> > =

> > 	pernet =3D net_generic(sock_net((struct sock *)msk), pm_nl_pernet_id);
> > =

> > -	spin_lock_bh(&msk->pm.lock);
> > -	msk->pm.status =3D MPTCP_PM_IDLE;
> > 	pr_debug("accepted %d:%d remote family %d",
> > 		 msk->pm.add_addr_accepted, msk->pm.add_addr_accept_max,
> > 		 msk->pm.remote.family);
> > @@ -264,11 +256,10 @@ void mptcp_pm_nl_add_addr_received(struct mptcp_s=
ock *msk)
> > 		remote.port =3D sk->sk_dport;
> > 	memset(&local, 0, sizeof(local));
> > 	local.family =3D remote.family;
> > -	spin_unlock_bh(&msk->pm.lock);
> > =

> > -	lock_sock(sk);
> > +	spin_unlock_bh(&msk->pm.lock);
> > 	__mptcp_subflow_connect((struct sock *)msk, 0, &local, &remote);
> > -	release_sock(sk);
> > +	spin_lock_bh(&msk->pm.lock);
> =

> This last change to unlock/re-lock pm.lock does require care around =

> setting and clearing the pm->status bits. It looks like it's possible to =

> set a bit that gets cleared by a currently running worker, so the next ru=
n =

> of pm_worker might find no bits set.
> =

> Should pm_worker copy and and clear pm->status once at the beginning, the=
n =

> use the copy to choose when to run the mptcp_pm_nl_* functions? It might =

> behave more consistently when the worker code is reacquiring the lock.

Thank you for the review!

I thought about the above a bit. Yes, it can happen that the PM worker
is scheduled with no real work to do, but only if the requested work is
is served by the an already running instance. The PM worker scheduling
can happen only a few times per connections (no more than
add_addr_signal_max + subflow_max), so I does not look that bad to me.

I cleared all status bit at once in previous internal iteration, but it
was racy because add_addr status bit has also an associated ancillatory
data (the address itself), and such iteration add_addr even were served
later by the main even switch statement. =


With such code the IP address data was sometime out-of-sync. I had to
change the NL event callback order because - it caused also other
issues, so this race should not be possible now. Still clearing the
status bit non atomically with the related event callback invocation
looks a bit fragile to me.

Anyhow I don't have any strong opinion here, so either options are
doable for me. Whatever you prefer ;)

Thanks,

Paolo

--===============2476333012050794565==--
