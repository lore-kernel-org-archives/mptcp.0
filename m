Content-Type: multipart/mixed; boundary="===============8478401823029140016=="
MIME-Version: 1.0
From: Geliang Tang <geliangtang at gmail.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [MPTCP][PATCH v5 mptcp-next 3/9] mptcp: add rm_list in
 mptcp_options_received
Date: Tue, 09 Feb 2021 23:13:32 +0800
Message-ID: <CA+WQbwtncFHFs7FyK9pjGAwO7K4E4ijkV4+Pg5Qv=RuEgwCWkg@mail.gmail.com>
In-Reply-To: ae7e1f18-93ee-8d70-8919-519a4887c281@linux.intel.com
X-Status: 
X-Keywords:                  
X-UID: 7724

--===============8478401823029140016==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Mat,

Thanks for your reviews.

Mat Martineau <mathew.j.martineau(a)linux.intel.com> =E4=BA=8E2021=E5=B9=B4=
2=E6=9C=889=E6=97=A5=E5=91=A8=E4=BA=8C =E4=B8=8A=E5=8D=889:51=E5=86=99=E9=
=81=93=EF=BC=9A
>
> On Mon, 8 Feb 2021, Geliang Tang wrote:
>
> > This patch changed the member rm_id in struct mptcp_options_received as=
 a
> > list of the removing address ids, and renamed it to rm_list.
> >
> > In mptcp_parse_option, parsed the RM_ADDR suboption and filled them into
> > the rm_list in struct mptcp_options_received.
> >
> > In mptcp_incoming_options, passed this rm_list to the function
> > mptcp_pm_rm_addr_received.
> >
> > It alse changed the parameter type of mptcp_pm_rm_addr_received.
> >
> > Signed-off-by: Geliang Tang <geliangtang(a)gmail.com>
> > ---
> > net/mptcp/options.c  | 12 ++++++++----
> > net/mptcp/pm.c       | 10 ++++++----
> > net/mptcp/protocol.h |  4 ++--
> > 3 files changed, 16 insertions(+), 10 deletions(-)
> >
> > diff --git a/net/mptcp/options.c b/net/mptcp/options.c
> > index 9e9bbe88b58f..066c46b2a40b 100644
> > --- a/net/mptcp/options.c
> > +++ b/net/mptcp/options.c
> > @@ -26,6 +26,7 @@ static void mptcp_parse_option(const struct sk_buff *=
skb,
> >       int expected_opsize;
> >       u8 version;
> >       u8 flags;
> > +     u8 i;
> >
> >       switch (subtype) {
> >       case MPTCPOPT_MP_CAPABLE:
> > @@ -272,14 +273,17 @@ static void mptcp_parse_option(const struct sk_bu=
ff *skb,
> >               break;
> >
> >       case MPTCPOPT_RM_ADDR:
> > -             if (opsize !=3D TCPOLEN_MPTCP_RM_ADDR_BASE)
> > +             if (opsize < TCPOLEN_MPTCP_RM_ADDR_BASE + 1 ||
> > +                 opsize > TCPOLEN_MPTCP_RM_ADDR_BASE + MPTCP_RM_IDS_MA=
X)
> >                       break;
> >
> >               ptr++;
> >
> >               mp_opt->rm_addr =3D 1;
> > -             mp_opt->rm_id =3D *ptr++;
> > -             pr_debug("RM_ADDR: id=3D%d", mp_opt->rm_id);
> > +             mp_opt->rm_list.nr =3D opsize - TCPOLEN_MPTCP_RM_ADDR_BAS=
E;
> > +             for (i =3D 0; i < mp_opt->rm_list.nr; i++)
> > +                     mp_opt->rm_list.ids[i] =3D *ptr++;
> > +             pr_debug("RM_ADDR: rm_list_nr=3D%d", mp_opt->rm_list.nr);
> >               break;
> >
> >       case MPTCPOPT_MP_PRIO:
> > @@ -1041,7 +1045,7 @@ void mptcp_incoming_options(struct sock *sk, stru=
ct sk_buff *skb)
> >       }
> >
> >       if (mp_opt.rm_addr) {
> > -             mptcp_pm_rm_addr_received(msk, mp_opt.rm_id);
> > +             mptcp_pm_rm_addr_received(msk, mp_opt.rm_list);
> >               mp_opt.rm_addr =3D 0;
> >       }
> >
> > diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
> > index d3f3792c37ac..c8b7295cb522 100644
> > --- a/net/mptcp/pm.c
> > +++ b/net/mptcp/pm.c
> > @@ -220,17 +220,19 @@ void mptcp_pm_add_addr_send_ack(struct mptcp_sock=
 *msk)
> >       mptcp_pm_schedule_work(msk, MPTCP_PM_ADD_ADDR_SEND_ACK);
> > }
> >
> > -void mptcp_pm_rm_addr_received(struct mptcp_sock *msk, u8 rm_id)
> > +void mptcp_pm_rm_addr_received(struct mptcp_sock *msk, struct mptcp_rm=
_list rm_list)
> > {
> >       struct mptcp_pm_data *pm =3D &msk->pm;
> > +     u8 i;
> >
> > -     pr_debug("msk=3D%p remote_id=3D%d", msk, rm_id);
> > +     pr_debug("msk=3D%p remote_ids_nr=3D%d", msk, rm_list.nr);
> >
> > -     mptcp_event_addr_removed(msk, rm_id);
> > +     for (i =3D 0; i < rm_list.nr; i++)
> > +             mptcp_event_addr_removed(msk, rm_list.ids[i]);
> >
> >       spin_lock_bh(&pm->lock);
> >       mptcp_pm_schedule_work(msk, MPTCP_PM_RM_ADDR_RECEIVED);
> > -     pm->rm_id =3D rm_id;
> > +     pm->rm_id =3D rm_list.ids[0];
>
> Need to set rm_list.nr here too.
>

I think no need to set rm_list.nr here, I only set it in patch 1 in v6.

-Geliang


> >       spin_unlock_bh(&pm->lock);
> > }
> >
> > diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
> > index a7fe6b87ef49..f24482242f9e 100644
> > --- a/net/mptcp/protocol.h
> > +++ b/net/mptcp/protocol.h
> > @@ -141,7 +141,7 @@ struct mptcp_options_received {
> >               mpc_map:1,
> >               __unused:2;
> >       u8      addr_id;
> > -     u8      rm_id;
> > +     struct mptcp_rm_list rm_list;
> >       union {
> >               struct in_addr  addr;
> > #if IS_ENABLED(CONFIG_MPTCP_IPV6)
> > @@ -656,7 +656,7 @@ void mptcp_pm_subflow_closed(struct mptcp_sock *msk=
, u8 id);
> > void mptcp_pm_add_addr_received(struct mptcp_sock *msk,
> >                               const struct mptcp_addr_info *addr);
> > void mptcp_pm_add_addr_send_ack(struct mptcp_sock *msk);
> > -void mptcp_pm_rm_addr_received(struct mptcp_sock *msk, u8 rm_id);
> > +void mptcp_pm_rm_addr_received(struct mptcp_sock *msk, struct mptcp_rm=
_list rm_list);
> > void mptcp_pm_mp_prio_received(struct sock *sk, u8 bkup);
> > int mptcp_pm_nl_mp_prio_send_ack(struct mptcp_sock *msk,
> >                                struct mptcp_addr_info *addr,
> > --
> > 2.29.2
>
> --
> Mat Martineau
> Intel
--===============8478401823029140016==--
