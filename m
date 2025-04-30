Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 967DE1E4110
	for <mptcp@lists.linux.dev>; Wed, 30 Apr 2025 09:06:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746003979; cv=none; b=LcGpOOy7QjWQYM/55ip8CQ+KJA7/3p8Ud4wx3Gees3JQtS6MS4fO1igPupbMsRqEaYDAobT+/QCFw/pitF+3+dE6VJqd5xqwjpG0rRXLHR8yeu+YcPAaEqxzEu2znwoxIqevjVQl4QN6ibIhOO+7+ul/AtVXlyumlFUA4Qm8idA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746003979; c=relaxed/simple;
	bh=RjYMsFwZ51ZOIi6jzymAFaU68VGjrBMIOjLAf9OkPz8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SMr8tg/ATS67pZxM186tYJXNyCFGIsILzXXjRJ53BMKXvFzC8NyfE1ViIwjsqOgnQOmRfVeOeKfuJsdvrRaQdapHB72dlfwp4S4u9ZhsunfU4bh/2/3cwfksG/3scH+IyHz+ccJQKg4dij+kWdla8E4hulELKVAI2B6I2+u4isk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kRORibrJ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kRORibrJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 625A5C4CEE9;
	Wed, 30 Apr 2025 09:06:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746003974;
	bh=RjYMsFwZ51ZOIi6jzymAFaU68VGjrBMIOjLAf9OkPz8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=kRORibrJw47dIwhGLQBtOOl8YseYoReGMXUbaHo+PLn3j9LK9cVq+xfuoLbfuK+4/
	 pEcm2ilp6zW82aEbiLUDw41X/si74j/zDPzH2qh74PAjq869rZhTwNOJY9TMseV/s1
	 Yg1gL84rigd5ZjYSoWwg9v6Us5H0YWW3ZfmM/b/62tQl0nA4G5fomxKIofge7jHncx
	 TKnKoltCj/PPgL6bdLIGEov9LhVX7ehMusDyzZtZSOHO3uzcgrF0CRGoYTcHDTofMb
	 yjwIKecFgPHp8gaOjsJiqePPf7gXtFmuiOCoGpXf+NN0UiSRn7sRe9JpSORQQDP/kW
	 HBGmANQdjbP1w==
Message-ID: <d514f88c-cead-4975-9dd2-55a7b4ba8bcf@kernel.org>
Date: Wed, 30 Apr 2025 11:06:11 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH mptcp-next v3 2/2] mptcp: add TCP_MAXSEG sockopt support
Content-Language: en-GB, fr-BE
To: Geliang Tang <geliang@kernel.org>, mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
References: <cover.1745991978.git.geliang@kernel.org>
 <cdc5f6389f230f8c1eec4332c27efbf51c734a51.1745991978.git.geliang@kernel.org>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <cdc5f6389f230f8c1eec4332c27efbf51c734a51.1745991978.git.geliang@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 30/04/2025 07:49, Geliang Tang wrote:
> From: Geliang Tang <tanggeliang@kylinos.cn>
> 
> The TCP_MAXSEG socket option is currently not supported by MPTCP, mainly
> because it has never been requested before. But there are still valid
> use-cases, e.g. with HAProxy.
> 
> This patch adds its support in MPTCP by propagating the value to all
> subflows.
> 
> Similar to mptcp_setsockopt_first_sf_only(), a generic helper
> mptcp_setsockopt_all_subflows() is added to set sockopt for each
> subflows of the mptcp socket.
> 
> Add a new member for struct mptcp_sock to store the TCP_MAXSEG value,
> and return this value in getsockopt.
> 
> Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/515
> Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
> ---
>  net/mptcp/protocol.h |  1 +
>  net/mptcp/sockopt.c  | 25 +++++++++++++++++++++++++
>  2 files changed, 26 insertions(+)
> 
> diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
> index 64aa091cb685..91aaed17fe56 100644
> --- a/net/mptcp/protocol.h
> +++ b/net/mptcp/protocol.h
> @@ -327,6 +327,7 @@ struct mptcp_sock {
>  	int		keepalive_cnt;
>  	int		keepalive_idle;
>  	int		keepalive_intvl;
> +	int		maxseg;
>  	struct work_struct work;
>  	struct sk_buff  *ooo_last_skb;
>  	struct rb_root  out_of_order_queue;
> diff --git a/net/mptcp/sockopt.c b/net/mptcp/sockopt.c
> index afa54fba51e2..5a002dd05cc9 100644
> --- a/net/mptcp/sockopt.c
> +++ b/net/mptcp/sockopt.c
> @@ -798,6 +798,22 @@ static int mptcp_setsockopt_first_sf_only(struct mptcp_sock *msk, int level, int
>  	return ret;
>  }
>  
> +static int mptcp_setsockopt_all_subflows(struct mptcp_sock *msk, int level, int optname,

Checkpatch was complaining about this line because we were over 80
chars. I just did a modification to avoid that, and while at it, I also
use 'mptcp_setsockopt_all_sf', similar to 'first_sf_only' and what was
suggested there:

https://patchwork.kernel.org/project/mptcp/patch/20230707-mptcp-unify-sockopt-issue-353-v1-5-693e15c06646@tessares.net/

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

