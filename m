Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D387A42A99
	for <mptcp@lists.linux.dev>; Sat,  6 Sep 2025 00:45:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757119519; cv=none; b=Ztf+5RffghYJrerjU0L9QuxwFMdrL+C6eW/EsPcRtR5MOoFSlACybvU10Gd5VfQjoZ2DyOi3/RnXpWk1NVxUvvbb/mL5k/BbTTfDCZEzb538aIuRirFSDUhcIoxKe4IDhWGAo/vajqBQkmEa8mDZqGyoPzhNiKsvZP1zzW4NfMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757119519; c=relaxed/simple;
	bh=mDjP4ksMnoYHDfX8r7SyAErBoiSEV8mz6+QBYMbpHrA=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=nbKTlLYulmq6lc3SeIdI43GFGU/XJXS0sIw/68DoXPabIA/sLXW7jCJMFDQaSzrQ1slv/jt+ru5wYwgWZ+Hh9tyyPvJjnWZIOiB8ASipMCoY2li/+glzT1Ka+zK7nUIva1V1XKBI1x2sr88LzAWIv5yK5z2iKk2Nt1SOxbCO2pA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qXRqlFfe; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qXRqlFfe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 194F9C4CEF1;
	Sat,  6 Sep 2025 00:45:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757119519;
	bh=mDjP4ksMnoYHDfX8r7SyAErBoiSEV8mz6+QBYMbpHrA=;
	h=Subject:From:To:Date:In-Reply-To:References:From;
	b=qXRqlFfeE75ZzTB95BpPSs1DnqDU9ARMCuF5VmxbPIeODaDCRdlW9nEFWAnPG226r
	 A9HsPyyOwNgI3XZ9ehM0KI355aYoMqshHnPmRXDpfkBUGx9j8wekdldYUO0rQzIo/U
	 6meSJ202LfVfgNXU4BhNCQ97aJynvu4u8gWwZT7jCYGt7QHGyWroZB8HPm3gAq/eKQ
	 gub6oWKp8pneoedbuj/slPqcNAnEq6bkW2zCixCsIM2wxR23wIBpx+wG0/oIQtVHTF
	 NZyepRQpCCx5dJLD9GAe4xFD0/o5mD+h3X6VnRQYq205uvOcdodVMBnF21awhJJv4N
	 3Crp4wooNu/rQ==
Message-ID: <9f2a05ac6034fb33f579302a0ede2ec13eb6c915.camel@kernel.org>
Subject: Re: [PATCH mptcp-net v2 1/5] mptcp: propagate shutdown to subflows
 when possible
From: Geliang Tang <geliang@kernel.org>
To: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, mptcp@lists.linux.dev
Date: Sat, 06 Sep 2025 08:45:16 +0800
In-Reply-To: <20250905-sft-mptcp-disc-err-v2-1-dfb3b6b4a877@kernel.org>
References: <20250905-sft-mptcp-disc-err-v2-0-dfb3b6b4a877@kernel.org>
	 <20250905-sft-mptcp-disc-err-v2-1-dfb3b6b4a877@kernel.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.56.0-1 
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Fri, 2025-09-05 at 20:18 +0200, Matthieu Baerts (NGI0) wrote:
> When the MPTCP DATA FIN have been ACKed, there is no more MPTCP
> related
> metadata to exchange, and all subflows can be safely shutdown.
> 
> Before this patch, the subflows were actually terminated at 'close()'
> time. That's certainly fine most of the time, but not when the
> userspace
> 'shutdown()' a connection, without close()ing it. When doing so, the
> subflows were staying in LAST_ACK state on one side -- and
> consequently
> in FIN_WAIT2 on the other side -- until the 'close()' of the MPTCP
> socket.
> 
> Now, when the DATA FIN have been ACKed, all subflows are shutdown. A
> consequence of this is that the TCP 'FIN' flag can be set earlier
> now,
> but the end result is the same. This affects the packetdrill tests
> looking at the end of the MPTCP connections, but for a good reason.
> 
> Fixes: 3721b9b64676 ("mptcp: Track received DATA_FIN sequence number
> and add related helpers")
> Fixes: 16a9a9da1723 ("mptcp: Add helper to process acks of DATA_FIN")
> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
> ---
>  net/mptcp/protocol.c | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
> 
> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index
> 1c26acf6c4145896ecbb5c7f7004121c66a20649..9feb9f437c2bdfff392249e7ad0
> 0edd09ba67ac3 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -372,6 +372,20 @@ static void mptcp_close_wake_up(struct sock *sk)
>  		sk_wake_async(sk, SOCK_WAKE_WAITD, POLL_IN);
>  }
>  
> +static void mptcp_shutdown_subflows(struct mptcp_sock *msk)
> +{
> +	struct mptcp_subflow_context *subflow;
> +
> +	mptcp_for_each_subflow(msk, subflow) {
> +		struct sock *ssk = mptcp_subflow_tcp_sock(subflow);
> +		bool slow;
> +
> +		slow = lock_sock_fast(ssk);
> +		tcp_shutdown(ssk, SEND_SHUTDOWN);
> +		unlock_sock_fast(ssk, slow);
> +	}
> +}
> +
>  /* called under the msk socket lock */
>  static bool mptcp_pending_data_fin_ack(struct sock *sk)
>  {
> @@ -396,6 +410,7 @@ static void mptcp_check_data_fin_ack(struct sock
> *sk)
>  			break;
>  		case TCP_CLOSING:
>  		case TCP_LAST_ACK:
> +			mptcp_shutdown_subflows(msk);
>  			mptcp_set_state(sk, TCP_CLOSE);
>  			break;
>  		}
> @@ -564,6 +579,7 @@ static bool mptcp_check_data_fin(struct sock *sk)
>  			mptcp_set_state(sk, TCP_CLOSING);
>  			break;
>  		case TCP_FIN_WAIT2:
> +			mptcp_shutdown_subflows(msk);

I think we should not directly call mptcp_shutdown_subflows() within
mptcp_check_data_fin() and mptcp_check_data_fin_ack(), but should
instead call it after these functions return and the sk state is
TCP_CLOSE. This ensures that the original purpose of these two
functions remains unchanged.

WDYT?

Thanks,
-Geliang

>  			mptcp_set_state(sk, TCP_CLOSE);
>  			break;
>  		default:
