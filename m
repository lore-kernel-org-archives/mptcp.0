Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 244E5139D0A
	for <mptcp@lists.linux.dev>; Sun,  3 Aug 2025 12:01:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754222512; cv=none; b=qSl3fatfHhfk8WZK3SOPJtMonJUjWBGwqemBBAlXE6TpQSSGxt7bFZQtudr7V1WL9CYE+TfU/lhQ99cVp+QQiOyTAzwsXu4l2EWHY1H5nQ3CD6lE5zeTphnDmHSlq8WTslmvnPQPynAex4z0VGm5JmknDCVYxgQGJBHtmGc320w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754222512; c=relaxed/simple;
	bh=KvNoZC4cS0wqyX085TPO3Yh/hxsVSiDBF2VT0TZPwnA=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=YuYMT1TUhRVcdjfgOS9fqdPHEx8jFJVuqhPwiNXEhX+Yqloe1+OmfLl+FjCU0MCKPeqIqPDfKImYqw7AoKUwDGlMXhWRC5BkkCOJb1cuFJEDTk6JwJgZmsC75lNAIrWb/bcf8SM1/9yThLkL6KLZNWI3VBDFziyb0DhJEu4u+Bk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rCIG7Lm/; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rCIG7Lm/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F197C4CEEB;
	Sun,  3 Aug 2025 12:01:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754222511;
	bh=KvNoZC4cS0wqyX085TPO3Yh/hxsVSiDBF2VT0TZPwnA=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=rCIG7Lm/MbQQYki9/6WHl5dYQu8F7dxO91SdwP48GjtV5lNA6qBdEm/JZQ/mbF8kk
	 yOAt0e3V2FkLxheJu+Jw2AxzA8XoXdYHKtWGaVSgrcUiA64aFA7zq4GiBbelmzu8l2
	 gtYLMz9YXKN/S5oTNm+iNgyR+nl99cwbBgvVmUC+nNz4BRjgLwnR/d4wf2wJCewlWL
	 PymYSdzCZ6e4n/pCgSG1aJPxTxga46HNBAgIfGTNV6XOrgUH7TtsGDAJlTr+N/NVsy
	 rOBoHJmprg+fRt48Y8c6C9tlBHQzKHSlleM/ZBEKBRquVy1EGe6mE59K8+FfK7szuC
	 6/gBBlmBXLupg==
Message-ID: <f15385c8-cbec-4434-9dcb-5a0e71581314@kernel.org>
Date: Sun, 3 Aug 2025 14:01:48 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH mptcp-next 1/2] mptcp: Add support for SO_MAX_PACING_RATE
Content-Language: en-GB, fr-BE
To: cpaasch@openai.com, MPTCP Upstream <mptcp@lists.linux.dev>,
 Mat Martineau <martineau@kernel.org>, Geliang Tang <geliang@kernel.org>
References: <20250802-b4-mptcp_setsockopt-v1-0-50d4905a4c2b@openai.com>
 <20250802-b4-mptcp_setsockopt-v1-1-50d4905a4c2b@openai.com>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <20250802-b4-mptcp_setsockopt-v1-1-50d4905a4c2b@openai.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Christoph,

Thank you for looking at that!

On 03/08/2025 01:52, Christoph Paasch via B4 Relay wrote:
> From: Christoph Paasch <cpaasch@openai.com>
> 
> Add support for SO_MAX_PACING_RATE. It will limit the rate of each
> individual TCP subflow to the specified rate.

Applying the same rate for each subflow seems easier, but should we do that?

I mean: if I have an app and I set SO_MAX_PACING_RATE at 1Mbps, at the
end, data will be sent at 1Mbps * number of subflows. Is it not strange?
On the other hand, implementing it globally with all the subflows might
be quite complex I guess as currently, this rate limit is done by TC I
think, no? I guess the scheduler could set sk_max_pacing_rate for each
subflow, but how to distribute it amongst all subflows? Equally? It
depends on the limit of each subflow I guess.

At the end, what's the "common" use case with SO_MAX_PACING_RATE? If the
goal is just to apply a "vague" max limit to avoid abuses, that's maybe
OK with a limit per subflow. If the goal is to limit at a precise value,
that's possibly strange like that, e.g. using iperf3 with --fq-rate and
seeing more than expected.
> Signed-off-by: Christoph Paasch <cpaasch@openai.com>
> ---
>  net/mptcp/sockopt.c | 31 ++++++++++++++++++++++++++++++-
>  1 file changed, 30 insertions(+), 1 deletion(-)
> 
> diff --git a/net/mptcp/sockopt.c b/net/mptcp/sockopt.c
> index 2c267aff95bec90d341de9f9e136b9d2df9b8e13..a79dfeb54a3fe0d8c26a1836ae5dda9fd2fdddea 100644
> --- a/net/mptcp/sockopt.c
> +++ b/net/mptcp/sockopt.c
> @@ -308,6 +308,7 @@ static int mptcp_setsockopt_sol_socket(struct mptcp_sock *msk, int optname,
>  
>  		ret = sk_setsockopt(ssk, SOL_SOCKET, optname, optval, optlen);
>  		if (ret == 0) {
> +			/* Record the option at the msk for subsequent subflows */

(unrelated: maybe not needed?)
>  			if (optname == SO_REUSEPORT)
>  				sk->sk_reuseport = ssk->sk_reuseport;
>  			else if (optname == SO_REUSEADDR)
> @@ -340,6 +341,25 @@ static int mptcp_setsockopt_sol_socket(struct mptcp_sock *msk, int optname,
>  								optval, optlen);
>  	case SO_LINGER:
>  		return mptcp_setsockopt_sol_socket_linger(msk, optval, optlen);
> +	case SO_MAX_PACING_RATE: {
> +		struct mptcp_subflow_context *subflow;
> +
> +		ret = sock_setsockopt(sk->sk_socket, SOL_SOCKET, optname, optval, optlen);
> +		if (ret < 0)
> +			return ret;
> +
> +		lock_sock(sk);
> +		sockopt_seq_inc(msk);
> +
> +		mptcp_for_each_subflow(msk, subflow) {
> +			struct sock *ssk = mptcp_subflow_tcp_sock(subflow);
> +
> +			sk_setsockopt(ssk, SOL_SOCKET, optname, optval, optlen);
> +		}
> +
> +		release_sock(sk);
> +		break;

It might be better to move this block in a generic helper.

(and we should probably refactor more code to use such helpers, similar
to what was suggested there:
https://patchwork.kernel.org/project/mptcp/list/?series=763505&state=*)

> +	}
>  	case SO_RCVLOWAT:
>  	case SO_RCVTIMEO_OLD:
>  	case SO_RCVTIMEO_NEW:
> @@ -373,7 +393,6 @@ static int mptcp_setsockopt_sol_socket(struct mptcp_sock *msk, int optname,
>  	 * explicitly the sk_protocol field
>  	 *
>  	 * SO_PEEK_OFF is unsupported, as it is for plain TCP
> -	 * SO_MAX_PACING_RATE is unsupported, we must be careful with subflows
>  	 * SO_CNX_ADVICE is currently unsupported, could possibly be relevant,
>  	 * but likely needs careful design
>  	 *
> @@ -1532,6 +1551,7 @@ static void sync_socket_options(struct mptcp_sock *msk, struct sock *ssk)
>  {
>  	static const unsigned int tx_rx_locks = SOCK_RCVBUF_LOCK | SOCK_SNDBUF_LOCK;
>  	struct sock *sk = (struct sock *)msk;
> +	unsigned long max_pacing_rate;
>  
>  	if (ssk->sk_prot->keepalive) {
>  		if (sock_flag(sk, SOCK_KEEPOPEN))
> @@ -1579,6 +1599,15 @@ static void sync_socket_options(struct mptcp_sock *msk, struct sock *ssk)
>  	tcp_sock_set_keepcnt(ssk, msk->keepalive_cnt);
>  	tcp_sock_set_maxseg(ssk, msk->maxseg);
>  
> +	/* Keep pacing settings in sync as well. */
> +	max_pacing_rate = READ_ONCE(sk->sk_max_pacing_rate);
> +
> +	WRITE_ONCE(ssk->sk_max_pacing_rate, max_pacing_rate);
> +	if (max_pacing_rate != ~0UL)
> +		cmpxchg(&ssk->sk_pacing_status, SK_PACING_NONE, SK_PACING_NEEDED);
> +	if (READ_ONCE(ssk->sk_pacing_rate) > max_pacing_rate)
> +		WRITE_ONCE(ssk->sk_pacing_rate, max_pacing_rate);

Would it not be easier for the maintenance to export some code from

  net/core/sock.c

doing the same, and calling it from there and here?

> +
>  	inet_assign_bit(TRANSPARENT, ssk, inet_test_bit(TRANSPARENT, sk));
>  	inet_assign_bit(FREEBIND, ssk, inet_test_bit(FREEBIND, sk));
>  	inet_assign_bit(BIND_ADDRESS_NO_PORT, ssk, inet_test_bit(BIND_ADDRESS_NO_PORT, sk));
> 

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

