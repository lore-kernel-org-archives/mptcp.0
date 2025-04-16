Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB9372356B6
	for <mptcp@lists.linux.dev>; Wed, 16 Apr 2025 09:42:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744796523; cv=none; b=thpDI6q7UVX/hUWgCqabLHArEZ4TY/NsD7gWo6ZTY/v7+tgz3fgdsuNeXf4eBi0a8jsEl66JCa7mPQjhQb18rj1W5MUwhXibjGT6DjbEU7PeHGD9B1/IPaTSxyq5ojtdFJdVntxQ4scoQNjfYBVrS231irImsEsXiH1K/kgMAbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744796523; c=relaxed/simple;
	bh=y+LiQpcpK4byPFDEeLB5tZVpRPkDXdJctJO4AWgzhbA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EG0zqanfkfB+bu9+sq3NKyaRx7yvanYgpZzZSwdCPBnKH5zP0SOq9QHGdXXRN4K4N9CHLTNuBdHuXTawzOmo7h4lkhfbygOPiGTg8XPdQ6loRC9v8CfrZ2MsIeHbudpmZmjstJNYslCIGRwBRI9dGEWnLVd8OUvtZwmkTR9AW9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S6hJtWT3; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S6hJtWT3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA2A1C4CEE2;
	Wed, 16 Apr 2025 09:42:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744796523;
	bh=y+LiQpcpK4byPFDEeLB5tZVpRPkDXdJctJO4AWgzhbA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=S6hJtWT3WNGOCg9Dm8mE2qfqjqkh5OJ2rJIk9EXQAHnE2r19vZwpaXAyGJe9aM7uU
	 XzTVPJpGUS+bloyCUMJR1QLU2S8QCE0H1uPn0ZdpMQqJYKsvMgm97dMGHT7xHTty5S
	 c6jIgMeLjPDLIoNQ+CywKrF7Nu9ZqKBZZCigoa3bzZ1MWq0/E3wxtvNZY5KRUyE0hy
	 UI4zcUglifNe/DWbew0O0TnQhLPbEHO51zl4WCZX0GTQPrWljD2SvsY91QJkE+Wunz
	 sdZegxBCdGMEXQIwDUcTSWlRMWVvtRv54fjrhKp3hGuCdNFxx9+DQBaZZK7zkRhjGU
	 w4ghO5JAjFyag==
Message-ID: <4930938c-7ed2-48bb-aa93-0f94c34c1084@kernel.org>
Date: Wed, 16 Apr 2025 11:42:00 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH mptcp-next v6 0/5] BPF path manager, part 6
Content-Language: en-GB, fr-BE
To: Geliang Tang <geliang@kernel.org>
Cc: MPTCP Linux <mptcp@lists.linux.dev>
References: <cover.1743133948.git.tanggeliang@kylinos.cn>
 <c81dfcab-0eee-45e2-8777-1b0c41e7f696@kernel.org>
 <ce0591ec28905dd087a74ea5abd762fb684fb17e.camel@kernel.org>
 <a51db524559756f66f544cfad08f2448b45d5080.camel@kernel.org>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <a51db524559756f66f544cfad08f2448b45d5080.camel@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Geliang,

On 16/04/2025 09:29, Geliang Tang wrote:
> Hi Matt,
> 
> On Tue, 2025-04-15 at 11:16 +0800, Geliang Tang wrote:
>> Hi Matt,
>>
>> On Tue, 2025-04-08 at 20:13 +0200, Matthieu Baerts wrote:
>>> Hi Geliang,
>>>
>>> On 28/03/2025 05:01, Geliang Tang wrote:
>>>> From: Geliang Tang <tanggeliang@kylinos.cn>
>>>>
>>>> v6:
>>>>  - squash accept_new_subflow patches into one.
>>>>  - change "pm->subflows == subflows_max - 1" to
>>>> 	pm->subflows + 1 == subflows_max.
>>>>  - not to call accept_new_subflow under the PM lock.
>>>>  - add mptcp_pm_accept_subflow helpers.
>>>>  - drop READ_ONCE in mptcp_pm_worker.
>>>>  - clear all the pm status flags once in mptcp_pm_worker.
>>>
>>> Thank you for the new version.
>>>
>>> FYI, I'm still thinking about how to handle PM lock should be
>>> handled. I
>>> will come back to you later. I might suggest a new version with
>>> some
>>> modifications if that's OK, that might be easier.
>>
>> Thanks for helping me think about this part around the PM lock. Look
>> forward to your feedback.
> 
> If you have time to take over this part around the PM lock, that would
> be even better and I would be very grateful.

Sure, no problem, I will have a look. But sadly, for the moment, it is
hard for me to dedicate a long time on some tasks. It might take a bit
of time for me to look at it, but I think that's fine, we are not in a rush.

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

