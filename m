Received: from out-189.mta1.migadu.com (out-189.mta1.migadu.com [95.215.58.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF1A62DF67
	for <mptcp@lists.linux.dev>; Fri, 15 Dec 2023 15:45:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="DVUbcVsf"
Message-ID: <9f8d460898f62406cccfddc0a5d69a42da2fe681.camel@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1702655124;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MgF09P8s2OrsAM5DgE/nzR5xazqxN1/AbaLM8/51OiY=;
	b=DVUbcVsf3hYTwvjI/nYPNMX4+AmUSgG2CEDEbZ3I+0nSCrZqQK1pYUDOKI0ElQDAhAUUo1
	K4t0ngrNKXuwOobVGQ2ZQZeiVRBNVeUAnIXxl3IFLTOoQ0DM+1EXgQfPq27YaIwyNmOUq3
	RSt9b1nBCj5Cd6H/fN9lv3cpGfvrL6Q=
Subject: Re: [PATCH mptcp-net] MAINTAINERS: add Geliang as reviewer for MPTCP
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Geliang Tang <geliang.tang@linux.dev>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: Mat Martineau <martineau@kernel.org>, mptcp@lists.linux.dev
Date: Fri, 15 Dec 2023 23:46:17 +0800
In-Reply-To: <20231215-mptcp-reviewers-geliang-v1-1-3fec5a0f8eac@kernel.org>
References: <20231215-mptcp-reviewers-geliang-v1-1-3fec5a0f8eac@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On Fri, 2023-12-15 at 15:45 +0100, Matthieu Baerts wrote:
> For a long time now, Geliang has contributed to a lot of code and
> reviews related to MPTCP. So let's reflect that in the MAINTAINERS
> file.
> 
> This should also encourage patch submitters to add him to the CC
> list.
> 
> Signed-off-by: Matthieu Baerts <matttbe@kernel.org>
> ---
> 
> @Geliang: do you mind publicly acking this patch if you are still OK
> with that?
> Cc: Geliang Tang <geliang.tang@linux.dev>

Thanks Matt.

Acked-by: Geliang Tang <geliang.tang@linux.dev>

> 
> @Mat: can I also add your Acked-by as discussed this week?
> Cc: Mat Martineau <martineau@kernel.org>
> ---
>  MAINTAINERS | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 49c1caad5d99..b7e51b7b8760 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -15076,6 +15076,7 @@ K:      \bmdo_
>  NETWORKING [MPTCP]
>  M:     Matthieu Baerts <matttbe@kernel.org>
>  M:     Mat Martineau <martineau@kernel.org>
> +R:     Geliang Tang <geliang.tang@linux.dev>
>  L:     netdev@vger.kernel.org
>  L:     mptcp@lists.linux.dev
>  S:     Maintained
> 
> ---
> base-commit: 84d8fb414b2a78b32e97b1e4888688bca82aecf5
> change-id: 20231215-mptcp-reviewers-geliang-4d826ebffd8c
> 
> Best regards,

