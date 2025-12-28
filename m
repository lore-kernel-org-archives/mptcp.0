Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B65DCA52
	for <mptcp@lists.linux.dev>; Sun, 28 Dec 2025 02:48:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766890102; cv=none; b=AO1W4jU++bVnlatgZEK2/cRawXkp7E/KcMp944b4AQCwegXniUQ3QGmLiFkcnxnRXPzsD8+8+shfFu8pJtakvZzuJ+auFSaghjze2w+H/uPXVHMIqhO6e6II3BdGUEXIinpdneRvXv4jFMeOKRX+F2RjHVe5Y1d4tKJVXdGkR3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766890102; c=relaxed/simple;
	bh=54pnAwbNIhhR+9OLsdiT1FjaUpV/yE2bgZourd+WsMg=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=gHgWJbSpIjEhg9rU/2jjuY4I7WsIDTplqev1DCCUqAFzQb5CiNJdq07kxw5/hCkI3T3T9JuYNQzA86r4+hlarRedD9Th8xJ8TT0QeEDvGSfe0CPlH8owQ2RqEXro1uCKYvVB+EpKIwvWUsaxaLCmnykF1ht8uYwqX9w5D6InaTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NSPlbpck; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NSPlbpck"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 085E1C4CEF1;
	Sun, 28 Dec 2025 02:48:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766890101;
	bh=54pnAwbNIhhR+9OLsdiT1FjaUpV/yE2bgZourd+WsMg=;
	h=Subject:From:To:Date:In-Reply-To:References:From;
	b=NSPlbpckQOoPka/+oBehC4UXf8IK3WyzfiHN21ORiX5PivVEg5bJB1AkBbXFReTVy
	 6DqeGVTRz3eSK62/NxSLf1gdsez+Bd7PKPdA2ZRrWYdASp8pBUzqzgNcEetuJq4YON
	 8R4P+RS5N/iezcJogz2MHbce+KqDO35BABEYc/yeQfc0+XKnUEbl2/cIzosm5QJum1
	 1vE6gmW2tp9cWQjGnvMf9+P3taYE2AFJsb7F9Z9rJ4d0a5MOUM6Zarhy8T6pwySatn
	 NiONlodTM6gwETnY6TLtIJT1ph2MObyDVAN11hLDow/EL9sCTbGKBycUo4z07PUR2W
	 aeUujoSNVxAoA==
Message-ID: <bf6e805ec8310f0814db3b05d51cc78f0bf77a92.camel@kernel.org>
Subject: Re: [PATCH mptcp-next 07/11] selftests: mptcp: join: userspace:
 wait for new events
From: Geliang Tang <geliang@kernel.org>
To: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, MPTCP Upstream
	 <mptcp@lists.linux.dev>
Date: Sun, 28 Dec 2025 10:48:19 +0800
In-Reply-To: <20251226-mptcp-issue-603-v1-7-bb30e331b839@kernel.org>
References: <20251226-mptcp-issue-603-v1-0-bb30e331b839@kernel.org>
	 <20251226-mptcp-issue-603-v1-7-bb30e331b839@kernel.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.56.2-4 
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Matt,

Thanks for this patch.

On Fri, 2025-12-26 at 07:40 +0100, Matthieu Baerts (NGI0) wrote:
> Instead of waiting for a random amount of time (1 second), wait for
> an
> event to be received on the other side.
> 
> To do that, when an address is announced (userspace_pm_add_addr), the
> ANNOUNCED is expected. When a new subflow is created
> (userspace_pm_add_sf), the SUB_ESTABLISHED event is expected.
> 
> With this, the tests can finish quicker.
> 
> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
> ---
>  tools/testing/selftests/net/mptcp/mptcp_join.sh | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh
> b/tools/testing/selftests/net/mptcp/mptcp_join.sh
> index cf28537b71f7..63a84a4d43a6 100755
> --- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
> +++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
> @@ -3717,7 +3717,6 @@ userspace_pm_add_addr()
>  	tk=$(mptcp_lib_evts_get_info token "$evts")
>  
>  	ip netns exec $1 ./pm_nl_ctl ann $2 token $tk id $3
> -	sleep 1
>  }
>  
>  # $1: ns ; $2: id
> @@ -3748,7 +3747,6 @@ userspace_pm_add_sf()
>  
>  	ip netns exec $1 ./pm_nl_ctl csf lip $2 lid $3 \
>  				rip $da rport $dp token $tk
> -	sleep 1
>  }
>  
>  # $1: ns ; $2: addr $3: event type
> @@ -4000,7 +3998,9 @@ userspace_tests()
>  		local tests_pid=$!
>  		wait_event ns1 MPTCP_LIB_EVENT_ESTABLISHED 1
>  		userspace_pm_add_addr $ns1 10.0.2.1 10
> +		wait_event ns2 MPTCP_LIB_EVENT_ANNOUNCED 1
>  		userspace_pm_add_addr $ns1 10.0.3.1 20
> +		wait_event ns2 MPTCP_LIB_EVENT_ANNOUNCED 2

This has been changed to wait for 2 seconds. Can it revert to waiting
for only 1 second like before?

Thanks,
-Geliang

>  		chk_join_nr 2 2 2
>  		chk_add_nr 2 2
>  		chk_mptcp_info subflows 2 subflows 2
> @@ -4033,6 +4033,7 @@ userspace_tests()
>  		local tests_pid=$!
>  		wait_event ns2 MPTCP_LIB_EVENT_ESTABLISHED 1
>  		userspace_pm_add_sf $ns2 10.0.3.2 20
> +		wait_event ns2 MPTCP_LIB_EVENT_SUB_ESTABLISHED 1
>  		chk_join_nr 1 1 1
>  		chk_mptcp_info subflows 1 subflows 1
>  		chk_subflows_total 2 2
> @@ -4063,6 +4064,7 @@ userspace_tests()
>  		chk_mptcp_info subflows 0 subflows 0
>  		chk_subflows_total 1 1
>  		userspace_pm_add_sf $ns2 10.0.3.2 0
> +		wait_event ns2 MPTCP_LIB_EVENT_SUB_ESTABLISHED 1
>  		userspace_pm_chk_dump_addr "${ns2}" \
>  			"id 0 flags subflow 10.0.3.2" "id 0 subflow"
>  		chk_join_nr 1 1 1
> @@ -4082,6 +4084,7 @@ userspace_tests()
>  		local tests_pid=$!
>  		wait_event ns2 MPTCP_LIB_EVENT_ESTABLISHED 1
>  		userspace_pm_add_sf $ns2 10.0.3.2 20
> +		wait_event ns2 MPTCP_LIB_EVENT_SUB_ESTABLISHED 1
>  		chk_join_nr 1 1 1
>  		chk_mptcp_info subflows 1 subflows 1
>  		chk_subflows_total 2 2
> @@ -4106,6 +4109,7 @@ userspace_tests()
>  		local tests_pid=$!
>  		wait_event ns1 MPTCP_LIB_EVENT_ESTABLISHED 1
>  		userspace_pm_add_addr $ns1 10.0.2.1 10
> +		wait_event ns2 MPTCP_LIB_EVENT_ANNOUNCED 1
>  		chk_join_nr 1 1 1
>  		chk_add_nr 1 1
>  		chk_mptcp_info subflows 1 subflows 1
> @@ -4132,6 +4136,7 @@ userspace_tests()
>  		local tests_pid=$!
>  		wait_event ns2 MPTCP_LIB_EVENT_ESTABLISHED 1
>  		userspace_pm_add_sf $ns2 10.0.3.2 20
> +		wait_event ns2 MPTCP_LIB_EVENT_SUB_ESTABLISHED 1
>  		chk_mptcp_info subflows 1 subflows 1
>  		chk_subflows_total 2 2
>  
