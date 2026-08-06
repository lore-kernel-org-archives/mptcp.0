Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FB5D3DDAFD
	for <mptcp@lists.linux.dev>; Thu,  6 Aug 2026 09:31:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786008697; cv=none; b=DtrAk57H/y0ARJS1mByeBov89H+0we89yyC5wp2FOgI/kDwat6optfT3AACz9cA5JCYfRxsyULeXnO3MIPvSLGA8AqHll0XMN21bC8v4TQ+I2jsv5ZzrrJPGgnE9/9/vO9r9EUrmkN/3Mbcnohip9M5qwJYzQkrt5n+ibiZUiqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786008697; c=relaxed/simple;
	bh=wznChJ4GEEbGNWewIHkJnSkbXlsQg3ZdffLcWrEAM6U=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=N+13VXwPKKD06ICMjet4O8CieanqdtZ+g05Gs67TcyIYxa/eqw8ZpU7NDpXeHHC7AZ4izg7CPocBvC/+zT7edSeD11D0VeV+v08Dxo8OZDNIjRoC7jzDmvJnAKJLxW9QsMVI1oTSlL1oKbPnVmKayOVkJ+FGUsj3Gbj2ZVIN/3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O8Qxnj8w; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O8Qxnj8w"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B57E1F000E9;
	Thu,  6 Aug 2026 09:31:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786008695;
	bh=GrKo8n5+TZouvcAUPNumA7FvJn01Z+A0W0c4mLqxXP8=;
	h=Subject:From:To:Date:In-Reply-To:References;
	b=O8Qxnj8wEIPkKvHQ0mWmXMCMX/f9F/UqhkGtqu2fZBgcBVMq+BzGa2QGIQx1cYSsb
	 jFBhQnd7XgaatWgG0Vyxd+v/Oxi5qQCoW3Wh55eSC848arrq6adEZ3Qp2tUmoBLgVV
	 hqmwxxBOdMRM8c5LMWKdubnBpuzVh/mZPk5EoVD+5yxtgeAdYd4yFAlUC59n1/At3i
	 csgru4O9BrBNp0NJp4POdwWi1MIPoDPXvtuZQhYbDyQGn7GvkapMdraGpM0RTO2yAI
	 XA05d6k1JOGenVPE/uFR63MgDQc1xnSH0iQwH8/NwRFi225p+U85TbUphP0pAZFkyi
	 XsuFqblf0QOCg==
Message-ID: <8a3758427e722a547c1a173dff8149c4cd33a479.camel@kernel.org>
Subject: Re: [PATCH mptcp-next 2/7] mptcp: move the stale logic out of
 retrans scheduler
From: Geliang Tang <geliang@kernel.org>
To: Paolo Abeni <pabeni@redhat.com>, mptcp@lists.linux.dev
Date: Thu, 06 Aug 2026 17:31:31 +0800
In-Reply-To: <57485667802eaecb541c09a3c0964b8528578058.1785943854.git.pabeni@redhat.com>
References: <cover.1785943854.git.pabeni@redhat.com>
	 <57485667802eaecb541c09a3c0964b8528578058.1785943854.git.pabeni@redhat.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.56.2-9 
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Paolo,

Thank you for this new version of the series. I have rebased the MPTCP
KTLS code onto it, and all tests passed.

On Wed, 2026-08-05 at 18:17 +0200, Paolo Abeni wrote:
> This allow separating the stale logic invocation and the retrans
> scheduler, and will simplify the next patch.
> 
> It's also a cleaner design as the retrans scheduler has currently
> too many side effects. As a possible downside, the retrans work will
> now traverse the subflows list additional times; that does not matter
> much, as this is slowpath.

However, this patch makes the KTLS selftests significantly slower -
specifically, this test case now takes several hundred seconds to
complete, whereas it previously finished in just a few seconds:

	chunked_sendfile(_metadata, self, 1, 4096);

Is there any way we can make it run faster?

Thanks,
-Geliang

> 
> While at it, pick more accurate names for the involved helpers
> 
> Also note that the scheduler and the stale logic may observe
> different
> subflow statues, as no lock is acquired. This is intentional and not
> harmful, worst case leading to slower retransmissions.
> 
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> ---
>  net/mptcp/pm.c       | 42 +++++++++++++++++++++++++++---------------
>  net/mptcp/protocol.c |  4 ++--
>  net/mptcp/protocol.h |  2 +-
>  3 files changed, 30 insertions(+), 18 deletions(-)
> 
> diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
> index 5e499ec1c50a..9ce50e8a149d 100644
> --- a/net/mptcp/pm.c
> +++ b/net/mptcp/pm.c
> @@ -1061,7 +1061,7 @@ bool mptcp_pm_is_backup(struct mptcp_sock *msk,
> struct sock_common *skc)
>  	return msk->pm.ops->get_priority(msk, &skc_local);
>  }
>  
> -static void mptcp_pm_subflows_chk_stale(const struct mptcp_sock
> *msk, struct sock *ssk)
> +static void mptcp_pm_subflow_chk_stale(const struct mptcp_sock *msk,
> struct sock *ssk)
>  {
>  	struct mptcp_subflow_context *iter, *subflow =
> mptcp_subflow_ctx(ssk);
>  	struct sock *sk = (struct sock *)msk;
> @@ -1098,22 +1098,34 @@ static void mptcp_pm_subflows_chk_stale(const
> struct mptcp_sock *msk, struct soc
>  	}
>  }
>  
> -void mptcp_pm_subflow_chk_stale(const struct mptcp_sock *msk, struct
> sock *ssk)
> +void mptcp_pm_chk_stale(const struct mptcp_sock *msk)
>  {
> -	struct mptcp_subflow_context *subflow =
> mptcp_subflow_ctx(ssk);
> -	u32 rcv_tstamp = READ_ONCE(tcp_sk(ssk)->rcv_tstamp);
> -
> -	/* keep track of rtx periods with no progress */
> -	if (!subflow->stale_count) {
> -		subflow->stale_rcv_tstamp = rcv_tstamp;
> -		subflow->stale_count++;
> -	} else if (subflow->stale_rcv_tstamp == rcv_tstamp) {
> -		if (subflow->stale_count < U8_MAX)
> +	struct mptcp_subflow_context *subflow;
> +
> +	mptcp_for_each_subflow(msk, subflow) {
> +		struct sock *ssk = mptcp_subflow_tcp_sock(subflow);
> +		u32 rcv_tstamp;
> +
> +		if (!__mptcp_subflow_active(subflow))
> +			continue;
> +
> +		/* No data outstanding at TCP level? not stale */
> +		if (tcp_rtx_and_write_queues_empty(ssk))
> +			continue;
> +
> +		/* keep track of rtx periods with no progress */
> +		rcv_tstamp = READ_ONCE(tcp_sk(ssk)->rcv_tstamp);
> +		if (!subflow->stale_count) {
> +			subflow->stale_rcv_tstamp = rcv_tstamp;
>  			subflow->stale_count++;
> -		mptcp_pm_subflows_chk_stale(msk, ssk);
> -	} else {
> -		subflow->stale_count = 0;
> -		mptcp_subflow_set_active(subflow);
> +		} else if (subflow->stale_rcv_tstamp == rcv_tstamp)
> {
> +			if (subflow->stale_count < U8_MAX)
> +				subflow->stale_count++;
> +			mptcp_pm_subflow_chk_stale(msk, ssk);
> +		} else {
> +			subflow->stale_count = 0;
> +			mptcp_subflow_set_active(subflow);
> +		}
>  	}
>  }
>  
> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index a21b10a8c5d3..88167edc6598 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -2469,7 +2469,6 @@ struct sock *mptcp_subflow_get_retrans(struct
> mptcp_sock *msk)
>  
>  		/* still data outstanding at TCP level? skip this */
>  		if (!tcp_rtx_and_write_queues_empty(ssk)) {
> -			mptcp_pm_subflow_chk_stale(msk, ssk);
>  			min_stale_count = min_t(int,
> min_stale_count, subflow->stale_count);
>  			continue;
>  		}
> @@ -2859,9 +2858,10 @@ static void __mptcp_retrans(struct sock *sk)
>  	struct mptcp_data_frag *dfrag;
>  	int err, len;
>  
> +	mptcp_pm_chk_stale(msk);
> +
>  	mptcp_clean_una_wakeup(sk);
>  
> -	/* first check ssk: need to kick "stale" logic */
>  	err = mptcp_sched_get_retrans(msk);
>  	dfrag = mptcp_rtx_head(sk);
>  	if (!dfrag) {
> diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
> index 0042112f118a..c5a9c3d3f223 100644
> --- a/net/mptcp/protocol.h
> +++ b/net/mptcp/protocol.h
> @@ -1104,7 +1104,7 @@ int mptcp_pm_parse_entry(struct nlattr *attr,
> struct genl_info *info,
>  bool mptcp_pm_addr_families_match(const struct sock *sk,
>  				  const struct mptcp_addr_info *loc,
>  				  const struct mptcp_addr_info
> *rem);
> -void mptcp_pm_subflow_chk_stale(const struct mptcp_sock *msk, struct
> sock *ssk);
> +void mptcp_pm_chk_stale(const struct mptcp_sock *msk);
>  void mptcp_pm_new_connection(struct mptcp_sock *msk, const struct
> sock *ssk, int server_side);
>  void mptcp_pm_fully_established(struct mptcp_sock *msk, const struct
> sock *ssk);
>  bool mptcp_pm_allow_new_subflow(struct mptcp_sock *msk);
