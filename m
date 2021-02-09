Content-Type: multipart/mixed; boundary="===============0659373444703503998=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH mptcp 1/3] mptcp: schedule worker when subflow is
 closed
Date: Tue, 09 Feb 2021 13:01:35 +0100
Message-ID: <70af47423799bd1f64201e8aac7bb2eecd467171.camel@redhat.com>
In-Reply-To: 20210209101646.GJ16570@breakpoint.cc
X-Status: 
X-Keywords:                  
X-UID: 7706

--===============0659373444703503998==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Tue, 2021-02-09 at 11:16 +0100, Florian Westphal wrote:
> Paolo Abeni <pabeni(a)redhat.com> wrote:
> > At least one per msk connection, I think. On a busy server with an high
> > ingress connection rate is likely significant. Yes, DATA_FIN (ack) will
> > weight twice (or 4x) more, so I think we should use delegated action
> > even for that ;) =

> =

> Compared to packet processing they are likely not relevant, =


I'm not sure - for short lived connection. Looks like time has come to
collect some connection/rate performance figure ;)

> > I have some related patches "cleaning-up" mptcp_release_cb that I'll
> > hopefully share soon.
> =

> Ok, will have a l ook.

Just shared ;)
> =

> > Or perhaps we could check for genl_has_listeners() before scheduling
> > the workqueue?
> =

> I think thats a good idea, however, the idea was not just to kick the
> event but also do the actual socket close, so if we don't sched the wq
> the ssk will stay around until msk close time, no?

We can use the delegated actions to close the subflow (or do any other
task requiring the msk socket lock), with the folloing pattern:

// under ssk lock

mptcp_data_lock();
if (!sock_owned_by_user(msk))
	if (<target ssk !=3D us>)
		mptcp_subflow_delegate(target_subflow, action id); =

		// mptcp_subflow_delegate to be extended to schedule
		// different actions [1]
	else
		<do the intended task> // [2]
else
	<schedule the task for release_cb time> // [3]

[1] and [2] must act atomically, while [3] could sleep, using the loop
introduced by "mptcp: fix race in release_cb". =


For CLOSE_SUBFLOW the target ssk will always be the current one, so
there is actually no need for delegated actions, the release cb will
suffice.

/P


--===============0659373444703503998==--
