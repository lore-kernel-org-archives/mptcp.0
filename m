Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3CD871
	for <mptcp@lists.linux.dev>; Mon, 21 Jun 2021 06:42:16 +0000 (UTC)
Received: by mail-pl1-f180.google.com with SMTP id v12so7982463plo.10
        for <mptcp@lists.linux.dev>; Sun, 20 Jun 2021 23:42:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=3VGnFOWTELBf3nFLNz3Qwgf0NLNFoAqaZeYel5PRWtE=;
        b=XyLCUsFzo66JiZhxJXNRpZcvwnmQBygdwhe4LJYguJ7GaOV3jXZdnpMtngYvIfRGGW
         iFwlAH0w9zAwu89gNoglO7t4O80jwP0ZwMFIuSlPRElI3jKgJhAgVgrh3hbsGzibRHAC
         UPLaEX1bdSdEw6K6LVZlfEDuf3bl9Xxigf66VBieGAQyWJviRgL9uLY/4eB27bahCH25
         zmMUIJ012nzdinUYtVWT+WBo7f5kOkjXNs5b96kzh5nqeA8vZIfiBkJP0r9B78OLzucQ
         LVjhMaSRcZkKA3NgR+XOEQZgX+saOjnr5S4QUQVs/bg/hryeBK4otwuMYkSeoAto9NrX
         0HhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=3VGnFOWTELBf3nFLNz3Qwgf0NLNFoAqaZeYel5PRWtE=;
        b=EygJsB6Q4BqeUdvsdo77bbDif9sIOTYQj1V4SfWw7z0Mx2HTJ5VN3xhxIqSXBj8nTx
         xizLwBlbdDr+5bXBvX9LfhYJfWbazeofA4yOdd2QtmyQOmUWQ8fY71001XXOAu3yGjup
         gh07Ihq5L/Upqa5jhMCAQ4p9zJ8/Ic2BXBPSKZOliYZv9e5MRv8xShOegMVRBa0QD4aM
         Og0Uuj25yJxOedctlC6jKyec9/Tk32g2captmykrPTH2LksjDkzeN44/6znxVD9Pfm8e
         GRVajHpBCx6BmOmDbjplIqeKuQqoR1IZK6KWhQW7HLvIwdNTObn74pt2Fre38UQa0Iz1
         nPVQ==
X-Gm-Message-State: AOAM530gsambg8upc4gC+ZvJEBxTaYti5LM9IS43tbIvr3kJKJUcEqO4
	rdDq7ZcyKl6pV+nKRcbxdoTsl+dmGn9bJVhQCPk=
X-Google-Smtp-Source: ABdhPJxVCtz682NQJexnhJ5tSfL5xuHQr1F5GG6U/MwHLLGQe2F+C6VI2Ss6dHh+xyFF4XvqGHXCVj/qALZF0wyemKk=
X-Received: by 2002:a17:902:446:b029:120:1fd:adbf with SMTP id
 64-20020a1709020446b029012001fdadbfmr16773469ple.52.1624257736536; Sun, 20
 Jun 2021 23:42:16 -0700 (PDT)
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <1624004309-54480-1-git-send-email-liyonglong@chinatelecom.cn>
 <1624004309-54480-4-git-send-email-liyonglong@chinatelecom.cn>
 <CA+WQbwsSmzxw5c-pPJNYndQ99FKmFXSuKD6kxpQgwJGe9Q2kpQ@mail.gmail.com> <85720e69-d6d4-4a9b-9f1c-0898a1cf5009@chinatelecom.cn>
In-Reply-To: <85720e69-d6d4-4a9b-9f1c-0898a1cf5009@chinatelecom.cn>
From: Geliang Tang <geliangtang@gmail.com>
Date: Mon, 21 Jun 2021 14:42:05 +0800
Message-ID: <CA+WQbwt0adACAC0HB_KteK8MtHbNjwV2GPfkn1s_DsWJL1pgqQ@mail.gmail.com>
Subject: Re: [PATCH v4 3/4] mptcp: build ADD_ADDR/echo-ADD_ADDR option
 according pm.add_signal
To: Yonglong Li <liyonglong@chinatelecom.cn>
Cc: mptcp@lists.linux.dev, Mat Martineau <mathew.j.martineau@linux.intel.com>, 
	qitiepeng@chinatelecom.cn
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Yonglong,

Yonglong Li <liyonglong@chinatelecom.cn> =E4=BA=8E2021=E5=B9=B46=E6=9C=8821=
=E6=97=A5=E5=91=A8=E4=B8=80 =E4=B8=8A=E5=8D=8811:52=E5=86=99=E9=81=93=EF=BC=
=9A
>
>
>
> On 2021/6/18 19:20, Geliang Tang wrote:
> > Hi Yonglong,
> >
> > Thanks for v4!
> >
> > Yonglong Li <liyonglong@chinatelecom.cn> =E4=BA=8E2021=E5=B9=B46=E6=9C=
=8818=E6=97=A5=E5=91=A8=E4=BA=94 =E4=B8=8B=E5=8D=884:19=E5=86=99=E9=81=93=
=EF=BC=9A
> >>
> >> according MPTCP_ADD_ADDR_SIGNAL and MPTCP_ADD_ADDR_ECHO flag build
> >> ADD_ADDR/echo-ADD_ADDR option
> >>
> >> add a suboptions type OPTION_MPTCP_ADD_ECHO to mark as echo option
> >>
> >> Signed-off-by: Yonglong Li <liyonglong@chinatelecom.cn>
> >> ---
> >>  net/mptcp/options.c  | 124 +++++++++++++++++++++++++++++++-----------=
---------
> >>  net/mptcp/pm.c       |  30 ++++---------
> >>  net/mptcp/protocol.h |  13 +++---
> >>  3 files changed, 92 insertions(+), 75 deletions(-)
> >>
> >> diff --git a/net/mptcp/options.c b/net/mptcp/options.c
> >> index 1aec016..43e3241 100644
> >> --- a/net/mptcp/options.c
> >> +++ b/net/mptcp/options.c
> >> @@ -655,41 +655,64 @@ static bool mptcp_established_options_add_addr(s=
truct sock *sk, struct sk_buff *
> >>         struct mptcp_sock *msk =3D mptcp_sk(subflow->conn);
> >>         bool drop_other_suboptions =3D false;
> >>         unsigned int opt_size =3D *size;
> >> -       bool echo;
> >> -       bool port;
> >> +       struct mptcp_addr_info remote;
> >> +       struct mptcp_addr_info local;
> >> +       u8 add_addr, flags =3D 0xff;
> >>         int len;
> >>
> >> -       if ((mptcp_pm_should_add_signal_ipv6(msk) ||
> >> -            mptcp_pm_should_add_signal_port(msk) ||
> >> -            mptcp_pm_should_add_signal_echo(msk)) &&
> >> -           skb && skb_is_tcp_pure_ack(skb)) {
> >> -               pr_debug("drop other suboptions");
> >> -               opts->suboptions =3D 0;
> >> -               opts->ext_copy.use_ack =3D 0;
> >> -               opts->ext_copy.use_map =3D 0;
> >> -               remaining +=3D opt_size;
> >> -               drop_other_suboptions =3D true;
> >> -       }
> >> -
> >> -       if (!mptcp_pm_should_add_signal(msk) ||
> >> -           !(mptcp_pm_add_addr_signal(msk, remaining, &opts->addr, &e=
cho, &port)))
> >> -               return false;
> >> -
> >> -       len =3D mptcp_add_addr_len(opts->addr.family, echo, port);
> >> -       if (remaining < len)
> >> +       if (!mptcp_pm_should_add_signal(msk))
> >>                 return false;
> >>
> >> -       *size =3D len;
> >> -       if (drop_other_suboptions)
> >> -               *size -=3D opt_size;
> >> -       opts->suboptions |=3D OPTION_MPTCP_ADD_ADDR;
> >> -       if (!echo) {
> >> +       *size =3D 0;
> >> +       mptcp_pm_add_addr_signal(msk, &local, &remote, &add_addr);
> >> +       if (mptcp_pm_should_add_signal_echo(msk)) {
> >> +               if (skb && skb_is_tcp_pure_ack(skb)) {
> >
> > '''
> >> +                       pr_debug("drop other suboptions");
> >> +                       opts->suboptions =3D 0;
> >> +                       opts->ext_copy.use_ack =3D 0;
> >> +                       opts->ext_copy.use_map =3D 0;
> >> +                       remaining +=3D opt_size;
> >> +                       drop_other_suboptions =3D true;
> > '''
> >
> >> +               }
> >> +               len =3D mptcp_add_addr_len(remote.family, true, !!remo=
te.port);
> >> +               if (remaining < len)
> >> +                       return false;
> >> +               remaining -=3D len;
> >> +               *size +=3D len;
> >> +               opts->remote =3D remote;
> >> +               flags =3D (u8)~BIT(MPTCP_ADD_ADDR_ECHO);
> >> +               opts->suboptions |=3D OPTION_MPTCP_ADD_ECHO;
> >> +               pr_debug("addr_id=3D%d, echo=3D1, port=3D%d addr_signa=
l:%x",
> >> +                        opts->remote.id, ntohs(opts->remote.port), ad=
d_addr);
> >> +       } else if (mptcp_pm_should_add_signal_addr(msk)) {
> >> +               if ((local.family =3D=3D AF_INET6 || local.port) && sk=
b &&
> >> +                   skb_is_tcp_pure_ack(skb)) {
> >
> > '''
> >> +                       pr_debug("drop other suboptions");
> >> +                       opts->suboptions =3D 0;
> >> +                       opts->ext_copy.use_ack =3D 0;
> >> +                       opts->ext_copy.use_map =3D 0;
> >> +                       remaining +=3D opt_size;
> >> +                       drop_other_suboptions =3D true;
> > '''
> >
> > I think this "drop other suboptions" trunk here is still duplicated. Ca=
n
> > we just use one "drop other suboptions" trunk only?
> >
> > Thanks.
> > -Geliang
> >
> Hi Geliang, Thanks for you replay.
>
> The commit "07f8252fe0e3c2b6320eeff18bdc5b7fb8845cb3" Davide said "echo-e=
d ADD_ADDR
> carried over pure TCP ACKs, so there is no need to add a DSS element that=
 would fit
> only ADD_ADDR with IPv4 address.Drop the DSS from echo-ed ADD_ADDR, regar=
dless of the
> IP version."
> ADD_ADDR option can add with DSS if the addr is IPv4. So I think it is mo=
re clear
> to decide "drop other suboptions" in two trunk.

Could we change it like this:

'''
diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index e77b5d532fb8..8b4cb0581a49 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -673,15 +673,20 @@ static bool
mptcp_established_options_add_addr(struct sock *sk, struct sk_buff *

        *size =3D 0;
        mptcp_pm_add_addr_signal(msk, &local, &remote, &add_addr);
+
+       if ((mptcp_pm_should_add_signal_echo(msk) ||
+           (mptcp_pm_should_add_signal_addr(msk) &&
+           (local.family =3D=3D AF_INET6 || local.port))) &&
+           skb && skb_is_tcp_pure_ack(skb)) {
+               pr_debug("drop other suboptions");
+               opts->suboptions =3D 0;
+               opts->ext_copy.use_ack =3D 0;
+               opts->ext_copy.use_map =3D 0;
+               remaining +=3D opt_size;
+               drop_other_suboptions =3D true;
+       }
+
        if (mptcp_pm_should_add_signal_echo(msk)) {
-               if (skb && skb_is_tcp_pure_ack(skb)) {
-                       pr_debug("drop other suboptions");
-                       opts->suboptions =3D 0;
-                       opts->ext_copy.use_ack =3D 0;
-                       opts->ext_copy.use_map =3D 0;
-                       remaining +=3D opt_size;
-                       drop_other_suboptions =3D true;
-               }
                len =3D mptcp_add_addr_len(remote.family, true, !!remote.po=
rt);
                if (remaining < len)
                        return false;
@@ -693,15 +698,6 @@ static bool
mptcp_established_options_add_addr(struct sock *sk, struct sk_buff *
                pr_debug("addr_id=3D%d, echo=3D1, port=3D%d addr_signal:%x"=
,
                         opts->remote.id, ntohs(opts->remote.port), add_add=
r);
        } else if (mptcp_pm_should_add_signal_addr(msk)) {
-               if ((local.family =3D=3D AF_INET6 || local.port) && skb &&
-                   skb_is_tcp_pure_ack(skb)) {
-                       pr_debug("drop other suboptions");
-                       opts->suboptions =3D 0;
-                       opts->ext_copy.use_ack =3D 0;
-                       opts->ext_copy.use_map =3D 0;
-                       remaining +=3D opt_size;
-                       drop_other_suboptions =3D true;
-               }
                len =3D mptcp_add_addr_len(local.family, false, !!local.por=
t);
                if (remaining < len)
                        return false;
'''
WDYT?

>
> >
> >
> >> +               }
> >> +               len =3D mptcp_add_addr_len(local.family, false, !!loca=
l.port);
> >> +               if (remaining < len)
> >> +                       return false;

And here, I think "remaining -=3D len;" is missing.

Thanks,
-Geliang


> >> +               *size +=3D len;
> >> +               opts->addr =3D local;
> >>                 opts->ahmac =3D add_addr_generate_hmac(msk->local_key,
> >>                                                      msk->remote_key,
> >>                                                      &opts->addr);
> >> +               opts->suboptions |=3D OPTION_MPTCP_ADD_ADDR;
> >> +               flags =3D (u8)~BIT(MPTCP_ADD_ADDR_SIGNAL);
> >> +               pr_debug("addr_id=3D%d, ahmac=3D%llu, echo=3D0, port=
=3D%d, addr_signal:%x",
> >> +                        opts->addr.id, opts->ahmac, ntohs(opts->addr.=
port), add_addr);
> >>         }
> >> -       pr_debug("addr_id=3D%d, ahmac=3D%llu, echo=3D%d, port=3D%d",
> >> -                opts->addr.id, opts->ahmac, echo, ntohs(opts->addr.po=
rt));
> >> +
> >> +       if (drop_other_suboptions)
> >> +               *size -=3D opt_size;
> >> +       spin_lock_bh(&msk->pm.lock);
> >> +       WRITE_ONCE(msk->pm.addr_signal, flags & msk->pm.addr_signal);
> >> +       spin_unlock_bh(&msk->pm.lock);
> >>
> >>         return true;
> >>  }
> >> @@ -1228,45 +1251,51 @@ void mptcp_write_options(__be32 *ptr, const st=
ruct tcp_sock *tp,
> >>         }
> >>
> >>  mp_capable_done:
> >> -       if (OPTION_MPTCP_ADD_ADDR & opts->suboptions) {
> >> -               u8 len =3D TCPOLEN_MPTCP_ADD_ADDR_BASE;
> >> -               u8 echo =3D MPTCP_ADDR_ECHO;
> >> +       if ((OPTION_MPTCP_ADD_ADDR | OPTION_MPTCP_ADD_ECHO) & opts->su=
boptions) {
> >> +               struct mptcp_addr_info *addr_info;
> >> +               u8 len =3D 0;
> >> +               u8 echo =3D 0;
> >> +
> >> +               if (OPTION_MPTCP_ADD_ADDR & opts->suboptions) {
> >> +                       len +=3D sizeof(opts->ahmac);
> >> +                       addr_info =3D &opts->addr;
> >> +               } else {
> >> +                       echo =3D MPTCP_ADDR_ECHO;
> >> +                       addr_info =3D &opts->remote;
> >> +               }
> >>
> >>  #if IS_ENABLED(CONFIG_MPTCP_IPV6)
> >> -               if (opts->addr.family =3D=3D AF_INET6)
> >> -                       len =3D TCPOLEN_MPTCP_ADD_ADDR6_BASE;
> >> +               if (addr_info->family =3D=3D AF_INET6)
> >> +                       len +=3D TCPOLEN_MPTCP_ADD_ADDR6_BASE;
> >> +               else
> >>  #endif
> >> +                       len +=3D TCPOLEN_MPTCP_ADD_ADDR_BASE;
> >>
> >> -               if (opts->addr.port)
> >> +               if (addr_info->port)
> >>                         len +=3D TCPOLEN_MPTCP_PORT_LEN;
> >>
> >> -               if (opts->ahmac) {
> >> -                       len +=3D sizeof(opts->ahmac);
> >> -                       echo =3D 0;
> >> -               }
> >> -
> >>                 *ptr++ =3D mptcp_option(MPTCPOPT_ADD_ADDR,
> >> -                                     len, echo, opts->addr.id);
> >> -               if (opts->addr.family =3D=3D AF_INET) {
> >> -                       memcpy((u8 *)ptr, (u8 *)&opts->addr.addr.s_add=
r, 4);
> >> +                                     len, echo, addr_info->id);
> >> +               if (addr_info->family =3D=3D AF_INET) {
> >> +                       memcpy((u8 *)ptr, (u8 *)&addr_info->addr.s_add=
r, 4);
> >>                         ptr +=3D 1;
> >>                 }
> >>  #if IS_ENABLED(CONFIG_MPTCP_IPV6)
> >> -               else if (opts->addr.family =3D=3D AF_INET6) {
> >> -                       memcpy((u8 *)ptr, opts->addr.addr6.s6_addr, 16=
);
> >> +               else if (addr_info->family =3D=3D AF_INET6) {
> >> +                       memcpy((u8 *)ptr, addr_info->addr6.s6_addr, 16=
);
> >>                         ptr +=3D 4;
> >>                 }
> >>  #endif
> >>
> >> -               if (!opts->addr.port) {
> >> -                       if (opts->ahmac) {
> >> +               if (!addr_info->port) {
> >> +                       if (!echo) {
> >>                                 put_unaligned_be64(opts->ahmac, ptr);
> >>                                 ptr +=3D 2;
> >>                         }
> >>                 } else {
> >> -                       u16 port =3D ntohs(opts->addr.port);
> >> +                       u16 port =3D ntohs(addr_info->port);
> >>
> >> -                       if (opts->ahmac) {
> >> +                       if (!echo) {
> >>                                 u8 *bptr =3D (u8 *)ptr;
> >>
> >>                                 put_unaligned_be16(port, bptr);
> >> @@ -1275,7 +1304,6 @@ void mptcp_write_options(__be32 *ptr, const stru=
ct tcp_sock *tp,
> >>                                 bptr +=3D 8;
> >>                                 put_unaligned_be16(TCPOPT_NOP << 8 |
> >>                                                    TCPOPT_NOP, bptr);
> >> -
> >>                                 ptr +=3D 3;
> >>                         } else {
> >>                                 put_unaligned_be32(port << 16 |
> >> diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
> >> index 107a5a2..a62d4a5 100644
> >> --- a/net/mptcp/pm.c
> >> +++ b/net/mptcp/pm.c
> >> @@ -22,7 +22,8 @@ int mptcp_pm_announce_addr(struct mptcp_sock *msk,
> >>
> >>         lockdep_assert_held(&msk->pm.lock);
> >>
> >> -       if (add_addr) {
> >> +       if (add_addr &
> >> +           (echo ? BIT(MPTCP_ADD_ADDR_ECHO) : BIT(MPTCP_ADD_ADDR_SIGN=
AL))) {
> >>                 pr_warn("addr_signal error, add_addr=3D%d", add_addr);
> >>                 return -EINVAL;
> >>         }
> >> @@ -252,32 +253,19 @@ void mptcp_pm_mp_prio_received(struct sock *sk, =
u8 bkup)
> >>
> >>  /* path manager helpers */
> >>
> >> -bool mptcp_pm_add_addr_signal(struct mptcp_sock *msk, unsigned int re=
maining,
> >> -                             struct mptcp_addr_info *saddr, bool *ech=
o, bool *port)
> >> +void mptcp_pm_add_addr_signal(struct mptcp_sock *msk, struct mptcp_ad=
dr_info *saddr,
> >> +                             struct mptcp_addr_info *daddr, u8 *add_a=
ddr)
> >>  {
> >> -       u8 add_addr;
> >> -       int ret =3D false;
> >> -
> >>         spin_lock_bh(&msk->pm.lock);
> >>
> >> -       /* double check after the lock is acquired */
> >> -       if (!mptcp_pm_should_add_signal(msk))
> >> -               goto out_unlock;
> >> -
> >> -       *echo =3D mptcp_pm_should_add_signal_echo(msk);
> >> -       *port =3D mptcp_pm_should_add_signal_port(msk);
> >> -
> >> -       if (remaining < mptcp_add_addr_len(msk->pm.local.family, *echo=
, *port))
> >> -               goto out_unlock;
> >> -
> >>         *saddr =3D msk->pm.local;
> >> -       add_addr =3D msk->pm.addr_signal & ~(BIT(MPTCP_ADD_ADDR_SIGNAL=
) | BIT(MPTCP_ADD_ADDR_ECHO));
> >> -       WRITE_ONCE(msk->pm.addr_signal, add_addr);
> >> -       ret =3D true;
> >> +       *daddr =3D msk->pm.remote;
> >> +       *add_addr =3D msk->pm.addr_signal;
> >>
> >> -out_unlock:
> >>         spin_unlock_bh(&msk->pm.lock);
> >> -       return ret;
> >> +
> >> +       if ((mptcp_pm_should_add_signal_echo(msk)) && (mptcp_pm_should=
_add_signal_addr(msk)))
> >> +               mptcp_pm_schedule_work(msk, MPTCP_PM_ADD_ADDR_SEND_ACK=
);
> >>  }
> >>
> >>  bool mptcp_pm_rm_addr_signal(struct mptcp_sock *msk, unsigned int rem=
aining,
> >> diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
> >> index a0b0ec0..90fb532 100644
> >> --- a/net/mptcp/protocol.h
> >> +++ b/net/mptcp/protocol.h
> >> @@ -22,10 +22,11 @@
> >>  #define OPTION_MPTCP_MPJ_SYNACK        BIT(4)
> >>  #define OPTION_MPTCP_MPJ_ACK   BIT(5)
> >>  #define OPTION_MPTCP_ADD_ADDR  BIT(6)
> >> -#define OPTION_MPTCP_RM_ADDR   BIT(7)
> >> -#define OPTION_MPTCP_FASTCLOSE BIT(8)
> >> -#define OPTION_MPTCP_PRIO      BIT(9)
> >> -#define OPTION_MPTCP_RST       BIT(10)
> >> +#define OPTION_MPTCP_ADD_ECHO  BIT(7)
> >> +#define OPTION_MPTCP_RM_ADDR   BIT(8)
> >> +#define OPTION_MPTCP_FASTCLOSE BIT(9)
> >> +#define OPTION_MPTCP_PRIO      BIT(10)
> >> +#define OPTION_MPTCP_RST       BIT(11)
> >>
> >>  /* MPTCP option subtypes */
> >>  #define MPTCPOPT_MP_CAPABLE    0
> >> @@ -760,8 +761,8 @@ static inline int mptcp_rm_addr_len(const struct m=
ptcp_rm_list *rm_list)
> >>         return TCPOLEN_MPTCP_RM_ADDR_BASE + roundup(rm_list->nr - 1, 4=
) + 1;
> >>  }
> >>
> >> -bool mptcp_pm_add_addr_signal(struct mptcp_sock *msk, unsigned int re=
maining,
> >> -                             struct mptcp_addr_info *saddr, bool *ech=
o, bool *port);
> >> +void mptcp_pm_add_addr_signal(struct mptcp_sock *msk, struct mptcp_ad=
dr_info *saddr,
> >> +                             struct mptcp_addr_info *daddr, u8 *add_a=
ddr);
> >>  bool mptcp_pm_rm_addr_signal(struct mptcp_sock *msk, unsigned int rem=
aining,
> >>                              struct mptcp_rm_list *rm_list);
> >>  int mptcp_pm_get_local_id(struct mptcp_sock *msk, struct sock_common =
*skc);
> >> --
> >> 1.8.3.1
> >>
> >
