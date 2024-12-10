Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD04678F39
	for <mptcp@lists.linux.dev>; Tue, 10 Dec 2024 11:46:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733831163; cv=none; b=Gs6Hc4Kr3DByGmV3aNtbdAXt/N7VA+NWBVKQW3Rhhb6g0wLzGmayvE2OoEHfy2kTmUEuGQq8C1d7IRxTmgrlThqXESDbyMfPAlEwl4sUckXMSNech3lXd4CHMOugrUjfUHszv05s5AifutGFTpGbiPA0FfEU2CSvxZAgVNkUtcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733831163; c=relaxed/simple;
	bh=2vnhEUl2NmutpHR6cmq+AitqzZSlldyBsoXiyVuuqX8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SGus7e4d2yydZbXrG5kv0fMEBesRZNs8kyp0nxH2Z2Mwk/nnTJwQ+zpnku1G/g8QUOkn6QeJ6CGST99Trfys1BV+kht1IRCBUt5WuQBi4Kam+PAgcLcnUWgNEhqpFv8tAkefGajXATde6+Vu+dCc7pQeIu/aZxa4bL8HFFOsVNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NyeFD5zQ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NyeFD5zQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94664C4CED6;
	Tue, 10 Dec 2024 11:46:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733831163;
	bh=2vnhEUl2NmutpHR6cmq+AitqzZSlldyBsoXiyVuuqX8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=NyeFD5zQV6kGnY5VfBgtRqWg1LxkfzH2qgiN4tNYxUfzeYP23oIqEhW20B5ADy1ol
	 kt6N+RKx1hs2a85isqqwzh4aV4GxF4132S3rIKBcD6Y7+AyDGc+U56mWHFoA3Chalm
	 bjQElklmm0qNYKiuHRBiGlIuNgP1Q/OIg4cNIO7Tz3XU0m/EOUhzj/VGxZp01svRIU
	 CV4FbjRcsKUuctQV2vUcq51UeZwKzgsrJWj7hU1kZcHTH9fU97wNufHkw1G3p00go7
	 w1/F2xUWuXIPYa21OeeL7wUH21H75q7NLKqPNHxsLnwrEv8Hek7+HvaDAVCJIjo4Kb
	 n+omIUlMZmQvQ==
Message-ID: <b21b4b4c-48ab-460e-8e41-1782ca9a28a7@kernel.org>
Date: Tue, 10 Dec 2024 12:46:00 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH mptcp-next v4 3/5] Squash to "bpf: Register mptcp common
 kfunc set"
Content-Language: en-GB
To: Geliang Tang <geliang@kernel.org>, mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
References: <cover.1733733573.git.tanggeliang@kylinos.cn>
 <1de02f9ee30ee67ec5eb4bfd9bdef9737e6cd4d8.1733733573.git.tanggeliang@kylinos.cn>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <1de02f9ee30ee67ec5eb4bfd9bdef9737e6cd4d8.1733733573.git.tanggeliang@kylinos.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 09/12/2024 09:47, Geliang Tang wrote:
> From: Geliang Tang <tanggeliang@kylinos.cn>
> 
> Drop bpf_mptcp_sk() and bpf_mptcp_subflow_tcp_sock() definitions. Use
> bpf_skc_to_mptcp_sock() and mptcp_subflow_tcp_sock() in mptcp_subflow
> bpf_iter selftests instead.
> 
> Address Martin's comments in v1:
> 
> - add null-check for bpf_mptcp_subflow_ctx.
> - add KF_RET_NULL flags for bpf_mptcp_subflow_ctx.
> - register this kfunc set to BPF_PROG_TYPE_CGROUP_SOCKOPT only,
>   not BPF_PROG_TYPE_UNSPEC.
> 
> Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
> ---
>  net/mptcp/bpf.c | 20 +++++---------------
>  1 file changed, 5 insertions(+), 15 deletions(-)
> 
> diff --git a/net/mptcp/bpf.c b/net/mptcp/bpf.c
> index a0f49af85d57..f9ba0a46a9f1 100644
> --- a/net/mptcp/bpf.c
> +++ b/net/mptcp/bpf.c
> @@ -218,21 +218,13 @@ struct bpf_iter_mptcp_subflow_kern {
>  
>  __bpf_kfunc_start_defs();
>  
> -__bpf_kfunc static struct mptcp_sock *bpf_mptcp_sk(struct sock *sk)
> -{
> -	return mptcp_sk(sk);
> -}
> -
>  __bpf_kfunc static struct mptcp_subflow_context *
>  bpf_mptcp_subflow_ctx(const struct sock *sk)
>  {
> -	return mptcp_subflow_ctx(sk);
> -}
> +	if (!sk)
> +		return NULL;

Is it enough for the restrictions?

I mean, from what I understood, this helper can be used from any CGROUP
SOCKOPT hooks, with any type of 'struct sock *': then it could be called
from a non MPTCP subflow socket, e.g. a socket with ULP data, no?

Then should we not check this?

  sk->sk_protocol == IPPROTO_TCP && sk_is_mptcp(sk)

(and even sk_fullsock(sk)?)

(...)

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

