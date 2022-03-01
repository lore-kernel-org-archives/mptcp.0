Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAF455A03
	for <mptcp@lists.linux.dev>; Tue,  1 Mar 2022 10:06:20 +0000 (UTC)
Received: by mail-ej1-f53.google.com with SMTP id p15so30408946ejc.7
        for <mptcp@lists.linux.dev>; Tue, 01 Mar 2022 02:06:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=voAm566RLg/qx4QuW0UWRuYk99PuDgRyYLD+Tyc0DkM=;
        b=mtcHzvh8ox0JnKz6M2sML2tTyVBeiS2B4ggHEhrDXjVsWnyfg9AintG24PufaY0Fij
         f4oYmBhCOsQfqIuWeR96gu72TnXHBOblCLTEqAgGbKKRUIXdNDeI6AxZEZDFfLVMSSCZ
         6wt62nBmUMGPlVrhCp90TyGL5qiptCAUqQndCdZVPNHZPsBkLX6ixN5lC7zU7F8OV5lg
         SXp4pgoQIp1zg1FGwkAqauZFBeHuaKHMVy9IMaG5uqyCQ5dZ7DeszAtvFI0Vnfn5mTQz
         vXX/5rEbcXvOg7hTG8r5vJgG4v1cgGaKbY1DnaN502YgWbyWd9SSmvko5/a8tu7xarRw
         WGgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=voAm566RLg/qx4QuW0UWRuYk99PuDgRyYLD+Tyc0DkM=;
        b=JbACtZUMDV5//tfWtpdP/BnQ/0j1mp0h3qOAwGX5CGcpgBU0y9XRMzZlfgW8n5rX+n
         OM/oLCjJjZnFPSFdznhDMg65lvE+OFD+l/KDzDw+KV7NceTaOB9YOUqv1R0xc3o8nNIB
         g2ZAQ/5Q++V6uJYCJeYv6RrRdJYSbG7bgsQCbVKJ0D6TSEWsJVw2e8c7OMR6nWZOc0Hf
         nvYOIgX9Kh6bZLUsGr3itAyqzJyWKm2cvrDwF+9f9P9m+GU8Jsz0E009hCvycMDPdOZ/
         ankxCKf+Fmwqt1jfpRXE0eEuV7azFef33xgMJcgpB4njsI6mjogR1jx6ilGNgXcT3vFM
         dDaA==
X-Gm-Message-State: AOAM530mK19IffS5gT7fSP4L3ox+eLHmJYnEJzRQhZX50bLXJvS+RG4L
	vxRNDYAWrOxA9S9tEyr41L+VTLH2tGHrezqz
X-Google-Smtp-Source: ABdhPJyqjUwvXsUL+roJPtz1zXREe+g+Dk+6uRfmVtWnc/9CYkQvMK1afJ7GM3mAsSA0yEzEArrvKA==
X-Received: by 2002:a17:906:9ad4:b0:6d6:e972:a9e9 with SMTP id ah20-20020a1709069ad400b006d6e972a9e9mr954027ejc.669.1646129178759;
        Tue, 01 Mar 2022 02:06:18 -0800 (PST)
Received: from ?IPV6:2a02:578:8593:1200:9adc:7cd9:4239:a8d7? ([2a02:578:8593:1200:9adc:7cd9:4239:a8d7])
        by smtp.gmail.com with ESMTPSA id z11-20020a170906814b00b006a6be1e0f86sm5132093ejw.132.2022.03.01.02.06.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Mar 2022 02:06:18 -0800 (PST)
Message-ID: <ca21a6c9-e347-c29c-80fc-45ab4876a595@tessares.net>
Date: Tue, 1 Mar 2022 11:06:17 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH mptcp-next v2 0/2] fix libbpf 0.7 deprecated warnings
Content-Language: en-GB
To: Geliang Tang <geliang.tang@suse.com>, mptcp@lists.linux.dev
References: <cover.1646058641.git.geliang.tang@suse.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <cover.1646058641.git.geliang.tang@suse.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Geliang,

On 28/02/2022 15:32, Geliang Tang wrote:
> v2:
>  - update the Makefile as Mat suggested.
>
> Geliang Tang (2):
>   bpf: examples: static library link to libbpf
>   bpf: examples: fix libbpf 0.7 deprecated warnings

Thank you for these two patches!

Just applied in our repo ("scripts" branch)!

While at it, I added a few other small patches cleaning up the Makefile.

For patches in this "scripts" branch and if it is easier for you, you
can also propose a PR on GitHub.
If you prefer continuing sending patches by email, please use
'mptcp-scripts' instead of 'mptcp-next' to avoid confusions ;-)

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
