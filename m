Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 879C870
	for <mptcp@lists.linux.dev>; Thu, 12 Aug 2021 09:37:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1628761055;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=snQLCbtqgvOjfQV/+bqu8/WdUcG9G1lVf20vyU6t35Y=;
	b=TWhsejBO76Rdk4KMCd8qe+D75qxbDNgLxa4HX8eJlw1drZE+vTJFEpEQB0TWnYDbLlmhuS
	+vgzFfeEbRmCti17PwZZOxnJckLwpkUHRReqTcFOJR7axtgYSOjba3a5bOlPX7dru48hXi
	s4LV7yOo32hQwUBpHmGYfODXxJGsXUs=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-466-I4HS2Q6zMMeQmpprfavO_A-1; Thu, 12 Aug 2021 05:37:34 -0400
X-MC-Unique: I4HS2Q6zMMeQmpprfavO_A-1
Received: by mail-wr1-f69.google.com with SMTP id o4-20020a5d47c40000b0290154ad228388so1621268wrc.9
        for <mptcp@lists.linux.dev>; Thu, 12 Aug 2021 02:37:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=snQLCbtqgvOjfQV/+bqu8/WdUcG9G1lVf20vyU6t35Y=;
        b=XYI8ZbGhdw234kqTYv4gDE22hCzluCin+Xszq4BKmZriX1Iq07iGmQbMDuQO5Tz6Zj
         glGVSIPab/RWykCKoPBNWMXhchwJ6XHLfvMIUC5n48f/mKmIK6mHzPiLsuup9Hzpufx4
         ywG15FLRJMjYAyOZoOpIgAO1dfQ96nftKzjqzRy1Fs74mXEmFmvxJukMtTr6lgPQTPHO
         LpU12ODKzd5t9z7CqiL6go6yJc5a1p1dWupwNX62ng6kXGbptFj9vUgXOirsLicL4OL5
         XSWDr7rvbECy27OsqvM3WNRxAcVXh6gkTU0cwiDVPZ3scjVJHsLCEovOd8OSSyZrPLpn
         Ozzg==
X-Gm-Message-State: AOAM5338jh/vpJgxBzNvuKvbzTZYEl7mLjYqr5ialHgJeg7KfAVXR1/h
	wnZR+kyWUaqeH+P/NhBbnupc9WnPz37GiGuTKK9DSUHhqSrNEVZvidmZP5dlzMnunz8prlZyWTx
	QsMesLXBIRyfxJAg=
X-Received: by 2002:a1c:5457:: with SMTP id p23mr3035142wmi.50.1628761052941;
        Thu, 12 Aug 2021 02:37:32 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwZ6Ajr3Dl+/kzWP1GH2lJyFDEzrgGngGbhzO9onbamAHHmY47XgixdqqaZpPkxhfN12RB7aA==
X-Received: by 2002:a1c:5457:: with SMTP id p23mr3035127wmi.50.1628761052758;
        Thu, 12 Aug 2021 02:37:32 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-224-77.dyn.eolo.it. [146.241.224.77])
        by smtp.gmail.com with ESMTPSA id 7sm639308wmk.39.2021.08.12.02.37.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Aug 2021 02:37:32 -0700 (PDT)
Message-ID: <85da0534130a3c604d2207bb9d74accedde7156c.camel@redhat.com>
Subject: Re: [MPTCP][PATCH mptcp-next] mptcp: use unlikely for non-DSS
 suboptions
From: Paolo Abeni <pabeni@redhat.com>
To: Geliang Tang <geliangtang@gmail.com>, mptcp@lists.linux.dev
Cc: Geliang Tang <geliangtang@xiaomi.com>
Date: Thu, 12 Aug 2021 11:37:31 +0200
In-Reply-To: <e59a65d4bc669101b598c79e57ff425e4cf88d6e.1628752099.git.geliangtang@xiaomi.com>
References: <e59a65d4bc669101b598c79e57ff425e4cf88d6e.1628752099.git.geliangtang@xiaomi.com>
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

Hello,

On Thu, 2021-08-12 at 15:09 +0800, Geliang Tang wrote:
> From: Geliang Tang <geliangtang@xiaomi.com>
> 
> Usually we get a single MPTCP subopt per packet: a DSS. So we could
> optimize the other suboptions code path with something alike:
> 
>         if (unlikely(any subopt other than dss is present))
>                 // go checking all of them individually
> 
> Suggested-by: Paolo Abeni <pabeni@redhat.com>
> Signed-off-by: Geliang Tang <geliangtang@xiaomi.com>
> ---
>  net/mptcp/options.c | 75 +++++++++++++++++++++++----------------------
>  1 file changed, 39 insertions(+), 36 deletions(-)
> 
> diff --git a/net/mptcp/options.c b/net/mptcp/options.c
> index eaee69df6635..7e8019ad8542 100644
> --- a/net/mptcp/options.c
> +++ b/net/mptcp/options.c
> @@ -1123,49 +1123,52 @@ bool mptcp_incoming_options(struct sock *sk, struct sk_buff *skb)
>  	if (!check_fully_established(msk, sk, subflow, skb, &mp_opt))
>  		return sk->sk_state != TCP_CLOSE;
>  
> -	if (mp_opt.fastclose &&
> -	    msk->local_key == mp_opt.rcvr_key) {
> -		WRITE_ONCE(msk->rcv_fastclose, true);
> -		mptcp_schedule_work((struct sock *)msk);
> -	}
> -
> -	if (mp_opt.add_addr && add_addr_hmac_valid(msk, &mp_opt)) {
> -		if (!mp_opt.echo) {
> -			mptcp_pm_add_addr_received(msk, &mp_opt.addr);
> -			MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_ADDADDR);
> -		} else {
> -			mptcp_pm_add_addr_echoed(msk, &mp_opt.addr);
> -			mptcp_pm_del_add_timer(msk, &mp_opt.addr, true);
> -			MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_ECHOADD);
> +	if (unlikely(mp_opt.fastclose || mp_opt.add_addr || mp_opt.rm_addr ||
> +		     mp_opt.mp_prio || mp_opt.mp_fail || mp_opt.reset)) {
> +		if (mp_opt.fastclose &&
> +		    msk->local_key == mp_opt.rcvr_key) {
> +			WRITE_ONCE(msk->rcv_fastclose, true);
> +			mptcp_schedule_work((struct sock *)msk);
>  		}
>  
> -		if (mp_opt.addr.port)
> -			MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_PORTADD);
> +		if (mp_opt.add_addr && add_addr_hmac_valid(msk, &mp_opt)) {
> +			if (!mp_opt.echo) {
> +				mptcp_pm_add_addr_received(msk, &mp_opt.addr);
> +				MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_ADDADDR);
> +			} else {
> +				mptcp_pm_add_addr_echoed(msk, &mp_opt.addr);
> +				mptcp_pm_del_add_timer(msk, &mp_opt.addr, true);
> +				MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_ECHOADD);
> +			}
>  
> -		mp_opt.add_addr = 0;
> -	}
> +			if (mp_opt.addr.port)
> +				MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_PORTADD);
>  
> -	if (mp_opt.rm_addr) {
> -		mptcp_pm_rm_addr_received(msk, &mp_opt.rm_list);
> -		mp_opt.rm_addr = 0;
> -	}
> +			mp_opt.add_addr = 0;
> +		}
>  
> -	if (mp_opt.mp_prio) {
> -		mptcp_pm_mp_prio_received(sk, mp_opt.backup);
> -		MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_MPPRIORX);
> -		mp_opt.mp_prio = 0;
> -	}
> +		if (mp_opt.rm_addr) {
> +			mptcp_pm_rm_addr_received(msk, &mp_opt.rm_list);
> +			mp_opt.rm_addr = 0;
> +		}
>  
> -	if (mp_opt.mp_fail) {
> -		mptcp_pm_mp_fail_received(sk, mp_opt.fail_seq);
> -		MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_MPFAILRX);
> -		mp_opt.mp_fail = 0;
> -	}
> +		if (mp_opt.mp_prio) {
> +			mptcp_pm_mp_prio_received(sk, mp_opt.backup);
> +			MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_MPPRIORX);
> +			mp_opt.mp_prio = 0;
> +		}
>  
> -	if (mp_opt.reset) {
> -		subflow->reset_seen = 1;
> -		subflow->reset_reason = mp_opt.reset_reason;
> -		subflow->reset_transient = mp_opt.reset_transient;
> +		if (mp_opt.mp_fail) {
> +			mptcp_pm_mp_fail_received(sk, mp_opt.fail_seq);
> +			MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_MPFAILRX);
> +			mp_opt.mp_fail = 0;
> +		}
> +
> +		if (mp_opt.reset) {
> +			subflow->reset_seen = 1;
> +			subflow->reset_reason = mp_opt.reset_reason;
> +			subflow->reset_transient = mp_opt.reset_transient;
> +		}
>  	}
>  
>  	if (!mp_opt.dss)

I think with a slighly larger change, we can trim completely a lot of
conditionals, specifically:
- replace all the 'opt.reset', 'opt.mp_fail', 'opt.dss' etc. fields
with a bitmask 'suboptions'

- in mptcp_incoming_options() 
	if (unlikely(opt.suboptions != BIT(OPT_DSS_WHATEVER_WILL_BE_CALLED))) {
		// check the individual bits

		if (!(opt.suboptions & BIT(OPT_DSS_WHATEVER_WILL_BE_CALLED)))
			return;
	}

	// here DSS will be always set.

With the above, for the most common scenario, we will have a single
'if' statement in the fastpath (and that will use branch prediction
hint, too)

I've the patch half-cooked, if I find some time to finish them...

Cheers,

Paolo

