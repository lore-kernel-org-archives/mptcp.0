Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4653A2877F8
	for <mptcp@lists.linux.dev>; Fri,  4 Jul 2025 08:49:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751618954; cv=none; b=b7oAO3EszR67Xx9OziEymsRxQp5THqsxRMCSH+hbM1Epr5r1iLiihBObvqPvMH4jCB0jsieizMJg+OAO39cnwPUPHAdQDOTM83tGodnpKj1CfbMIjLNrcXZ7P2ewB8rVti36Uno4iyMdyFMq3FyzdMEbheU72/gHgKSiy5070iw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751618954; c=relaxed/simple;
	bh=3MIz725kca4XJWytFJEhAzRoHGtwUmtZY1CS4Q87rxM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=f+Uzl8+O0Eth7HNJU0tlQCGzyfj80zpQBrLLKRyv9RDfzmojueRqh6M3YpcE/x3SXRJMQCKlULXFey3XAH4IuvloPp76zYSdTLQaFPUUTbP9n7VN/duR6dw8G2D6bVAopKf7coCseFXtPdI2pI8Ca1/quxDf46g0bXMY/zGMiDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hksSc/j2; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hksSc/j2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751618952;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ujFp2tJIEHvWHWcpjimSOsURrpRz0hZ8Fn+DJPx4HHA=;
	b=hksSc/j2xcnDgABggGpP1lXIN5pKIqtAgzvHzA2z4Mq11xqL6ANC6Imod46g13+d1ORH5q
	Y4TsP9r7ixzo9qgroc0+HeLBkHMmtKI2LwBwQ1rOodXny/nWTEq0FN3NYNDm70t5xIzaNW
	72L7885mxp3h04qciB9N/9nWeTOTBAI=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-42-wX2DJrfWPCyTZivzC4I8NQ-1; Fri, 04 Jul 2025 04:49:11 -0400
X-MC-Unique: wX2DJrfWPCyTZivzC4I8NQ-1
X-Mimecast-MFC-AGG-ID: wX2DJrfWPCyTZivzC4I8NQ_1751618950
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-451d5600a54so5499625e9.2
        for <mptcp@lists.linux.dev>; Fri, 04 Jul 2025 01:49:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751618950; x=1752223750;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ujFp2tJIEHvWHWcpjimSOsURrpRz0hZ8Fn+DJPx4HHA=;
        b=qO0u6nohuFUGBennndVRuF3Q09iwzxmVhQ7ud4+0yDzWwYKwhGMJpSK1tgVq7QKRg+
         Og2FrJ6uRKx7PN+2e7UFwyKLeBj0ZC59G0fhB9urBiRyDEcV9MTtGA0A8zta7J7VbR6P
         MsKFBTwhY5GLnsAF4X/msSJ03HwPNtl5rOY+dpGAF+qLofrYAD2eCHF9F36nL8g6ncFh
         lSEhGvqDnh3jGXQ+ujee5nWjZFA7eHBH3I9d99+hrEdRAfSWqo6RtxuhuMJI+pFaJuc2
         79+e9DDZicZIK1sfs8fFfS6X7Mwkxha94Uhig828+qGFjHv8+qxlmLuUai6sfOFs4MhL
         CkjA==
X-Forwarded-Encrypted: i=1; AJvYcCV/2OMTgkc7ffxj/BHv3/yXPCKLFIOgl4+Y+ONJj9zS96n1B7+DDfMJoXGBhBErXx0XIqe6dg==@lists.linux.dev
X-Gm-Message-State: AOJu0YyhhMmG1wHeqfg+ls1Wv8f2+2I/LFvwCQ2zY9wJrRxgCyFEZE+J
	xkoJS6x16Uq59wOrjfP+Ltc6B02PRgjG631ZUgPQV6KUVpLRq0wriUCanmLx+wpyixqd1rCrctW
	QA9OhKagmaApMvSTiiQsinPosRWL81rdV8Nap/DB+z1UQD4OHbZQC6dKS
X-Gm-Gg: ASbGnctOZbAzsJDn9YrTbVwRNTz+sXTntUFyBK8RZuRuIMBHmvJe0OIoEVNsrCDUf9A
	ZnI3WAHZuiLJ3jiQ0p7Sx0LdglNqAe+nwz+vwET/Y32m3HNIKKLeTIZQ9guvnp8UzcOp70F6i9N
	VIYNaVMDRVWT2Fwq7S1MpaLAiBGk8d2eNa12QOrbQ0Z/QQMYrkfRtUsTo7kikPdzm87MAw8htJ+
	gUC1d5TdskwErlOW1xyeYyy1j+uT6ZFtpmJ3nB6DEg75V6P/8slnhfBL6BEQtL2Tiig3a3/aZEV
	BMEFkIBv/KecL+5xdiOp0pStPHmQqrjs9ENEzFWDQWI9E8hgs6Jd22Ir2bIEBHFfu1o=
X-Received: by 2002:a05:600c:348d:b0:453:608:a18b with SMTP id 5b1f17b1804b1-454b3096211mr17040395e9.9.1751618949453;
        Fri, 04 Jul 2025 01:49:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH0PqWV3xmeABSgVcuUm73casy/st/fMuMgGBem5w6DeAWYz7bnOYZFjkxuIg6qW0zWnGXEXg==
X-Received: by 2002:a05:600c:348d:b0:453:608:a18b with SMTP id 5b1f17b1804b1-454b3096211mr17040045e9.9.1751618948972;
        Fri, 04 Jul 2025 01:49:08 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:270a:b10:5fbf:faa5:ef2b:6314? ([2a0d:3344:270a:b10:5fbf:faa5:ef2b:6314])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-454a9bcef22sm49642335e9.19.2025.07.04.01.49.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Jul 2025 01:49:08 -0700 (PDT)
Message-ID: <cee4eb31-70e0-4755-8aab-026524a5b1dd@redhat.com>
Date: Fri, 4 Jul 2025 10:49:07 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH mptcp-next v5 2/5] mptcp: add recvmsg_desc helper
To: Geliang Tang <geliang@kernel.org>, mptcp@lists.linux.dev, hare@kernel.org
Cc: Geliang Tang <tanggeliang@kylinos.cn>
References: <cover.1751093346.git.tanggeliang@kylinos.cn>
 <5fcd0bddfcdca24ebe9b0ff66cad0913235a4df9.1751093346.git.tanggeliang@kylinos.cn>
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <5fcd0bddfcdca24ebe9b0ff66cad0913235a4df9.1751093346.git.tanggeliang@kylinos.cn>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: CSPe_0JKZjpTr0_lQ0L6tWx9fxXrIUPDYrummb5262k_1751618950
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

hi,

I'm sorry, I look at v4 too late...

On 6/28/25 8:57 AM, Geliang Tang wrote:
> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index 2f747ab730e5..2ebdad6b233d 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -1844,8 +1844,9 @@ static int mptcp_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
>  
>  static void mptcp_rcv_space_adjust(struct mptcp_sock *msk, int copied);
>  
> -static int __mptcp_recvmsg_mskq(struct sock *sk,
> -				struct msghdr *msg,
> +static int __mptcp_recvmsg_desc(struct sock *sk,
> +				read_descriptor_t *desc,
> +				sk_read_actor_t recv_actor,
>  				size_t len, int flags,
>  				struct scm_timestamping_internal *tss,
>  				int *cmsg_flags)
> @@ -1861,12 +1862,14 @@ static int __mptcp_recvmsg_mskq(struct sock *sk,
>  		int err;
>  
>  		if (!(flags & MSG_TRUNC)) {
> -			err = skb_copy_datagram_msg(skb, offset, msg, count);
> -			if (unlikely(err < 0)) {
> +			err = recv_actor(desc, skb, offset, count);
> +			if (err <= 0) {
>  				if (!copied)
>  					return err;
>  				break;
>  			}
> +			if (!WARN_ON_ONCE(err > count))
> +				count = err;
>  		}
>  
>  		if (MPTCP_SKB_CB(skb)->has_rxtstamp) {
> @@ -1902,6 +1905,32 @@ static int __mptcp_recvmsg_mskq(struct sock *sk,
>  	return copied;
>  }
>  
> +static int mptcp_recvmsg_actor(read_descriptor_t *rd_desc, struct sk_buff *skb,
> +			       unsigned int offset, size_t len)
> +{
> +	struct msghdr *msg = rd_desc->arg.data;
> +	int err;
> +
> +	err = skb_copy_datagram_msg(skb, offset, msg, len);
> +	if (unlikely(err < 0))
> +		return err;
> +	return len;
> +}
> +
> +static int __mptcp_recvmsg_mskq(struct sock *sk,
> +				struct msghdr *msg,
> +				size_t len, int flags,
> +				struct scm_timestamping_internal *tss,
> +				int *cmsg_flags)
> +{
> +	read_descriptor_t desc = {
> +		.arg.data = msg,
> +	};
> +
> +	return __mptcp_recvmsg_desc(sk, &desc, mptcp_recvmsg_actor,
> +				    len, flags, tss, cmsg_flags);

We want to avoid this indirect call in the fast path, even with the
indirect call wrapper. I think the approach in v4 should be preferred.

Also this looks problematic from a functional perspective, see comment
on the next patch

/P

