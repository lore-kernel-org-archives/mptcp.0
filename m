Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6FE3243968
	for <mptcp@lists.linux.dev>; Wed,  3 Sep 2025 09:19:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756891172; cv=none; b=BH9bqifYMM1Fu7lXiVkk7REa/1WdB8jhGKdoj7dgT/yIPMdEquncmai6MJ4XpdcZzkdeTyBSlw3or8ArMeDBH+1xHl75GTuk0hI+yE71gpbAStF4Nepppw+hGBadFLpOJEeeP1f/tiqNYRT0mwUjksRjj0AcDx3qV8QQY75An2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756891172; c=relaxed/simple;
	bh=QEXcxIunv7Jc5tXDYYE4DrLz6/9d4tEeS29NL1eCipk=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=nFBSobzEjGTZ4ozKuQsToVVxtZpz5TStbBL9HLgGplYrlUgjOkjQi52ha5DVpcIZ9qHWIh8X6rRVNts6vWSpa1DzmdX9QwN+O9iuuq/rsQrEpUV/QoVUwZ8jFIQBguNexAhUhgd2m2oOO72Bs74FT9nAaJkdtEqDuIf58Lh+Buk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VOH1Eedq; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VOH1Eedq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E0D6C4CEF5;
	Wed,  3 Sep 2025 09:19:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756891172;
	bh=QEXcxIunv7Jc5tXDYYE4DrLz6/9d4tEeS29NL1eCipk=;
	h=Subject:From:To:Date:In-Reply-To:References:From;
	b=VOH1Eedq4S4ZQAsPPFPt+CwA50tfUiItCPizgVNbiM5mmoXQTyILkQCoE8AYtNz1x
	 FrZ88VYjjnUe96O5BZHbzOjuM8SHEEbo/3EnAkje3kiv8Ut/bLuUExJqKOtxbO4HzP
	 KF+lpjZJqXY3yu/XfaLrO75mZI36wofU/3VQ4zlR72gYkYF86EbtENG/jP/zzBrWaE
	 WSnIjcFMua6dXSAHXT6oSJFbUj666DDhdo0MFOKb6LgUhy87OrRZeRMyHQU4vwzEPE
	 qSnaHwau1d4e70W4nItbRLnf/8ojDeKZDLiE6n1CcEDEgam53nsPbGjSBg1RDg9oSg
	 2kM/Am/1WPL1w==
Message-ID: <c5e62f971d89fabcae32ee2b924b5d6f34e2934b.camel@kernel.org>
Subject: Re: [PATCH mptcp-next 1/3] Squash to "selftests: mptcp: remove
 add_addr_timeout settings"
From: Geliang Tang <geliang@kernel.org>
To: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, mptcp@lists.linux.dev
Date: Wed, 03 Sep 2025 17:19:27 +0800
In-Reply-To: <20250902-sft-mptcp-join-add_addr-no-retrans-v1-1-956a315d6a5a@kernel.org>
References: 
	<20250902-sft-mptcp-join-add_addr-no-retrans-v1-0-956a315d6a5a@kernel.org>
	 <20250902-sft-mptcp-join-add_addr-no-retrans-v1-1-956a315d6a5a@kernel.org>
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
> This reverts the patch: when add_addr_timeout is set to 1,
> chk_add_nr()
> and chk_add_tx_nr() are more tolerant with retransmissions, see
> commit
> 6ef84b1517e0 ("selftests: mptcp: more robust signal race test").
> 
> But the main reason is that this revert breaks the selftests running
> on
> old kernels.
> 
> It is then important to keep this. Plus it still acts as a maximum,
> just
> in case everything is very slow, we still have retransmissions in
> time,
> especially with the new exponential backoff.
> 
> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>

I agree.

Reviewed-by: Geliang Tang <geliang@kernel.org>

Thanks,
-Geliang

> ---
>  tools/testing/selftests/net/mptcp/mptcp_join.sh | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh
> b/tools/testing/selftests/net/mptcp/mptcp_join.sh
> index
> a97b568104bc284f050b2f0e09fe3fdd3341c5cb..2f046167a0b6cc6fb5531a033d8
> d95c9ea399cf9 100755
> --- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
> +++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
> @@ -358,6 +358,8 @@ reset_with_add_addr_timeout()
>  		tables="${ip6tables}"
>  	fi
>  
> +	ip netns exec $ns1 sysctl -q net.mptcp.add_addr_timeout=1
> +
>  	if ! ip netns exec $ns2 $tables -A OUTPUT -p tcp \
>  			-m tcp --tcp-option 30 \
>  			-m bpf --bytecode \
> @@ -2303,6 +2305,7 @@ signal_address_tests()
>  		pm_nl_add_endpoint $ns2 10.0.4.2 flags signal
>  
>  		# the peer could possibly miss some addr
> notification, allow retransmission
> +		ip netns exec $ns1 sysctl -q
> net.mptcp.add_addr_timeout=1
>  		speed=slow \
>  			run_tests $ns1 $ns2 10.0.1.1
>  
