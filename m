Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4722B24EF8B
	for <mptcp@lists.linux.dev>; Wed, 19 Mar 2025 07:38:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742369926; cv=none; b=diOQ9XwTbfh8cJ2DK0sylsXtFzV1jHY0ifkX3outydRTsK1O9nxEky2Gp6Lqk8dJ8jCXQL22vu/WJKaVZSQQ8zSy8tOwy79/2VkvVENA4lLLRQjfz7IY3Tq7hjOsP1ZYFbCmuVyQA7ZqswJnm02FlqnsN9Cwz+32VWMQ2li/PuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742369926; c=relaxed/simple;
	bh=2hPfWjdac/d9BjRh+E5VRMJfLM4+W42x3XZe49E50+s=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=uKzV2Bs3kUvkGDBhRdKwwC382s5tNzv9/x+M0X+tPCmHC7uDjpUgElGnSpzKHpYSkL+7LUIj3wtYvGxuskmn8rHtd8wsAFneDxcnns5Sltv4npSPy0oww+C+G3KKc1uys0s0S5Z9Myje63v1k8okAhZSwxMQ4ZlQDE/al4youoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gSMXIYmM; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gSMXIYmM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742369923;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qCH5Fb4UAQ6lTSHXL/dUUax0faEHFK7ijRJACqleApg=;
	b=gSMXIYmMTqxREQrC+EY8KGTA3Awh45Q7EB6vQ809amTV12zwo5RQFUsmHNnnghPNjpinOB
	rqufzpkJwSsfjttTorQf0f13MbcvpZJNPuwyXQ/QK+lmcU/cEAZ3aIU5x0994kydCwo6kn
	vNbBRs+Z4hTzreCZhWjuBc/aGrsthVU=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-134-KZbgzH6tNxSyuZDIEa1m6g-1; Wed, 19 Mar 2025 03:38:41 -0400
X-MC-Unique: KZbgzH6tNxSyuZDIEa1m6g-1
X-Mimecast-MFC-AGG-ID: KZbgzH6tNxSyuZDIEa1m6g_1742369921
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-43d00017e9dso25534605e9.0
        for <mptcp@lists.linux.dev>; Wed, 19 Mar 2025 00:38:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742369921; x=1742974721;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qCH5Fb4UAQ6lTSHXL/dUUax0faEHFK7ijRJACqleApg=;
        b=KYEAb/rN6SgLgI/Q2ZkgHCxX9JywPdNok5LF/LA/dxHs/SRU2+kbviMehsNj/MdVuk
         16ZXVFH9K+VSCK2/KTur6gH8OX1vzpg3aqWdgdYBXDfjWpDBsAS07Hipwl3QHuQ0fAL/
         PTmDbIyjvQ3d2L46kmI4dhGHARR+M1ZJ3FYHHz+MRHdH9TMEGnOPz6in/Dk2ybn0ViEs
         vogRK1cEJMhrIdv+w5NkYNFvoeEv/Q5UBZRDClci+N6RbWtsPlzDw6mfzcNYqz8Q/MEH
         WBo4mgHP/FqVbKpSgEWMND23ySEprCVpgzyIZRXy6d4VWRU5cu4kHxignERpYi9dowhF
         iVNg==
X-Forwarded-Encrypted: i=1; AJvYcCX6Djc9Zj6TwUG7z/qq8w8fqRyv3noiSwHqH8NbeOWOl8JNOyTp1P8pHn5dU+uUaQvNQYVUcA==@lists.linux.dev
X-Gm-Message-State: AOJu0YzI5QmH0y98S9ENjBDLGxG0/AuiiL6v4X6PW7BGCTfx0xp9nc8n
	u0sZ/nF9eVXrV5U1ziu/5RmvbOSYuAB8Nwl8dleQVI23cpM0uvQ9BRr/rvxG73LmiSaR333G/t+
	ppqjybbSdyP4wyBur3Wcjk47eJ2djWpH1hTZmwTWXBXGkU5UF1a67
X-Gm-Gg: ASbGncsk+Fe1TT6yq2LLGsGW5V5mV6BGi/yfo64bBQmdzMD4jgjiVaiSRDQT36WWeie
	pHaN4KWvljkDPugK3hcfDdNh+1KY3oba6Jsjd2L1EHkfSccINbJXeZEysDId/PzDjRNhk3iFKod
	+Qz/LpnDJgEzF7yoKNitO6/dzWFqxQ0INLMl7OU44gKVhlQ+RwZ4Nv5LpRl0dk7+LvH6039/rq/
	Tazdo1lIUiv5x0vFT0wghxi7vj6Ku2tmsV7/KTxNKpyxMWDlQdxNf1JdgpgpZc91lNDZZPvZ5pH
	jmZ5NLqp6vvPWfxPl2bMuUFo3azqBBu5RFlP1JvoJR78TA==
X-Received: by 2002:adf:e00d:0:b0:391:2c0c:1270 with SMTP id ffacd0b85a97d-399739bc457mr1124225f8f.1.1742369920568;
        Wed, 19 Mar 2025 00:38:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEt6/afB88oekGZNUYNYje0tfnIAbjfrppFCIJtl1oRSMqpjCXIeyD09FxeYvFRAWM73XpWKA==
X-Received: by 2002:adf:e00d:0:b0:391:2c0c:1270 with SMTP id ffacd0b85a97d-399739bc457mr1124203f8f.1.1742369920090;
        Wed, 19 Mar 2025 00:38:40 -0700 (PDT)
Received: from [192.168.88.253] (146-241-10-172.dyn.eolo.it. [146.241.10.172])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-395c83b7656sm19777218f8f.40.2025.03.19.00.38.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Mar 2025 00:38:39 -0700 (PDT)
Message-ID: <480b189d-af0b-4af4-8abd-5ebc6873255a@redhat.com>
Date: Wed, 19 Mar 2025 08:38:38 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [mptcp-net, v2] mptcp: fix a NULL pointer result in panic
To: Gang Yan <yangang@kylinos.cn>, mptcp@lists.linux.dev,
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
References: <20250319022733.51444-1-yangang@kylinos.cn>
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250319022733.51444-1-yangang@kylinos.cn>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: jXbDmhoX7IzoqOk6Ow5Knxcwkwt1_TGX2VJAiuaXqC4_1742369921
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/19/25 3:27 AM, Gang Yan wrote:
> When test valkey in mptcp, the kernel will panic due to the function
> 'mptcp_can_accept_new_subflow' when the subflow_req->msk is NULL.
> 
> This problem shows in kernel 6.11.0-rc3 and 6.14.0-rc4. The message
> attached is valkey_test in 6.14.0-rc4:
> 
> Call trace:
> mptcp_can_accept_new_subflow (./net/mptcp/subflow.c:63 (discriminator 4)) (P)
> subflow_syn_recv_sock (./net/mptcp/subflow.c:854)
> tcp_check_req (./net/ipv4/tcp_minisocks.c:863)
> tcp_v4_rcv (./net/ipv4/tcp_ipv4.c:2268)
> ip_protocol_deliver_rcu (./net/ipv4/ip_input.c:207)
> ip_local_deliver_finish (./net/ipv4/ip_input.c:234)
> ip_local_deliver (./net/ipv4/ip_input.c:254)
> ip_rcv_finish (./net/ipv4/ip_input.c:449)
> ...
> 
> According to the debug log, the same req received two SYN-ACK in a very
> short time. (When the client retransmits the syn ack dueto multiple reasons.
> Even if the packets are transmitted with a relevant time interval, they can be
> processed by the server on different CPUs concurrently). The 'subflow_req->msk'
> ownership is transferred to subflow in the first, and there will be a risk of a
> null pointer dereference here.
> 
> This patch can fix this issue by moving the 'subflow_req->msk' under the
> `own_req == true` conditional.
> 
> Suggested-by: Paolo Abeni <pabeni@redhat.com>
> Signed-off-by: Gang Yan <yangang@kylinos.cn>

The code LGTM.

Possibly the commit message could be expanded noting that the !msk check
in subflow_hmac_valid() could be dropped, because there is already the
same check under the own_req mpj branch.

Also this needs a Fixes tag:

Fixes: 9466a1ccebbe ("mptcp: enable JOIN requests even if cookies are in
use")

Matt: could you please adjust the above while applying the patch?

Thanks!

Paolo

