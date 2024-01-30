Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF10936119
	for <mptcp@lists.linux.dev>; Tue, 30 Jan 2024 00:50:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706575824; cv=none; b=du/YIzpDoih7w7U/cmXsSvxu4uJvvP6hi9fG1D+Y4IOxhP4aknIacHYHmKd7BmCAvXGDPp/ONn3n8ZOOzoE8h7+D0XU+Me7dhHowg+paI0mXWe88kYZ+RJbeE4hIITvsHDmshrJiSgBHwHNWL4U38kCQR0bNsxtfpqm9yDf7T7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706575824; c=relaxed/simple;
	bh=Odi4r35NXmhTUyxNvmhlhXI72JO91BRIUbpmJkhtGvA=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Vnb3WC3FHRr0g4YzBUGsYpzvxcu0tx0EbcyhbSjNovPW6JqZBpYpACdmusOyIc6mJs1oQggeqrHO0FkuHIXhO6g/m3EHl+iUXgfyAS8dCd3eKgIW3NLXC4oqDlq73247g5s0WAfZMVSZKpYwYw9EVLVJtjF1/+Oo7ZviRgXyjsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E3ohd5fx; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E3ohd5fx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7123FC433F1
	for <mptcp@lists.linux.dev>; Tue, 30 Jan 2024 00:50:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706575824;
	bh=Odi4r35NXmhTUyxNvmhlhXI72JO91BRIUbpmJkhtGvA=;
	h=Date:From:To:Subject:References:In-Reply-To:From;
	b=E3ohd5fxV/MNnVeetFdVnAizQK+KkSegf/zeUR6+oztR56W5ls0uS7ha2qW/Vc9ap
	 Gn/2jARpU8tn8aUcg8z+/XFn0JyxHszbbs7yNG4bSwPBaD19PbT8Qgxb3LczcsZcUC
	 DFWrNRQN/0fVYo+HhaPlJKNrI9NHMmzUdJ5GMl6Cuonl1VGTJcN8SbGpM/YGk1c0rg
	 DSTKP0PnmLT1JOPmBFBM0BiOp9gl5f7c03cDjnsNjL23ICT5oncT4mQK29GOgAl4w1
	 2dTNjJwb4FDtrqZMtBOQCEvinUOYBw1lG90Yt2PrYIrVyvD9mCNjb/TcwrNvw3xF0Z
	 w/65MZbigZKOA==
Date: Tue, 30 Jan 2024 08:50:19 +0800
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Subject: Re: [PATCH virtme-docker 2/3] upgrade to ubuntu 23.10
Message-ID: <ZbhHy6GPo4UcCKy0@t480>
References: <cover.1706422466.git.geliang@kernel.org>
 <dc2e14b63fd7ec288e015124919c28c9470d5913.1706422466.git.geliang@kernel.org>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dc2e14b63fd7ec288e015124919c28c9470d5913.1706422466.git.geliang@kernel.org>

On Sun, Jan 28, 2024 at 02:16:02PM +0800, Geliang Tang wrote:
> There will be many build errors when comliling bpf selftests under
> Ubuntu 22.04. Upgrade to 23.10 to use the new versions of gcc, clang
> and LLVM.
> 
> Fix sparse build errors for llvm-16. This part alse be sent to sparse
> upstream. It can be dropped from this patch when accepted.

This part has been upstreamed, we can drop it now from this patch.

> 
> Signed-off-by: Geliang Tang <geliang@kernel.org>
> ---
>  Dockerfile | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/Dockerfile b/Dockerfile
> index cf8c692..cbc11f7 100644
> --- a/Dockerfile
> +++ b/Dockerfile
> @@ -1,4 +1,4 @@
> -FROM ubuntu:22.04
> +FROM ubuntu:23.10
>  
>  LABEL name=mptcp-upstream-virtme-docker
>  
> @@ -71,6 +71,10 @@ ARG SPARSE_GIT_SHA="ce1a6720f69e6233ec9abd4e9aae5945e05fda41" # include a fix fo
>  RUN cd /opt && \
>  	git clone "${SPARSE_GIT_URL}" sparse && \
>  	cd "sparse" && \
> +		sed -i 's/LLVMConstGEP(/LLVMConstGEP2(type, /g' sparse-llvm.c && \
> +		sed -i 's/LLVMBuildInBoundsGEP(builder/LLVMBuildInBoundsGEP2(builder, type/g' sparse-llvm.c && \
> +		sed -i 's/LLVMBuildLoad(fn->builder/LLVMBuildLoad2(fn->builder, insn_symbol_type(insn)/g' sparse-llvm.c && \
> +		sed -i 's/LLVMBuildCall(fn->builder/LLVMBuildCall2(fn->builder, insn_symbol_type(insn)/g' sparse-llvm.c && \
>  		make -j"$(nproc)" -l"$(nproc)" && \
>  		make PREFIX=/usr install && \
>  		cd .. && \
> -- 
> 2.40.1
