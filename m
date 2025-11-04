Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13FF072639
	for <mptcp@lists.linux.dev>; Tue,  4 Nov 2025 22:32:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762295530; cv=none; b=Wm3eeUFfyv5XrGm4ygP3ZRH04JQAkkW18n8fb4DtkSX3Vn5XdKbCQhqUYDL1Qnmbt2cY8+Q58ku6lxSUiCNRang3c/n4BvCmoyhT4lD4a3SADBB/TDmrwLNRRSk4U4HN5gfZZHGhEqzN3CRaRCyJCh96C0vv3G4GQlG1co9T3ew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762295530; c=relaxed/simple;
	bh=+jCn/yU0QssYl1sgsow2FmswnTzh3gHG/ADb7e/Xpq4=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=r3RXRohdzimrE0w3Gc2OF9pLTLRRLlKObjoHJXaIZKHLhYvfeQfCpwwRBehCGp2Vtgx4tGWck1h9JaV3FMJWTph9muwLAH5bkOttHxxrQzPVWaXIllfftEGZEFJ5+YJD66aP4vvVB3m43I17VEhsaJxcE0CNxukCKt6wTeMRTiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ULyJMf3Q; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ULyJMf3Q"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77F62C4CEF8;
	Tue,  4 Nov 2025 22:32:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762295529;
	bh=+jCn/yU0QssYl1sgsow2FmswnTzh3gHG/ADb7e/Xpq4=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=ULyJMf3QuPl/KpbPn78y5QG6ktLzrghyqfZlF9ZKgOc9OIRzKsc9/QTaVwyn3WPJK
	 DoMY930+MoXh2c2cfOxZG5cpQQkydV1A01YXyEc/e2C7n2wdIDT2+gX9gB0h+lQ7Io
	 OKHfPgLhDK/OQ6CvsbuOjCiEtwr/ahnuWTjKb4QeHAjn55kW88ogRwL+T2SvTl7e8l
	 uqCPlysQup6qX8vVOdkVnlgXq6IxomsfTb3TP+V0hODnEO7VXYYwTltmlOor6FFA8X
	 RSMtB7WRSptTkgJOeiBhpebsD6Y5K2hQm3RfQJ1w9mr1vgrGC1DuULIlZLzUaoJyGJ
	 K9dcOETAPD4UQ==
Date: Tue, 4 Nov 2025 14:32:08 -0800 (PST)
From: Mat Martineau <martineau@kernel.org>
To: Paolo Abeni <pabeni@redhat.com>
cc: mptcp@lists.linux.dev, geliang@kernel.org
Subject: Re: [PATCH RESENT v7 mptcp-next 4/4] mptcp: leverage the backlog
 for RX packet processing
In-Reply-To: <bf160603-cfb4-4945-81d2-c958043078cf@redhat.com>
Message-ID: <45416918-6168-327e-36a2-6c7033a36098@kernel.org>
References: <cover.1761576117.git.pabeni@redhat.com> <08f8e227a749a28a88ce245fa36870173e32c54f.1761576117.git.pabeni@redhat.com> <6fb0d5aa-8140-505d-c40f-1dc40fff352f@kernel.org> <bf160603-cfb4-4945-81d2-c958043078cf@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Mon, 3 Nov 2025, Paolo Abeni wrote:

> On 11/1/25 1:04 AM, Mat Martineau wrote:
>> On Mon, 27 Oct 2025, Paolo Abeni wrote:
>>> @@ -3573,6 +3586,8 @@ static void mptcp_release_cb(struct sock *sk)
>>>
>>> 		cond_resched();
>>> 		spin_lock_bh(&sk->sk_lock.slock);
>>> +		if (spool_bl)
>>> +			mptcp_backlog_spooled(sk, moved, &skbs);
>>
>> Hi Paolo -
>>
>> Given the discussion in v5, to address the "wild producer" scenario this
>> loop can keep track of total_moved and exit the loop when that gets too
>> large.
>>
>> The question is what the total limit would be - available rcvbuf when
>> entering the loop, or some multiple of that?
>
> I spent a lot of time around that choice. Limiting the loop here is
> quite tricky. Stopping the loop after sk_rcvbuf bytes causes mptcp-level
> OoO and adds additional complexity to the code (as the receiver will
> need to check the backlog even when the receive queue is not empty.
>
> Note that the code proposed in this series is as robust as the current
> (i.e. release_cb() can already be bothered by a wild producer in exactly
> the same way).
>
> I propose to decouple the wild producer problem solution from these patches.

Sounds reasonable to me. After the v5 thread, wanted to be sure I was 
clearly understanding the tradeoffs. Thanks for the details!

- Mat
