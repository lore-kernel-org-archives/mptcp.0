Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C720A1C7662
	for <mptcp@lists.linux.dev>; Tue,  3 Sep 2024 08:51:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725353516; cv=none; b=koiMnrtQDICwRILZJYzbheOiXbtylKozH9IcCB1SXLxXZJKtJhJ79dAQx7Sp3PRn39zQycCiaQT2D9LJPw0o7XGPN2mwlZ7howpw0hsKixNTHSFl5B5AFUtnyR0BGysfiK19pYUzE0+xre2FqLTVsiSvnNeAzKyeym13dlR7bTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725353516; c=relaxed/simple;
	bh=e/K4n76Mlr1klu75vjGByC0BhuAXb58Rcjo2ibV1TTQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qvLeBUOH4h9Tl4M35Uq9L1urTnBG1jNzpfrw8DUWCxh+X4Pumhb/02Q83GBMpaRTdtVmZuttswDCBin5lLXu0B0YGWnc/TbySIUvgPt5xzAh/extjnuLyDuppN4Cx9LWXHvmPzEQsVdh5zIm2vX7m5OkjDpoZloxBnOiXV36tlI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y6oen4EN; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y6oen4EN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9959FC4CEC4;
	Tue,  3 Sep 2024 08:51:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725353516;
	bh=e/K4n76Mlr1klu75vjGByC0BhuAXb58Rcjo2ibV1TTQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Y6oen4ENSgI+eJv8bWdlbB8mz7JHWyoQU7dSdHusjoD2+eSImGAF1kwqJ09M19f3u
	 9I2MTc7iCCD450aiMpJVmfMYrI3UMeq6MOqiSq0vkGyZUeAxjRAEjGEHYAPSG33+wq
	 /ZmwJfSU78G2PE6t1yjXZyDoBrU4FKBApC5rK84WtxceuPhC6BqJkeCCCvoTPPOGVI
	 1O2Cyu1B9mDLpUnkWwikgEbNtkNkgAoqgesw+sZQDK9DCES01t9/sx+H6FUtduOBZ6
	 HA4OJfd7zM+YYX19x0oQXrEr/awx82OgFFxHC/QHM1HdRzmcV9k1wwspizPLvP6gMk
	 djpQ7po4n6+QA==
Message-ID: <23283e65-0447-499f-a1ba-5c3ffdd4d344@kernel.org>
Date: Tue, 3 Sep 2024 10:51:53 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH mptcp-next v6 2/4] selftests/bpf: Add getsockopt to
 inspect mptcp subflow
Content-Language: en-GB
To: Geliang Tang <geliang@kernel.org>, mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
References: <cover.1725000687.git.tanggeliang@kylinos.cn>
 <0ce049060df256e7376516e4d94af71264a69da0.1725000687.git.tanggeliang@kylinos.cn>
 <6d54b731-b8a5-4d2c-8569-82ae84fb4b75@kernel.org>
 <80605ef1b8687bbf4925577014781ef128ea5112.camel@kernel.org>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <80605ef1b8687bbf4925577014781ef128ea5112.camel@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Geliang,

On 03/09/2024 10:00, Geliang Tang wrote:
> On Mon, 2024-09-02 at 18:47 +0200, Matthieu Baerts wrote:
>> On 30/08/2024 08:55, Geliang Tang wrote:

(...)

>> It looks like you didn't reply to my question from v5: if there is an
>> issue with the verifications that are done in BPF, are these
>> bpf_printk
>> printed somewhere? e.g. if you force it to fail here, do you see the
>> new
>> message in the logs of the BPF selftests?
> 
> Yes, bpf_printk works. These logs are found in
> /sys/kernel/debug/tracing/trace if force it to fail here:
> 
>       test_progs-75858   [003] ...11  2338.270065: bpf_trace_printk:
> MPTCP Subflow: expected 1 extra subflows, got 1

Good, but is it visible when launching the test or did you have to do
something else to see them?

Said differently: if such issue happens on the CI side, will we see the
logs? Or do we need to modify the CI to get them in case of error?

>> If the test is unstable, we need to have a way understand where is
>> the
>> issue exactly, not somewhere where we set 'ctx->retval = -1'. The
>> best
>> would be to have a comprehensive message like what I'm suggesting
>> here.
>> If not, we should at least have a unique retval or errno somehow.
>>
>>> + ctx->retval = -1;
>>> + }
>>> +
>>> + mptcp_for_each_subflow(msk, subflow) {
>>> + struct sock *ssk;
>>> +
>>> + ssk = mptcp_subflow_tcp_sock(bpf_core_cast(subflow,
>>> +    struct mptcp_subflow_context));
>>> +
>>> + if (ssk->sk_mark != ++i)
>>> + ctx->retval = -1;
>>
>> Please add an error message here, e.g.
>>
>>   MPTCP Subflow: expected %d mark, got %d
>>
>>> + }
>>> +
>>> + return 1;
>>
>> (no need to change if you prefer, but your helper is always returning
>> -1, maybe it doesn't need to return anything?)
> 
> Set the return value to ctx->retval in v7:
> 
> ctx->retval = _check_getsockopt_subflow_mark()

Can 'ctx->retval' be != 0 before _getsockopt_subflow()? Not to override
an error if there was already one before.

(...)

>>> + return 1;
>>> + }
>>> +
>>> + msk = bpf_core_cast(sk, struct mptcp_sock);
>>
>> Just to be sure: this cast can never fail, and no need to check if
>> 'msk'
>> is NULL, right?
> 
> Yes, no need to check if msk is NULL.

Good, thank you for your reply!

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

