Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2212B306B38
	for <mptcp@lists.linux.dev>; Mon,  1 Dec 2025 11:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764587415; cv=none; b=NQ5wzk3+ioGbRE5Hw0ZdF7CJ2dpRQU92GWWLhgHAMiST0J0PwbnY1MLYrZF2cR4sYcSUWk/oDsyYzqwgQ37zuITDVRu/AXwXLrLvln8/JymlaKA/0qotEGcpHl0Z0WpoajkqPvwkwx5ToM7tY0/AkpOO/rzl/8+7MDevXEbE3FQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764587415; c=relaxed/simple;
	bh=kncEdnB71fqaD2hcIiHguiRwsbnDOSKTWALyMv3oYiY=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=G0EUl+ZD3uwCOUl7CrmllUYONQ0ckuqULohvqXrmiXt52tIR3na8IGlvfR6zKI57HURfHTvYKA8CQUZ5ud0Qtf61NKs4IS6W/hGGN0DfCZqEoYMgJMnNhNxKIvPg4thN2pP2S3q3btJVgv0KdrvfQRqsqZY3Ym5iC3dFT7VwJho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dPBL+XXl; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dPBL+XXl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1764587412;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Yc8DTpUpDggKx7nZnQvP1aNWrxRtgyLLV2eExM143SM=;
	b=dPBL+XXlj0YJ5ZoSqKsLZ8QrEISETo3Fp+tSmg6D6DgY29dpwu6/9PvElewvOVKkOFw7DD
	h+BvFrD5aefpzXXvzIsFGXzjJYZQ9bJyDL2OV6hrLojUQqu2JpYkUdwj4NUZNCMQ4LzD8n
	U2uIWzKJKaEtrBHTrAsNAcfwf8qT4l4=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-470-WtdTW4ApP8KK9wf7ElYWtA-1; Mon, 01 Dec 2025 06:10:10 -0500
X-MC-Unique: WtdTW4ApP8KK9wf7ElYWtA-1
X-Mimecast-MFC-AGG-ID: WtdTW4ApP8KK9wf7ElYWtA_1764587409
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-42e2d105358so955023f8f.3
        for <mptcp@lists.linux.dev>; Mon, 01 Dec 2025 03:10:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764587409; x=1765192209;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Yc8DTpUpDggKx7nZnQvP1aNWrxRtgyLLV2eExM143SM=;
        b=XBRfX0hS9oqO/g5RlxyM6tDltT2V2GHGiq/8YrJIl6eFDU8v9odSv1iwQdP2rI6/SI
         DhNBAxLQ2CpNwS8dWEdMOEuYp+V8jIOp8C2D5MuLjgBEia3n1KZg7WNFO5eoI5S60m+b
         knQstNNXCP24vZugafC45/cQEqDUEvbOartUVHxJAat7knzyMOz/lEMpN3/Z9c7l2uaw
         cgQISoxa3wVhjqHcpLcjvxz1lPrM/XBioG6DXJ3D/jK3PliukGk9lJv5LrpA1MxDVpOJ
         gx4e4NMaBFU+ZrGMMKfrv/HzAQEbmQT5ih9/ievzPX7S2bYLE3jgEYKxhD/zISOGKVNb
         QiPw==
X-Gm-Message-State: AOJu0Yxk97SpUrcsZfiuY7ssfS5h7++HQ/kv70uRYXN+Di+b1YIcajp+
	aYmcorr78UgVpAm61sTb6oppS5ZCxxGU22RP9CzwdT2Y3ztG61pjryJ1345lTNhF2LUYCpG3jSd
	2pMDRpvvSeVFptOOUSL8xOYRad3AgIbr/orkBTcweaEMJFSFIfhBIxyv/rWvrmt6i7vqTYdyg36
	WaFPjh2GzQhZDaRsFoOyFzL9JOfoLvpnVfhGxioA==
X-Gm-Gg: ASbGncuwXlUseGZTttpUz9USzwiLBy2MGKBvHyi3wTcmZow3wYqxxcj1Zj9qT0R7cQT
	KBsAP2Z5TjDKkUe/+r/XOu8x/qsy/C4GF4VkE5XcOx+1o8pHVUrD3tHJ7GI8qprgZaQrG6jXYzh
	LUDIxi5AUWfbJ+Zs4F44vBwEkWoBwTum39601Ipqh89+zcXOBkK5qpWrP0Xgmx9GhEMwHBvf5o2
	Dm5aEeKSqBbRFFEB8mrlNxnCPZpyLJyqqi1aDF2ycptYUYjLiM7CXpFr/tfzDZKcTGahq4S/zxz
	kLN6MITg2p/xbxnFNxUjX1EYIcjnJ7jQj0zPqFHp4PtjGTt7TZxcWKxpfnWnG2Kc4LLZHVRBEg5
	JOlDivqVArWk=
X-Received: by 2002:a5d:5f93:0:b0:42b:30d4:e401 with SMTP id ffacd0b85a97d-42cc1ac9d58mr43059398f8f.12.1764587409025;
        Mon, 01 Dec 2025 03:10:09 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFORf3xPc6lczsq48a6PCqiM4kesMxA7iPZPvAr9BUeZmEYYcJexrIOkE5u/+fBkBdHWUdDWA==
X-Received: by 2002:a5d:5f93:0:b0:42b:30d4:e401 with SMTP id ffacd0b85a97d-42cc1ac9d58mr43059348f8f.12.1764587408518;
        Mon, 01 Dec 2025 03:10:08 -0800 (PST)
Received: from [192.168.88.32] ([212.105.153.9])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42e1c5e3857sm26529949f8f.19.2025.12.01.03.10.07
        for <mptcp@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Dec 2025 03:10:07 -0800 (PST)
Message-ID: <cb41f3a1-2a45-496d-9dba-784a81dc2de2@redhat.com>
Date: Mon, 1 Dec 2025 12:10:07 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH mptcp-net] mptcp: fallback earlier on simult connection
To: mptcp@lists.linux.dev
References: <36b926c5d55933a6f2d2a7f6ff8d8a091c0de719.1764332508.git.pabeni@redhat.com>
 <7bc3d452-b6f3-ce84-f163-a2fbefa71e55@gmail.com>
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <7bc3d452-b6f3-ce84-f163-a2fbefa71e55@gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: rDQsKOu7PnBznopL9cNXayJ1r6fsenFk07eTciGSHZA_1764587409
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 11/28/25 2:35 PM, MPTCP CI wrote:
> Thank you for your modifications, that's great!
> 
> Our CI did some validations and here is its report:
> 
> - KVM Validation: normal (except selftest_mptcp_join): Unstable: 2 failed test(s): packetdrill_syscalls selftest_simult_flows 🔴
> - KVM Validation: normal (only selftest_mptcp_join): Success! ✅
> - KVM Validation: debug (except selftest_mptcp_join): Unstable: 1 failed test(s): packetdrill_syscalls 🔴
> - KVM Validation: debug (only selftest_mptcp_join): Success! ✅
> - KVM Validation: btf-normal (only bpftest_all): Success! ✅
> - KVM Validation: btf-debug (only bpftest_all): Unstable: 1 failed test(s): bpftest_test_progs_mptcp 🔴
> - Task: https://github.com/multipath-tcp/mptcp_net-next/actions/runs/19764025304

As mentioned, pktdrill failures are expected - test need to be updated.

The simult flows and btf failures are unexpected, but looks unrelated
from this patch.

/P

