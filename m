Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1A85548EE
	for <mptcp@lists.linux.dev>; Sun, 31 May 2026 06:39:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780209600; cv=none; b=DBmOAxcs36FKZo0qut9n2iDxU0pDd3Saf+BtYIff9vhHVx5IkhlOTNTnI3WW5GR7NeG2oaKydP+s0Q4FOBxfbrXXUlp2k0RhHH9EZXM+4OljqhtoFK1wazgLvlZ0r3lgvcIsS73xxF+G7l2F0vK2wlGiniYgXAVri5Mn0cai/ug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780209600; c=relaxed/simple;
	bh=6LGKeL/vyqBP6PIj9Gu4SZ5C5oEZsECaFqmJaYwO07M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KeAchN4pUomlhIVgfT38ucu8V5Hwr90xzWPJ48El3qQbmGO6byycHGKIJmaIA5IDXZbXHlGq0lhSVQq7tJOF9+IPl4eqtOmjnFjjCisCRyjP1q4RhjqCVHo1Hi+awkySJT402w3Uc0qjlr9g2uEAyVHWzskoCsNcaFLQGRaFc9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=keiFF9a6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="keiFF9a6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6AE71F00893;
	Sun, 31 May 2026 06:39:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780209599;
	bh=gV6pAlYxVSUeM3XAQkYsQULXb4G6GMw+cIbe1D1IZEU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=keiFF9a6GclN68hSfQE1LjS+gc37dtNGnpJaHkEysFOPH+SqUbmKHg6UlHkAwh5EZ
	 UwfYet74CWR2M9yU6W0BjlEmCYICT/qCHCYN8uC1s7xNgmHF7cg8AE6eFynsXWevjE
	 lWKRLW0lalp98IEAtbbp8piu74mlTE5KdGyXoLU5IGKdKY8SW63Si5QFOjrPAOaKWZ
	 9+QRLRgy8lIDCsSbTZtcpBEIk8+24Exy5ERp7Zmq8pruD2UwY6bqLQNZk8ke+PSU1J
	 LDO15uoTvimWpjM1Cg/Mu5PaQEQ32Sl4xzqz7hPhurZBUbS2J40dOYnut+YAi44NsX
	 EzpeObo1UBl+g==
Message-ID: <bca2ad2f-1f45-45e7-a8bd-7a08dd7100c2@kernel.org>
Date: Sun, 31 May 2026 16:39:53 +1000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH net v2] mptcp: pm: drop pending ADD_ADDR when removing id
 0 endpoint
Content-Language: fr
To: Kalpan Jani <kalpan.jani@mpiricsoftware.com>
Cc: mptcp <mptcp@lists.linux.dev>, martineau <martineau@kernel.org>,
 pabeni <pabeni@redhat.com>, "shardul.b" <shardul.b@mpiricsoftware.com>,
 janak <janak@mpiric.us>, kalpanjani009 <kalpanjani009@gmail.com>,
 shardulsb08 <shardulsb08@gmail.com>,
 syzbot+55c2a5c871441261ed14
 <syzbot+55c2a5c871441261ed14@syzkaller.appspotmail.com>
References: <20260529064355.922763-1-kalpan.jani@mpiricsoftware.com>
 <0f13954f-3bfa-4630-af9f-6f1f4b138a13@kernel.org>
 <19e72995d6d.89137929840232.7611532549298755137@mpiricsoftware.com>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <19e72995d6d.89137929840232.7611532549298755137@mpiricsoftware.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Kalpan,

On 29/05/2026 17:18, Kalpan Jani wrote:
> Hi Matt,
> 
>> Did it work with packetdrill?
> 
> I worked on a packetdrill test based on add_addr4_server.pkt with the
> MP_JOIN extra subflow and the delete/re-add sequence. The environment
> is working (add_addr4_server.pkt passes cleanly), but I was not able
> to reliably trigger the WARN through packetdrill within the test
> timeframe.
> 
> The difficulty is that the id 0 ADD_ADDR is only sent when the
> endpoint is re-added after the connection is established AND after
> mptcp_nl_remove_id_zero_address() has run to restore the
> id_avail_bitmap bit via __mark_subflow_endp_available(). Getting
> packetdrill to control this timing precisely — while also keeping
> conn_list non-empty so mptcp_nl_remove_id_zero_address() actually
> processes the msk — proved tricky.

I understand it might be tricky, but do you mind sharing what you have
so far. Maybe someone else can help you to reproduce the issue. Also, it
might be enough to have a test that can reproduce the WARN not 100% of
the time, as long as it is not 0. I will wait for this test before
applying the v3.

At least having something exercising new paths: here, having the new
call to mptcp_remove_anno_list_by_saddr() returning true.

> syzbot is reproducing the bug reliably on current upstream (3 crashes
> between 2026/05/19 and 2026/05/22 on kernels including cca95436be15).
> The syzbot reproducer is the most reliable pre-fix evidence available.

Because syzbot didn't manage to generate a reproducer, we cannot really
rely on syzbot to say that the bug is fixed. 3 crashes out of how many
thousands/millions attempts? :)

> I will continue working on the packetdrill test and send it as a
> follow-up once I have a clean before/after result. For v3 I have
> addressed your comment shortening request.

Thanks!

Do not forget to wait ~1 day between submissions, otherwise it is even
harder for reviewers and various tools to follow the modifications and
discussions.

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

