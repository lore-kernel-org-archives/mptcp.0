Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58BEF6E
	for <mptcp@lists.linux.dev>; Tue, 23 Mar 2021 03:06:21 +0000 (UTC)
Received: by mail-qt1-f169.google.com with SMTP id h7so13981024qtx.3
        for <mptcp@lists.linux.dev>; Mon, 22 Mar 2021 20:06:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=EBgcVDpy4s1jdOaycEbwkuPsU7C+r9zIb2hrMOiKf+s=;
        b=GtHrrvFxjB/DOp8zk8vdzkePgKOeM34zdGTsggnGH0hvLBBjcWM6k2ySn68MMy8z8z
         nCT3y2cb9cR77uFBLursLuAl65YWvc+qLY1cNCrXKqRp5urJUVd2hm85sJMVu1c2Uiaw
         d04s8R43BuHljOisibJ4uLpcGRTknDnSHevO7liCTSbXTwchYSNVGWZGQmUinqnQbALN
         We/m4OsMdlYrxPFPz6/FKMH3Bl+PCbrwzVj30fYcR1/G7rHAu6KS94BwS+kMBXs1tVUs
         PvES4dgnNtyeLG5yObwDzTj6lZ1ppzCzOvSJo/ysFuRFFTKIlcecCoysKPhg3S0fr1iR
         qJAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=EBgcVDpy4s1jdOaycEbwkuPsU7C+r9zIb2hrMOiKf+s=;
        b=PFFwRSntnvpanQMYNB1qQJuAB/q8mW50LYvZclMoXik+rT9P+2XncycqdZMQOI+2nf
         TW+1xNhtInKvANHcoyQpkaIdAT7k68e3Ao3GTOeaXrBCHx2p9oFkYukm2ZRMtC/x+BeN
         CVPacv/1AHt5Km+TRXts7sIOOrQUr2kJvKgSNGSESlz+J/++ZmYx3eq1xHC+a4l7ly/3
         hnpjdMFq25KKjS8LpzjoJNWIS7hlF9//gNtj4HUkpXW/1v7qWJoIj+n9ReDanB0uy53R
         9wL2xfPGOjGou2JLpn/5/+NA3v0kNOmbkJAcXbCZqBCHCmPIQ68noX5jbE1DzEFD95r5
         rQHA==
X-Gm-Message-State: AOAM533w8r9YsgTxNCBG0hn++/nKdEamLsKyBS7YIlM5fASj682ibaub
	xru3NGo9VdH/k4eDkolzfxwMUh+5KEvJnohAgQKTdGe1OJM=
X-Google-Smtp-Source: ABdhPJxA9Zhq7M7/c0A+sY7K8+l6aPNsX2PhgY1mCi+4XskKlqOYMTOWdQMnrS9d4Aahc1q9P01gHFxcOYR+Qpda9Yk=
X-Received: by 2002:ac8:7d52:: with SMTP id h18mr2723076qtb.175.1616468780330;
 Mon, 22 Mar 2021 20:06:20 -0700 (PDT)
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20210322162132.2471823-1-matthieu.baerts@tessares.net>
 <20210322162132.2471823-3-matthieu.baerts@tessares.net> <502b4037-3ca0-1fb9-8985-5fbc7fdb2e2@linux.intel.com>
In-Reply-To: <502b4037-3ca0-1fb9-8985-5fbc7fdb2e2@linux.intel.com>
From: Geliang Tang <geliangtang@gmail.com>
Date: Tue, 23 Mar 2021 11:06:08 +0800
Message-ID: <CA+WQbwt0XaT5EfTi9LR8ZDroNk=74cHA5Yf7_RgKarHGtNWBUw@mail.gmail.com>
Subject: Re: [PATCH mptcp-next 3/3] Squash to "mptcp: drop MPTCP_ADDR_IPVERSION_4/6"
To: Mat Martineau <mathew.j.martineau@linux.intel.com>
Cc: Matthieu Baerts <matthieu.baerts@tessares.net>, mptcp@lists.linux.dev, 
	mptcp <mptcp@lists.01.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Matt,

Thanks for your patches.

Mat Martineau <mathew.j.martineau@linux.intel.com> =E4=BA=8E2021=E5=B9=B43=
=E6=9C=8823=E6=97=A5=E5=91=A8=E4=BA=8C =E4=B8=8A=E5=8D=885:56=E5=86=99=E9=
=81=93=EF=BC=9A
>
>
> On Mon, 22 Mar 2021, Matthieu Baerts wrote:
>
> > Fix issues reported by sparse because we are doing non explicit casting
> > from __be16 to integer.
> >
> >  net/mptcp/options.c:604:24: warning: restricted __be16 degrades to int=
eger
> >  net/mptcp/options.c:605:24: warning: restricted __be16 degrades to int=
eger
> >
> > Before the mentioned commit, we were using port in u16 given in argumen=
t
> > of add_addr_generate_hmac function, everything was OK.
> >
> > Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
> > ---
> > net/mptcp/options.c | 5 +++--
> > 1 file changed, 3 insertions(+), 2 deletions(-)
>
> I think the subject line is incorrect on this one (it applies cleanly to
> "mptcp: unify add_addr(6)_generate_hmac" instead), but other than that al=
l
> three patches look good to squash. Thanks!
>
> Mat
>
>
> >
> > diff --git a/net/mptcp/options.c b/net/mptcp/options.c
> > index 071b446aa2c9..d9e5f864d774 100644
> > --- a/net/mptcp/options.c
> > +++ b/net/mptcp/options.c
> > @@ -586,6 +586,7 @@ static bool mptcp_established_options_dss(struct so=
ck *sk, struct sk_buff *skb,
> > static u64 add_addr_generate_hmac(u64 key1, u64 key2,
> >                                 struct mptcp_addr_info *addr)
> > {
> > +     u16 port =3D be16_to_cpu(addr->port);

I prefer to use ntohs/htons instead of be16_to_cpu/cpu_to_be16 in these
three patches to keep the consistency of the port number converting.

WDYT?

-Geliang

> >       u8 hmac[SHA256_DIGEST_SIZE];
> >       u8 msg[19];
> >       int i =3D 0;
> > @@ -601,8 +602,8 @@ static u64 add_addr_generate_hmac(u64 key1, u64 key=
2,
> >               i +=3D 16;
> >       }
> > #endif
> > -     msg[i++] =3D addr->port >> 8;
> > -     msg[i++] =3D addr->port & 0xFF;
> > +     msg[i++] =3D port >> 8;
> > +     msg[i++] =3D port & 0xFF;
> >
> >       mptcp_crypto_hmac_sha(key1, key2, msg, i, hmac);
> >
> > --
> > 2.30.2
> >
> >
> >
>
> --
> Mat Martineau
> Intel
