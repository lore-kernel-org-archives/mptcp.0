Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com [209.85.167.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E635C158D69
	for <mptcp@lists.linux.dev>; Fri, 31 May 2024 13:41:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717162894; cv=none; b=obUj3FoX8AzntiYxAHUiNSITTybd3Clpty8S5Mg26cE/1kzs07EFPjiVHHK7oSBPrcNhJPWkxheCeg8m/PbBPd44bBCDDhwOGmgi71wujP+9Ukl2oxHTKpoSwb2mEm+vN2oiPRhXu4zAiU5svKYTY0S0X1khzsapPSXgEXmzSPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717162894; c=relaxed/simple;
	bh=Qe6iPNmZyF9PbqeWNYRD2JXQ9U03MTdbpv50ax+t/hk=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=a+y+pxnltdmoxehvVpFqREOdDutLy5BrWZY5/3xPdNyTCRsN/oO2bbkllmNo/KR8MsbZgq6dzDnHzMQxVT9LuscJ6JHLpKNX/Yfwwmv44hjvunFan2fszdAqdfppZSXTv7r4oTp3GCokBsJ3bb7YmyeYBffdFFWDrIEOI01qeyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jxRPCLYE; arc=none smtp.client-ip=209.85.167.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jxRPCLYE"
Received: by mail-oi1-f181.google.com with SMTP id 5614622812f47-3cabac56b38so1124703b6e.3
        for <mptcp@lists.linux.dev>; Fri, 31 May 2024 06:41:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717162892; x=1717767692; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=53NT90nK/rQ/MNedY8JCIK8AOZhWYEd9h5PFD5XpxyU=;
        b=jxRPCLYErjH6jK4P1J28dpJJnPZ2gcXBvTm73qbDz7Ocm9ZjHet3x6xEqbTcH6as8y
         BlUo5XGULAV5BUfVDnmY2nHanixFV/045qoX7horMX2yH5CbggSISd6RVK8AVMLhcMWs
         PqGTSd3RQmgQ5kBqZP4kXq0Ikbw+7MEP9iffp1DoscATUHev83lz5iAIXOfCBwNMMzob
         Yzf7E3xb2ZTLG4RzxSR5dihVJ5tuDy8idXuTXjewQmCkwFhIqQBwkXjaHT8uste1cUYT
         7M9JNrtcF/z8mf+RrQgv4GK0FZTq/86uMbElAaI6E/61x99h+Jszqqi7G06Tm1V9Gx0a
         pmrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717162892; x=1717767692;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=53NT90nK/rQ/MNedY8JCIK8AOZhWYEd9h5PFD5XpxyU=;
        b=M+eQjGfZFjowE657/mLsDbh7La97m+EhSWJ0fzZBW0w+K/jawbRyaKvYKHDDHYMsqK
         B1MuvCK3lhYBHZ2j3p0jt2+GATOxS3/eIl/hmzUg8YkCF8BSKzTliLIaPh4PWgpHygOn
         R7mISrOv1bNKRBxypbMI2sq7UA4CMg7t59jfMII1zKP2hmm5igP10sQfLW64sfvIgxrn
         BoM0Giv3qhSdFP1fCkomIK1gA/CsXmnKIAYBJpXTC8NZ8FKAa+Pf9QN5Kwe+0NP4pgKo
         Y7V5d4OoJhOIY9RV9Iye1jxF4Z0K9l2LAo5RX/V5bb0DMCUJk+aftZ+DmCa6O/7//Y9S
         7fWw==
X-Forwarded-Encrypted: i=1; AJvYcCXFePVcmO7Ahu6T0WmYvu3Lkm9PBw3E1EyBfs3siOyEFCW/GMx2pzZ03zIyMxC1eof3qNTknP3GDV0gGRCEmrLPYF0obME=
X-Gm-Message-State: AOJu0Yy6MjzaGUX86U1FNOjQe7tKPDSleDyryInf3A7uYXNcYvhUeolr
	jAHu6g86IA9zFftgThg0Dvw7/IOOfdvyTA6Is+clcDxKU2DJgK0w
X-Google-Smtp-Source: AGHT+IE7yMTgsH5ODanjs+vRlfbfg0/F/j+h/ZOyGYRrc00sXZyuCTKmgGy3M8gqqDyGx1aRGA2SKg==
X-Received: by 2002:a05:6808:1491:b0:3c7:4d4e:efa with SMTP id 5614622812f47-3d1e31ead0fmr2761496b6e.0.1717162891841;
        Fri, 31 May 2024 06:41:31 -0700 (PDT)
Received: from localhost (112.49.199.35.bc.googleusercontent.com. [35.199.49.112])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6ae4a73fa69sm6601726d6.19.2024.05.31.06.41.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 May 2024 06:41:31 -0700 (PDT)
Date: Fri, 31 May 2024 09:41:30 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>, 
 edumazet@google.com, 
 pabeni@redhat.com
Cc: davem@davemloft.net, 
 netdev@vger.kernel.org, 
 mptcp@lists.linux.dev, 
 matttbe@kernel.org, 
 martineau@kernel.org, 
 borisp@nvidia.com, 
 willemdebruijn.kernel@gmail.com, 
 Jakub Kicinski <kuba@kernel.org>
Message-ID: <6659d38ac31fa_3f8cab29482@willemb.c.googlers.com.notmuch>
In-Reply-To: <20240530233616.85897-3-kuba@kernel.org>
References: <20240530233616.85897-1-kuba@kernel.org>
 <20240530233616.85897-3-kuba@kernel.org>
Subject: Re: [PATCH net-next 2/3] tcp: add a helper for setting EOR on tail
 skb
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Jakub Kicinski wrote:
> TLS (and hopefully soon PSP will) use EOR to prevent skbs
> with different decrypted state from getting merged, without
> adding new tests to the skb handling. In both cases once
> the connection switches to an "encrypted" state, all subsequent
> skbs will be encrypted, so a single "EOR fence" is sufficient
> to prevent mixing.
> 
> Add a helper for setting the EOR bit, to make this arrangement
> more explicit.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Reviewed-by: Willem de Bruijn <willemb@google.com>

> ---
>  include/net/tcp.h    |  9 +++++++++
>  net/tls/tls_device.c | 11 ++---------
>  2 files changed, 11 insertions(+), 9 deletions(-)
> 
> diff --git a/include/net/tcp.h b/include/net/tcp.h
> index 32741856da01..08c3b99501cf 100644
> --- a/include/net/tcp.h
> +++ b/include/net/tcp.h
> @@ -1066,6 +1066,7 @@ static inline bool tcp_skb_can_collapse_to(const struct sk_buff *skb)
>  static inline bool tcp_skb_can_collapse(const struct sk_buff *to,
>  					const struct sk_buff *from)
>  {
> +	/* skb_cmp_decrypted() not needed, use tcp_write_collapse_fence() */
>  	return likely(tcp_skb_can_collapse_to(to) &&
>  		      mptcp_skb_can_collapse(to, from) &&
>  		      skb_pure_zcopy_same(to, from));
> @@ -2102,6 +2103,14 @@ static inline void tcp_rtx_queue_unlink_and_free(struct sk_buff *skb, struct soc
>  	tcp_wmem_free_skb(sk, skb);
>  }
>  
> +static inline void tcp_write_collapse_fence(struct sock *sk)
> +{

const struct ptr?

> +	struct sk_buff *skb = tcp_write_queue_tail(sk);
> +
> +	if (skb)
> +		TCP_SKB_CB(skb)->eor = 1;
> +}
