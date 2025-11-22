Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 282EF2773F
	for <mptcp@lists.linux.dev>; Sat, 22 Nov 2025 12:59:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763816371; cv=none; b=PqaRvfCziikQjEQi00K5SiQmMVMgjS+y9HD/cNLn2JHHbTWH0vUsxJhiw4U8alXypKX7ThF5lZ4j1XvWxbj7dAaSht7hxrnnU9hTMS3GtXHMj7eLt1t5lGb9B7tf7478k4N7ULY08frYYqbDrXmVqaz5Mub6K5C8wZJ2UR9JWKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763816371; c=relaxed/simple;
	bh=B3kW9KXHwZ90SF6OoXrJsEdPmwanb9+gu2u+puL+rSE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=aNFM/ykRBZhSOJvcUmOtC3MuRsNwytqf0rwM/gLMeUzuCpeoUJY87g+hLPnJY8IsNEbLWaSNpxBKjD6vO15AnxHQwRReZfEmt0KQmvfbVLv7RyrBCSxJhwifRIWYaS0HIgNIm2PXaJlZEd8nWwIckZiU8yoFBxIsG17dbNzCGnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rhn6pP30; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rhn6pP30"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1EEDC4CEF5;
	Sat, 22 Nov 2025 12:59:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763816370;
	bh=B3kW9KXHwZ90SF6OoXrJsEdPmwanb9+gu2u+puL+rSE=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=rhn6pP30j85R16Pimii/r+9yPIDENX/FgkKSA/af+sshrJiU9jS+IWS40skbIoazB
	 z0L698KmOTRTBludXEuYsgoGIbgbXvYN0kLSYE3Gw5ZBia2aasrnEORg9eqUZ4XjnO
	 uAQE5ViYqJSkX8MqTjCbMK2Zjpx85ul58ESP6KuE1jaLJn1ri57cndIGvU+Db0dWIo
	 ODApdrAfK9ZnfXUFWjJI+qNn0W46edWPBVsGGdQonWTMmn0qCZdmXJEqgGe6r+bMkB
	 ArfTuODNKCCcGka+TfMFJrTFsTPFul2RbRZGwKKOcTCpzxm4dO05MnWkDGkv34wkFi
	 crOWfr6aIz8IQ==
Message-ID: <f53b9be4a701bf2696a96fb316f538aca2566bdf.camel@kernel.org>
Subject: Re: [PATCH mptcp-net] mptcp: clear scheduled subflows on retransmit
From: Geliang Tang <geliang@kernel.org>
To: Paolo Abeni <pabeni@redhat.com>, mptcp@lists.linux.dev
Cc: dcaratti@redhat.com
Date: Sat, 22 Nov 2025 20:59:27 +0800
In-Reply-To: <30e5325f37026b870cd0d0765d5d47c8a68fced9.1763676964.git.pabeni@redhat.com>
References: 
	<30e5325f37026b870cd0d0765d5d47c8a68fced9.1763676964.git.pabeni@redhat.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.56.2-4 
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Paolo,

On Thu, 2025-11-20 at 23:16 +0100, Paolo Abeni wrote:
> When __mptcp_retrans() kicks-in, it schedules one or more subflow for
> retransmission, but such subflows could be actually left alone if
> there
> is no more data to retransmit and/or in case of concurrent fallback.
> 
> Scheduled subflows could be processed much later in time, i.e. when
> new
> data will be transmitted, leading to bad subflow selection.
> 
> Explicitly clear all scheduled subflows before leaving the
> retransmission
> function.
> 
> Fixes: ee2708aedad0 ("mptcp: use get_retrans wrapper")
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> ---
>  net/mptcp/protocol.c | 13 +++++++++++--
>  1 file changed, 11 insertions(+), 2 deletions(-)
> 
> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index 6f4220c8b5bb..3b327e9ccb78 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -2763,7 +2763,7 @@ static void __mptcp_retrans(struct sock *sk)
>  		}
>  
>  		if (!mptcp_send_head(sk))
> -			return;
> +			goto clear_scheduled;
>  
>  		goto reset_timer;
>  	}
> @@ -2794,7 +2794,7 @@ static void __mptcp_retrans(struct sock *sk)
>  			if (__mptcp_check_fallback(msk)) {
>  				spin_unlock_bh(&msk->fallback_lock);
>  				release_sock(ssk);
> -				return;
> +				goto clear_scheduled;
>  			}
>  
>  			while (info.sent < info.limit) {
> @@ -2826,6 +2826,15 @@ static void __mptcp_retrans(struct sock *sk)
>  
>  	if (!mptcp_rtx_timer_pending(sk))
>  		mptcp_reset_rtx_timer(sk);
> +
> +clear_scheduled:
> +	/* If no rtx data was available or in case of fallback,
> there
> +	 * could be left-over scheduled subflows; clear them all
> +	 * or later xmit could use bad ones
> +	 */
> +	mptcp_for_each_subflow(msk, subflow)
> +		if (READ_ONCE(subflow->scheduled))
> +			mptcp_subflow_set_scheduled(subflow, false);
>  }

If this __mptcp_retrans() needs to clear scheduled subflows, then
shouldn't similar this clear_scheduled operations also be added at the
end of both the __mptcp_push_pending() and
__mptcp_subflow_push_pending()?

Thanks,
-Geliang

>  
>  /* schedule the timeout timer for the relevant event: either close
> timeout
