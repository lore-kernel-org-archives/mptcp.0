Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16FA52EB842
	for <mptcp@lists.linux.dev>; Sat,  6 Sep 2025 13:55:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757166909; cv=none; b=I5E9QyFBEAlpBoa8+5hmOFTXgKU6Abtxss4wpQVHRZCLd+58LLxOoz0WWQ3q5fsOcL+62nGPLmGkAPg/fII+QOKXyj9uIlsQX89ajvErGMAe7por8hgGbzeMuuR46B07/KbbwvAjSz51VPHabW5D1d5RtnDd1iqoV0FE/L663a0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757166909; c=relaxed/simple;
	bh=mDjP4ksMnoYHDfX8r7SyAErBoiSEV8mz6+QBYMbpHrA=;
	h=Message-ID:Subject:From:To:In-Reply-To:References:Content-Type:
	 Date:MIME-Version; b=nIPcsq0X1wNDB4fpa0IKvGbro4hnprAwFIT0kiEHCD+XGfCQ0VXF3p3K64WfGUn6fn5yPkODDT4Q3zBo7z3/0mU1RQ5tt/llNMH53iYw3PTXpGZRlJrcyT/27nQWvHNWC8kkHhxO8lJ9HU/2BWCpkT6jEBnhR2XiPZI67IVRz9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PCJuphmz; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PCJuphmz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0900FC4CEE7;
	Sat,  6 Sep 2025 13:55:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757166908;
	bh=mDjP4ksMnoYHDfX8r7SyAErBoiSEV8mz6+QBYMbpHrA=;
	h=Subject:From:To:In-Reply-To:References:Date:From;
	b=PCJuphmz8I6PlGptqRZtBhKOeNSX8iL9XnUvg3qPQRWaExy4MPrPaa/N0/PLj4fnk
	 sons38ZZoeNvSSGfqhH1mY4EFYisMkcon0nUWObwpZLTWzFs2TdpyHrq0jTxBJYJzN
	 KAwBJ+KCzQYDsKLBZautStzwKCJQwRb36uWd27DE0pqpyY5gp4RzjT/HpDH53evpMl
	 SC2yybXfqmW16orXwUag4Cc47SFDwKw73KikPZdcKupZJPd139ef8n30O8cg7B8Gqt
	 uBlg0J5KVv3nM7EcA3e5NcgIXL4pITOfPfY336VhCg93MJ7kGSUOP/u242A+V7Mzsa
	 qD7WjklIhkMEA==
Message-ID: <c08a3c66a2096793dbeb6c1e8225ce031526bb7a.camel@kernel.org>
Subject: Re: [PATCH mptcp-net v2 1/5] mptcp: propagate shutdown to subflows
 when possible
From: Geliang Tang <geliang@kernel.org>
To: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, mptcp@lists.linux.dev
In-Reply-To: <20250905-sft-mptcp-disc-err-v2-1-dfb3b6b4a877@kernel.org>
References: <20250905-sft-mptcp-disc-err-v2-0-dfb3b6b4a877@kernel.org>
	 <20250905-sft-mptcp-disc-err-v2-1-dfb3b6b4a877@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Date: Sat, 06 Sep 2025 08:47:08 +0800
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Evolution 3.56.0-1 
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
