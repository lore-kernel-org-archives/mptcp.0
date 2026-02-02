Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 149DC2D63F6
	for <mptcp@lists.linux.dev>; Mon,  2 Feb 2026 10:07:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770026830; cv=none; b=TecoCpCc9mWP4XGst/y+ejxdOQmlFAyZGFCCdeEkgEKZG3bsOxX8KpP8a1p+uEozAt3A2nFjCRHPDR9ixaAnKgqsGPgb+snZqlSBFD0OjwAIpmvWqaLrj76QN5aNkSW1929ETmtXKZhGtzVJ1jn61pkelpobFnOhOIsvEV6PTf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770026830; c=relaxed/simple;
	bh=s2B6b0lm2+VHiTVOLSKCU++iOQRm1KElrCfxmj+bXvk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EQCid5/DvBJBCqd8CikbisC7vhCzU8JqAJon19gq6tKQTXAmrJnjNXPOTgNLPiAyDXfUHSnJhA6uHDWl1bNNT74XtLf8W+P08HmCSZvnQ+DsxiQibDEmlUAIXNuL5oXTC0wVCCq5PpX575py/Qxb9IjzDYN0D+z2wdvZBra7kds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Wqimp+1Q; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Wqimp+1Q"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D696BC2BC86;
	Mon,  2 Feb 2026 10:07:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770026829;
	bh=s2B6b0lm2+VHiTVOLSKCU++iOQRm1KElrCfxmj+bXvk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Wqimp+1QLTi6fbQgNGga45m6oOQ6y3NrYXAcMYKeTaaEAriZEMdDt10fiyc+Df7Wo
	 y07aWwEomMRcU1lVSjZi3ku3qJoHDx45CicGt/Eatx1FbKem4N0a7LWTyDWlIwKK3D
	 WR5zuhbkIVt6Ft7VO34f9PToyRwrglWZR/jMmK5Ad6kKRIbJLGCk0eQVMhD7pZXKYP
	 EAK1uJ4FHu16aHGUk2cid/zjSfWJ8nkbxdif4ubnrAAk/Us3QLSf/nN1JAMp5lQ1Ov
	 y7EB1rpN33yjulG3Xn2A4FbJW9RRvMBCzEOlEfAal7c7n4ZZtgkXE49xPNg6qEhqX8
	 xPAeS3jxhz5CQ==
Message-ID: <5866364b-87b9-4abd-9eed-5437e6c56ffb@kernel.org>
Date: Mon, 2 Feb 2026 11:07:06 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH mptcp-next 2/3] mptcp: implement .splice_eof
Content-Language: en-GB, fr-BE
To: Geliang Tang <geliang@kernel.org>, mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
References: <cover.1770023932.git.tanggeliang@kylinos.cn>
 <9e3dddfc65f24c1a11e5f0353b497f1d4f1c6f82.1770023932.git.tanggeliang@kylinos.cn>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <9e3dddfc65f24c1a11e5f0353b497f1d4f1c6f82.1770023932.git.tanggeliang@kylinos.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Geliang,

Thank you for looking at that!

On 02/02/2026 10:21, Geliang Tang wrote:
> From: Geliang Tang <tanggeliang@kylinos.cn>
> 
> This patch implements the .splice_eof interface for MPTCP, namely
> mptcp_splice_eof(), which sequentially calls do_tcp_splice_eof() for
> each subflow.

Can you please explain what this hook is supposed to do / used for please?
And also why the solution is to call do_tcp_splice_eof() on each subflow?

Also, I'm a bit confused: why is this needed? Does it fix something or
is it a new feature or an optimisation?

> Suggested-by: Matthieu Baerts <matttbe@kernel.org>
> Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
> ---
>  net/mptcp/protocol.c | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
> 
> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index c88882062c40..5635d196cb9f 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -4018,6 +4018,20 @@ static int mptcp_connect(struct sock *sk, struct sockaddr_unsized *uaddr,
>  	return 0;
>  }
>  
> +static void mptcp_splice_eof(struct socket *sock)
> +{
> +	struct mptcp_subflow_context *subflow;
> +	struct sock *sk = sock->sk, *ssk;
> +
> +	lock_sock(sk);
> +	mptcp_for_each_subflow(mptcp_sk(sk), subflow) {
> +		ssk = mptcp_subflow_tcp_sock(subflow);
> +
> +		do_tcp_splice_eof(ssk);

Is it fine to call this on closed subflows? e.g. if the initial subflow
has been closed. (I didn't check, maybe that's OK)

> +	}
> +	release_sock(sk);
> +}
> +
>  static struct proto mptcp_prot = {
>  	.name		= "MPTCP",
>  	.owner		= THIS_MODULE,
> @@ -4049,6 +4063,7 @@ static struct proto mptcp_prot = {
>  	.obj_size	= sizeof(struct mptcp_sock),
>  	.slab_flags	= SLAB_TYPESAFE_BY_RCU,
>  	.no_autobind	= true,
> +	.splice_eof	= mptcp_splice_eof,
>  };
>  
>  static int mptcp_bind(struct socket *sock, struct sockaddr_unsized *uaddr, int addr_len)
> @@ -4540,6 +4555,7 @@ static const struct proto_ops mptcp_stream_ops = {
>  	.set_rcvlowat	   = mptcp_set_rcvlowat,
>  	.read_sock	   = mptcp_read_sock,
>  	.splice_read	   = mptcp_splice_read,
> +	.splice_eof	   = inet_splice_eof,

Is this line required? Will it not call inet_splice_eof() by default? (I
didn't check)

>  };
>  
>  static struct inet_protosw mptcp_protosw = {

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

