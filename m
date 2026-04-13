Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FDF235A95A
	for <mptcp@lists.linux.dev>; Mon, 13 Apr 2026 15:49:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776095382; cv=none; b=AGVI6ovcPRf1PLh8JT9H3KYTex3PrQw2YQh/+u49LOXapdgFwKl0am7QEx0QtF1aEy40NQ0W4ksfqh7yJlK4lOw9hDQc6AD2djjfWlDyrpOvlzwRKwJAE/nT2u2ycFqQuOiwlCN+1DJltKoJQecqqNoGdhCEbkn9IUnO+Tq+kh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776095382; c=relaxed/simple;
	bh=+zVo8Npe9WC9LO9spfh4o21LlHumSIzq+Q/ZZr9dZVE=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=KjaISEBWgmPxwvf5iDC3jg4DA+cgEHSbsIZ5h4yLLbVM1ZFVCMWknyTx46dGE4GpUWnlNmcpLyAeygoTy8mr9i6te9GMCzWUNqz15ePlnCnqqELq33QJUbtIqhvQ0kFfDSWeDfM5MLzg4YUS6DpCzxnCaE3Y9Y06UMMBS6qWU2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ffzc01LK; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ffzc01LK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776095380;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MrtrZDv601JCoZBNuRIUNbFu+dPTjBpn2WL1XKFca4g=;
	b=Ffzc01LKeRbHr/xxWh7Kr9pJjdycID8wUzUoJ1xiSzPsh/X1DIayFrw6yMqzk2CrcxRTt2
	51S1/7UkRma4AlJ1WWc4zsUaQT8q8jccPYnfsvKewtzfLidqroa6A/vQv1sWJa0CcQVtbl
	pGFKuC8V2KrZIpD9Ob+Bo/S1U3LgIPM=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-711-CEt7lfHSNGiE7bM-vWBtPQ-1; Mon, 13 Apr 2026 11:49:39 -0400
X-MC-Unique: CEt7lfHSNGiE7bM-vWBtPQ-1
X-Mimecast-MFC-AGG-ID: CEt7lfHSNGiE7bM-vWBtPQ_1776095378
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-43cff5ef652so2879707f8f.2
        for <mptcp@lists.linux.dev>; Mon, 13 Apr 2026 08:49:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776095378; x=1776700178;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MrtrZDv601JCoZBNuRIUNbFu+dPTjBpn2WL1XKFca4g=;
        b=lg0E5a+lY8LALZ4YZO279Q00w5jQjRBYLICY3fVtw74JgGt+eFdRRpzAzHbtvNMbcS
         XSyNLmBDLrtv20sdzxz6Jfh6jCesKZyU6FXVwDJhNBpwd46acAYOEHx9eNIQOq54pKFI
         /JEfdUaZT5mqKxaGWXvnyIVL4fvtwswklLzDRJu0sNScP0Vb4SX9w6bex7IcYt6evUhL
         FDFcw9jQ90ewdpYSdbPiHonefKESyvchQySob9tk1utdletUJ3XZ3D71in7OPBlNAnPi
         tROJfF/nSjr9iXsr46tB8jdwX9kZoEJzD/CHmkVTvTWs5+K7pBhUv4siIgtlm19DBeRa
         7xQQ==
X-Forwarded-Encrypted: i=1; AFNElJ8/FwuKfnbx6hYkIoO8XU+jmYITRkGRLJ74iQrnfhIzsPr8VvsdopFOwzZw7h1pNTesaQP7gA==@lists.linux.dev
X-Gm-Message-State: AOJu0YxROjzE6vaC9YnUCNqQNJlqjC8b8POisF9Ndp/TOsiMQ67R7KOk
	Y7lAwOYJSK1eCpJHJO4k31147qWPBz7zSkwzqapKAyf7QwXMBeBvBAUofnSePX8ak5OzPTIVOpS
	pyTrtn8cN3y+xzEg9+CO1b1ZY+wW7YwM1YPf76iWMpfDZojgCnjjD8X00BgbL4Zkp
X-Gm-Gg: AeBDieuYMTGYL3rocTs1hfoyBBmDRo3pkDwhDfTltyC8NGjyWmYGKsOFHHLQb0GG/8K
	fnexGLgNlvBj72BVoXDNnmBGhXjNlxP09Prt95ZEA6gdUx3bZSBOiTbYLj2mK72nQ3+Ek7X8dU8
	MLVqwVT1mufx/PnfZzfRfoElIFCOzxUhR4UfqZXi9/q0vJvg3tjUPwxVRTeOjxrJKt1V2bqZucO
	40k9IUaj8cfLJx3KizQ4cgn3gDmU8pUgPRxCDoBx8eOOUo03yyDf15X+Gm0TEPmaIWseH/WpFFJ
	KxPaSFqE8HgE1cE7qw4IjTy6i/FpGj8VkhIoZat4yggUjM59gybBn7D75el2F7KYS+WxcHNvJaw
	dWcBHwJsLVwolbxaf5QFryBPXHEv6prr7syLdowYeIxEQdtvJcVJ4NHxd
X-Received: by 2002:a05:6000:26cd:b0:43d:7b90:fa21 with SMTP id ffacd0b85a97d-43d7b90fc9fmr4633800f8f.12.1776095377688;
        Mon, 13 Apr 2026 08:49:37 -0700 (PDT)
X-Received: by 2002:a05:6000:26cd:b0:43d:7b90:fa21 with SMTP id ffacd0b85a97d-43d7b90fc9fmr4633750f8f.12.1776095377197;
        Mon, 13 Apr 2026 08:49:37 -0700 (PDT)
Received: from [192.168.88.32] ([216.128.11.125])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43d63e5061fsm34790546f8f.30.2026.04.13.08.49.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Apr 2026 08:49:36 -0700 (PDT)
Message-ID: <29fbf2db-d678-4144-96e1-a03f63df2988@redhat.com>
Date: Mon, 13 Apr 2026 17:49:35 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Fwd: Re: [PATCH mptcp-net v5 4/5] mptcp: fix the dead_lock in
 mptcp_data_ready
To: gang.yan@linux.dev, mptcp@lists.linux.dev
References: <cover.1775033340.git.yangang@kylinos.cn>
 <8ed0aeb49f13410b25200d884c89ef3201d2c23b.1775033340.git.yangang@kylinos.cn>
 <159f8b70-4ffa-4eef-a3ca-13de3f8bc191@redhat.com>
 <e1f58d941ad141f9f96a24d1a1d9d6ca74cc2f5e@linux.dev>
 <bd405b7aaedd030858f609e936c811903e139f32@linux.dev>
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <bd405b7aaedd030858f609e936c811903e139f32@linux.dev>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: ptAYPAniqqNkdHTbLWxn95E9BeKTYpPZWl6Vm__Jigo_1776095378
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

hi,

I'm sorry for the very late reply. I'm really can't keep-up with
everything, my latency here is going to be even worse.

On 4/3/26 8:45 AM, gang.yan@linux.dev wrote:
> -------- Forwarded message -------
> 
> From: gang.yan@linux.dev mailto:gang.yan@linux.dev 
> To: "Paolo Abeni" <pabeni@redhat.com mailto:pabeni@redhat.com?to=%22Paolo%20Abeni%22%20%3Cpabeni%40redhat.com%3E >
> Sent: April 3, 2026 at 2:44 PM
> Subject: Re: [PATCH mptcp-net v5 4/5] mptcp: fix the dead_lock in mptcp_data_ready
> 
> April 2, 2026 at 4:02 AM, "Paolo Abeni" <pabeni@redhat.com mailto:pabeni@redhat.com?to=%22Paolo%20Abeni%22%20%3Cpabeni%40redhat.com%3E > wrote:
> 
> 
> 
>>
>> On 4/1/26 10:54 AM, Gang Yan wrote:
>>  
>>  
>>  From: Gang Yan <yangang@kylinos.cn>
>>  
>>  This patch defers mptcp_check_data_fin from __mptcp_move_skbs to avoid
>>  deadlock.
>>  
>>  When processing backlogged data in softirq context, __mptcp_move_skbs
>>  directly calls mptcp_check_data_fin, which can lead to a deadlock if
>>  the msk socket is in TCP_FIN_WAIT2 state. In that case,
>>  mptcp_check_data_fin calls mptcp_shutdown_subflows, which attempts to
>>  lock the subflow socket with lock_sock_fast() - a sleeping function
>>  that cannot be called in atomic context (softirq).
>>  
>>  The fix for such issue should be squashed inside the patch generating
>>  the issue itself.
>>  
>>  
>>  The correct pattern is already used in move_skbs_to_msk: if a data fin
>>  is pending, schedule the work to be processed later in process context
>>  rather than handling it directly.
>>  
>>  Reported-by: Geliang Tang <geliang@kernel.org>
>>  Co-developed-by: Geliang Tang <geliang@kernel.org>
>>  Signed-off-by: Geliang Tang <geliang@kernel.org>
>>  Signed-off-by: Gang Yan <yangang@kylinos.cn>
>>  ---
>>  Notes:
>>  
>>  Hi Matt,Paolo:
>>  
>>  Here is the response of AI review for this patch:
>>  
>>  - Typo problem in subject line:
>>  Already fixed in v5.
>>  
>>  - Remove else branch:
>>  It demonstrates a TOCTOU race, though the race window is extremely
>>  narrow. The else branch is useless even without the race. So I
>>  removed it in v5. WDYT?
>>  
>>  Thanks,
>>  Gang
>>  
>>  Changelog:
>>  v5:
>>  - Fix typo in title.
>>  - Remove the else branch.
>>  
>>  ---
>>  net/mptcp/protocol.c | 5 +++--
>>  1 file changed, 3 insertions(+), 2 deletions(-)
>>  
>>  diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
>>  index 326b5d4d79e7..88e19fa61b84 100644
>>  --- a/net/mptcp/protocol.c
>>  +++ b/net/mptcp/protocol.c
>>  @@ -2247,8 +2247,9 @@ static bool __mptcp_move_skbs(struct sock *sk, struct list_head *skbs, u32 *delt
>>  }
>>  
>>  __mptcp_ofo_queue(msk);
>>  - if (moved)
>>  - mptcp_check_data_fin((struct sock *)msk);
>>  + if (moved && mptcp_pending_data_fin(sk, NULL))
>>  + mptcp_schedule_work(sk);
>>  
>>  Scheduling the worker when we are not in BH could introduce problematic
>>  delays. Instead you could factor out a ____mptcp_move_skbs() helper (a
>>  better name would be nice!) not including the mptcp_check_data_fin()
>>  call, use the latter in mptcp_data_ready() and in such function
>>  eventually schedule the mptcp work as needed.
>>
> Hi Paolo,
> 
> Thanks for your review. 
> I'm a little bit confused. Does this mean the 'move_skbs_to_msk' should be
> fixed too? like:

The additional latency due to the schedule work is the lesser problem,
the main one is the potentially very long time spent in RB tree processing.

> 
> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index 6ce0d18c86b6..e90c8621683c 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -869,13 +869,6 @@ static bool move_skbs_to_msk(struct mptcp_sock *msk, struct sock *ssk)
>  if (unlikely(ssk->sk_err))
>  __mptcp_subflow_error_report(sk, ssk);
>  
> - /* If the moves have caught up with the DATA_FIN sequence number
> - * it's time to ack the DATA_FIN and change socket state, but
> - * this is not a good place to change state. Let the workqueue
> - * do it.
> - */
> - if (mptcp_pending_data_fin(sk, NULL))
> - mptcp_schedule_work(sk);

Also, on top of my memory, this is like that since the beginning, and
never caused problem. The point vs the proposed patch is that it adds
latency to the current status quo.

>  return moved;
>  }
>  
> @@ -909,6 +902,7 @@ void mptcp_data_ready(struct sock *sk, struct sock *ssk)
>  {
>  struct mptcp_subflow_context *subflow = mptcp_subflow_ctx(ssk);
>  struct mptcp_sock *msk = mptcp_sk(sk);
> + bool moved = false;
>  
>  /* The peer can send data while we are shutting down this
>  * subflow at subflow destruction time, but we must avoid enqueuing
> @@ -920,13 +914,17 @@ void mptcp_data_ready(struct sock *sk, struct sock *ssk)
>  mptcp_data_lock(sk);
>  mptcp_rcv_rtt_update(msk, subflow);
>  if (!sock_owned_by_user(sk)) {
> + moved = move_skbs_to_msk(msk, ssk); 
>  /* Wake-up the reader only for in-sequence data */
> - if (move_skbs_to_msk(msk, ssk) && mptcp_epollin_ready(sk))
> + if (moved && mptcp_epollin_ready(sk))
>  sk->sk_data_ready(sk);
>  } else {
>  __mptcp_move_skbs_from_subflow(msk, ssk, false);
>  }
>  mptcp_data_unlock(sk);
> + 
> + if (mptcp_pending_data_fin(sk, NULL))
> + mptcp_check_data_fin(sk);

Finally this chunk should still be (mostly) in atomic context as it's
invoked by the subflow sk_data_ready and sk_state_change callbacks with
run almost always in bh scope.

DL:DR: this chunk is not needed.

/P

