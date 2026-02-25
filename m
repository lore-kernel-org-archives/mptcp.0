Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A18253D1CA7
	for <mptcp@lists.linux.dev>; Wed, 25 Feb 2026 17:51:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772041880; cv=none; b=ItuLL33LJzV+fmcqbXTls2p1xIdxn0BUqxPTss1atQcftzWzoopzgNbSCewkKM15dAFqi0FqCX1Rtx0c72oytAD4Krb/7obenfrt9KBtk1PwZwGh0xuyDMLazXD7397oA20P06bo4YXQtS4toSqrX3VYg6JHNCpRvvSGkinfWVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772041880; c=relaxed/simple;
	bh=9KACtRSsnmfVn5XCKTiwUinEDyUzvp4EIYF6H9RLuTQ=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=BpUJHO9NpIzeo3rHU0vod4roXOudkdBArOaxPxroP3R0OooRsmVX5bQiSBfSR49vA+/u/SgHetcctddMD+VW5oTmNh6KNZOefKqeTNcmfss15/enfvSUbiSu2HO55agnN05Z4uxkjtz0z5FRlJgT0rG6CmuHrgyP2iBD59JHUXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=btDIqrSD; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="btDIqrSD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43C0FC116D0;
	Wed, 25 Feb 2026 17:51:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772041880;
	bh=9KACtRSsnmfVn5XCKTiwUinEDyUzvp4EIYF6H9RLuTQ=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=btDIqrSDQqyiICPrVJX/DnY+o2truq1E4VoPhOgGIkKRkgFebu/SAIZv2C4EqTNEB
	 IG4F5Rz9cUlTF+Xf7P0TCYB8BXmnpIkGfJsEqTdbMRUy1PCaKXJNojoCMX/BZw/pLE
	 bGWQOGJ0pp510vCPoSgONsMYllkTtue8IWe/KvAhn9FZHKnU6CNvyzJ3wA6T26t4mu
	 1NjMPWEwtNUhHTpi//oKmygqZgGJ42PAK2crK6cQGHPaXMY9dsFQSxbp3+tw0aFqGJ
	 V4qWHhM+y6Bg3oLeowjPBNCWRqCPyeqpcxjrQT/qQ6dGtC2S6gVfHB5mk/ZIvrc5EB
	 CjdjA6GRihLWA==
Date: Wed, 25 Feb 2026 09:51:19 -0800 (PST)
From: Mat Martineau <martineau@kernel.org>
To: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
cc: MPTCP Upstream <mptcp@lists.linux.dev>
Subject: Re: [PATCH mptcp-net] selftests: mptcp: join: check removing
 signal+subflow endp
In-Reply-To: <20260219101033.716403-2-matttbe@kernel.org>
Message-ID: <e9828ca4-f91a-3f31-5ef6-6608012acf89@kernel.org>
References: <20260219101033.716403-2-matttbe@kernel.org>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII

On Thu, 19 Feb 2026, Matthieu Baerts (NGI0) wrote:

> This validates the previous commit: endpoints with both the signal and
> subflow flags should always be marked as used even if it was not
> possible to create new subflows due to the MPTCP PM limits.
>
> For this test, an extra endpoint is created with both the signal and the
> subflow flags, and limits are set not to create extra subflows. In this
> case, an ADD_ADDR is sent, but no subflows are created. Still, the local
> endpoint is marked as used, and no warning is fired when removing the
> endpoint, after having sent a RM_ADDR.
>
> The 'Fixes' tag here below is the same as the one from the previous
> commit: this patch here is not fixing anything wrong in the selftests,
> but it validates the previous fix for an issue introduced by this commit
> ID.
>
> Fixes: 85df533a787b ("mptcp: pm: do not ignore 'subflow' if 'signal' flag is also set")
> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
> ---
> Linked to "mptcp: pm: in-kernel: always mark signal+subflow endp as
> used" sent earlier.
>
> Based-on: <20260218-mptcp-issue-613-v1-1-f8e9adb12010@kernel.org>
> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>

Reviewed-by: Mat Martineau <martineau@kernel.org>

> ---
> tools/testing/selftests/net/mptcp/mptcp_join.sh | 13 +++++++++++++
> 1 file changed, 13 insertions(+)
>
> diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
> index dc1f200aaa81..afb6fd3daced 100755
> --- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
> +++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
> @@ -2608,6 +2608,19 @@ remove_tests()
> 		chk_rst_nr 0 0
> 	fi
>
> +	# signal+subflow with limits, remove
> +	if reset "remove signal+subflow with limits"; then
> +		pm_nl_set_limits $ns1 0 0
> +		pm_nl_add_endpoint $ns1 10.0.2.1 flags signal,subflow
> +		pm_nl_set_limits $ns2 0 0
> +		addr_nr_ns1=-1 speed=slow \
> +			run_tests $ns1 $ns2 10.0.1.1
> +		chk_join_nr 0 0 0
> +		chk_add_nr 1 1
> +		chk_rm_nr 1 0 invert
> +		chk_rst_nr 0 0
> +	fi
> +
> 	# addresses remove
> 	if reset "remove addresses"; then
> 		pm_nl_set_limits $ns1 3 3
> -- 
> 2.51.0
>
>
>
