Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 620B613C914
	for <mptcp@lists.linux.dev>; Thu, 23 May 2024 09:22:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716456173; cv=none; b=jI4ag7d+ByMre+etXM1+usdrJlOXIwr1S1m/lsR9ag/NfB11KjxV3X9BvOn9cctpVV/K1zvbz08AX8Ow4p4xY36JnL91K9BM/tVYzkH37FfXnA826ruhKqNcL58jXhDxowDTXDcy81ZzGyvjdX5nlHGyCObuVuuILmS9MZpGWQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716456173; c=relaxed/simple;
	bh=9j1dGMyCPPYKsN6Vlq1jUKsoCs+4m9YQf4i9Kl4mXfw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CTBWiIHFLQiMTl42IpeaOmXdJAGa3xx11wMqAChsL1ltweckLcyYRRfeBULU+mOCUUgnGv1tEx0LdTwtmCUFmHoNC5wNwfsKuD+IBET9TyFSqVBYdrVD0kl5r9hdn3CxMLsutdwNoGIfxbEeedAOdvHK8o9gER/g5sGthENAMFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vN+awECM; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vN+awECM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D046C3277B;
	Thu, 23 May 2024 09:22:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716456172;
	bh=9j1dGMyCPPYKsN6Vlq1jUKsoCs+4m9YQf4i9Kl4mXfw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=vN+awECMgHit1XM2tVf4xgWyfeHbXIYU4Ib4Qmdz+t/KjljupNAxKyBItdP6Ssorf
	 FLY4P5xwwuedwqBvhIoNf2PKhbXb0xYlPZnlJduZAbNPYwJOQCwfGp4k2tP6rQS4EJ
	 bmpnKotE8jqXffZMWl6I8C9L5ourgU+eVHhdzdzuTXwTFXoztSZmYleL4QIDKW1Jbm
	 69H4HAD1oUG3hd4BPCVPkWvgFbMrml5b5Qc3ExNg+kDzNQUSYDTyihF83GCaWhF6dl
	 8Rl8frIKgRk7yV5exwrC1XZLHnWkTxes9S7yOSQpih8+8VGluPVvdcPy71kReSjZjc
	 +Gf9O/ruhQeiw==
Message-ID: <77b181f2-cff1-4747-9a4e-5633d54c3121@kernel.org>
Date: Thu, 23 May 2024 11:22:49 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH mptcp-next v2 3/4] selftests: mptcp: use cleanup_all_ns
 helper in lib.sh
Content-Language: en-GB
To: Geliang Tang <geliang@kernel.org>, mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
References: <cover.1716451525.git.tanggeliang@kylinos.cn>
 <d341c904ef486b7e0039c3812ddd659ef7791f9f.1716451525.git.tanggeliang@kylinos.cn>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <d341c904ef486b7e0039c3812ddd659ef7791f9f.1716451525.git.tanggeliang@kylinos.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Geliang,

On 23/05/2024 10:08, Geliang Tang wrote:
> From: Geliang Tang <tanggeliang@kylinos.cn>
> 
> This patch uses cleanup_all_ns() helper defined in lib.sh instead of
> all mptcp_lib_ns_exit() in mptcp seltests. And drop this duplicate
> mptcp helper in mptcp_lib.sh.
> 
> In mptcp_connect.sh, drop mptcp_lib_ns_exit in check_mptcp_disabled()
> directly, this "disabled_ns" will be deleted by cleanup_all_ns() in
> cleanup(), together with "ns1 - ns4".

Mmh, I think it is better to clear resources when we don't need them,
than cleaning them all at the end. New code doing that might be OK, but
here switching to that while not really gaining anything new looks less
good.

> In mptcp_join.sh, drop mptcp_lib_ns_exit in cleanup_partial() directly,
> each existing namespace will delete automaticly in setup_ns(), only
> adding cleanup_all_ns in cleanup() is enough.

Mmh, same here: I think it is better to clean at the end of a test, than
at the beginning of a new one: if there are issues to delete it, it will
be clearer it is due to the previous test, not the new one.

(...)

> diff --git a/tools/testing/selftests/net/mptcp/mptcp_lib.sh b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
> index 59eb77e7813d..bd7d78e4aa83 100644
> --- a/tools/testing/selftests/net/mptcp/mptcp_lib.sh
> +++ b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
> @@ -424,14 +424,6 @@ mptcp_lib_ns_init() {
>  	done
>  }
>  
> -mptcp_lib_ns_exit() {
> -	local netns
> -	for netns in "${@}"; do
> -		ip netns del "${netns}"
> -		rm -f /tmp/"${netns}".{nstat,out}

These files are no longer removed. It is then no longer just a "simple"
refactoring. Such behaviour change should be mentioned in the commit
message, explaining why it is OK to do that.

I would suggest to keep mptcp_lib_ns_exit helper(), and simply call
'cleanup_ns "${@}"' here instead. If you do that, there is no need to
modify the other selftests, and you can squash this in patch 2 with
'setup_ns()'. WDYT?

> -	done
> -}
> -
>  mptcp_lib_events() {
>  	local ns="${1}"
>  	local evts="${2}"

(...)

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

