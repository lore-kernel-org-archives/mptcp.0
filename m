Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D692242901
	for <mptcp@lists.linux.dev>; Wed,  5 Mar 2025 11:59:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741175958; cv=none; b=iVwucfMaevpjpuIOV/S0E1p7/Yurb1uA9kgKL8fSaojqPAH9/N4s3UpN2qMUzW4dcBcxyrxmbOnfvbBnEE1H4eucroyG20AVbVlBIUWrvI/QJaOujm4PpnMn8kTmepYys1cor06xEGvFCfrKc88HR2YifXFMvRrUfv1cBIPez2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741175958; c=relaxed/simple;
	bh=4A9AEGT4vuZAtuZ5pGYhQgjI3+hX1SH1TV15vcsqXGg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eJgxnL3JWoGqm+aq90L6b9XRFMInC5+raQ60FR2Wwn7hETn98Zj1tSyMVz99YtndsGsqu0nTxrCblRM4Ys0azkUXgowNRFMm1gOKWZ2pjXwukr5W1gZVZMjRJrFRz9v4IBnMOHn6UDaQ0yU7OAKqRgik1rfDG1vJwF23TxeIYhQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RQWU9pHy; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RQWU9pHy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99DB9C4CEE2;
	Wed,  5 Mar 2025 11:59:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741175958;
	bh=4A9AEGT4vuZAtuZ5pGYhQgjI3+hX1SH1TV15vcsqXGg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=RQWU9pHy/cTzPZbIB5XYNU9XWD/v1HFxlQzDoV3CNgt/RhIxccQZFdm96Dpg2r/hc
	 ZQ6oM+0y2HqufxZu5y6n59Q4pe9PbSoQe5jQ4fb7K016Ttm4BeBXTJmPCv/E2suKU9
	 sTWrhnYSwN14rQ7jU7en77vMpsUMNJzR/iU/Gz4YILMi3BnUWyE3SuswN+40Z/sXP7
	 FXwIo2lLDgiLMak+7T64ZA33GBaBx3K/FAOIO77sPtypbDdwoQBxa660BBu/t8cBZf
	 ctBP8HYs1N0kG4TOlVRunIJysHMUhS58ZwcohTQ7VGFqPhfxhUjAZTZm4DfzXnHJq8
	 5Qqz85HHeUYFQ==
Message-ID: <e27648cb-d28c-4555-903c-f43fa0b7a6d3@kernel.org>
Date: Wed, 5 Mar 2025 12:59:15 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH mptcp-next v8 12/12] selftests: mptcp: add path_manager
 sysctl test
Content-Language: en-GB
To: Geliang Tang <geliang@kernel.org>, mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
References: <cover.1741088339.git.tanggeliang@kylinos.cn>
 <bd2c57de226d1f36f7d9388f50442f32fb300154.1741088339.git.tanggeliang@kylinos.cn>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <bd2c57de226d1f36f7d9388f50442f32fb300154.1741088339.git.tanggeliang@kylinos.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Geliang,

On 04/03/2025 12:40, Geliang Tang wrote:
> From: Geliang Tang <tanggeliang@kylinos.cn>
> 
> This patch adds a new helper set_path_manager() to set the newly added
> net.mptcp.path_manager, and test it inside a userspace pm test.
> 
> Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
> ---
>  .../testing/selftests/net/mptcp/mptcp_join.sh | 34 ++++++++++++++++++-
>  1 file changed, 33 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
> index fa1929ca6ad4..3b43b42f9abe 100755
> --- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
> +++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
> @@ -91,6 +91,19 @@ CBPF_MPTCP_SUBOPTION_ADD_ADDR="14,
>  			       6 0 0 65535,
>  			       6 0 0 0"
>  
> +set_path_manager()
> +{
> +	local ns=$1
> +	local pm=$2
> +
> +	if ! ip netns exec ${ns} sysctl net.mptcp.available_path_managers |
> +	     grep -wq "${pm}"; then
> +		mptcp_lib_pr_fail "path manager ${pm} not found"
> +		return 1
> +	fi
> +	ip netns exec ${ns} sysctl -q net.mptcp.path_manager="${pm}"
> +}
> +
>  init_partial()
>  {
>  	capout=$(mktemp)
> @@ -3619,7 +3632,26 @@ userspace_tests()
>  	# userspace pm create destroy subflow
>  	if reset_with_events "userspace pm create destroy subflow" &&
>  	   continue_if mptcp_lib_has_file '/proc/sys/net/mptcp/pm_type'; then
> -		set_userspace_pm $ns2
> +		if continue_if mptcp_lib_has_file '/proc/sys/net/mptcp/path_manager'; then

Same here, we cannot have continue_if here.

> +			local pm1 pm2
> +
> +			set_path_manager $ns1 "kernel"
> +			set_path_manager $ns2 "userspace"
> +
> +			pm1=$(ip netns exec ${ns1} sysctl -n net.mptcp.pm_type)
> +			if [ "$pm1" != "0" ]; then
> +				mptcp_lib_pr_fail "ns1 pm_type mapping fails"
> +				return 1
> +			fi
> +
> +			pm2=$(ip netns exec ${ns2} sysctl -n net.mptcp.pm_type)
> +			if [ "$pm2" != "1" ]; then
> +				mptcp_lib_pr_fail "ns2 pm_type mapping fails"
> +				return 1
> +			fi

I think it would be better to do that in userspace_pm.sh as suggested in
my review from patch 11/12. So replacing patches 11 and 12 by this one. No?

> +		else
> +			set_userspace_pm $ns2
> +		fi
>  		pm_nl_set_limits $ns1 0 1
>  		{ speed=5 \
>  			run_tests $ns1 $ns2 10.0.1.1 & } 2>/dev/null

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

