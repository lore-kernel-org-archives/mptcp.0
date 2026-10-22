Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792664382;
	b=mQP64lcsbb9uxWAaF1sWmfBszhysgwNVXB+t8MS9jNua8vxsqKKhWBsJ7gVowqm/W5e1
	 IhXGjXcaZGk4psgZWp6FGj3zPI51hNC4MtWMD2Y9vtHCCirk1UKOiejIdzzkn4/EH7Nzs
	 cgP+57kpLwXyQXextOxqCwGwb2BxR0IiHUgJmQBQJSO0Lvui9l9jHMIVbVuJVreaRBMRg
	 ltSFY2ooWvBioyFyFLjrk2BX4FA45JEFd+knPGEgwGNLIFoMs3jvxNKLHouRjVybfU9ZU
	 95lxXpM7O0altUXQDNRULj3HHPtcc0mUfjYEokC0VZKhmr0K0irq2jyFwC5JJm9TPZw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792664382;
	h=Received:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:Content-Language:To:References:From:Autocrypt:Organization:
	 In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=1D3+/otixqO6pjwI33PcoWvwPnFPmdlbMKb4y+KtnWs=;
	b=oDfZdA58JG5TV0yQIzslM0AVFYykahB0n/NCqssJLj8vAph5lL8TaT8E8hkIxjyMMkzz
	 hPfrcNZPqdUEBSR9H6JYpxu7KHnRba7FZMyARabn7jDXOpVMad9kPWnZSOLgyVSt8/8uI
	 WAx8391xWkwjLo7+XmT4p7HbZAYKdOvY2aDQGFZDlOVinkpbHRhkblA8KFhJhKlLIkN33
	 S43M5o1SMqDlp99E1MawWKYkU/skwMRyBABudUxUdf+roVMduAxpZY/G1HhHAvPuLE21o
	 HxADwxiQ0hkymvmpg/LSGkgDz/LK4Tt9wSl5OKjlZoqiIJUDScb1+H9HduEbSvLRg7w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cQN92BEb;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B25A5606A319
	for <mptcp@lists.linux.dev>; Thu, 22 Oct 2026 10:19:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cQN92BEb
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43CCE1F000C1
	for <mptcp@lists.linux.dev>; Thu, 22 Oct 2026 10:19:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792664381;
	bh=1D3+/otixqO6pjwI33PcoWvwPnFPmdlbMKb4y+KtnWs=;
	h=Date:Subject:To:References:From:In-Reply-To;
	b=cQN92BEb41kSn1ATGdRWQdt0QtmyttcOUZ77Al4EZ7XCtVMoZIwiAAC9NxYbVysaR
	 hCPHBGiM1uceitjFq+Xq1VcsIAMjkjcZl/5XFkBR2rK0fF6vx/83zYUSPS54gzjkZM
	 mbVaK3x8ee8b4AtZpSzp7lcQ972q/nOg36/LpUidNx+zY8R1PnqEFt/SdEWFfFLEvb
	 NDmml9Nt8yptLY/mCeXd9Z0jIv7j2Ruigrr+iEkQ0fNG7jzeGciiirwPJTLZrhkHYN
	 TEcQJqhBOhtWlIuMFrK/RvBqqNgAni7oZtf9y8pJ6lMLID/qNQuR2f99nmv+vUAiw1
	 P2gXPms7bt0QQ==
Message-ID: <56679372-0ae6-43bf-b0fa-a6b853a1b68c@kernel.org>
Date: Thu, 22 Oct 2026 12:19:39 +0200
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Post: <mailto:mptcp@lists.linux.dev>
List-Help: <mailto:mptcp+help@lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
List-Owner: <mailto:mptcp+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH mptcp-next v7 3/6] mptcp: pm: in-kernel: add the
 subflow-retries limit
Content-Language: fr
To: mptcp@lists.linux.dev
References: <20261020031711.1896660-1-anilkaushikwireless@gmail.com>
 <20261020031711.1896660-4-anilkaushikwireless@gmail.com>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <20261020031711.1896660-4-anilkaushikwireless@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 20/10/2026 05:17, Anil Kaushik wrote:
> A new limit for the in-kernel PM, set and read with the other limits:
> the number of SYN retries of a subflow re-created after an error, like
> the TCP_SYNCNT socket option. 15 by default, about 20 minutes, and 0
> to not re-create it. The netlink policy checks the maximum value,
> MAX_TCP_SYNCNT.
> 
> It is also exposed in struct mptcp_info, in place of the reserved field.
> 
> The next patch uses it.
> 
> Assisted-by: LLM
> Signed-off-by: Anil Kaushik <anilkaushikwireless@gmail.com>
> ---
> 
> Notes:
>     v6:
>      - the netlink policy checks the maximum, no more parse_limit() change
>        (netdev Sashiko)
>      - the limit works like TCP_SYNCNT, say so (netdev Sashiko)

That's a good idea to use netlink policy to check the maximum. Do you
mind adding a patch between the current 1 and 2 to do the same with the
other 2 limits to uniform everything, please?

Either that, or continuing to use parse_limit(), but better not to have
a mix of the two.

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

