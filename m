Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.219
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793671654;
	b=huw5rk7SsVH/AfvcTHhkfP7qjxNQnUC3Cnt6sS8j8C+Agx2rsZ+Lf79m2zu3AnfjwMN+
	 dnPyY90OMffLxD79gZhmalUaiFqxWAxXDOsjHEtO4oFp6HSaU8ISJQ8SHunsm7s7Cw/EO
	 ebhTGuS2S2bnLLbiPy5wadyJANcw5YLfCXELoYCK56+qQoty1V6ESOk3mFKyZ6hWgMEs2
	 Zg9zyaZNtNi1kwD581VnPYvUUuNN9rvQ9HJgCSKutR+6poPuACCC5v3yeqdpzgl4o2Kej
	 86N8MrRXzrrRf7gJ1w7cUtjsCWG4YZDsc8m3ilEifGjalqf7/45MMepmlDFG2zoR1sw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793671654;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=P7k5cnC+t2I3C26m1w5k2WjBKMTtjaHYcmzM++bUry0=;
	b=v32yLePTieIOiUpBk/FfJHD3GuorIWnYUDlr9u3JM+Fo1L/R6uW2jY4llzxfY0WuZ+MO
	 6sgGz/fLwkujQnHzOlSHTzsEY4NUty0A6H5PVSS9dFXxgB9d+FdvjpYOefdQCYuHRuSK/
	 hO3YwUIXXuu6uYe8jo/68icYOK9Gb8OZGZ4oBb1/ttRqekkHGnKumjU0tp05ETo3BgHmM
	 /LChlpXGeB3tH1NsT+bzx4CUYDuMt8VuU/oVR5vUwLQZmakYmu2Ri9fWgdLh3AH2xLrAy
	 S+qaxn/0L0qNNUaeXlWDmqH46Ay4tGhPgejgHx87jrR/E5hSC4zYeiL9cQWUc5fzTiA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=CoccJxjV;
	arc=none smtp.remote-ip=95.215.58.219
Received: from mta1.migadu.com (out-219.mta1.migadu.com [95.215.58.219])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F335606A32C
	for <mptcp@lists.linux.dev>; Tue,  3 Nov 2026 02:07:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6F335606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=CoccJxjV
X-Envelope-To: mptcp@lists.linux.dev
DKIM-Signature: a=rsa-sha256; bh=0seUYfdCS8VwnvHk3Qjkg69KJT02ZhaNs/EnHfYw7T8=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793671651; v=1; x=1794276451;
 b=CoccJxjVlkU46zufn5h61S55XxHyIcc3pbaHjWPdt3Owf/7IGLLXfMbAVGNiNdF48CNErGBQ
 u/WfmkWu2HwDnO5os8Kjo3sH2Tml2dNojjicRFtKf4s32BT/+xDQJ/n6Am1ExqRyWJnQHmOGzhd
 zZqJVkBMabuo9gEHxWeAbkYQ=
X-Envelope-To: mptcp@lists.linux.dev
Received: by smtp.migadu.com with ESMTPS id 572a8b41bc4b2687;
	Tue, 03 Nov 2026 02:07:31 +0000
X-Mizu-Trace-ID: 572a8b41bc4b2687
X-Migadu-Flow: FLOW_OUT
Message-ID: <57fa7d2f-7cb2-4fa3-92cb-50bcd8ed576d@linux.dev>
Date: Tue, 3 Nov 2026 10:07:18 +0800
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
Subject: Re: [PATCH bpf v2 13/15] bpf, sockmap: Check that the redirected
 message is the cork
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>, bpf@vger.kernel.org,
 netdev@vger.kernel.org
Cc: daniel@iogearbox.net, andrii@kernel.org, eddyz87@gmail.com,
 memxor@gmail.com, john.fastabend@gmail.com, jakub@cloudflare.com,
 davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, kuniyu@google.com, willemb@google.com,
 matttbe@kernel.org, mptcp@lists.linux.dev, mason@kernel.org,
 josef@toxicpanda.com
References: <20261102072112.4160195-1-alexei.starovoitov@gmail.com>
 <20261102072112.4160195-14-alexei.starovoitov@gmail.com>
From: Jiayuan Chen <jiayuan.chen@linux.dev>
In-Reply-To: <20261102072112.4160195-14-alexei.starovoitov@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


On 11/2/26 3:21 PM, Alexei Starovoitov wrote:
> From: Alexei Starovoitov <ast@kernel.org>
>
> In tcp_bpf_send_verdict(), msg is psock->cork or the sk_msg on the stack of
> tcp_bpf_sendmsg(). If psock->cork is not NULL, the SK_REDIRECT branch sets
> it to NULL before release_sock() and calls kfree(msg) after the redirect.
> Thus the branch assumes that a cork is msg.
>
> This is not true after release_sock(), because a second sender on the same
> socket can make a cork. The first sender can run the branch again, and then
> psock->cork is not its msg. Nobody sends or frees the cork of the second
> sender. kfree() gets the sk_msg on the stack, and the kernel crashes.
>
> Compare psock->cork with msg. Nothing changes for one sender, because
> psock->cork is then NULL or msg. The other branches do not change, and a
> cork is still not safe for two senders on one socket.


I think I should try to serialize senders on the same socket. The underlying risk here probably goes beyond this series.


>
> Fixes: 4f738adba30a ("bpf: create tcp_bpf_ulp allowing BPF to monitor socket TX/RX data")
> Signed-off-by: Alexei Starovoitov <ast@kernel.org>


Reviewed-by: Jiayuan Chen <jiayuan.chen@linux.dev>


> ---
>  net/ipv4/tcp_bpf.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/net/ipv4/tcp_bpf.c b/net/ipv4/tcp_bpf.c
> index d8e29b09818c..b1071b0960cf 100644
> --- a/net/ipv4/tcp_bpf.c
> +++ b/net/ipv4/tcp_bpf.c
> @@ -517,7 +517,11 @@ static int tcp_bpf_send_verdict(struct sock *sk, struct sk_psock *psock,
>  			psock->eval = __SK_NONE;
>  			psock->sk_redir = NULL;
>  		}
> -		if (psock->cork) {
> +		/*
> +		 * Another thread can make a cork while this one sends msg
> +		 * without the socket lock. Leave that cork alone.
> +		 */
> +		if (psock->cork == msg) {
>  			cork = true;
>  			psock->cork = NULL;
>  		}
