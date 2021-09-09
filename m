Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72FFC3FE9
	for <mptcp@lists.linux.dev>; Thu,  9 Sep 2021 13:54:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1631195683;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/Y0fuahaFTIgtTr5m9a5GPUUSgOcs06599wkNbJxcKo=;
	b=XcYmJifKIRz9DBi3EqhcyAtS2C1gGBnD4yKJZ2nEW3wFwvtC8FLdS2l16lkm5sKRIdvvr8
	fvnyYJ6TZSTxjcqeKRHp3EVaArnqMHgwuJ/y7ndAy9V6OR0UQVYC4COIC7vm8Q63ojqkZj
	R9p4fujezgLVc4dfgqWpPMUMwTbQXqY=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-164-oe6uigYgMC2WpSA0RSZFZA-1; Thu, 09 Sep 2021 09:54:42 -0400
X-MC-Unique: oe6uigYgMC2WpSA0RSZFZA-1
Received: by mail-wr1-f72.google.com with SMTP id n1-20020a5d4c41000000b00159305d19baso534716wrt.11
        for <mptcp@lists.linux.dev>; Thu, 09 Sep 2021 06:54:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=/Y0fuahaFTIgtTr5m9a5GPUUSgOcs06599wkNbJxcKo=;
        b=kTG9nWyP1a8pMeYp8th+yVUpzm91byTMn1VxlrhIVnUtS89nyDT7MUO0Dgukj9pmgc
         82YoXRw6ySHlS9ukSwdWm10PQspkp5dhcI6Btaf/W7xyO10WdNDjZiQZuU0rXzIC8HCy
         opBKOyXGXMCU0iZJ2441sgIUUkstH4UrVe7rDD+MJ17czVxX0gQ9JAq1Gp2LmEZap8Xh
         zjt7No8JMLpJkpvGsLgJKVqX+CGqs1vCoAyaS+5lfA9PEH6COUOksfaVPS8YRceYTARm
         rMNBPNXgd/291uxIzo74CvwcTyiEBl6qtegEIHt98ZVXkTOUjeUUe8VPOXxNpdXlC8oV
         lflQ==
X-Gm-Message-State: AOAM5316FsSP9UKD68bHv10jQ1wKOP1NBFZmnFzvINQNhDbVvecPNelA
	hlk7EEwAr99NalotrHmipIVDyLiAlqS/QScKouhxt4Llp5Hwza9GuRsnwClhx1Q2EbbkARson4y
	ahKadzscVOF6AoHM=
X-Received: by 2002:adf:a2c4:: with SMTP id t4mr3798049wra.258.1631195681022;
        Thu, 09 Sep 2021 06:54:41 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwlUGklMpot5VbhOSuRof9hIWcXm9C/3afLH3EYANGnmDL9dbHk3lS+xTN6sCtj5NXTmHSH7A==
X-Received: by 2002:adf:a2c4:: with SMTP id t4mr3798029wra.258.1631195680731;
        Thu, 09 Sep 2021 06:54:40 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-241-2.dyn.eolo.it. [146.241.241.2])
        by smtp.gmail.com with ESMTPSA id m29sm1898574wrb.89.2021.09.09.06.54.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Sep 2021 06:54:40 -0700 (PDT)
Message-ID: <e62030507662c46ca596bb1c4d5d0f9151a74b59.camel@redhat.com>
Subject: Re: [PATCH mptcp-next v2 5/9] mptcp: infinite mapping sending
From: Paolo Abeni <pabeni@redhat.com>
To: Geliang Tang <geliangtang@gmail.com>, mptcp@lists.linux.dev
Cc: Geliang Tang <geliangtang@xiaomi.com>
Date: Thu, 09 Sep 2021 15:54:39 +0200
In-Reply-To: <e32e444b498565f85da14285dfc5a865fedc6e58.1631188109.git.geliangtang@xiaomi.com>
References: <cover.1631188109.git.geliangtang@xiaomi.com>
	 <e32e444b498565f85da14285dfc5a865fedc6e58.1631188109.git.geliangtang@xiaomi.com>
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

On Thu, 2021-09-09 at 19:51 +0800, Geliang Tang wrote:
> From: Geliang Tang <geliangtang@xiaomi.com>
> 
> This patch added the infinite mapping sending logic.
> 
> Added a new flag snd_infinite_mapping_enable in mptcp_sock. Set it true
> when a single contiguous subflow is in use in mptcp_pm_mp_fail_received.
> In mptcp_sendmsg_frag, if this flag is true, call the new function
> mptcp_update_infinite_mapping to set the infinite mapping.
> 
> Signed-off-by: Geliang Tang <geliangtang@xiaomi.com>
> ---
>  net/mptcp/pm.c       |  6 ++++++
>  net/mptcp/protocol.c | 18 ++++++++++++++++++
>  net/mptcp/protocol.h |  1 +
>  3 files changed, 25 insertions(+)
> 
> diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
> index 6ab386ff3294..2830adf64f79 100644
> --- a/net/mptcp/pm.c
> +++ b/net/mptcp/pm.c
> @@ -251,7 +251,13 @@ void mptcp_pm_mp_prio_received(struct sock *sk, u8 bkup)
>  
>  void mptcp_pm_mp_fail_received(struct sock *sk, u64 fail_seq)
>  {
> +	struct mptcp_subflow_context *subflow = mptcp_subflow_ctx(sk);
> +	struct mptcp_sock *msk = mptcp_sk(subflow->conn);
> +
>  	pr_debug("fail_seq=%llu", fail_seq);
> +
> +	if (!mptcp_has_another_subflow(sk) && !READ_ONCE(msk->noncontiguous))
> +		WRITE_ONCE(msk->snd_infinite_mapping_enable, true);
>  }
>  
>  /* path manager helpers */
> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index c7ecd3e3b537..4ebbbc6f1d01 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -1278,6 +1278,21 @@ static void mptcp_update_data_checksum(struct sk_buff *skb, int added)
>  	mpext->csum = csum_fold(csum_block_add(csum, skb_checksum(skb, offset, added, 0), offset));
>  }
>  
> +static void mptcp_update_infinite_mapping(struct mptcp_sock *msk, struct mptcp_ext *mpext)
> +{
> +	if (!mpext)
> +		return;
> +
> +	mpext->data_seq = READ_ONCE(msk->start_seq);
> +	mpext->subflow_seq = 0;
> +	mpext->data_len = 0;
> +	mpext->csum = 0;
> +
> +	WRITE_ONCE(msk->snd_infinite_mapping_enable, false);
> +	pr_infinite(msk);
> +	__mptcp_do_infinite(msk);
> +}

If you move the 'snd_infinite_mapping_enable' flag at the subflow level
(inside struct mptcp_subflow_context), all the _ONCE annotation will
not be needed. And the flag will be already initializated to 0 at ctx
creation time.

Additionally, I'm unsure the MPTCP_INFINITE_DONE bit is required ?!?
can we simply rely on FALLBACK ???

/P

