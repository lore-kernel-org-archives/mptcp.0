Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.56
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793618368;
	b=eJm8rsgetcFO1SAHWEoIVODggXTvBiISOxtj5sMmFEPR5hgh6/2+F3C8X7jOMpKt/jXq
	 wXMEyv1y3XgeoRpUUflOCZWGK23Z9Cz4fAN89LKuARx+Ozyb80/ZmVq0tlUbgWWgynvQA
	 boHUn0kF4aiGctaqBXTzwDvcNMbqI8yA5Kb7ACOuIW7oqqdc+qqXRHEH0mYfKGA0YhFlU
	 tafSX62mm7ZLkCjwU/L6zXwkUxkZCvx6x++c+qZMfl1XRuqUriuprRJOvLmTGyOWqMhOG
	 gtwJxVy9oGSGQ5wUSy8wgbFYWDxpPPUCFGXzXssxjzd8x1a2C77hYxCdYjZIwEygrog==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793618368;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=dRXNIv+DjYJ9+xKJw7sbi+h+wlCEfvAUG5KDSY1I8Bs=;
	b=WckEuQDJOWklw9iju/pCSyV+tY7AK0iiKNAvx/5UpNK+vl2bmPu+a18Ynuemmg3GDHtV
	 wmP4QzSzA2FWtwFNlslpikaMX8pFG0q11ylYMlMOh36AebLbTGvkM9IfW4fft89tre9UA
	 9QQTev+osPJHEBR5Uu3c1Tfu/y6CNysXp1lqnodip5sHWLzh28QJ5maNVIrOSNiYXxqmI
	 8I3VzwG1Vbj+u1PCVWcFQRSNIkLBXlsc/hkuErCLHjzOcwK3tY6aGCjA8y84dHEGcg25j
	 GiRdAl681JvNTJOEM4JgW6P21qA12htBQdJCWlVu2Bn9YDAk2z2kBR1SbK9+P2wb3oQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=IxGU5tNT;
	arc=none smtp.remote-ip=95.215.58.56
Received: from mta1.migadu.com (out-56.mta1.migadu.com [95.215.58.56])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08E3F606A326
	for <mptcp@lists.linux.dev>; Mon,  2 Nov 2026 11:19:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 08E3F606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=IxGU5tNT
X-Envelope-To: mptcp@lists.linux.dev
DKIM-Signature: a=rsa-sha256; bh=kdrMq5KnZifKZQNMAwZlFHNok5RGWVsm3UzqOukQXj4=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793618359; v=1; x=1794223159;
 b=IxGU5tNTW00mxD1061NSfytTWBcJgf2THMlRUiwpR0NtaICUnmDdp/LaCuJ2J15yN6mAwZ+I
 takgOxP7DoJJQU4mc+WQ9EPYCaOaWaETfCWG4k9WB+ZlooddlsE4eqM9Kaae8V7IqMyO0VNgYN1
 qsXQvE5rLy1rax1Y9mK1Ev/A=
X-Envelope-To: mptcp@lists.linux.dev
Received: by smtp.migadu.com with ESMTPS id 4f07de2689d355c0;
	Mon, 02 Nov 2026 11:19:18 +0000
X-Mizu-Trace-ID: 4f07de2689d355c0
X-Migadu-Flow: FLOW_OUT
Message-ID: <f846ce70-58b7-4932-a1ef-35ffb747387f@linux.dev>
Date: Mon, 2 Nov 2026 19:19:09 +0800
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
Subject: Re: [PATCH bpf v2 04/15] bpf, sockmap: Subtract all dropped bytes
 from the return value
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>, bpf@vger.kernel.org,
 netdev@vger.kernel.org
Cc: daniel@iogearbox.net, andrii@kernel.org, eddyz87@gmail.com,
 memxor@gmail.com, john.fastabend@gmail.com, jakub@cloudflare.com,
 davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, kuniyu@google.com, willemb@google.com,
 matttbe@kernel.org, mptcp@lists.linux.dev, mason@kernel.org,
 josef@toxicpanda.com
References: <20261102072112.4160195-1-alexei.starovoitov@gmail.com>
 <20261102072112.4160195-5-alexei.starovoitov@gmail.com>
From: Jiayuan Chen <jiayuan.chen@linux.dev>
In-Reply-To: <20261102072112.4160195-5-alexei.starovoitov@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


On 11/2/26 3:21 PM, Alexei Starovoitov wrote:
> From: Alexei Starovoitov <ast@kernel.org>
>
> When an sk_msg prog returns SK_DROP, tcp_bpf_send_verdict() frees the full
> message. It then subtracts tosend bytes from *copied, the return value of
> sendmsg(). But tosend is the number of bytes that the verdict applies to.
> After bpf_msg_apply_bytes() tosend can be less than the message size. Then
> sendmsg() reports dropped bytes as sent.
>
> Subtract the number of bytes that sk_msg_free() frees. After an error the
> SK_PASS branch already does this. The SK_REDIRECT branch does the same if
> the message is not the cork. Nothing changes when tosend is equal to the
> message size. Otherwise sendmsg() now returns -EACCES if it sends nothing.
>
> Fixes: ca70b8baf2bd ("tcp_bpf: Fix the sk_mem_uncharge logic in tcp_bpf_sendmsg")
> Signed-off-by: Alexei Starovoitov <ast@kernel.org>


Reviewed-by: Jiayuan Chen <jiayuan.chen@linux.dev>


> ---
>  net/ipv4/tcp_bpf.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/net/ipv4/tcp_bpf.c b/net/ipv4/tcp_bpf.c
> index b016aa419fb2..36d1bf46353a 100644
> --- a/net/ipv4/tcp_bpf.c
> +++ b/net/ipv4/tcp_bpf.c
> @@ -521,12 +521,12 @@ static int tcp_bpf_send_verdict(struct sock *sk, struct sk_psock *psock,
>  		break;
>  	case __SK_DROP:
>  	default:
> -		sk_msg_free(sk, msg);
> +		/* All of it is thrown away, not only tosend bytes */
> +		*copied -= sk_msg_free(sk, msg) + delta;
>  		sk_msg_apply_bytes(psock, tosend);
>  		/* The verdict holds for apply_bytes, not for ever */
>  		if (!psock->apply_bytes)
>  			psock->eval = __SK_NONE;
> -		*copied -= (tosend + delta);
>  		return -EACCES;
>  	}
>  
