Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A25E83FC1
	for <mptcp@lists.linux.dev>; Tue, 24 Aug 2021 07:58:42 +0000 (UTC)
Received: by mail-ot1-f53.google.com with SMTP id k12-20020a056830150c00b0051abe7f680bso38621555otp.1
        for <mptcp@lists.linux.dev>; Tue, 24 Aug 2021 00:58:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qrGUvUS/KIDwQcIGab309fFc7Hn4+1ct5OaaYFM/29w=;
        b=VK2uY5st1jpFwxGElDlSwRqwvHMQWk3FvqpkK+obuEI5jXsKB+8SdgVwl+6bPv/58v
         l2yoQXoEmtAu06J372yv6LljhKdLHPQANcOadK505xe6S59BQ/0b+IKQ/oZOqQtHgk+G
         xue21I2+r/Qok0h88jMeNibWgnya+7g6qCa4JOCkNZEXgYNgCKAhCtzNQHH3OU1IHbTu
         nphEHtgUo213c8JuO0xxANIiM4zeJ4l7Zz58TLtvbknc9hmW2hkBPjX33/K8nYcLJ8c7
         X/9t6CXKbYbggTmyHk5f/tNCnje+5QHEdtPHPGxlC2o3pObuUZAIAbOa+X5cp/7bYTAy
         aofw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qrGUvUS/KIDwQcIGab309fFc7Hn4+1ct5OaaYFM/29w=;
        b=eE8WdZAwxsAic4x8Ohgd1hRTAlb2S4yUI5xCX0IHLJas/SWULylRzOWCuPgF4lgJjy
         y1uIVN0BRINSQyFVM2D9O3iue9vHrTA37qbF9aGNwMekge1jf4OHMKpfvF+UUwSZ3Q+y
         olBc+rCz9GYFcJCpPS/z/3vY5Xv2e9ZTTYDdkvA9Qbkze37VT+OCt5Q0rxwlIE166n46
         RifCPgnsPPKDPhDGPFbE187RtKx/feSdvJ8k5D0+er23xwQFpE3cNfN8R0NlAqs2pYTn
         FrKoOhJdYhWK5Fbrdh/cwT1eJhwClTN30zujINqI5+7CgUltGijBMwdUuzYMxL6syBgq
         vabA==
X-Gm-Message-State: AOAM5327TW/3KOw6HYPSUsKs4Xg6ZHqLiG31+lqFmVBqX1mF2ryPrLXk
	/qVRRadVcnmnc+yS6Qr0in7AlDWLcsbziDmTSnQ=
X-Google-Smtp-Source: ABdhPJz8Zixz9iOHRSHarGwc/mp2eUt5b8i28s21bK4CCcwVBiBuR+M3l80bTbzEGALKyz9y8jy/msoSHLG5FJM0r1w=
X-Received: by 2002:a9d:36d:: with SMTP id 100mr30558391otv.237.1629791921865;
 Tue, 24 Aug 2021 00:58:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20210824071926.68019-1-benbjiang@gmail.com> <fe512c8b-6f5a-0210-3f23-2c1fc75cd6e5@tessares.net>
In-Reply-To: <fe512c8b-6f5a-0210-3f23-2c1fc75cd6e5@tessares.net>
From: Jiang Biao <benbjiang@gmail.com>
Date: Tue, 24 Aug 2021 15:58:31 +0800
Message-ID: <CAPJCdBmTPW5gcO6DO5i=T+R2TNypzbaA666krk=7Duf2mt1yBw@mail.gmail.com>
Subject: Re: [PATCH] ipv4/mptcp: fix divide error
To: Matthieu Baerts <matthieu.baerts@tessares.net>
Cc: mathew.j.martineau@linux.intel.com, davem@davemloft.net, kuba@kernel.org, 
	netdev@vger.kernel.org, mptcp@lists.linux.dev, 
	linux-kernel <linux-kernel@vger.kernel.org>, Jiang Biao <benbjiang@tencent.com>, 
	Jiang Biao <tcs_robot@tencent.com>
Content-Type: text/plain; charset="UTF-8"

Hi,

On Tue, 24 Aug 2021 at 15:36, Matthieu Baerts
<matthieu.baerts@tessares.net> wrote:
>
> Hi Jiang,
>
> On 24/08/2021 09:19, Jiang Biao wrote:
>
> (...)
>
> > There is a fix divide error reported,
> > divide error: 0000 [#1] PREEMPT SMP KASAN
> > RIP: 0010:tcp_tso_autosize build/../net/ipv4/tcp_output.c:1975 [inline]
> > RIP: 0010:tcp_tso_segs+0x14f/0x250 build/../net/ipv4/tcp_output.c:1992
>
> Thank you for this patch and validating MPTCP on your side!
>
> This issue is actively tracked on our Github project [1] and a patch is
> already in our tree [2] but still under validation.
> > It's introduced by non-initialized info->mss_now in __mptcp_push_pending.
> > Fix it by adding protection in mptcp_push_release.
>
> Indeed, you are right, info->mss_now can be set to 0 in some cases but
> that's not normal.
>
> Instead of adding a protection here, we preferred fixing the root cause,
> see [2]. Do not hesitate to have a look at the other patch and comment
> there if you don't agree with this version.
> Except if [2] is difficult to backport, I think we don't need your extra
> protection. WDYT?
>
Agreed, fixing the root cause is much better.
Thanks for the reply.

Regards,
Jiang
