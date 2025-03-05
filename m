Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8FB21E50B
	for <mptcp@lists.linux.dev>; Wed,  5 Mar 2025 01:01:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741136487; cv=none; b=cd84Wl3DyA5klKywbK1O2/CQf2Dc9B4TRV42FrRGmaPrba6ZMy0MToBh0+wOAd8pWUjmbZ2DnL4CpyJDxIW2K31s6b/otsPN+8wvUNGlsaWfiz353ECPNmNknac9Tnzo/RNvvJQd4Dr2E0O9BdFn6PXZlgBQTDIRY9BW+VoS/NU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741136487; c=relaxed/simple;
	bh=8WenIm4X+D1ZGxQ49Qw7V4B3n75jEmZw3dzIO2bx3dY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=jKCCfv+v7awxnfmnBiTL/bHEupbgjxrezYPFosfkDIKOL4L8OT6yhu0YETQAmoviHJlO6b9vx9cSsm4bxtB5/dPsvnEUNtDF7YI89/+nOAX6IUOvBuAkuAfJGAzd7Rc+N+cDXzlwWpOdXEkJKl/yyrLulhGy5MomTAt77AafL8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uoxv9Vj+; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uoxv9Vj+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89871C4CEE5;
	Wed,  5 Mar 2025 01:01:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741136486;
	bh=8WenIm4X+D1ZGxQ49Qw7V4B3n75jEmZw3dzIO2bx3dY=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=uoxv9Vj+s2LRq9YrRoJzAEKNi2dzfUFYAX1Orvyko1F805DHNKZg66ovLf83/NDWk
	 ic4wqH4nT9fMVRft2aGCaPmb3t+T26OHzpuseHM5Q99LfvxHlUy0DBZO8xy0eEBdAl
	 4cnOJgGXGZI9vFLWpG8L2OvAUXQkIiiwLCB8IDWTy74Abbar5MkTF/tGxfciW6SWuu
	 KH1funm2Fs8v1oFyE/fq32z2cPkyMMi2VNu1Vvh9r1k3kzVb37RZSZyPwv+hExDCux
	 Mm4NOyUc/kOhPnWXSHZEElF0mde5CvaVhwtolwgqDYg2SipiouHZ+qOY6vlGoqQCra
	 TWwuNT6PgI/+w==
Message-ID: <bffcd0a1a52c731ac59d5102aa5f0e2e260b82f2.camel@kernel.org>
Subject: Re: [PATCH mptcp-next v1 2/2] mptcp: pm: use pm variable instead of
 msk->pm
From: Geliang Tang <geliang@kernel.org>
To: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Cc: Geliang Tang <tanggeliang@kylinos.cn>, mptcp@lists.linux.dev
Date: Wed, 05 Mar 2025 09:01:23 +0800
In-Reply-To: <b3fc56c8fefef00d42c064da81ce13b138d43103.1741072099.git.tanggeliang@kylinos.cn>
References: <cover.1741072099.git.tanggeliang@kylinos.cn>
	 <b3fc56c8fefef00d42c064da81ce13b138d43103.1741072099.git.tanggeliang@kylinos.cn>
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

On Tue, 2025-03-04 at 15:16 +0800, Geliang Tang wrote:
> From: Geliang Tang <tanggeliang@kylinos.cn>
> 
> The variable "pm" has been defined in mptcp_pm_fully_established()
> and mptcp_pm_data_reset() as "sk->pm", so use "pm" directly instead
> of using "sk->pm".

This commit log needs to be updated. Should be "msk->pm", not "sk->pm".
Please update this for me:

'''
and mptcp_pm_data_reset() as "msk->pm", so use "pm" directly instead
of using "msk->pm".
'''

Thanks,
-Geliang

> 
> Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
> ---
>  net/mptcp/pm.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
> index 8e6a325a3898..04a156395aad 100644
> --- a/net/mptcp/pm.c
> +++ b/net/mptcp/pm.c
> @@ -511,13 +511,13 @@ void mptcp_pm_fully_established(struct
> mptcp_sock *msk, const struct sock *ssk)
>  	 * be sure to serve this event only once.
>  	 */
>  	if (READ_ONCE(pm->work_pending) &&
> -	    !(msk->pm.status & BIT(MPTCP_PM_ALREADY_ESTABLISHED)))
> +	    !(pm->status & BIT(MPTCP_PM_ALREADY_ESTABLISHED)))
>  		mptcp_pm_schedule_work(msk, MPTCP_PM_ESTABLISHED);
>  
> -	if ((msk->pm.status & BIT(MPTCP_PM_ALREADY_ESTABLISHED)) ==
> 0)
> +	if ((pm->status & BIT(MPTCP_PM_ALREADY_ESTABLISHED)) == 0)
>  		announce = true;
>  
> -	msk->pm.status |= BIT(MPTCP_PM_ALREADY_ESTABLISHED);
> +	pm->status |= BIT(MPTCP_PM_ALREADY_ESTABLISHED);
>  	spin_unlock_bh(&pm->lock);
>  
>  	if (announce)
> @@ -1009,7 +1009,7 @@ void mptcp_pm_data_reset(struct mptcp_sock
> *msk)
>  	WRITE_ONCE(pm->addr_signal, 0);
>  	WRITE_ONCE(pm->remote_deny_join_id0, false);
>  	pm->status = 0;
> -	bitmap_fill(msk->pm.id_avail_bitmap, MPTCP_PM_MAX_ADDR_ID +
> 1);
> +	bitmap_fill(pm->id_avail_bitmap, MPTCP_PM_MAX_ADDR_ID + 1);
>  }
>  
>  void mptcp_pm_data_init(struct mptcp_sock *msk)

