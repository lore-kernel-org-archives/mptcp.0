Content-Type: multipart/mixed; boundary="===============8336780381464056553=="
MIME-Version: 1.0
From: Geliang Tang <geliangtang at gmail.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [MPTCP][PATCH mptcp-next 2/5] mptcp: add the incoming
 MP_PRIO support
Date: Mon, 30 Nov 2020 10:37:32 +0800
Message-ID: <CA+WQbwu4GK9=7pvM0mP5hgUm1BNBZ+sb97NBxkqBD1rCaQMe0w@mail.gmail.com>
In-Reply-To: 8e3d4390-cc29-4f8a-7f87-6cf5a9bdcc93@linux.intel.com
X-Status: 
X-Keywords:                  
X-UID: 6969

--===============8336780381464056553==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Mat,

Thanks for your review.

Mat Martineau <mathew.j.martineau(a)linux.intel.com> =E4=BA=8E2020=E5=B9=B4=
11=E6=9C=8821=E6=97=A5=E5=91=A8=E5=85=AD =E4=B8=8A=E5=8D=889:06=E5=86=99=E9=
=81=93=EF=BC=9A
>
> On Fri, 20 Nov 2020, Geliang Tang wrote:
>
> > This patch added the incoming MP_PRIO logic:
> >
> > Added a flag named mp_prio in struct mptcp_options_received, to mark the
> > MP_PRIO is received, and save the priority value to struct
> > mptcp_options_received's backup member. Then invoke
> > mptcp_pm_mp_prio_received with the receiving subsocket and
> > the backup value.
> >
> > In mptcp_pm_mp_prio_received, get the subflow context according the inp=
ut
> > subsocket, and change the subflow's backup as the incoming priority val=
ue
> > and reschedule mptcp_worker.
> >
> > Signed-off-by: Geliang Tang <geliangtang(a)gmail.com>
> > ---
> > net/mptcp/options.c  | 15 +++++++++++++++
> > net/mptcp/pm.c       | 19 +++++++++++++++++++
> > net/mptcp/protocol.h |  5 +++++
> > 3 files changed, 39 insertions(+)
> >
> > diff --git a/net/mptcp/options.c b/net/mptcp/options.c
> > index e52eda8c1a18..b1cb43c76be8 100644
> > --- a/net/mptcp/options.c
> > +++ b/net/mptcp/options.c
> > @@ -282,6 +282,15 @@ static void mptcp_parse_option(const struct sk_buf=
f *skb,
> >               pr_debug("RM_ADDR: id=3D%d", mp_opt->rm_id);
> >               break;
> >
> > +     case MPTCPOPT_MP_PRIO:
> > +             if (opsize !=3D TCPOLEN_MPTCP_PRIO)
> > +                     break;
> > +
> > +             mp_opt->mp_prio =3D 1;
> > +             mp_opt->backup =3D *ptr++ & MPTCP_PRIO_BKUP;
>
> Hi Geliang. Thank you for the updated patch set.
>
> Why are both mp_opt->mp_prio and mp_opt->backup needed? Why not use only
> mp_opt->backup?

I think mp_opt->backup could be 0 when we want to change the subflow's
backup value from 1 to 0. So I added another flag mp_prio to mark we get
an MP_PRIO packet.


-Geliang

>
> Regards,
>
> Mat
>
>
> > +             pr_debug("MP_PRIO: prio=3D%d", mp_opt->backup);
> > +             break;
> > +
> >       default:
> >               break;
> >       }
> > @@ -302,6 +311,7 @@ void mptcp_get_options(const struct sk_buff *skb,
> >       mp_opt->port =3D 0;
> >       mp_opt->rm_addr =3D 0;
> >       mp_opt->dss =3D 0;
> > +     mp_opt->mp_prio =3D 0;
> >
> >       length =3D (th->doff * 4) - sizeof(struct tcphdr);
> >       ptr =3D (const unsigned char *)(th + 1);
> > @@ -999,6 +1009,11 @@ void mptcp_incoming_options(struct sock *sk, stru=
ct sk_buff *skb)
> >               mp_opt.rm_addr =3D 0;
> >       }
> >
> > +     if (mp_opt.mp_prio) {
> > +             mptcp_pm_mp_prio_received(sk, mp_opt.backup);
> > +             mp_opt.mp_prio =3D 0;
> > +     }
> > +
> >       if (!mp_opt.dss)
> >               return;
> >
> > diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
> > index ea9e498903e4..ba5b6c4b6fea 100644
> > --- a/net/mptcp/pm.c
> > +++ b/net/mptcp/pm.c
> > @@ -201,6 +201,25 @@ void mptcp_pm_rm_addr_received(struct mptcp_sock *=
msk, u8 rm_id)
> >       spin_unlock_bh(&pm->lock);
> > }
> >
> > +void mptcp_pm_mp_prio_received(struct sock *sk, u8 bkup)
> > +{
> > +     struct mptcp_subflow_context *subflow =3D mptcp_subflow_ctx(sk);
> > +     struct mptcp_sock *msk =3D mptcp_sk(subflow->conn);
> > +
> > +     pr_debug("bkup=3D%d", bkup);
> > +
> > +     if (subflow->backup =3D=3D bkup) {
> > +             pr_warn("backup error.");
> > +             return;
> > +     }
> > +
> > +     subflow->backup =3D bkup;
> > +
> > +     spin_lock_bh(&msk->pm.lock);
> > +     mptcp_schedule_work((struct sock *)msk);
> > +     spin_unlock_bh(&msk->pm.lock);
> > +}
> > +
> > /* path manager helpers */
> >
> > bool mptcp_pm_add_addr_signal(struct mptcp_sock *msk, unsigned int rema=
ining,
> > diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
> > index 99de1f13915d..09a8885a0cc4 100644
> > --- a/net/mptcp/protocol.h
> > +++ b/net/mptcp/protocol.h
> > @@ -87,6 +87,9 @@
> > #define MPTCP_ADDR_IPVERSION_4        4
> > #define MPTCP_ADDR_IPVERSION_6        6
> >
> > +/* MPTCP MP_PRIO flags */
> > +#define MPTCP_PRIO_BKUP              BIT(0)
> > +
> > /* MPTCP socket flags */
> > #define MPTCP_DATA_READY      0
> > #define MPTCP_NOSPACE         1
> > @@ -116,6 +119,7 @@ struct mptcp_options_received {
> >               dss : 1,
> >               add_addr : 1,
> >               rm_addr : 1,
> > +             mp_prio : 1,
> >               family : 4,
> >               echo : 1,
> >               backup : 1;
> > @@ -555,6 +559,7 @@ void mptcp_pm_add_addr_received(struct mptcp_sock *=
msk,
> >                               const struct mptcp_addr_info *addr);
> > void mptcp_pm_add_addr_send_ack(struct mptcp_sock *msk);
> > void mptcp_pm_rm_addr_received(struct mptcp_sock *msk, u8 rm_id);
> > +void mptcp_pm_mp_prio_received(struct sock *sk, u8 bkup);
> > void mptcp_pm_nl_mp_prio_send_ack(struct mptcp_sock *msk,
> >                                 struct mptcp_addr_info *addr,
> >                                 u8 bkup);
> > --
> > 2.26.2
>
> --
> Mat Martineau
> Intel
--===============8336780381464056553==--
