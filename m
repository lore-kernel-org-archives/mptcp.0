Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F418A1F943D
	for <mptcp@lists.linux.dev>; Mon,  2 Dec 2024 08:19:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733127572; cv=none; b=BEI/k89UGffw6iizW+8Ko0gkhBCKs65N7sf2gApwztwp6fe1joAWoiLKP87zBR985OO9JT2d8AA345FT46++/L1BtKDY7qHlq4jmi2/vGVye36FolHA8e6ckSsoxk147jIADHb7fdTec8q7birM+WaRtzGemCVLJbjy6nEYZiDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733127572; c=relaxed/simple;
	bh=iz2A44GDLVYj87M9FdTrX87bVXh6OmQMFYu76f5qfJ0=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=gV4Fs8mdnr1nw5c8wR0wQufACqh7rhEjnQi9Urd2AXLK02kymn7kUsjJsT/7/CE3jV+x++GSEn2Ba7SqIcvV3Y9fEa18piWuh457AixeyPo1/tbQnPIfTbQUXgMWlOHMYskxagtGNLqRDFsMT5zaraIXBa7jUMrCMfha32bOS5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=N0GjBYoK; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="N0GjBYoK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733127569;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bkuArjAlac0k+fxg69kJA114oIDXkfhh54zk5GLhvHA=;
	b=N0GjBYoKjp+jtc8eZLC5kc3m2FlgH5qKJe1EmdvL8Z/Kiwpxehhvja4kRMHx4lY/OEDHXW
	rH+uZmz9lue5sCxP1guTZgeUXHl+fBD8z9fY3Jp9/3CpJ/uzpzrkuuTVwVK3NpxNnH5D3g
	AD3VMFBEZ5G9LTHlbMJXjmdC2/rnrqg=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-50-v5mKI6B_MxipwmOzW6AlNg-1; Mon, 02 Dec 2024 03:19:28 -0500
X-MC-Unique: v5mKI6B_MxipwmOzW6AlNg-1
X-Mimecast-MFC-AGG-ID: v5mKI6B_MxipwmOzW6AlNg
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-385f0829430so539820f8f.1
        for <mptcp@lists.linux.dev>; Mon, 02 Dec 2024 00:19:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733127567; x=1733732367;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bkuArjAlac0k+fxg69kJA114oIDXkfhh54zk5GLhvHA=;
        b=uMRY9qZoVKRe5up0CSgbTd330oG6g+VEPWaitFqpfsCeWi4ukAwhD3fwfRdskW02Kz
         ZSkrq46RdkEU66UbVcnMPYw1kAPAhERMNAeU4/CibUHLo3DUy8GjUASDCi7TPhv1m1OW
         FeGE/GeHCdPyfTkrf6YX0wVXt62JLqefgIzFkSgDy4aSv+wsY9HCOAyuLMJYTgzyGnb6
         safkXIGHO+cB6umv78BT7MsDGxa5SuEnV1B57cWVt0zll7JraVuSAZibVjKqLvgBo0oF
         QHQCXH+Z8qhFTHsDcI7pS7ndEDi3XwrgcDc8hdgeK7JxTHl1ULi/w8tbhdZAXvgM/gLw
         V4dg==
X-Gm-Message-State: AOJu0YwEQqL6c1ehdJIy080QIfbeYUd0XiMr0KcuaRj13wzcIWYEYWwN
	C4LNsBbcwEksATXl6mz6Z2bRdtyl+e/IeBct/tegCVUBO3xLN3xdSzqREoD7ka+w7cOYS/ELCDB
	9bGFTFPA8EruJhAwQQxkV9mRxYJwpW4vcT5I/i9QMnSM6KoDJWCZRGZ/V885LE9A0GvcluCrvPX
	qfRDdxpoAtDR5bbnIlQJbg8LQz8W1taoMkyw==
X-Gm-Gg: ASbGncvislFSNLk155leAZB13uURNtaVH4tOETD7gagq3iXFm7sq1zdGQ8Hp2Pyn/Zp
	zvEA6tPuiYKK/rMT+o03ilAQB414gXPc8ZChfMNoYZeXqQQk7xCiFHPly3hKbN3h3F8F4UbzUt7
	RB71rxWq380A13HuJiV1B23Z4+fpDtaavEt7vQjITgmIdrYmt7HlRb+nkBaNf+igPkZaNLfPi4K
	jPDaxHdw/UY3NdiTRLqibxkTgCr2XuKcL6rl1MMk/YSXIDvfFg5M229X9TnIxvb4ZqhGFk+GJrg
X-Received: by 2002:a05:6000:683:b0:385:f1ac:3ac9 with SMTP id ffacd0b85a97d-385f1ac3d18mr3831564f8f.17.1733127567179;
        Mon, 02 Dec 2024 00:19:27 -0800 (PST)
X-Google-Smtp-Source: AGHT+IErIcL79XrUvCdZkTp6ZrcRw4nvZ8UqA57HnO5iyl+x4XfQ27N6h5pAPSyulP++DVYuibSOUA==
X-Received: by 2002:a05:6000:683:b0:385:f1ac:3ac9 with SMTP id ffacd0b85a97d-385f1ac3d18mr3831539f8f.17.1733127566839;
        Mon, 02 Dec 2024 00:19:26 -0800 (PST)
Received: from [192.168.88.24] (146-241-38-31.dyn.eolo.it. [146.241.38.31])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-385ebaf3bccsm4445084f8f.68.2024.12.02.00.19.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Dec 2024 00:19:26 -0800 (PST)
Message-ID: <f57eb03e-23b4-40ac-b30e-8b91bf2cee0f@redhat.com>
Date: Mon, 2 Dec 2024 09:19:25 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH mptcp-next-next 0/3] mptcp: rx path refactor
To: mptcp@lists.linux.dev, "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
References: <cover.1732902181.git.pabeni@redhat.com>
 <12d1c966-9462-72fc-8088-16d65769a81e@gmail.com>
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <12d1c966-9462-72fc-8088-16d65769a81e@gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: d1ihbgtJzCwaTznp3mGW1DkBb1XzbtNACYoH2ZG6P8w_1733127567
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 11/29/24 19:52, MPTCP CI wrote:
> Thank you for your modifications, that's great!
> 
> Our CI did some validations and here is its report:
> 
> - KVM Validation: normal: Success! ✅
> - KVM Validation: debug: Unstable: 1 failed test(s): selftest_mptcp_connect 🔴

This is somewhat 'funny'; I can't reproduce it locally, and other tests
do the connection successfully. I guess there is some race due to the
slow env?!? Is virtme still running without KVM ?

Thanks,

Paolo

