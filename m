Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33880CA52
	for <mptcp@lists.linux.dev>; Sun, 28 Dec 2025 02:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766890274; cv=none; b=oOca/BEtLgkWTLtQM9gXH+cQN47/6vENHNEgt4ttPRHzYckdWjtar7bIOgzjtGc2cqarx3F3/seM0z1HC6cuIt7toy1Ivghku+9FPTLOKexRxJ2wZdL/2AhjuiANHuHCqKaabRZM0bzWa4zpV65HWSsC/3T4YAax1VddJkc0GHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766890274; c=relaxed/simple;
	bh=A5RTf/SI1qgu6q24sxSDsm0tA9UoghiAvWdRGQt63os=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=gHEVFWD72IuhkeBK66f3zW6l3n1V/5bPxjYm1GmqDaoa9TRYKkeJ86r3V2GKYW5K2nJ2RKVs+vST1GKWp+xplMUKrGKfKmmyEIh9AKmNTj5JXsBLEYpdGLEC6R/C+AfHolhbG3rzoKLos3ZeE3NLx4w9QeYDiYdE/EoLvt4B2jU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tL5wOPI4; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tL5wOPI4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10093C4CEF1;
	Sun, 28 Dec 2025 02:51:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766890273;
	bh=A5RTf/SI1qgu6q24sxSDsm0tA9UoghiAvWdRGQt63os=;
	h=Subject:From:To:Date:In-Reply-To:References:From;
	b=tL5wOPI4/90rMpVO/0OAHFNAHP02SVQO5xN71lFYLCBBHgvE3WxJPViIrCiAMf9A4
	 cys/QsPvzHZ/kV/JAzl6N3C4rDv2/Y0jAR8kAOpuMoAUIJaHKKIHO/+BXP0IouJ1JZ
	 MUPyTjVMbuuwDTLLUpiO4zYwBxuguzhRrgTL6qntOPXPPPxfSkGei+oVBrnVI01xM9
	 XNZH6UGCCiyXq0ajUToXh6jXfaNVeH2p/6S9Bqzs6dbJJho0/ZJ/s2OmCgN+8C+5IC
	 T7oOI/lJn7BF5vZBJD4QSOr3Jhhvp8qhVpC/oH7AxqNSj1tO2bTonZfUXQtggrvIKF
	 XyPuCB5VjMxdA==
Message-ID: <d16b1a026c14795fe02aaec2a4694ca6dbbb4360.camel@kernel.org>
Subject: Re: [PATCH mptcp-next 09/11] selftests: mptcp: join: avoid
 declaring i if not used
From: Geliang Tang <geliang@kernel.org>
To: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, MPTCP Upstream
	 <mptcp@lists.linux.dev>
Date: Sun, 28 Dec 2025 10:51:10 +0800
In-Reply-To: <20251226-mptcp-issue-603-v1-9-bb30e331b839@kernel.org>
References: <20251226-mptcp-issue-603-v1-0-bb30e331b839@kernel.org>
	 <20251226-mptcp-issue-603-v1-9-bb30e331b839@kernel.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.56.2-4 
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Fri, 2025-12-26 at 07:40 +0100, Matthieu Baerts (NGI0) wrote:
> A few loops were declaring 'i', but this variable was not used.
> 
> To avoid confusions, use '_' instead: it is more explicit to mark
> that
> this variable is not needed.
> 
> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>

    Reviewed-by: Geliang Tang <geliang@kernel.org>

Thanks,
-Geliang

> ---
>  tools/testing/selftests/net/mptcp/mptcp_join.sh | 9 +++------
>  1 file changed, 3 insertions(+), 6 deletions(-)
> 
> diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh
> b/tools/testing/selftests/net/mptcp/mptcp_join.sh
> index 80e03168b419..4ca4bdfea246 100755
> --- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
> +++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
> @@ -603,8 +603,7 @@ wait_rm_addr()
>  	local old_cnt="${2}"
>  	local cnt
>  
> -	local i
> -	for i in $(seq 10); do
> +	for _ in $(seq 10); do
>  		cnt=$(rm_addr_count ${ns})
>  		[ "$cnt" = "${old_cnt}" ] || break
>  		sleep 0.1
> @@ -623,8 +622,7 @@ wait_rm_sf()
>  	local old_cnt="${2}"
>  	local cnt
>  
> -	local i
> -	for i in $(seq 10); do
> +	for _ in $(seq 10); do
>  		cnt=$(rm_sf_count ${ns})
>  		[ "$cnt" = "${old_cnt}" ] || break
>  		sleep 0.1
> @@ -648,8 +646,7 @@ wait_ll_ready()
>  {
>  	local ns="${1}"
>  
> -	local i
> -	for i in $(seq 50); do
> +	for _ in $(seq 50); do
>  		ip -n "${ns}" -6 addr show scope link | grep "inet6
> fe80" |
>  			grep -qw "tentative" || break
>  		sleep 0.1
