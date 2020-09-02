Content-Type: multipart/mixed; boundary="===============6822206191506593403=="
MIME-Version: 1.0
From: Geliang Tang <geliangtang at gmail.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [MPTCP][PATCH v8 mptcp-next 0/8] Add REMOVE_ADDR support
Date: Wed, 02 Sep 2020 19:30:05 +0800
Message-ID: <CA+WQbwvYqYZYq0CNHYiO0+_1WMQzaf6k8h8-BX15VHE4u=hX3Q@mail.gmail.com>
In-Reply-To: 3717e7b40a029e1e5e5cd343af74d6f702e721d2.camel@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 5694

--===============6822206191506593403==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Paolo,

Thanks for your review.

Paolo Abeni <pabeni(a)redhat.com> =E4=BA=8E2020=E5=B9=B49=E6=9C=882=E6=97=
=A5=E5=91=A8=E4=B8=89 =E4=B8=8A=E5=8D=8812:02=E5=86=99=E9=81=93=EF=BC=9A
>
> On Mon, 2020-08-24 at 19:36 +0800, Geliang Tang wrote:
> > v8:
> >  - drop anno_list in v7.
> >    We don't need to add a new list, conn_list is enough for the signal
> > address and local subflow.
>
> I think this could be problematic.
>
> An MPTCP socket could refuse or delay the creation of new subflows for
> addresses received via ADD_ADDR.
>
> But an MPTCP should send REMOVE_ADDR for accounced addresses, even if
> no subflows exists on top of them.
>
> Removing the anno_list we lose this ability.

Yes, we can't cover this case, but the v7 code with anno_list can't cover
it either. Since anno_list only recorded the local announced addresses,
we need also record the received addresses on the remote side.

I'll write a patch to fix this problem later.

>
> I'd like to avoid additional interations, if possible, and eventually
> add squash-to fixes if/where needed. Other options more than welcome.

Since my another patchset 'add ADD_ADDR echo flag support' is accepted,
v8 will conflict with it. So here I simply updated the v8 patchset as
you suggested and sent out the v9 version.

>
> Cheers,
>
> Paolo
>

> very minor note: this does not respect the reverse x-mas tree order.
>
> Otherwise looks good.
>
> Note: I think you can submit this patch and the previous one (4/8)
> directly to -net (with an appropriate Fixes tag).
>

Since patch 5/8 is depended on the patch 'mptcp: add the incoming RM_ADDR
support', which is only on net-next's export branch, we can't directly
submit 4/8 and 5/8 to -net. So here I still keeped them in the v9 patchset.

Thanks.

-Geliang
--===============6822206191506593403==--
