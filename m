Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 648DF136F
	for <mptcp@lists.linux.dev>; Sat,  6 Jan 2024 01:04:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qpWmtP61"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA57EC433C7;
	Sat,  6 Jan 2024 01:04:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704503081;
	bh=Uuxktpxus1kRMgFo4e0soCW/vHk0fe+Di1Tng/Hc44E=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=qpWmtP61K0Keh2X/mC68k73ohpHBmLPQhCcqQd6QAiIg+mUBCNWqMD+XbQ7CHhRT5
	 pueKRq00GrroVEZkuKzYk0N7TSOEkup74zluW/5QSb9ELMVEmNZ5foinGg3suDNoQV
	 19g99IT1bj5BOsJ9PLFAwR84HmjBqxh3gFdtaQ69bZnsGJ/y4uOKO2ohcdn6+2T7A8
	 omJkcDU9XTi/9NZlpwy3k/zZ7oR2Hj3Y0ZnI+7VH+SvEsh+Fm/7j2x0VQKw5xK7hrl
	 A64YVvrEEuUwX5xELKxI8FXl0gbbhbyf5dTJhSZdSLxLlBOCJzZuNoTI43l9yqSW8/
	 xfVnQqml8M1bA==
Date: Fri, 5 Jan 2024 17:04:41 -0800 (PST)
From: Mat Martineau <martineau@kernel.org>
To: Geliang Tang <geliang.tang@linux.dev>
cc: mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-next v7 06/24] selftests: mptcp: rm subflow with
 v4/v4mapped addr
In-Reply-To: <7a78251539a8f39951087b337dc6ab809563c74e.1703904325.git.geliang.tang@linux.dev>
Message-ID: <9b35c17d-6fce-5755-0b25-5e4b8d268f2f@kernel.org>
References: <cover.1703904325.git.geliang.tang@linux.dev> <7a78251539a8f39951087b337dc6ab809563c74e.1703904325.git.geliang.tang@linux.dev>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII

On Sat, 30 Dec 2023, Geliang Tang wrote:

> Now both a v4 address and a v4-mapped address are supported when
> destroying a userspace pm subflow, this patch adds random tests for both
> addresses.
>
> Signed-off-by: Geliang Tang <geliang.tang@linux.dev>

Hi Geliang,

The changes look good. I'm marking this as "Changes Required" in patchwork 
since it depends on patch 5 (which only needs some commit message 
updates). Would be good to have a Fixes tag if this is going to -net too.

- Mat


> ---
> tools/testing/selftests/net/mptcp/mptcp_join.sh | 11 ++++++++---
> 1 file changed, 8 insertions(+), 3 deletions(-)
>
> diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
> index 3a5b63026191..915ec79f5030 100755
> --- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
> +++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
> @@ -3340,12 +3340,13 @@ userspace_pm_rm_sf()
> {
> 	local evts=$evts_ns1
> 	local t=${3:-1}
> -	local ip=4
> +	local ip
> 	local tk da dp sp
> 	local cnt
>
> 	[ "$1" == "$ns2" ] && evts=$evts_ns2
> -	if mptcp_lib_is_v6 $2; then ip=6; fi
> +	[ -n "$(mptcp_lib_evts_get_info "saddr4" "$evts" $t)" ] && ip=4
> +	[ -n "$(mptcp_lib_evts_get_info "saddr6" "$evts" $t)" ] && ip=6
> 	tk=$(mptcp_lib_evts_get_info token "$evts")
> 	da=$(mptcp_lib_evts_get_info "daddr$ip" "$evts" $t)
> 	dp=$(mptcp_lib_evts_get_info dport "$evts" $t)
> @@ -3448,7 +3449,11 @@ userspace_tests()
> 		chk_subflows_total 2 2
> 		chk_mptcp_info add_addr_signal 1 add_addr_accepted 1
> 		userspace_pm_rm_addr $ns1 10
> -		userspace_pm_rm_sf $ns1 "::ffff:10.0.2.1" $SUB_ESTABLISHED
> +		if [ $((RANDOM%2)) -eq 0 ]; then
> +			userspace_pm_rm_sf $ns1 ::ffff:10.0.2.1 $SUB_ESTABLISHED
> +		else
> +			userspace_pm_rm_sf $ns1 10.0.2.1 $SUB_ESTABLISHED
> +		fi
> 		chk_rm_nr 1 1 invert
> 		chk_mptcp_info subflows 0 subflows 0
> 		chk_subflows_total 1 1
> -- 
> 2.39.2
>
>
>
