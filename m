Content-Type: multipart/mixed; boundary="===============1060431030651720176=="
MIME-Version: 1.0
From: Geliang Tang <geliangtang at gmail.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [MPTCP][PATCH v5 mptcp-next 1/3] mptcp: send out ADD_ADDR
 with echo flag
Date: Wed, 26 Aug 2020 16:45:24 +0800
Message-ID: <CA+WQbwsGk1vPp8JRHcOZSSk92CQEphW6t5PgUD0bVDo2K_DtPA@mail.gmail.com>
In-Reply-To: alpine.OSX.2.23.453.2008251728130.25312@ticede-or-125.amr.corp.intel.com
X-Status: 
X-Keywords:                  
X-UID: 5625

--===============1060431030651720176==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Mat Martineau <mathew.j.martineau(a)linux.intel.com> =E4=BA=8E2020=E5=B9=B4=
8=E6=9C=8826=E6=97=A5=E5=91=A8=E4=B8=89 =E4=B8=8A=E5=8D=888:34=E5=86=99=E9=
=81=93=EF=BC=9A
>
> On Tue, 25 Aug 2020, Mat Martineau wrote:
>
> > On Sun, 23 Aug 2020, Geliang Tang wrote:
> >
> >> When the ADD_ADDR suboption has been received, we need to send out the=
 same
> >> ADD_ADDR suboption with echo-flag=3D1, and no HMAC.
> >>
> >> Signed-off-by: Geliang Tang <geliangtang(a)gmail.com>
> >> ---
> >> net/mptcp/options.c    | 27 ++++++++++++++++-----------
> >> net/mptcp/pm.c         | 14 +++++++++++---
> >> net/mptcp/pm_netlink.c |  4 +++-
> >> net/mptcp/protocol.h   |  6 ++++--
> >> 4 files changed, 34 insertions(+), 17 deletions(-)
> >>
> >> diff --git a/net/mptcp/options.c b/net/mptcp/options.c
> >> index a52a05effac9..a41996e6c6d7 100644
> >> --- a/net/mptcp/options.c
> >> +++ b/net/mptcp/options.c
> >> @@ -242,7 +242,7 @@ static void mptcp_parse_option(const struct sk_buff
> >> *skb,
> >>              mp_opt->add_addr =3D 1;
> >>              mp_opt->port =3D 0;
> >>              mp_opt->addr_id =3D *ptr++;
> >> -            pr_debug("ADD_ADDR: id=3D%d", mp_opt->addr_id);
> >> +            pr_debug("ADD_ADDR: id=3D%d, echo=3D%d", mp_opt->addr_id,
> >> mp_opt->echo);
> >>              if (mp_opt->family =3D=3D MPTCP_ADDR_IPVERSION_4) {
> >>                      memcpy((u8 *)&mp_opt->addr.s_addr, (u8 *)ptr, 4);
> >>                      ptr +=3D 4;
> >> @@ -579,10 +579,11 @@ static bool mptcp_established_options_add_addr(s=
truct
> >> sock *sk,
> >>      struct mptcp_subflow_context *subflow =3D mptcp_subflow_ctx(sk);
> >>      struct mptcp_sock *msk =3D mptcp_sk(subflow->conn);
> >>      struct mptcp_addr_info saddr;
> >> +    bool echo;
> >>      int len;
> >>
> >>      if (!mptcp_pm_should_add_signal(msk) ||
> >> -        !(mptcp_pm_add_addr_signal(msk, remaining, &saddr)))
> >> +        !(mptcp_pm_add_addr_signal(msk, remaining, &saddr, &echo)))
> >>              return false;
> >>
> >>      len =3D mptcp_add_addr_len(saddr.family);
> >> @@ -594,22 +595,26 @@ static bool mptcp_established_options_add_addr(s=
truct
> >> sock *sk,
> >>      if (saddr.family =3D=3D AF_INET) {
> >>              opts->suboptions |=3D OPTION_MPTCP_ADD_ADDR;
> >>              opts->addr =3D saddr.addr;
> >> -            opts->ahmac =3D add_addr_generate_hmac(msk->local_key,
> >> -                                                 msk->remote_key,
> >> -                                                 opts->addr_id,
> >> -                                                 &opts->addr);
> >> +            if (!echo) {
> >> +                    opts->ahmac =3D add_addr_generate_hmac(msk->local=
_key,
> >> +                                                         msk->remote_=
key,
> >> +                                                         opts->addr_i=
d,
> >> +                                                         &opts->addr);
> >> +            }
> >>      }
> >> #if IS_ENABLED(CONFIG_MPTCP_IPV6)
> >>      else if (saddr.family =3D=3D AF_INET6) {
> >>              opts->suboptions |=3D OPTION_MPTCP_ADD_ADDR6;
> >>              opts->addr6 =3D saddr.addr6;
> >> -            opts->ahmac =3D add_addr6_generate_hmac(msk->local_key,
> >> -                                                  msk->remote_key,
> >> -                                                  opts->addr_id,
> >> -                                                  &opts->addr6);
> >> +            if (!echo) {
> >> +                    opts->ahmac =3D add_addr6_generate_hmac(msk->loca=
l_key,
> >> +
> >> msk->remote_key,
> >> +                                                          opts->addr_=
id,
> >> +                                                          &opts->addr=
6);
> >> +            }
> >>      }
> >> #endif
> >> -    pr_debug("addr_id=3D%d, ahmac=3D%llu", opts->addr_id, opts->ahmac=
);
> >> +    pr_debug("addr_id=3D%d, ahmac=3D%llu, echo=3D%d", opts->addr_id,
> >> opts->ahmac, echo);
> >>
> >>      return true;
> >> }
> >> diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
> >> index 558462d87eb3..e9d1d6670106 100644
> >> --- a/net/mptcp/pm.c
> >> +++ b/net/mptcp/pm.c
> >> @@ -13,11 +13,13 @@
> >> /* path manager command handlers */
> >>
> >> int mptcp_pm_announce_addr(struct mptcp_sock *msk,
> >> -                       const struct mptcp_addr_info *addr)
> >> +                       const struct mptcp_addr_info *addr,
> >> +                       bool echo)
> >> {
> >>      pr_debug("msk=3D%p, local_id=3D%d", msk, addr->id);
> >>
> >>      msk->pm.local =3D *addr;
> >> +    WRITE_ONCE(msk->pm.add_addr_echo, echo);
> >>      WRITE_ONCE(msk->pm.add_addr_signal, true);
> >>      return 0;
> >> }
> >> @@ -136,8 +138,12 @@ void mptcp_pm_add_addr_received(struct mptcp_sock
> >> *msk,
> >>               READ_ONCE(pm->accept_addr));
> >>
> >>      /* avoid acquiring the lock if there is no room for fouther addre=
sses
> >> */
> >> -    if (!READ_ONCE(pm->accept_addr))
> >> +    if (!READ_ONCE(pm->accept_addr)) {
> >> +            spin_lock_bh(&pm->lock);
> >> +            mptcp_pm_announce_addr(msk, addr, true);
> >> +            spin_unlock_bh(&pm->lock);
> >>              return;
> >> +    }
> >
> > The spin lock is now always acquired, so there's no reason to check
> > pm->accept_addr twice. The above code can be deleted, and instead only =
check
> > pm->accept_addr once (the existing check below the existing spin lock h=
ere:
> >
> >>
> >>      spin_lock_bh(&pm->lock);
> >
> > and then add an 'else' case to the "READ_ONCE(pm->accept_addr &&
> > mptcp_pm_schedule_work()" 'if' statement below where the call to
> > mptcp_pm_announce_addr() can be added. This makes sure the echo is also=
 sent
> > if the mptcp_pm_schedule_work() returns false.
>
> Sorry, I think I was wrong about this one. If mptcp_pm_schedule_work()
> returns false it's probably better to not echo so the peer will send
> again.
>
> It would still be better to only check pm->accept once:
>
>         spin_lock_bh(&pm->lock);
>
>         if (!READ_ONCE(pm->accept_addr))
>                 mptcp_pm_announce_addr(msk, addr, true);
>          else if (mptcp_pm_schedule_work(msk, MPTCP_PM_ADD_ADDR_RECEIVED))
>                 pm->remote =3D *addr;
>
>         spin_unlock_bh(&pm->lock);
>

Hi Mat,

Many thanks for your review.

I think we should keep this accept_addr check and re-check mechanism here,
since all the PM's other bool values are used this check and re-check
mechanism. This mechanism first check the bool value without the PM lock,
then re-check it under the PM lock.

Here are all the PM's bool value in mptcp_pm_data:

        bool            add_addr_signal;
        bool            rm_addr_signal;
        bool            server_side;
        bool            work_pending;
        bool            accept_addr;
        bool            accept_subflow;

Except server_side, all the other five bool values are used this mechanism.

1 work_pending

Check and re-check work_pending in mptcp_pm_fully_established:

        if (!READ_ONCE(pm->work_pending))
                return;

        spin_lock_bh(&pm->lock);

        if (READ_ONCE(pm->work_pending))
                mptcp_pm_schedule_work(msk, MPTCP_PM_SUBFLOW_ESTABLISHED);

        spin_unlock_bh(&pm->lock);

2 accept_addr

Check and re-check accept_addr in mptcp_pm_add_addr_received:

        /* avoid acquiring the lock if there is no room for fouther address=
es */
        if (!READ_ONCE(pm->accept_addr))
                return;

        spin_lock_bh(&pm->lock);

        /* be sure there is something to signal re-checking under PM lock */
        if (READ_ONCE(pm->accept_addr) &&
            mptcp_pm_schedule_work(msk, MPTCP_PM_ADD_ADDR_RECEIVED))
                pm->remote =3D *addr;

        spin_unlock_bh(&pm->lock);

3 accept_subflow

Check and re-check accept_subflow in mptcp_pm_allow_new_subflow:

        /* try to avoid acquiring the lock below */
        if (!READ_ONCE(pm->accept_subflow))
                return false;

        spin_lock_bh(&pm->lock);
        ret =3D pm->subflows < pm->subflows_max;
        if (ret && ++pm->subflows =3D=3D pm->subflows_max)
                WRITE_ONCE(pm->accept_subflow, false);
        spin_unlock_bh(&pm->lock);

4 add_addr_signal

First check add_addr_signal in mptcp_pm_should_add_signal:

        if (!mptcp_pm_should_add_signal(msk) ||
            !(mptcp_pm_add_addr_signal(msk, remaining, &saddr)))
                return false;

Then re-check it in mptcp_pm_add_addr_signal under PM lock:

        spin_lock_bh(&msk->pm.lock);

        /* double check after the lock is acquired */
        if (!mptcp_pm_should_add_signal(msk))
                goto out_unlock;

        if (remaining < mptcp_add_addr_len(msk->pm.local.family))
                goto out_unlock;

        *saddr =3D msk->pm.local;
        WRITE_ONCE(msk->pm.add_addr_signal, false);
        ret =3D true;

out_unlock:
        spin_unlock_bh(&msk->pm.lock);

5 rm_addr_signal

First check rm_addr_signal in mptcp_pm_should_rm_signal:
        if (!mptcp_pm_should_rm_signal(msk) ||
            !(mptcp_pm_rm_addr_signal(msk, remaining, &rm_id)))
                return false;

Then re-check it in mptcp_pm_rm_addr_signal under PM lock:

        spin_lock_bh(&msk->pm.lock);

        /* double check after the lock is acquired */
        if (!mptcp_pm_should_rm_signal(msk))
                goto out_unlock;

        if (remaining < TCPOLEN_MPTCP_RM_ADDR_BASE)
                goto out_unlock;

        *rm_id =3D msk->pm.rm_id;
        WRITE_ONCE(msk->pm.rm_addr_signal, false);
        ret =3D true;

out_unlock:
        spin_unlock_bh(&msk->pm.lock);

-Geliang

>
> Mat
>
> >
> >>
> >> @@ -164,7 +170,7 @@ void mptcp_pm_rm_addr_received(struct mptcp_sock *=
msk,
> >> u8 rm_id)
> >> /* path manager helpers */
> >>
> >> bool mptcp_pm_add_addr_signal(struct mptcp_sock *msk, unsigned int
> >> remaining,
> >> -                          struct mptcp_addr_info *saddr)
> >> +                          struct mptcp_addr_info *saddr, bool *echo)
> >> {
> >>      int ret =3D false;
> >>
> >> @@ -178,6 +184,7 @@ bool mptcp_pm_add_addr_signal(struct mptcp_sock *m=
sk,
> >> unsigned int remaining,
> >>              goto out_unlock;
> >>
> >>      *saddr =3D msk->pm.local;
> >> +    *echo =3D READ_ONCE(msk->pm.add_addr_echo);
> >>      WRITE_ONCE(msk->pm.add_addr_signal, false);
> >>      ret =3D true;
> >>
> >> @@ -226,6 +233,7 @@ void mptcp_pm_data_init(struct mptcp_sock *msk)
> >>      WRITE_ONCE(msk->pm.rm_addr_signal, false);
> >>      WRITE_ONCE(msk->pm.accept_addr, false);
> >>      WRITE_ONCE(msk->pm.accept_subflow, false);
> >> +    WRITE_ONCE(msk->pm.add_addr_echo, false);
> >>      msk->pm.status =3D 0;
> >>
> >>      spin_lock_init(&msk->pm.lock);
> >> diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
> >> index ad7232a1d9f1..54fd9db6fb7a 100644
> >> --- a/net/mptcp/pm_netlink.c
> >> +++ b/net/mptcp/pm_netlink.c
> >> @@ -188,7 +188,7 @@ static void
> >> mptcp_pm_create_subflow_or_signal_addr(struct mptcp_sock *msk)
> >>
> >>              if (local) {
> >>                      msk->pm.add_addr_signaled++;
> >> -                    mptcp_pm_announce_addr(msk, &local->addr);
> >> +                    mptcp_pm_announce_addr(msk, &local->addr, false);
> >>              } else {
> >>                      /* pick failed, avoid fourther attempts later */
> >>                      msk->pm.local_addr_used =3D
> >> msk->pm.add_addr_signal_max;
> >> @@ -256,6 +256,8 @@ void mptcp_pm_nl_add_addr_received(struct mptcp_so=
ck
> >> *msk)
> >>      spin_unlock_bh(&msk->pm.lock);
> >>      __mptcp_subflow_connect((struct sock *)msk, &local, &remote);
> >>      spin_lock_bh(&msk->pm.lock);
> >> +
> >> +    mptcp_pm_announce_addr(msk, &remote, true);
> >> }
> >>
> >> void mptcp_pm_nl_rm_addr_received(struct mptcp_sock *msk)
> >> diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
> >> index 4b8a5308aeed..3718d6c287fe 100644
> >> --- a/net/mptcp/protocol.h
> >> +++ b/net/mptcp/protocol.h
> >> @@ -169,6 +169,7 @@ struct mptcp_pm_data {
> >>      bool            work_pending;
> >>      bool            accept_addr;
> >>      bool            accept_subflow;
> >> +    bool            add_addr_echo;
> >>      u8              add_addr_signaled;
> >>      u8              add_addr_accepted;
> >>      u8              local_addr_used;
> >> @@ -443,7 +444,8 @@ void mptcp_pm_add_addr_received(struct mptcp_sock =
*msk,
> >> void mptcp_pm_rm_addr_received(struct mptcp_sock *msk, u8 rm_id);
> >>
> >> int mptcp_pm_announce_addr(struct mptcp_sock *msk,
> >> -                       const struct mptcp_addr_info *addr);
> >> +                       const struct mptcp_addr_info *addr,
> >> +                       bool echo);
> >> int mptcp_pm_remove_addr(struct mptcp_sock *msk, u8 local_id);
> >> int mptcp_pm_remove_subflow(struct mptcp_sock *msk, u8 remote_id);
> >>
> >> @@ -465,7 +467,7 @@ static inline unsigned int mptcp_add_addr_len(int
> >> family)
> >> }
> >>
> >> bool mptcp_pm_add_addr_signal(struct mptcp_sock *msk, unsigned int
> >> remaining,
> >> -                          struct mptcp_addr_info *saddr);
> >> +                          struct mptcp_addr_info *saddr, bool *echo);
> >> bool mptcp_pm_rm_addr_signal(struct mptcp_sock *msk, unsigned int
> >> remaining,
> >>                           u8 *rm_id);
> >> int mptcp_pm_get_local_id(struct mptcp_sock *msk, struct sock_common *=
skc);
> >> --
> >> 2.17.1
> >> _______________________________________________
> >> mptcp mailing list -- mptcp(a)lists.01.org
> >> To unsubscribe send an email to mptcp-leave(a)lists.01.org
> >>
> >
> > --
> > Mat Martineau
> > Intel
> > _______________________________________________
> > mptcp mailing list -- mptcp(a)lists.01.org
> > To unsubscribe send an email to mptcp-leave(a)lists.01.org
> >
>
> --
> Mat Martineau
> Intel
--===============1060431030651720176==--
