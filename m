Content-Type: multipart/mixed; boundary="===============8367859576447490264=="
MIME-Version: 1.0
From: Florian Westphal <fw at strlen.de>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH mptcp-next 3/3] mptcp: switch mptcp_poll to mptcp
 socket wait queue
Date: Fri, 11 Oct 2019 12:06:40 +0200
Message-ID: <20191011100640.GM25052@breakpoint.cc>
In-Reply-To: alpine.OSX.2.21.1910101702400.68386@crpeter1-mobl.amr.corp.intel.com
X-Status: 
X-Keywords:                  
X-UID: 2096

--===============8367859576447490264==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Mat Martineau <mathew.j.martineau(a)linux.intel.com> wrote:
> > -		pr_debug("parent=3D%p", parent);
> > +		struct socket_wq *wq;
> > =

> > 		smp_mb__before_atomic();
> > 		set_bit(MPTCP_DATA_READY, &mptcp_sk(parent)->flags);
> > 		smp_mb__after_atomic();
> > =

> > -		parent->sk_data_ready(parent);
> > -	}
> > +		rcu_read_lock();
> > +		wq =3D rcu_dereference(parent->sk_wq);
> > +		if (skwq_has_sleeper(wq) &&
> > +		    mptcp_should_wake_parent(subflow)) {
> > +			wake_up_interruptible_all(&wq->wait);
> > +		}
> > +		rcu_read_unlock();
> =

> Compared to sock_def_readable, this wakeup code doesn't call sk_wake_asyn=
c.
> Is SOCK_FASYNC irrelevant here (sk_wake_async doesn't do anything without
> that sock flag)?

Its not.  Perhaps best to make this a simpler

if (mptcp_should_wake_parent(subflow))
	parent->sk_data_ready(parent);

I will make this change in the next iteration.
--===============8367859576447490264==--
