Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6418929BD94
	for <mptcp@lists.linux.dev>; Thu,  4 Dec 2025 17:22:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764868931; cv=none; b=PZo87SNMxi2banqyopZneAZLvBGECxA57NCcP8ttvtm6QzN7Iv2GK3zy3M0OAG+z4vcmj2daZihVtVPUqgej9CWg46U/lWVkZ8Nzsg9qaOMQGUigiRg4MbVb2/YAropVOtNUvqUk/Qw1Nd1OkQLmSqBObLuQBFLXXToQ4FYw0kk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764868931; c=relaxed/simple;
	bh=9IILW4+PKmLrQ2mlUkybjZHKNnp+S88azvpBX+nnqoo=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:Cc:
	 In-Reply-To:Content-Type; b=esGsH2NzfV+Ov1b33YQVbGK3mSSy/ujYXzYdxBbWxLB9E+CCeeImwUUpCbQdEAcCRTgV6KiKLoJvDTT+oNrcTftf26gIr+O0wGl3F+RPCsEdksggswFq7wpEC/HYwfasACSOpZ+g2cLTp3ymUKoDwcUFFgiOaeDNlwc0iLM5rLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QYWJPLNR; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QYWJPLNR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3CC83C4CEFB;
	Thu,  4 Dec 2025 17:22:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764868930;
	bh=9IILW4+PKmLrQ2mlUkybjZHKNnp+S88azvpBX+nnqoo=;
	h=Date:Subject:To:References:From:Cc:In-Reply-To:From;
	b=QYWJPLNR46cb5x4k7XYP6qXVgP78+9dz2SnbKU66HekZ7jTRTmZbgvJFXsYZv9TI3
	 ynU7AX1/RaKWS6kcg0PSXLeV14AedQ7tSuOoGY/zc7o40j455zWf0d3bIuQDSOV5iF
	 HseGcoWFN2SkPAhUbP8vlrnvDr89oAH2LXJ5NnRaGrBO5XJyRk/17ycpDLax1DUJ9d
	 d+YWpHe+pyo6xN0LZr5dql2kGdizeOKUY212BJ1zjnK/xKTKyXyJTthr3XWkVssIJG
	 pB4qlt+YnhvajPQRKzjo4xFhyNgI6fSibkiprdfcBpWnP3hFp7pFrKlkJHISt+tcwt
	 GSdX7mnpqbAGw==
Message-ID: <24ac4eeb-5092-4f13-a1e7-423ea5659016@kernel.org>
Date: Thu, 4 Dec 2025 18:22:08 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH mptcp-next] mptcp: cleanup duplicate ack suppression on
 fastclose.
Content-Language: en-GB, fr-BE
To: Paolo Abeni <pabeni@redhat.com>
References: <6d4733b0268246892cbbb8c2d3bcebce1714404a.1764786299.git.pabeni@redhat.com>
From: Matthieu Baerts <matttbe@kernel.org>
Cc: mptcp@lists.linux.dev
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <6d4733b0268246892cbbb8c2d3bcebce1714404a.1764786299.git.pabeni@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Paolo,

On 03/12/2025 19:25, Paolo Abeni wrote:
> The current transition to TCP_CLOSE in __mptcp_close_ssk() is rather
> obscure, especially since it's done unconditionally for all subflow.
> 
> Such action is needed only when disposing the given socket - that is
> for MPJ subflows, or at mptcp close time.
> 
> Move the statement in a better place and explain it's role for future
> memory.
> 
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> ---
>  net/mptcp/protocol.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index cd5a19ab3ba1..61066eb81412 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -2533,9 +2533,6 @@ static void __mptcp_close_ssk(struct sock *sk, struct sock *ssk,
>  	if (dispose_it)
>  		list_del(&subflow->node);
>  
> -	if (subflow->send_fastclose && ssk->sk_state != TCP_CLOSE)
> -		tcp_set_state(ssk, TCP_CLOSE);
> -
>  	need_push = (flags & MPTCP_CF_PUSH) && __mptcp_retransmit_pending_data(sk);
>  	if (!dispose_it) {
>  		__mptcp_subflow_disconnect(ssk, subflow, flags);

Just to be sure, is it not an issue to transition to TCP_CLOSE after
having called __mptcp_subflow_disconnect()? I guess no because the
transition above was done if "subflow->send_fastclose", which is also
check there. Also, tcp_disconnect() will transition to TCP_CLOSE but the
old state might cause extra RST, but I think that's fine, right?


If everything is OK, while at it, do you think it is worth it to drop
"dispose_it" variable?

  need_push = (...)

  if (msk->free_first || ssk != msk->first) {
      list_del(&subflow->node);
  } else {
      __mptcp_subflow_disconnect(ssk, subflow, flags);
      (...)
  }

> @@ -2554,6 +2551,10 @@ static void __mptcp_close_ssk(struct sock *sk, struct sock *ssk,
>  		WARN_ON_ONCE(!sock_flag(ssk, SOCK_DEAD));
>  		kfree_rcu(subflow, rcu);
>  	} else {
> +		/* Prevent __tcp_close() from sending additional resets */
> +		if (subflow->send_fastclose && ssk->sk_state != TCP_CLOSE)
> +			tcp_set_state(ssk, TCP_CLOSE);
> +
>  		/* otherwise tcp will dispose of the ssk and subflow ctx */
>  		__tcp_close(ssk, 0);
>  

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

