Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF8BB8487
	for <mptcp@lists.linux.dev>; Sun,  8 Oct 2023 11:25:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BUPpoxlt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD655C433C7;
	Sun,  8 Oct 2023 11:25:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1696764355;
	bh=lsDf2a7HIYC1hZvMIt6vdvvJAbhWO2/G+PKexr64zLE=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=BUPpoxlt8Q+iNBSKAB/QRi/XPwEPfNx2bnHK8J25FfnX9bdup+CY3RIV802RC1Rns
	 jaK9UEZ24gXspgCO0BEd69kpmGW42eya/IdEh9KswDMl7Y5bKOQCDGqsxJmEVakbsv
	 VffYiTM8CR84sucAeD8sU8WUH8AGpsUSJ3U3RJcYN++cnbQnn0WnsaHLSnschL34hF
	 /j2HZ+P+Sik7eHFe9mv6WbzhgWDv5xJCj1NllIAHMZa/pt0ZZkg+QoE1ZAM0YQs1ZV
	 RfUGSb7BZS8rhr0SsL4w2dAlV9Bjm+DO+GbUvxp7lnDrkglFNKgqu8iKPWky603+p5
	 rXJzXjlNp6fkw==
Message-ID: <01dfaf2a-e1a8-45ca-880d-be3a6e213703@kernel.org>
Date: Sun, 8 Oct 2023 13:25:52 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH mptcp-next v11 4/4] selftests: mptcp: userspace pm remove
 id 0 address
Content-Language: en-GB, fr-BE
To: Geliang Tang <geliang.tang@suse.com>, mptcp@lists.linux.dev
References: <cover.1696760702.git.geliang.tang@suse.com>
 <3738a4c89c049ae3b2832206390a39471331865d.1696760702.git.geliang.tang@suse.com>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 Fe7fduHbABmYz9cefQpO7wDE/Q==
Organization: Tessares
In-Reply-To: <3738a4c89c049ae3b2832206390a39471331865d.1696760702.git.geliang.tang@suse.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Geliang,

On 08/10/2023 12:27, Geliang Tang wrote:
> This patch adds a selftest for userpsace PM to remove id 0 address.
> Use userspace_pm_add_addr() helper to add a id 10 address, then use
> userspace_pm_rm_addr() helper to remove id 0 address.
> 
> Signed-off-by: Geliang Tang <geliang.tang@suse.com>
> ---
>  .../testing/selftests/net/mptcp/mptcp_join.sh | 23 +++++++++++++++++++
>  1 file changed, 23 insertions(+)
> 
> diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
> index ce691aeca99e..30b9e367cefa 100755
> --- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
> +++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
> @@ -3511,6 +3511,29 @@ userspace_tests()
>  		kill_events_pids
>  		wait $tests_pid
>  	fi
> +
> +	# userspace pm remove id 0 address
> +	if reset_with_events "userspace pm remove id 0 address" &&

Maybe clearer to say: "userspace pm send RM_ADDR for ID 0", no?

> +	   continue_if mptcp_lib_has_file '/proc/sys/net/mptcp/pm_type'; then
> +		set_userspace_pm $ns1
> +		pm_nl_set_limits $ns2 1 1
> +		speed=10 \
> +			run_tests $ns1 $ns2 10.0.1.1 &
> +		local tests_pid=$!
> +		wait_mpj $ns1
> +		userspace_pm_add_addr $ns1 10.0.2.1 10
> +		chk_join_nr 1 1 1
> +		chk_add_nr 1 1
> +		chk_mptcp_info subflows 1 subflows 1
> +		chk_subflows_total 2 2
> +		chk_mptcp_info add_addr_signal 1 add_addr_accepted 1
> +		userspace_pm_rm_addr $ns1 0
> +		chk_rm_nr 1 0 invert
> +		chk_mptcp_info subflows 1 subflows 1
> +		chk_subflows_total 2 2

(Is it really 2? I guess this is due to your patch 1/4 and we should
have 2 subflows in total here, no?)

After the server has sent a RM_ADDR for ID0, the client with the Netlink
PM will react by closing the subflow, no? If yes, please add a comment
explaining why the subflow has been removed after having sent a RM_ADDR
because it can be confusing.

Also, can you check that no RST has been sent?

Cheers,
Matt

> +		kill_events_pids
> +		wait $tests_pid
> +	fi
>  }
>  
>  endpoint_tests()

-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
