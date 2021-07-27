Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0667372
	for <mptcp@lists.linux.dev>; Tue, 27 Jul 2021 12:41:00 +0000 (UTC)
Received: by mail-pj1-f46.google.com with SMTP id mz5-20020a17090b3785b0290176ecf64922so4002053pjb.3
        for <mptcp@lists.linux.dev>; Tue, 27 Jul 2021 05:41:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=OD/lKgXiY4lEddnAKI2nQSji0417hABOuob/f6iFzLs=;
        b=TXu1pRmPwrdn0iUAvKi6G/B/3IrkPD3y8vs0As3cx6YrOFsONOMam8uQeS9rtcP81v
         Nso+jPMc/sdYv/xi3AP9j1B74IeBFJuEVjO9WjgkZguRQkEVF9RjdWlbGv5GeIaXdCE5
         ecQmOgPFlwCgo2hemzHEU0caqVxu/qQG3V8FO3yxpxcIDVtXXENCMGbj7EirqnEhqeqW
         SJU001zgPOPEEKBAuSTilMx3uXIIjASMMCibBxS74qfsiS6tFwVodoHVPwki3tmnY2CG
         09RHnr7lthtTRWQd2NQzBY27/4VS6RgfNY0a7x8G2koIMP8kg/U1GQLXmwwXm47R07TP
         48Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=OD/lKgXiY4lEddnAKI2nQSji0417hABOuob/f6iFzLs=;
        b=TL7fnr9Oysg3eAb4wqPJQI6FvYMq856y8f1+MLLE6aPP3exD2bmq3K6Rsq6W9SYhC4
         H85Jy5FJ2/U8LdOHrIdpaAt723h//QUKnZaoF9J45gOrqr+qfdRaJyRL9Fhga8YO5LS8
         AB24hZ5YNDGzSEpfY5Kv/mW153fD6EK3TzI64fvFtYbDC5hxJw/q3TSUXIbVm9Mn0Qso
         6fsb1/eYOEOB1zsnmQiyoCTaFml2uEPWwk9JLLtM/RXf9cQzgd9rPbt7XCxIQ9l21PB2
         Lnkru2LJEhMd7eKLWEm7klOcHlVP2EZBSfFYr0jwTh0TVE3DdrKlUWVNapC+uf1wIEaD
         FbPw==
X-Gm-Message-State: AOAM5327pGfVJzgWkz6f4ydoRIAnSVBM3GkXL0myeNmMnvD2fdF2Ii/1
	1uJj/uY0/oqJqxNDrml4BEb4WLVT99cjdgtK+Zc=
X-Google-Smtp-Source: ABdhPJyY28D/5D2P2Ui6nIu4H+Vf8iUllwI49fHbSKWTvbULM8qiDBFtLekuZl8yuDKGv/D4GGITvR3ulNRNF0NUGbE=
X-Received: by 2002:a62:a516:0:b029:333:1995:5e75 with SMTP id
 v22-20020a62a5160000b029033319955e75mr22682857pfm.67.1627389660581; Tue, 27
 Jul 2021 05:41:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <cover.1627372396.git.geliangtang@xiaomi.com> <b8af3a77da2fcd8e16e8b5d6b63c7c8386abcbac.1627372396.git.geliangtang@xiaomi.com>
 <9c137e22c92b4756f3e743a7ab7fc0c37bad57f2.camel@redhat.com>
In-Reply-To: <9c137e22c92b4756f3e743a7ab7fc0c37bad57f2.camel@redhat.com>
From: Geliang Tang <geliangtang@gmail.com>
Date: Tue, 27 Jul 2021 20:40:49 +0800
Message-ID: <CA+WQbwsQych7NHhrcWE51wtMVO1A+h9zaBiwhpsVjmd1czuOtQ@mail.gmail.com>
Subject: Re: [MPTCP][PATCH v5 mptcp-next 1/5] mptcp: remote addresses fullmesh
To: Paolo Abeni <pabeni@redhat.com>
Cc: mptcp@lists.linux.dev, Geliang Tang <geliangtang@xiaomi.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Paolo Abeni <pabeni@redhat.com> =E4=BA=8E2021=E5=B9=B47=E6=9C=8827=E6=97=A5=
=E5=91=A8=E4=BA=8C =E4=B8=8B=E5=8D=885:51=E5=86=99=E9=81=93=EF=BC=9A
>
> Hello,
>
>
> I'm sorry for the partial feedback so far, I noticed more things
> looking at the following patches. Again, I'm sorry!
>
> On Tue, 2021-07-27 at 15:58 +0800, Geliang Tang wrote:
> > +static bool lookup_subflow_by_addrs(const struct list_head *list,
> > +                                 struct mptcp_addr_info *saddr,
> > +                                 struct mptcp_addr_info *daddr)
> > +{
>
> both 'saddr' and 'daddr' could be 'const', I think.
>
> > +     struct mptcp_subflow_context *subflow;
> > +     struct mptcp_addr_info local, remote;
> > +     struct sock_common *skc;
> > +
> > +     list_for_each_entry(subflow, list, node) {
> > +             skc =3D (struct sock_common *)mptcp_subflow_tcp_sock(subf=
low);
> > +
> > +             local_address(skc, &local);
> > +             remote_address(skc, &remote);
> > +             if (addresses_equal(&local, saddr, saddr->port) &&
> > +                 addresses_equal(&remote, daddr, daddr->port))
> > +                     return true;
> > +     }
> > +
> > +     return false;
> > +}
> > +
> >  static struct mptcp_pm_addr_entry *
> >  select_local_address(const struct pm_nl_pernet *pernet,
> >                    struct mptcp_sock *msk)
> > @@ -410,6 +431,53 @@ void mptcp_pm_free_anno_list(struct mptcp_sock *ms=
k)
> >       }
> >  }
> >
> > +static bool lookup_address_in_vec(struct mptcp_addr_info *addrs, unsig=
ned int nr,
> > +                               struct mptcp_addr_info *addr)
>
> 'addr' could be 'const', I think.

It can be 'const', since the 2nd argument of addresses_equal is non-const.

And all the other 'const's in this comment too.

>
> > +{
> > +     int i;
> > +
> > +     for (i =3D 0; i < nr; i++) {
> > +             if (addresses_equal(&addrs[i], addr, addr->port))
> > +                     return true;
> > +     }
> > +
> > +     return false;
> > +}
> > +
> > +static unsigned int fill_remote_addresses_vec(struct mptcp_sock *msk,
> > +                                           struct mptcp_pm_addr_entry =
*local,
> > +                                           struct mptcp_addr_info *add=
rs)
> > +{
>
> 'local' could be 'const', I think.
>
> hopefully no more comments on this patch ;)
>
> Cheers,
>
> Paolo
>
