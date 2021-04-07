Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 432F76D0E
	for <mptcp@lists.linux.dev>; Wed,  7 Apr 2021 07:55:48 +0000 (UTC)
Received: by mail-ed1-f43.google.com with SMTP id f8so15655868edd.11
        for <mptcp@lists.linux.dev>; Wed, 07 Apr 2021 00:55:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=kdyGvJdklRaIiNZ0E15LlyAEBmSqCbGe7g4T0ma7IeE=;
        b=UgS4WrGU3BQ1MFX/Iq4zkFcHOAC2kXelvbWzC5PTmDQrCnInOnoyCIPU/ZkOIwWszF
         ERSgp32U8Hl0ORdRUnPI2UBR63DLmpy1tVywxJeGxsLLrymoM746GfI42tl/xQfor7kt
         ocS1A2MCK5lMNOmYERM4yv8x49bJX0kCbHhg1k+/IXsEZ7Zqdx+wnVJoXpfacc59KzIy
         j6o93/bytKpbCjBouW/iZNua12sd4T0iGl/V5hnIC9aWgXkAd7jCQ56y9q9nDTZNqdW8
         7pDwePfsGC1wyHxgbwU0/dJ5wLqGTDTcDhq1efFUaBqzVx2ldXZzj2e2M7eqsj161ZU+
         Bd5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=kdyGvJdklRaIiNZ0E15LlyAEBmSqCbGe7g4T0ma7IeE=;
        b=a8SLloTVEn5gUSrnk1toSKXrekm+LtIWSA/0FjIGFoBw2A8XBpctjIKj2B234Z+AQb
         GH29qf0/isgyryK+K1lZRL9m8UxfOB+IlEJG4jtkqhbW4+Iuwpfg6GQ9dFRpTNxs0Huu
         hs9qKAhXOhZWM4Xvrcw/2X2AoO/DzHln1f6Pk/RRYiMLXjGp4Kesk/Xt4hlixSwqufzE
         gh1rwnLUgoLqnk2HAp+eD7BYGqbLlOetit7sT8VU9SX1UzTlHfSlPdALy6o04vda3saN
         x2FOjddbF86hWSAGpvzhDfD12+4NX034O3oCQOM8ThbNLc+GjEY2xlWAfmrnHAn6apbd
         qxRw==
X-Gm-Message-State: AOAM531geBcvTj1O6d+Kht9PbmdZnMM8WoJAkndtk8lIm4w4YADnyYnm
	8vu1d2q+Q7r0celKFzIz0Ef8A1/rkJsV3jqE/YMJcoVxxKPPoQ==
X-Google-Smtp-Source: ABdhPJxhic7wb6Gmyh563fwl3L5EemYf5ImP0QGI4Tbr356srR4VvRbh76s6kb4sI0jNakPgA/8nvP7Zhu/T9J3i5X8=
X-Received: by 2002:a05:6402:2787:: with SMTP id b7mr2805493ede.225.1617782146710;
 Wed, 07 Apr 2021 00:55:46 -0700 (PDT)
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <cover.1617703144.git.geliangtang@gmail.com> <ba5b4db66f47311d65703f5ea25430a5957106a9.1617703144.git.geliangtang@gmail.com>
 <32cc5ed6-d0a9-756d-454-6ee7ecf8f2d1@linux.intel.com>
In-Reply-To: <32cc5ed6-d0a9-756d-454-6ee7ecf8f2d1@linux.intel.com>
From: Geliang Tang <geliangtang@gmail.com>
Date: Wed, 7 Apr 2021 15:55:35 +0800
Message-ID: <CA+WQbwsnxW3s4oi6-fUmWMN6hhF27QecpeA-Uj8nEiM4W81yXA@mail.gmail.com>
Subject: Re: [MPTCP][PATCH mptcp-next 1/2] mptcp: add mptcp_for_each_msk helper
To: Mat Martineau <mathew.j.martineau@linux.intel.com>
Cc: mptcp@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Mat Martineau <mathew.j.martineau@linux.intel.com> =E4=BA=8E2021=E5=B9=B44=
=E6=9C=887=E6=97=A5=E5=91=A8=E4=B8=89 =E4=B8=8A=E5=8D=887:44=E5=86=99=E9=81=
=93=EF=BC=9A
>
>
> On Tue, 6 Apr 2021, Geliang Tang wrote:
>
> > This patch added a new macro helper mptcp_for_each_msk to traverse each
> > existing msk socket in the net namespace.
> >
> > Signed-off-by: Geliang Tang <geliangtang@gmail.com>
> > ---
> > net/mptcp/pm_netlink.c | 39 +++++++++++++++++----------------------
> > 1 file changed, 17 insertions(+), 22 deletions(-)
> >
> > diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
> > index 6ba040897738..b9044defd89b 100644
> > --- a/net/mptcp/pm_netlink.c
> > +++ b/net/mptcp/pm_netlink.c
> > @@ -58,6 +58,10 @@ struct pm_nl_pernet {
> > #define MPTCP_PM_ADDR_MAX     8
> > #define ADD_ADDR_RETRANS_MAX  3
> >
> > +#define mptcp_for_each_msk(__net, __msk)                             \
> > +     long __slot =3D 0, __num =3D 0;                                  =
   \
> > +     while ((__msk =3D mptcp_token_iter_next(__net, &(__slot), &(__num=
))) !=3D NULL)
>
> Hi Geliang,
>
> I don't think it's good to move the variable declarations inside the macr=
o
> like this. It looks like the compiler or sparse might have complained whe=
n
> the macro was used after a non-declaration line of code, since some other
> code (like list.ids[] initialization) was moved around. The macro
> shouldn't depend on careful placement in a code block this way - in my
> view, it's better to live with the existing syntax.

I agree with you, thanks Mat.

-Geliang

>
>
> Mat
>
>
> > +
> > static bool addresses_equal(const struct mptcp_addr_info *a,
> >                           struct mptcp_addr_info *b, bool use_port)
> > {
> > @@ -985,9 +989,8 @@ static struct pm_nl_pernet *genl_info_pm_nl(struct =
genl_info *info)
> > static int mptcp_nl_add_subflow_or_signal_addr(struct net *net)
> > {
> >       struct mptcp_sock *msk;
> > -     long s_slot =3D 0, s_num =3D 0;
> >
> > -     while ((msk =3D mptcp_token_iter_next(net, &s_slot, &s_num)) !=3D=
 NULL) {
> > +     mptcp_for_each_msk(net, msk) {
> >               struct sock *sk =3D (struct sock *)msk;
> >
> >               if (!READ_ONCE(msk->fully_established))
> > @@ -1096,14 +1099,9 @@ static int mptcp_nl_remove_subflow_and_signal_ad=
dr(struct net *net,
> >                                                  struct mptcp_addr_info=
 *addr)
> > {
> >       struct mptcp_sock *msk;
> > -     long s_slot =3D 0, s_num =3D 0;
> > -     struct mptcp_rm_list list =3D { .nr =3D 0 };
> > -
> > -     pr_debug("remove_id=3D%d", addr->id);
> >
> > -     list.ids[list.nr++] =3D addr->id;
> > -
> > -     while ((msk =3D mptcp_token_iter_next(net, &s_slot, &s_num)) !=3D=
 NULL) {
> > +     mptcp_for_each_msk(net, msk) {
> > +             struct mptcp_rm_list list =3D { .nr =3D 0 };
> >               struct sock *sk =3D (struct sock *)msk;
> >               bool remove_subflow;
> >
> > @@ -1112,6 +1110,8 @@ static int mptcp_nl_remove_subflow_and_signal_add=
r(struct net *net,
> >                       goto next;
> >               }
> >
> > +             list.ids[list.nr++] =3D addr->id;
> > +
> >               lock_sock(sk);
> >               remove_subflow =3D lookup_subflow_by_saddr(&msk->conn_lis=
t, addr);
> >               mptcp_pm_remove_anno_addr(msk, addr, remove_subflow);
> > @@ -1162,13 +1162,10 @@ static void mptcp_pm_free_addr_entry(struct mpt=
cp_pm_addr_entry *entry)
> > static int mptcp_nl_remove_id_zero_address(struct net *net,
> >                                          struct mptcp_addr_info *addr)
> > {
> > -     struct mptcp_rm_list list =3D { .nr =3D 0 };
> > -     long s_slot =3D 0, s_num =3D 0;
> >       struct mptcp_sock *msk;
> >
> > -     list.ids[list.nr++] =3D 0;
> > -
> > -     while ((msk =3D mptcp_token_iter_next(net, &s_slot, &s_num)) !=3D=
 NULL) {
> > +     mptcp_for_each_msk(net, msk) {
> > +             struct mptcp_rm_list list =3D { .nr =3D 0 };
> >               struct sock *sk =3D (struct sock *)msk;
> >               struct mptcp_addr_info msk_local;
> >
> > @@ -1179,6 +1176,8 @@ static int mptcp_nl_remove_id_zero_address(struct=
 net *net,
> >               if (!addresses_equal(&msk_local, addr, addr->port))
> >                       goto next;
> >
> > +             list.ids[list.nr++] =3D 0;
> > +
> >               lock_sock(sk);
> >               spin_lock_bh(&msk->pm.lock);
> >               mptcp_pm_remove_addr(msk, &list);
> > @@ -1271,13 +1270,9 @@ static void mptcp_pm_remove_addrs_and_subflows(s=
truct mptcp_sock *msk,
> > static void mptcp_nl_remove_addrs_list(struct net *net,
> >                                      struct list_head *rm_list)
> > {
> > -     long s_slot =3D 0, s_num =3D 0;
> >       struct mptcp_sock *msk;
> >
> > -     if (list_empty(rm_list))
> > -             return;
> > -
> > -     while ((msk =3D mptcp_token_iter_next(net, &s_slot, &s_num)) !=3D=
 NULL) {
> > +     mptcp_for_each_msk(net, msk) {
> >               struct sock *sk =3D (struct sock *)msk;
> >
> >               lock_sock(sk);
> > @@ -1320,7 +1315,8 @@ static int mptcp_nl_cmd_flush_addrs(struct sk_buf=
f *skb, struct genl_info *info)
> >       pernet->next_id =3D 1;
> >       bitmap_zero(pernet->id_bitmap, MAX_ADDR_ID + 1);
> >       spin_unlock_bh(&pernet->lock);
> > -     mptcp_nl_remove_addrs_list(sock_net(skb->sk), &free_list);
> > +     if (!list_empty(&free_list))
> > +             mptcp_nl_remove_addrs_list(sock_net(skb->sk), &free_list)=
;
> >       __flush_addrs(&free_list);
> >       return 0;
> > }
> > @@ -1535,11 +1531,10 @@ static int mptcp_nl_addr_backup(struct net *net=
,
> >                               struct mptcp_addr_info *addr,
> >                               u8 bkup)
> > {
> > -     long s_slot =3D 0, s_num =3D 0;
> >       struct mptcp_sock *msk;
> >       int ret =3D -EINVAL;
> >
> > -     while ((msk =3D mptcp_token_iter_next(net, &s_slot, &s_num)) !=3D=
 NULL) {
> > +     mptcp_for_each_msk(net, msk) {
> >               struct sock *sk =3D (struct sock *)msk;
> >
> >               if (list_empty(&msk->conn_list))
> > --
> > 2.30.2
> >
> >
> >
>
> --
> Mat Martineau
> Intel
