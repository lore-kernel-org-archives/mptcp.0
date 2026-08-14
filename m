Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC32E44AB70
	for <mptcp@lists.linux.dev>; Fri, 14 Aug 2026 11:07:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786705629; cv=none; b=QQPr4wOrR6Bg7uHxkZ/zvU3zgA592a2ccclutESywqj8ATuCTIRLx0Esx+yJWbiwkM6rYVmYIxsm5pcM3p98aEPaEDd92WxMUAn8BSELQwtqDHm3A8Xi4cPZ2e1RSsrdjn6Ie73Brkkl7t72JzCktQFpiVK5PQxOW3AEgeD/cgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786705629; c=relaxed/simple;
	bh=x0HqK0iDFKTS6zM6ODp8XlFr7wYyxoWPhPNMUuLvEb4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QkKqLWgspW4C+LQBvciNiVUk0OateZB1gXV1qHQv6WepexHUjcw0PxPeqPynbqZoPIkpU4ktYLqWpUkJWR9jUpxqtV6emj2bGCnuvOoDJm/D65AdliOVhNmPFVfWchK/Ws+rweLcEzM/IrFUGdjo5m8rmevwYTSo7tZ3KStY3Q8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PQIzCZtW; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PQIzCZtW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1786705617;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=szCD2wEJqr3QFsnYzhlgVK3W/w6IENGU1GBA3BW14mc=;
	b=PQIzCZtWwdIErtvlCMtDcu4M6xwTVBQjjNNZ+T2zM91+mlz3Wf3TouN1b1s+Upzzbcvs0T
	gUIfVHfkOMbJMAV8nILMXB3bUOruWMwDMdJVQ/e3Zxq3Oh89J2RlGgnKklD2T/2+DaMcbR
	rbvhr5+Jtw1kOX2VIWtu1Q5U2Zk6nx8=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-287-6WbPG6YGMdiAggkl9m_iEQ-1; Fri, 14 Aug 2026 07:06:49 -0400
X-MC-Unique: 6WbPG6YGMdiAggkl9m_iEQ-1
X-Mimecast-MFC-AGG-ID: 6WbPG6YGMdiAggkl9m_iEQ_1786705608
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4957287363bso5217665e9.0
        for <mptcp@lists.linux.dev>; Fri, 14 Aug 2026 04:06:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786705608; x=1787310408;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=szCD2wEJqr3QFsnYzhlgVK3W/w6IENGU1GBA3BW14mc=;
        b=UgQNDox6JWpxrjgu+LGMq0oqSr2Al4unWvCMnQjRMH7Vinz1NZM4CEZgG4yJmpxaRt
         sArXZTm0ZMku81wL3E/0GKn4Al+sYHMfPAhqzYhYDBJsdKK94jCxELfRUFWbGHMxwIAf
         EpvDQobMnoEaDhMChM0ZCv75HPMhS9XAuWvAtApRF1+PJa8PyJccqLlrRMTzZFXNJ8RA
         KFGqboJjz1STkHyWDuCmJdb60jS+LS7LZiZZjpTnTPbnnDKpOdVM7Lx0eCCe7i4aZNiI
         qH6WX5+/8vBbt/YFciLMJKZUYTrtbw8yjizyNYq0Gxz2aUC4ZHls9HKVxhyniAhoASra
         Ve0A==
X-Forwarded-Encrypted: i=1; AHgh+RoJVOJ98s3Dy4Xm6ja1qlujS5qcmsjqiP/1rkMD7rPH0UQrzxSPkF7Lo/SwlAX8+/Nrv8/9bQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yx9twcx85MWP2iiDOHUCJQjFTu+wuxQ5b9fsgFDJ71V3HOY0/O8
	8kTnAs/sl4EVf7gMzMzDM9/nTSeZHMj3gVLGplwXA6sbuNoy5b6GFb79vGwsOSZC8xxRPA5DrB9
	E6zPQMm+pSXf2PEj4T1naSjbsicm4Ko91J1d1/IU4Cxbui4/3pULA1r/N
X-Gm-Gg: AR+sD12qPzCltajiExoWgNUzk8u5ukAWGEkjMeea3uwiSu9kldRcic8495IDuzSwpVr
	+/H4TxayptglG+3ru/Hi5mPdgOZGqyRX6Pgkzf6DAuLgbFTi8vFKM5Z7ogmcaCZH3tkzQRrxBJV
	gc6ag/4kGqNeTekwy3Bwuv/A0dgXRB2AhSdDM3QVxKRsShD/39b61n9w8zPtVNxI0tpnbuWZ3bZ
	q/QUo/wF8EJWTZ/1g+EI5D6i9QZm44jrPdYciXOofft9msqfx7Ur0yPzgeWTVPPjIlM45xAQKN9
	ASR2Y5LBLu+l+oE7c/gh90kwKkYnkmrm/2Jy4M4fk+aLokju18gonr/RPXMdvLOTckcEHPub9Rk
	zyjN6bzor7QkEH+jWZEaWvA+8Kq6Zh2bFmkbmGh9+IY19PA9BbXmv9Ii+GO+hfUgKfm00gCnH3m
	s=
X-Received: by 2002:a05:600c:698d:b0:493:aa0a:45ad with SMTP id 5b1f17b1804b1-4998792e4f3mr72289075e9.2.1786705608371;
        Fri, 14 Aug 2026 04:06:48 -0700 (PDT)
X-Received: by 2002:a05:600c:698d:b0:493:aa0a:45ad with SMTP id 5b1f17b1804b1-4998792e4f3mr72288185e9.2.1786705607839;
        Fri, 14 Aug 2026 04:06:47 -0700 (PDT)
Received: from [192.168.188.103] (ip239-44-231-195.pool-bba.aruba.it. [195.231.44.239])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-499899b5f86sm21728715e9.5.2026.08.14.04.06.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Aug 2026 04:06:46 -0700 (PDT)
Message-ID: <8f69b636-57ff-4f1b-a562-826306ab23d3@redhat.com>
Date: Fri, 14 Aug 2026 13:06:46 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH export v3 2/4] mptcp: reject joins after fallback in
 mptcp_is_fully_established
To: Matthieu Baerts <matttbe@kernel.org>
Cc: Chenguang Zhao <chenguang.zhao@linux.dev>, mptcp@lists.linux.dev,
 Chenguang Zhao <zhaochenguang@kylinos.cn>
References: <20260812054653.43799-1-chenguang.zhao@linux.dev>
 <20260812054653.43799-3-chenguang.zhao@linux.dev>
 <1d7c56b9-00c1-4550-a403-c3d704259267@redhat.com>
 <41078a8c-00c7-4cb1-8e57-237b4ea6c2f0@kernel.org>
 <643936d9-5da2-45cc-b108-f7c2e7785044@redhat.com>
 <a52da320-e6f2-4ccb-92ca-7ad28ebd49f2@kernel.org>
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <a52da320-e6f2-4ccb-92ca-7ad28ebd49f2@kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 3Nu-Tet6QKWO852Va2LBM87ORjMm5gpkW6IMbZ2Gb-0_1786705608
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/14/26 11:09 AM, Matthieu Baerts wrote:
> 14 Aug 2026 10:43:41 Paolo Abeni <pabeni@redhat.com>:
>> It's not clear to me what actually goes wrong and how. Do you have handy
>> a event sequence or stack trace demonstrating the critical scenario?
> 
> Indeed, better with packetdrill scripts:
> 
> https://github.com/chrisocean716-star/packetdrill/blob/bf9be7a7bee3687500444b284a9db2a0009a5252/gtests/net/mptcp/dss/dss_drop_after_data_fallback_server.pkt
> 
> => A fallback is done, a subflow can be initiated, then rejected.
> 
> 
> https://github.com/chrisocean716-star/packetdrill/blob/fed57fab92c407eb433acdb8c8ce72bd8e3e2f37/gtests/net/mptcp/mp_join/mp_join_server_after_fallback.pkt
> 
> => The MP_FAIL is partially ignored if received before being in fully
> established state.

Thanks!

I'm pretty sure there is a miss-intepretation of the 2nd case. The
problem is not with `msk->fully_established`. AFAICS
msk->fully_established is true when the MP_FAIL is receive.

The passive msk socket sets it at MPC ACK reception.

The problem is that, at MP_FAIL reception, the infinite mapping is not
sent immediately, but it's scheduled with the next xmit, and until such
point the msk does not perform the fallback.

I think a proper solution would be bounding MP_FAIL (reply) and infinite
mapping in the same ack.

As noted by Gang, it may require a new helper (build on top of the
tcp_send_ack).

/P

