Content-Type: multipart/mixed; boundary="===============8772515708684322274=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: Re: [MPTCP] [PATCH RFC] net/mptcp: rcu-ify the subflow context
Date: Fri, 20 Sep 2019 17:22:36 +0200
Message-ID: <6ddcd7dccbd7e219ec37ff88a4dac8b42f53a2b5.camel@redhat.com>
In-Reply-To: 2ae1030d601a904f1484c3a384845866ff589845.camel@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 1892

--===============8772515708684322274==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Thu, 2019-09-19 at 18:08 +0200, Davide Caratti wrote:
> On Fri, 2019-09-13 at 17:54 +0200, Paolo Abeni wrote:
> > The patch looks fine, but I'm still wondering if we should try to be
> > more conservative here, using something alike:
> > =

> > 	return rcu_dereference_protected(icsk->icsk_ulp_data,
> > 		lockdep_sock_is_held((struct sock *)icsk))
> > =

> > and fixing the eventual lockdep splat explcitily
> > =

> > (possibly we may need a different/additional condition for
> > rcu_dereference_protected() based  on icsk refcnt)
> =

> this is for sure, because the socket lock for icsk is often not held when
> subflow_ctx() is called. Nevertheless, icsk_ulp_data is a valid pointer in
> all the traffic path of MPTCP (and it keeps the same value until it's
> freed at the enf of the grace period). Should we do a function that does
> the atomic read of sk_refcnt when lockdep is on? =


I re-read the relevant code, and I changed a bit my mind: the usage of
rcu_dereference_protected() without a condition not based on a lock is
a bit ackward. =


Other similar use-case do force the correct annotation, as in this
patch.

So I'm fine with the posted code.

I'm sorry for useless delay/blocking.

Paolo


--===============8772515708684322274==--
