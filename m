Content-Type: multipart/mixed; boundary="===============4946534787893732396=="
MIME-Version: 1.0
From: Davide Caratti <dcaratti at redhat.com>
To: mptcp at lists.01.org
Subject: Re: [MPTCP] [PATCH RFC] mptcp: allow dumping subflow context to
 userspace
Date: Wed, 18 Sep 2019 12:47:41 +0200
Message-ID: <81f9022e20af8b29a95d93f6a6faffa6afb9f232.camel@redhat.com>
In-Reply-To: 2f5b76fd-cf9f-777d-45ab-4439fbd66a95@tessares.net
X-Status: 
X-Keywords:                  
X-UID: 1878

--===============4946534787893732396==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Thu, 2019-09-12 at 19:34 +0200, Matthieu Baerts wrote:
> Hi Davide,
> =

> Thank you for sharing this patch and thank you for looking at that!
> =

> On 12/09/2019 18:57, Davide Caratti wrote:
> > On Thu, 2019-09-12 at 18:50 +0200, Davide Caratti wrote:
> > > add ulp-specific diagnostic functions, so that subflow information ca=
n be
> > > dumped to userspace programs like 'ss'.
> > =

> > for the record: iproute2 support is also on the way, but also in this c=
ase
> > the first step will be in ktls. This patch exposes token, local/remote
> > keys, and some of the bitfield members. What do you think it's reasonab=
le
> > exposing to users of 'ss -i' ?
> =

> That looks good to start! I guess later we can expose more info like the
> number of subflows, =


probably the information on 'token' should be sufficient, even though it
needs to query the kernel for TCP_DIAG_INFO on all TCP sockets matching a
particular filter (e.g, given a destination address + port, the number of
subflows is the sum of items that have equal value of 'token').

Another possibility, not necessarily alternative, is to enumerate master
sockets instead of subflows (this needs to walk the radix tree instead of
TCP hashes).

> if there was a fallback to TCP (or maybe non
> relevant?), =


I think this is relevant, and it should also be feasible because the
ulp_ops  shouldstay attached to the subflow socket also after the
fallback.

I will try to include this in the next patch, thanks Matthieu.

> the version of MPTCP and other info we store in the MPTCP
> socket structure, etc.

this is more relevant to the msk IMO.

> Also, do you think it is possible to restrict the informations that are
> shared depending on the capabilities of the requester?
> =

> A bit like what happened on the out-of-tree implementation with this
> famous (for us) commit:
> =

> 	https://github.com/multipath-tcp/mptcp/commit/e993b775d8abda23

currently these sock_diags are available only to users having
CAP_NET_ADMIN, that can obtain the same infos attaching a packet socket on
the host. Do you think we should restrict more than this?

-- =

davide


--===============4946534787893732396==--
