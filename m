Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BB353164D8
	for <mptcp@lists.linux.dev>; Tue, 26 May 2026 07:48:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779781686; cv=none; b=g6bI7XDDFUHDdsdsayIZIK4vdX8sS5UgRpL73dwfGbY/sd+xE9fJqmew7ghi11HxWc/NAA4TtmaWE0YSrHL8ymEHf+Lp+Zwi5i6GHqVaIlDwqIGFW2UDUBM6+LHBDZyErDzkFjaQGtJp7qUiNx16vHfK2BxgR6jMULdh2NcPN4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779781686; c=relaxed/simple;
	bh=088RjeJOmv4uSTK9beDyNyoLZN5R5gKn85mQLpJatz4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=H8Iv68VjI3et87oqY7d7ZO4QkfInmrLEovUX3O0VGrp1aFZqDNjKVKedJn03It4AshiRRvNeMbN996/xuNRaJ23JfEsG0fYsfAwmg5E0gotYAljZolfwk1lcJkwVU8l4KSfByUYsiT22IXjtcoKjhiCOwnWCGwIf7S0krb5jO8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J/OLH9yx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J/OLH9yx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BC661F000E9;
	Tue, 26 May 2026 07:48:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779781684;
	bh=UH4j25+XbftFvNV8BptTPvhLTqmR+8HOQDgbDDGjHUk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=J/OLH9yx/TWfieapN9Wm5D3pmMlpjQ6SNdLUMaaKROPzaRJ9KZ1NS4TSJxuNTC0nN
	 XwT8H5LLrJhyzf6a4zE/2B6ma6iEFmmZsXDarpbC9COFuvcbOLg0e24hSCy9AAD+9U
	 /bXJqvrCG27cGcDBma9OvJlMP9bcMtmsGO7VOZK7FStt/1YsXSphyxj3h7PPw9ukca
	 WXVxQFi7pUHg6rfcSNmWjKReFdJyxy9sqedLr8iQuHGil5/EaO9bByrVF5LxTUJel6
	 BNb+TX4PQ9YA8RxIq8jBffVA6lPa2QvJlzA29MPi3JxpedpLq8HxJEHQYs9lPZ7dsD
	 BS3W3J+26PWDw==
Message-ID: <c622e923-631b-4117-838c-25298aa7d120@kernel.org>
Date: Tue, 26 May 2026 17:48:00 +1000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH v8 mptcp-next 2/9] mptcp: fix retransmission loop when
 csum is enabled
Content-Language: fr
To: Paolo Abeni <pabeni@redhat.com>, mptcp@lists.linux.dev
Cc: Geliang Tang <geliang@kernel.org>, gang.yan@linux.dev
References: <cover.1779485511.git.pabeni@redhat.com>
 <eb3104033a7831b126ad918b7f6e5c06ac74c407.1779485511.git.pabeni@redhat.com>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <eb3104033a7831b126ad918b7f6e5c06ac74c407.1779485511.git.pabeni@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Paolo,

Thank you for this fix!

On 23/05/2026 07:43, Paolo Abeni wrote:
> Sashiko noted that retransmission with csum enabled can actually
> transmit new data, but currently the relevant code does not update
> accordingly snd_nxt.
> 
> The may cause incoming ack drop and an endless retransmission loop.
> 
> Address the issue incrementing snd_nxt as needed.
> 
> Fixes: 4e14867d5e91 ("mptcp: tune re-injections for csum enabled mode")
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> ---
>  net/mptcp/protocol.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index f14572fb1975..4f2b2868031a 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -2867,6 +2867,10 @@ static void __mptcp_retrans(struct sock *sk)
>  	msk->bytes_retrans += len;
>  	dfrag->already_sent = max(dfrag->already_sent, len);
>  
> +	/* With csum enabled retransmission can send new data. */
> +	if (after64(dfrag->already_sent + dfrag->data_seq, msk->snd_nxt))
> +		msk->snd_nxt = dfrag->already_sent + dfrag->data_seq;

Should we use WRITE_ONCE() here, similar to other places where it is
updated?

If yes, I can do the modification when applying the patch.

Apart from that:

Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>

> +
>  reset_timer:
>  	mptcp_check_and_set_pending(sk);
>  

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

