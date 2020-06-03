Content-Type: multipart/mixed; boundary="===============2466722221101272017=="
MIME-Version: 1.0
From: Christoph Paasch <cpaasch at apple.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH v2 mptcp-next] mptcp: add receive buffer
 auto-tuning
Date: Wed, 03 Jun 2020 08:45:37 -0700
Message-ID: <20200603154537.GE82850@MacBook-Pro-64.local>
In-Reply-To: 1890d27aa25a7f7303e14554aebbc937aca20a55.camel@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 4579

--===============2466722221101272017==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hello Davide,

On 06/03/20 - 17:08, Davide Caratti wrote:
> On Wed, 2020-06-03 at 16:39 +0200, Florian Westphal wrote:
> > Davide Caratti <dcaratti(a)redhat.com> wrote:
> > > hello Florian,
> > > =

> > > net-next will not be accepting patches for a while - but I would like=
 to
> > > fix this on some tree, so that periodic tests can be run over there. =
So, I
> > > will rebase the fallback rework on top of the rx buffer auto-tuning p=
atch.
> > =

> > Do you plan to submit your patches to net or net-next when it reopens?
> =

> net-next, because the patch doesn't change functionality (moreover, the rx
> support for infinte maps is splitted into another patch). It just
> "improves" fallback to tcp.
> =

> > My plan wrt. autotuning is to send the selftest patch for net, and the
> > autotune one for net-next.  So, to me it would make more sense for your
> > work to go into mptcp-next first.  I would then apply the delta from
> > Christoph and send a new version for mptcp-next.
> =

> ok. Then, I just need to re-send [1] targeting mptcp-next (or Matthieu can
> change it with pwclient?), and let it settle for some days while reviews /
> further troubles occur. Correct?

I don't know if you saw this one, but your patch seems to reveal another
issue when MPTCP tries to connect to itself
(https://github.com/multipath-tcp/mptcp_net-next/issues/35).

AFAICS, it does not trigger because of your change, but rather just triggers
the WARN you added in subflow_data_ready.



Christoph

--===============2466722221101272017==--
