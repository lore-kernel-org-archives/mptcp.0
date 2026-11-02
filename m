Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.110
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793609157;
	b=yT8eAPTMJ1d2Du4kwXSPuoZpG9FBfH6hoJvJArQvoqKt0lJQajI5Me6xlkWA+2Vt+Gux
	 xG4JCJHP1cb8wmrhBDMQW/g7UXl1TTbbUyRl5uVefYpBDhcZRWqUKXEXtG6f2Se/UV81O
	 WH4sLRoq82vzhgue2rpDUelyG0DPcgOMIRbqHXmJWt9ApkYPfsijIQSGmd5xPWYaOmU37
	 YGYy9gJTIycx4g/mrtV+xX3Oal2lY0G40CPrqXnGPyK2ujtgBS4slJHZBU1bLTwv0GI2j
	 qA3aAmwmKkg83s5FAP7iXH4xh27WJ32deQNdVK7VU5HOdoDMtMUNRN53+RI5hKT0Pcg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793609157;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=jx4qlQkPxS7DAszsO8FykZUqEui3HDCIXlBMJeUNy0Y=;
	b=ka6R9vJL9KkXdcemsporz4vtiRYIEXuTKmNg7yAYUgxMyr5xopnFriBWA3sXm+W0xAhv
	 BbWkkJjRlg5t8KA1bDTekJFhuOrq2we9YQn+/Djf9czQW1PAgtHzrN4Y+yix2vAOzxwRc
	 XY+e9s+4Xfvq2WaIpq/pH7bu1WAVSUT0a5fLu3LiM4T15cG5J1Z4yO60HJcer85NB25mK
	 5EOQm7mXntUR0l8be3dlC+LPgsw3v0Xa0eo3dq0pubaA/+gb7J4uG3t0L5vrVQY1IgFyO
	 BXMgsm7gdeTD4nXyGCN1f9ZMkMWMABBVjHtcneNKu0Fu06DuD3careh/+53ILJQmSwA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=cjHN8xey;
	arc=none smtp.remote-ip=91.218.175.110
Received: from mta0.migadu.com (out-110.mta0.migadu.com [91.218.175.110])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9868606A329
	for <mptcp@lists.linux.dev>; Mon,  2 Nov 2026 08:45:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C9868606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=cjHN8xey
X-Envelope-To: mptcp@lists.linux.dev
DKIM-Signature: a=rsa-sha256; bh=xxE5inaPrVu+F+7VswAWI/5YBh6Q8RuY05CNRqyPUa4=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793609154; v=1; x=1794213954;
 b=cjHN8xeysAL5ALPxZMu2qazghWYfyhOK3oO2LxRICrgbvHbJaHbAmgL4XyWaCJGsdL+Tp2vw
 NPjjSBXOjlHy6J1rzNqwgbVnEmiwkGBgcI84XPFJTyIe+e5rRR/mXCJtGOFo3arFF94Fw1JW969
 1LAoqiHbd/H4CLbp7oH8zysY=
X-Envelope-To: mptcp@lists.linux.dev
Received: by smtp.migadu.com with ESMTPS id 2b7e906160719b9f;
	Mon, 02 Nov 2026 08:45:53 +0000
X-Mizu-Trace-ID: 2b7e906160719b9f
X-Migadu-Flow: FLOW_OUT
Message-ID: <bc3366e4-3429-4826-b04b-ca1ff20b9686@linux.dev>
Date: Mon, 2 Nov 2026 16:45:44 +0800
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
Subject: Re: [PATCH bpf v2 02/15] bpf, sockmap: Don't let an SK_DROP verdict
 stick
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>, bpf@vger.kernel.org,
 netdev@vger.kernel.org
Cc: daniel@iogearbox.net, andrii@kernel.org, eddyz87@gmail.com,
 memxor@gmail.com, john.fastabend@gmail.com, jakub@cloudflare.com,
 davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, kuniyu@google.com, willemb@google.com,
 matttbe@kernel.org, mptcp@lists.linux.dev, mason@kernel.org,
 josef@toxicpanda.com
References: <20261102072112.4160195-1-alexei.starovoitov@gmail.com>
 <20261102072112.4160195-3-alexei.starovoitov@gmail.com>
From: Jiayuan Chen <jiayuan.chen@linux.dev>
In-Reply-To: <20261102072112.4160195-3-alexei.starovoitov@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


On 11/2/26 3:20 PM, Alexei Starovoitov wrote:
> From: Josef Bacik <josef@toxicpanda.com>
>
> The verdict of an sk_msg prog is valid for one message, or for the bytes
> that bpf_msg_apply_bytes() requests. These bytes can come from many
> sendmsg() calls. Thus tcp_bpf_send_verdict() keeps the verdict in
> psock->eval and runs the prog only when psock->eval is __SK_NONE. The code
> that resets psock->eval is after the switch statement, but the __SK_DROP
> branch returns before that code. Then sendmsg() drops all subsequent
> messages with -EACCES and does not run the prog.
>
> Reset psock->eval when apply_bytes is 0, as the __SK_REDIRECT branch does.
>
> Fixes: 4f738adba30a ("bpf: create tcp_bpf_ulp allowing BPF to monitor socket TX/RX data")
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> Signed-off-by: Alexei Starovoitov <ast@kernel.org>


Reviewed-by: Jiayuan Chen <jiayuan.chen@linux.dev>


> ---
>  net/ipv4/tcp_bpf.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/net/ipv4/tcp_bpf.c b/net/ipv4/tcp_bpf.c
> index 8cf63a9e7fed..d90bcc911b36 100644
> --- a/net/ipv4/tcp_bpf.c
> +++ b/net/ipv4/tcp_bpf.c
> @@ -509,6 +509,9 @@ static int tcp_bpf_send_verdict(struct sock *sk, struct sk_psock *psock,
>  	default:
>  		sk_msg_free(sk, msg);
>  		sk_msg_apply_bytes(psock, tosend);
> +		/* The verdict holds for apply_bytes, not for ever */
> +		if (!psock->apply_bytes)
> +			psock->eval = __SK_NONE;
>  		*copied -= (tosend + delta);
>  		return -EACCES;
>  	}
