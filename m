Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B0FF1DDA09
	for <mptcp@lists.linux.dev>; Mon, 10 Mar 2025 23:17:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741648661; cv=none; b=eLEcSZDeFiO6NpAYOYfsZMNTzJTC1KCdNq10NAmFvTxsv0j3UsqsvUwSFkDDpGvWuqEaxv4cvxPkdzruqlAxxzzEaMBEeoMIHNyk81onI7IYBWKE2FrLO8dTHaX0N4N7r+m1+pj3ValJEOQqd4e5XQa99XjpVR07ZTncu0l6XiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741648661; c=relaxed/simple;
	bh=6lDdByEmzFLSbCijzR8ed5TH2+pwzKB2RNSMuXtbtwE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gHY+qhymhi7ClgOGxeDqEvdgbQWFZuiGFbF4RnsgW7QcQ4RDKd/IIaP/RiuppiR4AmjF15ZOkTWS6GU+U4WUXqjciCZvwK7SPAbN/OjvliUdWqH8V99bicRLtLIigP+oI7wuUssBm/BVFTEkpnGnc3kucsoe9UtORToAFtOVJZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j+9VbKFQ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j+9VbKFQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E066C4CEE5;
	Mon, 10 Mar 2025 23:17:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741648660;
	bh=6lDdByEmzFLSbCijzR8ed5TH2+pwzKB2RNSMuXtbtwE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=j+9VbKFQjtUqeOBGHkIvPrV2uyUkYHW+kQYdYwxrV39CTqtDxbEs0yq4f3CIQiw8H
	 BIfq9GmqAUoZWjsr1snLf+KeS+QgIRoWykuUF5aMz5wmbTgtqzoC+L9g5/otkGxpCt
	 E/gc3AFnXyBPU6sb4ynVU9Wcq9keH1MVSdYU3rJWMLsgNReCamIFT2TqCCAn4bcgcu
	 sCWaAzJFTfZ97XReuSz5z/TYs35iDBQkeODYJTKSCPgXfTi8VHV/H1dN3gyY7HLwyM
	 K8ngv0DKLAkbn7TtBYBg9Q65lWcCh5sbShDkIwLgSpZ/V3NL7cKb0+0pqwrQorcLN9
	 05LrBtnDRxLWg==
Message-ID: <26482cc0-abce-464e-96ba-826217c779d8@kernel.org>
Date: Tue, 11 Mar 2025 00:17:37 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH mptcp-next v10 04/12] mptcp: add struct_group in
 mptcp_pm_data
Content-Language: en-GB
To: Geliang Tang <geliang@kernel.org>, mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
References: <cover.1741258415.git.tanggeliang@kylinos.cn>
 <9133981edb83438ee10e6da9ef4e5cc6bf7f188b.1741258415.git.tanggeliang@kylinos.cn>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <9133981edb83438ee10e6da9ef4e5cc6bf7f188b.1741258415.git.tanggeliang@kylinos.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Geliang,

On 06/03/2025 12:01, Geliang Tang wrote:
> From: Geliang Tang <tanggeliang@kylinos.cn>
> 
> This patch adds a "struct_group(reset, ...)" in struct mptcp_pm_data to
> simplify the reset, and make sure we don't miss any.

Do you mind checking if, before this patch, we didn't already miss the
reset of some fields? (I think I quickly checked last time and
everything was reset here, or a bit later (e.g. server_side). If we
missed something, we will need a dedicated patch reseting the missing
fields first, with a Fixes tag, for -net, then this patch using
'struct_group' to ease the reset.

> Suggested-by: Matthieu Baerts <matttbe@kernel.org>
> Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
> ---
>  net/mptcp/pm.c       | 14 +-------------
>  net/mptcp/protocol.h |  4 ++++
>  2 files changed, 5 insertions(+), 13 deletions(-)
> 
> diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
> index eefed554dcc9..1400bfed4b0d 100644
> --- a/net/mptcp/pm.c
> +++ b/net/mptcp/pm.c
> @@ -983,12 +983,7 @@ void mptcp_pm_data_reset(struct mptcp_sock *msk)
>  	u8 pm_type = mptcp_get_pm_type(sock_net((struct sock *)msk));
>  	struct mptcp_pm_data *pm = &msk->pm;
>  
> -	pm->add_addr_signaled = 0;
> -	pm->add_addr_accepted = 0;
> -	pm->local_addr_used = 0;
> -	pm->subflows = 0;
> -	pm->rm_list_tx.nr = 0;
> -	pm->rm_list_rx.nr = 0;

Just to be sure, is it OK to reset the list with memset(0)? (I didn't check)

> +	memset(&pm->reset, 0, sizeof(pm->reset));
>  	WRITE_ONCE(pm->pm_type, pm_type);
>  
>  	if (pm_type == MPTCP_PM_TYPE_KERNEL) {
> @@ -1005,15 +1000,8 @@ void mptcp_pm_data_reset(struct mptcp_sock *msk)
>  			   !!mptcp_pm_get_add_addr_accept_max(msk) &&
>  			   subflows_allowed);
>  		WRITE_ONCE(pm->accept_subflow, subflows_allowed);
> -	} else {
> -		WRITE_ONCE(pm->work_pending, 0);
> -		WRITE_ONCE(pm->accept_addr, 0);
> -		WRITE_ONCE(pm->accept_subflow, 0);
>  	}
>  
> -	WRITE_ONCE(pm->addr_signal, 0);
> -	WRITE_ONCE(pm->remote_deny_join_id0, false);
> -	pm->status = 0;
>  	bitmap_fill(pm->id_avail_bitmap, MPTCP_PM_MAX_ADDR_ID + 1);
>  }
>  
> diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
> index 0ef758d233b7..47710db243f4 100644
> --- a/net/mptcp/protocol.h
> +++ b/net/mptcp/protocol.h
> @@ -223,6 +223,8 @@ struct mptcp_pm_data {
>  
>  	spinlock_t	lock;		/*protects the whole PM data */
>  
> +	struct_group(reset,
> +
>  	u8		addr_signal;
>  	bool		server_side;
>  	bool		work_pending;
> @@ -238,6 +240,8 @@ struct mptcp_pm_data {
>  	DECLARE_BITMAP(id_avail_bitmap, MPTCP_PM_MAX_ADDR_ID + 1);

Maybe better to move this bitmap after the reset group, because it is
large, and it will be overwritten with 1 just after the reset.

>  	struct mptcp_rm_list rm_list_tx;
>  	struct mptcp_rm_list rm_list_rx;
> +
> +	);
>  };
>  
>  struct mptcp_pm_local {
Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

