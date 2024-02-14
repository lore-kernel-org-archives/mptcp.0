Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8418B64A
	for <mptcp@lists.linux.dev>; Wed, 14 Feb 2024 01:44:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707875091; cv=none; b=NHe9PL4Z3EjvOSlSfamlwjtHXS03M/F8MJ9nQOD/07XYo44z0Gw2flRdcJV69AwkFvE5xeYmHFtzyjIUlZ+x63P17ojPNa8BVtuql3ua4zybs1M54u6SqNrDF6f3swtbGtTmQegruOwSWl6stMsuheuouvn9Cu7BAU+cqghO1qw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707875091; c=relaxed/simple;
	bh=fsUZIysrCDaGtEMN6+PZDUe5eXcF5N/mNOYtT/vfsiI=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=or1ybcjqRYYJ9ps6vxnTtzc4APwwPn54zuQd/Wd1vd14PlvbgwCDSoidyNQyCiVO4wJ5WZh1ksAi5YpD+93CIM7Eev+KMRLBu/jQHptMuq2SligNB+pGcdp+4hw+wKF6HQJSO2Z4fR4a8n4Tw2vhN+emTHYuUrsZAMREMMODVhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OTs27BGS; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OTs27BGS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2882EC433F1;
	Wed, 14 Feb 2024 01:44:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707875091;
	bh=fsUZIysrCDaGtEMN6+PZDUe5eXcF5N/mNOYtT/vfsiI=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=OTs27BGSDzFyjLwgoPDl39+NNEk+XaVhjZexTrPA5Qg6Ocp75oCYQltm+Fv4wvCv6
	 2f3UAIFla0UwAW1JwbyyCl+TZ8NaeNoGulBfU/dvUb8gNRqGDxWAiADtiR+nIbQDWg
	 cped3IB/b+SV6n6bqBVKoenk/IT91s+bxrGn4QoKwi+aAh5j/buZVRfwihKTWfiEqM
	 JWM5PssHnPTSSxfC16CcjmWlMC/A5FpXyN6j9/BkxrjL0qEgcXFaJOXPTkNp/inj5r
	 VTk7l+L1EFflelo/Kc4NrAVmvtyVQ83a7ojh+hrSfOdsAqHL4wAUul/TUpEMQCT6g+
	 eBJxT78Zsz6AA==
Date: Tue, 13 Feb 2024 17:44:50 -0800 (PST)
From: Mat Martineau <martineau@kernel.org>
To: Geliang Tang <geliang@kernel.org>
cc: mptcp@lists.linux.dev, Geliang Tang <tanggeliang@kylinos.cn>
Subject: Re: [PATCH mptcp-next v3 0/2] fixes for "map v4 address to v6"
In-Reply-To: <cover.1707270765.git.tanggeliang@kylinos.cn>
Message-ID: <59fce9d5-366e-1231-6472-41f35a1da5f8@kernel.org>
References: <cover.1707270765.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII

On Wed, 7 Feb 2024, Geliang Tang wrote:

> From: Geliang Tang <tanggeliang@kylinos.cn>
>
> v3:
> - add a new argument addr for mptcp_lib_evts_get_info, instead of
>   a new helper mptcp_lib_evts_get_info_with_addr

v3 looks good to me, thanks Geliang.

Reviewed-by: Mat Martineau <martineau@kernel.org>

>
> v2:
> - update selftests as Mat suggested.
>
> Geliang Tang (2):
>  mptcp: map v4 address to v6 when destroying subflow
>  selftests: mptcp: rm subflow with v4/v4mapped addr
>
> net/mptcp/pm_userspace.c                      | 10 +++++++
> .../testing/selftests/net/mptcp/mptcp_join.sh | 28 +++++++++++--------
> .../testing/selftests/net/mptcp/mptcp_lib.sh  |  7 +++--
> 3 files changed, 31 insertions(+), 14 deletions(-)
>
> -- 
> 2.40.1
>
>
>
