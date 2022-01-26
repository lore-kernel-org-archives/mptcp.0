Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com [209.85.219.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A105168
	for <mptcp@lists.linux.dev>; Wed, 26 Jan 2022 18:02:39 +0000 (UTC)
Received: by mail-yb1-f170.google.com with SMTP id k31so1216720ybj.4
        for <mptcp@lists.linux.dev>; Wed, 26 Jan 2022 10:02:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7SdXBvGbOpOY/4kmO/R/ivRpvZgo0xmy4QSxKe3/74U=;
        b=C2DN6CKH0cqmpDDWQpTb+86bIKfsusqney7cqrye6yUpfLpjk/wCs/URhXuomAzZDk
         /yS2jUbpei0RDYlq99g4Cv3mShTY4g3PcLJ6TN4XXkJffI8ZctAIQuIJNt83EcYDkmkF
         555l/foXGL6aD5yk/qzdYUFScRLCrJFQguz1UvvKfhl5TfWYnT0MxNdv5UYfepJ/KpMi
         iywi+CZmxjP10Cj0kp8I73RSHq2TXb61uIenzDS21+e3LPllp3XslIfhRGitY6B6v5t2
         zLo3bzRncg1QPNAZVY7UlVDLxxX8xW7xct7Kk3BrRBNDU5Qt+P3sZqImZEQAYW7Zkijs
         Gjbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7SdXBvGbOpOY/4kmO/R/ivRpvZgo0xmy4QSxKe3/74U=;
        b=BFiPoxSswOgpFoEEv/T6sfNez1YiP6VLoksC1I9XpoC7k0regHQUebAiLZ3RAOKfaN
         jQLUID+jcUO+ZtdJcotH4oQlyb/4aS/YiJC8SHMoJekpcA17bnHXxDDWxvCUeoPsAryU
         bx88OsI7dCyKUvxqw3w9OGG3XJTHclDgQKcN6wP9ZL37HTAIrs9SbJ1yX9sb00kO+9Mw
         A2IJKd139+4bkw6ghHxuxgt2AcDb3Q77zSG3b4qHm+b0t8A7lHbh9O3vEI+WsOUhBeOi
         bX7EzbFIuouDT9XUASNN887RQVeqScFRB9GUOzPDfs9M+kRap0utwmJaRgX1V+rNnFxv
         Ui2w==
X-Gm-Message-State: AOAM532GC7+m6EOJUrXQ9YusT2RCWVVNOr/4ATE0qVFZDsuuTCB+YW9p
	cIvz5qDJImpbosO6fvHrsjMCN9G1y0X+GYejz9KqhA==
X-Google-Smtp-Source: ABdhPJzLAcy57agCmX6g7z+ig3kGKeizB4jLOnpaZ7HV88XMt4hjkcq+h1pioK4RACpTvdeTdlFjqneU42Yf3n1hTXs=
X-Received: by 2002:a25:9d11:: with SMTP id i17mr73462ybp.383.1643220158473;
 Wed, 26 Jan 2022 10:02:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20220124202457.3450198-1-eric.dumazet@gmail.com>
 <20220124202457.3450198-7-eric.dumazet@gmail.com> <6cccaaa7854c98248d663f60404ab6163250107f.camel@redhat.com>
 <CANn89iLCdpgh9vWd_A70mPqkRgLTk9aqNY=zV2ibtVus9YLxeA@mail.gmail.com> <3ecef3c4c1d158fc1c5812918e1710bce57c4812.camel@redhat.com>
In-Reply-To: <3ecef3c4c1d158fc1c5812918e1710bce57c4812.camel@redhat.com>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 26 Jan 2022 10:02:27 -0800
Message-ID: <CANn89iJrm1yhQOdguVEHh5B=YJGJig-kV3QFkXRat=BWAOHuMQ@mail.gmail.com>
Subject: Re: [PATCH net-next 6/6] ipv4/tcp: do not use per netns ctl sockets
To: Paolo Abeni <pabeni@redhat.com>
Cc: Eric Dumazet <eric.dumazet@gmail.com>, "David S . Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, netdev <netdev@vger.kernel.org>, 
	MPTCP Upstream <mptcp@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"

On Wed, Jan 26, 2022 at 8:35 AM Paolo Abeni <pabeni@redhat.com> wrote:
>
> On Wed, 2022-01-26 at 08:24 -0800, Eric Dumazet wrote:
> > I was working a fix. syzbot found the issue yesterday before I went to bed ;)
>
> I know that is not a nice way to get some rest :(
>
> > (And this is not related to MPTCP)
> >
> > My plan is to make struct inet_timewait_death_row not a sub-strutcure
> > of struct netns_ipv4
> >
> > (the atomic_t tw_count becomes a refcount_t as a bonus)
>
> Sounds good. We can test the patch, if that helps (e.g. if syzbot lacks
> a repro or the repro is not very reliable)

Sure, I am going to CC you on the upcoming patch (in few minutes)

Thanks !
