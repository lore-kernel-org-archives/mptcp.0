Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3F8670
	for <mptcp@lists.linux.dev>; Thu,  6 May 2021 14:30:56 +0000 (UTC)
Received: by mail-ej1-f52.google.com with SMTP id n2so8585884ejy.7
        for <mptcp@lists.linux.dev>; Thu, 06 May 2021 07:30:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=jUQetYBGzOO2yl4dYNvvPwx5XB+lGtRY2rUUdYBpkwk=;
        b=hNt3nMoQPCARVLlmmafD32BXft192SVjab9VR8UoD48TntYpprcOLIdqjqN3g8sB0o
         ypm9w+WcpG3HNxObxZLi4K2nYmXFMfq82VOCtYtJ/cGx4s7T9vmodtFi9CTBd+2T7fYo
         MtBeq6a56SV1Lb+NJpTfq0ioG6AnwxRadOBYNxYz8Yf2AoRrY/bL17aC8YQTCVX+y3nu
         VJiHia4MPnU7gtBynkBNzUnNwUX0qHWx/7IyuVttMqXCbtBYdGca37gHBRWLLd2yM+B7
         h4Fn3LGhepmjhT/S35OiQ1xzplaTvF7E1+Tv2tapVGvyI4Pa3QSxDKgM1SjKwgDS1scp
         1EkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=jUQetYBGzOO2yl4dYNvvPwx5XB+lGtRY2rUUdYBpkwk=;
        b=CsEd+GAL+joD6WBs+Rncz+YYBhxXWMsbaXnq9UOnunIQf/9oQyoLAY/d62stACkt3E
         6MD4u0PjaK8sBTLbIyutWYCM1iOUVQLvofn11pso6nMgSS3Ye3PLSB78/ivGomlSi/NA
         9E7kKmXza9wgAG5SJnFrYt7tY+uH9xjMnQzOIXakvGlGI+oEL+9wQ7GhyyTTXiECj+CJ
         I2+I3LXl5ugts7ZZF/SroIktMFygdaTKb0aQ72awlKYFXotWoBixKj9CZ5X98VqKiwrG
         c1IAArfoZ9GdbFIdHWy7XvJditYBMM+ZHILoSW3TAFLG9WuNV4BVQH5uQRsoz/a3Tho8
         v3/g==
X-Gm-Message-State: AOAM531QZO6To1L3KhsPvbeIQ+ChFmIeBWmfwYTSPFLcbo/fNCeCnhSZ
	xvLHcpML9eIu7Ad8ftpBswaD1b7y2Di9X1/BXWswQQ==
X-Google-Smtp-Source: ABdhPJyffKoaYRlD+yjE1eLBH9oHcOm2WcrCPhBE9u1jyLc/OclRiHyLmm0q5IaSUfyvBZ1TwT6Fzg==
X-Received: by 2002:a17:906:c1c9:: with SMTP id bw9mr4800467ejb.239.1620311455253;
        Thu, 06 May 2021 07:30:55 -0700 (PDT)
Received: from tsr-lap-08.nix.tessares.net ([2a02:578:85b0:e00:2955:d350:566e:2ff2])
        by smtp.gmail.com with ESMTPSA id u24sm1745509edt.85.2021.05.06.07.30.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 May 2021 07:30:55 -0700 (PDT)
Subject: Re: [MPTCP][PATCH mptcp-next] Squash to "mptcp: dump csum fields in
 mptcp_dump_mpext"
To: Geliang Tang <geliangtang@gmail.com>, Paolo Abeni <pabeni@redhat.com>
References: <7102b3cc726a2562a5903786de957852b9eec033.1620310714.git.geliangtang@gmail.com>
Cc: mptcp@lists.linux.dev
From: Matthieu Baerts <matthieu.baerts@tessares.net>
Message-ID: <0acfb7c0-9a64-85ac-9b61-0b0deaf94d4d@tessares.net>
Date: Thu, 6 May 2021 16:30:54 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <7102b3cc726a2562a5903786de957852b9eec033.1620310714.git.geliangtang@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit

Hi Geliang, Paolo,

On 06/05/2021 16:19, Geliang Tang wrote:
> Use %x for csum as Paolo suggested.
> 
> Signed-off-by: Geliang Tang <geliangtang@gmail.com>

Thank you for the patch and the suggestion!

- 4a14b5949e5e: "squashed" in "mptcp: dump csum fields in mptcp_dump_mpext"
- Results: 9e9ac1620af0..3ad3c4cba5ea

Builds and tests are now in progress:

https://cirrus-ci.com/github/multipath-tcp/mptcp_net-next/export/20210506T143039
https://github.com/multipath-tcp/mptcp_net-next/actions/workflows/build-validation.yml?query=branch:export/20210506T143039

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
