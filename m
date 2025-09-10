Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FDEC3115BB
	for <mptcp@lists.linux.dev>; Wed, 10 Sep 2025 08:56:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757494619; cv=none; b=J0wUxPCBzIayP9wmaVfza4BqEfJCceiO9BeNN2SdvwEdrsPcmfZ4xc7bz6aD4/npyJm3jeonUR00lnDpQ2gfJV3VsagQi3RQ1nYz/Rv2RgzmmtjxW6wLn4jrq159652/LqE/bUe3vjTi5TYU8nsPNl0sd+E3qrdf7QZSwNd53wY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757494619; c=relaxed/simple;
	bh=1kvJyLRA3qorOtEizalZAbRK41ujlJ31rNQpgw/YD5c=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=aZs4/tJxcociOXhQxjlwmzmLiz/LAKQMbFr2TrziGUek3D1a3waNybMRq8xpvR1ITWHUf0rkGsQCR227vsV4ao+74ofY/AdsJK8UTM5mROz8ieg2Nxl65/BCpVwdwUd+IT+9G2lmodEZI0alhtXCaUJNvKkNOSlOn4x5+9tb08o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tbIQzedN; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tbIQzedN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93DBAC4CEF5;
	Wed, 10 Sep 2025 08:56:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757494619;
	bh=1kvJyLRA3qorOtEizalZAbRK41ujlJ31rNQpgw/YD5c=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=tbIQzedNhO/k//lwI6v4+36HJJIBwpYS1Wd6lLIIuqj2s/wkznvcAF7sduKvWkPJ2
	 2bGq5oL0hpODMChkjAH90aQTYH36QQwyOteRLA96hEOyXrI2lop6CLFACdudZBRe4v
	 W/Y5spocNKRGu0pPZL2Z9S3Q7qQaxJrxidv3BNAG8KdxqH0VqXcER3e/FdBtFiwTjt
	 s8sJ3gv/0DIY9yfWhbvV9Oiv8pWXQwuuicaDBVdrHCj1s+dtjLqMv/3abkG52vrer+
	 6SEziOrFHEOIvCDlZZoI1Od1LrX1JMYTrsRdMBFlvt+/8zeZqQty7RLTmiahZYN5sk
	 BZIOaGQlqD7hg==
Message-ID: <ba475884-ee50-4f4c-8a54-2fd10a7c2611@kernel.org>
Date: Wed, 10 Sep 2025 10:56:58 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH mptcp-net v2 1/5] mptcp: propagate shutdown to subflows
 when possible
Content-Language: en-GB, fr-BE
To: Geliang Tang <geliang@kernel.org>, mptcp@lists.linux.dev
References: <20250905-sft-mptcp-disc-err-v2-0-dfb3b6b4a877@kernel.org>
 <20250905-sft-mptcp-disc-err-v2-1-dfb3b6b4a877@kernel.org>
 <9f2a05ac6034fb33f579302a0ede2ec13eb6c915.camel@kernel.org>
 <aa8f9007-71cb-4c82-b235-bd585da19922@kernel.org>
 <b76b31112598ee1e4774e1fd0cb68162c5633a3d.camel@kernel.org>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <b76b31112598ee1e4774e1fd0cb68162c5633a3d.camel@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Geliang,

On 10/09/2025 05:24, Geliang Tang wrote:
> Hi Matt,
> 
> On Sat, 2025-09-06 at 15:42 +0200, Matthieu Baerts wrote:
>> Hi Geliang,
>>
>> On 06/09/2025 02:45, Geliang Tang wrote:
>>> On Fri, 2025-09-05 at 20:18 +0200, Matthieu Baerts (NGI0) wrote:
>>>> When the MPTCP DATA FIN have been ACKed, there is no more MPTCP
>>>> related
>>>> metadata to exchange, and all subflows can be safely shutdown.
>>>>
>>>> Before this patch, the subflows were actually terminated at
>>>> 'close()'
>>>> time. That's certainly fine most of the time, but not when the
>>>> userspace
>>>> 'shutdown()' a connection, without close()ing it. When doing so,
>>>> the
>>>> subflows were staying in LAST_ACK state on one side -- and
>>>> consequently
>>>> in FIN_WAIT2 on the other side -- until the 'close()' of the
>>>> MPTCP
>>>> socket.
>>>>
>>>> Now, when the DATA FIN have been ACKed, all subflows are
>>>> shutdown. A
>>>> consequence of this is that the TCP 'FIN' flag can be set earlier
>>>> now,
>>>> but the end result is the same. This affects the packetdrill
>>>> tests
>>>> looking at the end of the MPTCP connections, but for a good
>>>> reason.
>>>>
>>>> Fixes: 3721b9b64676 ("mptcp: Track received DATA_FIN sequence
>>>> number
>>>> and add related helpers")
>>>> Fixes: 16a9a9da1723 ("mptcp: Add helper to process acks of
>>>> DATA_FIN")
>>>> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
>>>> ---
>>>>  net/mptcp/protocol.c | 16 ++++++++++++++++
>>>>  1 file changed, 16 insertions(+)
>>>>
>>>> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
>>>> index
>>>> 1c26acf6c4145896ecbb5c7f7004121c66a20649..9feb9f437c2bdfff392249e
>>>> 7ad0
>>>> 0edd09ba67ac3 100644
>>>> --- a/net/mptcp/protocol.c
>>>> +++ b/net/mptcp/protocol.c
>>>> @@ -372,6 +372,20 @@ static void mptcp_close_wake_up(struct sock
>>>> *sk)
>>>>  		sk_wake_async(sk, SOCK_WAKE_WAITD, POLL_IN);
>>>>  }
>>>>  
>>>> +static void mptcp_shutdown_subflows(struct mptcp_sock *msk)
>>>> +{
>>>> +	struct mptcp_subflow_context *subflow;
>>>> +
>>>> +	mptcp_for_each_subflow(msk, subflow) {
>>>> +		struct sock *ssk =
>>>> mptcp_subflow_tcp_sock(subflow);
>>>> +		bool slow;
>>>> +
>>>> +		slow = lock_sock_fast(ssk);
>>>> +		tcp_shutdown(ssk, SEND_SHUTDOWN);
>>>> +		unlock_sock_fast(ssk, slow);
>>>> +	}
>>>> +}
>>>> +
>>>>  /* called under the msk socket lock */
>>>>  static bool mptcp_pending_data_fin_ack(struct sock *sk)
>>>>  {
>>>> @@ -396,6 +410,7 @@ static void mptcp_check_data_fin_ack(struct
>>>> sock
>>>> *sk)
>>>>  			break;
>>>>  		case TCP_CLOSING:
>>>>  		case TCP_LAST_ACK:
>>>> +			mptcp_shutdown_subflows(msk);
>>>>  			mptcp_set_state(sk, TCP_CLOSE);
>>>>  			break;
>>>>  		}
>>>> @@ -564,6 +579,7 @@ static bool mptcp_check_data_fin(struct sock
>>>> *sk)
>>>>  			mptcp_set_state(sk, TCP_CLOSING);
>>>>  			break;
>>>>  		case TCP_FIN_WAIT2:
>>>> +			mptcp_shutdown_subflows(msk);
>>>
>>> I think we should not directly call mptcp_shutdown_subflows()
>>> within
>>> mptcp_check_data_fin() and mptcp_check_data_fin_ack(), but should
>>> instead call it after these functions return and the sk state is
>>> TCP_CLOSE. This ensures that the original purpose of these two
>>> functions remains unchanged.
>>
>> Thank you for the review. I'm not sure to understand what you mean
>> about
>> the "original purpose": they both set the appropriated actions when
>> DATA_FIN have been received. Here, I do want to shut the subflows
>> down
>> when the DATA_FIN ACK are received, so that's the good spot, no?
>>
>> Note that commit 3721b9b64676 ("mptcp: Track received DATA_FIN
>> sequence
>> number and add related helpers") already had a hint of what should
>> have
>> been done: see the "Close subflows now?" comment, later removed in
>> commit e16163b6e2b7 ("mptcp: refactor shutdown and close").
>>
>> Or maybe do you mean their original name "check_data_fin(_ack)" is
>> confusing? The "check" here is not just to check if the DATA_FIN
>> (ACK)
>> was set, but to check actions related to them.
> 
> I mean not to modify mptcp_check_data_fin and mptcp_check_data_fin_ack,
> but to check TCP_CLOSE in mptcp_worker(), something like:
> 
> @@ -2749,6 +2749,9 @@ static void mptcp_worker(struct work_struct
> *work)
>         mptcp_check_data_fin_ack(sk);
>         mptcp_check_data_fin(sk);
>  
> +       if (sk->sk_state == TCP_CLOSE)
> +               mptcp_shutdown_subflows(msk);
> +
>         if (test_and_clear_bit(MPTCP_WORK_CLOSE_SUBFLOW, &msk->flags))
>                 __mptcp_close_subflow(sk);

No, we should only do that when receiving the DATA_FIN ACK, when
transitioning from FIN_WAIT_2/LAST_ACK to CLOSE.

I do think these data_fin functions are the best place, in the
operations linked to the state machine, not here in the worker.

> Another option is to call mptcp_shutdown_subflows in
> mptcp_close_wake_up, which one do you think is better?

No, that's not linked to 'waking up the userspace'.

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

