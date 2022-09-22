Received: from mail-pl1-f194.google.com (mail-pl1-f194.google.com [209.85.214.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 728BB1FBA
	for <mptcp@lists.linux.dev>; Thu, 22 Sep 2022 03:48:17 +0000 (UTC)
Received: by mail-pl1-f194.google.com with SMTP id l10so7579680plb.10
        for <mptcp@lists.linux.dev>; Wed, 21 Sep 2022 20:48:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=HSYp/ck797voAC2Bz26MvwW8RIFxhYbOQfRgLo4c/3s=;
        b=iwIqPQIowBcRaMTLy3xka9SnRKTPIa1wag+lOnStJRd5qzqR4HImRLrKQrRHhw6Ziy
         wwqF9Pv0BuntlBc3Q+X8XaDxLYSKxg9iENJEAZ32HEm1wF9Krv7ZjZ5acwjon6nwkItj
         S/0Mfp/Chkq8bBKvml2GWhNJcbRhVGoWhXC2orVdMCPMwLlFxnRdb2zY8d/5Fu7NG6Hu
         4CPjSgtLw8MLkwkB9XmgFVkN/vyaquzV1jxtJPedBo9dU70Xv/PFPLOIkEvQM2HOW8yW
         kel4xNEnzn0dGFlmFUknQDrIi0DEQtzoB6CPkbuAG/FwcfG3Rh/pC/5eyKkuLVvTvf3b
         XjYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=HSYp/ck797voAC2Bz26MvwW8RIFxhYbOQfRgLo4c/3s=;
        b=fdTiKm8ibCCiFEbgCtoma6j6BG7mVi9eSwRLGmxbMY+sLZ/Oz7bEBEJGM7VOt4fVkH
         go9i5LC7B9YhecMwUbZW4nyuhMdLypgdtXwPPReF9PrW/u8EF2FqtkhRl2h9v9qUrxks
         TPa1ZZae1UeivLcRMzTOIG1r/3SQro0jyI3Vr8iHWeKj4V3FxUMGWKQfOJ2CZwiyEm96
         +l+mluPxIv/o35oZddRZjXMn4JxrZjnC36IIhK97PTmfSh9WLjRfOd8TDsMNA/PWy2po
         NRODI1hHFbzFsA627qgLUKRLVbEitrQtH4V88obz07nqVSnQq+L6G9iF59dh5BpMvpc0
         xENQ==
X-Gm-Message-State: ACrzQf3eKpfKgxE99J7vFnYG777n0bNtqm4VcNpy+8qbsCDxSk8sjUVv
	AV8gqoT6FhLecrb0X0Xyh5cPyxVxoyvZPXijIk0=
X-Google-Smtp-Source: AMsMyM4UQxGw95V7UyTJG6SHBrQMBo2Z+tbylS/RxK5HSR/gsyHHCqZLi0HZzZTiwFbGm0g9048E+2mAN7gBZXfOvHo=
X-Received: by 2002:a17:902:da82:b0:178:38ee:70b with SMTP id
 j2-20020a170902da8200b0017838ee070bmr1292135plx.85.1663818496915; Wed, 21 Sep
 2022 20:48:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20220921120442.320727-1-imagedong@tencent.com> <ca982b91-22b7-48c0-bf01-6ce05394632b@linux.intel.com>
In-Reply-To: <ca982b91-22b7-48c0-bf01-6ce05394632b@linux.intel.com>
From: Menglong Dong <menglong8.dong@gmail.com>
Date: Thu, 22 Sep 2022 11:48:05 +0800
Message-ID: <CADxym3ZiZ9P7wOpxSJYZP-ehK8T9f_saQn=vaoWx6qzQ6R0e+Q@mail.gmail.com>
Subject: Re: [PATCH mptcp-next v2 0/2] mptcp: add statistics for mptcp socket
 in use
To: Mat Martineau <mathew.j.martineau@linux.intel.com>
Cc: mptcp@lists.linux.dev, Menglong Dong <imagedong@tencent.com>
Content-Type: text/plain; charset="UTF-8"

Hello,

On Thu, Sep 22, 2022 at 8:04 AM Mat Martineau
<mathew.j.martineau@linux.intel.com> wrote:
>
> On Wed, 21 Sep 2022, menglong8.dong@gmail.com wrote:
>
> > From: Menglong Dong <imagedong@tencent.com>
> >
> > In the 1th patch, we do some code cleanup with replease 'sock->sk'
> > with 'sk'. In the 2th patch, we add statistics for mptcp socket in
> > use.
> >
> > Changes since v1:
> > - split the code cleanup into the 1th patch.
> > - decrease the statistics for listening mptcp socket inuse with
> >  mptcp_listen_inuse_dec()
> > - add MPTCP_DESTROIED flags to store if mptcp_destroy_common() was
> >  called on the msk. For fallback case, we need to decrease the
> >  statistics only once, and mptcp_destroy_common() can be called
> >  more than once.
> >
>
> Hi Menglong -
>
> Thanks for the v2. Other than Matthieu's request about MPTCP_DESTROYED,
> could you also add a selftest patch to confirm the counter is updated
> correctly?
>
> This test script:
>
> tools/testing/selftests/net/mptcp/diag.sh
>
> already creates a large number of simultaneous sockets, so it might work
> well to modify the wait_msk_nr() function to also confirm the protocol
> inuse counter, and then check that the counter returns to zero after the
> sockets are closed.

Thanks for the explanation, I think it can work. In case of that
there are mptcp sockets existing out of the testing, we can also
record the statistics before creating mptcp socket, and compare
the statistics after the closing of mptcp socket.

I'll add the test in the next version.

Thanks!
Menglong Dong

>
> > Menglong Dong (2):
> >  mptcp: introduce 'sk' to replace 'sock->sk' in mptcp_listen()
> >  mptcp: add statistics for mptcp socket in use
> >
> > net/mptcp/protocol.c | 34 +++++++++++++++++++++++++++-------
> > net/mptcp/protocol.h |  1 +
> > net/mptcp/subflow.c  |  3 +++
> > 3 files changed, 31 insertions(+), 7 deletions(-)
> >
> > --
> > 2.37.2
> >
> >
>
> --
> Mat Martineau
> Intel
