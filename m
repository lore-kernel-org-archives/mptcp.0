Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E70782DC765
	for <mptcp@lists.linux.dev>; Tue, 23 Dec 2025 16:39:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766507983; cv=none; b=QPeX9s3UPIMiayF6PDNWYpWiL6txIAz9eqF1HDtOQ1XluYp7FU4F7Q73lUPrZzPQKDHA9PsM4S/PSisPuYA/shR/EcuzJCAFf59c1texzP/ki2huL9NLATjrbNObgf1b+jJBZaIHWgiR8y90ZlzSxptvZ+BKhnnfOrJghhu2D94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766507983; c=relaxed/simple;
	bh=eUSWSfE1/jGG9MU1ZMFGTecEBfRjULv8OsMYKYOrdV0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XGSIwtBxCmogjPIYYTGRge+4TtH2lb+uIrjCNjAemmZBgtyi9QhbUK4k0u3tmDXBRncLLLeXrc0wjhW/SmvzxhNhZ56dHVBMzmG7/cOWtrj4XWDDdY5asEdFgPhqR6N/1PQrnILE8INvsJosNwHfk2almINYmwWkoGLIUcf+BX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Chdrzx+l; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Chdrzx+l"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CDB60C113D0;
	Tue, 23 Dec 2025 16:39:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766507982;
	bh=eUSWSfE1/jGG9MU1ZMFGTecEBfRjULv8OsMYKYOrdV0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Chdrzx+lGQZW768tqpuI6SYioFWqBroZGO+SVepnO9hGuD9z3X38Yxgv77/qx5qaq
	 Xk4adtbzhLAeHy2DixxsuGaui+a0NsSMRhi31DltqehPa5F2NkrWM8Qeb+7ZmQpefQ
	 apeQKBEXIEJLID4AIGmgt4ztrCkxKruSz2Jw8QjhHmSDj6fhaTkd+pmV1XhpFPpf6d
	 AgtNvicwpO7MxeL0WGyz/7DzWiigUNfzaQFLF/lBDx95LgEqqUxzRL7gHwEztbP9F8
	 0A/PqWwh2CTnhQ/QZZrfma2PzOJ/O1TElAqWmT7D72Q0UbtA6hrZdb8t7zr1d4WUhQ
	 pQiBw84jN0JCw==
Message-ID: <228f0676-b4cb-43f5-b4e7-198b06251dc1@kernel.org>
Date: Tue, 23 Dec 2025 17:39:39 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC mptcp-next v5 7/8] mptcp: fix the mptcp_check_readable
Content-Language: en-GB, fr-BE
To: Geliang Tang <geliang@kernel.org>, mptcp@lists.linux.dev
Cc: Gang Yan <yangang@kylinos.cn>
References: <cover.1766372799.git.tanggeliang@kylinos.cn>
 <814297ff30d16e51ac7c126255ef26dbfdc1ca10.1766372799.git.tanggeliang@kylinos.cn>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <814297ff30d16e51ac7c126255ef26dbfdc1ca10.1766372799.git.tanggeliang@kylinos.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Geliang, Gang,

On 22/12/2025 04:15, Geliang Tang wrote:
> From: Gang Yan <yangang@kylinos.cn>
> 
> 'mptcp_check_readble' is corresponding to the 'tcp_stream_is_readable',
> but the later one will call the 'sk_is_readble' ->
> 'prot->sock_is_readable(sk)' -> 'tls_sw_sock_is_readable'.
> 
> If not apply this patch, it will cause an error in 'poll_wait_split'
> test when running tls_test in mptcp mode.

Which error?

It might be better to move this before patch 2 and mention that this is
to aligned with TCP, and will be used in the case of KTLS, because
'prot' will be modified, tls_sw_sock_is_readable is expected to be
called from prot->sock_is_readable(), etc.

> 
> Signed-off-by: Gang Yan <yangang@kylinos.cn>
> ---
>  net/mptcp/protocol.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index bdf53e4b3f7e..8363d89d3a13 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -3260,7 +3260,9 @@ void __mptcp_unaccepted_force_close(struct sock *sk)
>  
>  static __poll_t mptcp_check_readable(struct sock *sk)

Might be good to add a comment to say that it is similar to
tcp_stream_is_readable()

While at it, maybe rename it to mptcp_stream_is_readable() so it is
aligned with TCP?

>  {
> -	return mptcp_epollin_ready(sk) ? EPOLLIN | EPOLLRDNORM : 0;
> +	if (mptcp_epollin_ready(sk))
> +		return true;
> +	return sk_is_readable(sk);
>  }
>  
>  static void mptcp_check_listen_stop(struct sock *sk)
> @@ -4322,7 +4324,8 @@ static __poll_t mptcp_poll(struct file *file, struct socket *sock,
>  		mask |= EPOLLIN | EPOLLRDNORM | EPOLLRDHUP;
>  
>  	if (state != TCP_SYN_SENT && state != TCP_SYN_RECV) {
> -		mask |= mptcp_check_readable(sk);
> +		if (mptcp_check_readable(sk))
> +			mask |= EPOLLIN | EPOLLRDNORM;
>  		if (shutdown & SEND_SHUTDOWN)
>  			mask |= EPOLLOUT | EPOLLWRNORM;
>  		else

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

