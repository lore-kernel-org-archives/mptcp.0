Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 213D0143747
	for <mptcp@lists.linux.dev>; Tue, 23 Jul 2024 22:02:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721772139; cv=none; b=UHUsvYSYjoannaVLs8QnXIKd9Ico7E8Z3HQ/rE+xhFkSLgXUsRGrGgRJH6wTsq1Yjaw9lvk7s+8rYN7P/4+1ZQWgTE4Fcv5AavQ37KcK3UtKjCWjAzmCaubrBaZrhnnrtlG5Jp4QKinPANnbSlRa9QCfo1Mvnux9XrYX1y1vE1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721772139; c=relaxed/simple;
	bh=7Gvu2gTIRmk3Xja7kTvugCsuHi2whVMSYG78BlEwZPo=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=kFeaEYc3UWNXTYwk7dIe2vrLCNiHDhBGjIOo8HuDxmphv5/ZOhwJBlVOYS8jY3yQaur1lVRuuHxONzNWgZw79S5pOuUolxnQis+qO7GdnwLyFnkhZYGT+v91OcOLR4LC5nSfBBKJPrk4D6/Y4cU8EZ6QKYrU6AIfhKXLqkrzYJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rXkGOOni; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rXkGOOni"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62FE9C4AF0A;
	Tue, 23 Jul 2024 22:02:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721772138;
	bh=7Gvu2gTIRmk3Xja7kTvugCsuHi2whVMSYG78BlEwZPo=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=rXkGOOnisqxxXkWusG0fUt946ua+dbLDIDHoavO9iFvKWoDHL9oVrOJTEMTFtcpQa
	 OTcW//NRCJFqFAkk+9cU/95CO9nDPITfeBSSGHUD0VNEEUfLpkfXY3EAAqdza7OMbm
	 V0ODs0wNi0zZtd9FrwOZz2xbpgJOvP8vwyJiDMNS5RmSUGAbMPjl3Jes4KPzltJbMp
	 A/ez3WEVXb4sTRn36DhVdgQtWoNwc21gkS4vBJhtSgKi81lDHBOcReuPv8BJDxXnP+
	 I/KhG735cOndcgKCocHKBlG3IhQvnBVRhXLFt0rxHHZKdTaQLnjp8z/o+iNwx8vPcF
	 PkrFexnvlJVIQ==
Date: Tue, 23 Jul 2024 15:02:17 -0700 (PDT)
From: Mat Martineau <martineau@kernel.org>
To: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
cc: mptcp@lists.linux.dev, Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH mptcp-net v4 22/23] mptcp: pm: reuse ID 0 after delete
 and re-add
In-Reply-To: <20240722-mptcp-pm-avail-v4-22-15bfd73de384@kernel.org>
Message-ID: <d3350be8-c35c-d02a-fe77-c898f08c604b@kernel.org>
References: <20240722-mptcp-pm-avail-v4-0-15bfd73de384@kernel.org> <20240722-mptcp-pm-avail-v4-22-15bfd73de384@kernel.org>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Mon, 22 Jul 2024, Matthieu Baerts (NGI0) wrote:

> When the endpoint used by the initial subflow is removed and re-added
> later, the PM has to force the ID 0, it is a special case imposed by the
> MPTCP specs.
>
> Note that the endpoint should then need to be re-added reusing the same
> ID.
>
> Fixes: 3ad14f54bd74 ("mptcp: more accurate MPC endpoint tracking")
> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
> ---
> net/mptcp/pm_netlink.c | 9 +++++++++
> 1 file changed, 9 insertions(+)
>
> diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
> index 8f25690a5edc..45a1aa0a40bf 100644
> --- a/net/mptcp/pm_netlink.c
> +++ b/net/mptcp/pm_netlink.c
> @@ -586,6 +586,11 @@ static void mptcp_pm_create_subflow_or_signal_addr(struct mptcp_sock *msk)
>
> 		__clear_bit(local.addr.id, msk->pm.id_avail_bitmap);
> 		msk->pm.add_addr_signaled++;
> +
> +		/* Special case for ID0: set the correct */

"set the correct ID" ?

> +		if (local.addr.id == msk->mpc_endpoint_id)
> +			local.addr.id = 0;
> +
> 		mptcp_pm_announce_addr(msk, &local.addr, false);
> 		mptcp_pm_nl_addr_send_ack(msk);
>
> @@ -614,6 +619,10 @@ static void mptcp_pm_create_subflow_or_signal_addr(struct mptcp_sock *msk)
> 		if (nr == 0)
> 			continue;
>
> +		/* Special case for ID0: set the correct ID */
> +		if (local.addr.id == msk->mpc_endpoint_id)
> +			local.addr.id = 0;
> +
> 		spin_unlock_bh(&msk->pm.lock);
> 		for (i = 0; i < nr; i++)
> 			__mptcp_subflow_connect(sk, &local.addr, &addrs[i]);
>
> -- 
> 2.45.2
>
>
>
