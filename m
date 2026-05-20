Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ECD93AF678
	for <mptcp@lists.linux.dev>; Wed, 20 May 2026 08:19:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779265174; cv=none; b=kNbyxK16P6Vd0OTfRnFtFA+425ndFyxE1ENBwLse3iTRCxHeeCsrU+ou2DGJP3H+eXqsSznOjJ1UD5kJy2c9HZ3C39JWV0RI9P3mgj75ifk08Z9KzFv61t1NNOX8PGVUEieFQ3jvRC2DX4wZRjVY6nu9iLSFOc97J9RiHf0+QL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779265174; c=relaxed/simple;
	bh=eR5Lv6/5aIUbZd9lZvmD7vRmfx4VYOEe+++dY1SAZ78=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fcqWzqbk50eiIvGbPUzfBZKWAhxeGMonZWK9J+Mcgsc6PAxKR+1zmASi5gXySVQ7oWhZBj/tiCrA0UbTndsrdiqPQfNTQjKME8Ir5RNhAbEcv9q1S6IG5SjFePXCxAt86FRHLacmF3RYfI2HAkKq3mNDdznDhJr/30zgJ+OF1K0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SYepq/8o; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SYepq/8o"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1779265171;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mftZB/6L0HviNbkfnf9d/CDhKlPg/UyNoJjXGNy6dMM=;
	b=SYepq/8oSJzV10DYKj2lDyN3hXQWYfDXzQPuBOgYKgFmAKmdz63BGO9OWRE1zyf6VjMb1N
	fSCf+w+EuhQyHjMW3z5704wYz3QaO0FpQ7TdqEFfY0aKI9onvCi2R2P3ZFATMd3wWbZs3+
	wffMjKW2nLaiFC6TBNtjtJDrn3Zhl98=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-622-xtkj7H8APmCaZJZCFNLcng-1; Wed, 20 May 2026 04:19:29 -0400
X-MC-Unique: xtkj7H8APmCaZJZCFNLcng-1
X-Mimecast-MFC-AGG-ID: xtkj7H8APmCaZJZCFNLcng_1779265169
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-48919890a95so23903585e9.2
        for <mptcp@lists.linux.dev>; Wed, 20 May 2026 01:19:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779265168; x=1779869968;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mftZB/6L0HviNbkfnf9d/CDhKlPg/UyNoJjXGNy6dMM=;
        b=N151kxpV+i/n/yCCx0j+/98w/5+wkYEPlSaynDqlUPpwCh3CATXD9wcFwkDDWFB5bV
         GqZz5xYPhF4p/f9eKL17LkUg47oDKWmFFdOiv3fclyrhCl3KjvdMyIGj7a03d+HVWB7Z
         vf8Uk7DyvCH5wudUuJdG2rBFReapQT3P5hkkw9yZfznxABlb3B+4bbXLIXaStX30CCfK
         QYQqewnfTc79JLRUjxFuVqZKGXVVxBPEduX9lwpvyxWP98pgMM5WbkkEL5vSIfEQ+pGD
         EfXpsAkbmTiysbINMJiy35daO/0m4xSwX+SlKdO/26VX5YrkBSx1FZGs94gHfzRqmNj/
         6OVQ==
X-Forwarded-Encrypted: i=1; AFNElJ/vnrLa61CMlSxDrKFiPlNYERLzwtmtvAyEIdMBzYgI+GWQc3z0fn7f7hL6zUM3HcXAzVEYOg==@lists.linux.dev
X-Gm-Message-State: AOJu0YzV0Amzs5Zvo+eUC40uEIT/+kl2xiBOZYhtMCuUSIJc5yMYREEW
	QzW9+O6vGDR2GaEqLt6ChhWZwbU2i0MdqAMTK5BMiVE1x+I3O9SDJgcTTx+VOSENSMs3966k1Uw
	fJkeYxnHlzt7kjcigabgNb172VC8pqmIZoV1jpbQIhPDU/qjQ36VMQ3dS
X-Gm-Gg: Acq92OEIopcqcYcg+g6+2qx9YpOXCcM5zFWOMBVm3Brmy5s5e08X4aGdgnCZjd/MKKG
	NdqmqxVj5lB/AaKSxRDB12U0B03mHnIvnEJlXH5haNPSSkWUmyNRrmtEtbG+WsMDGSAGG9SZA1Q
	IzAEHQj7HODv4oAT6nSH8p/D1MLmw89mHNjY9TNEeKpoy3LP4KPNQDhkctx0uLvuZLhnwnBgLqt
	2cmqW2NAietRrXSHZpMhFaaPWUQMR+zJnvJanMptJcASfKFdYKGZi0rMjhPsV+596Sz/pL4fzV7
	EtUhxZ4saDd4D2GOGh4v8k5hhxLPeIVr87/f53NU6ROko4iKBr695ntfvOl0Q3Glr7pZ1noPVAo
	Nl8vw6HVFmcrCLqynKlvOXKssxHCSdMxxmAEVh2LFc5UyunOHxampjpnn8g==
X-Received: by 2002:a05:600c:821b:b0:488:b811:51c4 with SMTP id 5b1f17b1804b1-48fe6515831mr338698415e9.25.1779265168542;
        Wed, 20 May 2026 01:19:28 -0700 (PDT)
X-Received: by 2002:a05:600c:821b:b0:488:b811:51c4 with SMTP id 5b1f17b1804b1-48fe6515831mr338698035e9.25.1779265168083;
        Wed, 20 May 2026 01:19:28 -0700 (PDT)
Received: from [192.168.88.32] ([212.105.155.226])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48fead18659sm124877765e9.7.2026.05.20.01.19.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 May 2026 01:19:26 -0700 (PDT)
Message-ID: <5b4149a2-fa05-4f72-bb8c-f3ee82f07d63@redhat.com>
Date: Wed, 20 May 2026 10:19:25 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 mptcp-next 0/7] mptcp: address stall under memory
 pressure
To: Geliang Tang <geliang@kernel.org>, mptcp@lists.linux.dev
Cc: gang.yan@linux.dev
References: <cover.1779210016.git.pabeni@redhat.com>
 <da87a06afe83a817fefdb86882b6d68169ba121e.camel@kernel.org>
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <da87a06afe83a817fefdb86882b6d68169ba121e.camel@kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: XZBC7DnXylp_7oom5n-Wck1g48zCnOeAgEO9NsBlv-E_1779265169
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/20/26 8:32 AM, Geliang Tang wrote:
> On Tue, 2026-05-19 at 19:01 +0200, Paolo Abeni wrote:
>> This an attempt to fix the data transfer stall reported by Geliang
>> and
>> Gang more carefully enforcing memory constraints at the MPTCP level.
>>
>> This iteration presents a significant change WRT the previous one,
>> avoiding entirely the collapse attempt on memory pressure. Note that
>> this choice represent a trade off: collapsing allow much faster
>> transfer
>> (to be more accurate: order of magnitude less slow) under some
>> extreme
>> conditions, but makes transfer slower and much more CPU intensive for
>> less unlikely conditions.
>>
>> As a consequence of the above the `mptcp_data.multi_chunk_sendfile`
>> test-case needs a 240 seconds timeout to complete successfully:
>>
>> TEST_F_TIMEOUT(mptcp, multi_chunk_sendfile, 240)
>>
>> The solution performing data collapsing would need similar long
>> timeout
>> for the multiproc tests cases: mutliproc_even, mutliproc_readers,
>> mutliproc_writers, mutliproc_sendpage_even,
>> mutliproc_sendpage_readers,
>> mutliproc_sendpage_writers.
> 
> Based on this version, I actually tested the MPTCP TLS self-tests and
> still encountered a few similar errors, with the test duration taking
> several times longer than before.

[...]
> ... ...
> # #  RUN           tls.12_aes_gcm_mptcp.multi_chunk_sendfile ...
> # # multi_chunk_sendfile: Test terminated by timeout
> # #          FAIL  tls.12_aes_gcm_mptcp.multi_chunk_sendfile
> # not ok 3 tls.12_aes_gcm_mptcp.multi_chunk_sendfile

Without this series you should get some stall there, right?

Note that the 'multi_chunk' test will require increasing the test-case timeout,
as mentioned in v3:

---
diff --git a/tools/testing/selftests/net/mptcp/mptcp_data.c b/tools/testing/selftests/net/mptcp/mptcp_data.c
index 39d092e7888d..127d8b47bd39 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_data.c
+++ b/tools/testing/selftests/net/mptcp/mptcp_data.c
@@ -166,7 +166,7 @@ static void chunked_sendfile(struct __test_metadata *_metadata,
 	close(fd);
 }
 
-TEST_F(mptcp, multi_chunk_sendfile)
+TEST_F_TIMEOUT(mptcp, multi_chunk_sendfile, 240)
 {
 	chunked_sendfile(_metadata, self, 4096, 4096);
 	chunked_sendfile(_metadata, self, 4096, 0);

---

The timeout could be reduced/avoided, including the 'collapse' strategy from v5
and previous revisions. As hinted by Eric, collapsing is a sort of weak spot
for potential evil peers and in practice causes high CPU usage increase to the
point that in debug build some other test-cases will still require an increased
timeout. 

AFAICS the multi chunk is really a corner case, especially when sending
1 byte chunk. As a trade off I prefer avoiding collapsing, and accept any
solution that allow completion in the multi chunk test, even with very low
tput. 

Side note: I think/I'm reasonably sure even plain TCP will have hard time
with such that case in comparable conditions, i.e. when OoO happens with
very high probability _after_ that the sender start pushing data at high speed, 
but the upstream self-tests (rightfully) do not include the OoO part.

/P

