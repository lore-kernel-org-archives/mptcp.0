Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1477C28E5F4
	for <mptcp@lists.linux.dev>; Tue, 15 Apr 2025 11:00:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744714815; cv=none; b=CW/Nj029j1XP1fzVPpzNjpfPC+it4k26ljXNoAYhWtphyArkUWuPTdkBXMkRsMcK9plKM+Hcvac4wvqT7BsdOSCpzBXgN1DLumWM/PwKzGL5CY1+mBuFlMei23k2Y6EAUfUYCYzkRLPFURIYSfCLMgNfuYiD3J4jgQsfqyEulDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744714815; c=relaxed/simple;
	bh=HQE7SXivX8PWqQ2e4eaCquKrZV4m3PyGRNiBnBTJOjw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hWteY5y/FqPzgxhBsoApY15Sg9PZyKi6sF35KEe3cibAyv6C+o676ga0ek/QofShRPBgEwPpWu4pxs6VGm5Y22vFnQRgPTxlZsFPaUitRUD0k0tCIe0LrZCX8boqgEdZQ32guxODR9BmTWkzsPdPz6DtmS6FN3lgC1oq5b9GAQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hLNPa7ig; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hLNPa7ig"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D2C4C4CEE7;
	Tue, 15 Apr 2025 11:00:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744714814;
	bh=HQE7SXivX8PWqQ2e4eaCquKrZV4m3PyGRNiBnBTJOjw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=hLNPa7ig+HBi6OahHmtQQzCVQz/0gqLqiN/ENYdxd7t8Woet/IQ+IC9wffkRvwkNY
	 nJ9SZtcdfUaFzQtzO8vLlkkIFYfyVXLM683O4D8RQNHj0UVRETshsV00MhQnkpr3HO
	 LQBZyBo6w7P4nq/wlov9RhAFSifNn97MBdn9fn6/bYzi8EOrPIMVUr8AYMjmbSpJ1E
	 V5HAH/df6zKLFK6DuNLifb4n1mPmFE2yCtXqLI9YM8/c7YBEv6MM/3xLyP9FI6Rfrw
	 RfFheFsKlDglOVwtipl3nqjjzy4XjpPMC2BI5JHzf18rmUAFzZ1OsuTpbcCUZMe7DP
	 yTzoq0YbqiMqg==
Message-ID: <100ce0ca-d6e3-4ea5-8227-909e671a1ead@kernel.org>
Date: Tue, 15 Apr 2025 13:00:10 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH mptcp-next v2 1/2] mptcp: pm: userspace: drop
 delete_local_addr helper
Content-Language: en-GB, fr-BE
To: Geliang Tang <geliang@kernel.org>, Mat Martineau <martineau@kernel.org>
Cc: mptcp@lists.linux.dev, Geliang Tang <tanggeliang@kylinos.cn>
References: <cover.1744257362.git.tanggeliang@kylinos.cn>
 <2b140a3cefd7d5766a79e8c55b73cf2d38c710d0.1744257362.git.tanggeliang@kylinos.cn>
 <ebdb4b2d-19fe-29ef-65df-d201b201b151@kernel.org>
 <0caab1005d589bbda1e4e9224757ccc258ab37d4.camel@kernel.org>
 <66f456226a68cc9e5458bb49eae348fadbe8649a.camel@kernel.org>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <66f456226a68cc9e5458bb49eae348fadbe8649a.camel@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Geliang,

On 15/04/2025 11:18, Geliang Tang wrote:
> On Tue, 2025-04-15 at 11:09 +0800, Geliang Tang wrote:
>> On Fri, 2025-04-11 at 17:26 -0700, Mat Martineau wrote:
>>> On Thu, 10 Apr 2025, Geliang Tang wrote:
>>>
>>>> From: Geliang Tang <tanggeliang@kylinos.cn>
>>>>
>>>> Address entries should not be removed from local_addr_list when a
>>>> subflow
>>>> is deleted by the userspace PM, should only be removed when
>>>> sending
>>>> a
>>>> REMOVE_ADDR.
>>>>
>>>> So mptcp_userspace_pm_delete_local_addr() helper shouldn't be
>>>> called in
>>>> mptcp_pm_nl_subflow_create_doit() and
>>>> mptcp_pm_nl_subflow_destroy_doit().
>>>>
>>>> Since this helper is open-coding in mptcp_pm_nl_remove_doit(), it
>>>> can be
>>>> dropped now.
>>>>
>>>> Address entries are removed from local_addr_list when sending a
>>>> REMOVE_ADDR
>>>> by the userspace PM, the local_addr_used counter of PM should
>>>> also
>>>> be
>>>> decremented accordingly.
>>>>
>>>
>>> Hi Geliang -
>>>
>>> Have you tried this patch with mptcpd? Does it affect any tests
>>> there?
>>
>> I haven't tested it. To be honest, I don't know how to run the test
>> items of mptcpd. Can you give me some guidance?

'make check' should execute all the tests. Do you mind trying this with
and without your modifications?

Please make sure relevant ones are not skipped because of missing
dependences or tools.

> I just tested it this way, and here are the test results:

(...)

> These results appear to be unchanged from before. And in fact these
> tests do not test userspace pm.

I don't remember what is being tested, but I guess some parts of the
userspace PM are tested somewhere, no?

Coveralls [1] seems to indicate it is tested, but I don't see the details.

[1] https://coveralls.io/github/multipath-tcp/mptcpd

> So it seems that this patch will not affect the tests of mptcpd.

Regarding your patch 2/2 of this series: did you have to modify the
selftests to make the tests passing again due to a changed behaviour, or
did you modify them to extend the behaviour.

It looks like the behaviour has changed, but it is unclear to me if it
is to fix something or add a new feature.

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

