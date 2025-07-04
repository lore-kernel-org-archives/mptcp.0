Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A9332C08A7
	for <mptcp@lists.linux.dev>; Fri,  4 Jul 2025 08:54:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751619284; cv=none; b=XOX8CA78lAPLPoirnBI00g6nLDAg8z953CmxOjtc2vu5o383F9RS9xXBR6VdYwxiEanl3fGs1zHgYClebbvKrtd70AVJh8i2bJqk/5zvVahvWOkTMf4qqdUxVK/qLutoZuqSnYwbl19mHRVns6zfm/1I349Lgiz/XIAR9puuSKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751619284; c=relaxed/simple;
	bh=md79LY18o3Ute+OvsboBCXOTCUq/ceRArrzXsTHqzxI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OmOBeBn9zQmmSWnrbODqrEuF8lwZiPZoIsAp1pCS96swVGlaakq50RfvC7kSDYjYM8bvI+DqNwvKKK2DhK2ohbJ7EadlZwS7bfwzlu4/lshUtiEHFqm6/0YWEu1eYiLXswUNvM038W3lMwSYtAt2lXMdUKX5BwcM3ih62lTdAhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PpKFXQhK; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PpKFXQhK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751619277;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Nst6OZIST5/DENO2lx0gatFBSv2FWy17CzTnZtFS9J8=;
	b=PpKFXQhKw8ECn3FJmRuqJHriJPqn/apmj9IyvqjiAQEl2N+LFOzFCaSP+OmX+wmYkT4Osh
	MJBCpGc6xmWVCTBo6gPrvxr4KWRMSHWKbdhQ9AD3ZQ6Q+EiLpir1MaaGHSCLk3xY3lIUwk
	bvRyyZi19WsfHDvRRtpsWpJWdwo9usQ=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-78-I4cavIIAOT2v_brmL3rlMQ-1; Fri, 04 Jul 2025 04:54:35 -0400
X-MC-Unique: I4cavIIAOT2v_brmL3rlMQ-1
X-Mimecast-MFC-AGG-ID: I4cavIIAOT2v_brmL3rlMQ_1751619274
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-45311704cdbso4834085e9.1
        for <mptcp@lists.linux.dev>; Fri, 04 Jul 2025 01:54:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751619274; x=1752224074;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Nst6OZIST5/DENO2lx0gatFBSv2FWy17CzTnZtFS9J8=;
        b=R9zodvAPC4JFpgYK64hoiedLqWNpNlLDqwFqM0ZVKn0z04I1VbzqhFr5SknXDfMPym
         GflkcwG7biUA1ttmUJohjWHwTHZ0vEsnGmKHC6rbLbgS950UEPBJ39L9Y7M7GMnLZmqK
         lW6nynnmsEoxtmQax9foAbaPlfJlBvIJzCTzZ6psqB/tJEfNubLuIH4bAf/22cymCLyi
         xZKRpXQLBoCarAfWFXSnhrU4/Y9VPKqgdwqcZ/X17JxsDSHoFGDMcVnDz+FQZq9HApaz
         7dHAb+FA6g7FWbFcy4bHBKvgEfclBRr+3qgnOKVdrEIszOPGanPXTfEu7EltfP4wvCHA
         +Plg==
X-Forwarded-Encrypted: i=1; AJvYcCXtue9aa3rAOdGYKM3Lr6fx3zWcox9J6b/jXiGvsv9O/e9EGseLc6zB+EwKkrMaxeCnvphaQg==@lists.linux.dev
X-Gm-Message-State: AOJu0YwhDcdLnWl7XNAziQN6Vrl+DOeJ4iOvRnjqkOcW/TfyJy99UzdO
	12qSDYeYd+o4i62WPtc7n12YfCqj8mJOrdVHJl8Clpl33ejfDUAVkWHqrW0ZJ0AUTNkEeqivYED
	xfeOLyZxIEbR8GuM/2UxI7I95e7/sX8GT+iUkBk4lIWrJRhCqGS7cH6yX
X-Gm-Gg: ASbGncueckoVGHee+HRiBopYMCHa4AsauHmnZQY3Us7TZYd3wseqpmdlmD4y1MBRQaN
	CKFULe6+MgpimMiV1FlUq46IHXFlRZSmVj2EsOmLFSVboSETYasFi9mMKWBWCOYUrwLxMuBaeRI
	MfMG0DjsfJfkfDoFQ3OmIgILHsciYVqsekl+YtQSor5t1lOVnuwnmNgNHnJovhQiNW24A1Ktx6p
	JT+5Fs5zyNAuuxU+gvlKbVUrP75NyEZMAKwaqfeoTF8TF0FNFfqxP3vz922lJ323DRS07/FDlBU
	ECZotqwtqtCxlbNwUNuVY/Fc8SxuxFDhMPDYGQbVnODaHUqnWTLuzfBLJ+wHu5wXkaI=
X-Received: by 2002:a05:600c:648a:b0:43d:878c:7c40 with SMTP id 5b1f17b1804b1-454b4e769e4mr12662635e9.10.1751619274415;
        Fri, 04 Jul 2025 01:54:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF6ifvhyganauCPxGNOSwcrpIDtdYA0cjL/zf+H2YnkiRD5fR0i9fPqrxU54fMDDUxilh6rpw==
X-Received: by 2002:a05:600c:648a:b0:43d:878c:7c40 with SMTP id 5b1f17b1804b1-454b4e769e4mr12662255e9.10.1751619273916;
        Fri, 04 Jul 2025 01:54:33 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:270a:b10:5fbf:faa5:ef2b:6314? ([2a0d:3344:270a:b10:5fbf:faa5:ef2b:6314])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b472259842sm1913018f8f.72.2025.07.04.01.54.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Jul 2025 01:54:33 -0700 (PDT)
Message-ID: <b875b089-8233-4e61-ac42-b0e4d032d644@redhat.com>
Date: Fri, 4 Jul 2025 10:54:32 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH mptcp-next v5 3/5] mptcp: implement .read_sock
To: Geliang Tang <geliang@kernel.org>, mptcp@lists.linux.dev, hare@kernel.org
Cc: Geliang Tang <tanggeliang@kylinos.cn>
References: <cover.1751093346.git.tanggeliang@kylinos.cn>
 <1beb923fbaa782f2ddd2f97c5028425641e244d8.1751093346.git.tanggeliang@kylinos.cn>
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <1beb923fbaa782f2ddd2f97c5028425641e244d8.1751093346.git.tanggeliang@kylinos.cn>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: -zY1r6tMoAgsDRMSWLXZWMRMeckRjMOqYF0DS0P38qk_1751619274
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/28/25 8:57 AM, Geliang Tang wrote:
>  net/mptcp/protocol.c | 29 +++++++++++++++++++++++++++++
>  1 file changed, 29 insertions(+)
> 
> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index 2ebdad6b233d..1a1cfa1ff376 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -3985,6 +3985,33 @@ static __poll_t mptcp_poll(struct file *file, struct socket *sock,
>  	return mask;
>  }
>  
> +/*
> + * Note:
> + *	- It is assumed that the socket was locked by the caller.
> + */
> +static int mptcp_read_sock(struct sock *sk, read_descriptor_t *desc,
> +			   sk_read_actor_t recv_actor)
> +{
> +	struct mptcp_sock *msk = mptcp_sk(sk);
> +	struct scm_timestamping_internal tss;
> +	int flags = 0, cmsg_flags = 0;
> +	size_t len = sk->sk_rcvbuf;
> +	int copied = 0;
> +
> +	if (sk->sk_state == TCP_LISTEN)
> +		return -ENOTCONN;
> +
> +	copied = __mptcp_recvmsg_desc(sk, desc, recv_actor,
> +				      len, flags, &tss, &cmsg_flags);
> +	if (copied > 0) {
> +		if (skb_queue_empty(&sk->sk_receive_queue))
> +			__mptcp_move_skbs(sk);

With this approach, when copied == 0 &&
skb_queue_empty(&sk->sk_receive_queue) we need to call
__mptcp_move_skbs() and loop again.

I think the v4 bases implementation would be cleaner.

/p

