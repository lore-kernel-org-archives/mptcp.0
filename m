Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8F46469D
	for <mptcp@lists.linux.dev>; Wed, 17 Jul 2024 04:25:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721190334; cv=none; b=HbcKZeBUTVcivjEG2QDCivD/EMUfkZER0HEeVoTqGXYuww4MbJmGu0TNERKpdRiSM5asaE8WwHikJ7G+HKcmOndtIq8U7c0/KqAU9tXtk61Lsl3TFRukgPzW2ZnEzg5D6lTZDmXs7QsNWWplmxWT23rjDaBuiyM6vwW5anXDObY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721190334; c=relaxed/simple;
	bh=xUx8TqSd4PXSrmD0yJSaHFM3tuGIW6ZFxPqg8Pnoy1s=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=e60zAxNJT1RaKGLQB7fnLdWH3c4No6KL8xW2OvUKs7lXYbMjOfoQCB5v2mXu1ogRgHWOFAVvgOKVCcoqOuF4fepgBN74Pvla1spi8TA+LOvAW5PUMUESOlBE5CxZYTSyVLnlSx9k9capSQ1vS+8qc5OUupTBHhVs5UsBcNdNOxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bs3L+Ayc; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bs3L+Ayc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79A85C32782;
	Wed, 17 Jul 2024 04:25:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721190333;
	bh=xUx8TqSd4PXSrmD0yJSaHFM3tuGIW6ZFxPqg8Pnoy1s=;
	h=Subject:From:To:Date:In-Reply-To:References:From;
	b=bs3L+AycFln7nEr+ChQCZ441Ts95peHYrceukj9NgdcPeVT/Q7+86woNtGrRfIZD4
	 5Oemv12a0x2DW5IJ5+OmfpwO+yVHdJ1kccOk7AQ0QUnDOAXNoY/P2TU8Ku4Oq/koow
	 v51Vsuw6y6PGvbk7oLiAzE+UPWnedh+acPth/efaVc3GUy5rECi89vDuTgd1SxFsA2
	 Kvze5fYn/Ub3h/hoGWmwLz7pq4VYkfmd8ehqK0khhmfewz4PEtLZ7r2Rv1QbMT961s
	 rcYIPI6WHU10b6HjN54KOUjtSjinwmaqZ4cGQhKbwor8Y7v4WkW5Q6bVjqrPO/3rR6
	 gSUULmTpg+VOg==
Message-ID: <b1e4da8f4c7ed9179e4e6730f8b18f8661ace772.camel@kernel.org>
Subject: Re: [PATCH mptcp-net v2 1/9] mptcp: sched: check both directions
 for backup
From: Geliang Tang <geliang@kernel.org>
To: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, mptcp@lists.linux.dev
Date: Wed, 17 Jul 2024 12:25:27 +0800
In-Reply-To: <20240716-mptcp-backup-mpj-v2-1-4d50247405fb@kernel.org>
References: <20240716-mptcp-backup-mpj-v2-0-4d50247405fb@kernel.org>
	 <20240716-mptcp-backup-mpj-v2-1-4d50247405fb@kernel.org>
Autocrypt: addr=geliang@kernel.org; prefer-encrypt=mutual;
 keydata=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
 TO0tfEdfAX7IENcV87h2yAFBZkaA==
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.52.0-1build2 
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue, 2024-07-16 at 22:53 +0200, Matthieu Baerts (NGI0) wrote:
> The 'mptcp_subflow_context' structure has two items related to the
> backup flags:
> 
>  - 'backup': the subflow has been marked as backup by the other peer
> 
> - 'request_bkup': the backup flag has been set by the host

The two lines are not aligned.

> 
> Before this patch, the scheduler was only looking at the 'backup'
> flag.
> That can make sense in some cases, but it looks like that's not what
> we
> wanted for the general use, because either the path-manager was
> setting
> both of them when sending an MP_PRIO, or the receiver was duplicating
> the 'backup' flag in the subflow request.
> 
> Note that the use of these two flags in the path-manager are going to
> be
> fixed in the next commits, but this change here is needed not to
> modify
> the behaviour.
> 
> Fixes: f296234c98a8 ("mptcp: Add handling of incoming MP_JOIN
> requests")

Patch 3 can be squashed into this one, with two "Fixes" tags here.

WDYT?

Thanks,
-Geliang

> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
> ---
>  include/trace/events/mptcp.h |  2 +-
>  net/mptcp/protocol.c         | 10 ++++++----
>  2 files changed, 7 insertions(+), 5 deletions(-)
> 
> diff --git a/include/trace/events/mptcp.h
> b/include/trace/events/mptcp.h
> index 09e72215b9f9..085b749cdd97 100644
> --- a/include/trace/events/mptcp.h
> +++ b/include/trace/events/mptcp.h
> @@ -34,7 +34,7 @@ TRACE_EVENT(mptcp_subflow_get_send,
>  		struct sock *ssk;
>  
>  		__entry->active = mptcp_subflow_active(subflow);
> -		__entry->backup = subflow->backup;
> +		__entry->backup = subflow->backup || subflow-
> >request_bkup;
>  
>  		if (subflow->tcp_sock && sk_fullsock(subflow-
> >tcp_sock))
>  			__entry->free =
> sk_stream_memory_free(subflow->tcp_sock);
> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index ac94225489f8..b3a48d97f009 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -1422,13 +1422,15 @@ struct sock *mptcp_subflow_get_send(struct
> mptcp_sock *msk)
>  	}
>  
>  	mptcp_for_each_subflow(msk, subflow) {
> +		bool backup = subflow->backup || subflow-
> >request_bkup;
> +
>  		trace_mptcp_subflow_get_send(subflow);
>  		ssk =  mptcp_subflow_tcp_sock(subflow);
>  		if (!mptcp_subflow_active(subflow))
>  			continue;
>  
>  		tout = max(tout,
> mptcp_timeout_from_subflow(subflow));
> -		nr_active += !subflow->backup;
> +		nr_active += !backup;
>  		pace = subflow->avg_pacing_rate;
>  		if (unlikely(!pace)) {
>  			/* init pacing rate from socket */
> @@ -1439,9 +1441,9 @@ struct sock *mptcp_subflow_get_send(struct
> mptcp_sock *msk)
>  		}
>  
>  		linger_time = div_u64((u64)READ_ONCE(ssk-
> >sk_wmem_queued) << 32, pace);
> -		if (linger_time < send_info[subflow-
> >backup].linger_time) {
> -			send_info[subflow->backup].ssk = ssk;
> -			send_info[subflow->backup].linger_time =
> linger_time;
> +		if (linger_time < send_info[backup].linger_time) {
> +			send_info[backup].ssk = ssk;
> +			send_info[backup].linger_time = linger_time;
>  		}
>  	}
>  	__mptcp_set_timeout(sk, tout);
> 

