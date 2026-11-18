Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795025945;
	b=wOEExCBl6eZGxvTVIsF3gJzQ7cGv+gICMIOv51hbRwbdHo7eRWG5OE1Cbh9UuvNQuzD9
	 xRaXYZUwFH8utmkYG6xMGkpu26QktVEjgl9DkCNJhO1vkDbRa4CJhkltuImYopLXM+MlY
	 BndKa0jyHpHKUY0YjQ5MRcElAh14tcSVQwsNwkqoaP6o+hjrUBQFBFzu2ZHBSNgjO8lDi
	 bSain2DMmGkNR0aFDoJJZFSgSFMSEWo4fYqaPs0DPVRcqNH5kWZZvFGfdET/8PzZl+gfY
	 D4mPVQ1HNyoNd9jmAPsZrHbt3eHO6se59vJwAPYS3M0B0jJ6BvKRj42FT+XXw9EuGcQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795025945;
	h=Received:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:Content-Language:To:Cc:References:From:Autocrypt:Organization:
	 In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=ZFMbQmS5Ec95/BM5uCXJYmzAHLkYlZBGDKoiVn7chog=;
	b=RlxAFdQNKddcZly+nAF0Z7xiRdVOx9NteB92Dykbw6mc+GrOj0uO2gE2hPtaVbNZgMjq
	 rJo/TCD4R+/eR/GtmBCf8ZoP9ijmi8d8JdIbUK/Xt/xrcQLano2eQ6fPA/MMwTqm4pPxs
	 CUKwMhKyOj3m45eowc1oGURp605XCZBEEJ+L3iFsA49Kb1RJfyfYabYH4IWrWXyuf1wTT
	 xz4HJA2soETEGX14WkTY6di7Pp0huP+0xdUBCxnMpmLloggdCET5q54YuGan1MfXTjw8w
	 Zk1akY+DlU8ILv1hJu7R0BXwGZ0Q/mxels+33y2I0v450Wp3DUIsan+AVKJDgejxuMQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kkYzgU3a;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ED40606A320;
	Wed, 18 Nov 2026 18:19:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kkYzgU3a
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F5FB1F000C6;
	Wed, 18 Nov 2026 18:19:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795025944;
	bh=ZFMbQmS5Ec95/BM5uCXJYmzAHLkYlZBGDKoiVn7chog=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=kkYzgU3akIg75redaOVqvHrrZvo4JOflhkjQY4vWtT7DdW30MWaIAnldG5yYqppcP
	 RTxxnIzAgMo1D0D1wlvuVeQzLCNvEYs+/fhC87SOjITOiNpGIpEXU5r4PT8ga4I4b9
	 e4gZLt6cFPYREKttOodtJhYk7lIHsq6Qa3AfMFUBYxH3xz3lqyu7DblZZI9LobWGR2
	 0PuzZ/HKovMA98YBdOeQs3HDJlM2AD+wC97pix0I0bkXohSm5BFo8CGReFYdKvF/MO
	 7qSogrlDYhXVuKe1G5fS+2oRmzxgxDuSXpGEqylgTDwA5s4m8znz7ZwdOdh5hiHGS0
	 qwYQ4gUchr86w==
Message-ID: <5d651146-b21d-44da-9f15-860f0c9c2dc5@kernel.org>
Date: Wed, 18 Nov 2026 19:18:59 +0100
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
Subject: Re: [BUG] mptcp: pm: WARNING in mptcp_check_listen_stop() when listen
 fails on a new endpoint listener
Content-Language: fr
To: Kyuwon Cho <kyuwoncho18@gmail.com>
Cc: Mat Martineau <martineau@kernel.org>, Geliang Tang <geliang@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
 Simon Horman <horms@kernel.org>, mptcp@lists.linux.dev,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <179502042942.2742790.17887994424282536144@gmail.com>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <179502042942.2742790.17887994424282536144@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Kyuwon,

Thank you for the bug report and the reproducer.

On 18/11/2026 17:59, Kyuwon Cho wrote:
> Hi Matthieu, Mat, Geliang,
> 
> While testing v7.4-rc3 with an LLM-guided test generator that we are
> developing as a research prototype, we found that adding a "signal"
> endpoint with a port can trigger the WARN_ON_ONCE() in
> mptcp_check_listen_stop(). It happens when __inet_listen_sk() fails on
> the subflow of the listener that mptcp_pm_nl_create_listen_socket()
> creates, here because another socket took the port after the subflow's
> bind:
> 
>   ------------[ cut here ]------------
>   WARNING: net/mptcp/protocol.c:3451 at mptcp_check_listen_stop.part.0+0x15c/0x220, CPU#0: test/116

(...)

Please always decode stacktraces with ./scripts/decode_stacktrace.sh.

> mptcp_pm_nl_create_listen_socket() binds the subflow, sets the MPTCP
> socket to TCP_LISTEN, and only then calls __inet_listen_sk() on the
> subflow:
> 
> 	inet_sk_state_store(newsk, TCP_LISTEN);
> 	sock_set_flag(newsk, SOCK_RCU_FREE);
> 	lock_sock(ssk);
> 	WRITE_ONCE(mptcp_subflow_ctx(ssk)->pm_listener, true);
> 	err = __inet_listen_sk(ssk, backlog);
> 	...
> 	return err;
> 
> If __inet_listen_sk() fails, inet_csk_listen_start() puts the subflow
> back to TCP_CLOSE, but the MPTCP socket stays in TCP_LISTEN.
> mptcp_pm_nl_add_addr_doit() then releases the listener, and
> mptcp_check_listen_stop() finds an MPTCP socket in TCP_LISTEN whose
> first subflow is not:
> 
> 	if (WARN_ON_ONCE(!ssk || inet_sk_state_load(ssk) != TCP_LISTEN))
> 		return;
> 
> Matthieu's "mptcp: pm: kernel: count endpoint listeners as sockets in
> use" (17/34 of the mptcp-net series posted on 2026-11-13) notes that
> this socket stays in TCP_LISTEN when __inet_listen_sk() fails, and
> counts it accordingly; it does not change the warning.

Indeed, v1 of this patch did not fix the warning. Sashiko spotted the
same issue on v1, and I already fixed this issue locally (but the series
is huge now due to all the new reports from Sashiko, etc...). The v2
will be sent to the MPTCP ML soon, and I will add your Reported-by tag.

> __inet_listen_sk() fails there when another socket binds the port
> between the subflow's bind and its listen, and listen() then sees the
> conflict. In the reproducer, one thread adds and flushes a signal
> endpoint 127.0.0.1:10007 through the mptcp_pm genl family, and another
> binds and listens on the same port with TCP_REPAIR sockets, whose
> SK_FORCE_REUSE skips the conflict check at bind. About a quarter of the
> 3000 ADD_ADDR requests fail with EADDRINUSE; the warning comes from the
> ones that fail at listen rather than at bind. It runs as an
> unprivileged user (uid 65534) in its own user and network namespace.
> On an x86_64 QEMU guest with 2 vCPUs and KASAN (gcc 13.3), the warning
> shows up in every run (3 of 3 with the attached 168-line reproducer, 3
> of 3 with our original test).
> 
> syzbot reported the same warning in 2023 through a different path, a
> tcp diag request closing the listener's subflow, which 4c0288299fd0
> ("mptcp: prevent tcp diag from closing listener subflows") fixed. The
> check and the TCP_LISTEN state of this listener both come from
> 57fc0f1ceaa4 ("mptcp: ensure listener is unhashed before updating the
> sk status").
> 
> Checked against v7.4-rc3 (aebb72744764);
> mptcp_pm_nl_create_listen_socket() and mptcp_check_listen_stop() are
> the same in net (2a324a58a084). We searched lore and syzbot and found
> no other report of this path.
> 
> The reproducer (repro.c) and the kernel config are attached.

Out of curiosity: if your LLM has already analysed the root cause and
has a reproducer, why not ask to generate a fix and send this patch
instead of the bug report? There are so many patches being shared today
that it is already hard to keep up. If maintainers also have to create
fixes for issues report by LLMs, that might not work. Sending a patch
after having passed a series of reviews by an internal Sashiko instance
on your side would be more helpful.

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

