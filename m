Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 664743EEADE
	for <mptcp@lists.linux.dev>; Fri, 29 May 2026 15:01:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780066869; cv=none; b=Tfymu1oLHt7PL5o2oprdOrX5LAn8g4ORZVZPNJsFxRgaq/mcUp4bgUyXYeF12vGUBSvvrtysm1bEk0ayRGL6id11QohOwRLVuTGh906T8WLGwmdMqbTRAOpygvaFwAXAkTjIEzNMI6rMU+LMIEzTpJRVNG1oysAACjjLU5xHREE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780066869; c=relaxed/simple;
	bh=Jv4WOFCyRR1LVj0k7cNZMSDJ/rtfDgEakaHEzgUYIPw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AcUtkNL8Kdndw5C//cBMFBZJDp9G9JjS1XiSRQcsRoki9KtZqPKwYAdMmrogq188zP4YqoWNOyNVl9h2XazRmBGm187WoVxbACIjGXgBRysfZD879nlK5HX3Lwh6rJiYa/GmvLmeKdq/j8LzSiu6XIZR5uDqXkkKjuA98f4T5ls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Wb67pB3i; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Wb67pB3i"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1780066866;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TPaGwibtFzl6QG5n1LYkb3WkddCdF8ida4bbEeofF8o=;
	b=Wb67pB3igUlYkk2Y0spvehBMdfgiLjzxwgSFr8qL3ZJOLrU0SvEGzybHB9T2nrTjyTgkbo
	y8Y1y2w6qsgxvVd3miTHwfxQaEeh6st570NCz3ZuJUkh3eP/rfegEyMs2dLsqb5iXGzvMF
	r/DvirhfxfDIb4doYaRiWZOZ3mo6dHE=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-495-izaeVmVuOH2TMkPT6AvGSw-1; Fri, 29 May 2026 11:01:04 -0400
X-MC-Unique: izaeVmVuOH2TMkPT6AvGSw-1
X-Mimecast-MFC-AGG-ID: izaeVmVuOH2TMkPT6AvGSw_1780066862
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-45eea62dc50so1457998f8f.1
        for <mptcp@lists.linux.dev>; Fri, 29 May 2026 08:01:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780066862; x=1780671662;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TPaGwibtFzl6QG5n1LYkb3WkddCdF8ida4bbEeofF8o=;
        b=CF6WxH3PkdFJP7m2SYYv5YypCFUeKsqkPf4GFt/9Wn09k00eKZfx2xuljuBFBNsxyd
         GMn0Ja49DPbzH4EwueujoNZ+vMdlC+ICEl2mNDTo4Q2rvii1xNfu5d2SLZJdTVz21YA3
         XZ0VotTAYcE3nPPo2IMPfJg3ooxLgGwrRAdJe5Rgr1v9r4GYapFaYjnyWKjj3V7XJ3XT
         PtHeUnEXbXac/b0yScDP0xEHSXehryCMq+KzYK2UY40uyhD0CvDr4Br3DQtM1yldRjk0
         Q5VRYi6qFOjm5ugL+Ke1nHVYjILQnql8Ur4FjBUwyGzp07Gzsam6lcCL/XhKDb0atQZS
         +wgw==
X-Forwarded-Encrypted: i=1; AFNElJ+VdBN81bv29JJkkBY0Z9LwCpY9CnUbwtPau4Pw/AYDhJV2uAlO3ytj9fxEoi7Z5XaK61OGpA==@lists.linux.dev
X-Gm-Message-State: AOJu0YySZq77N2QlDhAbDqeXNb69mcKP7fuV+DRDY4ZDRn33pEhP12jo
	1/FwX8TR2W1mlqHKQKTFhuDdLg9EukLt0kqatAwQKlWxj0pgS/W7bXQfy7+T0o4erZFiza0TwXu
	nAjQDg/ESGBINERzG+OsZ6cLmBUcigaEBLrcbMSJPXDBAnvGBYE3wFdZ5fn76v8qO
X-Gm-Gg: Acq92OGePzVhUuq/MDu93D8vzTEIqPKwnKoY33v7cZ+v8oyWoLCZ9LYJZSI4gi3QAB/
	Uy4ejYjOwW0ma/YqJaLrIRNqdj5rVpuuFTyBv/+AcF4/lPF7BemviqGiYxmXygCIQCT+IVGXupZ
	gdjRrD4RjggL0WejgJHkNx6xTzGlkqcZqqg+idbj8yNt/WEElLdjKdE0uViJutYGH20NkfTwxkw
	DOXOVgsm9oO+JxIAKQ0rLoupPU41/mo9loOIXySf8hvV812ZtLyZG1aArBv/2fs/tELSQX7VpU6
	mVXWNlcvEcuho59HjGePJfSkMHwwNucL3ET/r8ugGyv6gUDibBMYDNRnt1j3Eme8A7W8/TnGY01
	wTza/ZA53KuTIrm6L9x+cJnOUHpPepRrrxVay9aaDYwtgQBFhrKO60q5bbDvLUDZQRKsz
X-Received: by 2002:a05:600c:34cf:b0:48a:563c:c8c0 with SMTP id 5b1f17b1804b1-490a2901abcmr465985e9.7.1780066861080;
        Fri, 29 May 2026 08:01:01 -0700 (PDT)
X-Received: by 2002:a05:600c:34cf:b0:48a:563c:c8c0 with SMTP id 5b1f17b1804b1-490a2901abcmr460135e9.7.1780066857054;
        Fri, 29 May 2026 08:00:57 -0700 (PDT)
Received: from [192.168.88.32] ([169.155.232.197])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4909d68b853sm47864665e9.3.2026.05.29.08.00.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 May 2026 08:00:56 -0700 (PDT)
Message-ID: <abaf1bd3-58fa-4161-a1c0-18bebf4608ae@redhat.com>
Date: Fri, 29 May 2026 17:00:55 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC mptcp-next v22 18/20] selftests: tls: set timeout for
 multi_chunk_sendfile
To: Geliang Tang <geliang@kernel.org>, mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>, Gang Yan <yangang@kylinos.cn>
References: <cover.1780052851.git.tanggeliang@kylinos.cn>
 <1f8df4b64bc23644c48b25a8a3fc0a4ed8611cb9.1780052851.git.tanggeliang@kylinos.cn>
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <1f8df4b64bc23644c48b25a8a3fc0a4ed8611cb9.1780052851.git.tanggeliang@kylinos.cn>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: JHOxQkUyHhB9SVDIizCSMVloHEB43jz_13xtZYB8GVM_1780066862
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/29/26 1:14 PM, Geliang Tang wrote:
> From: Geliang Tang <tanggeliang@kylinos.cn>
> 
> The multi_chunk_sendfile test can time out with the default 30-second
> limit when run on certain configurations (e.g., MPTCP). Add a 240-second
> timeout using TEST_F_TIMEOUT to prevent failure:
> 
>  # multi_chunk_sendfile: Test terminated by timeout 30
>  #          FAIL  tls.13_chacha_mptcp.multi_chunk_sendfile
>  not ok 204 tls.13_chacha_mptcp.multi_chunk_sendfile
> 
> Suggested-by: Paolo Abeni <pabeni@redhat.com>
> Co-developed-by: Gang Yan <yangang@kylinos.cn>
> Signed-off-by: Gang Yan <yangang@kylinos.cn>
> Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
> ---
>  tools/testing/selftests/net/tls.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/net/tls.c b/tools/testing/selftests/net/tls.c
> index 4ae7505846f9..6f51da27ef1e 100644
> --- a/tools/testing/selftests/net/tls.c
> +++ b/tools/testing/selftests/net/tls.c
> @@ -536,7 +536,7 @@ static void chunked_sendfile(struct __test_metadata *_metadata,
>  	close(fd);
>  }
>  
> -TEST_F(tls, multi_chunk_sendfile)
> +TEST_F_TIMEOUT(tls, multi_chunk_sendfile, 240)
>  {
>  	chunked_sendfile(_metadata, self, 4096, 4096);
>  	chunked_sendfile(_metadata, self, 4096, 0);

Is this still required? in my tests since v8 of the stall patch I could
not observe any long timeout anymore.

/P

