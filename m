Content-Type: multipart/mixed; boundary="===============7781511341133565590=="
MIME-Version: 1.0
From: Davide Caratti <dcaratti at redhat.com>
To: mptcp at lists.01.org
Subject: Re: [MPTCP] [PATCH RFC] net/mptcp: rcu-ify the subflow context
Date: Tue, 24 Sep 2019 17:42:07 +0200
Message-ID: <d8f6a1ff7934e99311c8d7851e691d803da272a8.camel@redhat.com>
In-Reply-To: f233d813-dc78-bbe8-d2ce-127647758a31@tessares.net
X-Status: 
X-Keywords:                  
X-UID: 1916

--===============7781511341133565590==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Tue, 2019-09-24 at 14:18 +0200, Matthieu Baerts wrote:
> Hi Davide, Paolo,
> =

> On 20/09/2019 17:22, Paolo Abeni wrote:
> > On Thu, 2019-09-19 at 18:08 +0200, Davide Caratti wrote:
> > > On Fri, 2019-09-13 at 17:54 +0200, Paolo Abeni wrote:
> > > > The patch looks fine, but I'm still wondering if we should try to be
> > > > more conservative here, using something alike:
> > > > =

> > > > 	return rcu_dereference_protected(icsk->icsk_ulp_data,
> > > > 		lockdep_sock_is_held((struct sock *)icsk))
> > > > =

> > > > and fixing the eventual lockdep splat explcitily
> > > > =

> > > > (possibly we may need a different/additional condition for
> > > > rcu_dereference_protected() based  on icsk refcnt)
> > > =

> > > this is for sure, because the socket lock for icsk is often not held =
when
> > > subflow_ctx() is called. Nevertheless, icsk_ulp_data is a valid point=
er in
> > > all the traffic path of MPTCP (and it keeps the same value until it's
> > > freed at the enf of the grace period). Should we do a function that d=
oes
> > > the atomic read of sk_refcnt when lockdep is on? =

> > =

> > I re-read the relevant code, and I changed a bit my mind: the usage of
> > rcu_dereference_protected() without a condition not based on a lock is
> > a bit ackward. =

> > =

> > Other similar use-case do force the correct annotation, as in this
> > patch.
> > =

> > So I'm fine with the posted code.
> > =

> > I'm sorry for useless delay/blocking.
> =

> Sorry this time the delay was on my side. Because of the "RFC" tag, I
> didn't put the patch on my list. But can you just confirm that I can
> apply this patch, nothing else is coming?

Hello Matthieu,

I have no plans to improve the current code w.r.t. this patch. Unless
anybody disagrees, I'm for applying it as-is (and squashing it into
"mptcp: Implement MPTCP receive path" ).

thanks!
-- =

davide




--===============7781511341133565590==--
