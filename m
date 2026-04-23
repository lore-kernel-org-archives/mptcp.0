Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3740E30E0C0
	for <mptcp@lists.linux.dev>; Thu, 23 Apr 2026 23:48:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776988089; cv=none; b=sfHew/EagWJozso9FAVacREFllg3yOdRoKWoc5fLi8c8qMya8hP3EE4FSBl99NMeo/puZdB40wfkyA7ujbTz5o4429zxLDb+VW62+0aj2lM41zqc90/xw/4os5CG4LbJOe3dK4XugBDDtc8y52MJ6d2v15TEmzgQOXVZqHdQ46Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776988089; c=relaxed/simple;
	bh=hU/aoyrtDeQR9d82aV1KYoMFOLXwLVLs1MVLu3BkrZM=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=Z54U++eU+CV62D1Z3qvVhZor6B9n8jh9m4LVpLEVbnJoyt+sEduzml3RWc5zzB6nnwb6VXLvz9plmIcJMdq10t4IKhEnpaWVpwF6sncGl2TqblGIIdEK4CJdwiZEifWQdG1IYoTYPNgzD4VHAF+Nc5woe49otNJplZkY9KgPBXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RFbgpIsD; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RFbgpIsD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07E1BC2BCAF;
	Thu, 23 Apr 2026 23:48:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776988089;
	bh=hU/aoyrtDeQR9d82aV1KYoMFOLXwLVLs1MVLu3BkrZM=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=RFbgpIsDz5qVyZ2aUvoabmMCoZln+Gc9gnLWWaFmjLsFr1zVsXIJiWEgoqVfzFdNv
	 5WiAJIzn0XjMIi2ykMdrdyvslnJ0ilTfN9xoqaAhisjZrQvI2/FeC827H5fLECyiyr
	 lpcQNb/Mhb4vvbJGxwDlQJoMWuFrYj1RqYuAFdyIG6yJxQZEZ2mYTg/V00JajTyttw
	 bu8jgexeZx7OrNJVT1/t0k5JmUH+XA1Jn1VetE58LZk5InJxEpWoC5tPwI3lHHdJLf
	 bIHkVm/4g8HncNPNkUTokn0x2BxJ5SuNRGc4grHPXlEgA7h7HQwuuPWWzYKf2Lbn5n
	 Cw6sB1/toiV5A==
Date: Thu, 23 Apr 2026 16:48:08 -0700 (PDT)
From: Mat Martineau <martineau@kernel.org>
To: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
cc: MPTCP Upstream <mptcp@lists.linux.dev>, Sashiko <sashiko-bot@kernel.org>
Subject: Re: [PATCH mptcp-net] mptcp: pm: kernel: reset fullmesh counter
 after flush
In-Reply-To: <20260423-mptcp-pm-reset-endp_fullmesh_max-v1-1-e43a46fc8d49@kernel.org>
Message-ID: <6bbf7614-1952-1d6c-bce0-c30023cb5213@kernel.org>
References: <20260423-mptcp-pm-reset-endp_fullmesh_max-v1-1-e43a46fc8d49@kernel.org>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Thu, 23 Apr 2026, Matthieu Baerts (NGI0) wrote:

> This variable counts how many MPTCP endpoints have a 'fullmesh' flag
> set. After having flushed all MPTCP endpoints, it is then needed to
> reset this counter.
>
> Without this reset, this counter exposed to the userspace is wrong, but
> also non-fullmesh endpoints added after the flush will not be taken into
> account to create subflows in reaction to ADD_ADDRs.
>
> Fixes: f88191c7f361 ("mptcp: pm: in-kernel: record fullmesh endp nb")
> Reported-by: Sashiko <sashiko-bot@kernel.org>
> Closes: https://sashiko.dev/#/patchset/20260422-mptcp-inc-limits-v6-0-903181771530%40kernel.org?part=15
> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
> ---
> net/mptcp/pm_kernel.c | 1 +
> 1 file changed, 1 insertion(+)
>
> diff --git a/net/mptcp/pm_kernel.c b/net/mptcp/pm_kernel.c
> index 7895fb5f982e..382893f22f6a 100644
> --- a/net/mptcp/pm_kernel.c
> +++ b/net/mptcp/pm_kernel.c
> @@ -1279,6 +1279,7 @@ static void __reset_counters(struct pm_nl_pernet *pernet)
> 	WRITE_ONCE(pernet->endp_signal_max, 0);
> 	WRITE_ONCE(pernet->endp_subflow_max, 0);
> 	WRITE_ONCE(pernet->endp_laminar_max, 0);
> +	WRITE_ONCE(pernet->endp_fullmesh_max, 0);

LGTM

Reviewed-by: Mat Martineau <martineau@kernel.org>

> 	pernet->endpoints = 0;
> }
>
>
> ---
> base-commit: 94ca4b024f14c6f7ce32ca0c274f5b19c82f634a
> change-id: 20260423-mptcp-pm-reset-endp_fullmesh_max-e1e56a51bf01
>
> Best regards,
> --
> Matthieu Baerts (NGI0) <matttbe@kernel.org>
>
>
>
