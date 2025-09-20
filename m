Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AF611C01
	for <mptcp@lists.linux.dev>; Sat, 20 Sep 2025 00:04:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758326657; cv=none; b=n1F9HLKhIkpDO0QQD07CLmIj/eIyqWR5/HuLBtCTRcx+heZU0Ibtu0OVB+hA+jI3DAWH8UKq+ne3R5xFLxPjN9XsSpgOikPWpZrbfx9EFsCAXjLYsOe6Hy69+dbyOTiz0xiAQjzqCTkVSlVouTxQSm+zm+BtcTRe3A0L5HGmLNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758326657; c=relaxed/simple;
	bh=mCFmNM8SzlazeFFrDofnt2HW/rvQ6QjHS53M4iYt3ac=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=TAZbBojQvp41zYk57MdM+hgtq5mrD0WNjkcBc2poEgANxAoKChkKr5H/mlBjlmi752DRaIi8qsvVCyktFgLjusAv7vlZWSqftZaw3580IxS9StDHmZBCnxsIdkEZSwuHj+t4QFcixBL7+M/rz/GFd4Okp6DuLLT9Y9MRQryVHMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PLyP54K5; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PLyP54K5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5833CC4CEF0;
	Sat, 20 Sep 2025 00:04:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758326655;
	bh=mCFmNM8SzlazeFFrDofnt2HW/rvQ6QjHS53M4iYt3ac=;
	h=Subject:From:To:Date:In-Reply-To:References:From;
	b=PLyP54K58g1iM4oCwy1ouVWoE6wCif4Iocnhq/c9592Mrak4nlukuN/f7thDZBLL5
	 2/EVBUFFL9JJDRAAN679PYJkSZGp42aarA02UAhsEN/bk5NfWomSjq/ODxrvmRibI/
	 Bgt7WqYvlfApGspDAHORhNUKdPewYW/sk30Qk+3Meh156AMd7fbJQWQ24X6SvXaAtg
	 2D6+p0qWDYpR42/5aKb/Fep8JGtrlWootTMRi7L+BZZcy8E1SB68PqJeSsvkkJ9XBE
	 b8XTIPL2v+WKQt3GIjvzJsSX5X4P1vxq0LtxsIgzyYC1ndDayZ+TUgHn468iUP2OZR
	 MWtLS8zWilo6A==
Message-ID: <676f901e815cf02379af4f24dd2df51ae23b398a.camel@kernel.org>
Subject: Re: [MPTCP next v3 08/12] mptcp: cleanup fallback data fin reception
From: Geliang Tang <geliang@kernel.org>
To: Paolo Abeni <pabeni@redhat.com>, mptcp@lists.linux.dev
Date: Sat, 20 Sep 2025 08:04:12 +0800
In-Reply-To: <48b486e75249911cbee4325706622116e3a41a66.1758296923.git.pabeni@redhat.com>
References: <cover.1758296923.git.pabeni@redhat.com>
	 <48b486e75249911cbee4325706622116e3a41a66.1758296923.git.pabeni@redhat.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.56.0-1 
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Fri, 2025-09-19 at 17:53 +0200, Paolo Abeni wrote:
> MPTCP currently generate a dummy data_fin for fallback socket
> when the fallback subflow has completed data reception using
> the current ack_seq.
> 
> We are going to introduce backlog usage for the msk soon, even
> for fallback sockets: the ack_seq value will not match the most
> recent
> sequence number seen by the fallback subflow socket, as it will
> ignore
> data_seq sitting in the backlog.
> 
> Instead use the last map sequence number to set the data_fin,
> as fallback (dummy) map sequences are always in sequence.
> 
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>

LGTM.

Reviewed-by: Geliang Tang <geliang@kernel.org>
Tested-by: Geliang Tang <geliang@kernel.org>

Thanks,
-Geliang

> ---
> v2 -> v3:
>   - keep the close check in subflow_sched_work_if_closed, fix
>     CI failures
> ---
>  net/mptcp/subflow.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
> index e8325890a3223..b9455c04e8a46 100644
> --- a/net/mptcp/subflow.c
> +++ b/net/mptcp/subflow.c
> @@ -1285,6 +1285,7 @@ static bool subflow_is_done(const struct sock
> *sk)
>  /* sched mptcp worker for subflow cleanup if no more data is pending
> */
>  static void subflow_sched_work_if_closed(struct mptcp_sock *msk,
> struct sock *ssk)
>  {
> +	const struct mptcp_subflow_context *subflow =
> mptcp_subflow_ctx(ssk);
>  	struct sock *sk = (struct sock *)msk;
>  
>  	if (likely(ssk->sk_state != TCP_CLOSE &&
> @@ -1303,7 +1304,8 @@ static void subflow_sched_work_if_closed(struct
> mptcp_sock *msk, struct sock *ss
>  	 */
>  	if (__mptcp_check_fallback(msk) && subflow_is_done(ssk) &&
>  	    msk->first == ssk &&
> -	    mptcp_update_rcv_data_fin(msk, READ_ONCE(msk->ack_seq),
> true))
> +	    mptcp_update_rcv_data_fin(msk, subflow->map_seq +
> +				      subflow->map_data_len, true))
>  		mptcp_schedule_work(sk);
>  }
>  
