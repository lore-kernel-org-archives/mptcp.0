Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37A5F2EE29F
	for <mptcp@lists.linux.dev>; Wed, 13 Aug 2025 14:54:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755096842; cv=none; b=HWSeExr0Fea0VrKjYlIYQb7oSrynK+vuN4i8L7aFxyue4zE27YlqG1un7XkZHnBP4aHU6OiT/Y7EbJT3Fi+wYCG55JRUw2RH5nGr9QRUGxHENPSvhoZFN3TNmnApLcRDL1Ni3mGFEWcp0hoM9tS6on1WCpuvi06zgY4H08X8kas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755096842; c=relaxed/simple;
	bh=+9CtScc3gTUY9mBf745Ywoefi6UUC9jnOqd5tGnh5rw=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:Cc:
	 In-Reply-To:Content-Type; b=Qfu6nDWgpjqgn97nouzBE/d8ejr/L3pKLkMXM+KpP/Oo7EoGX/8GlnnqhD6c+qxtqjqax9nDqy9ow9LXb5eGxy20QF9YXlSYjqZVB/nRKUx2DyRBpghoL0Die38PD3AvzBtsVmcQp7NjIo+b0ZWQqm2lM7PFQmCqDavFY3PoLhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QCm+zkIV; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QCm+zkIV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF243C4CEEB;
	Wed, 13 Aug 2025 14:54:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755096841;
	bh=+9CtScc3gTUY9mBf745Ywoefi6UUC9jnOqd5tGnh5rw=;
	h=Date:Subject:To:References:From:Cc:In-Reply-To:From;
	b=QCm+zkIVneklcOS3Tfo1x7R6gZk3pqglcONXvfNOYLXW6JkFqkiA0R8V+36iQE2dr
	 fC2sD4HnPaL1/WCo5bC4AUb+teawFGW8RHjadIb5UXU1POF3zsMLX2c6rxnOTR3lQF
	 DRLZjPdayAtdZRM2gJ/+Af/qcSLu1c3cM8fx4fmO0BlJ7GyNLEgTIcVjcKsXLJm8Rg
	 5G5OJauPiZwE5sUHgBVcPGQ+4UQ3mf0zRyW6rZUtKBC8wdfGbzTHeV00L07iBkRGaw
	 DZzkgifrhKRIl5kQN+e6IV7uYzCIxkePdXOjXrR9PyCmWtrQdjPC4sMd5T+t+e0XY9
	 B/MRyzo0v8IAg==
Message-ID: <2f037b38-c9f4-44a0-857c-0f65cbd50688@kernel.org>
Date: Wed, 13 Aug 2025 16:53:58 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH mptcp-next] mptcp: record subflows in RPS table
Content-Language: en-GB, fr-BE
To: cpaasch@openai.com
References: <20250807-b4-mptcp_perf-v1-1-e89cc14179cc@openai.com>
From: Matthieu Baerts <matttbe@kernel.org>
Cc: MPTCP Upstream <mptcp@lists.linux.dev>, Geliang Tang
 <geliang@kernel.org>, Mat Martineau <martineau@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <20250807-b4-mptcp_perf-v1-1-e89cc14179cc@openai.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Christoph,

On 07/08/2025 20:14, Christoph Paasch via B4 Relay wrote:
> From: Christoph Paasch <cpaasch@openai.com>
> 
> Accelerated Receive Flow Steering (aRFS) relies on sockets recording
> their RX flow hash into the rps_sock_flow_table so that incoming packets
> are steered to the CPU where the application runs.
> 
> With MPTCP, the application interacts with the parent MPTCP socket while
> data is carried over per-subflow TCP sockets. Without recording these
> subflows, aRFS cannot steer interrupts and RX processing for the flows
> to the desired CPU.
> 
> Record all subflows in the RPS table by calling sock_rps_record_flow()
> for each subflow at the start of mptcp_sendmsg() and mptcp_recvmsg().
> 
> It does not by itself improve throughput, but ensures that IRQ and RX
> processing are directed to the right CPU, which is a
> prerequisite for effective aRFS.

Thank you for looking at that!

> Signed-off-by: Christoph Paasch <cpaasch@openai.com>
> ---
>  net/mptcp/protocol.c | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
> 
> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index 4b510e04724f5c8be08a00a1cc03093bcd031905..86f1fc5be47bd5f6dc8bf40a488de32f253c1beb 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -12,6 +12,7 @@
>  #include <linux/sched/signal.h>
>  #include <linux/atomic.h>
>  #include <net/aligned_data.h>
> +#include <net/rps.h>
>  #include <net/sock.h>
>  #include <net/inet_common.h>
>  #include <net/inet_hashtables.h>
> @@ -1740,6 +1741,17 @@ static u32 mptcp_send_limit(const struct sock *sk)
>  	return limit - not_sent;
>  }
>  
> +static void mptcp_rps_record_subflows(const struct mptcp_sock *msk)
> +{
> +	struct mptcp_subflow_context *subflow;
> +
> +	mptcp_for_each_subflow(msk, subflow) {
> +		struct sock *ssk = mptcp_subflow_tcp_sock(subflow);
> +
> +		sock_rps_record_flow(ssk);

Should we eventually open code this RPS function and directly call
sock_rps_record_flow_hash()? If RPS is not needed, no need to go through
the subflow list. So we could add: #ifdef CONFIG_RPS + &rfs_needed
before the for_each, then check the state for each subflow, no?

Or maybe such optimisation is not worth it?

While at it, I see that sock_rps_record_flow() is called in
__inet_accept(), inet(6)_sendmsg and inet(6)_recvmsg, but with the msk.
I guess that's OK, right?
Also, is sock_rps_record_flow() called when a subflow is "accept()ed",
or is there something else to do there for this subflow to copy TCP's
behaviour?

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

