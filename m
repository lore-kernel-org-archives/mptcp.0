Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EA99391833
	for <mptcp@lists.linux.dev>; Wed,  4 Mar 2026 09:07:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772615231; cv=none; b=NGdc285z4eanbAKVTP95RErKsQ00YYUL9S5c7ycIY6MjVcSTD9Ke9AAiKxN5RMkz5zHsdsg06734YcFrPT5BGm2b2ejY5NcRdZOq3mmVwEUYX30B2rCutaozhnShcsVqtLCsWz0f5iwmQPUUF2LFlOFkqB/SM+VpFRx6qa6PfHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772615231; c=relaxed/simple;
	bh=MenES2bnD3YIFT8HkiuN9URfZnWIKlc//r8AacAz8MY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qywaMZLJN4h8oHQUdmpMayr1pDxXhRz2UKv6gCou8Xfzl/2psi/6GFPHBCZED7SGFbKqv8qFxEeIDd8+IQ47MMnFZ/Yz9vGySagzp4uR7zBCBbz2eTgDfJMdNxnNNetK2qTYVczSLVOm9H47sH6UnK5i9RoJ/q6enB0O6O6Qkb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Lcw9Zhac; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Lcw9Zhac"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1772615228;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qJ+svJhZviY13V6jetu+2Lop8pt2Tw6oU+fGIcexD3k=;
	b=Lcw9ZhacHRnJ4Mi92ZqnQy6x1eixD8GrUDdJk85td5pcsYoUDeRrVFuWkb2EElflmFGUAP
	hECxvRVxXZ+rG3meDzfegX7FIryeGIfYnLYOGfuQ46qpyRz0CTofsfkC270+sXRUaclYnS
	a29yWGnHY6lc7R7X36BZPwTml6AkXvw=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-398-fdI6VZvAOoOIfUQSCNrVNQ-1; Wed, 04 Mar 2026 04:07:07 -0500
X-MC-Unique: fdI6VZvAOoOIfUQSCNrVNQ-1
X-Mimecast-MFC-AGG-ID: fdI6VZvAOoOIfUQSCNrVNQ_1772615226
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4836bf1a920so71783255e9.3
        for <mptcp@lists.linux.dev>; Wed, 04 Mar 2026 01:07:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772615226; x=1773220026;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qJ+svJhZviY13V6jetu+2Lop8pt2Tw6oU+fGIcexD3k=;
        b=D93RkbdrSHOzah7w15Pqgfu0+RWCUVmrUYxdS3DaZnXMiQGvo6p8c2BzJYSwJqMa8n
         3bUcH5OPI3yiwYYm+F5KCCFhwcoLvqZOF3wsgYQOszLAusz2eFokQCD5qLgHc781eEDq
         46Npuz1YXWCk8WCD8FH9m7dWxpEBoxM43giQwPJ3S6UpPDalp3pKh/zjFWarhpUwP3ue
         ITMpZKIKD1f9UcDQ15261PI0SSNpEfvQPsGzOGeOpX+gEZNZ+2EwVoSI0v0PYL8Gls9K
         H40Dk8VMwO3dLvB1F9urbRaZxJ9EgH0VwQfRCW7d0b+kAJG5xik7yMBYFNLsymDr9wK/
         5Bgg==
X-Forwarded-Encrypted: i=1; AJvYcCWTc94c9KkAj21PBAepU2PrLnQ4cDNUl9YQXhhjbTSjsOFB8XdfuSzTCVMxkehptbz0Op+gOw==@lists.linux.dev
X-Gm-Message-State: AOJu0YwGf+NVQznojlXC0GX40ao876k7iQswmHf65vzMU40Qi/RCN3sG
	MJGm+WqJ4GqTERHEr5J5DqKkOLWYVYCjB/Lx/7AYuvdeU7TJSHmn3k7codSBIDWpukaWgRwAdkA
	MHWLeAt/qdnQR5x358eCyolVIrzFbubv40hDEwdivj9lXs/hGgOcJk6OI
X-Gm-Gg: ATEYQzx1ycZMZR+ePzfuLveXGSVshmo3OvessPt0pxu8EGPVjAkzFTV/zCBqORe17IN
	Pp/o9nmLETj7F8ycd7bsWA0szJj5H/gyGvUCJ7LM2+n0dQTGcIaMtY1xVUZQl3BvbJP11lIhdC7
	6gd8t/Nk874+eoSnvvSO8mhMqHL+OW9BAaTJiQaBTpw9jPpFuWuaZxtkNrogKF0tPfw+BPWCdGQ
	RDh/a+1FFhHf64VwBAO5/dr8AwPeCoEyt6HtlbkWSToZi98DHl79ZYL3Gg5TR0EcR52cFAWTK4X
	YcJFQ50+ExKVBcmq3zXQ9E2oceExQVzQm8CTj4dNv7F3pCi7hrlh4SJ103OraFhIgD7XeIr9dF1
	rHh4dKvfMwEIBcf4YjCL30FY5oQ==
X-Received: by 2002:a05:600c:608c:b0:483:bcff:7948 with SMTP id 5b1f17b1804b1-48519847972mr20302045e9.10.1772615225918;
        Wed, 04 Mar 2026 01:07:05 -0800 (PST)
X-Received: by 2002:a05:600c:608c:b0:483:bcff:7948 with SMTP id 5b1f17b1804b1-48519847972mr20301505e9.10.1772615225458;
        Wed, 04 Mar 2026 01:07:05 -0800 (PST)
Received: from [192.168.88.32] ([212.105.149.216])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4851aceb94dsm6878875e9.4.2026.03.04.01.07.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Mar 2026 01:07:04 -0800 (PST)
Message-ID: <64132462-e640-4ea6-82e8-48ca07a6ad44@redhat.com>
Date: Wed, 4 Mar 2026 10:07:02 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] mptcp: fix soft lockup in mptcp_recvmsg()
To: Li Xiasong <lixiasong1@huawei.com>, matttbe@kernel.org,
 martineau@kernel.org, geliang@kernel.org, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, horms@kernel.org
Cc: netdev@vger.kernel.org, mptcp@lists.linux.dev,
 linux-kernel@vger.kernel.org, weiyongjun1@huawei.com, yuehaibing@huawei.com,
 zhangchangzhong@huawei.com
References: <20260302052651.1466983-1-lixiasong1@huawei.com>
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20260302052651.1466983-1-lixiasong1@huawei.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: DxmTy1r-gOPQ86Wki1oWfQsv_o-lNgiwbZEb2u2Z_xM_1772615226
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/2/26 6:26 AM, Li Xiasong wrote:
> @@ -2343,7 +2347,7 @@ static int mptcp_recvmsg(struct sock *sk, struct msghdr *msg, size_t len,
>  
>  		pr_debug("block timeout %ld\n", timeo);
>  		mptcp_cleanup_rbuf(msk, copied);
> -		err = sk_wait_data(sk, &timeo, NULL);
> +		err = sk_wait_data(sk, &timeo, last);

Isn't
		err = sk_wait_data(sk, &timeo,  skb_peek_tail(&sk->sk_receive_queue));

Enough?

Also, could you please add a paired tests-case? Thanks!

Paolo

