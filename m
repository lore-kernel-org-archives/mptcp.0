Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7865417F
	for <mptcp@lists.linux.dev>; Tue, 29 Jun 2021 07:35:59 +0000 (UTC)
Received: by mail-pj1-f48.google.com with SMTP id g4so11919736pjk.0
        for <mptcp@lists.linux.dev>; Tue, 29 Jun 2021 00:35:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=vPFceTfzBrEoycJFpv4qTwDnuDR0W7hbfcFOLc/23lg=;
        b=h2ZcpNa4bFWSz8Nt1B3l1rQhGmHxiYrhMjRLLyCp1tcoyFFJJnFXVQ+eZkceF86Qf2
         gh4mYrsq1sIKClxmYi+b86hEx3YvdvGnSoPG2fozsEJk0mkws4fahVx/cCsUmPqxp2rM
         QUGhp1i6dB36lLkOYqNMA9i61l9RjfF5jnnSLZ4ncbOsm8OnC9BF3gdtQftFVPKVveHc
         +ucaB4PdAJTkxEsaXjZ4fXkfprupP3j5CEAtlxq3G4bzqdjCK1Qn9A3TxA+J40sq5uBa
         zOSM4HMezb3vUkWeg8y2S9k3xU6ymZhzbkUYIsZJHkxtmSgme/egRkHL6AvBJFcICRav
         ji/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=vPFceTfzBrEoycJFpv4qTwDnuDR0W7hbfcFOLc/23lg=;
        b=nqo4HIUQm2Ftxd17XGqUyCDwwS0eQhGfcY6QbKvux/k+KGjzIfeWfOWd2NI1LrRCg3
         NvH3Am5UsgLA0lphLBfRNsXS3lxUFlsGX12PlQCrM256Qk4b8NXgWWUBNPzw5u0MhVu7
         1uzTswu43oEZB04qTAvA2ybzTCQsEBdi3aEaWAThkWLpLTpNBrSYlV0ml3ZUd3vNTF8z
         oAwfGk6dLeL/IYhyJPKyzlZVhPMyxFRTVpaqfuS2tYEg8aa/5w44kD9salVWb7WSvmeC
         Be6RzCRt69B3bLWGXw4hWrypHJBLGfVmpa6BAmm8Ax4PsWhMutYwLByDSjOiGxKvbmFn
         dqzg==
X-Gm-Message-State: AOAM530y9r4FRPAyzdIO2W4UL61mhao4zVGvLrCgCbtoRviuaD41PEVu
	AQ6z8p9FJRZyJS1hkLZSU8g0dGKlWFB+RkKVAmk=
X-Google-Smtp-Source: ABdhPJyO0tHb6odXtbR3gexZQtbvkscr3pSnfrCt+0XycKgcKPJMKWmAvkbJxy9urjgURy2g1Mv7lH4dEhw54rH0B5o=
X-Received: by 2002:a17:90b:33c6:: with SMTP id lk6mr42649465pjb.6.1624952158915;
 Tue, 29 Jun 2021 00:35:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <1624930899-99623-1-git-send-email-liyonglong@chinatelecom.cn>
 <1624930899-99623-4-git-send-email-liyonglong@chinatelecom.cn>
 <CA+WQbwvCWgCog4jxVjpQxvJ0_ojms8ND=gP1WJUA=0B-zGB-=A@mail.gmail.com> <3ab57409-8d5b-981a-7656-fc2f1f6167ad@chinatelecom.cn>
In-Reply-To: <3ab57409-8d5b-981a-7656-fc2f1f6167ad@chinatelecom.cn>
From: Geliang Tang <geliangtang@gmail.com>
Date: Tue, 29 Jun 2021 15:35:47 +0800
Message-ID: <CA+WQbwtW-H6NoHFV=xqfVsGJ4Z5YwQkOd8vu=JSiuJyztx3Kzg@mail.gmail.com>
Subject: Re: [PATCH v6 3/4] mptcp: build ADD_ADDR/echo-ADD_ADDR option
 according pm.add_signal
To: Yonglong Li <liyonglong@chinatelecom.cn>
Cc: mptcp@lists.linux.dev, Mat Martineau <mathew.j.martineau@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Yonglong Li <liyonglong@chinatelecom.cn> =E4=BA=8E2021=E5=B9=B46=E6=9C=8829=
=E6=97=A5=E5=91=A8=E4=BA=8C =E4=B8=8B=E5=8D=883:02=E5=86=99=E9=81=93=EF=BC=
=9A
>
>
> Hi Geiliang, Thanks for your reviews.
>
> On 2021/6/29 13:58, Geliang Tang wrote:
> > Yonglong Li <liyonglong@chinatelecom.cn> =E4=BA=8E2021=E5=B9=B46=E6=9C=
=8829=E6=97=A5=E5=91=A8=E4=BA=8C =E4=B8=8A=E5=8D=889:42=E5=86=99=E9=81=93=
=EF=BC=9A
> >>
> >> according MPTCP_ADD_ADDR_SIGNAL and MPTCP_ADD_ADDR_ECHO flag build
> >> ADD_ADDR/echo-ADD_ADDR option
> >>
> >> add a suboptions type OPTION_MPTCP_ADD_ECHO to mark as echo option
> >>
> >> Signed-off-by: Yonglong Li <liyonglong@chinatelecom.cn>
> >> ---
> >>  include/net/mptcp.h  |  3 ++-
> >>  net/mptcp/options.c  | 65 +++++++++++++++++++++++++++++++------------=
---------
> >>  net/mptcp/pm.c       | 33 +++++++++++---------------
> >>  net/mptcp/protocol.h | 23 ++++++++++++-------
> >>  4 files changed, 69 insertions(+), 55 deletions(-)
> >>
> >> diff --git a/include/net/mptcp.h b/include/net/mptcp.h
> >> index d61bbbf..d2c6ebe 100644
> >> --- a/include/net/mptcp.h
> >> +++ b/include/net/mptcp.h
> >> @@ -61,7 +61,8 @@ struct mptcp_out_options {
> >>         u64 sndr_key;
> >>         u64 rcvr_key;
> >>         u64 ahmac;
> >> -       struct mptcp_addr_info addr;
> >> +       struct mptcp_addr_info local;
> >> +       struct mptcp_addr_info remote;
> >>         struct mptcp_rm_list rm_list;
> >>         u8 join_id;
> >>         u8 backup;
> >> diff --git a/net/mptcp/options.c b/net/mptcp/options.c
> >> index 1aec016..1707bec 100644
> >> --- a/net/mptcp/options.c
> >> +++ b/net/mptcp/options.c
> >> @@ -655,13 +655,15 @@ static bool mptcp_established_options_add_addr(s=
truct sock *sk, struct sk_buff *
> >>         struct mptcp_sock *msk =3D mptcp_sk(subflow->conn);
> >>         bool drop_other_suboptions =3D false;
> >>         unsigned int opt_size =3D *size;
> >> -       bool echo;
> >> -       bool port;
> >> -       int len;
> >> +       u8 add_addr, flags =3D 0xff;
> >> +       int len =3D 0;
> >>
> >> -       if ((mptcp_pm_should_add_signal_ipv6(msk) ||
> >> -            mptcp_pm_should_add_signal_port(msk) ||
> >> -            mptcp_pm_should_add_signal_echo(msk)) &&
> >> +       if (!mptcp_pm_add_addr_signal(msk, opts, &add_addr))
> >> +               return false;
> >
> > This add_addr argument is useless, let's drop it.
> >
> we can use add_addr use in debug log.

I think it's not worth adding a new argument just for debugging.

>
> > And here add back mptcp_pm_should_add_signal check here. The original c=
ode
> > called mptcp_pm_should_add_signal twice for double check, once out of p=
m
> > lock, once under pm lock. We should keep it.
> Sorry, I think double check is not necessary. does we need double check?

I think we should keep the original logic here. If we want to drop this
double check or something, we should do it in another patch, don't mix too
much things in one patch.

>
> >
> >> +
> >> +       if ((mptcp_pm_should_add_signal_echo(msk) ||
> >> +            (mptcp_pm_should_add_signal_addr(msk) &&
> >> +             (opts->local.family =3D=3D AF_INET6 || opts->local.port)=
)) &&
> >>             skb && skb_is_tcp_pure_ack(skb)) {
> >>                 pr_debug("drop other suboptions");
> >>                 opts->suboptions =3D 0;
> >> @@ -671,11 +673,17 @@ static bool mptcp_established_options_add_addr(s=
truct sock *sk, struct sk_buff *
> >>                 drop_other_suboptions =3D true;
> >>         }
> >>
> >> -       if (!mptcp_pm_should_add_signal(msk) ||
> >> -           !(mptcp_pm_add_addr_signal(msk, remaining, &opts->addr, &e=
cho, &port)))
> >> -               return false;
> >>
> >> -       len =3D mptcp_add_addr_len(opts->addr.family, echo, port);
> >> +       if (mptcp_pm_should_add_signal_echo(msk)) {
> >> +               flags =3D (u8)~BIT(MPTCP_ADD_ADDR_ECHO);
> >> +       } else {
> >> +               opts->ahmac =3D add_addr_generate_hmac(msk->local_key,
> >> +                                                    msk->remote_key,
> >> +                                                    &opts->local);
> >
> > Keep this ahmac generating code after opts->suboptions set just like th=
e
> > original code, since ahmac is the more expensive to populate. If remain=
ing
> > length isn't enough, no need to set ahmac.
>
> because mptcp_add_addr_len(opts) will use ahmac to calculate len of opts,=
 so I think Keep this ahmac
> generating code after opts->suboptions set is not ok.

So we should use mptcp_pm_should_add_signal_addr instead of opts->ahmac in
mptcp_add_addr_len.

>
> >
> >> +               flags =3D (u8)~BIT(MPTCP_ADD_ADDR_SIGNAL);
> >> +       }
> >> +
> >> +       len =3D mptcp_add_addr_len(opts);
> >>         if (remaining < len)
> >>                 return false;
> >>
> >> @@ -683,13 +691,14 @@ static bool mptcp_established_options_add_addr(s=
truct sock *sk, struct sk_buff *
> >>         if (drop_other_suboptions)
> >>                 *size -=3D opt_size;
> >>         opts->suboptions |=3D OPTION_MPTCP_ADD_ADDR;
> >> -       if (!echo) {
> >> -               opts->ahmac =3D add_addr_generate_hmac(msk->local_key,
> >> -                                                    msk->remote_key,
> >> -                                                    &opts->addr);
> >> -       }
> >> -       pr_debug("addr_id=3D%d, ahmac=3D%llu, echo=3D%d, port=3D%d",
> >> -                opts->addr.id, opts->ahmac, echo, ntohs(opts->addr.po=
rt));
> >> +
> >> +       spin_lock_bh(&msk->pm.lock);
> >> +       WRITE_ONCE(msk->pm.addr_signal, flags & msk->pm.addr_signal);
> >> +       spin_unlock_bh(&msk->pm.lock);
> >
> > addr_signal has been set in mptcp_pm_add_addr_signal in patch 1, no nee=
d to
> > set it again. I thinks this trunk and all the flags set above should be
> > dropped.
>
> Because MPTCP_ADD_ADDR_SIGNAL and MPTCP_ADD_ADDR_ECHO maybe set at the sa=
me time.
> So i think we should only unset one flag.

We can only unset one flag in mptcp_pm_add_addr_signal, see my comment in
patch 1.

-Geliang

>
> >
> >> +
> >> +       pr_debug("addr_signal:%x, echo=3D%d, local_addr_id=3D%d, ahmac=
=3D%llu, local_port=3D%d, remote_addr_id=3D%d, remote_port=3D%d",
> >> +                add_addr, (opts->ahmac =3D=3D 0), opts->local.id,
> >> +                opts->ahmac, ntohs(opts->local.port), opts->remote.id=
, ntohs(opts->remote.port));
> >>
> >>         return true;
> >>  }
> >
> > The whole function is something like this:
> > '''
> >         struct mptcp_subflow_context *subflow =3D mptcp_subflow_ctx(sk)=
;
> >         struct mptcp_sock *msk =3D mptcp_sk(subflow->conn);
> >         bool drop_other_suboptions =3D false;
> >         unsigned int opt_size =3D *size;
> >         int len;
> >
> >         if (!mptcp_pm_should_add_signal(msk) ||
> >             !mptcp_pm_add_addr_signal(msk, remaining, opts))
> >                 return false;
> >
> >         if ((mptcp_pm_should_add_signal_echo(msk) ||
> >              (mptcp_pm_should_add_signal_addr(msk) &&
> >               (opts->local.family =3D=3D AF_INET6 || opts->local.port))=
) &&
> >             skb && skb_is_tcp_pure_ack(skb)) {
> >                 pr_debug("drop other suboptions");
> >                 opts->suboptions =3D 0;
> >                 opts->ext_copy.use_ack =3D 0;
> >                 opts->ext_copy.use_map =3D 0;
> >                 remaining +=3D opt_size;
> >                 drop_other_suboptions =3D true;
> >         }
> >
> >         len =3D mptcp_add_addr_len(opts);
> >         if (remaining < len)
> >                 return false;
> >
> >         *size =3D len;
> >         if (drop_other_suboptions)
> >                 *size -=3D opt_size;
> >         opts->suboptions |=3D OPTION_MPTCP_ADD_ADDR;
> >         if (mptcp_pm_should_add_signal_addr(msk)) {
> >                 opts->ahmac =3D add_addr_generate_hmac(msk->local_key,
> >                                                      msk->remote_key,
> >                                                      &opts->local);
> >         }
> >
> >         pr_debug("addr_signal:%x, echo=3D%d, local_addr_id=3D%d,
> > ahmac=3D%llu, local_port=3D%d, remote_addr_id=3D%d, remote_port=3D%d",
> >                  msk->pm.addr_signal, (opts->ahmac =3D=3D 0), opts->loc=
al.id,
> >                  opts->ahmac, ntohs(opts->local.port),
> > opts->remote.id, ntohs(opts->remote.port));
> >
> >         return true;
> > '''
> >
> >> @@ -1229,15 +1238,19 @@ void mptcp_write_options(__be32 *ptr, const st=
ruct tcp_sock *tp,
> >>
> >>  mp_capable_done:
> >>         if (OPTION_MPTCP_ADD_ADDR & opts->suboptions) {
> >> +               struct mptcp_addr_info *addr =3D &opts->remote;
> >
> > We can simplify it like this:
> >          struct mptcp_addr_info *addr =3D opts->ahmac ? &opts->local :
> > &opts->remote;
> >
> >>                 u8 len =3D TCPOLEN_MPTCP_ADD_ADDR_BASE;
> >>                 u8 echo =3D MPTCP_ADDR_ECHO;
> >>
> >> +               if (opts->ahmac)
> >> +                       addr =3D &opts->local;
> >
> > And this trunk can be dropped.
> >
> >> +
> >>  #if IS_ENABLED(CONFIG_MPTCP_IPV6)
> >> -               if (opts->addr.family =3D=3D AF_INET6)
> >> +               if (addr->family =3D=3D AF_INET6)
> >>                         len =3D TCPOLEN_MPTCP_ADD_ADDR6_BASE;
> >>  #endif
> >>
> >> -               if (opts->addr.port)
> >> +               if (addr->port)
> >>                         len +=3D TCPOLEN_MPTCP_PORT_LEN;
> >>
> >>                 if (opts->ahmac) {
> >> @@ -1246,25 +1259,25 @@ void mptcp_write_options(__be32 *ptr, const st=
ruct tcp_sock *tp,
> >>                 }
> >>
> >>                 *ptr++ =3D mptcp_option(MPTCPOPT_ADD_ADDR,
> >> -                                     len, echo, opts->addr.id);
> >> -               if (opts->addr.family =3D=3D AF_INET) {
> >> -                       memcpy((u8 *)ptr, (u8 *)&opts->addr.addr.s_add=
r, 4);
> >> +                                     len, echo, addr->id);
> >> +               if (addr->family =3D=3D AF_INET) {
> >> +                       memcpy((u8 *)ptr, (u8 *)&addr->addr.s_addr, 4)=
;
> >>                         ptr +=3D 1;
> >>                 }
> >>  #if IS_ENABLED(CONFIG_MPTCP_IPV6)
> >> -               else if (opts->addr.family =3D=3D AF_INET6) {
> >> -                       memcpy((u8 *)ptr, opts->addr.addr6.s6_addr, 16=
);
> >> +               else if (addr->family =3D=3D AF_INET6) {
> >> +                       memcpy((u8 *)ptr, addr->addr6.s6_addr, 16);
> >>                         ptr +=3D 4;
> >>                 }
> >>  #endif
> >>
> >> -               if (!opts->addr.port) {
> >> +               if (!addr->port) {
> >>                         if (opts->ahmac) {
> >>                                 put_unaligned_be64(opts->ahmac, ptr);
> >>                                 ptr +=3D 2;
> >>                         }
> >>                 } else {
> >> -                       u16 port =3D ntohs(opts->addr.port);
> >> +                       u16 port =3D ntohs(addr->port);
> >>
> >>                         if (opts->ahmac) {
> >>                                 u8 *bptr =3D (u8 *)ptr;
> >> diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
> >> index cf873e9..9c621293 100644
> >> --- a/net/mptcp/pm.c
> >> +++ b/net/mptcp/pm.c
> >> @@ -253,32 +253,25 @@ void mptcp_pm_mp_prio_received(struct sock *sk, =
u8 bkup)
> >>
> >>  /* path manager helpers */
> >>
> >> -bool mptcp_pm_add_addr_signal(struct mptcp_sock *msk, unsigned int re=
maining,
> >> -                             struct mptcp_addr_info *saddr, bool *ech=
o, bool *port)
> >> +bool mptcp_pm_add_addr_signal(struct mptcp_sock *msk, struct mptcp_ou=
t_options *opts,
> >> +                             u8 *add_addr)
> >
> > Drop this add_addr argument.
> >
> >>  {
> >> -       u8 add_addr;
> >> -       int ret =3D false;
> >> -
> >>         spin_lock_bh(&msk->pm.lock);
> >>
> >> -       /* double check after the lock is acquired */
> >> -       if (!mptcp_pm_should_add_signal(msk))
> >> -               goto out_unlock;
> >
> > Keep this double check code.
> >
> >> -
> >> -       *echo =3D mptcp_pm_should_add_signal_echo(msk);
> >> -       *port =3D mptcp_pm_should_add_signal_port(msk);
> >> -
> >> -       if (remaining < mptcp_add_addr_len(msk->pm.local.family, *echo=
, *port))
> >> -               goto out_unlock;
> >
> > Keep this length double check code too.
> >
> >> +       if (!mptcp_pm_should_add_signal(msk)) {
> >> +               spin_unlock_bh(&msk->pm.lock);
> >> +               return false;
> >> +       }
> >>
> >> -       *saddr =3D msk->pm.local;
> >> -       add_addr =3D msk->pm.addr_signal & ~(BIT(MPTCP_ADD_ADDR_SIGNAL=
) | BIT(MPTCP_ADD_ADDR_ECHO));
> > -       WRITE_ONCE(msk->pm.addr_signal, add_addr);
> >
> > This code is just added in patch 1, I think we should keep it. And no n=
eed
> > to write addr_signal again in mptcp_established_options_add_addr.
> >
> >> -       ret =3D true;
> >> +       opts->local =3D msk->pm.local;
> >> +       opts->remote =3D msk->pm.remote;
> >> +       *add_addr =3D msk->pm.addr_signal;
> >>
> >> -out_unlock:
> >>         spin_unlock_bh(&msk->pm.lock);
> >> -       return ret;
> >
> > Keep this out_unlock code.
> >
> >> +
> >> +       if ((mptcp_pm_should_add_signal_echo(msk)) && (mptcp_pm_should=
_add_signal_addr(msk)))
> >> +               mptcp_pm_schedule_work(msk, MPTCP_PM_ADD_ADDR_SEND_ACK=
);
> >
> > Could we use mptcp_pm_add_addr_send_ack here instead of open coding?
> >
> > I'm no sure why we need this two lines, and why you use '&&' here. Do y=
ou
> > mean set MPTCP_ADD_ADDR_SIGNAL and MPTCP_ADD_ADDR_ECHO at the same time=
?
> >
> >> +       return true;
> >>  }
> >
> > The whole function is something like this:
> > '''
> >         int ret =3D false;
> >         u8 add_addr;
> >
> >         spin_lock_bh(&msk->pm.lock);
> >
> >         /* double check after the lock is acquired */
> >         if (!mptcp_pm_should_add_signal(msk))
> >                 goto out_unlock;
> >
> >         if (remaining < mptcp_add_addr_len(opts))
> >                 goto out_unlock;
> >
> >         opts->local =3D msk->pm.local;
> >         opts->remote =3D msk->pm.remote;
> >         if (mptcp_pm_should_add_signal_echo(msk))
> >                 add_addr =3D msk->pm.addr_signal & ~BIT(MPTCP_ADD_ADDR_=
ECHO);
> >         else
> >                 add_addr =3D msk->pm.addr_signal & ~BIT(MPTCP_ADD_ADDR_=
SIGNAL);
> >         WRITE_ONCE(msk->pm.addr_signal, add_addr);
> >         ret =3D true;
> >
> > out_unlock:
> >         spin_unlock_bh(&msk->pm.lock);
> >         if (ret && mptcp_pm_should_add_signal_echo(msk) &&
> > mptcp_pm_should_add_signal_addr(msk))
> >                 mptcp_pm_schedule_work(msk, MPTCP_PM_ADD_ADDR_SEND_ACK)=
;
> >         return ret;
> > '''
> >
> >>
> >>  bool mptcp_pm_rm_addr_signal(struct mptcp_sock *msk, unsigned int rem=
aining,
> >> diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
> >> index a0b0ec0..0bfbbdef 100644
> >> --- a/net/mptcp/protocol.h
> >> +++ b/net/mptcp/protocol.h
> >> @@ -737,16 +737,23 @@ static inline bool mptcp_pm_should_rm_signal(str=
uct mptcp_sock *msk)
> >>         return READ_ONCE(msk->pm.addr_signal) & BIT(MPTCP_RM_ADDR_SIGN=
AL);
> >>  }
> >>
> >> -static inline unsigned int mptcp_add_addr_len(int family, bool echo, =
bool port)
> >> +static inline unsigned int mptcp_add_addr_len(struct mptcp_out_option=
s *opts)
> >>  {
> >> -       u8 len =3D TCPOLEN_MPTCP_ADD_ADDR_BASE;
> >> +       u8 len =3D 0;
> >> +       struct mptcp_addr_info *addr =3D &opts->remote;
> >
> > We can simplify it like this:
> >          struct mptcp_addr_info *addr =3D opts->ahmac ? &opts->local :
> > &opts->remote;
> >
> > And keep the orignal code unchanged.
> >
> >>
> >> -       if (family =3D=3D AF_INET6)
> >> -               len =3D TCPOLEN_MPTCP_ADD_ADDR6_BASE;
> >> -       if (!echo)
> >> +       if (opts->ahmac) {
> >> +               addr =3D &opts->local;
> >>                 len +=3D MPTCPOPT_THMAC_LEN;
> >> +       }
> >> +
> >> +       if (addr->family =3D=3D AF_INET6)
> >> +               len +=3D TCPOLEN_MPTCP_ADD_ADDR6_BASE;
> >> +       else
> >> +               len +=3D TCPOLEN_MPTCP_ADD_ADDR_BASE;
> >> +
> >>         /* account for 2 trailing 'nop' options */
> >> -       if (port)
> >> +       if (addr->port)
> >>                 len +=3D TCPOLEN_MPTCP_PORT_LEN + TCPOLEN_MPTCP_PORT_A=
LIGN;
> >>
> >>         return len;
> >
> > The whole function is something like this:
> > '''
> >         struct mptcp_addr_info *addr =3D opts->ahmac ? &opts->local :
> > &opts->remote;
> >         u8 len =3D TCPOLEN_MPTCP_ADD_ADDR_BASE;
> >
> >         if (addr->family =3D=3D AF_INET6)
> >                 len =3D TCPOLEN_MPTCP_ADD_ADDR6_BASE;
> >         if (opts->ahmac)
> >                 len +=3D MPTCPOPT_THMAC_LEN;
> >         /* account for 2 trailing 'nop' options */
> >         if (addr->port)
> >                 len +=3D TCPOLEN_MPTCP_PORT_LEN + TCPOLEN_MPTCP_PORT_AL=
IGN;
> >
> >         return len;
> > '''
> >
> > Thanks.
> > -Geliang
> >
> >> @@ -760,8 +767,8 @@ static inline int mptcp_rm_addr_len(const struct m=
ptcp_rm_list *rm_list)
> >>         return TCPOLEN_MPTCP_RM_ADDR_BASE + roundup(rm_list->nr - 1, 4=
) + 1;
> >>  }
> >>
> >> -bool mptcp_pm_add_addr_signal(struct mptcp_sock *msk, unsigned int re=
maining,
> >> -                             struct mptcp_addr_info *saddr, bool *ech=
o, bool *port);
> >> +bool mptcp_pm_add_addr_signal(struct mptcp_sock *msk, struct mptcp_ou=
t_options *opts,
> >> +                             u8 *add_addr);
> >>  bool mptcp_pm_rm_addr_signal(struct mptcp_sock *msk, unsigned int rem=
aining,
> >>                              struct mptcp_rm_list *rm_list);
> >>  int mptcp_pm_get_local_id(struct mptcp_sock *msk, struct sock_common =
*skc);
> >> --
> >> 1.8.3.1
> >>
> >>
> >
> >
>
> --
> Li YongLong
