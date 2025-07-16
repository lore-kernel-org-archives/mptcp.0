Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49A2F256C6D
	for <mptcp@lists.linux.dev>; Wed, 16 Jul 2025 01:43:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752630204; cv=none; b=fyroq0VTCZ5WemuvVzF9OxHAiQSqYUDxYQ7uxB3i6pU2PpUhacnJvCWO9sqK8AKVraPGGkMazlrqvbRVQVc4NN5yjWe9wk+I3KdgpAlRYSKBdHzKvotoKpVA9+2Mxtp8e26JqRyB1G7x3aK2+sGT8k5rK4mIjAAb92yT86cdSIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752630204; c=relaxed/simple;
	bh=MH4uM2o0F/XXREDRbk+NXbYsSqxe1eunM65v5DAs1T4=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=F2uZllHB8Y9l/fTeJvYQUwmBqQ3YGLVZah6JKTWaQW2OpvH8rXBFsBIesiSNLaa7r6sFY+81UFT0vgILU+rCH2UnHPcFNEGbW1Q83yEkRTptlD3aChHEon4LekgvR0Wh/l8ELbucmXtIwYedpkGDfzrsWC2Ng/YA/Kk4tapHe8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fOIb6CV8; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fOIb6CV8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFE1BC4CEE3;
	Wed, 16 Jul 2025 01:43:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752630203;
	bh=MH4uM2o0F/XXREDRbk+NXbYsSqxe1eunM65v5DAs1T4=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=fOIb6CV863JRZg/SsirAg3V6/qOpj3eKnmodBhezQTuf9ivq7kDZeE/okgeeCv3C5
	 R98w4bVxuS5PJNwtfleyqaUF4lLwy+l9DJ+Y2zn5Nmf6prZmffNfI3sjbwL53yuz2m
	 5uxijDx997ifL58K/Zd6wl6t78Xbgayb2vOzT+Xlg6yIQSynv0pci6FUVMncSwowME
	 sjatX8VEdb12FHOVGi7At1Xkp3CgzQdfKBv3akW+fgyheWENxKNFqaT6apw2g0YpaI
	 edcNbxjbNclBEoTAnlrWm+USpg8jQC6i2IOdjw3Uc1zncJ4+DPY1kO8JOfblMicLfM
	 AKePUVtD9VC4Q==
Date: Tue, 15 Jul 2025 18:43:22 -0700 (PDT)
From: Mat Martineau <martineau@kernel.org>
To: Geliang Tang <geliang@kernel.org>
cc: Matthieu Baerts <matttbe@kernel.org>, mptcp@lists.linux.dev, 
    Geliang Tang <tanggeliang@kylinos.cn>
Subject: Re: [PATCH mptcp-next v3 0/3] send() fails with EAGAIN in blocking
 IO mode #487
In-Reply-To: <47e97515be89fea46a0253aa8aa880130d87b39b.camel@kernel.org>
Message-ID: <760369c0-855f-1fd0-a268-fc3960b79956@kernel.org>
References: <cover.1748484770.git.tanggeliang@kylinos.cn> <a5c20f9f-3038-ed11-b78c-522ef40f9031@kernel.org> <23fd5569-f383-441e-9be4-48a8430954d9@kernel.org> <b90f35f04a8ea06593c44e988b39615a06646deb.camel@kernel.org>
 <47e97515be89fea46a0253aa8aa880130d87b39b.camel@kernel.org>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="0-1523353547-1752630203=:92643"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--0-1523353547-1752630203=:92643
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8BIT


Hi Geliang -

On Sun, 29 Jun 2025, Geliang Tang wrote:

> Hi Mat, Matt,
>
> On Mon, 2025-06-16 at 14:34 +0800, Geliang Tang wrote:
>> Hi Matt, Mat,
>>
>> On Sun, 2025-06-15 at 23:29 +0200, Matthieu Baerts wrote:
>>> Hi Mat, Geliang,
>>>
>>> On 14/06/2025 01:11, Mat Martineau wrote:
>>>> On Thu, 29 May 2025, Geliang Tang wrote:
>>>>
>>>>> From: Geliang Tang <tanggeliang@kylinos.cn>
>>>>>
>>>>> Good news! I finally solved the unstable issue of MPTCP BPF
>>>>> sched
>>>>> selftests
>>>>> I reported a year ago, #487 "send() fails with EAGAIN in
>>>>> blocking
>>>>> IO
>>>>> mode".
>>>>>
>>>>> The fix is simple, it can be solved by explicitly setting
>>>>> SO_SNDBUF
>>>>> sockopt, but be sure not to set SO_RCVBUF at the same time
>>>>> (see sk->sk_userlocks & SOCK_RCVBUF_LOCK in
>>>>> mptcp_rcv_space_adjust()).
>>>>>
>>>>> With this fix, BPF sched selftests are now very stable, I run
>>>>> loop
>>>>> testing
>>>>> using mptcp-upstream-virtme-docker (run_loop run_bpftest_all),
>>>>> and can
>>>>> run
>>>>> it normally for hundreds of times without error:
>>>>>
>>>>
>>>> Hi Geliang -
>>>>
>>>> I can see how changing SO_SNDBUF on the sending socket side would
>>>> shift
>>>> timing behavior in a way that affect the test outcome, but it
>>>> doesn't
>>>> address the root issue with bug #487:
>>>>
>>>> It is either OK to get an EAGAIN from a blocking send(), or it's
>>>> not OK.
>>>>
>>>>
>>>> If it's not ok to ever return EAGAIN from a blocking send, the
>>>> existing
>>>> test code is a reproducer for a bug, and changing the test is
>>>> hiding
>>>> that bug.
>>>>
>>>> If EAGAIN is ok, then we should change the code in
>>>> send_recv_server() to
>>>> allow it.
>>
>> I did try to handle EAGAIN in send_recv_server() but it didn't work.
>> MPTCP BPF sched selftests still fail. Test code and results are
>> attached.
>>
>> I added this in send_recv_server():
>>
>> 	if (errno == EAGAIN && again < 5) {
>> 		again++;
>> 		continue;
>> 	}
>>
>> And still got the EAGAIN error:
>>
>> # (network_helpers.c:728: errno: Resource temporarily unavailable)
>> send
>> 7867500 expected 10485760
>> # (network_helpers.c:782: errno: Resource temporarily unavailable)
>> recv
>> 3469500 ​​expected 10485760
>> # (network_helpers.c:790: errno: Resource temporarily unavailable)
>> Failed in thread_ret -11
>> # send_data_and_verify:FAIL:send_recv_data unexpected error: -11
>> (errno
>> 11)
>>
>> In addition, BPF selftests adds a new mechanism that does not allow
>> any
>> test item to run for more than 10 seconds. Otherwise, the following
>> error will be reported:
>>
>> # WATCHDOG: test case mptcp/default executes for 10 seconds...
>>
>> In my testing, I have not found any other solution besides limiting
>> the
>> send buffer. This allows data to be sent at a constant rate, which
>> ensures the stability of MPTCP BPF sched selftests.
>>
>> In order to avoid hiding this bug, we can add a test item for this in
>> mptcp selftest in the future, like in [1].
>
> Last week I debugged this issue further and found something (Thanks to
> Gang Yan for his help): when mptcp bpf sched selftests fail, the memory
> limit check (if (sk_rmem_alloc_get(sk) > sk->sk_rcvbuf)) is always true
> in __mptcp_move_skbs_from_subflow(), at this time sk->sk_receive_queue
> is empty,

Thanks for tracking down some more details!

> but no skb is moved from this subflow to sk->
> sk_receive_queue, which causes the transmission to fail.
>

I'm trying to understand this part (above) better. 
__mptcp_move_skbs_from_subflow() is on the receive path. What is the path 
to causing transmission to fail? Does exiting the loop early on the rx 
side leave ssk->sk_err set, so an error propagates in the msk and 
sendmsg() returns early with EAGAIN?

> One fix is ​​to also consider the case where sk->sk_receive_queue is
> empty when doing the memory limit check:
>
>  -               if (sk_rmem_alloc_get(sk) > sk->sk_rcvbuf)
>  +               if (sk_rmem_alloc_get(sk) > sk->sk_rcvbuf &&
>  +                   !skb_queue_empty(&sk->sk_receive_queue))
>                          break;

The msk sk_receive_queue is probably empty a lot of the time, does it look 
like the empty queue is related to the failure?

>
> In addition, this memory limit check was moved from the end of do {}
> while (more_data_avail) to the front in the commit e0ca4057e0ec
> ("mptcp: micro-optimize __mptcp_move_skb()"), so another better fix is
> ​​to restore this check to the end of do {} while () so that move skbs
> from this subflow to sk->sk_receive_queue always has a chance to do at
> least once:
>
> @@ -587,9 +587,6 @@ static bool __mptcp_move_skbs_from_subflow(struct
> mptcp_sock *msk,
>                struct sk_buff *skb;
>                bool fin;
>
> -               if (sk_rmem_alloc_get(sk) > sk->sk_rcvbuf)
> -                       break;
> -
>                /* try to move as much data as available */
>                map_remaining = subflow->map_data_len -
>                                mptcp_subflow_get_map_offset(subflow);
> @@ -634,6 +631,8 @@ static bool __mptcp_move_skbs_from_subflow(struct
> mptcp_sock *msk,
>                WRITE_ONCE(tp->copied_seq, seq);
>                more_data_avail = mptcp_subflow_data_available(ssk);
>
> +               if (sk_rmem_alloc_get(sk) > sk->sk_rcvbuf)
> +                       break;
>        } while (more_data_avail);
>
> I think this is the root cause of #487, I would like to hear your
> opinions on which fix is ​​better.

I have a slight preference for the second possible fix since it still 
provides an exit from the loop even when the sk_receive_queue is empty. 
Can you send that patch?

Before we merge a fix I'm still hoping to understand how letting this loop 
body run once on the rx path is changing the tx side behavior!

Thanks,
Mat

>
> Thanks,
> -Geliang
>
>>
>> WDYT?
>>
>> Thanks,
>> -Geliang
>>
>> [1]
>> https://patchwork.kernel.org/project/mptcp/cover/cover.1722502941.git.tanggeliang@kylinos.cn/
>>
>>>
>>> It is now a bit hidden in the middle of #487, but if I'm not
>>> mistaken,
>>> it is OK to get EAGAIN with a blocking send() **if** SO_SNDTIMEO is
>>> used, and in case of timeout.
>>>
>>> See:
>>> https://github.com/multipath-tcp/mptcp_net-next/issues/487#issuecomment-2485577676
>>>
>>> So I think the question should be: is it normal to block for longer
>>> than
>>> the timeout period (which is a "long" period, no?)? If yes, then
>>> limiting the send buffer might be a solution, but as Mat said, it
>>> looks
>>> better to understand the root cause than hiding a bug :)
>>>
>>> Cheers,
>>> Matt
>
--0-1523353547-1752630203=:92643--
