Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32A983093C4
	for <mptcp@lists.linux.dev>; Thu,  6 Nov 2025 08:58:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762419500; cv=none; b=iqcBSjE3bujmdL2vU9tUvA2dloViSP/tr2eWCOTbGdVLoCb44j3mamqewtVozAHZey9cVJt3SImZUXsPyRzbmydoAeEMawQ0BiLC3e7hl5F7eHhpT30VKUDlAI0MQxhLNZzmaZeKhiRaJM0vztZOUe+TY5ScwGeVsw0DgQqqdDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762419500; c=relaxed/simple;
	bh=O8HjjgLmkctR8Hhw9/hRGywZdLN/3LkqXx34iLxmUR0=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=GMCE1BCuUgSzqLgOvnnbZankjR2jOt5CColScm9Xr9VN2ZIJt/FiA3EdfkfbTJx9cYB8X23uw2T2/zDT6U9LYQWkLzTYJ+2Nnfy2CfIozdnTaZJDJLp9PkE8pLkjyjMqCBJHSlzdV8nGlarfitnqzBOWKZQHDSRpX5ObniK0ItU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GC7FEKkm; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GC7FEKkm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762419496;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=z/IRyDzeBsnSaH/MkBd5UXmOUwhtnFVZqgbvlZPaZwo=;
	b=GC7FEKkmQSPmhIH9MYjiPy40lO8Ix+KOVcKb2OiJZy76+AoYJz7zQtdV8+F+ZywcDMOExd
	YlZNMgKdTFzI/+plHQkqCjJ+7JopEhjRzXmheP+FVUBcS6RjKleTO5TpIsxhBiCrKDmAEp
	UpatWdIviiDaaV3w1x5PAg3kzg/DFcQ=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-494-mmRSwrUyNhOnkw1ZgT2E6A-1; Thu, 06 Nov 2025 03:58:15 -0500
X-MC-Unique: mmRSwrUyNhOnkw1ZgT2E6A-1
X-Mimecast-MFC-AGG-ID: mmRSwrUyNhOnkw1ZgT2E6A_1762419495
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-477212937eeso4102525e9.2
        for <mptcp@lists.linux.dev>; Thu, 06 Nov 2025 00:58:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762419494; x=1763024294;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=z/IRyDzeBsnSaH/MkBd5UXmOUwhtnFVZqgbvlZPaZwo=;
        b=gBJkNpIcA3ePEbpIMYpJZ31M+8y+BCquiYgO4NabjK5V7SWTfqokrZE08mTy3WbFrR
         7kgy8sfHTPXaD/rZIVdllO6tbujkvGoyd2GOVeu3WibOWQqiJ/hOVPuNcNsC7pVVbzpU
         MduvYn+/y/Sat1P2wl8XYF++fyhQ5Sf9+57xmEtCk6LGkgnC3Z5Wq3xcEMmqOlpK4xrS
         NfMGTMjMrtjIUhf12epj93xTsGXoBwym8Uv2WUxkvia15CBSehQ6DzLFk+j6iR1ngj7w
         HgygiT53SWvYMGOvoRJAn5A93L6N21ef1c9bak8eE05WPjH+a2LCKxhxUedIO/ATviwe
         q0Tg==
X-Forwarded-Encrypted: i=1; AJvYcCVD5C5jHkxPJrg6uGQyLX/X40zxXwE+XUquQlhxP39fI3dSl9Tl3LJKZA56Cs9qhYHyZzmswQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YxehOooPtnNacWxMSNFzK8pAvK/QQ9R3hgIS0kPObEg5Xwlmqwv
	VTBb81J38iNFuOA6tW1Cgl5e7u2/EXQkdGj0WAMI3R41E91Zniins5ZjQJHYMY7rSPH7sDMsQrF
	YUlgFuc7xO818z3roCe/2hMJPNPrU8hC92YXDDPRwmzwW/EsXm34UySEKP1PCVHEB
X-Gm-Gg: ASbGncvtR+rAWA9llv3WNRzYS3m8PVhjJoYYoOHXWSfuJEDzQA3vHk58sSz29mxC4bX
	uoGz2knA2go6zNlYbBKHgiUyRUwUXBMB45DVy0i34XcmPBaaopyOKGvX1XfTE/yUIhX4dOGG9Vc
	CZZML06sYnpgxKZsvW3IW9EUI/on0YQF1kMSjcYYikmKIOMCHM6S+tVGvA276xkQcf8TE0cOm56
	YPu65veqdKP/INfuoPou38/8FhDzkOaLtLi6AFgbhFSfjvso4PSiT/B1sbkSMt03z54u4Fd8YVv
	z25kbjaFNOq1dp59YzS7J6ziuOUVywume7iFx5ZIFzrMWqBQOzqJP/MZ++95WVvzWDRG0UzpUUl
	CRQ==
X-Received: by 2002:a05:600c:1c90:b0:477:589e:6c2f with SMTP id 5b1f17b1804b1-4775ce1eabamr59458825e9.22.1762419494151;
        Thu, 06 Nov 2025 00:58:14 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGdtKyvRnzJgMM95y092mh1QefSfWJrbJE2D8AGqmsBx+QlbTeo8yK1tNvpF9a3L7Tu6JUDWQ==
X-Received: by 2002:a05:600c:1c90:b0:477:589e:6c2f with SMTP id 5b1f17b1804b1-4775ce1eabamr59458575e9.22.1762419493759;
        Thu, 06 Nov 2025 00:58:13 -0800 (PST)
Received: from [192.168.88.32] ([212.105.155.83])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-477624f86a2sm35136695e9.6.2025.11.06.00.58.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Nov 2025 00:58:13 -0800 (PST)
Message-ID: <7cbc79de-b766-40c3-92a6-731755e64690@redhat.com>
Date: Thu, 6 Nov 2025 09:58:12 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH mptcp-net 2/2] mptcp: fix duplicate reset on fastclose
To: Geliang Tang <geliang@kernel.org>, Matthieu Baerts <matttbe@kernel.org>,
 mptcp@lists.linux.dev
References: <962efc0fd760155328967f4023a899e520e6f9a7.1762354419.git.pabeni@redhat.com>
 <0395b95bc89964254ad9a10a9e6da9fd58b6f7a7.1762354419.git.pabeni@redhat.com>
 <a778abeccfe59b89cbd92b892eb310dd8a6db79a.camel@kernel.org>
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <a778abeccfe59b89cbd92b892eb310dd8a6db79a.camel@kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 3xx8zclnwdBdYJRERUB-fVUAsVtMqG2tfAoGIEIUYNE_1762419495
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 11/6/25 8:56 AM, Geliang Tang wrote:
> On Wed, 2025-11-05 at 15:54 +0100, Paolo Abeni wrote:
>> @@ -2762,9 +2755,26 @@ static void mptcp_do_fastclose(struct sock
>> *sk)
>>  	struct mptcp_sock *msk = mptcp_sk(sk);
>>  
>>  	mptcp_set_state(sk, TCP_CLOSE);
>> -	mptcp_for_each_subflow_safe(msk, subflow, tmp)
>> -		__mptcp_close_ssk(sk,
>> mptcp_subflow_tcp_sock(subflow),
>> -				  subflow, MPTCP_CF_FASTCLOSE);
> 
> It seems that the MPTCP_CF_FASTCLOSE check in
> __mptcp_subflow_disconnect() can also be removed. In this case, the
> third parameter "flags" of __mptcp_subflow_disconnect() will no longer
> be useful and can be deleted as well. At the same time, the
> MPTCP_CF_FASTCLOSE macro definition can also be removed.

You are right! The patch is actually bugged because it should check
subflow->send_fastclose instead of MPTCP_CF_FASTCLOSE.

[...]>> diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh
>> b/tools/testing/selftests/net/mptcp/mptcp_join.sh
>> index 4faf58fecc94..663ea9ece31d 100755
>> --- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
>> +++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
>> @@ -3646,7 +3646,6 @@ fullmesh_tests()
>>  fastclose_tests()
>>  {
>>  	if reset_check_counter "fastclose test"
>> "MPTcpExtMPFastcloseTx"; then
>> -		MPTCP_LIB_SUBTEST_FLAKY=1
> 
> MPTCP_LIB_SUBTEST_FLAKY has already been deleted in the commit
> "selftests: mptcp: join: fastclose: drop plain RST". It seems that with
> this patchset, "selftests: mptcp: join: fastclose: drop plain RST" can
> be reverted. Is that correct?

Yes, the idea is that "selftests: mptcp: join: fastclose: drop plain
RST" should be reverted.

/P

