Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E7943FCB18
	for <mptcp@lists.linux.dev>; Mon, 18 May 2026 16:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779121838; cv=none; b=QBzqU34wC37uOlL+KQ+LAKuTsw1zzlN2X/AkAkLXEvugv/ZHwKsHiUq4LAbGEJShDeQoEp+Sa0YsKUxYYfbD7PRx+7ICqT4axa2FX0v3Ia5xZ/XFdXxs+m4WPDIAXNN+zSJL6v+6I8NwYw5cWdqpnp8YCwcK1mvVu9dFcysWESw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779121838; c=relaxed/simple;
	bh=kGSdkLqVymO/Zr3G2I6yZlcRQZhx8NFUaFE5ni8KtPA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=twNABRFqJrORCkGS2kb7BOotx6xHgE8axV6kJzh7MLIHglnf+C/JxHJ4p5XGEZ06Cfq87IMabuNG3PkOix3jlW0vvF0nneBUZd23fwexZ4eCnzujRR/zFeOBOcc86nkBLKNliki7+s7a1919yoyn3Y3+1tefSHbZzq4W3V7PeV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UMRnExGH; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UMRnExGH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1779121835;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2pch76HTKXURju5jf3KrROqeJQW7o65K/r/8pMhLgc8=;
	b=UMRnExGH6uxntwnlbO+qqQL4pn/zn1a/ofs0sjjR9sbfgH0FG1D9Q2QRNRbnYd398fJtCc
	rdHmklccqd+GFunw3F/BXArzRguf5eZXgVqPYPEY6/Ez04BM4AOK0rrKkL/3Cg28DcRYrj
	NNhhU5Rm6QiMelHiUsfjbUr7KfOiT/M=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-133-wj-uSXxGNreZKMWebEKBSQ-1; Mon, 18 May 2026 12:30:33 -0400
X-MC-Unique: wj-uSXxGNreZKMWebEKBSQ-1
X-Mimecast-MFC-AGG-ID: wj-uSXxGNreZKMWebEKBSQ_1779121832
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-45e78dd7baaso1431218f8f.0
        for <mptcp@lists.linux.dev>; Mon, 18 May 2026 09:30:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779121832; x=1779726632;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2pch76HTKXURju5jf3KrROqeJQW7o65K/r/8pMhLgc8=;
        b=j6QWWUJ99Wot3rwh4WrgUDBuP95Z4a7h5+mU2VInY6nwOTRL2UgqXbX2NBWqz5QRee
         XnIH6d8aSbeyU022fbsKFTFqjEUvlSKIlXDsziVsduW0v7mfs4awdouKrxoOY7HfjA3v
         9/W9g3eS3sK1XZ7TSF1njO1I/wGxCNsJ0AAxCtvQ1aOim2iTwLLK0lRf/8BK5glIWnA4
         mKeG3cBbWHYYVPPeikjWxdpsb7YsdYRefP8brramwpBswnFrkJfW1Xk7+4a8ht4Gq5rA
         0rDAzSU27mP8A+H/7NQbzMBp45FhYMmRvC5aXfSf80leyWkiMeNtie235Pz0DHqFlYu5
         4GUQ==
X-Forwarded-Encrypted: i=1; AFNElJ/aDwp1fkGQx+WK/T3qyeVuDxcU5ZprNM9LMIj2XH+zK2EZebc+S8ytsCTVzakIFCCtNu/4bw==@lists.linux.dev
X-Gm-Message-State: AOJu0YyD6EBdN7orDyWOjQoFs72K+uOowudE+7caNgaYRLMkCaonSAym
	n+0hFXBYwsl/J0zK9rpwQvj+DgEokCtW+8IPuO8LCbLoBu8/hGtdO2kzn3PLPFgpHdL5qBWf6ol
	usmTXG+Gl6z68cAX6Mgt6rH2KEFMGK4QPT/IOWeNwVMv3Cz6Ssg7PJg/YC7Rb45fx
X-Gm-Gg: Acq92OGcJWcgWHarLj6TdhyyktqUwprFJyPyepo4rsUuih81gan20+E50cOlLyOV8nT
	tSE3NtdXBdpxoBTfPCaoP2mfJmAzu/ex3r6gfOqkvyh9q4fBuTQP2+23cH3SNOjrG2ygI4xioy+
	2tejpmCMt7Rcl3XXJFA0kMiTb6r+TljHh69E86z9fo/vm77dXNuaaChW4X/PdzmAfdUDdscBOzy
	Qmp0ckGtTJuSxmK9cNeUBXUlCBqFVCvnuqFiKwT616FrmOljY9fpeHew0mbx411epInihtjBtNc
	UQm+iyyQjfGT0PjUuFxDLSET04zADyB4IRaov8FToaJcSkjRPRJB54ZBfMrwNpLLZ1Bn3qOLsCZ
	TgnzbBKgn0Ujw/oiGOeMnc5uicFsDrD3v8R/Bz+W1GSFow3pNugoPFvA=
X-Received: by 2002:a05:600c:4e02:b0:48a:906a:9050 with SMTP id 5b1f17b1804b1-48fe5fdb076mr250533555e9.10.1779121831749;
        Mon, 18 May 2026 09:30:31 -0700 (PDT)
X-Received: by 2002:a05:600c:4e02:b0:48a:906a:9050 with SMTP id 5b1f17b1804b1-48fe5fdb076mr250533005e9.10.1779121831221;
        Mon, 18 May 2026 09:30:31 -0700 (PDT)
Received: from [192.168.88.32] ([150.228.25.33])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45d9e768072sm37973907f8f.5.2026.05.18.09.30.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 May 2026 09:30:30 -0700 (PDT)
Message-ID: <7f816ee8-6119-47ff-a10d-bbfa61a24e6a@redhat.com>
Date: Mon, 18 May 2026 18:30:29 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 mptcp-next 0/7] mptcp: address stall under memory
 pressure
To: gang.yan@linux.dev, mptcp@lists.linux.dev
Cc: Geliang Tang <geliang@kernel.org>
References: <cover.1778835009.git.pabeni@redhat.com>
 <4a38eef7-0143-4980-b856-42591e521b13@redhat.com>
 <a3331544d24acc69090b43bb44fa5087c33a6092@linux.dev>
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <a3331544d24acc69090b43bb44fa5087c33a6092@linux.dev>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: N6FQBJh0C4rWJbFR2x0G7KMjbAXwUMVP-3elac5Xqdw_1779121832
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/18/26 10:13 AM, gang.yan@linux.dev wrote:
> May 15, 2026 at 5:29 PM, "Paolo Abeni" <pabeni@redhat.com mailto:pabeni@redhat.com?to=%22Paolo%20Abeni%22%20%3Cpabeni%40redhat.com%3E > wrote:
>> On 5/15/26 11:07 AM, Paolo Abeni wrote:
>>> This an attempt to fix the data transfer stall reported by Geliang and
>>>  Gang more carefully enforcing memory constraints at the MPTCP level.
>>>  
>>>  This iteration presents a significant change WRT the previous one,
>>>  avoiding entirely the collapse attempt on memory pressure. Note that
>>>  this choice represent a trade off: collapsing allow much faster transfer
>>>  (to be more accurate: order of magnitude less slow) under some extreme
>>>  conditions, but makes transfer slower and much more CPU intensive for
>>>  less unlikely conditions.
>>>  
>>>  As a consequence of the above the `mptcp_data.multi_chunk_sendfile`
>>>  test-case needs a 240 seconds timeout to complete successfully:
>>>  
>>>  TEST_F_TIMEOUT(mptcp, multi_chunk_sendfile, 240)
>>>  
>>>  The solution performing data collapsing would need similar long timeout
>>>  for the multiproc tests cases: mutliproc_even, mutliproc_readers,
>>>  mutliproc_writers, mutliproc_sendpage_even, mutliproc_sendpage_readers,
>>>  mutliproc_sendpage_writers.
>>>  
>>>  Patch 1 is new in v6, and is actually a fix for an old issue (targeting
>>>  net), included here just for my convenience.
>>>  
>>>  Patch 2 and 3 makes the admission check much more strict for incoming
>>>  packets exceeding the memory limits, with some exception for fallback
>>>  sockets.
>>>  Patch 4 makes implement OoO queue pruning for MPTCP and patch 5
>>>  addresses an edge scenario that could still lead to transfer stall
>>>  under memory pressure.
>>>  Finally patch 6 and 7 improve the MPTCP-level retransmission schema to
>>>  make recovery from memory pressure/after MPTCP-level drop significanly
>>>  faster.
>>>
>> @Geliang, @Gang: could you please have a spin at this iteration? Note
>> that you must increase the timeout for the
>> mptcp_data.multi_chunk_sendfile test-case, as mentioned above.
>>
> Hi Paolo,
> 
> Thanks a lot for the new patch set. We have encountered some issues during
> our testing. It will take us some time to analyze and locate the root cause.
> We will post updates on the mailing list as soon as we make progress.

I run a few hundred iterations of the mptcp_data test without observing
any issue (still running). Can you please share which issue are you
observing, the relevant tests case and the build type (debug/non debug)?

Thanks,

Paolo

