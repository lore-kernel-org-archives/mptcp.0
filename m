Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E26A26F504
	for <mptcp@lists.linux.dev>; Thu,  8 Feb 2024 09:27:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707384458; cv=none; b=aZwhoaXdIizGc47wDpw5xqw6m9ypetEFLe7egJndW+wPO9TU0YTDjlmOSzlhenkZNE9CZXhRWfHajIUBebeAONuBtaNfxJP53QrqLEr3uMDU65n2zlMCbBQoimhca/abV8s9Jvu2D0K1SWH6fFOoEa6iZayQOwU+i6XZdFVZ2Kg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707384458; c=relaxed/simple;
	bh=GGLD3JoUhc4HtMkmft1ikRFdjbpcS16R4kMVOvtYKDA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sbAGE7ky5CxlNvlJRQNPAzHisTFuovTBVrd0LGz6C3XDfkjtythwkSfAk33kTZSPc31GEl+Q0Ga4HbxY78RKO4N+JruFZgreO1BxkDRqRynUKLE2Ow4j11WoFwVJiHAXzlF61mnXUqPSMgVQTCBg2pJO7BjL8slnPx8mlHleZVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bGa1UFoN; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bGa1UFoN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30C9BC43390;
	Thu,  8 Feb 2024 09:27:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707384457;
	bh=GGLD3JoUhc4HtMkmft1ikRFdjbpcS16R4kMVOvtYKDA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=bGa1UFoNFftV/dHBBQQZHc+UGu+/OdrM6sbH43fNx+F6aiOh4I5Pk6PJOOtZaAGtZ
	 UPRWEVpYQv9ezC6SbmLbIqeFsbVziX7GYn0UEX1zj9I9Cboxggam1ejubxSAa677ah
	 Csg91w4vriBbSDClMXuf6WRGuyrKFbiW3awpkdYMXSL+LVluTJe0ZHRiBxrjnFRk40
	 01G24ieOCEY0P+LCKcG67+OGW7/dapa/qPjUsZTrGUVRL8EhYfffPgFUgOxB8sP42h
	 zd2rA+gk3v/nyrMCfDLHegGS03zo2EmbrEhk7m9uLkTWy/dgKRY3z2aDbSh9iPm1D5
	 qhCRu9ZpXMdag==
Message-ID: <c0bf51b0-9aea-4668-b156-57ab825c867e@kernel.org>
Date: Thu, 8 Feb 2024 10:27:27 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH mptcp-next v10 10/23] mptcp: check userspace pm subflow
 flag
Content-Language: en-GB, fr-BE
To: Geliang Tang <geliang.tang@linux.dev>,
 Mat Martineau <martineau@kernel.org>
Cc: mptcp@lists.linux.dev, Geliang Tang <tanggeliang@kylinos.cn>,
 Geliang Tang <geliang@kernel.org>
References: <cover.1705558030.git.tanggeliang@kylinos.cn>
 <8df3db253cf4e880813e2b499b12887904474736.1705558030.git.tanggeliang@kylinos.cn>
 <38c3cf2e-ba53-b30f-cf2c-e39d793851f2@kernel.org>
 <8bbb6d165777dd32ec9cb3c9b679a7bf543b17f8.camel@linux.dev>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <8bbb6d165777dd32ec9cb3c9b679a7bf543b17f8.camel@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Geliang,

On 06/02/2024 03:57, Geliang Tang wrote:
> Hi Mat & Matt,
> 
> On Tue, 2024-01-30 at 18:28 -0800, Mat Martineau wrote:
>> On Thu, 18 Jan 2024, Geliang Tang wrote:
>>
>>> From: Geliang Tang <tanggeliang@kylinos.cn>
>>>
>>> Just like MPTCP_PM_ADDR_FLAG_SIGNAL flag is checked in userspace PM
>>> announce mptcp_pm_nl_announce_doit(), MPTCP_PM_ADDR_FLAG_SUBFLOW
>>> flag
>>> should be checked in mptcp_pm_nl_subflow_create_doit() too.
>>>
>>> If MPTCP_PM_ADDR_FLAG_SUBFLOW flag is not set, there's no flags
>>> field
>>> in the output of dump_addr. This looks a bit strange:
>>>
>>> 	id 10 flags  10.0.3.2
>>>
>>> This patch uses mptcp_pm_parse_entry() instead of
>>> mptcp_pm_parse_addr()
>>> to get the flags of the entry. Add MPTCP_PM_ADDR_FLAG_SUBFLOW flag
>>> check
>>> in mptcp_pm_nl_subflow_create_doit().
>>>
>>
>> Hi Geliang -
>>
>> Have you tested this change with mptcpd?
> 
> What do you think to test 'mptcpd' in our CI too? If you agree, I'll
> try to do this, and add a new ticket about it in Github.

Thank you for the idea.

I don't think we should validate mptcpd when modifying the kernel. We
should not break the userspace API.

Maybe better to add this test on mptcpd side? The CI could download the
export branch, run the same
"multipath-tcp/mptcp-upstream-virtme-docker@latest" but with different
instruction in .virtme-exec-run file. Such test could run once a week.

WDYT?

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.
