Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.139
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793619643;
	b=YcQnovXoM//WYTOVxBZwMywBDjufrksvfLgUu8VoQ/EuwyWgoumaMCL0ewRli+9qlyv7
	 qSZJDRZ3d9Rz/teyq4Ii9BV4KUFGBnRT6m6gi6DBxsxEpl/MhFa46h+CCQp/Zuei0qOg0
	 u9wyb1HNVGrlTSb3SHfYuHetAvPx0PGpGp3Th1n7NHran7tpEnEalKn1/VRraqwbg0eYy
	 YYETwb/j2ix3IW+8mlnaR2yf7ZtimWd2fJvLTbRs6WnZavIVYyxF2qguqGcviMyCT+V35
	 A8eKv+CjmXw9IGVb/PP/6jQ8lRtBdnMA0rqa1v8bWtQErIV9gsWhbNnwloUl4rZAmNA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793619643;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=nZUpp2hJQkWCrqySp0A90JTwPZ/iUSnZg01sx3a4r5Q=;
	b=MtGndmQJVSc8NEk9lOZtG4J+hsBmfn/H3MzNY6jjoiqIQaJGQbaPzUdiyE+yzR2x+ERr
	 7KcsHVUSdP4f8Wmb4Aw0xXMQ1aZtP7SA0srEj6bECDip40ySy5l8yFiQ0fqHfplIivN75
	 Tf8OgYsWzN83rKZKyk4Sm6Vmx38y9Phq2BRs8o+uSKHyH94gwH+GYrW5aLzh8GmgvQWuj
	 GQzfZ//rivYqFMHJmXctd0zpb3kQCiI/b7dAC8RVt8iOE0naZl5p24f2BVniy1JzM5p8P
	 lzQVui4NN9rxXc4JJlg7FCSyMrSehtKlHwkQIaUNptvdqxHaHAwI9G32LRHdfcFxWBA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=ZmbZTYqG;
	arc=none smtp.remote-ip=91.218.175.139
Received: from mta0.migadu.com (out-139.mta0.migadu.com [91.218.175.139])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 357A360A2614
	for <mptcp@lists.linux.dev>; Mon,  2 Nov 2026 11:40:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 357A360A2614
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=ZmbZTYqG
X-Envelope-To: mptcp@lists.linux.dev
DKIM-Signature: a=rsa-sha256; bh=z1ZM5tFFhllBjxmb1sXO2yzQnSQGhBe8JrM4BxDb5r8=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793619640; v=1; x=1794224440;
 b=ZmbZTYqGgiezKBHWmMYpxm5eQy08lOONKT3n5wHMV6Lh5EsOSI1izpt8YEGKsp8KlzfsW9y5
 dagOtHvc8jcLHF3CRMucr4qCGK00zvRZEP1+PdgRz6uZJGn0ju15QRPq9KEskUcXN+MY0ldNeJ9
 q4JAf/iAa1TqFCI8Ev5xuMiw=
X-Envelope-To: mptcp@lists.linux.dev
Received: by smtp.migadu.com with ESMTPS id 1443bbc0a505c443;
	Mon, 02 Nov 2026 11:40:33 +0000
X-Mizu-Trace-ID: 1443bbc0a505c443
X-Migadu-Flow: FLOW_OUT
Message-ID: <9d399d69-1dfd-4848-bd55-be099b6dd792@linux.dev>
Date: Mon, 2 Nov 2026 19:40:22 +0800
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Post: <mailto:mptcp@lists.linux.dev>
List-Help: <mailto:mptcp+help@lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
List-Owner: <mailto:mptcp+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf v2 05/15] bpf, sockmap: Clear the resume state of a
 stopped psock
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>, bpf@vger.kernel.org,
 netdev@vger.kernel.org
Cc: daniel@iogearbox.net, andrii@kernel.org, eddyz87@gmail.com,
 memxor@gmail.com, john.fastabend@gmail.com, jakub@cloudflare.com,
 davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, kuniyu@google.com, willemb@google.com,
 matttbe@kernel.org, mptcp@lists.linux.dev, mason@kernel.org,
 josef@toxicpanda.com
References: <20261102072112.4160195-1-alexei.starovoitov@gmail.com>
 <20261102072112.4160195-6-alexei.starovoitov@gmail.com>
From: Jiayuan Chen <jiayuan.chen@linux.dev>
In-Reply-To: <20261102072112.4160195-6-alexei.starovoitov@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


On 11/2/26 3:21 PM, Alexei Starovoitov wrote:
> From: Josef Bacik <josef@toxicpanda.com>
>
> sk_psock_backlog() passes the skbs of psock->ingress_skb to the socket of
> the psock. When the socket has no room, the function saves the length and
> offset of the remaining data in psock->work_state. A later run continues at
> this offset and clears the state when the skb is complete.
>
> sk_psock_skb_state() saves and clears the state, but only while
> SK_PSOCK_TX_ENABLED is set. sk_psock_backlog() does not test this flag for
> each skb. If the socket closes during the loop, sk_psock_stop() clears the
> flag. The loop continues, but the state of the completed skb stays. The
> loop uses this state for all subsequent skbs and sends only part of their
> data. A closing socket may lose the end of a stream, but not the middle.
>
> The state belongs to the skb at the head of ingress_skb. Always clear the
> state when this skb is complete. A stopped psock still saves no new state.
>
> Fixes: 3b4f14b79428 ("bpf, sockmap: fix duplicated data transmission")
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> Signed-off-by: Alexei Starovoitov <ast@kernel.org>
> ---
>  net/core/skmsg.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/net/core/skmsg.c b/net/core/skmsg.c
> index f03519468ad1..a5d498982848 100644
> --- a/net/core/skmsg.c
> +++ b/net/core/skmsg.c
> @@ -664,7 +664,8 @@ static void sk_psock_skb_state(struct sk_psock *psock,
>  			       int len, int off)
>  {
>  	spin_lock_bh(&psock->ingress_lock);
> -	if (sk_psock_test_state(psock, SK_PSOCK_TX_ENABLED)) {
> +	/* No new state once the psock is stopped, but never keep an old one */
> +	if (!len || sk_psock_test_state(psock, SK_PSOCK_TX_ENABLED)) {
>  		state->len = len;
>  		state->off = off;
>  	}


Reviewed-by: Jiayuan Chen <jiayuan.chen@linux.dev>


The 'state' should be clear unconditionally.


