Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E988256D
	for <mptcp@lists.linux.dev>; Fri,  9 Jun 2023 14:52:38 +0000 (UTC)
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-9745c5fed21so281227966b.3
        for <mptcp@lists.linux.dev>; Fri, 09 Jun 2023 07:52:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1686322356; x=1688914356;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xyjafPhGDT3XokdnI9IgCQr+AR940Y+HLCGVYn4iqwo=;
        b=PkM7wHZ6zvRsoyT/tPwJ/xDiCialRKe8VkVnVS+0RaLHJghfG+y6coZUI0ve0hPnLs
         /eapykhKO+ORyoKjh173X7arzO4Hfi6MGGCVeClb7ogxIcpqpcNDOGkj7bKo3ZqVaSTX
         EwmT5nMrNbvi6lyewVGrVlmNtA8jYqxNnIrU6+IhLbgrsG3dCHKpYnO1pp67E4AOq4Nw
         W4c7cv2mjqbJs9EC0ROd9OjeLbrnxCxrcfR91t+nTjqWyXbKp8ETWfE53jRkrV7ws7AT
         2BfZcCBBpl6krorM+meN7DNytCKUq4VwxxL1sT/ZKVZAXTy7b/OFEJnNRAmv4Qepb2ii
         qd1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686322356; x=1688914356;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xyjafPhGDT3XokdnI9IgCQr+AR940Y+HLCGVYn4iqwo=;
        b=KvpW2F2ldZUz76E4xs6FHRpJAepwJyBFHv+5UI+g99pV6cPdYqDJxI/jV3SrBI2E7K
         3NhKH3bbPzY2h7iNc3D0mQXmK5RxK5tOpBzP/PpTN31Z3cjRdiUCWrsqsqGlLlDaM5ez
         5KTs/P5EQOZMGi5JWmG5XsnjajMaHzMZgjEZjg7HB3zMRQtWrT5IbaPKxprU0Jvlz4Kx
         x0JPPk7Ae1g/OCYiGcC7Dco5R7DIBZBT9w/I38nRAB5VUKH8IQ9QvE7Zt7ISX1eHiov3
         6BJeJ1dGiDtz0znVP3M363nVE0D8E6aGXsJNPwhyoGuyZR8H9H7E7XzjtMOckf9UKLrF
         YC8g==
X-Gm-Message-State: AC+VfDwyyE+MR2YQLOuyllUed/67o9w1r5nmJXvH0yLjM9w8o27hYNVu
	Qcj1Tb9PenZEVFyJt/0VFWS5yQ==
X-Google-Smtp-Source: ACHHUZ5R50v5ggPNegAHdbUM1brN+kV5x8Jibhp7AODa+vBd8mQwSw19wou/Wg50PvyM3eRFRu3xpA==
X-Received: by 2002:a17:906:eec3:b0:96a:63d4:2493 with SMTP id wu3-20020a170906eec300b0096a63d42493mr1885423ejb.40.1686322356223;
        Fri, 09 Jun 2023 07:52:36 -0700 (PDT)
Received: from [10.44.2.5] ([81.246.10.41])
        by smtp.gmail.com with ESMTPSA id e26-20020a1709062c1a00b00974556e50a6sm1383237ejh.114.2023.06.09.07.52.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Jun 2023 07:52:35 -0700 (PDT)
Message-ID: <a0a3cc11-8ea1-f9ca-ebd9-0bc3d7a3bae9@tessares.net>
Date: Fri, 9 Jun 2023 16:52:35 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH mptcp-net 2/2] mptcp: fix potential msk leak
Content-Language: en-GB
To: Paolo Abeni <pabeni@redhat.com>, mptcp@lists.linux.dev
References: <f88902bdf5168d86a858575a95882e3fbbadf556.1686155270.git.pabeni@redhat.com>
 <d9dcf7a0fd779b3d24d7c10cb21b881d62b1fdc7.1686155270.git.pabeni@redhat.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <d9dcf7a0fd779b3d24d7c10cb21b881d62b1fdc7.1686155270.git.pabeni@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Paolo,

On 07/06/2023 18:33, Paolo Abeni wrote:
> An orphaned msk releases the used resources via the worker,
> when the latter first see the msk in CLOSED status.
> 
> If the msk status transitions to TCP_CLOSE in the release callback
> invoked by the worker's final release_sock(), such instance of the
> workqueue will not take any action.
> 
> Additionally the MPTCP code prevents scheduling the worker once the
> socket reaches the CLOSE status: such msk resources will be leaked.
> 
> The only code path that can trigger the above scenario is the
> __mptcp_check_send_data_fin() in fallback mode. Address the issue
> simply removing the dangerous state change: the msk will be closed
> soon by the worker itself, triggered by MPTCP_WORK_CLOSE_SUBFLOW.
> 
> Fixes: 6e628cd3a8f7 ("mptcp: use mptcp release_cb for delayed tasks")
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> ---
>  net/mptcp/protocol.c | 10 ++++------
>  1 file changed, 4 insertions(+), 6 deletions(-)
> 
> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index 94229a318fc1..e93a678d057f 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -2936,16 +2936,14 @@ static void __mptcp_check_send_data_fin(struct sock *sk)
>  	WRITE_ONCE(msk->snd_nxt, msk->write_seq);
>  
>  	/* fallback socket will not get data_fin/ack, can move to the next
> -	 * state now
> +	 * state now. But can't set TCP_CLOSE here, as this code path is
> +	 * reachable from the mptcp_release_cb(). Anyway the subflow will
> +	 * close soon and the msk state will follow via WORK_CLOSE_SUBFLOW.
>  	 */
>  	if (__mptcp_check_fallback(msk)) {
>  		WRITE_ONCE(msk->snd_una, msk->write_seq);
> -		if ((1 << sk->sk_state) & (TCPF_CLOSING | TCPF_LAST_ACK)) {
> -			inet_sk_state_store(sk, TCP_CLOSE);
> -			mptcp_close_wake_up(sk);

Where are we going to wake up the userspace if we don't do it here for
fallback connections?

Via subflow_state_change() which will set MPTCP_WORK_EOF flag?

> -		} else if (sk->sk_state == TCP_FIN_WAIT1) {
> +		if (sk->sk_state == TCP_FIN_WAIT1)
>  			inet_sk_state_store(sk, TCP_FIN_WAIT2);
> -		}
>  	}
>  
>  	mptcp_for_each_subflow(msk, subflow) {

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
