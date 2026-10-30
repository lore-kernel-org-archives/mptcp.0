Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793326379;
	b=cg5s5ZnBzKpv2Vcc/Ij3ZzvHUPsVWfrVMrTAxcQN1umgz0/NbQ5YrGAaN70NvRcM0DqU
	 MID8moxiMYNzIHlSEpY1TaYYvVo6l3vfGTy8Znxnc5QmsCnripUdpFLKPKYeeTo+KkBSJ
	 btxLAVFn0dcQ60Lo8BbaPYZUU47Q/rOZVU5q42m+yGK8YnrMghez/jCuE4pBPCwkDOwq0
	 8rl9AjNDto3aCX458oYw2Ikmvtk+42rw3gVN+b2gyid1BYLZuRg1h6Ynkonsg9K+EKb19
	 QnV0gLSOL5AJLzcEZuG0junnB3yHp6JwiYDinKv+/wH7XRDUgOkx0Vekh443zs6UxBA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793326379;
	h=Received:DKIM-Signature:Message-ID:Subject:From:To:Cc:Date:
	 In-Reply-To:References:Content-Type:User-Agent:MIME-Version:
	 Content-Transfer-Encoding;
	bh=7kjLlkeOPSQM1BlKKSk3ngLytlLkrptPT3QzAzwyUNQ=;
	b=RFkUjDTuNfV9fgoHeePPYK99vjGrb7wEUANiSsuTMzeVeXfDtbviinEqtqMhnOCgX2Xr
	 wKuLweNir4GbhZz6hpz1HQOMUz8iWBXMuguIrLHZ0qC1tYbYeZaPMszV1JIEFk8n5m7BB
	 hoBPFlehFXodxqFsoWiE0rxJnW74iAx1q7QZdWshbrAVbSmAoPzhXr0nENGE+dzaD/5Qq
	 ZUBoQB/rdzvgGuvBNnxBNiNRYpDzBdIZbrmgU7EtV3x5CxqavNOEpxNOy4ZDhLLpMa3T7
	 qANmpsR16ypgHx4Rvkoj6sszhqZR3Grv8dNsw1ZkDN+eHfgE0CIRAHCIuEqNLWXbmRg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IFrgyc5c;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1877606A31A
	for <mptcp@lists.linux.dev>; Fri, 30 Oct 2026 02:12:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IFrgyc5c
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 699AB1F000C1;
	Fri, 30 Oct 2026 02:12:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793326378;
	bh=7kjLlkeOPSQM1BlKKSk3ngLytlLkrptPT3QzAzwyUNQ=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=IFrgyc5cBn5WPhXQzszByMe/lDoNxu1NKIJWbJfDlELlIN6gKqj3CGbSKgFJY25SU
	 5rL/6hTMqjsxywsVH7/FGqLikCU3TKIxWfyoUr7kp23BXgVBBlwDpcGkUpjwVB8MLp
	 N4RUaQbB7lfSvf/8j5xs5xd7rI6heVI3n9JMHdGlf35Cd0LK1WPxIMd9xhCg0SxNwB
	 fa2lKQCGL0VfhfrP3rejbm/0jAnUNXg2KokcmbAPBWywJXP3PR0ttlKBVbHW7oNJEC
	 TFq+aCMmZvapCn5eeo5McLPAfjRePYIdTvWcuSRyq8seE1IH33+dHO1ODpZPhiFnDZ
	 oLpn0QAI+JCag==
Message-ID: <0a3dcc9785f4f067bb051edafd0a780bbe2231b5.camel@kernel.org>
Subject: Re: [PATCH mptcp-net v3] mptcp: pm: kernel: c-flag: keep
 local_addr_used in sync
From: Geliang Tang <geliang@kernel.org>
To: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, MPTCP Linux
	 <mptcp@lists.linux.dev>
Cc: Yiming Qian <yimingqian591@gmail.com>
Date: Fri, 30 Oct 2026 10:12:54 +0800
In-Reply-To: <20261029-mptcp-pm-cflag-clear-when-used-v3-1-fa96c11f97b0@kernel.org>
References: 
	<20261029-mptcp-pm-cflag-clear-when-used-v3-1-fa96c11f97b0@kernel.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.56.2-10build1 
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Post: <mailto:mptcp@lists.linux.dev>
List-Help: <mailto:mptcp+help@lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
List-Owner: <mailto:mptcp+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Matt,

On Thu, 2026-10-29 at 21:43 +0100, Matthieu Baerts (NGI0) wrote:
> The ID was marked as used before incrementing local_addr_used counter
> when the families were not matching.
> 
> Marking endpoints as used while they are not can have an impact on
> the
> local_addr_used counter when endpoints not linked to the initial
> subflow
> are removed -- CAP_NET_ADMIN is required -- and active connections
> have
> such badly marked endpoints. In this case, the local counter will be
> decremented while it shouldn't. If the counter was already at 0, this
> warning will be emitted:
> 
>   WARNING: net/mptcp/pm_kernel.c:1080 at
> __mark_subflow_endp_available+0x46/0x50, CPU#0: a.out/149
>   RIP: 0010:__mark_subflow_endp_available (net/mptcp/pm_kernel.c:1080
> (discriminator 2) net/mptcp/pm_kernel.c:1076 (discriminator 2))
>   Call Trace:
>    mptcp_pm_nl_del_addr_doit (net/mptcp/pm_kernel.c:1112
> net/mptcp/pm_kernel.c:1227)
>    genl_family_rcv_msg_doit (net/netlink/genetlink.c:1114)
> 
> The fix is easy: increment local_addr_used similar to what is done in
> mptcp_pm_create_subflow_or_signal_addr() for the non C-flag case.
> 
> Fixes: 4b1ff850e0c1 ("mptcp: pm: in-kernel: usable client side with
> C-flag")
> Reported-by: Yiming Qian <yimingqian591@gmail.com>
> Closes:
> https://lore.kernel.org/20261006114409.117190-1-yimingqian591@gmail.com
> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>

Good catch. The fix correctly restores the consistency between
id_avail_bitmap and local_addr_used, matching the non-C-flag path.

Additionally, I don't think the Perf failure (Perf: Unstable: 1 failed
test(s): error:sched-bbr) reported by the CI is related to this patch.

	Reviewed-by: Geliang Tang <geliang@kernel.org>

Thanks,
-Geliang

> ---
> Changes in v3:
> - Reword commit message: the issue was only with mismatched families.
> - Link to v2:
> https://patch.msgid.link/20261022-mptcp-pm-cflag-clear-when-used-v2-1-8c7fbe166b74@kernel.org
> 
> Changes in v2:
> - Move the increment of local_addr_used before checking the family,
>   similar to what is done for the non C-flag case.
> - Link to v1:
> https://patch.msgid.link/20261022-mptcp-pm-cflag-clear-when-used-v1-1-516c09b4ee65@kernel.org
> ---
> Note: this patch supersedes the patch mentioned above: the author
> doesn't seem to be willing to send a v2. Because security@k.o was
> Cc'ed
> on public ML, that's forcing us not to wait, even if this fix is just
> about a counter that will be wrongly decremented when MPTCP endpoints
> are removed (requiring CAP_NET_ADMIN). Put the original author as
> "Reported-by" following the recommendations given to maintainers in
> such
> cases.
> ---
>  net/mptcp/pm_kernel.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/net/mptcp/pm_kernel.c b/net/mptcp/pm_kernel.c
> index d3014bf57bf3..fb611c4b3eb8 100644
> --- a/net/mptcp/pm_kernel.c
> +++ b/net/mptcp/pm_kernel.c
> @@ -584,13 +584,15 @@ fill_local_addresses_vec_c_flag(struct
> mptcp_sock *msk,
>  
>  		__clear_bit(local->addr.id, msk-
> >pm.id_avail_bitmap);
>  
> -		if (!mptcp_pm_addr_families_match(sk, &local->addr,
> remote))
> -			continue;
> -
>  		if (local->addr.id == msk->mpc_endpoint_id)
>  			continue;
>  
> +		/* Increment before checking families, similar to
> non C-flag */
>  		msk->pm.local_addr_used++;
> +
> +		if (!mptcp_pm_addr_families_match(sk, &local->addr,
> remote))
> +			continue;
> +
>  		msk->pm.extra_subflows++;
>  		i++;
>  
> 
> ---
> base-commit: bcc5638fabf418e763621a432840cf55287e604d
> change-id: 20261006-mptcp-pm-cflag-clear-when-used-ee817b26a553
> 
> Best regards,
> --  
> Matthieu Baerts (NGI0) <matttbe@kernel.org>
> 
