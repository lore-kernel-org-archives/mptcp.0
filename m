Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03C212AE66
	for <mptcp@lists.linux.dev>; Wed,  3 Sep 2025 09:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756892992; cv=none; b=DfvMwX63liLE8ZJLOU/SY9rafa96PBvHc0uLknhOiqDbnCtb1ROtHm1WeVrRxoenAPTLK2CLB9gdYHrXZ5Gm1uAdmFVNEuWAIR2MTcN6VpdXz1yDT2EObBu7bbMqgWPxhot1zGz+yCzS1ZOYLsMm7r+YCXdBDlKXNQ5G2TZBYkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756892992; c=relaxed/simple;
	bh=jXG7BukvM4cOUQNCZ/+Clpiv0kz9FeflckuvfDayUYI=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=s58BJ26qprXJgEw+1N0zrRU1ZM2dD7++ZJELP1TbkKxweaP/XAIRA9RJDpBW391l4cdV9jQp1Sfsui7CamvGUqAe2FnAJKDyMuRBDRVJHTcj07OqejKRc3zunSJlzeeroK/UFmZy0wJP1LYTYRmcS53muKsOGfmOkdU5OKyXsgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SFTfUIKU; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SFTfUIKU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8E2FC4CEF0;
	Wed,  3 Sep 2025 09:49:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756892991;
	bh=jXG7BukvM4cOUQNCZ/+Clpiv0kz9FeflckuvfDayUYI=;
	h=Subject:From:To:Date:In-Reply-To:References:From;
	b=SFTfUIKUBkYk8Hyrt2dd2SjMdCA4UAlTIZWL4ltkem/Z5RyEKp3n2nVq3P+PFHQl6
	 wsr4sFJweTiWfkdV1R/WvDVQo1YSiPmXCloQJvKRXjDONe4T76aGmhELlcL/VLy3un
	 tDbh81q01MsS+16nkz6ttP8viJQaSe9wN/5XNIlqsxHqfPWIJRjEOW5HtpDKiUPlw/
	 EJv2EHYHBunbB7aIMJsyV5EKwl/qmh8PiLnaeh5JJSQHtSN7bJS5VMnbcrUEUn6TdP
	 zLCrRpjTUY9TwsyBFc/MYR4k7/tVcm1da/9EeJzjRojJ+4CjBXoHcMpZ6ei+RRWEQ4
	 M95/0EapnFyag==
Message-ID: <15207e2aa2d8b83e10515798c05ae775d2bcb493.camel@kernel.org>
Subject: Re: [PATCH mptcp-next 3/3] selftests: mptcp: join: allow more time
 to send ADD_ADDR
From: Geliang Tang <geliang@kernel.org>
To: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, mptcp@lists.linux.dev
Date: Wed, 03 Sep 2025 17:49:44 +0800
In-Reply-To: <20250902-sft-mptcp-join-add_addr-no-retrans-v1-3-956a315d6a5a@kernel.org>
References: 
	<20250902-sft-mptcp-join-add_addr-no-retrans-v1-0-956a315d6a5a@kernel.org>
	 <20250902-sft-mptcp-join-add_addr-no-retrans-v1-3-956a315d6a5a@kernel.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.56.0-1 
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Matt,

On Tue, 2025-09-02 at 21:01 +0200, Matthieu Baerts (NGI0) wrote:
> When many ADD_ADDR need to be sent, it can take some time to send
> each
> of them, and create new subflows. Some CIs seem to occasionally have
> issues with these tests, especially with "debug" kernels.
> 
> Two subtests will now run for a slightly longer time: the last two
> where
> 3 or more ADD_ADDR are sent during the test.
> 
> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>

LGTM!

Reviewed-by: Geliang Tang <geliang@kernel.org>

Thanks,
-Geliang

> ---
>  tools/testing/selftests/net/mptcp/mptcp_join.sh | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh
> b/tools/testing/selftests/net/mptcp/mptcp_join.sh
> index
> 1028f3f931612d98e828707a9f55caa69be4a6ca..9c1ab36110850dcc35bb77e2d58
> 94d8b1dd496a0 100755
> --- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
> +++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
> @@ -2266,7 +2266,8 @@ signal_address_tests()
>  		pm_nl_add_endpoint $ns1 10.0.3.1 flags signal
>  		pm_nl_add_endpoint $ns1 10.0.4.1 flags signal
>  		pm_nl_set_limits $ns2 3 3
> -		run_tests $ns1 $ns2 10.0.1.1
> +		speed=slow \
> +			run_tests $ns1 $ns2 10.0.1.1
>  		chk_join_nr 3 3 3
>  		chk_add_nr 3 3
>  	fi
> @@ -2278,7 +2279,8 @@ signal_address_tests()
>  		pm_nl_add_endpoint $ns1 10.0.3.1 flags signal
>  		pm_nl_add_endpoint $ns1 10.0.14.1 flags signal
>  		pm_nl_set_limits $ns2 3 3
> -		run_tests $ns1 $ns2 10.0.1.1
> +		speed=slow \
> +			run_tests $ns1 $ns2 10.0.1.1
>  		join_syn_tx=3 \
>  			chk_join_nr 1 1 1
>  		chk_add_nr 3 3
