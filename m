Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15B0B1DD9AC
	for <mptcp@lists.linux.dev>; Wed, 30 Apr 2025 09:46:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746006368; cv=none; b=G4ESJN4q+79fYrJC4Lgg3DTEKImACGpLPYZno9wGNGNj7GAwtXydzy6kEA0Gia04vFWJZfpYjazk8Yi/3EmgWRC5gbuAlJUHRNhiCu9LhMssPO6BUdvUqmjstdEXzi90dtlb/Pja48iUezvxnh5kI2NHvD79s31KeWoc3DqityY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746006368; c=relaxed/simple;
	bh=wUCeIJDKb1Wvc0kyzDSVGYHhd8lzNrIm3PYeGIjig6s=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=qurKgiG4QnoF/Ep/UrvazZNDnrr+CvUuNu9se+h2szILkO0KKO+gr8nsskHKrdZRtrb8VCkN0jFGHd4dSJYY3fojBfxxzhwRB0ZtJ7on/a90LbHPJwBlFbi/N7yfhylTzQ2WheN+JMzR8GgbGuzbh69h7fgkBhYbyDyI0rYH5Yw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bVK6L+0U; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bVK6L+0U"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E44EAC4CEE9;
	Wed, 30 Apr 2025 09:46:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746006367;
	bh=wUCeIJDKb1Wvc0kyzDSVGYHhd8lzNrIm3PYeGIjig6s=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=bVK6L+0UAaZoGczoaVwJ5VEjVilimg1yJokE9PJtC4bxkAK3clzQKIcxqWLAZDr4H
	 Sqtaw07/lBU1XF0+jxfHW5d6oLzyGFJwQy37PLCZqzsGssVNZ8zqtOSSPhViuc1DkA
	 lGX59cjofRLUvmwSpz4DvsQZusLeHenZ1tIq+C4KsGZsU/lkKCsL0NhW0W2CBCL9a3
	 CEjO0x9EtjqHUOBMqX+BeOMAKx9O8YdTL4myQI/EbkaFySVL80sAlOAd5LAhjiF1AV
	 MBNTpcad1n9RXSSSa7nbaDdjrRzhd1j5mslP6PMoQ3+TQoUfT7Qv4JA/HI+QwU1t7t
	 sW9l3KHN/ZZtA==
Message-ID: <51744839-e4a2-4bb0-8f54-5f6ad3db6925@kernel.org>
Date: Wed, 30 Apr 2025 11:46:05 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH mptcp-next] sock: add sock_krfree_s helper
Content-Language: en-GB, fr-BE
To: Geliang Tang <geliang@kernel.org>, mptcp@lists.linux.dev
References: <ffe72ff201ea72938b136eb37ea3e0777ae890f4.1746004135.git.geliang@kernel.org>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <ffe72ff201ea72938b136eb37ea3e0777ae890f4.1746004135.git.geliang@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Geliang,

On 30/04/2025 11:09, Geliang Tang wrote:
> This patch adds the rcu version of sock_kfree_s() helper, named
> sock_krfree_s(), to free the memory using kfree_rcu_mightsleep()
> and adjust the socket's option memory buffer.
> 
> This new helper is first used in MPTCP.
> 
> Signed-off-by: Geliang Tang <geliang@kernel.org>
> ---
>  include/net/sock.h       |  1 +
>  net/core/sock.c          | 14 +++++++++++---
>  net/mptcp/pm_userspace.c |  3 +--
>  3 files changed, 13 insertions(+), 5 deletions(-)
> 
> diff --git a/include/net/sock.h b/include/net/sock.h
> index e223102337c7..94f72f5c8754 100644
> --- a/include/net/sock.h
> +++ b/include/net/sock.h
> @@ -1836,6 +1836,7 @@ void *sock_kmemdup(struct sock *sk, const void *src,
>  		   int size, gfp_t priority);
>  void sock_kfree_s(struct sock *sk, void *mem, int size);
>  void sock_kzfree_s(struct sock *sk, void *mem, int size);
> +void sock_krfree_s(struct sock *sk, void *mem, int size);
>  void sk_send_sigurg(struct sock *sk);
>  
>  static inline void sock_replace_proto(struct sock *sk, struct proto *proto)
> diff --git a/net/core/sock.c b/net/core/sock.c
> index b64df2463300..f9ee0b44ab2a 100644
> --- a/net/core/sock.c
> +++ b/net/core/sock.c
> @@ -2862,12 +2862,14 @@ EXPORT_SYMBOL(sock_kmemdup);
>   * condition entirely.
>   */
>  static inline void __sock_kfree_s(struct sock *sk, void *mem, int size,
> -				  const bool nullify)
> +				  const bool nullify, const bool rcu)
>  {
>  	if (WARN_ON_ONCE(!mem))
>  		return;
>  	if (nullify)
>  		kfree_sensitive(mem);
> +	else if (rcu)
> +		kfree_rcu_mightsleep(mem);

I'm not sure about that: in some cases, kfree_rcu() might be called.
kfree_rcu_mightsleep() is more an exception to me, I think. Also, it
looks like there are many other places where the free and atomic_sub()
is done "manually", that's not specific to MPTCP.

I don't know what Mat thinks about that, but I don't think this is
needed (or it should replace some code in different places in the kernel).

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

