Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C28B3232
	for <mptcp@lists.linux.dev>; Fri,  9 Aug 2024 00:28:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723163307; cv=none; b=KGY4XmlRdkc4ZVup9a30PNKbjNySS1lutYnr1uOnybglfVI4/RYgHFSfXH7w4caXTzjWjgJ5pLBXEZF4qISkp/RbWldt3xWKL4J5ZAG28+obEF3/RbtrQeh1E/vAFcYLgAqYij2kg4TlN2XJf9dJVTf0ffOU17OhjgjFev3gAno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723163307; c=relaxed/simple;
	bh=bWqOEL64zW4P//+YqR02IaxcwXSn9q6UJXGjsKTJOsI=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=J8n2zFg5Gia7BaGHhlYHCUhgwAz2HEnsAEQ67arnUtziTT3+7Z2iKfS3nuJDm2yQNHT3OHTL3YuuRRoxPt5skhV+JZR7BerdoFsA06hKZYo5wlwTi74FturDdGOkrUpeoYCnMeWiK6KG8lB8Y584sjUAeH7zoEP0LqApxn8R+cA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SURQqF4G; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SURQqF4G"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB79CC32782;
	Fri,  9 Aug 2024 00:28:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723163306;
	bh=bWqOEL64zW4P//+YqR02IaxcwXSn9q6UJXGjsKTJOsI=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=SURQqF4Gf4pdg2CrQBEONMAeMddNgfPQUSNe2iRXXjcngnMDy2xC/bzLIqU9uIDek
	 rcNIxQJFqmDeiMmRlAS9zYpgxISNbAyU8lCQPUB4QClrs/ATAY9kfvjGFK0su/oJjx
	 tOKy+BAbfhPEC8ZeOBNOFMOP/Mf3/0Xj1epgM/S3hk2Me0XwXAgXH3Nc0hU1uoz9yN
	 Esr3qnog3wIysuWUCc3O3j1WXsAlnBLl/03ifqAiEpUEzHjHMa7T43KnFzgxSm2Qnv
	 slhImsqX0JQ7MqxAoDMx6HzweZoYnxUSSFwTscgQ0cswzXnKvTSOTGc/0+nDD93Iky
	 4+8yxaFjCdUHA==
Date: Thu, 8 Aug 2024 17:28:26 -0700 (PDT)
From: Mat Martineau <martineau@kernel.org>
To: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
cc: mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-net v6 09/11] mptcp: close subflow when receiving
 TCP+FIN
In-Reply-To: <20240802-mptcp-pm-avail-v6-9-964ba9ce279f@kernel.org>
Message-ID: <661729ef-4fbd-a497-8a39-5657069384eb@kernel.org>
References: <20240802-mptcp-pm-avail-v6-0-964ba9ce279f@kernel.org> <20240802-mptcp-pm-avail-v6-9-964ba9ce279f@kernel.org>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII

On Fri, 2 Aug 2024, Matthieu Baerts (NGI0) wrote:

> When a peer decides to close one subflow in the middle of a connection
> having multiple subflows, the receiver of the first FIN should accept
> that, and close the subflow on its side as well. If not, the subflow
> will stay half closed, and would even continue to be used until the end
> of the MPTCP connection or a reset from the network.
>
> The issue has not been seen before, probably because the in-kernel
> path-manager always sends a RM_ADDR before closing the subflow. Upon the
> reception of this RM_ADDR, the other peer will initiate the closure on
> its side as well. On the other hand, if the RM_ADDR is lost, or if the
> path-manager of the other peer only closes the subflow without sending a
> RM_ADDR, the subflow would switch to TCP_CLOSE_WAIT, but that's it,
> leaving the subflow half-closed.
>
> So now, when the subflow switches to the TCP_CLOSE_WAIT state, and if
> the MPTCP connection has not been closed before with a DATA_FIN, the
> kernel owning the subflow schedules its worker to initiate the closure
> on its side as well.
>
> This issue can be easily reproduced with packetdrill, as visible in [1],
> by creating an additional subflow, injecting a FIN+ACK before sending
> the DATA_FIN, and expecting a FIN+ACK in return.
>
> Fixes: 40947e13997a ("mptcp: schedule worker when subflow is closed")
> Link: https://github.com/multipath-tcp/packetdrill/pull/154 [1]
> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
> ---
> net/mptcp/protocol.c | 5 ++++-
> net/mptcp/subflow.c  | 8 ++++++--
> 2 files changed, 10 insertions(+), 3 deletions(-)
>
> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index 13777c35496c..609d684135dc 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -2533,8 +2533,11 @@ static void __mptcp_close_subflow(struct sock *sk)
>
> 	mptcp_for_each_subflow_safe(msk, subflow, tmp) {
> 		struct sock *ssk = mptcp_subflow_tcp_sock(subflow);
> +		int ssk_state = inet_sk_state_load(ssk);
>
> -		if (inet_sk_state_load(ssk) != TCP_CLOSE)
> +		if (ssk_state != TCP_CLOSE &&
> +		    (ssk->sk_state != TCP_CLOSE_WAIT ||

Hi Matthieu -

Looks like both those ssk checks should use ssk_state, but otherwise the 
patch looks good.

- Mat

> +		     inet_sk_state_load(sk) != TCP_ESTABLISHED))
> 			continue;
>
> 		/* 'subflow_data_ready' will re-sched once rx queue is empty */
> diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
> index a7fb4d46e024..723cd3fbba32 100644
> --- a/net/mptcp/subflow.c
> +++ b/net/mptcp/subflow.c
> @@ -1255,12 +1255,16 @@ static void mptcp_subflow_discard_data(struct sock *ssk, struct sk_buff *skb,
> /* sched mptcp worker to remove the subflow if no more data is pending */
> static void subflow_sched_work_if_closed(struct mptcp_sock *msk, struct sock *ssk)
> {
> -	if (likely(ssk->sk_state != TCP_CLOSE))
> +	struct sock *sk = (struct sock *)msk;
> +
> +	if (likely(ssk->sk_state != TCP_CLOSE &&
> +		   (ssk->sk_state != TCP_CLOSE_WAIT ||
> +		    inet_sk_state_load(sk) != TCP_ESTABLISHED)))
> 		return;
>
> 	if (skb_queue_empty(&ssk->sk_receive_queue) &&
> 	    !test_and_set_bit(MPTCP_WORK_CLOSE_SUBFLOW, &msk->flags))
> -		mptcp_schedule_work((struct sock *)msk);
> +		mptcp_schedule_work(sk);
> }
>
> static bool subflow_can_fallback(struct mptcp_subflow_context *subflow)
>
> -- 
> 2.45.2
>
>
