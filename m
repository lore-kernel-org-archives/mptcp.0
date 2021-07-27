Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42E9572
	for <mptcp@lists.linux.dev>; Tue, 27 Jul 2021 12:51:48 +0000 (UTC)
Received: by mail-pl1-f169.google.com with SMTP id d17so15604989plh.10
        for <mptcp@lists.linux.dev>; Tue, 27 Jul 2021 05:51:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=WpEswOdbn8IGIfWJon6att1H7oGBOZprgsALL+0Nfww=;
        b=m9SdPgOoRvrNFC3Zcy4w4znL5g7U9pkvPgflnbgbnT1MRVhp6lVyHHJoe/EabzoIlE
         TDwHzitlBiGn6d0woy/34nS4a/2bSAr9PWvDUDwoxC+Dy01TGSt2RIJ1pyKNQpJrkUTo
         JRKiMYmZ/wlVYIJH9qh1MD0pwD/sFXT5TlqKOV5TdJDgmreiHMCfL/0T3wTLXYiMPFkk
         zm8u4oXovL8y4MS16HlBq/KRTQzSFVrzt8kYmwviJazhGmlupEFYiJbG3fBEeJRwWSuD
         sBdQtDk/1UYfvc6nu3ZqbjGmeJETsor/MbqXWgkfHnuxnG9soh0LJOg9RvAimKkrzhKT
         PKTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=WpEswOdbn8IGIfWJon6att1H7oGBOZprgsALL+0Nfww=;
        b=s9whkmN2c9EZ3kqPjGo6w8IpxGhSE2TU6lX82StzQTopnzzGaKkdcJ1agR1JJNUpcK
         qLGVprV4LUe4zsbbMpNZ5StbH21Axnxs5oRfe8bEHHGJgaonnS3aqfHRCA+HaPjX7use
         Voq+JqbjZnaJWK0SDB5bMXsaZTxqZqBeYKjmf5JeSjNgQYntmbdUqfciS6kv9GfBoGaJ
         VzFrLTGotlyg4Fxel9Wot6c9VRonebY+d/ELaK65JOojlRpauGQbn5qhSb6Gmhti+7i/
         0w/UTlyV2JsCI30D+za+Qb6MRT05XydUaxmfhjz6+W3ox+rSvKRLu89alF4EsohpyAzU
         doLg==
X-Gm-Message-State: AOAM531Q9kizcrYn7a/7R5U/yQwJJjISfPYjbwNf27nuRzf9okad0jG4
	yku7UwFQhtW4zHXY5dlenHoPR7eDblYhZKws2YQ=
X-Google-Smtp-Source: ABdhPJwS3IO3Wlfjm+TgTtcZF6MGqfA6FHyQMz/WhqqBUMLkV9uB+lca6lAm6nXyva0Xg9GAUsF49D38CSJ1SBa0D00=
X-Received: by 2002:a63:34a:: with SMTP id 71mr23392016pgd.289.1627390307908;
 Tue, 27 Jul 2021 05:51:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <cover.1627372396.git.geliangtang@xiaomi.com> <b8af3a77da2fcd8e16e8b5d6b63c7c8386abcbac.1627372396.git.geliangtang@xiaomi.com>
 <bde1048019780ecc5f2e553bbb4eb21213f76ba7.1627372396.git.geliangtang@xiaomi.com>
 <a642a08ee7444cf6607946010a4eabadcdc12535.camel@redhat.com>
In-Reply-To: <a642a08ee7444cf6607946010a4eabadcdc12535.camel@redhat.com>
From: Geliang Tang <geliangtang@gmail.com>
Date: Tue, 27 Jul 2021 20:51:36 +0800
Message-ID: <CA+WQbwsytNrMjW3mogu1mFmL5meR3vZGZcgCeT+DFSOA84TyGg@mail.gmail.com>
Subject: Re: [MPTCP][PATCH v5 mptcp-next 2/5] mptcp: local addresses fullmesh
To: Paolo Abeni <pabeni@redhat.com>
Cc: mptcp@lists.linux.dev, Geliang Tang <geliangtang@xiaomi.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Paolo Abeni <pabeni@redhat.com> =E4=BA=8E2021=E5=B9=B47=E6=9C=8827=E6=97=A5=
=E5=91=A8=E4=BA=8C =E4=B8=8B=E5=8D=885:52=E5=86=99=E9=81=93=EF=BC=9A
>
> On Tue, 2021-07-27 at 15:58 +0800, Geliang Tang wrote:
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
> >  net/mptcp/pm_netlink.c | 60 ++++++++++++++++++++++++++++++++++++++----
> >  1 file changed, 55 insertions(+), 5 deletions(-)
> >
> > diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
> > index 2259c424485f..a85bac950f3b 100644
> > --- a/net/mptcp/pm_netlink.c
> > +++ b/net/mptcp/pm_netlink.c
> > @@ -554,13 +554,62 @@ static void mptcp_pm_nl_subflow_established(struc=
t mptcp_sock *msk)
> >       mptcp_pm_create_subflow_or_signal_addr(msk);
> >  }
> >
> > +static unsigned int fill_local_addresses_vec(struct mptcp_sock *msk,
> > +                                          struct mptcp_addr_info *remo=
te,
> > +                                          struct mptcp_pm_addr_entry *=
entries)
>
> Minor nit: some comments here before the function describing it would
> be helpful, thanks!

Sure. added in v6.

>
> Also 'remote' could be 'const', I think.
>
> > +{
> > +     struct mptcp_pm_addr_entry local, *entry;
> > +     struct sock *sk =3D (struct sock *)msk;
> > +     struct pm_nl_pernet *pernet;
> > +     unsigned int subflows_max;
> > +     int i =3D 0;
> > +
> > +     pernet =3D net_generic(sock_net(sk), pm_nl_pernet_id);
> > +     subflows_max =3D mptcp_pm_get_subflows_max(msk);
> > +
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
r, remote) &&
> > +                 msk->pm.subflows < subflows_max) {
> > +                     msk->pm.subflows++;
> > +                     entries[i++] =3D *entry;
> > +             }
> > +     }
> > +     rcu_read_unlock();
> > +
> > +     if (!i) {
> > +             memset(&local, 0, sizeof(local));
> > +             local.addr.family =3D remote->family;
> > +
> > +             msk->pm.subflows++;
> > +             entries[i++] =3D local;
> > +     }
> > +
> > +     return i;
> > +}
> > +
> >  static void mptcp_pm_nl_add_addr_received(struct mptcp_sock *msk)
> >  {
> > +     struct mptcp_pm_addr_entry entries[MPTCP_PM_ADDR_MAX];
>
> mptcp_pm_addr_entry is quite larger than mptcp_addr_info (should be 64
> bytes vs 24). 64 * 8 =3D=3D 512 bytes could be a bit too much storage for
> the stack. What about using instead:
>
> struct mptcp_pm_addr_info addresses[MPTCP_PM_ADDR_MAX];
> u8 flags[MPTCP_PM_ADDR_MAX];
>
> ?
>
> And than pass the 2 arguments to fill_local_addresses_vec(), instead of
> the single 'entries' arg.

Pass 3 arguments 'addr', 'flags' and 'ifindex' instead of 'entries' in v6.

Thanks,
-Geliang

>
> Cheers,
>
> Paolo
>
