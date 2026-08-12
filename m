Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 631933EB81D
	for <mptcp@lists.linux.dev>; Wed, 12 Aug 2026 10:02:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786528972; cv=none; b=t01HZ6MNY4bdNk21iNJe/NYwXCSSy4YO7g3uJY4F0gSTuYz/x26tmSn/D3Vj7uk+TmeASt15SJgTWc4xvh2vZulWIAsbLaECGRFjghDQIv765HO5HV9/Eu9u+xWr0YmwAflGscdVvPJFJkJs4+7YEvHQEyjkF0aNV57eGvdO/eI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786528972; c=relaxed/simple;
	bh=0NAdj94h1Uw+DkYpg/G+sBXIFTqp3PGiRC/PPYVXM3w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uDegYQxkoiavc4BGCEytZsus7bE7zfLcNdKrJdqrCxWParsDWRBp1CtWhsSlcjxJr+W1RezXrXg+2J1RAOC1++Sht5UcFWtCYChnjRoGkHkYgt8R4TV0o1dPwtdzBV21VIYZM43AZzP56nWy4/sD8EFT6AChtvkWzB3oO8pXIt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bB7BSaXL; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bB7BSaXL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1786528969;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=C62z5zNDvc4JDjecTxfPhsiEgHifj5p9/O67Efg9Hao=;
	b=bB7BSaXLM4uy1o7+KSCkSPc6J4sZBLhkAn73EqBDLEMrn3BkJlAYCxJOd41DEivxtKftr4
	LXL07NMasZEV/r2qd89HJueWoO0mMqwrfuYyGUkjYhbmMrOXJ/WEtwdD2YcQyy+vpSRq6u
	r14Cp2vPIblYY5t5PG+7hhpHC8NZ5Xw=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-427-gFaAEOsSOp2pS5-7wd7VZQ-1; Wed, 12 Aug 2026 06:02:48 -0400
X-MC-Unique: gFaAEOsSOp2pS5-7wd7VZQ-1
X-Mimecast-MFC-AGG-ID: gFaAEOsSOp2pS5-7wd7VZQ_1786528967
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-496c06ba017so5729705e9.0
        for <mptcp@lists.linux.dev>; Wed, 12 Aug 2026 03:02:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786528967; x=1787133767;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=C62z5zNDvc4JDjecTxfPhsiEgHifj5p9/O67Efg9Hao=;
        b=SYtUr+rzfZKrgXAeOIYTO1MwLDAkOkJiJdWiMj9zTWVckdoaMQtc7Yqi1zAAippHAB
         A1DU/JrIe13xd2/FB5oSHcemrPbfJKf0kAxc8IF9hv7pnCgJWF+vvhafR2YCXBY+s8A+
         K5qgXuKKQwritGgg4xFOjuR9Jz1bkBMbzzYi7nFt/ACuKL4YtuWYD03cN+Cq/svOHlZq
         hxgeZz4fiXPHB+/NW748RoxPAe8P9d3m/PAvkyztU4d65qU07ERIlue5UfMOvqMzmiKX
         2ACrl9W8lrCRS8A7BlzdSmLt/fKsKQaem2PlkpyHE+jVfWpwTVgmRpdVASFk8dK0ol+X
         XIWg==
X-Forwarded-Encrypted: i=1; AHgh+RpdhJNugCoviK6sGK8tx4bflYcs1Sb2i2DC7TFw6fL9PoAiDJhDc4Dmc9qt2dUiJ56JwZ/QGg==@lists.linux.dev
X-Gm-Message-State: AOJu0Yw9KGsAOaAvxUdAlHdEbSaQuE7UZ+7bUruhE99F+H+E7n9EXGj/
	D4JNIz2UsTsl5k6s9tfl8DL3TAzjsfewzj/wjACD7WlAZ0O5fnOhC0qUdg9SoB2vPf8OYFKf51Y
	+bzN8FLwCeXXJua18TYpbB1y8EULqLsZTkeJd4d39sKRiFO69JP1VMqNdOUXtG2PE
X-Gm-Gg: AR+sD13L+gIidsksMVVXhwmnjqaReBHl0/druGWjYogskt6PdNDraB0Rpz5ji7kLzBZ
	5Im81yrxZ6Jhv8KjDw2K4g7mQfoeQQ1ZpkNDr82ZWD3i2jpGdFHZrsHMg7QqaiWmft1+ySnNIl1
	QGEK4O0JtZAC5M0HbsOuFZ9tHSEF1T38RIj0Eors+opaTnVLp+58B13qiZp4O2b5LIJkb7WzNsB
	99G1ZHjLJeD3qQ+A1v7ZQUlgdgvFX/hrm8tayPCRwLWcCNztj3wO+K7tuEaY8ofmBiTLOXCu8p+
	wolnfBBvAMMIZ5YE7eLFYr/Rfd8LoT3usqBzFnyN0H8zibXgE3wf8G7HhV5R2QFfDuqVeDXLc+6
	Ydt7kn3bk+QesNZ7jiuD44zTAKYJW3TdMt3VX5zQrszGEi7BYhQis1M+SDNId9aG+Eg2WZDR61g
	8=
X-Received: by 2002:a05:600c:a43:b0:495:3bc6:d381 with SMTP id 5b1f17b1804b1-4997c3782d4mr45106995e9.2.1786528966869;
        Wed, 12 Aug 2026 03:02:46 -0700 (PDT)
X-Received: by 2002:a05:600c:a43:b0:495:3bc6:d381 with SMTP id 5b1f17b1804b1-4997c3782d4mr45106085e9.2.1786528966360;
        Wed, 12 Aug 2026 03:02:46 -0700 (PDT)
Received: from [192.168.188.103] (ip239-44-231-195.pool-bba.aruba.it. [195.231.44.239])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4997aaa5d04sm57667145e9.2.2026.08.12.03.02.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Aug 2026 03:02:45 -0700 (PDT)
Message-ID: <b41cfc9c-065e-474c-ae1a-c79983e4a932@redhat.com>
Date: Wed, 12 Aug 2026 12:02:44 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH export v3 3/4] mptcp: reset subflow on MP_FAIL when OoO
 queue is non-empty
To: Chenguang Zhao <chenguang.zhao@linux.dev>, mptcp@lists.linux.dev
Cc: Chenguang Zhao <zhaochenguang@kylinos.cn>
References: <20260812054653.43799-1-chenguang.zhao@linux.dev>
 <20260812054653.43799-4-chenguang.zhao@linux.dev>
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20260812054653.43799-4-chenguang.zhao@linux.dev>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 08ClogHsEzziGXuVYc89LpnZG0nIm9nJB8l0LbG4yQc_1786528967
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/12/26 7:46 AM, Chenguang Zhao wrote:
> From: Chenguang Zhao <zhaochenguang@kylinos.cn>
> 
> Infinite mapping needs contiguous data. If the MPTCP OoO queue is not
> empty, reset the subflow instead of falling back.

Why? the RFC says:

"""if all unacknowledged data in flight is contiguous"""

That statement can be true even when the RTX queue is not empty.

It will become false if/when some mptcp-level retransmission will happen.

__mptcp_push_retrans() atomically sets `allow_infinite_fallback` to
false when such retransmission happen. The code just before the newly
added one checks such condition under the relevant lock.

I don't think this change is needed.

/P

