Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E89456BB58
	for <mptcp@lists.linux.dev>; Thu,  8 Feb 2024 09:37:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707385032; cv=none; b=Jst8UPFlGB9dSNhUk7eD4h7WcxpUFxJctPI2pQFgkV+RHbcXAyYYBL+L+LCD55qX2T+o3/JCCKXPuhIha/8LT56ABFD97U/qgeFNuR/RykIqbaV+zWJxadw0nDip6pF0HC9opXXAvEUniXEt7wGAFrnYnjWZF35fSvoev4gW2MY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707385032; c=relaxed/simple;
	bh=oibND+3wcTGItdSAI5eSlNexx3Fv9/AnKdLGZIKlFss=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UGPRuhL5Adw70tL7e9kVVRAjQCGZzZPgwSuS62kpQJ5mOG71HRKJvPvqB00JyClZqKWnrHsIgaHLdv9hSUIAamH386bBS22zY8fK954FI1w+8UZRN/cR6GHj7x6gbdxHWlWQuQtvdCQRAJ1e7QfzjtwMs5cYCiymUathRQrNj2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xvj5yjYI; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xvj5yjYI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B782CC433F1;
	Thu,  8 Feb 2024 09:37:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707385031;
	bh=oibND+3wcTGItdSAI5eSlNexx3Fv9/AnKdLGZIKlFss=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Xvj5yjYILfNyR0S+LvXwyEg481Qw8Z0iOpLqVj6JrQTzq9JupplFwGpgQae5zuyhz
	 vz16/hVUJLnsvfqZyoPDZ8Hnnw2C6louMrqFWlpXS6cfRGEcDWUdO37CIlkRBqmDmv
	 D8JsYINUnLVMtnW9vrHNvAgjzK2B+JRInk+njoYnM7BysBB8E47ARhhUHLZ1eWLxgs
	 M9XigCFOCNpAdamce+MRkX2zK5gNggijy1OORH4f9AFndnVu0gn6vmKGC/+7bhhkQF
	 ZvRAZAmwwzPvYADfFNc96eC7KsjxuuoArFvA5lWyW4S+xYGDk9RYDL6iioWoETRaNJ
	 xUubN8zwVY6DA==
Message-ID: <edb98f15-f993-438d-a5be-69d4219da9b2@kernel.org>
Date: Thu, 8 Feb 2024 10:37:09 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH mptcp-net 2/4] mptcp: add needs_id for netlink appending
 addr
Content-Language: en-GB, fr-BE
To: Geliang Tang <geliangtang@gmail.com>, Geliang Tang <geliang@kernel.org>
Cc: mptcp@lists.linux.dev, Geliang Tang <tanggeliang@kylinos.cn>
References: <cover.1706759413.git.tanggeliang@kylinos.cn>
 <1d1970ac75aa9b924f1da17c3c89dcba96e5bb46.1706759413.git.tanggeliang@kylinos.cn>
 <CA+WQbwue9GJFK+=KQk6nbr_mv9oyDjC+g0ed7awLzWKVxobXRQ@mail.gmail.com>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <CA+WQbwue9GJFK+=KQk6nbr_mv9oyDjC+g0ed7awLzWKVxobXRQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Geliang, Mat,

On 01/02/2024 06:35, Geliang Tang wrote:
>>
>> From: Geliang Tang <tanggeliang@kylinos.cn>
>>
>> Just the same as userspace PM, a new parameter needs_id is added for
>> in-kernel PM mptcp_pm_nl_append_new_local_addr() too.
>>
>> Add a new helper mptcp_pm_has_addr_attr_id() to check whether an address
>> ID is set from PM or not. It will be used in the next two commits.
>>
>> In mptcp_pm_nl_get_local_id(), needs_id is always true, but in
>> mptcp_pm_nl_add_addr_doit(), pass mptcp_pm_has_addr_attr_id() to
>> needs_it.
>>
>> Fixes: fd5a4c04e18 ("mptcp: add the address ID assignment bitmap")
> 
>  Sorry, should be efd5a4c04e18 here.

Thank you for these patches, and the review!

This patch and the parent one are now in our tree (fixes for -net) with
the fix for the sha, and also without "It will be used in the next two
commits." from above.

New patches for t/upstream-net and t/upstream:
- 1505f3076aa3: mptcp: add needs_id for userspace appending addr
- 073a9771f40a: mptcp: add needs_id for netlink appending addr
- Results: d93302b7258d..8f954145aaee (export-net)
- Results: c2469b38e369..8a133f7f21a3 (export)

Tests are now in progress:

https://cirrus-ci.com/github/multipath-tcp/mptcp_net-next/export-net/20240208T093459
https://cirrus-ci.com/github/multipath-tcp/mptcp_net-next/export/20240208T093459

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.
