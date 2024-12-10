Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE62478F4E
	for <mptcp@lists.linux.dev>; Tue, 10 Dec 2024 11:43:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733831039; cv=none; b=gHP+fPPFGSL/cNDUXTuXf7WCCxwZJrK7gerxRinuUlSOjNrxevWb2tRTwX0onlfnUnQuAmL70r0dYfSlfpmHjHOuEjk3pnLfA8EC3O54nK13qZl9fufnXs94oZ4eKyo/hEoYlo2zIosYu+iOSqGfGLC47JDpHb2GQmqsvWyae1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733831039; c=relaxed/simple;
	bh=etmHtKHbplj8a6fdAebEfuNDtiKWAMfTWL4HAswtOwg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Xy/YRYG49kztWhdJrFHN24OAvH1SWGt5QMLb3L5xwIq0eMkd9t5QcDfk9gCDY1XamVGq6lnzeLy1SLR4oq5/1TXanm2Kkz6eUgiCIqPJ+xq3dSw6vYj8gz/jxn5LYnuYq6aZuFtClpiTLV7YagH2gaQFkP+sm6Xqx3ugyNjDxR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N2e8QtqV; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N2e8QtqV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8ECBC4CEE3;
	Tue, 10 Dec 2024 11:43:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733831038;
	bh=etmHtKHbplj8a6fdAebEfuNDtiKWAMfTWL4HAswtOwg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=N2e8QtqVajCLS5cgGNG5Ns/HFdWEyLCoP+z4bh7OkwqCgvoRuaqhvcoK2GbpZ/iwq
	 tWf4D9VHr9Yo4Ian7TbgbRSY/cChfZEaM2zp2mxEj6Bjo+NqFR4SAK+oULmyHQpXvy
	 PCHGYgUBzUuCySF1DOdVv0jN+2Zrz3xkxFcWesvmOOaxI7xcLI9NE4KbQ+OrLQ3YJC
	 UVRCmmhfDn/ACPbwdvdEjDOlVGmjHr1tU3gz5fszkSnayH980b/nqtf9bElLhWrbK/
	 z+lqJHyQmBExKzK7Rj+H7xcTzdpfcAs2CX1KSdirUpBkMu5SmB8GRoYl4kISZADSv8
	 Sd5q0wuz8gKxg==
Message-ID: <63a651c3-0b8a-470f-a283-f70ae9c87870@kernel.org>
Date: Tue, 10 Dec 2024 12:43:55 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH mptcp-next v4 1/5] mptcp: update
 bpf_mptcp_sock_from_subflow
Content-Language: en-GB
To: Geliang Tang <geliang@kernel.org>, mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
References: <cover.1733733573.git.tanggeliang@kylinos.cn>
 <8f9c34611d46f96a0047928ac41b385faf743805.1733733573.git.tanggeliang@kylinos.cn>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <8f9c34611d46f96a0047928ac41b385faf743805.1733733573.git.tanggeliang@kylinos.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Geliang,

On 09/12/2024 09:47, Geliang Tang wrote:
> From: Geliang Tang <tanggeliang@kylinos.cn>
> 
> The input parameter of bpf_mptcp_sock_from_subflow() is an msk subsocket
> of type IPPROTO_TCP. This patch extends it to accept an IPPROTO_MPTCP
> socket. With this change, the function name bpf_mptcp_sock_from_subflow
> is no longer appropriate, and it is renamed to bpf_mptcp_sock_from_sock.

It took me a bit of time to find the reason: why do you need this, why
not adding a new helper, especially because you don't directly use it in
this series.

Please always clearly mention the reason, probably the most important
bit in a commit message, even if it is obvious to you. I then suggest
having a (hopefully) clearer commit message:

================================== 8< ==================================
bpf: extend bpf_skc_to_mptcp_sock to MPTCP sock

Currently, bpf_skc_to_mptcp_sock() can only be used with sockets that
are MPTCP subflows: TCP sockets with tp->is_mptcp, created by the kernel
from an MPTCP socket (IPPROTO_MPTCP). Typically used with BPF sock_ops
operators.

Here, this helper is extended to support MPTCP sockets, the ones created
by the userspace (IPPROTO_MPTCP). This is useful for BPF hooks involving
these sockets, e.g. [gs]etsocktopt.

bpf_skc_to_mptcp_sock() uses bpf_mptcp_sock_from_subflow(). The former
suggests any MPTCP type/subtype can be used, but the latter only accepts
subflow ones. So bpf_mptcp_sock_from_subflow is modified here to support
MPTCP socket, and renamed to avoid confusions.
================================== 8< ==================================

WDYT? Here the reason (bpf_skc_to_mptcp_sock supporting MPTCP sockets)
is explained, and the title is clearer ("update X" is too vague).

(...)

> diff --git a/net/mptcp/bpf.c b/net/mptcp/bpf.c
> index e9db856972cb..a0f49af85d57 100644
> --- a/net/mptcp/bpf.c
> +++ b/net/mptcp/bpf.c
> @@ -188,8 +188,10 @@ static struct bpf_struct_ops bpf_mptcp_sched_ops = {
>  };
>  #endif /* CONFIG_BPF_JIT */
>  
> -struct mptcp_sock *bpf_mptcp_sock_from_subflow(struct sock *sk)
> +struct mptcp_sock *bpf_mptcp_sock_from_sock(struct sock *sk)
>  {
> +	if (sk && sk_fullsock(sk) && sk->sk_protocol == IPPROTO_MPTCP)
> +		return mptcp_sk(sk);
>  	if (sk && sk_fullsock(sk) && sk->sk_protocol == IPPROTO_TCP && sk_is_mptcp(sk))
>  		return mptcp_sk(mptcp_subflow_ctx(sk)->conn);

Maybe we should avoid repeating some checks?

  if (unlikely(!sk || !sk_fullsock(sk)))
      return NULL;

  if (sk->sk_protocol == IPPROTO_MPTCP)
      return mptcp_sk(sk);

  if (sk->sk_protocol == IPPROTO_TCP && sk_is_mptcp(sk))
      return mptcp_sk(mptcp_subflow_ctx(sk)->conn);

  return NULL;



Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

