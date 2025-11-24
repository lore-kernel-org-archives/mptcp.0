Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE0D927FB1E
	for <mptcp@lists.linux.dev>; Mon, 24 Nov 2025 18:18:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764008319; cv=none; b=OIDNo8wPQJMmB9vKNisH1lJVc4jAc0Z+9Bazv1A4ybzg3pkL2FChiKKIUEIVdopLINp6O6bK+ux/Nm7YKl4U+uJ5vlYvMo6reLBX1jEBOgx+e0MzdSe2lk81Q2q4250BOW6YZxrXgx01ldljLtMT9p/35G3i/unC5svIG5wL3W0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764008319; c=relaxed/simple;
	bh=mMvOIz8Nm7FuSI48Tu78p+jiyefpr74061U+p8GqTKM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Dibeb/qhMvXPpHIXbB8bLqCDxnx01jeNiODpU1T3p4kclAIwd18MPYTSfZM6ECskiQxRZwF304CVTa0lL2FK8D+HXhdM7csekETIunQZ+n3hrLLm+E1YdiWZUCkQ2q0FBC5IX35BjoyYySp/seyI9unztz2DK6EIduycAaer2bo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CWQGFLYC; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CWQGFLYC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83694C4CEF1;
	Mon, 24 Nov 2025 18:18:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764008319;
	bh=mMvOIz8Nm7FuSI48Tu78p+jiyefpr74061U+p8GqTKM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=CWQGFLYCX2EM8aUmIGhS+zio1m+sz1GuXBcmKs1fI/HAl1fpFTSGgUpXSviHU3eO1
	 HN6MXn6nk0mlfjUe4PAPb5hOqz6iZBiodN8hBLQOktgZNPHqfdZG3i2uLol9iAlhY6
	 Holv8ju8i/jF/nztN+mBI48THDd3PeDE75OI36SDfZrLGw7sIXOHbS6oN09KvC2A2k
	 W/Ws8gG+i8cucULs+BcwIyb3LwVmITpLIhCfVeVj3IDb8oQ3VIuJ56V5hzmsBLDq24
	 xnnuKh7er27ji1DBQUIFVGPpgJLjcWrS/9jDb6l/d5ylK4rJj2C/LvAkSzRF7J9Glm
	 V/Zva8dxNV9gQ==
Message-ID: <fbd12dc4-ad95-46df-965b-43bf9de430ab@kernel.org>
Date: Mon, 24 Nov 2025 19:18:35 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH mptcp-net] mptcp: clear scheduled subflows on retransmit
Content-Language: en-GB, fr-BE
To: Paolo Abeni <pabeni@redhat.com>, mptcp@lists.linux.dev
Cc: dcaratti@redhat.com
References: <30e5325f37026b870cd0d0765d5d47c8a68fced9.1763676964.git.pabeni@redhat.com>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <30e5325f37026b870cd0d0765d5d47c8a68fced9.1763676964.git.pabeni@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Paolo,

On 20/11/2025 23:16, Paolo Abeni wrote:
> When __mptcp_retrans() kicks-in, it schedules one or more subflow for
> retransmission, but such subflows could be actually left alone if there
> is no more data to retransmit and/or in case of concurrent fallback.
> 
> Scheduled subflows could be processed much later in time, i.e. when new
> data will be transmitted, leading to bad subflow selection.
> 
> Explicitly clear all scheduled subflows before leaving the retransmission
> function.
> 
> Fixes: ee2708aedad0 ("mptcp: use get_retrans wrapper")
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> ---
>  net/mptcp/protocol.c | 13 +++++++++++--
>  1 file changed, 11 insertions(+), 2 deletions(-)
> 
> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index 6f4220c8b5bb..3b327e9ccb78 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -2763,7 +2763,7 @@ static void __mptcp_retrans(struct sock *sk)
>  		}
>  
>  		if (!mptcp_send_head(sk))
> -			return;
> +			goto clear_scheduled;
>  
>  		goto reset_timer;
>  	}
> @@ -2794,7 +2794,7 @@ static void __mptcp_retrans(struct sock *sk)
>  			if (__mptcp_check_fallback(msk)) {
>  				spin_unlock_bh(&msk->fallback_lock);
>  				release_sock(ssk);
> -				return;
> +				goto clear_scheduled;
>  			}
>  
>  			while (info.sent < info.limit) {
> @@ -2826,6 +2826,15 @@ static void __mptcp_retrans(struct sock *sk)
>  
>  	if (!mptcp_rtx_timer_pending(sk))
>  		mptcp_reset_rtx_timer(sk);
> +
> +clear_scheduled:
> +	/* If no rtx data was available or in case of fallback, there

When reading this comment, it sounds like a "return" could be added
before this new label (clear_scheduled). Is it always needed to clear
this flag or only in these two cases?

> +	 * could be left-over scheduled subflows; clear them all
> +	 * or later xmit could use bad ones
> +	 */
> +	mptcp_for_each_subflow(msk, subflow)
> +		if (READ_ONCE(subflow->scheduled))
> +			mptcp_subflow_set_scheduled(subflow, false);
>  }
>  
>  /* schedule the timeout timer for the relevant event: either close timeout

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

