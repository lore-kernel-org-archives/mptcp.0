Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC7B54B5C1
	for <mptcp@lists.linux.dev>; Wed, 20 Nov 2024 16:13:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732119236; cv=none; b=kWNRb/iUBC/Eh2GV8XlDHlsjWN2PEkdDMwxiTZDmgDPBGU3vIN1cPFmDzW3ATtihumVWl4v0ANHpYnsjPEFv8ok2ovB+9j47N80vThAWG9tvzE4gcz1YA64BX50dHi9G78wOYtdvoYxzSpbuaQ6zUzRSLO7N89izhpj6z7L0xmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732119236; c=relaxed/simple;
	bh=6dquPXmcvzZwZ7UNLGSo/e4SmGcQLkWTt1lEOQ8mB38=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=t/s5nuKoaghxdV5flRsYcGuiBga6fPLOOnm0itVtwMetr3lWhanCa9f/x9HmMEhgN3jgFcEO72TxIlh02MvEiNl2Q1mFIO7amBIYnWKO8KVK1Req3hk5BRhPRcKI+wzhykaXwGpAp7g/PlwbNmDmoPT0GG+HzctlpefCNb40P6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m382IvdR; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m382IvdR"
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-7f8cc29aaf2so1696850a12.3
        for <mptcp@lists.linux.dev>; Wed, 20 Nov 2024 08:13:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732119234; x=1732724034; darn=lists.linux.dev;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=e/HvFtGjqZ7DcsQBtPnZM2lJlY596mswDKkJjhdWmKo=;
        b=m382IvdRbgbSAfvYkAmHSDaxHHcGn1ZofqS+JEydrl3/Jf0uaw9gVcprQ71m5E3ivw
         SF7fRe3u6Oap4cFOFDlmkTBCu0cosfu9DzzJiSWh+UTRv2h6Zr0E2V78hp9gqlfqCqFX
         CT8S2JnT5t9zaFyj2oKA0Ct7nprz18oDdOicsHhN+zmnvUnqKDt5ioQ8IRpiSAFdFAF6
         04BtlpBUMrcpUAIVUmLboZt/VXbPU4JFyaIQc2lTciIMDrekF7eF/tWW5n5xcTVZVndb
         FW6sim9SQWX7px14GapsvBdJQvyrrQTH9XNM5z1ZoM7liGE///mi8/+7jSJJMzS7JqLt
         1Biw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732119234; x=1732724034;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=e/HvFtGjqZ7DcsQBtPnZM2lJlY596mswDKkJjhdWmKo=;
        b=v3tMdmC6mAc2gHx8QT6u+QED7dvUNnBd9MKvpbgpY4h4oddJtJTdOAO1Go0z1r+ed/
         Nb6HYTrHwFdIrbXSQkRxIdHJYT3SdlLKi9GEfI8jIFybi0G2NrgCsDOEOE0B0wxx4JrS
         hGHlBq5vIYWvin68ADVMLXHKE8a0rOWx8q21jfM4LCR4xpcLffb+Q6zpGkFOjmpxnfTo
         2PPQibY5/is1CJC6VJ33AXiR/qqWpC8d9rHh7dZAKWSG3U4p2iQQjukCzFIrj68tAyJu
         l2Av2uYDmORQRc10WyXY2WfE5yFcvN2EnLTyYx+8QG4R4hAtv+7gQQmhZfGY4Wyizs5y
         mS+A==
X-Forwarded-Encrypted: i=1; AJvYcCWAM6CIbQZ81yMBqF46hnzxpRFDbyBYuJcBF8a2EeX27Ktvmlre3IEyQI6Bw9gIBWRfCA5rTw==@lists.linux.dev
X-Gm-Message-State: AOJu0YyZBymrQre2Rxd+bs+yGFjL50xmmbvB9x4NheDrAS8vlHqDAyo3
	jQy9IRl0G3HafgwwSoHw5w7DJUUf+f2M+0F2UEs0Ty61eeF9TeyNOdj3yLOnP18+Il+Yey4C79J
	9IzShiNjxJQeCTIjN0IeLAuauu4M=
X-Gm-Gg: ASbGncuUKPRDV6SwTjhncc1eLFKyeYdUCjaAPKhLafxx3XcR6wGBKXqbk0aTzQKB62f
	nC49/lp4nBb7CtiSKn6u4umv7P66TJqBPQV73ikLfgce5XjO6VEHqlVRrhTKWDtFx6w==
X-Google-Smtp-Source: AGHT+IErlhHptHLWUZGmZIkis6XudrtzEe2+Y6fasY0LMn8WKG3iKlKQo1A0945v3nmksbHGL01UbUnKq6YQMAdMEdA=
X-Received: by 2002:a17:90b:5310:b0:2ea:819e:9126 with SMTP id
 98e67ed59e1d1-2eaca7cef44mr3317485a91.26.1732119234049; Wed, 20 Nov 2024
 08:13:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20241113-tcp-md5-diag-prep-v2-0-00a2a7feb1fa@gmail.com>
 <20241115160816.09df40eb@kernel.org> <7fb38122abcbcf28f7af8b9891d0b0852c01f088.camel@sipsolutions.net>
In-Reply-To: <7fb38122abcbcf28f7af8b9891d0b0852c01f088.camel@sipsolutions.net>
From: Dmitry Safonov <0x7f454c46@gmail.com>
Date: Wed, 20 Nov 2024 16:13:42 +0000
Message-ID: <CAJwJo6ZTT28XZ1HFhC77KrPeFmwVWDkFzYsg7YU1MD0PESAWrw@mail.gmail.com>
Subject: Re: [PATCH net v2 0/5] Make TCP-MD5-diag slightly less broken
To: Johannes Berg <johannes@sipsolutions.net>
Cc: Jakub Kicinski <kuba@kernel.org>, 
	Dmitry Safonov via B4 Relay <devnull+0x7f454c46.gmail.com@kernel.org>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, David Ahern <dsahern@kernel.org>, 
	Ivan Delalande <colona@arista.com>, Matthieu Baerts <matttbe@kernel.org>, 
	Mat Martineau <martineau@kernel.org>, Geliang Tang <geliang@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, Davide Caratti <dcaratti@redhat.com>, 
	Kuniyuki Iwashima <kuniyu@amazon.com>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	mptcp@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

On Wed, 20 Nov 2024 at 08:44, Johannes Berg <johannes@sipsolutions.net> wrote:
>
> (Sorry, late to the party)

Thanks for joining! :-)

> On Fri, 2024-11-15 at 16:08 -0800, Jakub Kicinski wrote:
> > Would it be too ugly if we simply retried with a 32kB skb if the initial
> > dump failed with EMSGSIZE?
>
> We have min_dump_alloc, which a number of places are setting much higher
> than the default, partially at least because there were similar issues,
> e.g. in nl80211. See e.g. nl80211_dump_wiphy() doing it dynamically.

Yeah, your example seems alike what netlink_dump() does with
min_dump_alloc and max_recvmsg_len. You have there
.doit = nl80211_get_wiphy,
.dumpit = nl80211_dump_wiphy,

So at this initial patch set, I'm trying to fix
inet_diag_handler::dump_one() callback, which is to my understanding
same as .doit() for generic netlink [should we just rename struct
inet_diag_handler callbacks to match the generics?]. See
inet_diag_handler_cmd() and NLM_F_DUMP in
Documentation/userspace-api/netlink/intro.rst
For TCP-MD5-diag even the single message reply may have a variable
number of keys on a socket's dump. For multi-messages dump, my plan is
to use netlink_callback::ctx[] and add an iterator type that will
allow to stop on N-th key between recvmsg() calls.

> Kind of ugly? Sure! And we shouldn't use it now with newer userspace
> that knows to request a more finely split dump. For older userspace it's
> the only way though.

Heh, the comment in nl80211_dump_wiphy() on sending an empty message
and retrying is ouch!

>
> Also, we don't even give all the data to older userspace (it must
> support split dumps to get information about the more modern features, 6
> GHz channels, etc.), but I gather that's not an option here.
>
> > Another option would be to automatically grow the skb. The size
> > accounting is an endless source of bugs. We'd just need to scan
> > the codebase to make sure there are no cases where someone does
> >
> >       ptr = __nla_reserve();
> >       nla_put();
> >       *ptr = 0;
> >
> > Which may be too much of a project and source of bugs in itself.
> >
> > Or do both, retry as a fix, and auto-grow in net-next.
>
> For auto-grow you'd also have to have information about the userspace
> buffer, I think? It still has to fit there, might as well fail anyway if
> that buffer is too small? I'm not sure we have that link back? But I'm
> not really sure right now, just remember this as an additional wrinkle
> from the above-mentioned nl80211 problem.

Yeah, netlink_recvmsg() attempts to track what the userspace is asking:

:        /* Record the max length of recvmsg() calls for future allocations */
:        max_recvmsg_len = max(READ_ONCE(nlk->max_recvmsg_len), len);
:        max_recvmsg_len = min_t(size_t, max_recvmsg_len,
:                                SKB_WITH_OVERHEAD(32768));
:        WRITE_ONCE(nlk->max_recvmsg_len, max_recvmsg_len);

Thanks,
             Dmitry
