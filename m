Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 846C03D9DC3
	for <mptcp@lists.linux.dev>; Tue, 13 Oct 2026 09:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791883817; cv=none; b=kM8Y2Vz6u0hC3epKDvQSYdZzMMU2pZY7bzY+dFXAszKo6+BE24S/qqJGNkbjbz3IvxJ9OHK8qySDuVLLb7y4a2Fh5yJIOj+BDDFyL6PS3YPjkC52OcnC80aoRV3M94jLSfx5I7+aR/QdaVcUND7CKfl7//INrLIpIwQPOK6E2KA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791883817; c=relaxed/simple;
	bh=fN4UrdrzXWyJSOnGeOEFtDIy3EX6NmXLobX1UG0tR3k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OJiZCoE2g8XMEan1zKSjWSq9LkxKxPF5Quo+IHp/7J4qqZznTg2cRB+NKAIC07I3fu8KqzCnnT+qEOODnzB4fZKD2WvunYc0tdCcTeOQFKIDNCofrTgf+EYUH2G24yi3fKAj7IbUp0WLvCvClEo2cW18LqOlkrdO7CWwOy5oMRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CNi4o1Wb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CNi4o1Wb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA86C1F000FF;
	Tue, 13 Oct 2026 09:30:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791883815;
	bh=+tFw0RzK3gqieiBF/LycvdbnMp5N8upvf7wLSvp06Bw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=CNi4o1Wb6mZ4ipTjVavmDunIH+Hm8uckIKjYL9d77j491XtkF4MinpeSkU6eRLe32
	 n9i5krqjtkx9u7m0znGmfb0W5vDMaQYO09zJM+t3ARiyAPtLcm96pg/vcSdzr23Ind
	 +/Gd2HUm76TTI1gdgqmBc/vtOQVGrwvqRMdJuaekOKPE6mmFnPw1c2fHmOvU2MYFsz
	 Uw74MGaKapMzqI0e92o04VkSFTV4i42PCy2ZEkW4IQsj79MnB+7XFSo8mEYu6G0I92
	 eNVmoUul6OXiErCXq+q07WgS9n9w7WRf0TARBUF7qgV2NiCfqCMGgcDOG/qBQIXJxC
	 4cDN0vF/JUC9A==
Message-ID: <b667a46d-7cd0-4b91-bcd3-6d745f2d7062@kernel.org>
Date: Tue, 13 Oct 2026 11:30:11 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH mptcp-net v3] mptcp: push queued data on passive TFO
 subflows becoming established
Content-Language: fr
To: T S Rameshkumar <rameshsv06@gmail.com>, mptcp@lists.linux.dev
Cc: petar.sakic@ink.fish, T S Rameshkumar <rameshkumar.t@phytecembedded.in>
References: <20261013080254.83992-1-rameshkumar.t@phytecembedded.in>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <20261013080254.83992-1-rameshkumar.t@phytecembedded.in>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi T S,

On 13/10/2026 10:02, T S Rameshkumar wrote:
> With TCP Fast Open on an MPTCP listener, if the server application
> writes data while the passive subflow is still in SYN_RECV (after
> consuming the client's SYN data but before the MP_CAPABLE third ACK
> arrives), __mptcp_subflow_active() refuses transmission and the data
> is queued into the msk write queue.
> 
> When the MPC third ACK arrives, the subflow transitions to
> TCP_ESTABLISHED and is marked fully established in
> check_fully_established(), but because the third ACK carries no
> DSS data, the queued bytes remain stranded until the peer sends
> more data.
> 
> Fix this in check_fully_established() by checking if the subflow
> was doing passive TFO (subflow->is_mptfo). Under mptcp_data_lock(),
> flush queued bytes via __mptcp_check_push().
> 
> Additionally, ensure subflow->is_mptfo is set in
> mptcp_fastopen_subflow_synack_set_params() even if the cookie-bearing
> SYN carries no data, so that server-first replies on zero-data TFO
> connections are also pushed upon 3WHS completion.

(...)

> diff --git a/net/mptcp/fastopen.c b/net/mptcp/fastopen.c
> index f71775090..c4c525019 100644
> --- a/net/mptcp/fastopen.c
> +++ b/net/mptcp/fastopen.c
> @@ -24,13 +24,13 @@ void mptcp_fastopen_subflow_synack_set_params(struct mptcp_subflow_context *subf
>  	sk = subflow->conn;
>  	tp = tcp_sk(ssk);
>  
> +	subflow->is_mptfo = 1;
> +
>  	/* A valid TFO cookie does not guarantee SYN data. */
>  	skb = skb_peek(&ssk->sk_receive_queue);
>  	if (!skb)
>  		return;
>  
> -	subflow->is_mptfo = 1;

No, we cannot do that:

 https://lore.kernel.org/3f9d7081-65f1-4618-8f34-d95e3f84824e@kernel.org

Please wait for the discussions to settle before sending new versions.

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

