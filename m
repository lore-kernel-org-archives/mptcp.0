Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B48C42417C3
	for <mptcp@lists.linux.dev>; Tue,  4 Nov 2025 05:53:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762235632; cv=none; b=WTzrXasP+XVzluQh6tacvVy+r463r7KgirRuQdSiwZfdS0wFRgzN7aE1eLlu/fXMkCaE6SX/yiKVGS3SsFre+PB1R89/rxPeDbK3cfECrYA0veIK8WI3thQFksPoyLU7dS9hNpIMXYFujKJFCG5jO6Z7cfJ7S++sbtr9i8z6gp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762235632; c=relaxed/simple;
	bh=D0Oqoiwef0Vm5kUCY6Tfc0m6QtYJvqIhwu0+xKGpUs8=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=lE11SBzr+zjMx5nCOYLWeSQyNp816LN/R9zIlKyU4LH31tUHDvzEkXwd/UV//rc5oLLTPTs0UWzKYQY1su7uDqeB8XogYq2kgQ8VnhcvDUO6eQkoy4Fqkw+AJAQitoKsQ1jZZLOZ+Q3hFf/Ew0JgnZC8t3NI+2wn8aKBDJka+tM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DcwwXz9w; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DcwwXz9w"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B10CC4CEF7;
	Tue,  4 Nov 2025 05:53:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762235632;
	bh=D0Oqoiwef0Vm5kUCY6Tfc0m6QtYJvqIhwu0+xKGpUs8=;
	h=Subject:From:To:Date:In-Reply-To:References:From;
	b=DcwwXz9wDDaaIm6zer+f2wluInn6ns9tk1+EBlkRUaV/pVkWrFJFnGWibnIXiVYKp
	 eQsESKjwLivCR52NNT/3ryPAgJIV+ikYsqHMl08aNNw1DajmN1VbJYrOcLhfHcDZay
	 lSpV+qpK+JGBshz9vxKaVhH3TgWzhaWynR8TxN2N2PCeCbf+/03Sy56UbsSK3xmade
	 eHJKf46veyk0CxnxeQZ3lPTqfv2C6kQcmRoOvV5UQ36faPSVt6ME+BEOeGlEmWtj4J
	 hVCiR78OeKpNl8rOgokY8n1vppkeTLAolJM4QjX+Q6vST5jY8/AVQjo/f41YSulgpu
	 elj5Z7RBcIkrQ==
Message-ID: <a8ddb726e2a2bf7242c5ec776ee7e4cca5e2450e.camel@kernel.org>
Subject: Re: [PATCH mptcp-net v2 1/6] selftests: mptcp: connect: fix
 fallback note due to OoO
From: Geliang Tang <geliang@kernel.org>
To: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, MPTCP Upstream
	 <mptcp@lists.linux.dev>
Date: Tue, 04 Nov 2025 13:53:47 +0800
In-Reply-To: <20251102-slft-join-inst-v2-1-b4f3ba15a7c4@kernel.org>
References: <20251102-slft-join-inst-v2-0-b4f3ba15a7c4@kernel.org>
	 <20251102-slft-join-inst-v2-1-b4f3ba15a7c4@kernel.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.52.3-0ubuntu1 
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Matt,

On Sun, 2025-11-02 at 12:30 +0100, Matthieu Baerts (NGI0) wrote:
> The "fallback due to TCP OoO" was never printed because the
> stat_ooo_now
> variable was checked twice: once in the parent if-statement, and one
> in
> the child one. The second condition was then always true then, and
> the
> 'else' branch was never taken.

Good catch!

Reviewed-by: Geliang Tang <geliang@kernel.org>

Thanks,
-Geliang

> 
> The idea is that when there are more ACK + MP_CAPABLE than expected,
> the
> test either fails if there was no out of order packets, or a notice
> is
> printed.
> 
> Fixes: 69ca3d29a755 ("mptcp: update selftest for fallback due to
> OoO")
> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
> ---
>  tools/testing/selftests/net/mptcp/mptcp_connect.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect.sh
> b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
> index 47ecb5b3836e..9b7b93f8eb0c 100755
> --- a/tools/testing/selftests/net/mptcp/mptcp_connect.sh
> +++ b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
> @@ -492,7 +492,7 @@ do_transfer()
>  				  "than expected (${expect_synrx})"
>  		retc=1
>  	fi
> -	if [ ${stat_ackrx_now_l} -lt ${expect_ackrx} ] && [
> ${stat_ooo_now} -eq 0 ]; then
> +	if [ ${stat_ackrx_now_l} -lt ${expect_ackrx} ]; then
>  		if [ ${stat_ooo_now} -eq 0 ]; then
>  			mptcp_lib_pr_fail "lower MPC ACK rx
> (${stat_ackrx_now_l})" \
>  					  "than expected
> (${expect_ackrx})"
> 

