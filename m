Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F354296BC8
	for <mptcp@lists.linux.dev>; Fri, 14 Aug 2026 01:22:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786670549; cv=none; b=u2tuIraOOHoc28IVyjNwm+60UnVo9bjzeGzN31Z2vkeXpAiSGitStlqHlTiv9HLrbSJ1J8iF0EOO9zcZO81ov+X1y9xFUXc+eodZl01KA3KS9PvSowz9AEafXdbr1wgHd/k9Nu6H/NUm7lL52vgiVgeQNzQuqg3mv8hRtCSukw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786670549; c=relaxed/simple;
	bh=w2Rm4Z5jAYFRcyhstEin3RaoaAmmD2xBkhjMGrneuFE=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=MOcVD5mjzMDYo0sVWfxeKRhgps0aRxUJBL/jD+4nsAY5NwyU7OD7lcqz5TpV29w0XGJP+Omo0UPQERwexVGECwfd2smClQ+KSqnRuJL0DG17T3KZHjhrne5xFnearZM0Wui0d9/JSyEICyDunpVcv5gQkQ8JTon8rB4kx90p+w0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YNNJ3YUq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YNNJ3YUq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24BE01F000E9;
	Fri, 14 Aug 2026 01:22:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786670548;
	bh=HFER4ltEfcVY+aKxCL4RxcNiiTx5JgKRfYEYUDcNG3M=;
	h=Date:From:To:cc:Subject:In-Reply-To:References;
	b=YNNJ3YUqQsp99B4QI7CVDG6tQEAnR14kePId3idotnaLCqkAeOIWE5zbwWrlRYsSU
	 4rQWl+l6xcMDVjGO8CVoEX9nxwBW2u9sWWt9pgBYjK3491gPeXeW2B9knh5R/LMqKv
	 cylejt1/juMkoDp9QeM+787VJnYgqU3cOwcuWYuriaeMntXIhMZrdPdAMQstHgZpq3
	 JxJgeK3Yp+nkuF2pZQl/ntMSbh35AXJC+AKQxFS6GOulqCtO9wzjJetPJzQWTFn0FN
	 BsNKERTfd2J7SY6xzPfqDS73ABvmhVliQ9po0S+91huVPffinAUev6U/I5PAXuOnQS
	 5WMj+uM0SfIiw==
Date: Thu, 13 Aug 2026 18:22:27 -0700 (PDT)
From: Mat Martineau <martineau@kernel.org>
To: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
cc: MPTCP Linux <mptcp@lists.linux.dev>
Subject: Re: [PATCH mptcp-net] mptcp: pm: reset retrans_time when ADD_ADDR
 entry is reused
In-Reply-To: <20260805-mptcp-pm-reset-retrans_time-v1-1-19efbe17046d@kernel.org>
Message-ID: <caa3dce5-940c-8068-8069-93bc3ac7896a@kernel.org>
References: <20260805-mptcp-pm-reset-retrans_time-v1-1-19efbe17046d@kernel.org>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Wed, 5 Aug 2026, Matthieu Baerts (NGI0) wrote:

> When an ADD_ADDR entry is reused, the timer is re-armed, because the
> goal is to re-announce an ADD_ADDR, and eventually retransmit it if
> needed.
>
> In this case, the retransmission counter should be reset as well, so the
> re-announced address gets its retransmissions back instead of relying on
> what was left before, and possibly not being able to retransmit it.
>
> Fixes: 304ab97f4c7c ("mptcp: allow ADD_ADDR reissuance by userspace PMs")
> Link: https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260803-net-mptcp-misc-fixes-7-2-rc6-v2-0-b8f496d71664%40kernel.org?part=4
> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
> ---
> net/mptcp/pm.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
> index 5e499ec1c50a..e46abbda7d27 100644
> --- a/net/mptcp/pm.c
> +++ b/net/mptcp/pm.c
> @@ -462,10 +462,10 @@ bool mptcp_pm_announced_alloc(struct mptcp_sock *msk,
>
> 	add_entry->addr = *addr;
> 	add_entry->sock = msk;
> -	add_entry->retrans_times = 0;
>
> 	timer_setup(&add_entry->timer, mptcp_pm_add_addr_timer, 0);
> reset_timer:
> +	add_entry->retrans_times = 0;
> 	add_entry->timer_done = false;
> 	timeout = mptcp_adjust_add_addr_timeout(msk);
> 	if (timeout)
>
> ---
> base-commit: 0715f5ba093a581def25b88da61c987b1719bc6d
> change-id: 20260805-mptcp-pm-reset-retrans_time-8894830b0bd7

Looks good to me, thanks for the fix.

Reviewed-by: Mat Martineau <martineau@kernel.org>

