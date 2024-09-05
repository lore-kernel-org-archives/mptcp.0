Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02FE119D8BC
	for <mptcp@lists.linux.dev>; Thu,  5 Sep 2024 14:03:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725545013; cv=none; b=OTthRi9rDtVMJods6GG6jgQByMuMl/o0/HSATMs3ojn1XDPEji0EwSknBQWFE/OIqK+ZBSZHZdiHh/EgGgiC+EIJNFul8xP7jGHB9mqhh5J0bHdl9w9Pe+IndxNAOBFAelX7S25gNKG2lyWKcWlu01JkWGE+mIIFrKXGvof6Qxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725545013; c=relaxed/simple;
	bh=UNKP2gAWWN+OGV0pKXhXQZpJm1MmGZN4RSVF9VBQWYo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=is2CAUhrR7eDF/Ik7gp4PcR6Fly9/sPOxJfcjEm0Ib4sWmC2jChT3bS2QP1fPgonoXO2cq1kSUT5MQJXqbYF6MnCIEuhFfENmP8FsdHmQbtHG9bmFvHoZs6dGTie1o4HLKILPC/XLdDmVGQ/tPPMjoXhW2//Cm8+l3uGbXBhXRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BlRsIqlh; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BlRsIqlh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 742FDC4CEC3;
	Thu,  5 Sep 2024 14:03:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725545012;
	bh=UNKP2gAWWN+OGV0pKXhXQZpJm1MmGZN4RSVF9VBQWYo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=BlRsIqlhPjbPLqwHaZih45SRKxvRT2fDy+a95NIDaGMCkSHXw7ayWMU63nS6sWVsX
	 SVaXS0qlwyEvijyI+SorFf9p3K9VGkt1/Jb/e8wSWVqmfKAkxPun+s9IPd/flNUcsn
	 t0HJjRb7aGq1P16UIxx5pmHAj/eLQfU56yX0Tm+7jYzLjxnErj1k653kis7A5pAZnG
	 20p0hmiNfhcp0+K0a4PzAXEj2UEmhp4DcMMX4owsL4fxSuj/UGnWsU5KQVXK997+do
	 Fo6NgEBBkdPfb9sUP2ZvEh00+odEOFHeoBXOzSECn7xnzo9qErs+YxSQ2/Yj866rsd
	 CnkTzcL3eqnbA==
Message-ID: <e6a444a2-c177-4723-be93-861e2cf7b69a@kernel.org>
Date: Thu, 5 Sep 2024 16:03:28 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH mptcp-next] Squash to "selftests/bpf: Add getsockopt to
 inspect mptcp subflow"
Content-Language: en-GB
To: Geliang Tang <geliang@kernel.org>, mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
References: <11a224e1bade27689271af77cd47c6a49852a2cf.1725543947.git.tanggeliang@kylinos.cn>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <11a224e1bade27689271af77cd47c6a49852a2cf.1725543947.git.tanggeliang@kylinos.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Geliang,

On 05/09/2024 15:46, Geliang Tang wrote:
> From: Geliang Tang <tanggeliang@kylinos.cn>
> 
> Update error messages:
> 
>  run_subflow:FAIL:mark unexpected mark: actual 3 != expected 0
>  run_subflow:FAIL:cc unexpected cc: actual 'reno' != expected 'cubic'

That's a good idea to improve the error message in case of error, but I
think this technique or changing the optval is dangerous:

(...)

> diff --git a/tools/testing/selftests/bpf/progs/mptcp_subflow.c b/tools/testing/selftests/bpf/progs/mptcp_subflow.c
> index 70302477e326..a5e42bfddbbf 100644
> --- a/tools/testing/selftests/bpf/progs/mptcp_subflow.c
> +++ b/tools/testing/selftests/bpf/progs/mptcp_subflow.c
> @@ -63,6 +63,7 @@ int mptcp_subflow(struct bpf_sock_ops *skops)
>  static int _check_getsockopt_subflow_mark(struct mptcp_sock *msk, struct bpf_sockopt *ctx)
>  {
>  	struct mptcp_subflow_context *subflow;
> +	int *optval = ctx->optval;
>  	int i = 0;
>  
>  	mptcp_for_each_subflow(msk, subflow) {
> @@ -72,7 +73,10 @@ static int _check_getsockopt_subflow_mark(struct mptcp_sock *msk, struct bpf_soc
>  							   struct mptcp_subflow_context));
>  
>  		if (ssk->sk_mark != ++i) {
> -			ctx->retval = -2;
> +			if (ctx->optval + sizeof(int) <= ctx->optval_end) {
> +				*optval = ssk->sk_mark;

I guess a likely error to have is that the mark (or the cc) has not been
changed on the subflow, and it then has its default value. In this case
here with the mark, you will not change optval: it will be 0 before, and
you will set it to 0. That means your test will not fail here (retval =
0) or in the verifications done by the userspace (mark = 0).

I think it is safer not to change 'optval' here in the verification
step. If you want to pass info to the userspace, can you not write a
string somewhere? e.g. skel->bss->error_msg, or using a storage map?

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

