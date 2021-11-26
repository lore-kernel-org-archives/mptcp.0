Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFBB172
	for <mptcp@lists.linux.dev>; Fri, 26 Nov 2021 17:53:38 +0000 (UTC)
Received: by mail-ed1-f50.google.com with SMTP id o20so41646187eds.10
        for <mptcp@lists.linux.dev>; Fri, 26 Nov 2021 09:53:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:cc:from:in-reply-to:content-transfer-encoding;
        bh=MwA2piBqwghlUbLwBnPY6J2xp+4EPVta1UEGMlJI1/o=;
        b=qa4/C/Kc5eRgNOKZrez34nwvXUEnqK4HFHO+8iEKx6joztYHlBcC+t2UzMMblDlJXZ
         aUMnneTGVChi8D4feUAGUQcEbnpRLeH317+3XFpnE4YN0XTv6kQfcZZY2n2oSm2+Afay
         mvdSgOBdRzDNCdjPhxVaAI/RSvuXalkf9U3lK23pHdBB2lFHCOjBhXLiyaN755BGJNsg
         WHYAeCcqPr4Ck65l2Z0hl9XeADXBPPK/kSo4jg+qk2bhgA0bRUGYqEm3chQfbC8hmF5X
         lw0y8WlPcxEw06i5GY2Y4bv9oDUn7sGn0158Rr3WIwB1i00pGiow93VbwKbjW5e1Uos/
         Bt/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:cc:from:in-reply-to
         :content-transfer-encoding;
        bh=MwA2piBqwghlUbLwBnPY6J2xp+4EPVta1UEGMlJI1/o=;
        b=PliuimwKIgp9veGjq+ySVUG6SVBgVlKKnWZZQJr1cPQVflMZYtD57m7T+NGSBLoniI
         Hq9wZy4Van/FGry4L81J2slFnztMoJymLxx+Y+26dry+/Uz/fny+c2X4yx47OvgQfQcd
         E0V6UxCJCfZtDC3/ayGW2xZ6niGlo6RsWDwUvxg9eMgCKKnO/IRKSiDo4xnVHv68FSr9
         qEhzBV0F0szHlK03kCJvQ5ZorHsk2t79p3Ot+4VaR0+7xK1sp4+yW+NHoj3ybq++LGM9
         A1svdL02pSPq3vIY9E8CdEG+0w5xgufxFuDYoohRfjBsUooiPRw0bEC8Vu7rgPjNpdCN
         lNQQ==
X-Gm-Message-State: AOAM531PBVVcO+BCnvNWo8gM/nvaZVzyTDVA2ovc90gtfOU6+Pl218SD
	Q8z3dNFhK0hIrslk427KCy0fEM8bbbpquhLoolQ=
X-Google-Smtp-Source: ABdhPJyOybpdqqXiGQem4vWHzUuZROkXKZ0fDawHydCBN+zbwjjsCV449S9HYO8UnUBtKnO8Arvbnw==
X-Received: by 2002:a17:907:6d28:: with SMTP id sa40mr39314872ejc.201.1637949217105;
        Fri, 26 Nov 2021 09:53:37 -0800 (PST)
Received: from [192.168.178.33] (213.211.136.227.static.edpnet.net. [213.211.136.227])
        by smtp.gmail.com with ESMTPSA id e8sm1954928edz.73.2021.11.26.09.53.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Nov 2021 09:53:36 -0800 (PST)
Message-ID: <cd1448c5-1fa6-7721-7685-c8d580684ebb@tessares.net>
Date: Fri, 26 Nov 2021 18:53:36 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH v2 mptcp-next 3/4] mptcp: do not block subflows creation
 on errors
Content-Language: en-GB
To: Paolo Abeni <pabeni@redhat.com>
References: <cover.1637929034.git.pabeni@redhat.com>
 <7eaa67c01eb780dacbbac368004d2306a7981e09.1637929034.git.pabeni@redhat.com>
Cc: mptcp@lists.linux.dev
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <7eaa67c01eb780dacbbac368004d2306a7981e09.1637929034.git.pabeni@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Paolo,

On 26/11/2021 13:19, Paolo Abeni wrote:
> If the MPTCP configuration allows for multiple subflows
> creation, and the first additional subflows never reach
> the fully established status - e.g. due to packets drop or
> reset - the in kernel path manager do not move to the
> next subflow.
> 
> This patch introduces a new PM helper to cope with MPJ
> subflow creation failure and delay and hook it where appropriate.
> 
> Such helper triggers additional subflow creation, as needed
> and updates the PM subflow counter, if the current one is
> closing.
> 
> Note that we don't need an additional timer to catch timeout
> and/or long delay in connection completion: we just need to
> measure the time elapsed since the subflow creation every
> time we emit an MPJ sub-option.
> 
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> ---
> v2 -> v3:
>  - fix compile warning (CI)
> 
> v1 -> v2:
>  - explicitly hook on subflow close instead of error notification
>  - fix checkpatch issue (Mat)

(+t :-P )

>  - introduce and use a new pm helper to cope with subflow close
>  - update pm subflow counters on close

Thank you for the new version!

> diff --git a/net/mptcp/options.c b/net/mptcp/options.c
> index 7a6a39b71633..00a8697addcd 100644
> --- a/net/mptcp/options.c
> +++ b/net/mptcp/options.c
> @@ -1382,6 +1382,21 @@ void mptcp_write_options(__be32 *ptr, const struct tcp_sock *tp,
>  		/* MPC is additionally mutually exclusive with MP_PRIO */
>  		goto mp_capable_done;
>  	} else if (OPTIONS_MPTCP_MPJ & opts->suboptions) {
> +		if (ssk) {
> +			/* we are still in the MPJ handshake and "a lot" of time passed
> +			 * e.g. due to syn retranmissions. We can attempt next
> +			 * subflow creation
> +			 */
> +			subflow = mptcp_subflow_ctx(ssk);
> +			if (subflow->start_stamp &&
> +			    unlikely(after(tcp_jiffies32, subflow->start_stamp + HZ / 10))) {

As discussed at the last meeting, we will reach this code path when
retransmitting the SYN, one second after having sent the initial one. In
this case, we might not need to keep 'start_stamp'.

But we can improve that in a new version after.

> +				mptcp_pm_subflow_check_next(mptcp_sk(subflow->conn), ssk, subflow);
> +
> +				/* avoid triggering the PM multiple times due to timeout */
> +				subflow->start_stamp = 0;
> +			}
> +		}
> +
>  		if (OPTION_MPTCP_MPJ_SYN & opts->suboptions) {
>  			*ptr++ = mptcp_option(MPTCPOPT_MP_JOIN,
>  					      TCPOLEN_MPTCP_MPJ_SYN,
> diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
> index 1ff856dd92c4..df8a596cd3ff 100644
> --- a/net/mptcp/pm.c
> +++ b/net/mptcp/pm.c
> @@ -172,9 +172,32 @@ void mptcp_pm_subflow_established(struct mptcp_sock *msk)
>  	spin_unlock_bh(&pm->lock);
>  }
>  
> -void mptcp_pm_subflow_closed(struct mptcp_sock *msk, u8 id)
> +void mptcp_pm_subflow_check_next(struct mptcp_sock *msk, const struct sock *ssk,
> +				 const struct mptcp_subflow_context *subflow)

Detail: do we need to pass the 'msk'? Can we not get it from 'subflow'?

>  {
> -	pr_debug("msk=%p", msk);
> +	struct mptcp_pm_data *pm = &msk->pm;
> +	bool closed;
> +
> +	closed = ssk->sk_state == TCP_CLOSE;
> +	if (subflow->fully_established && !closed)
> +		return;
> +
> +	spin_lock_bh(&pm->lock);
> +	if (closed) {
> +		pm->local_addr_used--;
> +		pm->subflows--;
> +		/* do not enable the pm worker: we don't want to pick again
> +		 * the just closed subflow
> +		 */
> +	}
> +
> +	/* Even if this subflow is not really established, tell the PM to try
> +	 * to pick the next one, if possible.
> +	 */
> +	if (pm->work_pending)

Does it not need to be "protected" with a READ_ONCE?

> +		mptcp_pm_schedule_work(msk, MPTCP_PM_SUBFLOW_ESTABLISHED);
> +
> +	spin_unlock_bh(&pm->lock);
>  }
>  
>  void mptcp_pm_add_addr_received(struct mptcp_sock *msk,

(not related to this line)

Did you see that the "fastclose" packetdrill tests are failing? Is it
due to these modifications?

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
