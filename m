Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44AD61F5825
	for <mptcp@lists.linux.dev>; Tue,  3 Feb 2026 06:54:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770101661; cv=none; b=JL5GkPtyGHPdeCB+xBBzaw/YlJC45MFzTBzrrJCXvUXMi1RpXAShm++PfX7fe/wJ5eT4xNCoGijnAbKxEOP3synQDeU6HsYWaCvFQktBNYHLFvSpcOdWTaBvWQf/kOlvi+Z720VyJ9WQ2biaxi7P30UAeA3/FqtNZ/1+iPpiBbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770101661; c=relaxed/simple;
	bh=c3T7aABCo/wAHRJCIA9k6Y1yRRGe5wTgmafY84SAGmQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Ip4u2xxvWWHkQ9esIPTB0E2LrqUvyQEh6MUU9MWA8H/MG0y6J7wLNtYnv0GL7pzEyxYLW+B2LJ5jvTYbSa9fqGbm2mgMQ44QLpQqJ9gDt1LMSIOCZ9Qm/nOlmWG3547Cx0zHVU4S+c7TLbQT824iec4GZzijJN3L1eSMfJfMoec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UUn/M3oT; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UUn/M3oT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8294C116D0;
	Tue,  3 Feb 2026 06:54:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770101658;
	bh=c3T7aABCo/wAHRJCIA9k6Y1yRRGe5wTgmafY84SAGmQ=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=UUn/M3oT037lwypjMnEhPKbj97BPNSnOooCg/1lggk78w6lZFkxE9+vdC3dXqiNTw
	 2WuflRc8ZDTQoovHd20IHGWU5KY6BOEXzWJMJkZVq0o6UuPjsIZ6r6h+7dzMaRHLQF
	 QCgvDt/SuQk2tHd6QbRp1gfL7F1oABZ7I/u60yQjZF9zrJMLrp3MFIYTJcI7j9ET0S
	 iwICaTeJLQs8517RzA/SL2earkPkyDYrTCq86p3GaiUu5nYH/UMeB04F6B5Sa6Ejbw
	 qpkd0e0eWJtDzeNEeYo8U4yZJ6DqLkEw3IE9Ausn/aPxAc3K6PfPFHiV1qnZdHts2u
	 bqmetA0WQFCMQ==
Message-ID: <9a2ce3981452685fe178892d0631b289b8d55e01.camel@kernel.org>
Subject: Re: [PATCH mptcp-next v2 2/3] mptcp: allow overridden write_space
 to be invoked
From: Geliang Tang <geliang@kernel.org>
To: Matthieu Baerts <matttbe@kernel.org>, Mat Martineau
 <martineau@kernel.org>,  Paolo Abeni <pabeni@redhat.com>
Cc: Gang Yan <yangang@kylinos.cn>, mptcp@lists.linux.dev
Date: Tue, 03 Feb 2026 14:54:14 +0800
In-Reply-To: <2efc3455052c3a33cad0c8744b171dfc6e7a6d8a.1767504329.git.tanggeliang@kylinos.cn>
References: <cover.1767504329.git.tanggeliang@kylinos.cn>
	 <2efc3455052c3a33cad0c8744b171dfc6e7a6d8a.1767504329.git.tanggeliang@kylinos.cn>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.58.2 (3.58.2-1.fc43) 
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Matt, Mat, Paolo,

On Sun, 2026-01-04 at 13:29 +0800, Geliang Tang wrote:
> From: Geliang Tang <tanggeliang@kylinos.cn>
> 
> psock may override its own sk_write_space functions. This patch
> ensures
> that the overridden sk_write_space can be invoked by MPTCP.
> 
> Note: This patch was initially included in the NVME MPTCP set.

This patch was initially developed to resolve the "timeout" errors
observed in the NVMe MPTCP tests described in [1], because NVMe TCP
overrides its own sk_write_space. During subsequent development, I
discovered that not only NVMe TCP overrides its own sk_write_space, but
KTLS and psock also override it. 

Therefore, this patch is needed in all three series. To reduce
dependencies between these three series, I propose to merge this patch
into the mainline first.

[1]
https://patchwork.kernel.org/project/mptcp/patch/cfdce3d91ca30abcf2ff9b77ecc146ad48f31d07.1762485513.git.tanggeliang@kylinos.cn/

Thanks,
-Geliang

> 
> Suggested-by: Paolo Abeni <pabeni@redhat.com>
> Co-developed-by: Gang Yan <yangang@kylinos.cn>
> Signed-off-by: Gang Yan <yangang@kylinos.cn>
> Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
> ---
>  net/mptcp/protocol.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
> index cd5266099993..f5d4d7d030f2 100644
> --- a/net/mptcp/protocol.h
> +++ b/net/mptcp/protocol.h
> @@ -1014,7 +1014,7 @@ static inline void mptcp_write_space(struct
> sock *sk)
>  	/* pairs with memory barrier in mptcp_poll */
>  	smp_mb();
>  	if (mptcp_stream_memory_free(sk, 1))
> -		sk_stream_write_space(sk);
> +		INDIRECT_CALL_1(sk->sk_write_space,
> sk_stream_write_space, sk);
>  }
>  
>  static inline void __mptcp_sync_sndbuf(struct sock *sk)
