Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB62739FD1
	for <mptcp@lists.linux.dev>; Thu, 29 Feb 2024 12:28:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709209721; cv=none; b=MbNNAJ2jBdLxr7WJOBepZ2HRQymGNt1u96IJurvQSnE8swtspiOPCfRL//zxsvZ75XXQDLSjjmuCtf4tJPfKbCPy/B7+Lq6y9CDngomNugTQCc7HuUo8O3sAy3oey0r9v6bS2GDjHqtzuF421cQ2cuybjTFlZAwea/jrE//y85g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709209721; c=relaxed/simple;
	bh=c9xTy4Y4iu6U4EPX1vxeaO/SRjrxoVB5w+S6B6hVU2s=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=KSxlzydX60cSG+ngnMCGCKEmHitLWLNtSeWv3wM8GQhfMfXIxW5ATyCQVseoVLfDM42U7VP0A77fUMSF9fdt9B09Uhonu4usOhm4gCMGrT3vMUCH0+e9xy8SNjFIaonjeTc1zMGjM+2VMykiqZLJqc/YiR4ryuQKpp88wNmL734=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EFdh3qu1; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EFdh3qu1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B47EEC433C7;
	Thu, 29 Feb 2024 12:28:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709209720;
	bh=c9xTy4Y4iu6U4EPX1vxeaO/SRjrxoVB5w+S6B6hVU2s=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
	b=EFdh3qu1qqneCJozmXnNVOXiSJVqBe7yEXH98RW7XZT2g/nskNLqDHoaovhVDd1V4
	 Lv4OYU4KruFbW+6Q67y6FqEhChG4KcyKKJrwUHR2sXm34rMbDvruDdcBxoNBQERYNM
	 oybTqKQWCak5Gdfi1ysaEKUsnDK4fnq9WAM1C9X5UyjVZXfzjAfdcAzj0+8f6ZkVi2
	 u4u2XKtjlEvEt31QPLLrA874LOXBBvAfE6/smEzEltTH+dIFMv11QuepshkqZ1NJgW
	 KuQxs1MEnCBTeCrM/ByuBKMTyK2HDUwG8VqgHir6eYdpeJbhpVEfEmcItP8bhQ6AOf
	 C3XMD44gktCFw==
Message-ID: <4930a445-3a30-4272-aa26-4dbff29b0c15@kernel.org>
Date: Thu, 29 Feb 2024 13:28:38 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH mptcp-next v7 6/8] selftests: mptcp: add test counter
 helpers
Content-Language: en-GB, fr-BE
From: Matthieu Baerts <matttbe@kernel.org>
To: Geliang Tang <geliang@kernel.org>, mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
References: <cover.1709200070.git.tanggeliang@kylinos.cn>
 <9a31a17605edb4546467a172d8619eff3f15a002.1709200070.git.tanggeliang@kylinos.cn>
 <fea0084f-665b-4ea2-96cd-f9c025c02a28@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <fea0084f-665b-4ea2-96cd-f9c025c02a28@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 29/02/2024 12:58, Matthieu Baerts wrote:
> Hi Geliang,
> 
> On 29/02/2024 10:51, Geliang Tang wrote:
>> From: Geliang Tang <tanggeliang@kylinos.cn>
>>
>> This patch adds two vars in mptcp_lib.sh, MPTCP_LIB_TEST_COUNTER for
>> the test counter and MPTCP_LIB_TEST_FORMAT for the test print format.
>> Also add two helpers, mptcp_lib_inc_test_counter(), increase the test
>> counter, and mptcp_lib_pr_title_counter(), print the test title with
>> counter. They are used in mptcp_join.sh first.
> 
> Please add the reason, something like: Each MPTCP selftest is having
> subtests, and it helps to give them a number to quickly identify them.
> This can be managed by mptcp_lib.sh, reusing what has been done here.
> The following commit will use these new helpers in the other tests.
> 
>> Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
>> ---

(...)

>> +mptcp_lib_pr_title_counter() {
>> +	: "${MPTCP_LIB_TEST_COUNTER:?}"
>> +	: "${MPTCP_LIB_TEST_FORMAT:="%02u %-50s"}"
>> +
>> +	printf "${MPTCP_LIB_TEST_FORMAT}" "${MPTCP_LIB_TEST_COUNTER}" "${*}"
> 
> I didn't check: can you not print the title and increment the counter
> (via mptcp_lib_inc_test_counter) from here? I think that would be a good
> practice to do that instead of having to deal with the counter in
> different places.
> 
> We would only call "mptcp_lib_inc_test_counter()" from other scripts
> when a test is skipped.

OK, I just saw you added mptcp_lib_print_title() in the next patch. Why
did you not use it for mptcp_join.sh?

Can you not call "mptcp_lib_inc_test_counter" in the "if skip_test" from
mptcp_join.sh and use mptcp_lib_print_title()? (if you do that, I guess
we don't need mptcp_lib_pr_title_counter(), no?)

> 
>> +}
> 
> Cheers,
> Matt

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.
