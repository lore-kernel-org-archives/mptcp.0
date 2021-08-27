Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [216.205.24.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D28D3FC2
	for <mptcp@lists.linux.dev>; Fri, 27 Aug 2021 14:33:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1630074791;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CEBeptVav0ypKtvhSijMsHwscJz76QIBwshChCBCYi0=;
	b=Pq3/W/Ic9alPgfTNpeJHIVZYXfnNzqucrXaLrn1US1Skzz8h8y6QJmQUItXSVvFa7w4BHk
	/PatZbLleyPbOJO4x2Y+4mUQ2Tocr4gSeMhS9Pvbde8RpcNn9V5BD7FuDL1adWx6DFd/Oj
	voQfUEPuXjimh/+4YD+91P4ZGYsCi4Q=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-261-cYe3756VNq6MKH0ANqmUqw-1; Fri, 27 Aug 2021 10:33:09 -0400
X-MC-Unique: cYe3756VNq6MKH0ANqmUqw-1
Received: by mail-wm1-f69.google.com with SMTP id r125-20020a1c2b830000b0290197a4be97b7so1815417wmr.9
        for <mptcp@lists.linux.dev>; Fri, 27 Aug 2021 07:33:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=CEBeptVav0ypKtvhSijMsHwscJz76QIBwshChCBCYi0=;
        b=QiISoybWAKVxNORgGtzF1C1ELMnAKZy8U4VYAtKfalkIEka7eNcSsz2R2f2fL+ZcDI
         rf01SPC4lUMdaLWZntljGaDRv6R9szy0MJkwzd0REDcr6iVnOlyHZOnQlR/Olc8rWvSz
         qcgcdLIKydr0/mEdiD/2cL5ffryeNsA6HjQBvioZdznzTGW5QcIkVAQd1ocB/7nvNMpo
         Ffb6uNLONtFjPNCeIphSY3IX23xSOki6H0wD1QeGxcZn/TCoY4CSGMyKTFvtXbe/GTmz
         QvkmC6ZWFKJ3Se7m3keBfvkgahs3nxNbHbxGOTs1zZASrfKWSPKPw8pSFzlkcQ3fjYoc
         Ctnw==
X-Gm-Message-State: AOAM530sooUHsQl0XH+Ty/V5NAi8we14YUj8uuRqOmywp8d02y7sXOtd
	VS6euU5jIY20RNRDgBDxCeVhvN9lz/8GQYR34cgyLRmAtT1okWYew5aQLD/LzhigDt7fztUWM3G
	v939oV0JkCRB8T6U=
X-Received: by 2002:adf:cd10:: with SMTP id w16mr11064725wrm.404.1630074788026;
        Fri, 27 Aug 2021 07:33:08 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwkXz/XGCtsx6SN9l8RAEJx1nf01K4k0MsFzFfh1WqW7fKeFQz114W01O1bctGWI0FIIbBPgw==
X-Received: by 2002:adf:cd10:: with SMTP id w16mr11064677wrm.404.1630074787743;
        Fri, 27 Aug 2021 07:33:07 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-233-185.dyn.eolo.it. [146.241.233.185])
        by smtp.gmail.com with ESMTPSA id h11sm13353550wmc.23.2021.08.27.07.33.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Aug 2021 07:33:07 -0700 (PDT)
Message-ID: <8abf35bb4ac75855d03a598d092b93d57743504a.camel@redhat.com>
Subject: Re: [PATCH mptcp] mptcp: do not shrink snd_nxt when recovering
From: Paolo Abeni <pabeni@redhat.com>
To: Florian Westphal <fw@strlen.de>, mptcp@lists.linux.dev
Date: Fri, 27 Aug 2021 16:33:06 +0200
In-Reply-To: <20210826234324.27764-1-fw@strlen.de>
References: <20210826234324.27764-1-fw@strlen.de>
User-Agent: Evolution 3.36.5 (3.36.5-2.fc32)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
	auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pabeni@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Fri, 2021-08-27 at 01:43 +0200, Florian Westphal wrote:
> When recovering after a link failure, snd_nxt should not be set to a
> lower value.  Else, update of snd_nxt is broken because:
> 
>   msk->snd_nxt += ret; (where ret is number of bytes sent)
> 
> assumes that snd_nxt always moves forward.
> After reduction, its possible that snd_nxt update gets out of sync:
> dfrag we just sent might have had a data sequence number even past
> snd_nxt_recovery.
> 
> This change factors the common msk state update to a helper
> and updates snd_nxt based on the current dfrag data sequence number.
> 
> The conditional is required for the recovery phase where we may
> re-transmit old dfrags that are before current snd_nxt.
> 
> After this change, snd_nxt only moves forward and covers all in-sequence
> data that was transmitted.
> 
> recovery_snd_nxt is retained to detect when recovery has completed.
> 
> Signed-off-by: Florian Westphal <fw@strlen.de>
> ---
>  Paolo, I think this is in line with what we discussed earlier today.
> 
>  This does NOT resolve issues/226, but as far as i can tell the
>  failure rate is cut in half: 500 runs of mptcp_join -l had 24 vs. 7
>  failures.
> 
>  I also no longer see
> 
>  ack_update_msk: invalid una (96072 or 424988 bytes, 1 below write_seq, cnt 22715
> 
>  debug log from ack_update_msk(), printed when we ignore advertised
>  new_snd_una while msk->recovery flag is set.
> 
>  net/mptcp/options.c  |  8 +++-----
>  net/mptcp/protocol.c | 45 ++++++++++++++++++++++++++++++++------------
>  2 files changed, 36 insertions(+), 17 deletions(-)
> 
> diff --git a/net/mptcp/options.c b/net/mptcp/options.c
> index f5fa8e7efd9c..12fcf7553d08 100644
> --- a/net/mptcp/options.c
> +++ b/net/mptcp/options.c
> @@ -1019,11 +1019,9 @@ static void ack_update_msk(struct mptcp_sock *msk,
>  	old_snd_una = msk->snd_una;
>  	new_snd_una = mptcp_expand_seq(old_snd_una, mp_opt->data_ack, mp_opt->ack64);
>  
> -	/* ACK for data not even sent yet and even above recovery bound? Ignore.*/
> -	if (unlikely(after64(new_snd_una, snd_nxt))) {
> -		if (!msk->recovery || after64(new_snd_una, msk->recovery_snd_nxt))
> -			new_snd_una = old_snd_una;
> -	}
> +	/* ACK for data not even sent yet? Ignore.*/
> +	if (unlikely(after64(new_snd_una, snd_nxt)))
> +		new_snd_una = old_snd_una;
>  
>  	new_wnd_end = new_snd_una + tcp_sk(ssk)->snd_wnd;
>  
> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index af8f677162f3..385405cf4626 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -1507,6 +1507,34 @@ static void mptcp_push_release(struct sock *sk, struct sock *ssk,
>  	release_sock(ssk);
>  }
>  
> +static void mptcp_update_post_push(struct mptcp_sock *msk,
> +				   struct mptcp_data_frag *dfrag,
> +				   u32 sent)
> +{
> +	u64 snd_nxt_new = dfrag->data_seq;
> +
> +	dfrag->already_sent += sent;
> +
> +	msk->snd_burst -= sent;
> +	msk->tx_pending_data -= sent;
> +
> +	snd_nxt_new += dfrag->already_sent;
> +
> +	/* snd_nxt_new can be smaller than snd_nxt in case mptcp
> +	 * is recovering after a failover. In that event, this re-sends
> +	 * old segments.
> +	 *
> +	 * Thus compute snd_nxt_new candidate based on
> +	 * the dfrag->data_seq that was sent and the data
> +	 * that has been handed to the subflow for transmission
> +	 * and skip update in case it was old dfrag.
> +	 */
> +	if (likely(after64(snd_nxt_new, msk->snd_nxt)))
> +		msk->snd_nxt = snd_nxt_new;
> +
> +	WARN_ON_ONCE(after64(msk->snd_nxt, msk->write_seq));

I think we could drop this WARN_ON(), as 'snd_nxt_new' never exceeds
the maximum sequence number in the MPTCP tx queue, which in turn never
exceeds write_seq. In any case no bjg objections on my side.

> +}
> +
>  void __mptcp_push_pending(struct sock *sk, unsigned int flags)
>  {
>  	struct sock *prev_ssk = NULL, *ssk = NULL;
> @@ -1550,12 +1578,10 @@ void __mptcp_push_pending(struct sock *sk, unsigned int flags)
>  			}
>  
>  			info.sent += ret;
> -			dfrag->already_sent += ret;
> -			msk->snd_nxt += ret;
> -			msk->snd_burst -= ret;
> -			msk->tx_pending_data -= ret;
>  			copied += ret;
>  			len -= ret;
> +
> +			mptcp_update_post_push(msk, dfrag, ret);
>  		}
>  		WRITE_ONCE(msk->first_pending, mptcp_send_next(sk));
>  	}
> @@ -1608,13 +1634,11 @@ static void __mptcp_subflow_push_pending(struct sock *sk, struct sock *ssk)
>  				goto out;
>  
>  			info.sent += ret;
> -			dfrag->already_sent += ret;
> -			msk->snd_nxt += ret;
> -			msk->snd_burst -= ret;
> -			msk->tx_pending_data -= ret;
>  			copied += ret;
>  			len -= ret;
>  			first = false;
> +
> +			mptcp_update_post_push(msk, dfrag, ret);
>  		}
>  		WRITE_ONCE(msk->first_pending, mptcp_send_next(sk));
>  	}
> @@ -2212,15 +2236,12 @@ bool __mptcp_retransmit_pending_data(struct sock *sk)
>  		return false;
>  	}
>  
> -	/* will accept ack for reijected data before re-sending them */
> -	if (!msk->recovery || after64(msk->snd_nxt, msk->recovery_snd_nxt))
> -		msk->recovery_snd_nxt = msk->snd_nxt;
> +	msk->recovery_snd_nxt = msk->snd_nxt;
>  	msk->recovery = true;
>  	mptcp_data_unlock(sk);
>  
>  	msk->first_pending = rtx_head;
>  	msk->tx_pending_data += msk->snd_nxt - rtx_head->data_seq;
> -	msk->snd_nxt = rtx_head->data_seq;
>  	msk->snd_burst = 0;
>  
>  	/* be sure to clear the "sent status" on all re-injected fragments */

otherwise LGTM! Thanks Florian!

Paolo

