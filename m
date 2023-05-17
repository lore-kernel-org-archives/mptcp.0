Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FE40524E
	for <mptcp@lists.linux.dev>; Wed, 17 May 2023 15:08:03 +0000 (UTC)
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-3075e802738so882549f8f.1
        for <mptcp@lists.linux.dev>; Wed, 17 May 2023 08:08:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1684336081; x=1686928081;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EJqjOVBePfz2jxjORVuKMrVNzpTzxRVatxdNytCWOuk=;
        b=AGl4sH5Hschi9M4AI0s7qJT3v4lxnX8eFdA8GUmyEB8/35qT5NEkM1sPlRs7+O6iM1
         zLEs2LrCzXTe4sVWMODaW0W+bgz+C0QYm5Djz4MELFv9puoZUyCv5CuD1yIlHYm5SzUm
         FncNmNZwTutgYyuFHIdVZySqxCp8e4GeaZDe10/UMCtv4FrlU0S7iDJhYEIHUSyNh5vt
         weIx3j4uDeOFRhvvvFIePpdqgswknm6vnA9cTCd6PjKi5lRQ1cdG/tUreqme7AHL6shu
         47YNOElXZ/c+EZkXZzaKc9UQorsof/8P+g931meYUGMAReal+tJvMgZqoyVLPY/W+ERw
         xhrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684336081; x=1686928081;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EJqjOVBePfz2jxjORVuKMrVNzpTzxRVatxdNytCWOuk=;
        b=bl77PKqKFwrd4P3qo5UMo5raq57pZ2X0YtBGebQHMmBzXydGBeSilwHhn9oyetdZ8w
         uCQ6yZFgaSabqIyiJ7ZtiuMzTK1OBHEAQGXssGdf75PzaC1un3eoZ4++lFK/tq4WLtzE
         U6bWQA+FIPm/iWOdDxjqYYZasHfc69pCjEU0xBeV3Zd+xSGkYlEpjZ1Z76npEKBf1fSn
         EhmCEnBlJBNj+LkEEnzM6fnYCsYrNZ72Qg+o7+/AaK8EW8Cyqf4/y3vj6+Z9lljVQ8et
         bmR8iYtXOqLeNVR1wLn4WMW/+glAJQF6jc+nja8mj4eutueug9S/B5vFFbV1CmbINlJQ
         /6VA==
X-Gm-Message-State: AC+VfDxQHhfWUAANN8i7b6JKhEzy/qL7YAq7cnb++yHA0AvlixVKuE5H
	ofmf8YSw3e9sfh7vjwcz92hv1FrRbab4P8TOnAA=
X-Google-Smtp-Source: ACHHUZ559IzpgkTaxmVyD5fkZRfrgOtr/I5zIoYqhcNzdXV+3qbr1ucL/yH78U80VKuO34BCE925MA==
X-Received: by 2002:adf:f6c3:0:b0:306:3b08:6da3 with SMTP id y3-20020adff6c3000000b003063b086da3mr960890wrp.61.1684336081565;
        Wed, 17 May 2023 08:08:01 -0700 (PDT)
Received: from ?IPV6:2a02:578:8593:1200:a66b:672f:3b69:b6da? ([2a02:578:8593:1200:a66b:672f:3b69:b6da])
        by smtp.gmail.com with ESMTPSA id k17-20020adff5d1000000b003078681a1e8sm3185167wrp.54.2023.05.17.08.08.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 May 2023 08:08:00 -0700 (PDT)
Message-ID: <f2f7125b-a132-532a-bfb7-ae3f78b0f31b@tessares.net>
Date: Wed, 17 May 2023 17:08:00 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH mptcp-next v3 0/6] run sched tests in a dedicated ns
Content-Language: en-GB
To: Geliang Tang <geliang.tang@suse.com>, mptcp@lists.linux.dev
References: <cover.1684331602.git.geliang.tang@suse.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <cover.1684331602.git.geliang.tang@suse.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Geliang,

On 17/05/2023 15:57, Geliang Tang wrote:
> v3:
>  - add two helpers.
>  - drop sched_cleanup().
>  - the first two patches should be merged between the commit
>  "selftests/bpf: Add mptcp sched structs" and
>  "selftests/bpf: Add bpf_first scheduler".

Thank you for this v3, it is clearer!

I just have two small last suggestions if you don't mind. The rest looks
good to me!

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
