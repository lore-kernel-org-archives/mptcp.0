Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DB19253340
	for <mptcp@lists.linux.dev>; Tue, 13 Oct 2026 09:28:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791883715; cv=none; b=Qc6PnlEVWPyZscxZNpbmRlViGielkQHYDrU9wN0oyt69W3t+hTxdE0f1Wy4U2MXYti7PCKQ2EyEct3dLCczUtVGJxkO5Kl2oZYsp3mphR77kFuRT1CiH9Yt82MhW6KsZyjUEjK3dqPxlpnIU78a8SvFxRVd5KBo/g4nk7CYPQp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791883715; c=relaxed/simple;
	bh=6ToZ/vfAO5+XDZE3j9k1mLctLQcftJo7HpEqYkK1XDw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VPTaRBDtJQQgY9vYEMZV7mOGqr3fa64oLoKOfiSv6w08qM8rWuqCrpW8Um07apZiGtY5/jrZWqBIKsuLiQnp6Dsd+uJ2ggmS1ozpsHSeNfokVnl0FoWN6dfqlGXP7v04+A+9BzEnQrImMaGHMXnknkDpZV22ASArqWFESyLqRzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nODcbkhP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nODcbkhP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 131AF1F000FF;
	Tue, 13 Oct 2026 09:28:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791883713;
	bh=jtj6bb4bSydAAdSlcb0w9lyDzoTnFf3v6RMFOUBMkqc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=nODcbkhPZYt4mM+a4dpPl6WRuAwGnJElYz2BNPTzjNgyy4mFvEdE0VMi682Zq+Lt7
	 2owdctcBaD1DRZc1Ix3d6mz3SHKSa41XZDVNe1XnIkwXWt/40RS2Qo4X37TalzqJ59
	 0axdoj/Lwm2l1zRkSEOMgMM0Q2bJKTveYuemyUGfexmFL3MNZmTlvU1kEAjShaIOCx
	 gq9e00BHJ9uV9Oh6j48z3WB8AR4RBDNfKdKifXczuPgHT/NTtbuVMhoRf/K5PVkb83
	 5PpKxEWDLCJQCFMuHzv683T2DZi4nm5zxsCEF4UKXNjEEgkKk88z7jcI1NxdQCEq2m
	 frq4QiEZ16v4w==
Message-ID: <3f9d7081-65f1-4618-8f34-d95e3f84824e@kernel.org>
Date: Tue, 13 Oct 2026 11:28:31 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH v4] mptcp: push queued data on passive TFO subflows
 becoming established
Content-Language: fr
To: Petar Sakic <petar.sakic@ink.fish>
Cc: T S RAMESHKUMAR <rameshsv06@gmail.com>, mptcp@lists.linux.dev
References: <20261008121602.206507-1-rameshkumar.t@phytecembedded.in>
 <CADRhS2uk-P8TSmyiM=X5JQXHtzdm68vg6+vyBDr-UCf0EAu0HA@mail.gmail.com>
 <b5d420d1-859a-4c84-a658-e7aa44abbb30@kernel.org>
 <CAFPPu1gEqVx=LuW8Z5qv-6GRDwzkLjbvdQwYOgaacL3zLBXWtQ@mail.gmail.com>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <CAFPPu1gEqVx=LuW8Z5qv-6GRDwzkLjbvdQwYOgaacL3zLBXWtQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/10/2026 21:48, Petar Sakic wrote:
> Hi Matthieu and T S
> 
> I hope replying here is OK.
> 
> Tested v2 on top of 6.12.111 (applies with a 15-line offset, no other change).
> 
> Setup: two netns over a veth pair, netem 50 ms each way (100 ms RTT). MPTCP
> listener with TCP_FASTOPEN=16; the server replies as soon as accept() returns,
> while the TFO child is still SYN_RECV (checked via TCP_INFO). Client: first
> connection fetches the cookie, the next ones use TCP_FASTOPEN_CONNECT so the
> request rides the SYN. Checked per run: TCPFastOpenActive/Passive,
> MPCapableSYNTX/ACKRX, MPCapableFallbackACK = 0.
> 
> - 6.12.111 unpatched: reply stranded on every TFO connection (3/3).
> - 6.12.111 + v2: reply delivered on every TFO connection (3/3), ~2 RTT.
>   Plain TCP control unchanged.
> 
> Tested-by: Petar Sakic <petar.sakic@ink.fish>

Thank you for having tested that.

> One case v2 does not cover, same setup: a cookie-bearing SYN with no data
> (sendmsg MSG_FASTOPEN, zero bytes), server speaking first.
> tcp_fastopen_create_child() still creates the child (TCPFastOpenPassive
> increments, accept() returns in SYN_RECV), but
> mptcp_fastopen_subflow_synack_set_params() returns before setting
> subflow->is_mptfo because the receive queue is empty, so the new check
> never fires and the reply is stranded again (2/2, with and without v2).
> Plain TCP handles it. Moving the assignment above the early return makes
> both cases pass here (3/3 and 2/2), no splats:
> 
> --- a/net/mptcp/fastopen.c
> +++ b/net/mptcp/fastopen.c
> @@ -25,13 +25,13 @@
>         tp = tcp_sk(ssk);
> 
> +       subflow->is_mptfo = 1;
> +
>         /* A valid TFO cookie does not guarantee SYN data. */
>         skb = skb_peek(&ssk->sk_receive_queue);
>         if (!skb)
>                 return;
> 
> -       subflow->is_mptfo = 1;
> -
>         /* dequeue the skb from sk receive queue */
> 
> Up to you whether that belongs in this patch or a follow-up.
Probably better in a follow-up in this form, but not with this patch:
here, you are reverting this:

  https://git.kernel.org/torvalds/c/e00b63056fb4

What about calling __mptcp_check_push() if (subflow->mp_capable) instead?

@T S: please wait for the discussions to settle before sending new versions.

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

