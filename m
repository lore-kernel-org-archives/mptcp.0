Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F07C772
	for <mptcp@lists.linux.dev>; Mon, 12 Jul 2021 09:07:48 +0000 (UTC)
Received: by mail-pl1-f180.google.com with SMTP id h1so8821393plf.6
        for <mptcp@lists.linux.dev>; Mon, 12 Jul 2021 02:07:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=NH64oPJ1vjSQaETbZq1x5AG7LvwnUIvjNPXKqvQfMoQ=;
        b=VnTUlILE3RYRka1jykFovp/dgteWMxFJTwL6wF/AJfjpPI5IzUNlDYlgMQPFaDjrtV
         vsuYsdHWhTFgO2B76PrEIK0JGoFNTtIRYOgzvKiPLqijBBzwWLUi58uz1ga0zOMCWBAW
         ApYRLAB88828x9tnSVs8Bi9+RiOSd6rRavAjs62SA/rGDRCpgnrdepcCiHCX6skAjwiG
         FeEzl9fCwuYjxVal9azTlM8ASJpBSu/hp6FFEelvYLCqgLxkFu2JyjX2bfOUrnxolhp3
         vqc5O8DGozN1vuj6jplmdqXb27j1nIy3EJozHxxPE323ch55+VIestpX96TZN/W0mV+9
         4IjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=NH64oPJ1vjSQaETbZq1x5AG7LvwnUIvjNPXKqvQfMoQ=;
        b=t464YEhFgElT6VcMXkG+7qWS1X2V5KzSTA8jkZX/k7yKw2285O/BPnb2NLkqx53gu6
         totGlkGyBqsZEY9KtRbImTCFVakSbQ0Qu2V7zVQuUs3/S+uSeVlOcJ80GW/4IFy7qHQy
         cEp5KxT3QNZxMHtWZXmgMkSgGDIAuzJrQl+qJbuWiwYg81IHgcJvz3tH4WUsMDNFDOHn
         A9BPxrBbn4MXhRoa2k7MA8u7DA9xRwagFRQSXuL2o7UCJu4e85WlqMprLy12lrQ6XXNW
         wAeqwbtoq6DlZOOkxsTeqwaFJWpZwprwzJVmPnCBLCquNVYOGWbSUn4o+kRmZAdyYh70
         oOCQ==
X-Gm-Message-State: AOAM533v7qLydEwFhIT5i3AqwVuiiJwF1lx7xIvsOD0DVVpI0Q8D2NoH
	F74/p8DfgcrEUExly+6VafxLKOwOUfPB63k8f3w=
X-Google-Smtp-Source: ABdhPJwp1Q8YtSV+mqpwp1x1OaeOXHCzS+s+1isNMF30A9UKmkVwqukw8dHizb0P7F0FDNMZ0E1HTrNM4VVSNAtBS+c=
X-Received: by 2002:a17:902:bf45:b029:129:8147:3a93 with SMTP id
 u5-20020a170902bf45b029012981473a93mr36166126pls.84.1626080868480; Mon, 12
 Jul 2021 02:07:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <9365b79b245b8a87af18ca458c67820d47de2515.1626016228.git.geliangtang@gmail.com>
 <80fa33a249c2ecc7edd9d0047dd84f163307cee7.1626016292.git.geliangtang@gmail.com>
 <347f6214-cc6b-2af2-c1e7-d9ac7f77f87e@chinatelecom.cn> <CA+WQbwuTFxxzsbDdeiWgMN7iqUp9e-ubAmsLa7JpaZbQ+WSBBw@mail.gmail.com>
 <4f790fa7-f99e-401e-d266-8fd85921204a@chinatelecom.cn> <CA+WQbwsuJTtVZ_hW1K25a4YOkSs7DGKOnjt=escT66QQg8WjRQ@mail.gmail.com>
In-Reply-To: <CA+WQbwsuJTtVZ_hW1K25a4YOkSs7DGKOnjt=escT66QQg8WjRQ@mail.gmail.com>
From: Geliang Tang <geliangtang@gmail.com>
Date: Mon, 12 Jul 2021 17:07:37 +0800
Message-ID: <CA+WQbwsd_3AqgwawQu_6socwuviNXMrck-BxjMJ+PU-D9QVX9g@mail.gmail.com>
Subject: Re: [MPTCP][PATCH mptcp-next] Squash to "mptcp: build
 ADD_ADDR/echo-ADD_ADDR option according pm.add_signal"
To: Yonglong Li <liyonglong@chinatelecom.cn>
Cc: mptcp@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Geliang Tang <geliangtang@gmail.com> =E4=BA=8E2021=E5=B9=B47=E6=9C=8812=E6=
=97=A5=E5=91=A8=E4=B8=80 =E4=B8=8B=E5=8D=884:44=E5=86=99=E9=81=93=EF=BC=9A
>
> Yonglong Li <liyonglong@chinatelecom.cn> =E4=BA=8E2021=E5=B9=B47=E6=9C=88=
12=E6=97=A5=E5=91=A8=E4=B8=80 =E4=B8=8B=E5=8D=884:07=E5=86=99=E9=81=93=EF=
=BC=9A
> >
> >
> >
> > On 2021/7/12 15:33, Geliang Tang wrote:
> > > Hi Yonglong,
> > >
> > > Yonglong Li <liyonglong@chinatelecom.cn> =E4=BA=8E2021=E5=B9=B47=E6=
=9C=8812=E6=97=A5=E5=91=A8=E4=B8=80 =E4=B8=8A=E5=8D=889:34=E5=86=99=E9=81=
=93=EF=BC=9A
> > >>
> > >>
> > >>
> > >> On 2021/7/11 23:15, Geliang Tang wrote:
> > >>> I think there're still some issues in v8:
> > >>>
> > >>> The remaining value is incorrect since "remaining +=3D opt_size;" i=
n the
> > >>> "drop other suboptions" checks has been called twice in
> > >>> mptcp_pm_add_addr_signal and mptcp_established_options_add_addr.
> > >>>
> > >> I think "remaining" in mptcp_pm_add_addr_signal does not touch "rema=
ining" in
> > >> mptcp_established_options_add_addr.
> > >>
> > >>> opts->local and opts->remote in mptcp_pm_add_addr_signal need be
> > >>> populate after the length chech, not before the check.]
> > >>>
> > >>> The squash-to patch keeped the more orignal code unchanged, and jus=
t do
> > >>> the least, necessary modifications.
> > >>>
> > >> Agree opts->local and opts->remote should be asigned after the lengt=
h check.
> > >> But if keep the length check out of mptcp_pm_add_addr_signal (out of=
 pm lock )
> > >> as orignal code, there is a race that:
> > >>
> > >> =3D=3D> a add addr event (pm.addr_signal =3D=3D MPTCP_ADD_ADDR_SIGNA=
L)
> > >> =3D=3D> call mptcp_pm_add_addr_signal
> > >> =3D=3D> a echo add addr event trigger (pm.addr_signal =3D=3D MPTCP_A=
DD_ADDR_ECHO|MPTCP_ADD_ADDR_SIGNAL)
> > >> =3D=3D> at this time opts->remote is empty and the length is incorre=
ct.
> > >>
> > >
> > > What will happen in v8 when this race occurs? How dose v8 deal with t=
he
> > > race?
> > Hi Geliang, thinks for your patience.
> >
> > I think v8 doesn't have this issue:
> > =3D=3D> a add addr event (pm.addr_signal =3D=3D MPTCP_ADD_ADDR_SIGNAL)
> > =3D=3D> call mptcp_pm_add_addr_signal, save pm.addr_signal to add_addr =
and save addr in opts under pm.lock
> > =3D=3D> a echo add addr event trigger (pm.addr_signal =3D=3D MPTCP_ADD_=
ADDR_ECHO), but add_addr doesn't changed.
> > =3D=3D> use add_addr and opts to check length.
> > =3D=3D> next send ack process will deal with MPTCP_ADD_ADDR_ECHO event.
>
> Thanks for your explanation.
>
> I think this squash-to patch did the same thing:
>
> =3D=3D> an add addr event (pm.addr_signal =3D=3D MPTCP_ADD_ADDR_SIGNAL)
> =3D=3D> call mptcp_pm_add_addr_signal, save echo bit of pm.addr_signal to
> 'echo' (echo =3D false), save the port number to 'port', and save addr
> in opts under pm.lock
> =3D=3D> an echo add addr event trigger (pm.addr_signal =3D=3D
> MPTCP_ADD_ADDR_ECHO), but 'echo' and 'port' don't changed.
> =3D=3D> use 'echo' to get the address family, use 'family', 'echo' and
> 'port' to check length.
> =3D=3D> next send ack process will deal with MPTCP_ADD_ADDR_ECHO event.
>
> Do you think so?

And one more thing. How do you test this "mptcp: fix conflicts when using
pm.add_signal in ADD_ADDR/echo and RM_ADDR process" series? Do you use our
mptcp_join.sh to test it, or you did some special tests? Does this race
scenario mentioned above easy to reproduce?

I just did the mptcp_join.sh tests for my squash-to patches, and everything
looks fine. If you have some special tests, could you please help me to tes=
t
these squash-to patches too? Hope it works in the race scenario.

Thanks.
-Geliang



>
> >
> > >
> > >> So I think the orignal code is incorrect. WDYT?
> > >>
> > >>> Drop the "drop other suboptions" check in mptcp_pm_add_addr_signal.
> > >>>
> > >>> Change arguments of mptcp_pm_add_addr_signal.
> > >>>
> > >>> Keep mptcp_add_addr_len unchanged.
> > >>>
> > >>> Signed-off-by: Geliang Tang <geliangtang@gmail.com>
> > >>> ---
> > >>>  net/mptcp/options.c  | 35 +++++++++++++++++------------------
> > >>>  net/mptcp/pm.c       | 23 +++++++++--------------
> > >>>  net/mptcp/protocol.h | 27 +++++++++------------------
> > >>>  3 files changed, 35 insertions(+), 50 deletions(-)
> > >>>
> > >>> diff --git a/net/mptcp/options.c b/net/mptcp/options.c
> > >>> index 5c0ad9b90866..93ad7b134f74 100644
> > >>> --- a/net/mptcp/options.c
> > >>> +++ b/net/mptcp/options.c
> > >>> @@ -663,16 +663,14 @@ static bool mptcp_established_options_add_add=
r(struct sock *sk, struct sk_buff *
> > >>>       struct mptcp_sock *msk =3D mptcp_sk(subflow->conn);
> > >>>       bool drop_other_suboptions =3D false;
> > >>>       unsigned int opt_size =3D *size;
> > >>> -     u8 add_addr;
> > >>> +     bool echo;
> > >>> +     bool port;
> > >>> +     u8 family;
> > >>>       int len;
> > >>>
> > >>> -     if (!mptcp_pm_should_add_signal(msk) ||
> > >>> -         !mptcp_pm_add_addr_signal(msk, skb, opt_size, remaining, =
opts, &add_addr))
> > >>> -             return false;
> > >>> -
> > >>> -     if (((add_addr & BIT(MPTCP_ADD_ADDR_ECHO)) ||
> > >>> -          ((add_addr & BIT(MPTCP_ADD_ADDR_SIGNAL)) &&
> > >>> -           (opts->local.family =3D=3D AF_INET6 || opts->local.port=
))) &&
> > >>> +     if ((mptcp_pm_should_add_signal_echo(msk) ||
> > >>> +          (mptcp_pm_should_add_signal_addr(msk) &&
> > >>> +           (msk->pm.local.family =3D=3D AF_INET6 || msk->pm.local.=
port))) &&
> > >>>           skb && skb_is_tcp_pure_ack(skb)) {
> > >>>               pr_debug("drop other suboptions");
> > >>>               opts->suboptions =3D 0;
> > >>> @@ -682,7 +680,12 @@ static bool mptcp_established_options_add_addr=
(struct sock *sk, struct sk_buff *
> > >>>               drop_other_suboptions =3D true;
> > >>>       }
> > >>>
> > >>> -     len =3D mptcp_add_addr_len(opts, add_addr);
> > >>> +     if (!mptcp_pm_should_add_signal(msk) ||
> > >>> +         !mptcp_pm_add_addr_signal(msk, remaining, &opts->local, &=
opts->remote, &echo, &port))
> > >>> +             return false;
> > >>> +
> > >>> +     family =3D echo ? opts->remote.family : opts->local.family;
> > >>> +     len =3D mptcp_add_addr_len(family, echo, port);
> > >>>       if (remaining < len)
> > >>>               return false;
> > >>>
> > >>> @@ -690,15 +693,14 @@ static bool mptcp_established_options_add_add=
r(struct sock *sk, struct sk_buff *
> > >>>       if (drop_other_suboptions)
> > >>>               *size -=3D opt_size;
> > >>>       opts->suboptions |=3D OPTION_MPTCP_ADD_ADDR;
> > >>> -     if (!(add_addr & BIT(MPTCP_ADD_ADDR_ECHO)) &&
> > >>> -         (add_addr & BIT(MPTCP_ADD_ADDR_SIGNAL))) {
> > >>> +     if (!echo) {
> > >>>               opts->ahmac =3D add_addr_generate_hmac(msk->local_key=
,
> > >>>                                                    msk->remote_key,
> > >>>                                                    &opts->local);
> > >>>       }
> > >>> -     pr_debug("addr_signal:%x, echo=3D%d, local_addr_id=3D%d, ahma=
c=3D%llu, local_port=3D%d, remote_addr_id=3D%d, remote_port=3D%d",
> > >>> -              add_addr, (opts->ahmac =3D=3D 0), opts->local.id, op=
ts->ahmac,
> > >>> -              ntohs(opts->local.port), opts->remote.id, ntohs(opts=
->remote.port));
> > >>> +     pr_debug("local_id=3D%d, local_port=3D%d, remote_id=3D%d, rem=
ote_port=3D%d, ahmac=3D%llu, echo=3D%d",
> > >>> +              opts->local.id, ntohs(opts->local.port), opts->remot=
e.id,
> > >>> +              ntohs(opts->remote.port), opts->ahmac, echo);
> > >>>
> > >>>       return true;
> > >>>  }
> > >>> @@ -1253,13 +1255,10 @@ void mptcp_write_options(__be32 *ptr, const=
 struct tcp_sock *tp,
> > >>>
> > >>>  mp_capable_done:
> > >>>       if (OPTION_MPTCP_ADD_ADDR & opts->suboptions) {
> > >>> -             struct mptcp_addr_info *addr =3D &opts->remote;
> > >>> +             struct mptcp_addr_info *addr =3D opts->ahmac ? &opts-=
>local : &opts->remote;
> > >>>               u8 len =3D TCPOLEN_MPTCP_ADD_ADDR_BASE;
> > >>>               u8 echo =3D MPTCP_ADDR_ECHO;
> > >>>
> > >>> -             if (opts->ahmac)
> > >>> -                     addr =3D &opts->local;
> > >>> -
> > >>>  #if IS_ENABLED(CONFIG_MPTCP_IPV6)
> > >>>               if (addr->family =3D=3D AF_INET6)
> > >>>                       len =3D TCPOLEN_MPTCP_ADD_ADDR6_BASE;
> > >>> diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
> > >>> index 264f522af530..399b59cb7563 100644
> > >>> --- a/net/mptcp/pm.c
> > >>> +++ b/net/mptcp/pm.c
> > >>> @@ -253,12 +253,13 @@ void mptcp_pm_mp_prio_received(struct sock *s=
k, u8 bkup)
> > >>>
> > >>>  /* path manager helpers */
> > >>>
> > >>> -bool mptcp_pm_add_addr_signal(struct mptcp_sock *msk, struct sk_bu=
ff *skb,
> > >>> -                           unsigned int opt_size, unsigned int rem=
aining,
> > >>> -                           struct mptcp_out_options *opts,  u8 *ad=
d_addr)
> > >>> +bool mptcp_pm_add_addr_signal(struct mptcp_sock *msk, unsigned int=
 remaining,
> > >>> +                           struct mptcp_addr_info *saddr, struct m=
ptcp_addr_info *daddr,
> > >>> +                           bool *echo, bool *port)
> > >>>  {
> > >>>       int ret =3D false;
> > >>>       u8 add_addr;
> > >>> +     u8 family;
> > >>>
> > >>>       spin_lock_bh(&msk->pm.lock);
> > >>>
> > >>> @@ -266,21 +267,15 @@ bool mptcp_pm_add_addr_signal(struct mptcp_so=
ck *msk, struct sk_buff *skb,
> > >>>       if (!mptcp_pm_should_add_signal(msk))
> > >>>               goto out_unlock;
> > >>>
> > >>> -     opts->local =3D msk->pm.local;
> > >>> -     opts->remote =3D msk->pm.remote;
> > >>> -     *add_addr =3D msk->pm.addr_signal;
> > >>> +     *echo =3D mptcp_pm_should_add_signal_echo(msk);
> > >>> +     *port =3D !!(*echo ? msk->pm.remote.port : msk->pm.local.port=
);
> > >>>
> > >>> -     if (((msk->pm.addr_signal & BIT(MPTCP_ADD_ADDR_ECHO)) ||
> > >>> -          ((msk->pm.addr_signal & BIT(MPTCP_ADD_ADDR_SIGNAL)) &&
> > >>> -           (msk->pm.local.family =3D=3D AF_INET6 || msk->pm.local.=
port))) &&
> > >>> -         skb && skb_is_tcp_pure_ack(skb)) {
> > >>> -             remaining +=3D opt_size;
> > >>> -     }
> > >>> -
> > >>> -     if (remaining < mptcp_add_addr_len(opts, *add_addr))
> > >>> +     family =3D *echo ? msk->pm.remote.family : msk->pm.local.fami=
ly;
> > >>> +     if (remaining < mptcp_add_addr_len(family, *echo, *port))
> > >>>               goto out_unlock;
> > >>>
> > >>>       *saddr =3D msk->pm.local;
> > >>> +     *daddr =3D msk->pm.remote;
> > >>>       add_addr =3D READ_ONCE(msk->pm.addr_signal);
> > >>>       if (mptcp_pm_should_add_signal_echo(msk))
> > >>>               add_addr &=3D ~BIT(MPTCP_ADD_ADDR_ECHO);
> > >>> diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
> > >>> index 937e0309e340..4b63cc6079fa 100644
> > >>> --- a/net/mptcp/protocol.h
> > >>> +++ b/net/mptcp/protocol.h
> > >>> @@ -766,25 +766,16 @@ static inline bool mptcp_pm_should_rm_signal(=
struct mptcp_sock *msk)
> > >>>       return READ_ONCE(msk->pm.addr_signal) & BIT(MPTCP_RM_ADDR_SIG=
NAL);
> > >>>  }
> > >>>
> > >>> -static inline unsigned int mptcp_add_addr_len(struct mptcp_out_opt=
ions *opts,
> > >>> -                                           u8 add_addr)
> > >>> +static inline unsigned int mptcp_add_addr_len(int family, bool ech=
o, bool port)
> > >>>  {
> > >>> -     struct mptcp_addr_info *addr =3D &opts->remote;
> > >>> -     u8 len =3D 0;
> > >>> +     u8 len =3D TCPOLEN_MPTCP_ADD_ADDR_BASE;
> > >>>
> > >>> -     if (!(add_addr & BIT(MPTCP_ADD_ADDR_ECHO)) &&
> > >>> -         (add_addr & BIT(MPTCP_ADD_ADDR_SIGNAL))) {
> > >>> -             addr =3D &opts->local;
> > >>> +     if (family =3D=3D AF_INET6)
> > >>> +             len =3D TCPOLEN_MPTCP_ADD_ADDR6_BASE;
> > >>> +     if (!echo)
> > >>>               len +=3D MPTCPOPT_THMAC_LEN;
> > >>> -     }
> > >>> -
> > >>> -     if (addr->family =3D=3D AF_INET6)
> > >>> -             len +=3D TCPOLEN_MPTCP_ADD_ADDR6_BASE;
> > >>> -     else
> > >>> -             len +=3D TCPOLEN_MPTCP_ADD_ADDR_BASE;
> > >>> -
> > >>>       /* account for 2 trailing 'nop' options */
> > >>> -     if (addr->port)
> > >>> +     if (port)
> > >>>               len +=3D TCPOLEN_MPTCP_PORT_LEN + TCPOLEN_MPTCP_PORT_=
ALIGN;
> > >>>
> > >>>       return len;
> > >>> @@ -798,9 +789,9 @@ static inline int mptcp_rm_addr_len(const struc=
t mptcp_rm_list *rm_list)
> > >>>       return TCPOLEN_MPTCP_RM_ADDR_BASE + roundup(rm_list->nr - 1, =
4) + 1;
> > >>>  }
> > >>>
> > >>> -bool mptcp_pm_add_addr_signal(struct mptcp_sock *msk, struct sk_bu=
ff *skb,
> > >>> -                           unsigned int opt_size, unsigned int rem=
aining,
> > >>> -                           struct mptcp_out_options *opts,  u8 *ad=
d_addr);
> > >>> +bool mptcp_pm_add_addr_signal(struct mptcp_sock *msk, unsigned int=
 remaining,
> > >>> +                           struct mptcp_addr_info *saddr, struct m=
ptcp_addr_info *daddr,
> > >>> +                           bool *echo, bool *port);
> > >>>  bool mptcp_pm_rm_addr_signal(struct mptcp_sock *msk, unsigned int =
remaining,
> > >>>                            struct mptcp_rm_list *rm_list);
> > >>>  int mptcp_pm_get_local_id(struct mptcp_sock *msk, struct sock_comm=
on *skc);
> > >>>
> > >>
> > >> --
> > >> Li YongLong
> > >
> >
> > --
> > Li YongLong
