Content-Type: multipart/mixed; boundary="===============7579530480603861555=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [RFC PATCH 0/6] add locking to PM APis,
 implement PM netlink
Date: Sat, 15 Feb 2020 01:16:23 +0100
Message-ID: <b7912a4ff7f2c9c49e149289d6c101da15da44d7.camel@redhat.com>
In-Reply-To: cover.1581444137.git.pabeni@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 3661

--===============7579530480603861555==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Tue, 2020-02-11 at 19:12 +0100, Paolo Abeni wrote:
> Sending as an early RFC to gather feedback, as this is proving to be more
> intrusive that what I initially hoped for.
> =

> This implement the locking required by the PM to allow concurent subflow
> accessing the msk PM data in a safe way. Such data is protected via a msk=
-level
> spinlock. It relies on the Double checked locking to avoid contention in =
the
> most common scenarion (no or very little PM "actions").
> =

> Overall the above adds quite a bit of code churn, is that a too premature
> optimization? On the flip side, the whole PM processing should be quite
> light on the CPU in most cases.
> =

> Additionally changes more than a bit the PM hooks/APIs, to be hopefully s=
impler
> and avoiding duplicate code (no v4/v6 variant, work queue management done=
 by the
> core PM infra).
> =

> It also introduce the PM netlink - should replace the current basic ones.
> Completely untested but please have a look at the specified netlink uAPI.
> =

> TODO:
>  - implement U/S helper
>  - self-tests
>  - do we need NL dump operation to inspect the PM netlink status?

The current snapshot of this work is available here:

https://github.com/pabeni/mptcp/tree/mptcp_net-next_part3_4

It includes some APIs schanges, basic self-tests for the NL APIs, a
bunch of bugfixes, but I still have to include Mat's feedback and full
MP_JOIN self-tests.

Cheers,

Paolo

--===============7579530480603861555==--
