Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27FF81D9A50
	for <mptcp@lists.linux.dev>; Fri, 21 Mar 2025 10:27:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742552868; cv=none; b=qcdpbL/BBr+zT5Q8kU1ShmuFE4qWELqXlMAA1n+qwknXe70nLyexh82p4qjKOhDyI73kEFuyFbtBRMRho3VbzX6valVCpIjnud5URpq8xcGQKCUzrbFjv9uSJTPElf0XbydLzbfMG5h7dKb+w6t4Z2B/iCXDv7dwl+mZZZNoHiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742552868; c=relaxed/simple;
	bh=eH0o869fhnlsFB9l5LiTlKiP7ovcPco4Xbvo0cj4d0o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dHuMEa12+/flB21czKpw4PKdpC0ce16SOmM0AXuenP30TlMKSEwS1fzUapAgtlZislNS4aoFGDOMVf//Su4tLV3ozBiFpJ+a/JHa+6GGLCDoaGruqhcpFlHtzPMrItJE1zmi1YvZNnfzdIQwOiGDIqajy55QzHaSUuh4dutfEHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dwPV6g6y; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dwPV6g6y"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0815C4CEE3;
	Fri, 21 Mar 2025 10:27:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742552867;
	bh=eH0o869fhnlsFB9l5LiTlKiP7ovcPco4Xbvo0cj4d0o=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=dwPV6g6y5z1bxd5F+3BzwbHV8xe84imtz+XT8v1B8tG+sy4p6OmILHMjncRnOinft
	 oznOlfiIOAeGwJRrCKGeLh+2KXbuExGUuMCHqo2ETz0/bgTC2jAYkYJydZrUmzngq5
	 MR0ojDcL7T4B2EATL3ClRbXgbonrtFPcMrnU0LIr3W3UOIKYuTLSioYqsv8A08PzQ3
	 y7UoLkpWp869Ahd6hx3Wb5HcXAkiwWIG9Sk2/Xg4wfR2LGKYnsj5Md0ranVKVuOzN0
	 ihc46ZV+/GgXEpdV+bC2eW2WDqaM/AvTW93H7TS8W7Dfs8mPrG3iVCkf6l5XmdYZle
	 TJYDSNbIWbCbQ==
Message-ID: <60356c4b-c145-42a0-b5db-ec53f857db47@kernel.org>
Date: Fri, 21 Mar 2025 11:27:44 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH mptcp-next v3 07/10] mptcp: pm: add add_addr_received()
 interface
Content-Language: en-GB, fr-BE
To: Geliang Tang <geliang@kernel.org>, mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
References: <cover.1742521397.git.tanggeliang@kylinos.cn>
 <2d7bb2ff8960c244aee00ec314f23edd0f5577df.1742521397.git.tanggeliang@kylinos.cn>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <2d7bb2ff8960c244aee00ec314f23edd0f5577df.1742521397.git.tanggeliang@kylinos.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Geliang,

On 21/03/2025 02:45, Geliang Tang wrote:
> From: Geliang Tang <tanggeliang@kylinos.cn>
> 
> This patch adds an optional .add_addr_received interface for struct
> mptcp_pm_ops and invokes it in mptcp_pm_add_addr_received(). A new helper
> mptcp_pm_add_addr_recv() is added to allow the MPTCP_PM_ADD_ADDR_RECEIVED
> worker can be invoke from the in-kernel PM.
> 
> Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
> ---
>  include/net/mptcp.h   |  4 ++++
>  net/mptcp/pm.c        |  9 +++++++--
>  net/mptcp/pm_kernel.c | 13 +++++++++++++
>  net/mptcp/protocol.h  |  1 +
>  4 files changed, 25 insertions(+), 2 deletions(-)
> 
> diff --git a/include/net/mptcp.h b/include/net/mptcp.h
> index de9838ea37c4..37a84b4c661e 100644
> --- a/include/net/mptcp.h
> +++ b/include/net/mptcp.h
> @@ -132,6 +132,10 @@ struct mptcp_pm_ops {
>  	bool (*allow_new_subflow)(struct mptcp_sock *msk);
>  	bool (*accept_new_subflow)(const struct mptcp_sock *msk);
>  
> +	/* optional */
> +	int (*add_addr_received)(struct mptcp_sock *msk,
> +				 const struct mptcp_addr_info *addr);
> +
>  	char			name[MPTCP_PM_NAME_MAX];
>  	struct module		*owner;
>  	struct list_head	list;
> diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
> index d2e72e36d80e..28bd91819ec1 100644
> --- a/net/mptcp/pm.c
> +++ b/net/mptcp/pm.c
> @@ -559,6 +559,11 @@ void mptcp_pm_subflow_check_next(struct mptcp_sock *msk,
>  	spin_unlock_bh(&pm->lock);
>  }
>  
> +bool mptcp_pm_add_addr_recv(struct mptcp_sock *msk)
> +{
> +	return mptcp_pm_schedule_work(msk, MPTCP_PM_ADD_ADDR_RECEIVED);
> +}
> +
>  void mptcp_pm_add_addr_received(const struct sock *ssk,
>  				const struct mptcp_addr_info *addr)
>  {
> @@ -586,10 +591,10 @@ void mptcp_pm_add_addr_received(const struct sock *ssk,
>  		   (addr->id > 0 && !READ_ONCE(pm->accept_addr))) {
>  		mptcp_pm_announce_addr(msk, addr, true);
>  		mptcp_pm_add_addr_send_ack(msk);
> -	} else if (mptcp_pm_schedule_work(msk, MPTCP_PM_ADD_ADDR_RECEIVED)) {
> -		pm->remote = *addr;
>  	} else {
>  		ret = -EINVAL;
> +		if (pm->ops->add_addr_received)
> +			ret = pm->ops->add_addr_received(msk, addr);

Please see my comment from:

 https://lore.kernel.org/bf2ad4ed-bf4a-47c7-a7d5-eb23c0825198@kernel.org

This part:

> For add_addr_received, I think it is safer to have the callback from the
> worker context. In other words, when an ADD_ADDR received on a subflow:
> 
> - the ADD_ADDR echo should be sent: I don't think it is worth it letting
> the other peer resending it just in case the userspace PM was not "ready"
> 
> - if pm->ops->add_addr_received is set, schedule the worker and set
>   msk->pm.remote
> 
> - then pm->ops->add_addr_received will be called from the worker.

WDYT?

I don't think a BPF PM should schedule the worker and wait to get called
from another callback.

Instead, we should have something similar than .established, no?

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

