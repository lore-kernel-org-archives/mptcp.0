Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 310BA2560
	for <mptcp@lists.linux.dev>; Mon, 30 Jan 2023 13:07:57 +0000 (UTC)
Received: by mail-ed1-f50.google.com with SMTP id x7so7643389edr.0
        for <mptcp@lists.linux.dev>; Mon, 30 Jan 2023 05:07:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EQBC4AdTv7a1bQsBBSSFo6fMm2hDyxc8cEa/U2E+T40=;
        b=0BwK2D6wB3KT5o33N7sBoOqwTX7Y4AiHIA0J73dJP6ypGX/8kJxR/pS2WUirjwuQO8
         sxvx4quIjFADt9oXz9xqkk3C8ujJvNRgOvzqjvoxVBZSGkjWYSNb3S+ZTAkLpfRcApsI
         nfOLRbaMMzKOB34htId+avs6hTijpVdcLjkYCE5KYcrv8fwVp0G3i47E3J+uBpOwE6j6
         yR20+u3u/TSZsE0C3SOb91myrgeFaNH3TbtfahuGsDi9/luRHAztDCA9A1lUX0DbnPQ2
         3MHvk8D4F7XBFvL2F5kjFyOKTzTEnodTke7h2ELRnoIxr34w6L/wtgZeb0Lwk2EBWiRX
         QzNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EQBC4AdTv7a1bQsBBSSFo6fMm2hDyxc8cEa/U2E+T40=;
        b=vsccIK7GhO/JTVNdX53WiX80OZj8wK7yv7/4mn9y+efXcMROUg/jqaOm3OStu3CsLT
         k1SMO7UbiyDkgYMw3SsVzquoMAyIxo88cQsydihzFpDqo7Eded9wNrPFxJJuOaHOMrzj
         cNERjvnXfDDUT3wnAAfrT7J5eLdArPoP30xvfD7sYGe0ExpKU0F8Llsgwen62nVfVq4M
         aESNd0OMhfshe4QTT+fsqAg4ysf9n8BHF7MOnOQsrOoCG+4wt88BT6a93AdWgF8NJvTF
         ai8boVyD661a6NVkapaFkD2ijcRT+G5/o9dBp40eIgVAm9EDmg5rFpr0PnayZtooaxvT
         ivjQ==
X-Gm-Message-State: AO0yUKUnlRGvICFJ20+WLWN8RmEKSes0sfzyeiv7yIQLRROEfkPx2hhw
	WK6Cl0uK1IUxTrqLC/xhH9yo4ETr1/vF+XlzWkU=
X-Google-Smtp-Source: AK7set/AqGiu1ZNaxek7YenQHNx+LVN2ioB65KzMhaAchyIV/Xzh6wOEjgkF0arBx2/13IXIUJbDQQ==
X-Received: by 2002:a05:6402:139a:b0:4a2:1b97:228c with SMTP id b26-20020a056402139a00b004a21b97228cmr10220194edv.28.1675084075645;
        Mon, 30 Jan 2023 05:07:55 -0800 (PST)
Received: from [10.44.2.5] ([81.246.10.41])
        by smtp.gmail.com with ESMTPSA id dk7-20020a0564021d8700b004a2440f0150sm2014745edb.97.2023.01.30.05.07.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Jan 2023 05:07:55 -0800 (PST)
Message-ID: <4e87b544-d9f5-2e29-a5ec-180a44cc6338@tessares.net>
Date: Mon, 30 Jan 2023 14:07:54 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: MPTCP Scheduler API: new design: discussions
Content-Language: en-GB
From: Matthieu Baerts <matthieu.baerts@tessares.net>
To: MPTCP Upstream <mptcp@lists.linux.dev>
Cc: Tim Froidcoeur <tim.froidcoeur@tessares.net>
References: <dd4363e7-d057-97e8-0b5f-8570f39aa538@tessares.net>
In-Reply-To: <dd4363e7-d057-97e8-0b5f-8570f39aa538@tessares.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hello,

Here are some notes from the last meeting we had.

Feel free to react here before the next meeting.

TL;DR:

- a new callback each time a ACK is received is required
- penalisation: keep state per sf to send a fraction of the cwnd
- be able to re-inject quicker from the scheduler
- the default sched should do ↑


On 23/01/2023 17:00, Matthieu Baerts wrote:

(...)

> If we look at the "realistic" use cases, we should probably focus on the
> different features that are needed to reach good performance:
> 
> 
> - penalization:
>     - see mptcp_rcv_buf_optimization(): from mptcp.org:
> 
> https://github.com/multipath-tcp/mptcp/blob/825b62d597b5/net/mptcp/mptcp_sched.c#L300-L330
> 
>     - Halve the cwnd of the slow flows (once per RTT):
>         - looks like a hack: the CC will potentially reset the
> modification quickly after
>         - maybe we need another kind of limitation: a max number of
> "in-flight" packets
> 
>     - MPTCP has a view of all the different subflows, e.g.:
>         - one subflow can be "bad" (high latency, losses, with
> bufferbloat, etc.)
>         - we are limited by buffers (sender/receiver)
>         - we have to use the limited resources the best way!
> 
>     - need: additional limits/constraint, on top of TCP CC per subflow:
>         - not to have the CC continuing to say: yeah, go on, I can send more
> 
>     - this is done by all the "realistic" packet schedulers from mptcp.org:
>         - with the current API in the Upstream kernel, a new scheduler:
> could modify the cwnd but it could only do that *before* a "big batch"
> where the size cannot be controlled
>         - this could be handled by the core eventually
> 
>     - solutions:
>         - new way to tell the CC there are more data to take into account:
>             - acceptable by upstream?
> 
>         - having new dedicated CC:
>             - there could be dedicated CC, e.g.:
>                 - if multiple subflows of the same MPTCP connection
> share the same bottleneck as TCP flows
>                 - (and if it is important to be "fair" here)
> 
>             - but here we are talking about generic cases
>             - we don't want to maintain copies of many CC algorithms
> 
>         - having an "overlay congestion control": a way to limit
> push_pending() / tell the CC to "slow down"?
> 
>     => Part of this?
>        https://github.com/multipath-tcp/mptcp_net-next/issues/332

The "penalisation" is needed but probably not in that form: it is a hack
to change the cwnd. Instead, there should be a way to tell the core to
send less or stop sooner.

One way is to keep data per subflow and have the core using it somehow:
- new hook?
- asking to stop at which fraction of the cwnd?
  - Note: halving it is not enough, we might need to "<< X" with X > 2.
  - Note: maybe we will want to shift it + multiplication, e.g. 3/4, 7/8

→ We can start by only keeping state per subflow and see later if a hook
is really needed.

When to cancel this restriction?
- After each RTT? (check each time we need to send if last time we did
that was > 1 RTT)
- Each batch?

Still, to be able to do that, a new callback each time a ACK is received
is required.

> - optimistic retransmission:
>     - see mptcp_rcv_buf_optimization(): from mptcp.org:
> 
> https://github.com/multipath-tcp/mptcp/blob/825b62d597b5/net/mptcp/mptcp_sched.c#L332-L361
> 
>     - this is done by all the "realistic" packet schedulers from mptcp.org:
>         - with the current API in the Upstream kernel, a new scheduler
> doesn't have the ability to trigger a retransmission (depends on the core)
>         - this could be handled by the core eventually:
>             - what if the scheduler decide to pro-actively reinject data?
>             - e.g. when it consider a path as "unusable" for the moment
>             - all queued data should be reinjected
>             - still easier to handle with a flag?
> 
>     => the core should be improved to manage this for the generic cases
>        https://github.com/multipath-tcp/mptcp_net-next/issues/332
> 
>     => but it looks like advanced schedulers might be able to extend
> that (flag vs API flexibility)

Currently, in the upstream kernel:
  - reinjection is limited to MPTCP level RTO
  - this should be extended

> - probing:
>     - Use case: subflows flagged as "too bad to be used for the moment"
> (e.g. too high RTT according to the scheduler):
>         - it is then required to probe them from time to time
>         - by reinjecting the last sent data on this specific subflow
>         - (max one per RTT)
> 
>     - How to do that with the upstream API:
>         - flag MPTCP_WORK_RTX / MPTCP_RETRANSMIT?, defer to a specific
> subflow
>         - but: we need to do that *after* having scheduled the "fast"
> subflow and reinject something that has already been sent
>         - and: we only want to reinject one packet, not the full RTX
> queue and not something new:
>         - => here, to trigger rtt updates:
>             - only one packet in flight, only an already sent packet
>             - could a scheduler need to do more?
>             - flag vs more flexibility in the API
> 
>     => Maybe better to allow that with a flag?
>        Or a "post-push" callback but we will need to act on another subflow?
> 
>     => the scheduler should be able to interact with the "stale" logic
> we have in the upstream kernel: mark a subflow as stale / back active.

Seems needed, to be discussed: interact with the "stale" logic?

> - check: call scheduler when ACK (+ RTO) is received on another subflow?
>     - in mptcp.org, the scheduler is often called, even when one ACK
> needs to be sent (if I'm not mistaken): good to react on many events
>     - In case of probing, we will receive the ACK after the
> corresponding one has been received on the fast subflow (duplicated packet):
>         - nothing has changed at MPTCP level: acked data already acked
>         - yet, there is more room on the subflow so the scheduler will
> be checked (via push pending frames):
>         - the scheduler can reconsidered a subflow as "no longer bad"
> 
>     - same with the upstream sched API?
>         - currently in the upstream kernel, the scheduler is called when:
>             - the cwnd is being (re)opened
>             - new data are being pushed by the userspace

To be discussed.

> - use-case: support the "Priority" scheduler:
>     - how to: use the backup flag to have high and low prio
>     - result: use subflows even if there are non-backup subflows
> available and even if these non-backup subflows are not considered as
> "staled" (linked to stale_loss_cnt)
>     - reuse the "stale" logic

To be discussed: interact with the "stale" logic?

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
