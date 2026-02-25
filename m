Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 483C03009FA
	for <mptcp@lists.linux.dev>; Wed, 25 Feb 2026 18:46:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772045214; cv=none; b=bK3FomD8OCNzsf6oi6GXJvzjnW4em7mD4tWeUHiikqMleg0TrAewpzo4eHt5gPRWHDNNaNhRpocxXF5iFtKYXFLKOFVByrmuqcAEK3tZ5BbZ4GS3XKyMTyriZMBTXx6eHM5dq5Gi3miz45Ztxdw1qc9P8Y3n3T35z1QNF8ORwgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772045214; c=relaxed/simple;
	bh=Dhcoz1sKmf9wjSV7JzfV281EXuzgaicvkQyQ9XMRKQg=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=ZSTlPBjkr9uX+8hFRy/eTR1Yif790YFom3V9YpWXj3cBnh+oKpOd+gOQCHPUB1COKMTlRLveXHuplaODsxyUCuXjHEeoHDf9tmo4D41HiXk2A6EoppOXI1H9n+W08HMMqFb8pEcenhdPckmGJtxRWL/cYHbt06JH9nqveDe569I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JrNSKmWx; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JrNSKmWx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB83CC19421;
	Wed, 25 Feb 2026 18:46:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772045213;
	bh=Dhcoz1sKmf9wjSV7JzfV281EXuzgaicvkQyQ9XMRKQg=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=JrNSKmWx44I3LwwUOE9T1nJVCgdf8tFwno6OvRJNMQBAvqDsHmyrOGKcDMac3+O/K
	 eoJrb/CG66XUKivWIWQpHAbCKRGT/jG5agn1EebdbsSZjXH0ZDPp+yLmG4UDZeub59
	 Q4XJj7zGgLQLWw5jDOwufesnlkKMj+vHwzIl/yiBEM6XY9aunwLPWOKQ9fgUbVMF0Z
	 xqZqpz2HgaFtJ0hfJxHvnrjH6uoCPJGdI1emDsgcHAisnD39qkRyU724rfTilA8HHC
	 je0KRC61E7dgNqhH4QYfxQsDss+LBubjLRwlo9wp5DD8RfnrigXtpYEpJO3C/VnHWU
	 LMObC0dCQPoAA==
Date: Wed, 25 Feb 2026 10:46:53 -0800 (PST)
From: Mat Martineau <martineau@kernel.org>
To: Matthieu Baerts <matttbe@kernel.org>
cc: MPTCP Upstream <mptcp@lists.linux.dev>
Subject: Re: [PATCH mptcp-net] mptcp: pm: in-kernel: always mark signal+subflow
 endp as used
In-Reply-To: <847f7e20-3c94-45a1-8c42-392701be8464@kernel.org>
Message-ID: <0316ea8e-38e0-6cc5-6d02-4defed40772b@kernel.org>
References: <20260218-mptcp-issue-613-v1-1-f8e9adb12010@kernel.org> <bffe9f3d-298b-1142-7cbe-e8bb768e9b38@kernel.org> <847f7e20-3c94-45a1-8c42-392701be8464@kernel.org>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="0-2059724384-1772045213=:31605"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--0-2059724384-1772045213=:31605
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8BIT

On Wed, 25 Feb 2026, Matthieu Baerts wrote:

> Hi Mat,
>
> Thank you for the review!
>
> On 25/02/2026 18:50, Mat Martineau wrote:
>> On Wed, 18 Feb 2026, Matthieu Baerts (NGI0) wrote:
>>
>>> Syzkaller managed to find a combination of actions that was generating
>>> this warning:
>
> (...)
>
>>> Note that signal_and_subflow variable is reset to false when the limits
>>> and the c-flag case allows subflows creation. Also, local_addr_used is
>>> only incremented for non ID0 subflows.
>
> (...)
>
>>> diff --git a/net/mptcp/pm_kernel.c b/net/mptcp/pm_kernel.c
>>> index 87e37c729f81..2710abcd4065 100644
>>> --- a/net/mptcp/pm_kernel.c
>>> +++ b/net/mptcp/pm_kernel.c
>>> @@ -418,6 +418,15 @@ static void
>>> mptcp_pm_create_subflow_or_signal_addr(struct mptcp_sock *msk)
>>>     }
>>>
>>> exit:
>>> +    /* If an endpoint has both the signal and subflow flags, but it is not
>>> +     * possible to create subflows because of the limits or the c-flag case,
>>> +     * then still mark the endp as used, which is the case. This avoids
>>> +     * issues later when removing the endpoint and calling
>>> +     * __mark_subflow_endp_available(), which expects the increment
>>> here.
>>> +     */
>>> +    if (signal_and_subflow && local.addr.id != msk->mpc_endpoint_id)
>>> +        msk->pm.local_addr_used++;
>>> +
>>
>> Looking at the code above, signal_and_subflow == TRUE is an indicator
>> that the body of the while loop never executed. Please add a comment
>> above this code in the while loop:
>>
>>         if (signal_and_subflow)
>>             signal_and_subflow = false;
>>
>> to point out that the code at the "exit:" label is assuming that
>> signal_and_subflow is always false if the loop body runs.
>
> That's a good idea, but I'm hesitating to add that: adding such comment
> might cause more conflicts. Plus, the use of this variable is quite
> limited I think: init to false, set only in one case, and reset after
> use. Do you think this comment is helpful there? Or should I add
> something else here at the end of the function?
>

True, it does run the risk of the comment and the code below getting out 
of sync and it's pointless to say "if you change the value of the variable 
it affects other code using that variable" (of course it does!).

I agree with you, and suggest updating the comment in the patch similar to 
"If an endpoint has both the signal and subflow flags and the 'while' loop 
body above never executed, ..."

Thanks,
Mat
--0-2059724384-1772045213=:31605--
