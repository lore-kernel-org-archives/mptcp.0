Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B21D33FC2
	for <mptcp@lists.linux.dev>; Thu, 26 Aug 2021 03:22:34 +0000 (UTC)
Received: by mail-ot1-f48.google.com with SMTP id i3-20020a056830210300b0051af5666070so1718103otc.4
        for <mptcp@lists.linux.dev>; Wed, 25 Aug 2021 20:22:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bUeZZcRUwgsVKTg9hbUOFpXsEAgjIJCFQuo9JR/6uzc=;
        b=Cd+PYR/CcyaKB2Dv5SB33p47LhOGWZXNOHn1EdmwVk1xcpzdrlZ6xHmaxnv2H1iPGf
         RWtP8SHbN3xokld1eM/pm5ttcqP5oEVT3y2TUXHs9mzHYDOL5ViUCwYYIhEstqF70Xfp
         WJuv/0dJdP/tOW4nFPoUoYJVY8ksZK6uTBcL2dfkCvEqvr9MPxqLKenyIHOEOED7k9fP
         mE1OcurZBALiFsM6WDqfM97C0n+lhT/e6Q4pbTF5SCAfMxtOP/qx8KGfQiJ1ujkQVkgf
         7i9VtdHZ42y7O9CHoQnhHn5VTuFgre5r3KC01v84y3Q2g+/0/OiXLFD9PY+X/ZGfUQCJ
         TbtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bUeZZcRUwgsVKTg9hbUOFpXsEAgjIJCFQuo9JR/6uzc=;
        b=B6XJzVWGvlpWrLJk2PHm0fb+EuzM64DE3NMVcaiAeyCPuCLj+7l8uOLERrZL9hFpNI
         HnolzuQCLcvketki6lrGlV6aYiIS7aONSmtfGepOL5UrwrvUspQoJdRMDGankNJedlDS
         xAnnTOBUtT150BujhsaNSN0Bsg3P9SuMU9uoZ4Nv/i7aHGop71W7FIBUhXKLvD3EUxA0
         qHxHaZUqJYj7wTzBpMSF/mSdg7ePQwiwPDns/8Z3lbrx2HiVlN/pygm0S0gJRSsoxLZ1
         q7FtxDwqNIRg5pyUDxU2LG+vkGm+dSHHw2M6cO0x7AtJo2uLhxV0BrwEMkOzWlvr9uGJ
         DTqQ==
X-Gm-Message-State: AOAM530Zh8yQchUlKa5VFRv6JeSSIJm7LB86ADGTMbKkDNv5bCxTn/X1
	DJCUxGmgn+wk2c1qhslTg8yDYCMXY2jZ0LTGt0Q=
X-Google-Smtp-Source: ABdhPJxgk1EqPZK7qA7ih/uquKPxaLzFqjR5sZ54uxK1N75LUQxoav/lMAWNN1uN0WKcEyzI+s06wNoInRxtLucaEAY=
X-Received: by 2002:a05:6830:20d0:: with SMTP id z16mr1331201otq.330.1629948153918;
 Wed, 25 Aug 2021 20:22:33 -0700 (PDT)
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
Date: Thu, 26 Aug 2021 11:22:23 +0800
Message-ID: <CAPJCdB=MF=PY0R+a1Ka9ymDvp9EXf2HbzosAC1sUh547EcAjOA@mail.gmail.com>
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
ok, I'll try and give you feedback.

Regards,
Jiang
