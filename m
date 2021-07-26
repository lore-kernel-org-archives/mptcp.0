Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BACE872
	for <mptcp@lists.linux.dev>; Mon, 26 Jul 2021 08:32:27 +0000 (UTC)
Received: by mail-pj1-f50.google.com with SMTP id ch6so2909090pjb.5
        for <mptcp@lists.linux.dev>; Mon, 26 Jul 2021 01:32:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Y73izOFrJhOqWt7zoz0VS5KC7Sjl0oeLcCyny4QkimQ=;
        b=AKluho9SgjL4Gy3I5ornsYQ16sLl0HhDcECbM2TL9ih1/gdeFO3m0Gyg9rdhDs8syw
         enK20iepjykl5kp16DfcJHBWEgTXWRZ+qVn50se5i8wP95WF+upwDM/9nDwsz059WQs7
         4nmrGh+BgE752Ktf23arn8Iq4rlPowYwmNtuHEmRJJc4WjTCiFCKi1RbdymwzxY4KVJS
         OT+iQH/cb/P9H10N9N7usQrHhLgWrvL+xMRip6yQBnHap97u+SavAaOC5zqRc/WEagut
         0nH6iFyPb1KqL0nvlhBtz7S2Dnc9PI4ccaZ0WCrt4lcf2bLFCsgv3cn9lqACjAqVEWwN
         z1Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Y73izOFrJhOqWt7zoz0VS5KC7Sjl0oeLcCyny4QkimQ=;
        b=ZKJm+2DfgZlUfn2RX8eO/eRWRuSsjuYYnDjAJ6yPXDAAKfDYyfvLefm5qNlO6kWfjY
         8yB6ZO2qWMeecFy/Nik1+jXPWbckLleJBroIU8Q4GK7gV4yezqoiDjZ+eDDLt6HDw495
         9a313keIk9exMMCjoOP5Tq2Oy5SPUOjUT4unuleRormmAbJXK6yo13PraOLRYVc3G7eM
         OJCXyYlpiA9+OCPMVqDQPdGQiP/ulHZ1QiAgm4G4XhlGYW4gRwzglsYvriGIHt0ATvYY
         jMKjT/kCOMknrvBsgajfDaTtvrsVClkyFZB2cI71ounLVGabGKmLeQj5PJCPu8ig+gHZ
         TWAg==
X-Gm-Message-State: AOAM530f4LpJQeiar1d/VzeEIhWATYBSjrD/TeiWH8HGmDr18R7pBLFi
	rntTp7OGrNrehoi7p6vz+8RuU8Z2PObWibfKWWM=
X-Google-Smtp-Source: ABdhPJyjBEJ5Dw+evOSQ17/vc0QrLTxeBPUhMFOSpoQyOj64Gts0cbKOOv0KTZgAOfM+GjWzk38H5TuQQsIi5KptJt0=
X-Received: by 2002:a62:a516:0:b029:333:1995:5e75 with SMTP id
 v22-20020a62a5160000b029033319955e75mr16574879pfm.67.1627288347272; Mon, 26
 Jul 2021 01:32:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <cover.1627272435.git.geliangtang@xiaomi.com> <6f7aa2fec63dcaa337c7b78184a73a90d58b580f.1627272435.git.geliangtang@xiaomi.com>
 <043ce3b46a70bd59ae7aaa53ed1afdf44b7f3ad2.1627272435.git.geliangtang@xiaomi.com>
 <e201da79ddf683eb0b2c6198e2b7a8c69b5a3c88.camel@redhat.com>
In-Reply-To: <e201da79ddf683eb0b2c6198e2b7a8c69b5a3c88.camel@redhat.com>
From: Geliang Tang <geliangtang@gmail.com>
Date: Mon, 26 Jul 2021 16:32:16 +0800
Message-ID: <CA+WQbwtmVWv+JkVd=RifG=o6=V0VMjaaGvJj2sMZQb6UDA0nYA@mail.gmail.com>
Subject: Re: [MPTCP][PATCH v3 mptcp-next 2/5] mptcp: local addresses fullmesh
To: Paolo Abeni <pabeni@redhat.com>
Cc: mptcp@lists.linux.dev, Geliang Tang <geliangtang@xiaomi.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Paolo Abeni <pabeni@redhat.com> =E4=BA=8E2021=E5=B9=B47=E6=9C=8826=E6=97=A5=
=E5=91=A8=E4=B8=80 =E4=B8=8B=E5=8D=884:24=E5=86=99=E9=81=93=EF=BC=9A
>
> On Mon, 2021-07-26 at 12:12 +0800, Geliang Tang wrote:
> > From: Geliang Tang <geliangtang@xiaomi.com>
> >
> > In mptcp_pm_nl_add_addr_received(), fill a temporary allocate array of
> > all local address corresponding to the fullmesh endpoint. If such array
> > is empty, keep the current behavior.
> >
> > Elsewhere loop on such array and create a subflow for each local addres=
s
> > towards the given remote address
> >
> > Suggested-by: Paolo Abeni <pabeni@redhat.com>
> > Signed-off-by: Geliang Tang <geliangtang@xiaomi.com>
> > ---
> >  net/mptcp/pm_netlink.c | 35 ++++++++++++++++++++++++++++++++---
> >  1 file changed, 32 insertions(+), 3 deletions(-)
> >
> > diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
> > index f57db5b9a50f..a03e8fd3a584 100644
> > --- a/net/mptcp/pm_netlink.c
> > +++ b/net/mptcp/pm_netlink.c
> > @@ -526,12 +526,17 @@ static void mptcp_pm_nl_subflow_established(struc=
t mptcp_sock *msk)
> >
> >  static void mptcp_pm_nl_add_addr_received(struct mptcp_sock *msk)
> >  {
> > +     struct mptcp_pm_addr_entry entries[MPTCP_PM_ADDR_MAX];
> >       struct sock *sk =3D (struct sock *)msk;
> > +     struct mptcp_pm_addr_entry *entry;
> >       unsigned int add_addr_accept_max;
> > +     struct mptcp_pm_addr_entry local;
> >       struct mptcp_addr_info remote;
> > -     struct mptcp_addr_info local;
> > +     struct pm_nl_pernet *pernet;
> >       unsigned int subflows_max;
> > +     int i, n =3D 0;
> >
> > +     pernet =3D net_generic(sock_net(sk), pm_nl_pernet_id);
> >       add_addr_accept_max =3D mptcp_pm_get_add_addr_accept_max(msk);
> >       subflows_max =3D mptcp_pm_get_subflows_max(msk);
> >
> > @@ -555,10 +560,34 @@ static void mptcp_pm_nl_add_addr_received(struct =
mptcp_sock *msk)
> >       if (!remote.port)
> >               remote.port =3D sk->sk_dport;
> >       memset(&local, 0, sizeof(local));
> > -     local.family =3D remote.family;
> > +     local.addr.family =3D remote.family;
> >
> > +     entries[n++] =3D local;
>
> If I read correctly, I think this entry should be added only if the
> full-mesh selection below find no other entries. Otherwise, e.g. in the
> simple scenario with 2 locals address, 3 subflows will be created.

local is the id 0 address, this address should always be used, and it's
not on the local_addr_list. So I think we should put local in the array
all the time, no matter fullmesh or not.

Do you agree?

Thanks,
-Geliang


>
> > +     rcu_read_lock();
> > +     __mptcp_flush_join_list(msk);
> > +     list_for_each_entry_rcu(entry, &pernet->local_addr_list, list) {
> > +             if (!(entry->flags & MPTCP_PM_ADDR_FLAG_FULLMESH))
> > +                     continue;
> > +
> > +             if (entry->addr.family !=3D sk->sk_family) {
> > +#if IS_ENABLED(CONFIG_MPTCP_IPV6)
> > +                     if ((entry->addr.family =3D=3D AF_INET &&
> > +                          !ipv6_addr_v4mapped(&sk->sk_v6_daddr)) ||
> > +                         (sk->sk_family =3D=3D AF_INET &&
> > +                          !ipv6_addr_v4mapped(&entry->addr.addr6)))
> > +#endif
> > +                             continue;
> > +             }
> > +
> > +             if (!lookup_subflow_by_addrs(&msk->conn_list, &entry->add=
r, &remote))
> > +                     entries[n++] =3D *entry;
>
> I guess the loop should stop when:
>
>  n + <number of already existing subflows> =3D mptcp_pm_get_subflows_max(=
)
>
> Even the previous patch need a similar check.
>
> Additional minor nit, what about encapsualting the above chunk in a new
> helper - fill_source_addresses_vec() or something similar? It gets the
> current pm and net as input arguments, the address vector as an output
> arg, and returns the number of addresses filled into the array
> (enforcing the above constraint).
>
> This also applies to the previous patch.
>
> Cheers,
>
> Paolo
>
