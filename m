Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A299D20012D
	for <mptcp@lists.linux.dev>; Wed,  5 Mar 2025 21:31:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741210268; cv=none; b=Dya26SHCcuI0lfys/eiHNjJHMcTuR+DEhwU4hknz5sSco6y6LEkfo6PyP4dfJQnE6OUrVZOaBmqjVaDiRyCCi6Fg81+4kNkh4rx8Rbeq4U2qYdSJ2tSbuQHPBz3rlBBeLV088Nho98cIP2t4Xy9/AH/sxXg7uwoe+nMhMRNqpXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741210268; c=relaxed/simple;
	bh=Z6bgWRDCW9YSQgxKHAqjqNV9opzLadIkAbtKl1G3kMQ=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=oye/6WQVzCAJ1cGwVL47Jh0fS6o5vI57vsZKVv8Z96BeRnEHTkqTF7Bm1+1pyZ938reGZ62tP0Gx/yZcaA+yuM1EwPXgFkmE5RVsCyddsZs+BT3DydDhH5qAJ6ww5hK+ni8Drz5qWR1mARC2v3kQH6n1siVIMfOtp+rdMUsOihw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CtSdsYoy; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CtSdsYoy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05BC5C4CED1;
	Wed,  5 Mar 2025 21:31:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741210268;
	bh=Z6bgWRDCW9YSQgxKHAqjqNV9opzLadIkAbtKl1G3kMQ=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=CtSdsYoyZWxCmvT2+E/FLVMweIp59Dm+hBpUSJnCoZN9Hf/5d18igqfI69zqo8C91
	 00f6pWvM8R/bj2AIiFfku0YoOzZWnijDT2whh7KmoVAs93MAsm2gPSnaR3LDp8VyB8
	 csDRUOBEbr2hS7ekF5yNqEkstRi1BmY3yGb5FRpUNxCGTPcQVdlWX5T0P+SBy2PZlX
	 4tL5/WkGqHMjvkKfv5hmcN1TjikCsEnzHtgtS4ydImxV8M8ZAJX24JqU0IyevR04LE
	 VF/qiOCHYOH2hWVhY7MXB3pFHyLBI7tXTjS/JkE8N2KUhBtPlT4AYzNxtLvjVl1DO8
	 7EK+zl+6Z3zWg==
Date: Wed, 5 Mar 2025 13:31:07 -0800 (PST)
From: Mat Martineau <martineau@kernel.org>
To: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
cc: mptcp@lists.linux.dev, Davide Caratti <dcaratti@redhat.com>
Subject: Re: [PATCH mptcp-next v2 2/2] tcp: ulp: diag: more info without
 CAP_NET_ADMIN
In-Reply-To: <20250305-mptcp-tcp-ulp-diag-cap-v2-2-d53fd80748eb@kernel.org>
Message-ID: <e1663bf9-76f1-1660-1ce1-43d4af629473@kernel.org>
References: <20250305-mptcp-tcp-ulp-diag-cap-v2-0-d53fd80748eb@kernel.org> <20250305-mptcp-tcp-ulp-diag-cap-v2-2-d53fd80748eb@kernel.org>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Wed, 5 Mar 2025, Matthieu Baerts (NGI0) wrote:

> When introduced in commit 61723b393292 ("tcp: ulp: add functions to dump
> ulp-specific information"), the whole ULP diag info has been exported
> only if the requester had CAP_NET_ADMIN.
>
> It looks like not everything is sensitive, and some info can be exported
> to all users in order to ease the debugging from the userspace side
> without requiring additional capabilities. Each layer should then decide
> what can be exposed to everybody. The 'net_admin' boolean is then passed
> to the different layers.
>
> On kTLS side, it looks like there is nothing sensitive there, only some
> metadata about the configuration, no cryptographic information. Then,
> everything can be exported to all users.
>
> On MPTCP side, that's different. The MPTCP-related sequence numbers per
> subflow should certainly not be exposed to everybody. For example, the
> DSS mapping and ssn_offset would give all users on the system access to
> narrow ranges of values for the subflow TCP sequence numbers and
> MPTCP-level DSNs, and then ease packet injection. The TCP diag interface
> doesn't expose the TCP sequence numbers for TCP sockets, so best to do
> the same here.
>
> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
> ---
> include/net/tcp.h   |  4 ++--
> net/ipv4/tcp_diag.c |  8 ++++----
> net/mptcp/diag.c    | 42 ++++++++++++++++++++++++++----------------
> net/tls/tls_main.c  |  4 ++--
> 4 files changed, 34 insertions(+), 24 deletions(-)

Matthieu -

This patch also LGTM:

Acked-by: Mat Martineau <martineau@kernel.org>

>
> diff --git a/include/net/tcp.h b/include/net/tcp.h
> index a9bc959fb102fc6697b4a664b3773b47b3309f13..7207c52b1fc9ce3cd9cf2a8580310d0e629f82d6 100644
> --- a/include/net/tcp.h
> +++ b/include/net/tcp.h
> @@ -2598,8 +2598,8 @@ struct tcp_ulp_ops {
> 	/* cleanup ulp */
> 	void (*release)(struct sock *sk);
> 	/* diagnostic */
> -	int (*get_info)(struct sock *sk, struct sk_buff *skb);
> -	size_t (*get_info_size)(const struct sock *sk);
> +	int (*get_info)(struct sock *sk, struct sk_buff *skb, bool net_admin);
> +	size_t (*get_info_size)(const struct sock *sk, bool net_admin);
> 	/* clone ulp */
> 	void (*clone)(const struct request_sock *req, struct sock *newsk,
> 		      const gfp_t priority);
> diff --git a/net/ipv4/tcp_diag.c b/net/ipv4/tcp_diag.c
> index d8bba37dbffd8c6cc7fab2328a88b6ce6ea3e9f4..45e174b8cd22173b6b8eeffe71df334c45498b15 100644
> --- a/net/ipv4/tcp_diag.c
> +++ b/net/ipv4/tcp_diag.c
> @@ -96,8 +96,8 @@ static int tcp_diag_put_ulp(struct sk_buff *skb, struct sock *sk,
> 	if (err)
> 		goto nla_failure;
>
> -	if (net_admin && ulp_ops->get_info)
> -		err = ulp_ops->get_info(sk, skb);
> +	if (ulp_ops->get_info)
> +		err = ulp_ops->get_info(sk, skb, net_admin);
> 	if (err)
> 		goto nla_failure;
>
> @@ -170,8 +170,8 @@ static size_t tcp_diag_get_aux_size(struct sock *sk, bool net_admin)
> 		if (ulp_ops) {
> 			size += nla_total_size(0) +
> 				nla_total_size(TCP_ULP_NAME_MAX);
> -			if (net_admin && ulp_ops->get_info_size)
> -				size += ulp_ops->get_info_size(sk);
> +			if (ulp_ops->get_info_size)
> +				size += ulp_ops->get_info_size(sk, net_admin);
> 		}
> 	}
> 	return size;
> diff --git a/net/mptcp/diag.c b/net/mptcp/diag.c
> index 02205f7994d752cc505991efdf7aa0bbbfd830db..70cf9ebce8338bde3b0bb10fc8620905b15f5190 100644
> --- a/net/mptcp/diag.c
> +++ b/net/mptcp/diag.c
> @@ -12,7 +12,7 @@
> #include <net/netlink.h>
> #include "protocol.h"
>
> -static int subflow_get_info(struct sock *sk, struct sk_buff *skb)
> +static int subflow_get_info(struct sock *sk, struct sk_buff *skb, bool net_admin)
> {
> 	struct mptcp_subflow_context *sf;
> 	struct nlattr *start;
> @@ -56,15 +56,6 @@ static int subflow_get_info(struct sock *sk, struct sk_buff *skb)
>
> 	if (nla_put_u32(skb, MPTCP_SUBFLOW_ATTR_TOKEN_REM, sf->remote_token) ||
> 	    nla_put_u32(skb, MPTCP_SUBFLOW_ATTR_TOKEN_LOC, sf->token) ||
> -	    nla_put_u32(skb, MPTCP_SUBFLOW_ATTR_RELWRITE_SEQ,
> -			sf->rel_write_seq) ||
> -	    nla_put_u64_64bit(skb, MPTCP_SUBFLOW_ATTR_MAP_SEQ, sf->map_seq,
> -			      MPTCP_SUBFLOW_ATTR_PAD) ||
> -	    nla_put_u32(skb, MPTCP_SUBFLOW_ATTR_MAP_SFSEQ,
> -			sf->map_subflow_seq) ||
> -	    nla_put_u32(skb, MPTCP_SUBFLOW_ATTR_SSN_OFFSET, sf->ssn_offset) ||
> -	    nla_put_u16(skb, MPTCP_SUBFLOW_ATTR_MAP_DATALEN,
> -			sf->map_data_len) ||
> 	    nla_put_u32(skb, MPTCP_SUBFLOW_ATTR_FLAGS, flags) ||
> 	    nla_put_u8(skb, MPTCP_SUBFLOW_ATTR_ID_REM, sf->remote_id) ||
> 	    nla_put_u8(skb, MPTCP_SUBFLOW_ATTR_ID_LOC, subflow_get_local_id(sf))) {
> @@ -72,6 +63,21 @@ static int subflow_get_info(struct sock *sk, struct sk_buff *skb)
> 		goto nla_failure;
> 	}
>
> +	/* Only export seq related counters to user with CAP_NET_ADMIN */
> +	if (net_admin &&
> +	    (nla_put_u32(skb, MPTCP_SUBFLOW_ATTR_RELWRITE_SEQ,
> +			 sf->rel_write_seq) ||
> +	     nla_put_u64_64bit(skb, MPTCP_SUBFLOW_ATTR_MAP_SEQ, sf->map_seq,
> +			       MPTCP_SUBFLOW_ATTR_PAD) ||
> +	     nla_put_u32(skb, MPTCP_SUBFLOW_ATTR_MAP_SFSEQ,
> +			 sf->map_subflow_seq) ||
> +	     nla_put_u32(skb, MPTCP_SUBFLOW_ATTR_SSN_OFFSET, sf->ssn_offset) ||
> +	     nla_put_u16(skb, MPTCP_SUBFLOW_ATTR_MAP_DATALEN,
> +			 sf->map_data_len))) {
> +		err = -EMSGSIZE;
> +		goto nla_failure;
> +	}
> +
> 	rcu_read_unlock();
> 	unlock_sock_fast(sk, slow);
> 	nla_nest_end(skb, start);
> @@ -84,22 +90,26 @@ static int subflow_get_info(struct sock *sk, struct sk_buff *skb)
> 	return err;
> }
>
> -static size_t subflow_get_info_size(const struct sock *sk)
> +static size_t subflow_get_info_size(const struct sock *sk, bool net_admin)
> {
> 	size_t size = 0;
>
> 	size += nla_total_size(0) +	/* INET_ULP_INFO_MPTCP */
> 		nla_total_size(4) +	/* MPTCP_SUBFLOW_ATTR_TOKEN_REM */
> 		nla_total_size(4) +	/* MPTCP_SUBFLOW_ATTR_TOKEN_LOC */
> -		nla_total_size(4) +	/* MPTCP_SUBFLOW_ATTR_RELWRITE_SEQ */
> -		nla_total_size_64bit(8) +	/* MPTCP_SUBFLOW_ATTR_MAP_SEQ */
> -		nla_total_size(4) +	/* MPTCP_SUBFLOW_ATTR_MAP_SFSEQ */
> -		nla_total_size(4) +	/* MPTCP_SUBFLOW_ATTR_SSN_OFFSET */
> -		nla_total_size(2) +	/* MPTCP_SUBFLOW_ATTR_MAP_DATALEN */
> 		nla_total_size(4) +	/* MPTCP_SUBFLOW_ATTR_FLAGS */
> 		nla_total_size(1) +	/* MPTCP_SUBFLOW_ATTR_ID_REM */
> 		nla_total_size(1) +	/* MPTCP_SUBFLOW_ATTR_ID_LOC */
> 		0;
> +
> +	if (net_admin)
> +		size += nla_total_size(4) +	/* MPTCP_SUBFLOW_ATTR_RELWRITE_SEQ */
> +			nla_total_size_64bit(8) +	/* MPTCP_SUBFLOW_ATTR_MAP_SEQ */
> +			nla_total_size(4) +	/* MPTCP_SUBFLOW_ATTR_MAP_SFSEQ */
> +			nla_total_size(4) +	/* MPTCP_SUBFLOW_ATTR_SSN_OFFSET */
> +			nla_total_size(2) +	/* MPTCP_SUBFLOW_ATTR_MAP_DATALEN */
> +			0;
> +
> 	return size;
> }
>
> diff --git a/net/tls/tls_main.c b/net/tls/tls_main.c
> index 99ca4465f70216c5a44e4ca7477df0e93df6b76d..cb86b0bf9a53e1ff060d8e69eddbd6acfbee5194 100644
> --- a/net/tls/tls_main.c
> +++ b/net/tls/tls_main.c
> @@ -1057,7 +1057,7 @@ static u16 tls_user_config(struct tls_context *ctx, bool tx)
> 	return 0;
> }
>
> -static int tls_get_info(struct sock *sk, struct sk_buff *skb)
> +static int tls_get_info(struct sock *sk, struct sk_buff *skb, bool net_admin)
> {
> 	u16 version, cipher_type;
> 	struct tls_context *ctx;
> @@ -1115,7 +1115,7 @@ static int tls_get_info(struct sock *sk, struct sk_buff *skb)
> 	return err;
> }
>
> -static size_t tls_get_info_size(const struct sock *sk)
> +static size_t tls_get_info_size(const struct sock *sk, bool net_admin)
> {
> 	size_t size = 0;
>
>
> -- 
> 2.47.1
>
>
