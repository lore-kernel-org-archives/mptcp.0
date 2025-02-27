Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C29E17BA3
	for <mptcp@lists.linux.dev>; Thu, 27 Feb 2025 01:55:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740621305; cv=none; b=dW0djGzmKrKuLCWZl5+xHxKGMO/9Y4xK0Era5s+rcUGARw3JYBm82Fj3QkE5QoCytKnwbb7yo19y6Uv3fq+3AgB/xK3uLSBup1kohi+0ut9BnxiP7hMvmPyIibRi6Z6Zfk1HbiiSPAviu56/deJpMqHRqJEXX6rjSZrsmmmiJy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740621305; c=relaxed/simple;
	bh=HL85RAuKCwh187Z0/kTBsNYJtPH39oCBueXo5UoKdRs=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=AcoDgT2IQuQpzzwu2D1IIDYDyCUIE+hthj67DOnR4cssjr9sI+SNNwCMwHCEvQp8x+cb88pzkFCQu/qPOzke98f3jmVT928/hSisdMr91QavvQ3U7kW7a5HI3kYk1LyGoAo2OMY82iV+pIvRZ+0p1WvdQfaQkXuT1HgS+Gs65Kg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Wt6JvVQ3; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Wt6JvVQ3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 873DDC4CED6;
	Thu, 27 Feb 2025 01:55:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740621304;
	bh=HL85RAuKCwh187Z0/kTBsNYJtPH39oCBueXo5UoKdRs=;
	h=Subject:From:To:Date:In-Reply-To:References:From;
	b=Wt6JvVQ3UAfYgzrxGb0ayLTvqjOY1y0g+8ACKaAdVrUt8WQSSqosQPiUrWBuJ3/ox
	 iFDUSA61E41lSgVFjampodv4eVeOKa+Ur6MuNoy4DMj+p7kviGSxK6LIjoU175cWwV
	 04MVYmw5MyYG95L0dEp7tzwFp7fNRvfvj/o2CWx6t0qujRJAUGVDgpLiemYYIcMfAh
	 TmpMgmN4xK/cs54/PP3MyztFLx1NAx8DcJ23rZZLttW3uIuDWad+ptmG7GtuxbPm4O
	 iFJ1xuG0N6EYD6Aw2CSlZwSLKJW7acBJvYKBG+cLIbb2AxJJV7yoMWRCk+H15Gf6lM
	 f8fsjSNluyIMQ==
Message-ID: <1d87b4d55777c11a33298336418de576baa62673.camel@kernel.org>
Subject: Re: [PATCH mptcp-next v2] mptcp: pm: exit early with ADD_ADDR echo
 if possible
From: Geliang Tang <geliang@kernel.org>
To: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, mptcp@lists.linux.dev
Date: Thu, 27 Feb 2025 09:55:01 +0800
In-Reply-To: <20250226-mptcp-userspace-avoid-worker-v2-1-4b144f314353@kernel.org>
References: 
	<20250226-mptcp-userspace-avoid-worker-v2-1-4b144f314353@kernel.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.52.3-0ubuntu1 
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Matt,

On Wed, 2025-02-26 at 15:21 +0100, Matthieu Baerts (NGI0) wrote:
> When the userspace PM is used, or when the in-kernel limits are
> reached,
> there will be no need to schedule the PM worker to signal new
> addresses.
> That corresponds to pm->work_pending set to 0.
> 
> In this case, an early exit can be done in mptcp_pm_add_addr_echoed()
> not to hold the PM lock, and iterate over the announced addresses
> list,
> not to schedule the worker anyway in this case. This is similar to
> what
> is done when a connection or a subflow has been established.
> 
> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>

This v2 looks good to me, thanks.

Reviewed-by: Geliang Tang <geliang@kernel.org>

> ---
> Changes in v2:
> - Link to v1:
> https://lore.kernel.org/r/20250224-mptcp-userspace-avoid-worker-v1-1-127325d3e9a4@kernel.org
> ---
> Notes:
> - v2:
>   - Only modify mptcp_pm_add_addr_echoed().
>   - The rest doesn't need to or shouldn't be modified (Geliang).
> Cc: Geliang Tang <tanggeliang@kylinos.cn>
> ---
>  net/mptcp/pm.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
> index
> 16cacce6c10fe86467aa7ef8e588f9f535b586fb..6c8cadf84f31f4c7dcc38b787be
> da048d5362dc8 100644
> --- a/net/mptcp/pm.c
> +++ b/net/mptcp/pm.c
> @@ -251,6 +251,9 @@ void mptcp_pm_add_addr_echoed(struct mptcp_sock
> *msk,
>  
>  	pr_debug("msk=%p\n", msk);
>  
> +	if (!READ_ONCE(pm->work_pending))
> +		return;
> +
>  	spin_lock_bh(&pm->lock);
>  
>  	if (mptcp_lookup_anno_list_by_saddr(msk, addr) &&
> READ_ONCE(pm->work_pending))
> 
> ---
> base-commit: 1238896935ea03f333a183a32fab666cc0c20e3b
> change-id: 20250224-mptcp-userspace-avoid-worker-93f367e39ca6
> 
> Best regards,

