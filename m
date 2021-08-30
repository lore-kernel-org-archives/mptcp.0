Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com [209.85.167.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3BBE3FC3
	for <mptcp@lists.linux.dev>; Mon, 30 Aug 2021 03:32:23 +0000 (UTC)
Received: by mail-oi1-f182.google.com with SMTP id r26so18504258oij.2
        for <mptcp@lists.linux.dev>; Sun, 29 Aug 2021 20:32:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qYWX5+fW4xjujbLa4k+fgCWESUP9bq3v4p0R4RlvdMY=;
        b=XOCZngbHRsBW/HUCfhxvU4B4g2JR9j7ubX7/gy75ocJpQaphjZpMiafmeOgxznl9C7
         np2+76HQwlKnnfgMUZAYOks7JIKe+sgTB2ARDIBqw6Mx28m2yjUUaq3ZJLuSO6Z42px+
         E5ErS26qdI9rCPwbOA12+19TSQ4VIewCk8aNs7GsM3keVkNjKN4BbSUDbl6Tori+JuTE
         ARAb4/pQO27AVZET08e/SwyxwxD71WWomO/ZC3kZQxNy+JRJpEQ0GzeG1bLLGrDzzwNE
         YUonFV667J5DJ/9ZerFosPDT5Tuh1eN9dR0h3IG46HINFMLVhENWAvFClqeYDjH3jTfF
         e+4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qYWX5+fW4xjujbLa4k+fgCWESUP9bq3v4p0R4RlvdMY=;
        b=leuOO/NEFMPRuZwtp8RzHQghF3d4mRbYE1wmBSdbZbOozH++bbnS7LsTQr7y+9DpHl
         dF3N2mNyYiTUGqQdEIyiy9XzWSUqN2yXmMLBp1oOpEpJeRbvyO1U6Ib6sMJjXZhcPsBJ
         cXZrGEoKOLD4aaE1v9QoYtTgLyWyztAvWe4U9QqZ/Foc7jIQaoZGu8lXywctYJzG+//Y
         J2FDLCSUszNZ7NWvO1rQuxBvlIOYFp1XngQWsWyfKObcFIhdTiKE92nOaaTR+5awkyCY
         dywjO3GGK+M6Sv0NCcWsbv0z5vN9GZBZEPyG9cqf7/q/zXpRooWs5LZHznZjegKv09mv
         4Lvg==
X-Gm-Message-State: AOAM530Y/bSsECZFWVZ7pGtA86OlRUXiP6EHZmRGOYzo1Q9FKWE4Lrrr
	YC6WJ7iqNZkfBcZimDoo7sK/Ab7NX1Yh0DCfG1g=
X-Google-Smtp-Source: ABdhPJxWRhlLd73xrWLBTdl6wz0JyREpItsaujS3cleDpZ9WEAPe3FjiUR5EgczFuYZdpsrmnerPhs/RL8X5ddyyKHE=
X-Received: by 2002:aca:220a:: with SMTP id b10mr13980732oic.101.1630294343178;
 Sun, 29 Aug 2021 20:32:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20210824071926.68019-1-benbjiang@gmail.com> <fe512c8b-6f5a-0210-3f23-2c1fc75cd6e5@tessares.net>
 <CAPJCdBmTPW5gcO6DO5i=T+R2TNypzbaA666krk=7Duf2mt1yBw@mail.gmail.com> <f9b97b7f-cb48-f0bf-2dfb-a13bf1296b19@linux.intel.com>
In-Reply-To: <f9b97b7f-cb48-f0bf-2dfb-a13bf1296b19@linux.intel.com>
From: Jiang Biao <benbjiang@gmail.com>
Date: Mon, 30 Aug 2021 11:32:12 +0800
Message-ID: <CAPJCdBmqPgbxYTvViRQrzLgmNjQWc4PRmw_yScLgp0ktt-dVCQ@mail.gmail.com>
Subject: Re: [PATCH] ipv4/mptcp: fix divide error
To: Mat Martineau <mathew.j.martineau@linux.intel.com>
Cc: Matthieu Baerts <matthieu.baerts@tessares.net>, davem@davemloft.net, kuba@kernel.org, 
	netdev@vger.kernel.org, mptcp@lists.linux.dev, 
	linux-kernel <linux-kernel@vger.kernel.org>, Jiang Biao <benbjiang@tencent.com>, 
	Jiang Biao <tcs_robot@tencent.com>, Paolo Abeni <pabeni@redhat.com>
Content-Type: text/plain; charset="UTF-8"

On Thu, 26 Aug 2021 at 01:56, Mat Martineau
<mathew.j.martineau@linux.intel.com> wrote:
>
>
> On Tue, 24 Aug 2021, Jiang Biao wrote:
>
> > Hi,
> >
> > On Tue, 24 Aug 2021 at 15:36, Matthieu Baerts
> > <matthieu.baerts@tessares.net> wrote:
> >>
> >> Hi Jiang,
> >>
> >> On 24/08/2021 09:19, Jiang Biao wrote:
> >>
> >> (...)
> >>
> >>> There is a fix divide error reported,
> >>> divide error: 0000 [#1] PREEMPT SMP KASAN
> >>> RIP: 0010:tcp_tso_autosize build/../net/ipv4/tcp_output.c:1975 [inline]
> >>> RIP: 0010:tcp_tso_segs+0x14f/0x250 build/../net/ipv4/tcp_output.c:1992
> >>
> >> Thank you for this patch and validating MPTCP on your side!
> >>
> >> This issue is actively tracked on our Github project [1] and a patch is
> >> already in our tree [2] but still under validation.
> >>> It's introduced by non-initialized info->mss_now in __mptcp_push_pending.
> >>> Fix it by adding protection in mptcp_push_release.
> >>
> >> Indeed, you are right, info->mss_now can be set to 0 in some cases but
> >> that's not normal.
> >>
> >> Instead of adding a protection here, we preferred fixing the root cause,
> >> see [2]. Do not hesitate to have a look at the other patch and comment
> >> there if you don't agree with this version.
> >> Except if [2] is difficult to backport, I think we don't need your extra
> >> protection. WDYT?
> >>
> > Agreed, fixing the root cause is much better.
> > Thanks for the reply.
> >
>
> Hi Jiang -
>
> Could you try cherry-picking this commit to see if it eliminates the error
> in your system?
>
> https://github.com/multipath-tcp/mptcp_net-next/commit/9ef5aea5a794f4a369e26ed816e9c80cdc5a5f86
>
Errors' gone with the patch.:)

Regards,
Jiang
>
> Thanks!
>
> --
> Mat Martineau
> Intel
