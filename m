Content-Type: multipart/mixed; boundary="===============8853938882972404426=="
MIME-Version: 1.0
From: cpaasch at apple.com
To: mptcp at lists.01.org
Subject: Re: [MPTCP] [PATCH 1/2] skbuff: Add shared control buffer
Date: Thu, 09 Nov 2017 16:56:10 +0900
Message-ID: <20171109075610.GD87737@Chimay.local>
In-Reply-To: AM4PR0501MB2723F33714AC723059ED8D6ED4570@AM4PR0501MB2723.eurprd05.prod.outlook.com
X-Status: 
X-Keywords:                  
X-UID: 169

--===============8853938882972404426==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On 09/11/17 - 07:31:40, Ilya Lesokhin wrote:
> One of the issues I see with TLS is that we need to update
> This control buffer when SKBs are split or merged.
> Have you given any thought into how it should be done?
> =

> In any case, having a hint with a pointer to record could help TLS
> Even if the hint is not always accurate.

This would still incur the cost of maintaining and allocating the records in
the list. Do you have an estimate as to the cost of it in terms of CPU
cycles? (should be possible to have a rough measurement with perf)


In general, there seems to be a need for adding meta-data to skb's. (I just
looked at skb_shared_info->meta_len which was also added recently for XDP).

With all these use-cases, it might be worth to have something clean to store
this meta-data.


Another idea we had was to store meta-data rather somewhere in the linear
memory of the skb (e.g., between skb->head and skb->data or between
skb->end and skb->tail).


Christoph


> =

> > -----Original Message-----
> > From: Boris Pismenny
> > Sent: Thursday, November 09, 2017 8:48 AM
> > To: cpaasch(a)apple.com
> > Cc: Mat Martineau <mathew.j.martineau(a)linux.intel.com>; Ilya Lesokhin
> > <ilyal(a)mellanox.com>; Liran Liss <liranl(a)mellanox.com>; mptcp(a)lis=
ts.01.org
> > Subject: RE: [MPTCP] [PATCH 1/2] skbuff: Add shared control buffer
> > =

> > =

> > =

> > > -----Original Message-----
> > > From: cpaasch(a)apple.com [mailto:cpaasch(a)apple.com]
> > > Sent: Thursday, November 09, 2017 13:48
> > > To: Boris Pismenny <borisp(a)mellanox.com>
> > > Cc: Mat Martineau <mathew.j.martineau(a)linux.intel.com>; Ilya Lesokh=
in
> > > <ilyal(a)mellanox.com>; Liran Liss <liranl(a)mellanox.com>;
> > > mptcp(a)lists.01.org
> > > Subject: Re: [MPTCP] [PATCH 1/2] skbuff: Add shared control buffer
> > >
> > > On 09/11/17 - 04:32:54, Boris Pismenny wrote:
> > > > +Ilya and Liran
> > > >
> > > > Hi,
> > > >
> > > > > -----Original Message-----
> > > > > From: cpaasch(a)apple.com [mailto:cpaasch(a)apple.com]
> > > > > Sent: Thursday, November 09, 2017 13:13
> > > > > To: Mat Martineau <mathew.j.martineau(a)linux.intel.com>; Boris
> > > Pismenny
> > > > > <borisp(a)mellanox.com>
> > > > > Cc: mptcp(a)lists.01.org
> > > > > Subject: Re: [MPTCP] [PATCH 1/2] skbuff: Add shared control buffer
> > > > >
> > > > > +Boris
> > > > >
> > > > > On 20/10/17 - 16:02:31, Mat Martineau wrote:
> > > > > > The sk_buff control buffer is of limited size, and cannot be
> > > > > > enlarged without significant impact on systemwide memory use.
> > > > > > However,
> > > additional
> > > > > > per-packet state is needed for some protocols, like Multipath T=
CP.
> > > > > >
> > > > > > An optional shared control buffer placed after the normal struct
> > > > > > skb_shared_info can accomodate the necessary state without
> > > > > > imposing extra memory usage or code changes on normal struct
> > > > > > sk_buff users. __alloc_skb will now place a skb_shared_info_ext
> > > > > > structure at
> > > > > > skb->end when given the SKB_ALLOC_SHINFO_EXT flag. Most users of
> > > struct
> > > > > > sk_buff continue to use the skb_shinfo() macro to access shared
> > > > > > info. skb_shinfo(skb)->is_ext is set if the extended structure
> > > > > > is available, and cleared if it is not.
> > > > > >
> > > > > > pskb_expand_head will preserve the shared control buffer if it =
is
> > present.
> > > > > >
> > > > > > Signed-off-by: Mat Martineau
> > > > > > <mathew.j.martineau(a)linux.intel.com>
> > > > > > ---
> > > > > >  include/linux/skbuff.h | 24 +++++++++++++++++++++-
> > > > > >  net/core/skbuff.c      | 56
> > ++++++++++++++++++++++++++++++++++++++--
> > > -----
> > > > > -----
> > > > > >  2 files changed, 66 insertions(+), 14 deletions(-)
> > > > >
> > > > > Boris, below is the change I mentioned to you.
> > > > >
> > > > > It allows to allocate 48 additional bytes on-demand after skb_sha=
red_info.
> > > > > As it is on-demand, it won't increase the size of the skb for oth=
er users.
> > > > >
> > > > > For example, TLS could start using it when it creates the skb that
> > > > > it pushes down to the TCP-stack. That way you don't need to handle
> > > > > the tls_record lists.
> > > > >
> > > >
> > > > One small problem is that TLS doesn't create SKBs. As a ULP it calls
> > > > the
> > > transport send
> > > > Functions (do_tcp_sendpages for TLS). This function receives a page
> > > > and not a
> > > SKB.
> > >
> > > yes, that's a good point. Mat has another patch as part of this
> > > series, that adds an skb-arg to sendpages
> > >
> > (https://emea01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fl=
ists.
> > > 01.org%2Fpipermail%2Fmptcp%2F2017-
> > >
> > October%2F000130.html&data=3D02%7C01%7Cborisp%40mellanox.com%7C8d
> > 0
> > >
> > 4f7b1c39649a6e80d08d5272d17fe%7Ca652971c7d2e4d9ba6a4d149256f461
> > b
> > >
> > %7C0%7C0%7C636457996996299024&sdata=3DYjycapXvL2N%2FkrPj15oTy2igh
> > C
> > > 23j1lKmWetdJtdXLU%3D&reserved=3D0)
> > >
> > > That should do the job for you.
> > >
> > > > We decided not to create the SKB outside of the TCP layer to reduce
> > > > the
> > > number of
> > > > changes we made to TCP.
> > > >
> > > > It would be nice if we could use something like that. Did you talk
> > > > to DaveM
> > > about
> > > > upstreaming this?
> > >
> > > No, we didn't talk yet to anyone outside of this list here about it.
> > >
> > > We were looking for a user of it outside of MPTCP but couldn't find o=
ne.
> > > Now, it seems like we found one that would be interested :)
> > >
> > >
> > > I think this infrastructure here would simplify your code quite a bit=
, no?
> > =

> > I'm not sure. I'll need to think about that.
> > =

> > I'm worried that in some cases it won't work, i.e. the shared_info woul=
dn't
> > reach our driver and then again we would be forced to use the tls_get_r=
ecord
> > function.
> > One example, is the tcp_mtu_probe function, which creates a new skb. An=
other
> > is tcp_collapse_retrans. We need to ensure all of these are covered whe=
n we
> > pass any offloaded TLS skb to the driver.
> > =

> > >
> > > > We will definitely find it useful for the receive side, there we
> > > > allocate the SKB
> > > in the driver.
> > >
> > > Interesting! So even there you could use it. We were under the
> > > impression that it would be of less interest for the receive-side.
> > >
> > >
> > > Christoph
> > >
> > > >
> > > > > See below for the rest of the patch.
> > > > >
> > > > >
> > > > > Christoph
> > > > >
>=20

--===============8853938882972404426==--
