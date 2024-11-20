Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11099191
	for <mptcp@lists.linux.dev>; Wed, 20 Nov 2024 00:20:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732062004; cv=none; b=uXaQd4jiHOj0mvXQDm4TMeFjkRHMRZ8E/puxXTvta9Ymx9T1/OjgVL/hSHLzk1i7VDjVpdHnqV/VLAPxnbLjo1D/aHAmcXf6e6yZIc1Q6aA/o1K1Ede8r2hxELOpxKc/QaEZP7oVYfex1QtGJzCdefuZMJv5iq/ugoqllsEJQhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732062004; c=relaxed/simple;
	bh=tffTpPg9rATtnzAwirYZjiWerQgCm6dW1J0qRe0a+PM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Xs3LMA+iD/1DcfFzsr/qW5IEiy+VGPx+Wv1oL0VD3Nf0OBfPTSnNUPBuINE7yVwwsU2i9NHLkcs0KU6JyFD068FNc/rYCnCQP141vdA4nn8EwBXs4+7zD7iGztxK5/Wfd4cEVtGUQF4S1vUCkizXnzAgVhJ75v/Vw4YnoVKGMQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Pg+XV+Bo; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pg+XV+Bo"
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-7ea9739647bso1240465a12.0
        for <mptcp@lists.linux.dev>; Tue, 19 Nov 2024 16:20:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732062002; x=1732666802; darn=lists.linux.dev;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=rfOtefJc4QMbrWO0NVuhXeyUXomckquTaAfyd1RDazg=;
        b=Pg+XV+Bo0HCKNNzslTqgzGVzJvfD07gFwtigBC5peUdXd4i0a4EhFO1F1kcqpw6stV
         ClMTImHLlmCzozyG+RzMY4t+0um0A8vDqQJ0snwWYfOdd7k/qBXkuwmHvVZ60hmT/mU1
         U7g1v4oHok+tplNBs6cALXlkoWq3L9b/L2V2e+JsdsqfrsudU/KhK+Du6X08NDQClLyx
         JEDoQQ2PPEArc1LXHc6S1+eXR9nS4h8rdq8yy/D9RFB2FnHt9Cae91JSfIZkyhgYTUNl
         HUjTSjxSzy9oesO65S2lFnFMsPQ+XpYhvYTZ7Y6IEPSYWYDBKGkjAhfOfBD+Wnm7ylM1
         g5ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732062002; x=1732666802;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rfOtefJc4QMbrWO0NVuhXeyUXomckquTaAfyd1RDazg=;
        b=Qpe8BsTLhGeLPtKH12Js8Cvmd5Xu7eF3tYGAz8vLkjdj0a8ZKg/JB4iv7Xk+gd9EEU
         iGH9LbmvYYSxLJLDEnZg26NMmaFzc7PAAPF8StfgBsgbOm6OU6oHEpiKuGXm+ZdpY0Ua
         lurJ+5GDJzCiM2fLgV5o9r17HbHsd26zPEsKsDHjvQnv0Wz5gezi4LqToz16qxh5Spdj
         gmK0w7RswSOy37/gehzq9EomgM/9+svJ9QDgndWmVBKv1RZ1oxElUSDwvW0YICk39hUH
         Pm1M30aVcc7DIQA7XTddnZoGMF7gfI3jg4uKnqugm659oKuoZAvfdZVdkmJEuypw+oTc
         qgKQ==
X-Forwarded-Encrypted: i=1; AJvYcCX1XPJ5B0+NFfbKL/Hz82rDwOcOasTQz4+ENvo2x+aK2TwAbFYrgPlUCUTznFUoO44hH+swwA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yx4UyAz8h46z2fRsSLy10NW4l4HD3b+sfFEVYb2Bp05Vpf1JspE
	B24GyrKpT2mwEEeadO0ClT/JmTb7cQzrOZHAllOxGQn8PrSJGSY0qe5Xy3ce3fTOigH7bG00DWs
	uWYzpcB+H7Wh7rrQ1WajvcIeVyeM=
X-Gm-Gg: ASbGncsfHGWd2KGkPHZliFXbvGuz4Kqd56g6e4eAxU3qx2vV+CVfD4SiNBNbTHBIM51
	rOKmaSwZc3onKuswmPy8DdvM3xWrW4mQ=
X-Google-Smtp-Source: AGHT+IFeHhLBLADhTmN6NURSzRgBeGkE7BulzP2DU+xkLm6ttNjZngS+9SrzBgqtUNZ+usG4nnueqm1tD6g1F6iovJk=
X-Received: by 2002:a17:90b:35c7:b0:2ea:9ccb:d1fe with SMTP id
 98e67ed59e1d1-2eaca1f5ab5mr1109554a91.0.1732062002160; Tue, 19 Nov 2024
 16:20:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20241113-tcp-md5-diag-prep-v2-0-00a2a7feb1fa@gmail.com>
 <20241115160816.09df40eb@kernel.org> <CAJwJo6ax-Ltpa2xY7J7VxjDkUq_5NJqYx_g+yNn9yfrNHfWeYA@mail.gmail.com>
 <20241115175838.4dec771a@kernel.org> <CAJwJo6YdAEj1GscO-DQ2hAHeS3cvqU_xev3TKbpLSqf-EqiMiQ@mail.gmail.com>
 <20241118161243.21dd9bc0@kernel.org>
In-Reply-To: <20241118161243.21dd9bc0@kernel.org>
From: Dmitry Safonov <0x7f454c46@gmail.com>
Date: Wed, 20 Nov 2024 00:19:50 +0000
Message-ID: <CAJwJo6YcPt5+9uQt4yuYS_7o+O8ubjEgOBrq9RmH+b8OpJxdGA@mail.gmail.com>
Subject: Re: [PATCH net v2 0/5] Make TCP-MD5-diag slightly less broken
To: Jakub Kicinski <kuba@kernel.org>
Cc: Dmitry Safonov via B4 Relay <devnull+0x7f454c46.gmail.com@kernel.org>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, David Ahern <dsahern@kernel.org>, 
	Ivan Delalande <colona@arista.com>, Matthieu Baerts <matttbe@kernel.org>, 
	Mat Martineau <martineau@kernel.org>, Geliang Tang <geliang@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, Davide Caratti <dcaratti@redhat.com>, 
	Kuniyuki Iwashima <kuniyu@amazon.com>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	mptcp@lists.linux.dev, Johannes Berg <johannes@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"

On Tue, 19 Nov 2024 at 00:12, Jakub Kicinski <kuba@kernel.org> wrote:
>
> On Sat, 16 Nov 2024 03:52:47 +0000 Dmitry Safonov wrote:
> > Kind of agree. But then, it seems to be quite rare. Even on a
> > purposely created selftest it fires not each time (maybe I'm not
> > skilful enough). Yet somewhat sceptical about a re-try in the kernel:
> > the need for it is caused by another thread manipulating keys, so we
> > may need another re-try after the first re-try... So, then we would
> > have to introduce a limit on retries :D
>
> Wouldn't be the first time ;)
> But I'd just retry once with a "very large" buffer.
>
> > Hmm, what do you think about a kind of middle-ground/compromise
> > solution: keeping this NLM_F_DUMP_INTR flag and logic, but making it
> > hardly ever/never happen by purposely allocating larger skb. I don't
> > want to set some value in stone as one day it might become not enough
> > for all different socket infos, but maybe just add 4kB more to the
> > initial allocation? So, for it to reproduce, another thread would have
> > to add 4kB/sizeof(tcp_diag_md5sig) = 4kB/100 ~= 40 MD5 keys on the
> > socket between this thread's skb allocation and filling of the info
> > array. I'd call it "attempting to be nice to a user, but not at their
> > busylooping expense".
>
> The size of the retry buffer should be larger than any valid size.
> We can add a warning if calculated size >= 32kB.

Currently, md5/ao keys are limited by sock_kmalloc(), which uses
optmem_max sysctl limit. The default nowadays is 128KB.

From [1] I see that the current in-kernel (struct tcp_md5sig_key) hits
optmem_max on
# ok 38 optmem limit was hit on adding 655 key
IOW, with the default limit and sizeof(struct tcp_diag_md5sig) = 100,
the maximum skb size would be ~= 65Kb. Sounds a little too big for
kmemcache allocation.

Initially, my idea was to limit this old version of tcp-md5-diag by
U16_MAX. Now I'm thinking of adopting your idea by always allocating
32kB skb for single-message and marking it somehow, if it's not big
enough to fit all the keys on a socket (NLM_F_DUMP_INTR or any other
alternative for userspace to get a clue that the single message wasn't
enough).

Then, as I planned, teach the multi-message dump iterator to stop
between recvmsg() on N-th md5/ao key and continue the dump from that
key on the next recvmsg().

> If we support an inf number of md5 keys we need to cap it.

Yeah, unfortunately, we have some customers with 1000 peers (and
because of that we internally test BGP with even more peers).
And that's with an assumption of one key per peer, which is not
necessarily true for AO.

> Eric is back later this week, perhaps we should wait for his advice.

Sure, I will be glad to have advice from you both, thanks!

> > > Right, the table based parsing doesn't work well with multi-attr,
> > > but other table formats aren't fundamentally better. Or at least
> > > I never came up with a good way of solving this. And the multi-attr
> > > at least doesn't suffer from the u16 problem.
> >
> > Yeah, also an array of structs that makes it impossible to extend such
> > an ABI with new members.
> >
> > And with regards to u16, I was thinking of this diff for net-next, but
> > was not sure if it's worth it:
> >
> > diff --git a/lib/nlattr.c b/lib/nlattr.c
> > index be9c576b6e2d..01c5a49ffa34 100644
> > --- a/lib/nlattr.c
> > +++ b/lib/nlattr.c
> > @@ -903,6 +903,9 @@ struct nlattr *__nla_reserve(struct sk_buff *skb,
> > int attrtype, int attrlen)
> >  {
> >   struct nlattr *nla;
> >
> > + DEBUG_NET_WARN_ONCE(attrlen >= U16_MAX,
> > +     "requested nlattr::nla_len %d >= U16_MAX", attrlen);
> > +
> >   nla = skb_put(skb, nla_total_size(attrlen));
> >   nla->nla_type = attrtype;
> >   nla->nla_len = nla_attr_size(attrlen);
>
> I'm slightly worried that this can be triggered already from user
> space, but we can try DEBUG_NET_* and see. Here and in nla_nest_end().

Yeah, I thought that CONFIG_DEBUG_NET is not enabled on generic
distros, but the description is:
:          Enable extra sanity checks in networking.
:          This is mostly used by fuzzers, but is safe to select.

not sure if that guards any production users from enabling it.
But that would be interesting to see if, with those new additions,
netdev doesn't produce any warnings.

[1] https://netdev-3.bots.linux.dev/vmksft-tcp-ao/results/867500/14-setsockopt-closed-ipv4/stdout

Thanks,
             Dmitry
