Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 463CA1C15
	for <mptcp@lists.linux.dev>; Thu,  6 Apr 2023 09:19:23 +0000 (UTC)
Received: by mail-wr1-f48.google.com with SMTP id v1so38815843wrv.1
        for <mptcp@lists.linux.dev>; Thu, 06 Apr 2023 02:19:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1680772762;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SrYqZuYCzlpusErmHyqoSmmBo9f1ANMwiPmOjfCC894=;
        b=epqz1Mkq4e6b+Tl/OoTcv6fRpKnPZj0DxTAQvZj4DlO1BJRcCkgRUyTSpO2u9UCltJ
         NVmcvqNUFj7XtoFOwhLac9Ek8kHoDOvOIJiVGlaiRZBRrxUWaJ8MeS3Z0E7q+NnLV91p
         Dg9NEbMq3zGCqqJwCNYm3s4HX/Q4pTetCiZJxvuupA+q0vO2sl9gy0pBgY2cSSfwYkEH
         83Oi/Wl66HckrPSADvmUXmMRSAqEm7p3F2h/L2DzkOhJ9Gd1cNIVROr/LVEVc1e1xUnr
         gh95L26QxHAaRT+E+Y2qxgWB7J/+BCc+Ht0V3m7C2g3vCgpRxPHlIgOjnb++nEzytN2Y
         iwHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680772762;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SrYqZuYCzlpusErmHyqoSmmBo9f1ANMwiPmOjfCC894=;
        b=M68z6cKeLf1E6zU6q/XgI36Y6X0FIh5W7D+LeouctKBMfNOubrRbdvU9SMWoObF1U1
         AxLHsfSph0EDJ5zaYNcW34xra+0CQV4W6xvcXI9nE8AJI8s3esZGchLUNxHyvk1nfxd3
         GhEiEwzmqkeS4L5CvIwtmBJnIGvECV2CxSH8r1GI5dPRUR7MOVUl9cmq6/xDsFNMpMcZ
         xzFd/7O+oyYjRtFtF/OvKsUCWN12fyLEqxhAu3LXgh8wYobkCxBpEofJEaO8gGFUQ5Ds
         YC5e0ks+EeLY2Ww1vpe9BNssR4VvtSB2vlwIB6lpOWro2objl8hKGY355/lHO55ODOMQ
         /hUQ==
X-Gm-Message-State: AAQBX9c+4eJGJRfHjrq8rdfrTf80wbj8jZlx1D5cTrHz29NXDIvXNPRT
	//W1qN4GHZaCfjko5XZyuQUu7A==
X-Google-Smtp-Source: AKy350YNyVG6MQaYfw1h1T6xZJzO9HUZoFrUx2DoNYgMlHFV3c2vAz0iaGnD2An6ujCpbHNxWLpifw==
X-Received: by 2002:adf:e88e:0:b0:2ee:da37:6cbd with SMTP id d14-20020adfe88e000000b002eeda376cbdmr970037wrm.31.1680772761941;
        Thu, 06 Apr 2023 02:19:21 -0700 (PDT)
Received: from ?IPV6:2a02:578:8593:1200:f3b0:f2cb:5057:6981? ([2a02:578:8593:1200:f3b0:f2cb:5057:6981])
        by smtp.gmail.com with ESMTPSA id c18-20020a056000105200b002db1b66ea8fsm1208741wrx.57.2023.04.06.02.19.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Apr 2023 02:19:21 -0700 (PDT)
Message-ID: <48cbe7f3-8569-beec-b207-a111e6ff4922@tessares.net>
Date: Thu, 6 Apr 2023 11:19:20 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH mptcp-net 1/2] Squash-to: "mptcp: fix accept vs worker
 race"
Content-Language: en-GB
To: Paolo Abeni <pabeni@redhat.com>, mptcp@lists.linux.dev
Cc: Christoph Paasch <cpaasch@apple.com>
References: <cover.1680733942.git.pabeni@redhat.com>
 <a515310923cd2ac4610ce62aa48b21d6d36a19eb.1680733942.git.pabeni@redhat.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <a515310923cd2ac4610ce62aa48b21d6d36a19eb.1680733942.git.pabeni@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Paolo,

Thank you for the patch!

It looks good to me but I just have some questions if you don't mind,
just to be sure I understood the modifications.

On 06/04/2023 00:47, Paolo Abeni wrote:
> 2 separate fixes needed for the mentioned patch
> 
> On some exceptional scenarios (e.g. listener socket disconnecting while
> the subflow is created) a newly created MPC is deleted by the TCP stack
> via inet_child_forget(). When that happen we leak the subflow context
> and the msk.
> 
> Address the issue explicitly detecting such scenario and forcing a full
> msk shutdown.
> 
> mptcp_subflow_drop_ctx() does not remove the subflow from the msk list,
> racing msk lookup done by the NL PM could fetch the msk just before
> deletion, and try to free again the subflow.
> 
> Just explicitly remove the subflow from said list.
> 
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> ---
>  net/mptcp/protocol.c | 13 +++++++++++--
>  net/mptcp/subflow.c  |  1 +
>  2 files changed, 12 insertions(+), 2 deletions(-)
> 
> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index 0e4961e87b48..76c1814c0b19 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -2378,9 +2378,18 @@ static void __mptcp_close_ssk(struct sock *sk, struct sock *ssk,
>  	 * to deliver the msk to user-space.
>  	 * Do nothing at the moment and take action at accept and/or listener
>  	 * shutdown.
> +	 * If instead such subflow has been destroyed, e.g. by inet_child_forget
> +	 * do the kill
>  	 */
> -	if (msk->in_accept_queue && msk->first == ssk)
> -		return;
> +	if (msk->in_accept_queue && msk->first == ssk) {
> +		if (!sock_flag(ssk, SOCK_DEAD))
> +			return;
> +
> +		/* ensure later check in mptcp_worker will dispose the msk */
> +		sock_set_flag(sk, SOCK_DEAD);

Is it OK to mark the msk as dead and continue below? I guess yes because
there will not be any data to re-inject anyway?

> +		inet_csk(sk)->icsk_mtup.probe_timestamp = tcp_jiffies32 -
> +							  TCP_TIMEWAIT_LEN -1;

Changing the timestamp looks like an ugly hack :)

But I guess it is needed not to wait for nothing and there is no clearer
way? Or move this logic to the worker?

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
