Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3EC31FC0EA
	for <mptcp@lists.linux.dev>; Thu, 13 Nov 2025 17:09:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763053751; cv=none; b=srxcEVH7X4/+ZzBkXNBuxdkkFNgugK5HTSNEwX1/3BwAolSN5CGSdHzBJyoNfVDXV20PU9mfMVUzgyxfvxV8XaXRDiNOQgZjJrbLfHdKpPtvA9x3RRufgONNALcUgQMIVydj6c4R6+gXv9w3hSBq8K08AgpNc9osJFDVFumS0UU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763053751; c=relaxed/simple;
	bh=u0CwAjhjAGHPKjXkBJj615yiDXxKTNiSeS786wcedGA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gLQ+6vL59bDiwabj+nuxg7WsHR9XFOR5FIke1RAl7u4jOYZGeR2IpCRNKQ8N5kBEMwLEyXsgl3k6aUciZXcMlUg/Y6xEXz76mCEEyYPrR9ZVhwcGivbKf2yzH9qwduoTDO0SB+PIbJmo4a4GVHOSo0qYpo6q2x+nJjP/Kss6lmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TeATVUi0; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TeATVUi0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1763053748;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vAoJ2x67X7AugM2e7nJQ31xwDwBWtCyL1qtAwnBUQMc=;
	b=TeATVUi0PB89poky3em/zm5lzNg33mzOC0IeyvguhyBPQ9Ks24rI2M6mu6LTq02cLq9f1b
	sMLLKsndalBs6X0BopSSrJUTvZDACNO9dcp6uS9jhBX84Im2URzha5qsm51i2f+yIAPBq2
	wMVUODVMGLNQTLHJ0+70QYwPF6nzf0U=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-216-fuyFeecqNzK0GZHh7zjKvg-1; Thu, 13 Nov 2025 12:09:07 -0500
X-MC-Unique: fuyFeecqNzK0GZHh7zjKvg-1
X-Mimecast-MFC-AGG-ID: fuyFeecqNzK0GZHh7zjKvg_1763053746
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-42b2fb13b79so531156f8f.3
        for <mptcp@lists.linux.dev>; Thu, 13 Nov 2025 09:09:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763053745; x=1763658545;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vAoJ2x67X7AugM2e7nJQ31xwDwBWtCyL1qtAwnBUQMc=;
        b=XNdRxNG07DKBs3Hv1eIN7EcVQ7/yjJn2ErXeBAj5/wkczuxuHIFUC1Jo293xehmaao
         s3hLAvAziB0h/9k4YhcZacLWm+9YGnn8BoCHFF2RqHdLDxbr8bjF1KLsrE2fi2I2+jS9
         YkRtF7fXfESA/J/QjRmC2yf0tmixZN8z6QljkLGIQBimPp+gm/SEBz7Wt6+WPf/uh1l0
         aZgAUFtXEgboNCi/FrUE43Vc3TBAeFYDHAY4Lxvxh/GZ78tYArLv/H6fIXvYplVbU2La
         eqtvEjXbZPVm8soBBESeDxNjThCRTZTYyXwOrn6S2TQFBTRq0bMbLzHq/rGt1ATpPkwp
         I4sQ==
X-Gm-Message-State: AOJu0Yw66Aq4ahVS4rAUkI+8NuEjrI0qEGebnjxfCt4NZvzwZneZ+u6p
	00NsR5HLXJ4Nldrn/mH2EL1lf1ZA6csRoJTnwcru6evwlJR/w1pbM63Ad6hB7CYDjaDz9t3KQDF
	+72RcQnEtkheSqhMkZlCNXwfzYeQPzlFI78jRiTISnhcJQ1qpAQbS9GiDjw0Ssy+l
X-Gm-Gg: ASbGncuncZz8CXLV9nm0XHWY/tWPaMZvg1u5Uzpi20ord8nmCKN3gXbJ5zwNwWDnvh+
	I2nbaE6G25jv09Gk5RqJ7WmUkhdXnm4Nrx8V8wXrgvMWrk2lnw2yN12y9ADDHBWugMlWkymeh+x
	kZ93NSsI1ERdzg1d5ey8sgvDD+4je6vrqkuuBsYW2wnw0/fDsnOFlzE26/uT7xMrRTp/kZ9sbbS
	tALe8UKJhSaYJnN9ra+keMZ2yXZyl/atkEgbgW22Ri4UF629uZ6cfMs1nddnz11x/yKeDYpupDz
	lSumJJs4nMgofcbqo1fKLlXTwvFlH9d6mQvPKbQfrflTTmgp2C8gYc44ACXcjol1Q2McXHAeKt6
	sijzWQiIQ5JIQ
X-Received: by 2002:adf:9ccc:0:b0:42b:5448:7b11 with SMTP id ffacd0b85a97d-42b5936794amr101003f8f.33.1763053745486;
        Thu, 13 Nov 2025 09:09:05 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE9L0Jg6AskUZXWnYwn6gelP1bYyscjDrqLTecoKo/5eOWbpBHBgNid5lGFZmjGYlVfn0Z0Bg==
X-Received: by 2002:adf:9ccc:0:b0:42b:5448:7b11 with SMTP id ffacd0b85a97d-42b5936794amr100976f8f.33.1763053745068;
        Thu, 13 Nov 2025 09:09:05 -0800 (PST)
Received: from [192.168.88.32] ([212.105.155.55])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42b53f17291sm4866386f8f.32.2025.11.13.09.09.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Nov 2025 09:09:04 -0800 (PST)
Message-ID: <2102ad3b-4f22-4da7-ac2f-7da0eba0ba46@redhat.com>
Date: Thu, 13 Nov 2025 18:09:03 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 mptcp-net 1/3] mptcp: fix grafting corner case
To: Matthieu Baerts <matttbe@kernel.org>
Cc: mptcp@lists.linux.dev
References: <cover.1762992570.git.pabeni@redhat.com>
 <4696be966622c9d340e8bfa4728b219b7cac1d1b.1762992570.git.pabeni@redhat.com>
 <49c300cc-e000-420d-82ad-aa59e5f1cd76@kernel.org>
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <49c300cc-e000-420d-82ad-aa59e5f1cd76@kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: HgUSjVDXZGnHrE2A_nf_c4oFKDu3Vx5819eIcYlYYcs_1763053746
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/13/25 9:47 AM, Matthieu Baerts wrote:
> Hi Paolo,
> 
> On 13/11/2025 01:10, Paolo Abeni wrote:
>> If a passive MPTCP socket creates active subflows while still unaccepted,
>> __mptcp_subflow_connect() will try to graft such subflows to the msk,
>> but the msk struct socket is not yet initialized at that point:
>> the subflows will misbehave.
> 
> What kind of errors were visible?

Found by code inspection, never replicated in practice; thinking again
about it. I'm no more sure this is actually needed: the subflow
mentioned above should be catched and fixed at accept time.

/me needs more coffee and thinking...
>> +static void mptcp_check_graft(struct sock *sk, struct sock *ssk)
>> +{
>> +	struct socket *sock;
>> +
>> +	if (ssk->sk_socket)
>> +		return;
>> +
>> +	write_lock_bh(&sk->sk_callback_lock);
>> +	sock = sk->sk_socket;
>> +	write_lock_bh(&sk->sk_callback_lock);
> 
> The build job failed because here it should be the unlock version
> (write_unlock_bh()).
> (and probably an empty line just after).
Oh, it looks like I shared an older revision, sorry.

> If there is only that, I can fix that when applying the patches.
> 
>> +	if (sock)
>> +		mptcp_sock_graft(ssk, sock);
>> +}
>> +
>>  bool mptcp_finish_join(struct sock *ssk)
>>  {
>>  	struct mptcp_subflow_context *subflow = mptcp_subflow_ctx(ssk);
>> @@ -3758,6 +3766,7 @@ bool mptcp_finish_join(struct sock *ssk)
>>  		}
>>  		mptcp_subflow_joined(msk, ssk);
>>  		spin_unlock_bh(&msk->fallback_lock);
>> +		mptcp_check_graft(parent, ssk);
>>  		mptcp_propagate_sndbuf(parent, ssk);
>>  		return true;
>>  	}
>> @@ -3767,6 +3776,8 @@ bool mptcp_finish_join(struct sock *ssk)
>>  		goto err_prohibited;
>>  	}
>>  
>> +	mptcp_check_graft(parent, ssk);
> 
> Is it OK to graft it even in case of errors in __mptcp_finish_join()?
> i.e. not in an established state or !msk->allow_subflows.
> 
> Should it not be done after the block below, if there was no error?

My understanding/hope is that grafting early don't cause issues:
- no UaF access to ssk->sk_socket, because ssk either do finish
successfully the join or is reset/delete very soon.
- no ref leak, because ssk does not acquire any actual reference on
msk/socket.

It's needed to do it in mptcp_finish_join(), to ensure that in patch 3/3
all the subflows will always push accounted data after that
mptcp_graft_subflows() completes - or more specifically the
`backlog_unaccounted` counter is flushed.

Let me see if I can rework 3/3 without this patch

/P

