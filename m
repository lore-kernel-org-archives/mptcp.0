Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAEC72F60B2
	for <mptcp@lists.linux.dev>; Sat, 22 Nov 2025 12:14:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763813696; cv=none; b=mw+3EiLgjqpOeMLe1V+9ztvhx7J5UEVFKbUiybkmFh7U2DmIRHEuKl3d6/RFZIfJOX9nTR2IKvu7L+z8iydkaBrkP1jgpfetsdviK4snxJv+YfkPZM8iCZIbxf1uXffhUE5zL5FSlgvR/kP+d51pknGGv1hLkWbVHsEuWqY7p8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763813696; c=relaxed/simple;
	bh=X2I1wjeeeODt417hms8lIl3d5DAcAG1UJX9QO69mt84=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Rr/PKSyYUny/J9CE0OWifj75T6jQ/WoSBuA/7LgZ60HBORmhSDGAApVinisrEyfBF2SWuvOKLctdlMahuIkQDr89aA09M8yMpzzd4wNSyAsPswk2OJR8g+XYAiPa6k1bPyAEEfMNyMF37ijvP5r9y5CS1dInmeB8KaQTGOEkMG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lF7l9G7p; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lF7l9G7p"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CAC6CC4CEF5;
	Sat, 22 Nov 2025 12:14:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763813696;
	bh=X2I1wjeeeODt417hms8lIl3d5DAcAG1UJX9QO69mt84=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=lF7l9G7pb3NN92yUu9l4/qVLFw7D8JcLchZO7QZcFIwuu4tONfKLwt0X20bJtvhbr
	 5LHgJVmbKcJrXK5I+v36XhrWiv1F9STxBQD6lUE/jlWwsnKTxDlH4cEEV0IuKMKqPM
	 DaKyAd0c1Kcog3XgUf5aHoceE4pos0XG92IACNKhGqTz72toyBDS7ItrW2t6fxu0+L
	 R6h2X0fBScXBZI+TiftCMms17iSgJrk9skaKZDmAtqSCYR3e1r/617TSjtLY5mSbzN
	 AE7ljpZ/lfKETYqWRcwldVfFrrMg9ZSfoqIelEB/ldcEuGJNOuBVUCcC1yeB2/PEAB
	 0uLWSJnOVpEKw==
Message-ID: <b5cf59c34d0f47f32cce5ea0fe0f419beed4fa7d.camel@kernel.org>
Subject: Re: [PATCH mptcp-net] mptcp: schedule rtx timer only after pushing
 data
From: Geliang Tang <geliang@kernel.org>
To: Paolo Abeni <pabeni@redhat.com>, mptcp@lists.linux.dev
Cc: dcaratti@redhat.com
Date: Sat, 22 Nov 2025 20:14:53 +0800
In-Reply-To: <9f5e5b6c05fa0e6d303126c6a68a19305d166d36.1763715034.git.pabeni@redhat.com>
References: 
	<9f5e5b6c05fa0e6d303126c6a68a19305d166d36.1763715034.git.pabeni@redhat.com>
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

On Fri, 2025-11-21 at 09:52 +0100, Paolo Abeni wrote:
> The MPTCP protocol usually schedule the retransmission timer only
> when there is some chances for such retransmissions to happen.
> 
> With a notable exception: __mptcp_push_pending() currently schedule
> such timer unconditionally, potentially leading to unnecessary rtx
> timer expiration.
> 
> The issue is present since the blamed commit below but become easily
> reproducible after commit 27b0e701d387 ("mptcp: drop bogus
> optimization in
> __mptcp_check_push()")
> 
> Fixes: 33d41c9cd74c ("mptcp: more accurate timeout")
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> ---
> Note that the blamed commit states we always need to rearm the timer
> even
> with no data pending, to catch link failures. That sounds
> weird/possibly
> tied to broken zero window probes?!? Hopefully mp_join self test
> should
> catch that
> ---
>  net/mptcp/protocol.c | 15 +++++++++------
>  1 file changed, 9 insertions(+), 6 deletions(-)
> 
> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index 3b327e9ccb78..b3122f53827f 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -1649,7 +1649,7 @@ void __mptcp_push_pending(struct sock *sk,
> unsigned int flags)
>  	struct mptcp_sendmsg_info info = {
>  				.flags = flags,
>  	};
> -	bool do_check_data_fin = false;
> +	bool copied = false;
>  	int push_count = 1;
>  
>  	while (mptcp_send_head(sk) && (push_count > 0)) {
> @@ -1691,7 +1691,7 @@ void __mptcp_push_pending(struct sock *sk,
> unsigned int flags)
>  						push_count--;
>  					continue;
>  				}
> -				do_check_data_fin = true;
> +				copied = true;
>  			}
>  		}
>  	}
> @@ -1700,11 +1700,14 @@ void __mptcp_push_pending(struct sock *sk,
> unsigned int flags)
>  	if (ssk)
>  		mptcp_push_release(ssk, &info);
>  
> -	/* ensure the rtx timer is running */

nit:

This comment remains valid and can be moved inside the if (copied)
block together.

Thanks,
-Geliang

> -	if (!mptcp_rtx_timer_pending(sk))
> -		mptcp_reset_rtx_timer(sk);
> -	if (do_check_data_fin)
> +	/* Avoid scheduling the rtx timer if no data has been
> pushed; the timer
> +	 * will be updated on positive acks by
> __mptcp_cleanup_una().
> +	 */
> +	if (copied) {
> +		if (!mptcp_rtx_timer_pending(sk))
> +			mptcp_reset_rtx_timer(sk);
>  		mptcp_check_send_data_fin(sk);
> +	}
>  }
>  
>  static void __mptcp_subflow_push_pending(struct sock *sk, struct
> sock *ssk, bool first)
