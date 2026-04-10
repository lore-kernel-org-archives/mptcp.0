Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 139463A3E91
	for <mptcp@lists.linux.dev>; Fri, 10 Apr 2026 09:04:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775811876; cv=none; b=QFGWPdHL5DEXYr9xikkUZIr+YLoatXL/D3dGwWk5BKuw7scwhHrdpMgTRGQ5uhafQnJqaiyUsBSRoQoFNG3zl+FgWrK5M5eF3IO9ynq3ZBbO2RoNagXgcMOl69yhm17ZcrWOhTF3gq3wdhBnmlDrPBWBMg7ZzRgN7JVYvkuRcmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775811876; c=relaxed/simple;
	bh=9imxNANFha2VJMFJayzcvky6Oig4WXDw8rLoewE/OZg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WckwVlOm+khm6KS+2njRB5krr7dl2LwDMv7sm7TeGpR5F7DtmF/E+9bjm0rE7xMgJAnPRU2eEJVEVmw7n1t1EqpmuWWhnJPo1OCxjY9S8UifQ9oDfFKo6fcoQoowD0GaLmoa/q/jTKJ6jnUdEP/4e53dRdQkHQZLcK9gjrMkZr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ipA5YDNL; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ipA5YDNL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1775811874;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Y9wFpV5IlvMn1IEnwK7BNX+0h6SvZ89DwZ2CmvdTjiA=;
	b=ipA5YDNL4VVl/BOWV92fhQgz5rLBFB3lMjSFxFiE86eMAFdzRmIsItpCMMV6j+En574yOx
	juPe3LU2lNYLS/tcTpa0mXR2W3zFceVUp4Jizb6i7Gum9uoIb4o/AdPAjwDd0llfkEoQRG
	zBkB4ZKgPrS0/imt8m9I133Kss2wPnc=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-662-1y0RtNSyOGq4tdQRzwx_KA-1; Fri, 10 Apr 2026 05:04:30 -0400
X-MC-Unique: 1y0RtNSyOGq4tdQRzwx_KA-1
X-Mimecast-MFC-AGG-ID: 1y0RtNSyOGq4tdQRzwx_KA_1775811870
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-43d121c4271so1076507f8f.3
        for <mptcp@lists.linux.dev>; Fri, 10 Apr 2026 02:04:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775811869; x=1776416669;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Y9wFpV5IlvMn1IEnwK7BNX+0h6SvZ89DwZ2CmvdTjiA=;
        b=Qo+aijBJT/qDYCVpecnvKa9RdPJIz2QppLy62ls7dJBcXcoK/CWwqIlHHL0NgVLPRF
         /dt0R9OQBFLZ8Hd1UgJujURBinB328vk8Vk+BeUyQaZ7EVcE5WAGd/Q0+RE+37smWTkg
         YAmNu1bz6jvzRO45yjjdnyXTP5wtK793cx2sZrbQIOFHmNFOsv71egVLi5005FalYEeS
         g3JEn9L4svB3DguJIkobcWhqSuVEqpesn5XymRVQl4msdAqZoCozCVHOXqPZCiuvdQ/y
         01PwwI5z1sBHgYtd7wiX21gxnD45gTl5iKd/LbUo/HxDQOY+nolRrZ17Q0Ww/dwEjySF
         pyqA==
X-Forwarded-Encrypted: i=1; AJvYcCV0kUDNhwVGBPtlU+XX1LpEtCERtIUCtTHxmUEQv7SZ7rEd35ZEiUSSb6J+435mxDHJQefgEg==@lists.linux.dev
X-Gm-Message-State: AOJu0YzoZ4Sf6dPo94zk7oqJddzbFhBG8+oAyLxdYhKylAFv3330xeKS
	1ZwqIduZgnI0KT3ji4+CuRkN0MsubAX/BdC+kmOoGojkulw3cShcI1yILRmtXNueHK5TwDaWdtF
	sn9IOZQvhgH7aWVKD6RImH+uZ/KW00c8yZxLYE51qLplEKV5vKx1yzA9WZwErRMKB
X-Gm-Gg: AeBDiesN7+nwTRKCQmvxANTMlPpKirwujJJLxC8F3EinMafbuO7kwaAL50L06NQPewr
	lfONnzxqsHYZ3ca/sB9fyzkbKofKP2UGg5Imxq+zMiQAhQYY1Ip0BsugKWedS7kQP6thI70Z7nh
	BIjB8r3Qu8CssRp8HJunsPrW5QfXo+44UlOrbIPzmqWeXRXafMmb/rOA5ygE+70yTYMdjwnQCGX
	PKwBr+J+B947Xs1xLrxh6KSYq42eIBF+c80BdmcHpKnZdq2PwsJYnV467HxAmqoycfKIm5AAdyQ
	VxwA70EpD7qDFsOG5bIEFM74M5YCzPGA9Y2LeCu6fQVRlR1K6ELmKoNtADxDpikpaRYjy7bgx0B
	qjJJHsbxe/zwFoeIkvnFu+fQ24kHr9u4xzLq4JKL2vX7F6oEMovWPeEOA
X-Received: by 2002:a05:600c:c091:b0:488:a977:8d6 with SMTP id 5b1f17b1804b1-488d683662cmr18528775e9.19.1775811869268;
        Fri, 10 Apr 2026 02:04:29 -0700 (PDT)
X-Received: by 2002:a05:600c:c091:b0:488:a977:8d6 with SMTP id 5b1f17b1804b1-488d683662cmr18528495e9.19.1775811868850;
        Fri, 10 Apr 2026 02:04:28 -0700 (PDT)
Received: from [192.168.88.32] ([216.128.11.125])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43d63ab84cdsm6004237f8f.0.2026.04.10.02.04.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Apr 2026 02:04:28 -0700 (PDT)
Message-ID: <9b3a7675-cf38-4107-8c79-6ec7ccdbb2e4@redhat.com>
Date: Fri, 10 Apr 2026 11:04:27 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH mptcp-net v3 1/2] mptcp: sync the msk->sndbuf at accept()
 time
To: Gang Yan <gang.yan@linux.dev>, mptcp@lists.linux.dev
Cc: Gang Yan <yangang@kylinos.cn>, "Matthieu Baerts (NGI0)"
 <matttbe@kernel.org>
References: <cover.1775551182.git.yangang@kylinos.cn>
 <79d5862da1c7db353e27c56a26da78e6dd548659.1775551182.git.yangang@kylinos.cn>
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <79d5862da1c7db353e27c56a26da78e6dd548659.1775551182.git.yangang@kylinos.cn>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: Denb-cvF3By3jgkLPnri3WRYA5DtKS0NxDCHuWpsjlQ_1775811870
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/7/26 10:45 AM, Gang Yan wrote:
> From: Gang Yan <yangang@kylinos.cn>
> 
> After an MPTCP connection is established, the sk_sndbuf of client's msk
> can be updated through 'subflow_finish_connect'. However, the newly
> accepted msk on the server side has a small sk_sndbuf than
> msk->first->sk_sndbuf:
> 
> '''
> MPTCP: msk:00000000e55b09db, msk->sndbuf:20480, msk->first->sndbuf:2626560
> '''
> 
> This patch synchronizes the sk_sndbuf by triggering its update during
> accept.

I finally could wrap my head around the root cause: tcp_child_process()
-> tcp_init_transfer() -> tcp_sndbuf_expand() can and will grow the ssk
sndbuf _after_ tcp_check_req() -> subflow_syn_recv_sock() ->
mptcp_sk_clone_init() where __mptcp_propagate_sndbuf() is currently hooked.

I think the latter __mptcp_propagate_sndbuf() invocation can be removed,
and the commit message expanded to capture some of the above.

With the above included feel free to add:

Acked-by: Paolo Abeni <pabeni@redhat.com>

