Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA45163C4
	for <mptcp@lists.linux.dev>; Mon, 23 Jan 2023 16:00:35 +0000 (UTC)
Received: by mail-ed1-f41.google.com with SMTP id w14so15119386edi.5
        for <mptcp@lists.linux.dev>; Mon, 23 Jan 2023 08:00:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1Y5HlkkdKNpWJivXnmZe7aX5G7EvY6UJ2iytSK3btMg=;
        b=MJ2spPPdj2j1ql57HkWlxKQ/ZugQTLZgwjinNysce+G3icGcZvVoTSs4aDpQf2gn9t
         oOmMoZC/jbfgfdviQMFFjx2dLvQGm48N8OQM6GIDD4gFrIL3AxfFQc1YXJqAkKWIHqyK
         P9UvEu2gdPKwW8zqF8UWO6WVOa75h+WExZuFdlgxSkXNLYAJf9zdIAX6IXhXUKMbRJJS
         ex7iy/F+JjrUoMCGPwvd4f0JKFrfSGnCWWZ5XcqMXfcP+QHsk0n/FqPlb0PkAFnf2gIx
         VgeZz9we0v0adbdzL5GADQ8W6jSaH1KXLBCSlcdWgzn7BL23yJHfXAjIQm+CERd437/Y
         I4tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=1Y5HlkkdKNpWJivXnmZe7aX5G7EvY6UJ2iytSK3btMg=;
        b=qeORyyS2RvKAFACAj3gFZKr/o1ZLmY6eSCLnF21NzIc1e/l/7hYpJQjHY8rS6DNuEO
         KxlLaeCUek4jA3cVhNqMrW+ADcE8Vj9GiQy4BglvSN9myrvTjZMXgIBzSkPS3VJPX+JT
         aReaBg7nG1byIfRqGKXc/qPlr1E6/6uNjND/lLEnAbIDUniY2xsjjer4efm4N6WScxJG
         E3CdzvQupo7DwUE3RRoUVuVnxoZ4j6OecQvEDvQMdoGQDCTXZkaPJG387vovEMmKiuqU
         FWXHrzsfOG5mHQYRJGkT7Qo1JZH/JmZ4eX2Y+VGoa8SrX3ILXg78MwI78F1iOA0sPEAL
         aXdA==
X-Gm-Message-State: AFqh2kp9YniXJaUfK5mrGQdNcBo9xN596zswH5xffv9XEPPz5Rj7Q780
	yEE91DS5SsOjd3Z7agJR3R6Nrq0ZNZyg3+Cc
X-Google-Smtp-Source: AMrXdXusnCmjL0fnB5V/wF6rJQXRCO/MJNRW4HZzJQHbdcaNmawlvySvPAWyfZCz29nV6IjbPjhWpw==
X-Received: by 2002:a05:6402:2b9b:b0:49d:34ae:c7aa with SMTP id fj27-20020a0564022b9b00b0049d34aec7aamr26811689edb.29.1674489633200;
        Mon, 23 Jan 2023 08:00:33 -0800 (PST)
Received: from [10.44.2.5] ([81.246.10.41])
        by smtp.gmail.com with ESMTPSA id v2-20020a170906292200b008710789d85fsm11355896ejd.156.2023.01.23.08.00.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Jan 2023 08:00:32 -0800 (PST)
Message-ID: <dd4363e7-d057-97e8-0b5f-8570f39aa538@tessares.net>
Date: Mon, 23 Jan 2023 17:00:32 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Content-Language: en-GB
To: MPTCP Upstream <mptcp@lists.linux.dev>
Cc: Tim Froidcoeur <tim.froidcoeur@tessares.net>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
Subject: MPTCP Scheduler API: new design: discussions
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hello,

At the last meeting, we discussed about the MPTCP Scheduler API to see
if it is flexible enough to implement realistic use-cases while still
being optimised for the generic cases.


For the moment, the current MPTCP Scheduler API in the Upstream kernel
only lets the scheduler pick the next subflow. It is different from
mptcp.org where the schedulers can pick the data (skb) and the subflows
(sk).

In mptcp.org, there are a few schedulers available:
- the default one: min RTT first
- BLEST: Blocking estimation-based
- ECF: Earliest Completion First
- Redundant: duplicate each packet over all subflows
- Round-Robin: per packet

BLEST and ECF can be seen as extensions of the default one. They even
use the same function to select the next segment (skb): only the
selection of the next subflow is modified.


We can also refer to an IETF draft[1] mentioning different types of
schedulers:
- Round-Robin (same as above)
- Weighted Round-Robin (extension of the RR)
- Strict Priority
- Round-Trip-Time Threshold
- Lowest Round-Trip-Time First (the default on in MPTCP)
- Combination of schedulers type: Priority and Lowest round-trip-time first

[1]
https://www.ietf.org/archive/id/draft-bonaventure-iccrg-schedulers-02.html

To me, the per-packet Round-Robin scheduler doesn't make sense: it has
been added in mptcp.org to validate the API was working with another and
simple scheduler. But it doesn't seem to provide any advantage on a real
network (maybe if you have two identical links between 2 hosts nearby
but then use something lower level, like a LAG).

The redundant scheduler is very specific. It is not clear to me if MPTCP
is the right technology to ensure we keep a low latency and all packets
are delivered without damage and in order. But I think if we want to
support it, it should not impact the performances with the "generic" case.



If we look at the "realistic" use cases, we should probably focus on the
different features that are needed to reach good performance:


- penalization:
    - see mptcp_rcv_buf_optimization(): from mptcp.org:

https://github.com/multipath-tcp/mptcp/blob/825b62d597b5/net/mptcp/mptcp_sched.c#L300-L330

    - Halve the cwnd of the slow flows (once per RTT):
        - looks like a hack: the CC will potentially reset the
modification quickly after
        - maybe we need another kind of limitation: a max number of
"in-flight" packets

    - MPTCP has a view of all the different subflows, e.g.:
        - one subflow can be "bad" (high latency, losses, with
bufferbloat, etc.)
        - we are limited by buffers (sender/receiver)
        - we have to use the limited resources the best way!

    - need: additional limits/constraint, on top of TCP CC per subflow:
        - not to have the CC continuing to say: yeah, go on, I can send more

    - this is done by all the "realistic" packet schedulers from mptcp.org:
        - with the current API in the Upstream kernel, a new scheduler:
could modify the cwnd but it could only do that *before* a "big batch"
where the size cannot be controlled
        - this could be handled by the core eventually

    - solutions:
        - new way to tell the CC there are more data to take into account:
            - acceptable by upstream?

        - having new dedicated CC:
            - there could be dedicated CC, e.g.:
                - if multiple subflows of the same MPTCP connection
share the same bottleneck as TCP flows
                - (and if it is important to be "fair" here)

            - but here we are talking about generic cases
            - we don't want to maintain copies of many CC algorithms

        - having an "overlay congestion control": a way to limit
push_pending() / tell the CC to "slow down"?

    => Part of this?
       https://github.com/multipath-tcp/mptcp_net-next/issues/332



- optimistic retransmission:
    - see mptcp_rcv_buf_optimization(): from mptcp.org:

https://github.com/multipath-tcp/mptcp/blob/825b62d597b5/net/mptcp/mptcp_sched.c#L332-L361

    - this is done by all the "realistic" packet schedulers from mptcp.org:
        - with the current API in the Upstream kernel, a new scheduler
doesn't have the ability to trigger a retransmission (depends on the core)
        - this could be handled by the core eventually:
            - what if the scheduler decide to pro-actively reinject data?
            - e.g. when it consider a path as "unusable" for the moment
            - all queued data should be reinjected
            - still easier to handle with a flag?

    => the core should be improved to manage this for the generic cases
       https://github.com/multipath-tcp/mptcp_net-next/issues/332

    => but it looks like advanced schedulers might be able to extend
that (flag vs API flexibility)



- probing:
    - Use case: subflows flagged as "too bad to be used for the moment"
(e.g. too high RTT according to the scheduler):
        - it is then required to probe them from time to time
        - by reinjecting the last sent data on this specific subflow
        - (max one per RTT)

    - How to do that with the upstream API:
        - flag MPTCP_WORK_RTX / MPTCP_RETRANSMIT?, defer to a specific
subflow
        - but: we need to do that *after* having scheduled the "fast"
subflow and reinject something that has already been sent
        - and: we only want to reinject one packet, not the full RTX
queue and not something new:
        - => here, to trigger rtt updates:
            - only one packet in flight, only an already sent packet
            - could a scheduler need to do more?
            - flag vs more flexibility in the API

    => Maybe better to allow that with a flag?
       Or a "post-push" callback but we will need to act on another subflow?

    => the scheduler should be able to interact with the "stale" logic
we have in the upstream kernel: mark a subflow as stale / back active.



- check: call scheduler when ACK (+ RTO) is received on another subflow?
    - in mptcp.org, the scheduler is often called, even when one ACK
needs to be sent (if I'm not mistaken): good to react on many events
    - In case of probing, we will receive the ACK after the
corresponding one has been received on the fast subflow (duplicated packet):
        - nothing has changed at MPTCP level: acked data already acked
        - yet, there is more room on the subflow so the scheduler will
be checked (via push pending frames):
        - the scheduler can reconsidered a subflow as "no longer bad"

    - same with the upstream sched API?
        - currently in the upstream kernel, the scheduler is called when:
            - the cwnd is being (re)opened
            - new data are being pushed by the userspace



- use-case: support the "Priority" scheduler:
    - how to: use the backup flag to have high and low prio
    - result: use subflows even if there are non-backup subflows
available and even if these non-backup subflows are not considered as
"staled" (linked to stale_loss_cnt)
    - reuse the "stale" logic



- conclusion:
    - just selecting the next subflow is not enough

    - it seems important to have a way, from the scheduler side, to:
        - limit the number of packets and penalize some subflows:
"overlay congestion control"
        - force a reinjection (switch to a new subflow or probing)
        - make sure we are called when there are new info on MPTCP and
subflow level

    - in //, the default scheduler should implement the "opportunistic
retransmission algorithm", see ticket #332



WDYT?



------------------------------------------------------------------------



Other than that, there are some requirements to store and update info:
    - Access socket/TCP/MPTCP info:
        - e.g. tp->snd_cwnd, tp->snd_ssthresh, tcp_packets_in_flight(), etc.
        - BPF: should be OK

    - Store additional info per msk or ssk:
        - e.g. timestamps (last opti, max/min rtt, etc.)
        - BPF: hashmap using the pointer as a key
        - note that the msk has some bytes in the structures that are
not used, e.g. the ones related to the CC:
            - we could let write access to this area
        - we can also expend the subflow struct context size to have
some space per subflow:
            - like the previous one: can be seen as an opti for later

    - Update subflow info:
        - e.g. tp->snd_cwnd, tp->snd_ssthresh: opti rbuf
        - maybe not needed, see above (penalization)



------------------------------------------------------------------------



(Thanks to Tim Froidcoeur for his help to create the original list!)

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
