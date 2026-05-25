Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64D443D88E6
	for <mptcp@lists.linux.dev>; Mon, 25 May 2026 08:33:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779698036; cv=none; b=S4NkAfFtSVDjmNxJ2QW59vh8p6IFZcg4A3mdefIJEKLzhE9QkPVs/Zvp7ia55zVqRKt+F3BQ1wwksSkqZsTb6v6xcHBIgVWj1ym/92OnT6G5Yk/m7lPPZlR8sxt60PLsdsPRwuWuFogOm72u+J0NYarA7PMmettJwrlyrXAe7Zc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779698036; c=relaxed/simple;
	bh=Z/cjK7wMARA6+9GS3PPa+h123AlwSKeroAJKyouunEY=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=dvYivaiEmLhgtkdEzraFEtvOPCVHYui0VxvLjW8L5/PL26u5LvZ3xVgeG3gWzDm5HBHL7UDeIIyY/gm6zNhAmVa1xk3DO0Wdbcz7uEz19IXIPW18m+SgmuhgsLSr0xq+MDGPNCANf4vzxBh0hwbC5c18Wo3+QXGXawl9Ukp3QkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DcRN9dfs; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DcRN9dfs"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1779698034;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=A/YLNRb+mUIhnb94taHFPKzEeTneHbqZx/lbUG8ZTE4=;
	b=DcRN9dfsJKx2ykDGqYogX8u/Mt+rMrY619ZHsBTYob/N8vTJYOCx4LthHh1+wJcBUh/RBn
	7oz3M6aZ8uvzgqW3j9pDZg2/JV2YoF+teItlzMmPh6MgoxUuGZxRRWMJC7LqOUsus/1vcJ
	5TZA6+3xzDG+EevG3JzBEc9727XRETM=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-226-BGENlBY7N2ea60v-Ejf_Fg-1; Mon, 25 May 2026 04:33:52 -0400
X-MC-Unique: BGENlBY7N2ea60v-Ejf_Fg-1
X-Mimecast-MFC-AGG-ID: BGENlBY7N2ea60v-Ejf_Fg_1779698032
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-45ea19f2564so4163238f8f.2
        for <mptcp@lists.linux.dev>; Mon, 25 May 2026 01:33:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779698031; x=1780302831;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=A/YLNRb+mUIhnb94taHFPKzEeTneHbqZx/lbUG8ZTE4=;
        b=OVlPfls/Cbt8yi7RxR9A2qyXv21FEVqZW0zAiYkz9Ef9iwvWAeD0aNoynkiHLDIeRc
         SCAaIW0A2XEH0ub7BfGhrpHgHgLWLnMYNz6zsOxn46PrIt+kuWNOgjiRomA50OkRzP4t
         UHCie9VoW4hkFB+wEc9ZgVmB0c0M8goXKWuvIQyzsOHhxFtdPuTEIxIeS+w6qRVrBclF
         /qX5J90bgTh7rXyCDrpQSy/zUq+ezTsmm9eKaUj/zqzOqmcRrJBHifk7BJdY2V6+rR9P
         nW96UdEn41p9wO/9p6FOOvkeOSrsB99gbXTtsxZVK7JmP4PnsYAs+Fkwo309qk9lWRDn
         2hlg==
X-Gm-Message-State: AOJu0YxsBu/nU3x7yZXbwbLW42uFkmOpAFH44OHYkRKZx6S1zJAPKkbR
	o/XPJXEIFifq7r81Z8pmoONKaTlbksk0pSN/WbSSpXUZqimcg0JjVb4YRvro/W4prQJIXBw7teq
	SxUexw5Zo7ZRl1sFFDRW40hmuBHI6OB9PoBOAthJsAhCL9W33N3a1JphWeWoUsSahVBTvNxYxIe
	+qHd80bgOkUJVfszzJRWgOg5LdLk7GJx3EQYSF3Q==
X-Gm-Gg: Acq92OHp0iuXUcLj37vSc2din12XejkIPlLPPXJUfJk6Db1xf39WIWU4TsdU72Ypa8T
	smhhG9VqolsIAH+Aj5h2uWwJm+25TJEjTewtvtTJQO9ocDQ1oVPpmJaz5I659ofygAWmhTLfTa1
	pIp5++re4JYXZy5qgZgiuRU7p0WJ4+u4Qy9b3pWgek4fDgZILqvbfNCqkvPXKLl/B8zw0upd3ql
	PTWoAOjm2z4IkfatgUsKwYb610g8fzsJ2XW0DFpBJsLshu7ZYn1FBViBrZilh9UTRpoR0PxoLqZ
	bhOS45OdxCB3radcfyvON+TDkxwu5mOuxwACQ6KX26i7BKh2NLKCRLfa4E9NRsdAAfdxqEFVC2x
	AelWsLKKZj3iQZbaFBozwEzfELyWbUGih4JgnE3CEc+k26LSwhPThXFmYLQ==
X-Received: by 2002:a05:6000:41f9:b0:43d:7946:baee with SMTP id ffacd0b85a97d-45eb38af423mr19957714f8f.23.1779698031552;
        Mon, 25 May 2026 01:33:51 -0700 (PDT)
X-Received: by 2002:a05:6000:41f9:b0:43d:7946:baee with SMTP id ffacd0b85a97d-45eb38af423mr19957652f8f.23.1779698030977;
        Mon, 25 May 2026 01:33:50 -0700 (PDT)
Received: from [192.168.88.32] ([212.105.155.152])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45eb6d49132sm25519208f8f.24.2026.05.25.01.33.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 May 2026 01:33:50 -0700 (PDT)
Message-ID: <062597e3-655d-49b1-9210-db9d47b7aecf@redhat.com>
Date: Mon, 25 May 2026 10:33:49 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH mptcp-net v2] mptcp: fix divide-by-zero in
 __mptcp_push_pending close path
To: mptcp@lists.linux.dev, Shardul Bankar <shardul.b@mpiricsoftware.com>
References: <20260525003233.857172-1-shardul.b@mpiricsoftware.com>
 <91bc1ec3-2625-d99e-833b-9b3bc491270b@gmail.com>
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <91bc1ec3-2625-d99e-833b-9b3bc491270b@gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: kjoZrmmLzRakSgtaSrLCCLTpxJVyf4eEBw9H7X9K4xY_1779698032
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 5/25/26 3:44 AM, MPTCP CI wrote:
> Thank you for your modifications, that's great!
> 
> Our CI did some validations and here is its report:
> 
> - KVM Validation: normal (except selftest_mptcp_join): Unstable: 7 failed test(s): packetdrill_dss packetdrill_sockopts selftest_mptcp_connect selftest_mptcp_connect_checksum selftest_mptcp_connect_mmap selftest_mptcp_connect_sendfile selftest_mptcp_connect_splice ⚠️ 
> - KVM Validation: normal (only selftest_mptcp_join): Success! ✅
> - KVM Validation: debug (except selftest_mptcp_join): Unstable: 7 failed test(s): packetdrill_dss packetdrill_sockopts selftest_mptcp_connect selftest_mptcp_connect_checksum selftest_mptcp_connect_mmap selftest_mptcp_connect_sendfile selftest_mptcp_connect_splice ⚠️ 

The above failures look real. I guess the check I suggested is a bit too
rough. Could you please double check the failures are due to this change
and ev. try to refine it?

Thanks,

Paolo

