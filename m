Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3D1514F94
	for <mptcp@lists.linux.dev>; Tue, 29 Aug 2023 17:03:16 +0000 (UTC)
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-31c615eb6feso3876870f8f.3
        for <mptcp@lists.linux.dev>; Tue, 29 Aug 2023 10:03:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1693328594; x=1693933394;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:cc:references
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Q8yMJcBrJdh0AMEUVKkqh9LUAWmiBC+9ZfXGbxF5368=;
        b=JXYGRfTaHeTCkDVkJeCVNfUIUsZcyJT2hlq0inmsaOlw7rqOPHCp01RPBfaUcJgYXK
         ujZETCHTXDyT5azxoGKGlnOboi5RLJD1OUpzNBZuwCkq3bIbvJwe8oJ6VE4qAsaAEhnI
         1MBYozNUUIFNC+p9NFmRnC60DRiASbHyfcs5yi/TZY6+T7O/FvaP5n/6uw2ow/nbzaEs
         E5OJGWXLsdd7TQWm3Q6jrEdf/CcmN+P73C0lKPFxXQj1PXO8BRrX+p1TCARQ7hOYvXju
         NxhG5dgHy/bC5u1Np8ueFtZ5YmurI1elSn6GR4+AXg9UcxJI9nMYn3Xbtrj+YTu/8DEH
         o0wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693328594; x=1693933394;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:cc:references
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Q8yMJcBrJdh0AMEUVKkqh9LUAWmiBC+9ZfXGbxF5368=;
        b=VAdI52kUJy5n8n7KOYO0OPpLTmIgHv9gN+ktV1C7yf3+0S1qy6YUNdLshenvCi/uqM
         GSAV8llTIJpKO+ono5r2O3cXEZTBRqaSXMbHrYZCaCzZaiCX7jOhXuFeBuJa9HZOvTwv
         FpdFwFKqXL5ohamWW4DK5Us+6LWtECAR614f9OItUBlBxedRf/LHPSAQCHGl0hgHxjgF
         9ZKIlnmIlv2/9jBpAaXVeWOnvMczQ/ztIEAJFY1C1xQ04uwZsKm5YqXf68Y6oiq+TSlX
         UkQG/hzKVcjPnKtc29PIf3P5LWVuuTg1+zW8lfU6A0WYpumCfBTERFheq6Yy8Rjg9dXS
         u4RA==
X-Gm-Message-State: AOJu0YwxsMCWE71MWmCU4Cgnkq005LaBgtbJWrUdCgwNS9Ob3+36qMSE
	v/X1x38/HYEv6VwuU+XqjvW6QjfNgbMwMe6adrU=
X-Google-Smtp-Source: AGHT+IEZ9nKdUV5EHResY+Vg6ryn+mRWFuqVAdTPIYfi5BlGThLpsFtVtjPzcU9IE4Yq1b6QlkDElw==
X-Received: by 2002:a5d:6911:0:b0:313:eb09:c029 with SMTP id t17-20020a5d6911000000b00313eb09c029mr21441042wru.43.1693328594575;
        Tue, 29 Aug 2023 10:03:14 -0700 (PDT)
Received: from ?IPV6:2a02:578:8593:1200:2f72:9e4e:9104:797e? ([2a02:578:8593:1200:2f72:9e4e:9104:797e])
        by smtp.gmail.com with ESMTPSA id z12-20020adff1cc000000b00317f29ad113sm14315892wro.32.2023.08.29.10.03.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Aug 2023 10:03:13 -0700 (PDT)
Message-ID: <aa25a5ae-6438-4420-b4d2-738b745f2186@tessares.net>
Date: Tue, 29 Aug 2023 19:03:12 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH mptcp-net 0/2] mptcp: fix missing close transition
Content-Language: en-GB
To: Paolo Abeni <pabeni@redhat.com>, Mat Martineau <martineau@kernel.org>
References: <cover.1692690157.git.pabeni@redhat.com>
Cc: mptcp@lists.linux.dev
From: Matthieu Baerts <matthieu.baerts@tessares.net>
Autocrypt: addr=matthieu.baerts@tessares.net; keydata=
 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
In-Reply-To: <cover.1692690157.git.pabeni@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Paolo, Mat,

On 22/08/2023 09:43, Paolo Abeni wrote:
> This is an attempt to address the 2nd issue reported in:
> 
> https://github.com/multipath-tcp/mptcp_net-next/issues/427
> 
> See the individual patch changelog for the details. The cover letter
> is here mainly to trigger the CI.
> 
> Paolo Abeni (2):
>   mptcp: move __mptcp_error_report in protocol.c
>   mptcp: process pending subflow error on close

Thank you for the patches and the reviews!

Sorry for the delay, now in our tree (fixes for -net):

New patches for t/upstream-net and t/upstream:
- 9e7269dca15f: mptcp: move __mptcp_error_report in protocol.c
- 6106d8bdbfcf: mptcp: process pending subflow error on close
- Results: fa580ac35599..d415340e7fb3 (export-net)
- Results: 54ea4fcf4272..93aaf3d1e3d6 (export)

Tests are now in progress:

https://cirrus-ci.com/github/multipath-tcp/mptcp_net-next/export-net/20230829T170007
https://cirrus-ci.com/github/multipath-tcp/mptcp_net-next/export/20230829T170007

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
