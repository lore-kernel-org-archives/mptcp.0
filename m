Content-Type: multipart/mixed; boundary="===============6161473209657632726=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH v2 mptcp-next 4/4] mptcp: schedule work for better
 snd subflow selection
Date: Tue, 12 Jan 2021 11:27:07 +0100
Message-ID: <6daea7f6c997d88597c04e2338fc358fc1f14f73.camel@redhat.com>
In-Reply-To: c1e596a8-4626-543c-7e8d-7411d95dee15@linux.intel.com
X-Status: 
X-Keywords:                  
X-UID: 7320

--===============6161473209657632726==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Mon, 2021-01-11 at 17:20 -0800, Mat Martineau wrote:
> On Mon, 11 Jan 2021, Paolo Abeni wrote:
> =

> > Otherwise the packet scheduler policy will not be
> > enforced when pushing pending data at MPTCP-level
> > ack reception time.
> > =

> > Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>
> > ---
> > I'm very sad to re-introduce the worker usage for the
> > datapath, but I could not find an easy way to avoid it.
> > =

> > I'm thinking of some weird schema involving a dummy percpu
> > napi instance serving/processing a queue of mptcp sockets
> > instead of actual packets. Any BH user can enqueue an MPTCP
> > subflow there to delegate some action to the latter.
> > =

> > The above will require also overriding the tcp_release_cb()
> > with something able to process this delegated events.
> > =

> > Yep, crazy, but possibly doable without any core change and
> > possibly could be used to avoid the worker usage even for
> > data fin processing/sending.
> > ---
> > net/mptcp/protocol.c | 11 ++++++++---
> > 1 file changed, 8 insertions(+), 3 deletions(-)
> > =

> > diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> > index 510b87a3553b..0791421a971f 100644
> > --- a/net/mptcp/protocol.c
> > +++ b/net/mptcp/protocol.c
> > @@ -2244,6 +2244,7 @@ static void mptcp_worker(struct work_struct *work)
> > 	if (unlikely(state =3D=3D TCP_CLOSE))
> > 		goto unlock;
> > =

> > +	mptcp_push_pending(sk, 0);
> > 	mptcp_check_data_fin_ack(sk);
> > 	__mptcp_flush_join_list(msk);
> > =

> > @@ -2903,10 +2904,14 @@ void __mptcp_check_push(struct sock *sk, struct=
 sock *ssk)
> > 	if (!mptcp_send_head(sk))
> > 		return;
> > =

> > -	if (!sock_owned_by_user(sk))
> > -		__mptcp_subflow_push_pending(sk, ssk);
> > -	else
> > +	if (!sock_owned_by_user(sk)) {
> > +		if (mptcp_subflow_get_send(mptcp_sk(sk)) =3D=3D ssk)
> > +			__mptcp_subflow_push_pending(sk, ssk);
> > +		else
> > +			mptcp_schedule_work(sk);
> =

> Seems like a tradeoff here is between the old code trying to continue =

> sending on this subflow, versus the latency of the scheduled worker. If =

> the scheduler is frequently switching off between subflows the worker =

> would be more of an issue, =


Exactly! Additionaly, even if worker usage would be not too frequent on
each MPTCP connection, a busy server with many connection could be
badly impacted.

> do our self tests exercise that right now?

simlut_flows.sh test cases with unbalanced b/w use both the worker and
the current subflow. The tests themself run at a low rate, so the
overhead is not noticeable in the test. =


That choice is intentional, as the tests are supposed to check the
correctness/fairness of the packet scheduler, not the data plane
performances. It would be interesting adding some more perf-oriented
test using multiple subflows.

/P

--===============6161473209657632726==--
