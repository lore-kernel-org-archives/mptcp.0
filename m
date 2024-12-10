Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42D5A79FD
	for <mptcp@lists.linux.dev>; Tue, 10 Dec 2024 09:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733821229; cv=none; b=ToJ+w9cN4JoAqvSdOUcMZLMgD+NX3vVW2NAdkzHVD5zwnmcnZ55b8LD7UxjjY7z+poVDGMJzb7FbLj2jqLOuQIKBsB1+KcgC6KgFzJCQFP0IJnBg+LaRxfUxo2R86SL8dSwp4TqRioYFnaFsk5u5p20/wzT2yzSBs4AOpykfN+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733821229; c=relaxed/simple;
	bh=+3Y6ekhb1DgE/vGrN9+ae8B6hV11aHxZAiKa/szBs2E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aZRxpQY34+/0T6vq8w+QVWcEAev4LhYNeV5khmZrvCUEACv8GDH2HaJtErXpxD86jSx+11Ncw/YYeJDEd5BzNRLAQRNyOefb3NDx2FTOC30Vy9o6O7gKQ3CL2CjyEgaDlGwtuach212wvRbK4XP4pwaKDNO1bnNjXBcs5IWiaf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Vf1lhK+P; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Vf1lhK+P"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733821225;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=r/A7z091+Ipn5ZrHz4Xw0vmSlbf/xOK3qfiqNqA3/mk=;
	b=Vf1lhK+POkaoRq+le3UXMcbUb48nAXQ43OjMctA+T77ygYhpHi3t/7zUyNgdt8gxXv5oxi
	5niPWKh6tkNsjKSRW4SuLazRlg8jREgyKV5nT3qyM2/XM+Rz+t1/m15UjXIaM4NbN8Er+w
	qYkMgl01paKZIQf2SHVvyYQNOc3aJpM=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-652-LsNf9sfpMeOpmnE8eUAuWQ-1; Tue, 10 Dec 2024 04:00:23 -0500
X-MC-Unique: LsNf9sfpMeOpmnE8eUAuWQ-1
X-Mimecast-MFC-AGG-ID: LsNf9sfpMeOpmnE8eUAuWQ
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-7b6e59d6638so35208885a.1
        for <mptcp@lists.linux.dev>; Tue, 10 Dec 2024 01:00:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733821223; x=1734426023;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=r/A7z091+Ipn5ZrHz4Xw0vmSlbf/xOK3qfiqNqA3/mk=;
        b=pDd5XE0p1h/bBZvHnWcmFAwFua9kodqqXZMG6HKy9VkxXKL3Kv3faAH3A7fKvpB6QC
         AEIv/iGRUw69n2EaKL/VgqSyPVioII9590+95Yz0BEENscB0eLOR5amXdKcPHhbMUBN1
         5bqWff5FNMqs+XOSyosWszake7v6fXcnidp+ZpesGf7Zu4yX4t7I00HbXl3J99Ee5ToW
         Y3IdvsKYCVvMehMN+BUPg15YL7UCDGkuZ9JnjqGiOK5cr7C3Bz7qvkmSG8K/PSSWKKs+
         gWpp8rgJu4TsvYfkCK1k4ZQ+gFQ+2zumrAbwxXueOuOs3NVfBfcZ5HRtz9XSNKAN7gzm
         U+og==
X-Gm-Message-State: AOJu0YyMswpOj3QWf6lGonLnRHHH8yHtp966kkTfGUQy9igtnJC5fHuX
	6DKQtOa2amDyFuceqFUaiz6lBDfF5JLhekNHK/gGpyf3Nzo800CZXVhMUdTsDDKHdp99X2V6jxU
	fBjm/XHGxT2yGOftEkTgHhbsGNkPBDY9wgoxhn9Vr/+CHvWv+mOLuFNgQIrk+
X-Gm-Gg: ASbGnctAeZMiMS+rKhoBU5ffQH65QrdJw8Jaz0zpHPAcjlO/3c/XjHkCEcOaiC/yUz/
	By+VOajsyZba/yltZJUoC/qTXb6eX2W6cU8hLg74ZlwXGc2dhpjqpZX51ok/YEUQRNIEaS3ai9r
	7aEkYVD3IKyI/5oYqMOKfWChteCO6I/641+a9AGlDjPBbwGLO9DVm91uRoPf6oYwxWH0xHp9Diw
	DWgMAbi2axRJOZ32gdfIJ1LCwLx8wa0WUFvqHXnOpmBcLLnVW6wHXRYmb2EMijTMBwpAv5X0xrZ
	rLHSbh0XX20K+TE2HXv2/q39YA==
X-Received: by 2002:a05:622a:1a26:b0:45d:82a0:5028 with SMTP id d75a77b69052e-46734ca2bcfmr247449351cf.1.1733821223238;
        Tue, 10 Dec 2024 01:00:23 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGbQ0JwgDHUdOJhOy8SD4lM626+T81hhlZUgESJqzmfaQydl18BqbCiAV97QKCuvsnZe0UKhg==
X-Received: by 2002:a05:622a:1a26:b0:45d:82a0:5028 with SMTP id d75a77b69052e-46734ca2bcfmr247448931cf.1.1733821222902;
        Tue, 10 Dec 2024 01:00:22 -0800 (PST)
Received: from [192.168.1.14] (host-82-49-164-239.retail.telecomitalia.it. [82.49.164.239])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4676f1a44a7sm11669531cf.69.2024.12.10.01.00.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Dec 2024 01:00:22 -0800 (PST)
Message-ID: <b1aec5d2-0be6-42b2-811e-ba21038df9e7@redhat.com>
Date: Tue, 10 Dec 2024 10:00:19 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH mptcp-next v2 6/7] mptcp: cleanup mem accounting.
To: Mat Martineau <martineau@kernel.org>
Cc: mptcp@lists.linux.dev
References: <cover.1733486870.git.pabeni@redhat.com>
 <152364cf85476115c84f435d76a8f04da9e2d089.1733486870.git.pabeni@redhat.com>
 <7eb7bd25-b6b2-9561-bec3-7b51020a21fb@kernel.org>
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <7eb7bd25-b6b2-9561-bec3-7b51020a21fb@kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: z6XAhSH9mUkSlxGqgzF222qbTetH2G-INvQXZWHiSRg_1733821223
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 12/7/24 02:45, Mat Martineau wrote:
> Minor change: this helper is now exactly the same as sk_rmem_alloc_get(), 
> so use that existing helper instead.

If there are no strong opinion against that, I think it would be
preferrable to do the removal in a separate patch. In fact, I have 2
more follow-up patches doing the __mptcp_rmem() removal and some
micro-optimization/cleanup for __mptcp_move_skb().

Cheers,

Paolo

