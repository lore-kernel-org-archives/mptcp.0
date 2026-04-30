Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70EA33AE71B
	for <mptcp@lists.linux.dev>; Thu, 30 Apr 2026 20:53:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777582438; cv=none; b=rZvdISVYr5+BNncmTPUDpfnOcH4qF3VWvnIWs5zX/BHn5bFHOP0k7bQfq/mMH++fR+pXkdlzcdS7W1HQDK2KpHtqYVPFceWUJ6qTDLff4sKoqEFcDQWTGUA5dMJPyBx4T+xaVKOjQ/4cGy6YEZjyxW3EQLnQm3gNenU/Y+seNX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777582438; c=relaxed/simple;
	bh=wfPLuFUmFBKY60g7nf1+s737c+E/4use/NC6iOonq/o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KG59ir4u4t7N7Iz3G0Z3xkIFzJewtNURXp+1NV5veodhcs22yWctxWzZx7tq75vlGbNHwN3GdIiVYYpU2LYFmfVwao+3NgdiKEjkRiqAlOxa/GpKhioEyXjuEnVOR7f9mesSQX72LMJ83fv0f20AS2LRBqDG9coPjfumolVEoa4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N9SDBVSx; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N9SDBVSx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7477AC2BCB3;
	Thu, 30 Apr 2026 20:53:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777582438;
	bh=wfPLuFUmFBKY60g7nf1+s737c+E/4use/NC6iOonq/o=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=N9SDBVSxX/OCWQaQKfd0P/621HU/3nZ5XxcCn04D89UEoiG6xQg0oTmI43t/Pt1Qo
	 4Y2h/tDwqjpxhKPyIarcUwDN8A4uaP1F+uvkisGitMd6nSi87N92oCDE4svbSvXtgk
	 aQAigEUKs+c6TL6PV3pHqiV0h+KRckuF4spC5/r2ExFMm4OlT3uv0wparCMKKsBjSr
	 KCz/CEQ5gkjlZznDMauuxp5qIoPa2lyGO4KEvULyYhCILtpMobUI4A99eJagQqUwRp
	 ZEim1eXmf00ddqOMGiYeM5ojHHWkizJyh0h404HW5N2gkuMYJa9uy1lSje2osbiYKe
	 sN7wrQrJQnxHw==
Message-ID: <6f10adc7-22e7-4509-96c6-31d27543efd0@kernel.org>
Date: Thu, 30 Apr 2026 22:53:55 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH mptcp-net] mptcp: bpf: fix type confusion in
 bpf_mptcp_sock_from_subflow()
Content-Language: fr
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: MPTCP Linux <mptcp@lists.linux.dev>
References: <20260430-mptcp-bpf-mptcp-sock-type-v1-1-d2ed5cda7da9@kernel.org>
 <CAAVpQUDeJRSTympB2QqQv8Ouc+WRnM_HjVyitqngQiM3Uayh4Q@mail.gmail.com>
 <fb2d66e0-b2bf-484d-85e3-c325d99bbfb2@kernel.org>
 <CAAVpQUBUcGgqoTed8NMUMFhoe=xYPXtzktfr7Zv7yjwgVcL-Qw@mail.gmail.com>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <CAAVpQUBUcGgqoTed8NMUMFhoe=xYPXtzktfr7Zv7yjwgVcL-Qw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 30/04/2026 22:48, Kuniyuki Iwashima wrote:
> On Thu, Apr 30, 2026 at 1:45 PM Matthieu Baerts <matttbe@kernel.org> wrote:
>>
>> Hi Kuniyuki,
>>
>> On 30/04/2026 22:35, Kuniyuki Iwashima wrote:
>>> On Thu, Apr 30, 2026 at 1:27 PM Matthieu Baerts (NGI0)
>>> <matttbe@kernel.org> wrote:
>>>>
>>>> bpf_mptcp_sock_from_subflow() only checks if sk->sk_protocol is
>>>> IPPROTO_TCP, but RAW socket can bypass it:
>>>>
>>>>   socket(AF_INET, SOCK_RAW, IPPROTO_TCP)
>>>>
>>>> In this case, it would NOT be valid to call sk_is_mptcp() which will
>>>> assume sk is a pointer to a struct tcp_sock, and wrongly checks for:
>>>> tcp_sk(sk)->is_mptcp.
>>>>
>>>> This is similar to the modification done on TCP side [1], by Kuniyuki.
>>>>
>>>> Fixes: 3bc253c2e652 ("bpf: Add bpf_skc_to_mptcp_sock_proto")
>>>> Link: https://lore.kernel.org/20260430184405.1227386-1-kuniyu@google.com [1]
>>>> Cc: Kuniyuki Iwashima <kuniyu@google.com>
>>>> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
>>>
>>> Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>
>>
>> Thank you for the review!
>>
>> If you need to send a v2 of your series to the BPF ML, feel free to
>> include this patch (without the last sentence, the Link and the Cc
>> tags).
> 
> Sure, will include it in the series and extend the test accordingly.

Great, thank you!

> (I was looking for variants but only in net/core/filter.c and
>  missed mptcp one :p)
No problem, that's not the first time it happens! For once, I managed to
catch that quickly :)

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

