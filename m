Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09A4B1EB9EF
	for <mptcp@lists.linux.dev>; Mon, 21 Oct 2024 17:50:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729533016; cv=none; b=O/G9KJxwHI8LLGZiAPCJ/krhLL176dWMk3Q0Y7g0s3NXpYfDWwr/jLfLTigcXgWSZ0Rz91YpRRKqYz+EZ9ChztHxFE6nfsQb/pFWXuExgKw6ouxZ+WX7b6t10NhuRdzVgUyQyS3DAcM/3XQrEmEC5WXcPHmhYAFwqLs5y9heQKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729533016; c=relaxed/simple;
	bh=PH5No5iYViBm4r9XoUQFLbxoj9BKKbsiBKd8jK0CkrM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qDgvFiYxpuVB+ylxDZT+TxiExILpHHBogD+erqlqtRxX6Xi7/W+MAjAP4bYSnE/lcwxN2l/yyxhEOOHGt1VhjyuKEV6xveel7hPnJDpKde2gXD7Ax9AxE67fpRnDew81pf3C+49b9kl0Dx2yrO3wYZUADgiHNxjyi964tevlA5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t0LAjsLQ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t0LAjsLQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BAECEC4CEC3;
	Mon, 21 Oct 2024 17:50:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729533015;
	bh=PH5No5iYViBm4r9XoUQFLbxoj9BKKbsiBKd8jK0CkrM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=t0LAjsLQbP1zbIqqJVGtX4fo+Ai+E//ZGv5NHismwoaY148s3IIMPl0vNPPUIsBbb
	 4uJE5aXQaXUnpLvvWR0c3eAQFdtK9ebQ+/PKtkxHLvOI2/haZqkruOWilif1KPhZsu
	 owHpHVP3VcelltIuA10HwgIr0ghfOp8MEek2OM8cgFt5u/zt/AX0dLySAju8zw0+Sn
	 f8GvFupIanhysCILYNUpN03GOEssYSwyGtRr9i5BcyvA6J/MppK/59ro+e4024Spex
	 6pYIe67zazGnNk+PI4UPbOBZDlrexav3M2xNhUqIrPg4HbpLLxEcMYzWjc6wzKHKbY
	 Jj8xntCoUPQuw==
Message-ID: <8782252c-c851-4034-b094-c4d13b14c69b@kernel.org>
Date: Mon, 21 Oct 2024 19:50:12 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH mptcp-next v3 1/1] selftests/bpf: Use make/remove netns
 helpers in mptcp
Content-Language: en-GB
To: Geliang Tang <geliang@kernel.org>
Cc: Geliang Tang <tanggeliang@kylinos.cn>, mptcp@lists.linux.dev
References: <cover.1728530836.git.tanggeliang@kylinos.cn>
 <af42ab81074d8a56f5fac8bcb4637400777f5ad5.1728530836.git.tanggeliang@kylinos.cn>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <af42ab81074d8a56f5fac8bcb4637400777f5ad5.1728530836.git.tanggeliang@kylinos.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Geliang,

On 10/10/2024 05:31, Geliang Tang wrote:
> From: Geliang Tang <tanggeliang@kylinos.cn>
> 
> New netns selftest helpers make_netns() and remove_netns() are added in

(s/are/have been/)

> network_helpers.c, let's use them in mptcp selftests too.

Thank you for the patch!

I have one small comment below. The rest looks good to me:

Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>

Because it is just a single patch, and just a clean-up, do you mind
sending it directly to BPF maintainers please?

> Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
> ---
>  tools/testing/selftests/bpf/prog_tests/mptcp.c | 17 ++++++++++++-----
>  1 file changed, 12 insertions(+), 5 deletions(-)
> 
> diff --git a/tools/testing/selftests/bpf/prog_tests/mptcp.c b/tools/testing/selftests/bpf/prog_tests/mptcp.c
> index acd79be134cd..7f70f8ec76aa 100644
> --- a/tools/testing/selftests/bpf/prog_tests/mptcp.c
> +++ b/tools/testing/selftests/bpf/prog_tests/mptcp.c
> @@ -82,12 +82,19 @@ struct mptcp_storage {
>  
>  static struct nstoken *create_netns(void)
>  {
> -	SYS(fail, "ip netns add %s", NS_TEST);
> -	SYS(fail, "ip -net %s link set dev lo up", NS_TEST);
> +	struct nstoken *nstoken = NULL;
> +
> +	if (make_netns(NS_TEST))

I think it is clearer to explicitly add "< 0", so people would interpret
this line as "if there is an error when creating the netns". Otherwise,
it is not clear if we are going to take the error or the success branch:

  if (make_netns(NS_TEST) < 0)

> +		goto fail;

Maybe clearer with either:

  return NULL;

or below, also use a goto just for the error path:


      struct nstoken *nstoken = NULL;

      if (make_netns(NS_TEST) < 0)
          goto fail;

      nstoken = open_netns(NS_TEST);
      if (!nstoken)
          goto fail;

      return nstoken;

  fail:
      log_err("open netns %s failed", NS_TEST);
      remove_netns(NS_TEST);
      return NULL;

Up to you.

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

