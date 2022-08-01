Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 154187F
	for <mptcp@lists.linux.dev>; Mon,  1 Aug 2022 12:41:35 +0000 (UTC)
Received: by mail-wr1-f53.google.com with SMTP id z16so13908224wrh.12
        for <mptcp@lists.linux.dev>; Mon, 01 Aug 2022 05:41:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=fLvjBLbhS84e5/hRa29XSLwyltd2loiNFYMXPD08/js=;
        b=AOKg1WSOEvKVgyzkduFblbaj4deHQdcgPCDMeYKyFajeCz2rjtMMMMYw9VLNAEhN94
         MIm4ur/nqEgl1XXwd/eKH7eRqXqxp0DQx4mn7r5qZIyJ3dO5O3FDE7NpceTQhhUp/nJ7
         a7GYPgu/cGrtan9fagkj9ftQkSbUnsT7jdVZlvxPy2+bWaHV3AFmhGY7OOnCwWILS2xD
         3WFPKLNXODGrSQxyMxwwRPrc4CQkf2GOr9OuQqrPhWPeevTWBvZNt+ReSQvb3wHd/2cL
         88X0SJimdEkq8FpcsHyX8MClE4wXj6X85uhWeQ+p6C4ickPJVjAzTfEvsqCPzS+LgBo6
         9s4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=fLvjBLbhS84e5/hRa29XSLwyltd2loiNFYMXPD08/js=;
        b=hx+mCPmpHCy9GjP0RxL6TKb5tAzx9aSc2TtnO4JzC48CTyxiWbUCnkUhebb0ANjdNE
         cYx9xG4miFmI8rfORwkpM9ARM+s6MJWHPWXRcx+bGdF3Ilb4+kt2jGtRCC7S+1THAcUW
         x/iWrkf2tXkHFWLKm6i5CditbrsgCnLVKJB1zMM/eVPZcGBZqt5FG2ecqN0RHAx66K9t
         aBZq1upoFQriDjlMlCg7IePvnXu0/nevX0f04JgpneO9QFhgyRcUex47xTPqgRL4IuQH
         LxUk6hjYfYZeRDPKhLCVgtK1fE29iZL2OZFiZdV4Meaauhhu42+xcRg94/phWhLQIltR
         xPeQ==
X-Gm-Message-State: ACgBeo1w6qwFYyyVRnMhqW7qDEPf+zZdpvhmz2W6wBVSu4j8qio+CeZc
	M9FLb6tSeXBMS4YOdng7cOpa+/P4OFLtLA==
X-Google-Smtp-Source: AA6agR50WYTdDMqgEGihkEAOqmFTiFpq1G7ap0r0VtfEqnZoahtvnuR+4/B2zmXzqTVvXwAwlTwYqA==
X-Received: by 2002:a5d:48c8:0:b0:21e:5134:c78c with SMTP id p8-20020a5d48c8000000b0021e5134c78cmr9961801wrs.233.1659357693930;
        Mon, 01 Aug 2022 05:41:33 -0700 (PDT)
Received: from [10.44.2.26] ([81.246.10.41])
        by smtp.gmail.com with ESMTPSA id s10-20020a5d424a000000b0021e6effef8bsm11344165wrr.50.2022.08.01.05.41.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Aug 2022 05:41:33 -0700 (PDT)
Message-ID: <9beff9f6-b06d-a879-c2df-542375a2def7@tessares.net>
Date: Mon, 1 Aug 2022 14:41:33 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.0.3
Subject: Re: Patch "mptcp: don't send RST for single subflow" has been added
 to the 5.18-stable tree
Content-Language: en-GB
To: Mat Martineau <mathew.j.martineau@linux.intel.com>
Cc: MPTCP Upstream <mptcp@lists.linux.dev>
References: <20220731024320.3360515-1-sashal@kernel.org>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <20220731024320.3360515-1-sashal@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Mat,

(cc: MPTCP ML)

On 31/07/2022 04:43, Sasha Levin wrote:
> This is a note to let you know that I've just added the patch titled
> 
>     mptcp: don't send RST for single subflow
> 
> to the 5.18-stable tree which can be found at:
>     http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary
> 
> The filename of the patch is:
>      mptcp-don-t-send-rst-for-single-subflow.patch
> and it can be found in the queue-5.18 subdirectory.
> 
> If you, or anyone else, feels it should not be added to the stable tree,
> please let <stable@vger.kernel.org> know about it.

I just noticed the patch below is being backported to v5.18 while it
doesn't have any "Fixes" tag.

It slightly changes the behaviour on v5.18 but I don't think that's an
issue, it could even be seen as a bug-fix for me.

I just double-checked and the selftests are still OK with this patch.

Also OK for you to have it in v5.18?

Cheers,
Matt

> commit 0a782d12ad419f820fbaf1d637a788097014b5b1
> Author: Geliang Tang <geliang.tang@suse.com>
> Date:   Fri Apr 22 14:55:36 2022 -0700
> 
>     mptcp: don't send RST for single subflow
>     
>     [ Upstream commit 1761fed2567807f26fbd53032ff622f55978c7a9 ]
>     
>     When a bad checksum is detected and a single subflow is in use, don't
>     send RST + MP_FAIL, send data_ack + MP_FAIL instead.
>     
>     So invoke tcp_send_active_reset() only when mptcp_has_another_subflow()
>     is true.
>     
>     Signed-off-by: Geliang Tang <geliang.tang@suse.com>
>     Signed-off-by: Mat Martineau <mathew.j.martineau@linux.intel.com>
>     Signed-off-by: David S. Miller <davem@davemloft.net>
>     Signed-off-by: Sasha Levin <sashal@kernel.org>
> 
> diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
> index 7919e259175d..ccae50eba664 100644
> --- a/net/mptcp/subflow.c
> +++ b/net/mptcp/subflow.c
> @@ -1221,14 +1221,14 @@ static bool subflow_check_data_avail(struct sock *ssk)
>  	/* RFC 8684 section 3.7. */
>  	if (subflow->send_mp_fail) {
>  		if (mptcp_has_another_subflow(ssk)) {
> +			ssk->sk_err = EBADMSG;
> +			tcp_set_state(ssk, TCP_CLOSE);
> +			subflow->reset_transient = 0;
> +			subflow->reset_reason = MPTCP_RST_EMIDDLEBOX;
> +			tcp_send_active_reset(ssk, GFP_ATOMIC);
>  			while ((skb = skb_peek(&ssk->sk_receive_queue)))
>  				sk_eat_skb(ssk, skb);
>  		}
> -		ssk->sk_err = EBADMSG;
> -		tcp_set_state(ssk, TCP_CLOSE);
> -		subflow->reset_transient = 0;
> -		subflow->reset_reason = MPTCP_RST_EMIDDLEBOX;
> -		tcp_send_active_reset(ssk, GFP_ATOMIC);
>  		WRITE_ONCE(subflow->data_avail, MPTCP_SUBFLOW_NODATA);
>  		return true;
>  	}

-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
