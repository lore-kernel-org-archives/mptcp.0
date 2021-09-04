Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72B7B3FC0
	for <mptcp@lists.linux.dev>; Sat,  4 Sep 2021 08:00:46 +0000 (UTC)
Received: by mail-ed1-f45.google.com with SMTP id q3so2090000edt.5
        for <mptcp@lists.linux.dev>; Sat, 04 Sep 2021 01:00:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20150623.gappssmtp.com; s=20150623;
        h=to:references:cc:from:subject:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=iONsfeXuSrE50Go75nEow1hMyhWBmIFq/vR4H4bJ9qI=;
        b=dpA8DkseyWcZqcpE7W7cYVsmBMxlVurAkc7bnnGZyzqIlh9LDASNYXBvdu33lypaMy
         hJiIq2O/W/l0zCm63eBrpoI0vY5eLb2md7+PagRNeK/7+Pp7We63LXsmLcsk+zJV6JSM
         T14Qmg0QwYcM6PcV5VctP0UXdnHJyH3demSf279AgjfUE85MrQalhlV+tbOE8BzU/nC6
         aFdOdWdtGYPlXAOJVphqQQS3YvtRh0hvATYOZ/AeiPW4Cc5M1ajt1bQj7gBBaKEtOzYj
         gZImrG8sEZLfiP8TDiIkbsrqoepeTw9lUsGBar1mPiVtcpQdxM+/C2ohvQZ672NdzLf+
         6Ceg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:references:cc:from:subject:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=iONsfeXuSrE50Go75nEow1hMyhWBmIFq/vR4H4bJ9qI=;
        b=Vw2yl100euqD2Qg8gVK4ZBJvcrAQf8J7gD4bdmWct2aVLyN8l5ihT3wp+SYJa4IoTy
         9VO0WOdxXybG2FG5Ch2Xk37KeBRzyFFzFhAxWO5UooBjh7KbJTEeomIBrtCAAmMfRd9+
         eZFc9HxjFX/qvxL1ITOALAiOx/hIJrfuphfoVefWo762i+9mOwGhd/mfTUaxkY0ihYtz
         /vYMM0RhCt+8kj7pzlwKVljwsIL2lMU2oFy+FucgYtc2DUi7trtdaC3fQwfv5RxIYBpg
         v3oGdRSlYphnUSm0P/kUCxx8gUR93FX+r4s2QoMLmFzKaoJLmMShoTjGyoZ6TSfmx7wU
         Gt0A==
X-Gm-Message-State: AOAM530BhTv1cbo6qLrr01MpO4ZyD59wTXE5UFjhmgnc1kpEtRbtp9pq
	OGJijqkPfkDb8axJRIag6Jp5LP2/FZJkTE8M
X-Google-Smtp-Source: ABdhPJwAKtPYOSNg+iZgQaClKCnAkLt0T5GaijuuzwYTUWI4HVWn4phgnYseXjuzfzMIQm0Fpnc/GA==
X-Received: by 2002:aa7:c6c8:: with SMTP id b8mr3046992eds.295.1630742444683;
        Sat, 04 Sep 2021 01:00:44 -0700 (PDT)
Received: from tsr-lap-08.nix.tessares.net (94.105.103.227.dyn.edpnet.net. [94.105.103.227])
        by smtp.gmail.com with ESMTPSA id k12sm885047edq.59.2021.09.04.01.00.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 04 Sep 2021 01:00:44 -0700 (PDT)
To: Paolo Abeni <pabeni@redhat.com>
References: <cover.1630595171.git.pabeni@redhat.com>
 <ae127a2e3d2fb31e6f1687cb96128d39490f6be0.1630595171.git.pabeni@redhat.com>
Cc: mptcp@lists.linux.dev
From: Matthieu Baerts <matthieu.baerts@tessares.net>
Subject: Re: [PATCH v2 mptcp-next 2/4] mptcp: stop relaying on
 tcp_tx_skb_cache.
Message-ID: <9f09512c-0d95-2869-57bb-ffb538ead9b9@tessares.net>
Date: Sat, 4 Sep 2021 10:00:43 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <ae127a2e3d2fb31e6f1687cb96128d39490f6be0.1630595171.git.pabeni@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 8bit

Hi Paolo,

On 02/09/2021 17:52, Paolo Abeni wrote:
> We want to revert the skb TX cache, but MPTCP is currently
> using it unconditionally.
> 
> Rework the MPTCP tx code, so that tcp_tx_skb_cache is not
> needed anymore: do the whole coalescing check, skb allocation
> skb initialization/update inside mptcp_sendmsg_frag(), quite
> alike the current TCP code.

(...)

> @@ -1287,23 +1280,29 @@ static int mptcp_sendmsg_frag(struct sock *sk, struct sock *ssk,
>  			      struct mptcp_sendmsg_info *info)
>  {
>  	u64 data_seq = dfrag->data_seq + info->sent;
> +	int offset = dfrag->offset + info->sent;
>  	struct mptcp_sock *msk = mptcp_sk(sk);
>  	bool zero_window_probe = false;
>  	struct mptcp_ext *mpext = NULL;
> -	struct sk_buff *skb, *tail;
> -	bool must_collapse = false;
> -	int size_bias = 0;
> -	int avail_size;
> -	size_t ret = 0;
> +	bool can_coalesce = false;
> +	bool reuse_skb = true;
> +	struct sk_buff *skb;
> +	size_t copy;
> +	int i;
>  
>  	pr_debug("msk=%p ssk=%p sending dfrag at seq=%llu len=%u already sent=%u",
>  		 msk, ssk, dfrag->data_seq, dfrag->data_len, info->sent);
>  
> +	if (WARN_ON_ONCE(info->sent > info->limit ||
> +			 info->limit > dfrag->data_len))
> +		return 0;
> +
>  	/* compute send limit */
>  	info->mss_now = tcp_send_mss(ssk, &info->size_goal, info->flags);
> -	avail_size = info->size_goal;
> +	copy = info->size_goal;
> +
>  	skb = tcp_write_queue_tail(ssk);
> -	if (skb) {
> +	if (skb && (copy > skb->len)) {
>  		/* Limit the write to the size available in the
>  		 * current skb, if any, so that we create at most a new skb.
>  		 * Explicitly tells TCP internals to avoid collapsing on later
> @@ -1316,53 +1315,76 @@ static int mptcp_sendmsg_frag(struct sock *sk, struct sock *ssk,
>  			goto alloc_skb;
>  		}
>  
> -		must_collapse = (info->size_goal - skb->len > 0) &&
> -				(skb_shinfo(skb)->nr_frags < sysctl_max_skb_frags);
> -		if (must_collapse) {
> -			size_bias = skb->len;
> -			avail_size = info->size_goal - skb->len;
> +		i = skb_shinfo(skb)->nr_frags;
> +		can_coalesce = skb_can_coalesce(skb, i, dfrag->page, offset);
> +		if (!can_coalesce && i >= sysctl_max_skb_frags) {
> +			tcp_mark_push(tcp_sk(ssk), skb);
> +			goto alloc_skb;
>  		}
> -	}
>  
> +		copy -= skb->len;
> +	} else {
>  alloc_skb:
> -	if (!must_collapse && !ssk->sk_tx_skb_cache &&
> -	    !mptcp_alloc_tx_skb(sk, ssk, info->data_lock_held))
> -		return 0;
> +		skb = mptcp_alloc_tx_skb(sk, ssk, info->data_lock_held);
> +		if (!skb)
> +			return -ENOMEM;
> +
> +		i = skb_shinfo(skb)->nr_frags;
> +		reuse_skb = false;
> +		mpext = skb_ext_find(skb, SKB_EXT_MPTCP);
> +	}
>  
>  	/* Zero window and all data acked? Probe. */
> -	avail_size = mptcp_check_allowed_size(msk, data_seq, avail_size);
> -	if (avail_size == 0) {
> +	copy = mptcp_check_allowed_size(msk, data_seq, copy);
> +	if (copy == 0) {
>  		u64 snd_una = READ_ONCE(msk->snd_una);
>  
> -		if (skb || snd_una != msk->snd_nxt)
> +		if (skb || snd_una != msk->snd_nxt) {

If I'm not mistaken, 'skb' will always be != NULL here.

Should we only have these 2 next lines if 'copy == 0'?

> +			tcp_remove_empty_skb(ssk, tcp_write_queue_tail(ssk));
>  			return 0;
> +		}
> +
>  		zero_window_probe = true;
>  		data_seq = snd_una - 1;
> -		avail_size = 1;
> -	}
Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
