Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65A86146A64
	for <mptcp@lists.linux.dev>; Tue, 25 Jun 2024 23:18:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719357520; cv=none; b=SQbi+VGwqrOFAuA6K0ac3FadmuXd7Z2pE1r0Xhy9/VlUA8uUOLQGuHc2l9r4ggS7j4z34XAh68dGiGn4tx62WtoXCw5Ce1uyM+5gBFKsbS6XZrbNDXJRl+ib21SXgn5ED2pVaI8hehvZ/r0zBCkO6FjNnSGDbyVrgE/LG5BldjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719357520; c=relaxed/simple;
	bh=DghHlrb5keCfIUNkzOkcIW/vrAlWCCgOQB0GX9eYPTw=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=kIDGZkTC2/JXnGyWB1plF4vh8bSm3Zw/BGxQL2EHmadSLppMrbuHaYhszv/JnlrwySI/9+AaFgyBV7Q8xO7a9XkCzQG7YMcVrusi48t5nG/BwukG53tFlfRdd16gzhA/CY8SGHZl3R8Uujk5u0FTFWdvcOKerbL4vyEGLThKyYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zo0sayYO; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zo0sayYO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA1BCC32781;
	Tue, 25 Jun 2024 23:18:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719357519;
	bh=DghHlrb5keCfIUNkzOkcIW/vrAlWCCgOQB0GX9eYPTw=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=Zo0sayYOrEUpcUdW33u82b5SNLWCSnEr0tjzQVmLsrxMRl167POr7FiQD4pXAGSt1
	 /VBEYcsNWiVxdglh0S1dcWgkV7ACNgNrbGlKNZMTIdcsP3TzBHmQtPfgKLm9SZexP4
	 tzvkwUOpqJX1iTmbYJTMU99pki4tqLdyqMpPZR//oUHWujuTotihf7gLnEygny8uYl
	 eiC8xMBMj/jKffZUI6hDgKLKFNSab9hm9AOLXB1DPoSQghiZDISeUWLMA3da4idqbO
	 2kuF/KIYF1sRs0CMzxfKA+35bFg0aXjfRH3y2SR115bSkberc/VzjKW/HbhX2dQ4KR
	 75OBrT6JM1h2Q==
Date: Tue, 25 Jun 2024 16:18:39 -0700 (PDT)
From: Mat Martineau <martineau@kernel.org>
To: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
cc: mptcp@lists.linux.dev, Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH mptcp-next 4/4] selftests: mptcp: join: test both signal
 & subflow
In-Reply-To: <20240621-mptcp-pm-avail-v1-4-b692d5eb89b5@kernel.org>
Message-ID: <2dd5acd8-e841-00d8-bdde-6037d6bea3cb@kernel.org>
References: <20240621-mptcp-pm-avail-v1-0-b692d5eb89b5@kernel.org> <20240621-mptcp-pm-avail-v1-4-b692d5eb89b5@kernel.org>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Fri, 21 Jun 2024, Matthieu Baerts (NGI0) wrote:

> It should be quite uncommon to set both the subflow and the signal
> flags: the initiator of the connection is typically the one creating new
> subflows, not the other peer, then no need to announce additional local
> addresses, and use it to create subflows.
>
> But some people might be confused about the flags, and set both "just to
> be sure at least the right one is set". To verify the previous fix, and
> avoid future regressions, this specific case is now validated: the
> client announces a new address, and initiates a new subflow from the
> same address.
>
> While working on this, another bug has been noticed, where the client
> reset the new subflow because an ADD_ADDR echo got received as the 3rd
> ACK: check that no RST have been sent by the client and server.
>
> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
> ---
> tools/testing/selftests/net/mptcp/mptcp_join.sh | 15 +++++++++++++++
> 1 file changed, 15 insertions(+)
>
> diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
> index 5f5e498bbb75..b8c0b69db527 100755
> --- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
> +++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
> @@ -1967,6 +1967,21 @@ signal_address_tests()
> 		chk_add_nr 1 1
> 	fi
>
> +	# uncommon: subflow and signal flags on the same endpoint
> +	# or because the user wrongly picked both, but still expects the client
> +	# to create additional subflows
> +	if reset "subflow and signal together"; then
> +		pm_nl_set_limits $ns1 0 2
> +		pm_nl_set_limits $ns2 0 2
> +		pm_nl_add_endpoint $ns2 10.0.3.2 flags signal,subflow
> +		run_tests $ns1 $ns2 10.0.1.1
> +		chk_join_nr 1 1 1
> +		chk_add_nr 1 1 0 invert  # only initiated by ns2
> +		chk_add_nr 0 0 0         # none initiated by ns1
> +		chk_rst_nr 0 0 invert    # no RST sent by the client
> +		chk_rst_nr 0 0           # no RST sent by the server
> +	fi
> +
> 	# accept and use add_addr with additional subflows
> 	if reset "multiple subflows and signal"; then
> 		pm_nl_set_limits $ns1 0 3

Matthieu -

Related to my feedback on patch 2, it would be good to add a test to 
confirm that announced addr_ids can be reused after they are removed.

- Mat
