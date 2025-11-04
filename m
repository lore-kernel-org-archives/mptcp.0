Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14902208AD
	for <mptcp@lists.linux.dev>; Tue,  4 Nov 2025 21:13:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762290841; cv=none; b=UzrqDWIduh6917J28XMxKVpKdysOCgIHD3eL9GKyfXwIfEc/UYbba9FjmXOU0KpL6cM2L4DfNa++qSWl8WGCDtgEumBYqSNeqMA4fi/4dZXEbUrB0Xuu/3AwvqkMQJVofuekoz30sKzi9EHjktyyE4CWgJDK6IS0CNbpZKMfJec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762290841; c=relaxed/simple;
	bh=um5oK0ffYM5R8lEVbPy/ZvyhNmAl6alw+qPT1EcjHxM=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=CS7WY8J++fjKvsG6f53edxcllXdNdWmbOz0JZBl6gCUj+JYVRrWMAK4S4b1wqY/OXvf6dHgx1PzUSXsya+5QkUJqYtmyJkOnXQ2dd6o8J2hJeIDmoAc4+ib1mdXSUhC1gR/aQ69O7svf7UvcZPfavH/X5lefcw5TT5dAR4m01ac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YQZbVRFh; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YQZbVRFh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762290838;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=um5oK0ffYM5R8lEVbPy/ZvyhNmAl6alw+qPT1EcjHxM=;
	b=YQZbVRFhJJg1kLPYpgN0I/MuPu5/wLchqnfnZdBG3K/yVZJdDM3m4eDn0wRF7lF7BYxREQ
	j7PQE23D2WmMnLfiKYd+yb8sOib38/UER8GPdhIlUOureupJIY1KX2xVJJof9kuBK8tPo2
	4oRwYWwQQqnLHQ8upm6F7G5CjwnKvhk=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-22-9VcVLCvmPXaK58q7BkoATg-1; Tue, 04 Nov 2025 16:13:57 -0500
X-MC-Unique: 9VcVLCvmPXaK58q7BkoATg-1
X-Mimecast-MFC-AGG-ID: 9VcVLCvmPXaK58q7BkoATg_1762290837
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-429c76c8a1bso2405695f8f.0
        for <mptcp@lists.linux.dev>; Tue, 04 Nov 2025 13:13:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762290836; x=1762895636;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=um5oK0ffYM5R8lEVbPy/ZvyhNmAl6alw+qPT1EcjHxM=;
        b=ZhaR6OqRGUF17hYJjwkYvfuVEBkHBsCJB8L2joo5Rt2+tJ4MUFZHyX3EUYZbqi6E8S
         CQzdsFnUQM2w03x/XH7V+xB0E5InI1P5P1sAJ1agLYOenR0RcoMGbO+5SFcs7pDSm9oz
         ss0QncBj5fXkFLP77BFoe6218Lv0sEtHnqtxDnTXD8MTuwFc0ezo0ySPmcESlsikT1Lf
         kClNfkV24c5SfFl/SmuOfO/W52SdRflqY+49RdW6YNScb/eQ6RkUbfwWWxKiZ3gao2QV
         Fb1arSoBCtc/Bk3vBceAUEQ3CKShjmO3udr/tsQZQu/DxYTqjCfr8GiJs7YC0w6JGtDR
         08ig==
X-Gm-Message-State: AOJu0Yzx5v0hNiw19Jsrvm1s7fEyP7QtgyLFdCxIsMuJr57IEFLepuB9
	/UyKRrg7rm7vghLocRSVHGejT3g1tvzpY+4HWfuOYDPt6gFM4OlUet6j7ZsVgScLeCz6hL7gtbi
	oe8wUoIL5VjMMtZgoJav5a/q6PPbB1WlndgXEYAkTkKRNo6FXuRyez/Yow3Hz4T8vlmqqyQdJ03
	K5V2Pfq6PbJV3iR03ASkOq/ilOJE8wG70Weq7Dpg==
X-Gm-Gg: ASbGncshJkP2bpST5JaEuNiafpxhSASYqxHi7JPi74uuhoVoTKl705MqsJHmVISCR1x
	AkptMbhDIkYmlKKJ+F00zXHoOzPQHl2/yptVJ7JKuLfoXIJfkm5e/1B2sZQ7G4CbCUDIIX+2Ofy
	iVpkfvWYrt9+QVdVo3M72bd7A8R8+/qRfG1z1U1l3tCMiF37znKmOaZ5XGAzrv0vzid3Q86/ljh
	mJhTZyjIYB3zOplBzSXV6s49otS3O1hpU+Hga/Lyq/07hhOYyVrCvp7IJiWzp0QL6NHidtLdRai
	iU2hWDPyXKgoVQx9f0lTfiOAIUlDMkVp2B0Lymz5eURWWlf8IsePEGQjncIf9QeOQiLG/3iSDGs
	dHg==
X-Received: by 2002:a05:6000:40da:b0:429:c989:ceaf with SMTP id ffacd0b85a97d-429e330c3bcmr606672f8f.46.1762290836120;
        Tue, 04 Nov 2025 13:13:56 -0800 (PST)
X-Google-Smtp-Source: AGHT+IErT0bdEbLuSuppYrOXGUIhqOKtfGX0osGvejK/PrtYHdAEFsCjNR3w+rmI3KjNycSoC92UkA==
X-Received: by 2002:a05:6000:40da:b0:429:c989:ceaf with SMTP id ffacd0b85a97d-429e330c3bcmr606654f8f.46.1762290835647;
        Tue, 04 Nov 2025 13:13:55 -0800 (PST)
Received: from [192.168.0.115] ([216.128.11.239])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429dc2007afsm6522360f8f.44.2025.11.04.13.13.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Nov 2025 13:13:55 -0800 (PST)
Message-ID: <d1121a70-693f-4bd5-8b5e-223c011370a1@redhat.com>
Date: Tue, 4 Nov 2025 22:13:53 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH mptcp-next 0/5] selftests: mptcp: get counters from nstat
 history
To: mptcp@lists.linux.dev, Matthieu Baerts <matttbe@kernel.org>
References: <20251103-slft-nstat-cache-v1-0-56025c09e56a@kernel.org>
 <08d6eed5-4177-3a1d-d1a7-4aabcca38b9d@gmail.com>
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <08d6eed5-4177-3a1d-d1a7-4aabcca38b9d@gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: ekitlWDq-R6mGVvJ9pScYBJEdkXB3X-tLjSH-4p4Jao_1762290837
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Mat,

The series LGTM! actually that ugly old syntax I introduced bothered me
since a while, thanks for fixing it!

/P

