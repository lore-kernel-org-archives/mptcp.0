Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9843D6E
	for <mptcp@lists.linux.dev>; Tue, 23 Mar 2021 08:09:56 +0000 (UTC)
Received: by mail-ed1-f53.google.com with SMTP id y6so22395666eds.1
        for <mptcp@lists.linux.dev>; Tue, 23 Mar 2021 01:09:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=9yowSwhwHy/mPlEAYdiCQEP350DsFUPBajqT+3hCIaM=;
        b=WWobCF9ASN+UPKYo1YkiyqkHFvdtjK66+sf5xMuEcDChnDeeSnOfGdVh0WUy/WKzoP
         f+5/o85awdgzJY8YV59w+1FL/g6PmQt2jj07VXbUVNfADzxHCpSS92zknYdqDjNV6Dur
         1IR78lP5/eNgfI/l8VRT6+Fa9gFZIphOQJi9D/lnAleqdOXb5bjoL8CpHoM4G/Ql1UYk
         zNuqY4aoPudlN/53JenWylNKT6h7CNDme4/tNUjOLBQpXxJD1JOMNwv3acRJmqWQwVsG
         jbQe6cwBN5/ok5CqQGP0cemx82h7Uq1m65jpNUlH/d349WfFI4n7UUOzm7S8JWC2fiOf
         LnxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=9yowSwhwHy/mPlEAYdiCQEP350DsFUPBajqT+3hCIaM=;
        b=mE1t56PBaBd2+9N6xYacB84K3rXZ5+LvF9eYvlgcFZgmwAQrtIT5MUS4g80Vmsx09K
         Qrz4B4SIuEigR8NZtsKBUhls8dRC9JFHGtB0z1t2Wy8sFJ0uY+SPvXWZriMhIUF8jvdO
         KkPVcq35tfxXVb5urTcB0MqnVnz7UjDlgz5xc5aUOJzCv9K8hosDuw6Gi7d95aUEoM3q
         W9MVkgZhBcgIhe0PyCx9/yBPEzsbPfoCcAqrNJIPxJOUMjiNsN85YhGJzqo+XVA0EQ9t
         saS+ZfqesYNmqVTen6yxY9PN65h9q81Yi9fEL7A+9fv8hyl4o7sXvdjK6xK9V7K7cgSw
         wNxg==
X-Gm-Message-State: AOAM530xeG5vk2l/HB1P/Gu3PxY1TchxDSyEvmZVGeigUngoPG5j9WKX
	k1wgtzBN+XzJY1ccESeyVXs1sC4E9HYA2C2zpn4=
X-Google-Smtp-Source: ABdhPJyZuXtjs/Qzzk9w+38lxtMz8Kf1g1tTpZLVJEYe5wZtNI1R+D1n3UYtp5KkAW7GSiQ3gg1zx95ioJu6SVa+7FM=
X-Received: by 2002:a05:6402:42d3:: with SMTP id i19mr3424229edc.220.1616486995132;
 Tue, 23 Mar 2021 01:09:55 -0700 (PDT)
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20210322162132.2471823-1-matthieu.baerts@tessares.net>
 <20210322162132.2471823-3-matthieu.baerts@tessares.net> <502b4037-3ca0-1fb9-8985-5fbc7fdb2e2@linux.intel.com>
 <CA+WQbwt0XaT5EfTi9LR8ZDroNk=74cHA5Yf7_RgKarHGtNWBUw@mail.gmail.com> <946858fc-f303-52a3-65c0-1f9c76316703@tessares.net>
In-Reply-To: <946858fc-f303-52a3-65c0-1f9c76316703@tessares.net>
From: Geliang Tang <geliangtang@gmail.com>
Date: Tue, 23 Mar 2021 16:09:43 +0800
Message-ID: <CA+WQbwtBpbh8Y++JyHOK69J36tOA50z5XWo5yDQzDfLE6RHcpQ@mail.gmail.com>
Subject: Re: [PATCH mptcp-next 3/3] Squash to "mptcp: drop MPTCP_ADDR_IPVERSION_4/6"
To: Matthieu Baerts <matthieu.baerts@tessares.net>
Cc: Mat Martineau <mathew.j.martineau@linux.intel.com>, mptcp@lists.linux.dev, 
	mptcp <mptcp@lists.01.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Matt,

Matthieu Baerts <matthieu.baerts@tessares.net> =E4=BA=8E2021=E5=B9=B43=E6=
=9C=8823=E6=97=A5=E5=91=A8=E4=BA=8C =E4=B8=8B=E5=8D=883:59=E5=86=99=E9=81=
=93=EF=BC=9A
>
> Hi Geliang, Mat,
>
> Thank you for the reviews!
>
> On 23/03/2021 04:06, Geliang Tang wrote:
> > Hi Matt,
> >
> > Thanks for your patches.
> >
> > Mat Martineau <mathew.j.martineau@linux.intel.com> =E4=BA=8E2021=E5=B9=
=B43=E6=9C=8823=E6=97=A5=E5=91=A8=E4=BA=8C =E4=B8=8A=E5=8D=885:56=E5=86=99=
=E9=81=93=EF=BC=9A
> >>
> >>
> >> On Mon, 22 Mar 2021, Matthieu Baerts wrote:
> >>
> >>> Fix issues reported by sparse because we are doing non explicit casti=
ng
> >>> from __be16 to integer.
> >>>
> >>>   net/mptcp/options.c:604:24: warning: restricted __be16 degrades to =
integer
> >>>   net/mptcp/options.c:605:24: warning: restricted __be16 degrades to =
integer
> >>>
> >>> Before the mentioned commit, we were using port in u16 given in argum=
ent
> >>> of add_addr_generate_hmac function, everything was OK.
> >>>
> >>> Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
> >>> ---
> >>> net/mptcp/options.c | 5 +++--
> >>> 1 file changed, 3 insertions(+), 2 deletions(-)
> >>
> >> I think the subject line is incorrect on this one (it applies cleanly =
to
> >> "mptcp: unify add_addr(6)_generate_hmac" instead)
>
> Oh yes sorry, I picked the wrong commit, thank you for noticing that :)
>
> >> , but other than that all
> >> three patches look good to squash. Thanks!
> >>
> >> Mat
> >>
> >>
> >>>
> >>> diff --git a/net/mptcp/options.c b/net/mptcp/options.c
> >>> index 071b446aa2c9..d9e5f864d774 100644
> >>> --- a/net/mptcp/options.c
> >>> +++ b/net/mptcp/options.c
> >>> @@ -586,6 +586,7 @@ static bool mptcp_established_options_dss(struct =
sock *sk, struct sk_buff *skb,
> >>> static u64 add_addr_generate_hmac(u64 key1, u64 key2,
> >>>                                  struct mptcp_addr_info *addr)
> >>> {
> >>> +     u16 port =3D be16_to_cpu(addr->port);
> >
> > I prefer to use ntohs/htons instead of be16_to_cpu/cpu_to_be16 in these
> > three patches to keep the consistency of the port number converting.
> >
> > WDYT?
>
> No you are right, I don't know why I didn't use ntohs/htons, I think I
> was focused on the compiler issue forgetting the network env :)
>
> I hope you don't mind if I apply the modifications (code and commit
> messages) directly without sending a v2. Then I would be able to unblock
> the CI to have new versions of the export branch.

Great, please apply them directly.

-Geliang

>
> Cheers,
> Matt
> --
> Tessares | Belgium | Hybrid Access Solutions
> www.tessares.net
