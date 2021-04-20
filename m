Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31FCA2F83
	for <mptcp@lists.linux.dev>; Tue, 20 Apr 2021 19:13:27 +0000 (UTC)
Received: by mail-ej1-f46.google.com with SMTP id g5so53219175ejx.0
        for <mptcp@lists.linux.dev>; Tue, 20 Apr 2021 12:13:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20150623.gappssmtp.com; s=20150623;
        h=to:cc:references:from:subject:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=vczNUuXgCj0v3TjbzaovxdNOinglpJiC5YRKhR1oXSw=;
        b=Rmv5DAU0YOu9DuCRtLZd2qz1I2vX5fMrCrtaRMqiQBeKe5ctFpniCP4C73mY+WKezw
         YmvYOhgCgtwDUl8OKcpxPP/7a5DTMN1cKcv6fxCU5JXuHXgqGV1oKcSM/H1efZW3DJfO
         p0s4yNDRxy9O0wJq+GRgPH4/imrSFUtZQu2k8+JJ3aMAE41S2+BM9lUkvMmXSaAcOPGe
         i8gPnkqdPjlA0G5M5Uidqpcva/evDjgwcV6Uz5ORJqw7bOnEHyfDsBuA5TLkjXdXPazN
         Bo6sUEvtIBOyoP0kV96K1uMTtFwexyqtIQY43S1uPScBEGVk0l4nghJuxuJ9lAzPM8a5
         wUYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:references:from:subject:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=vczNUuXgCj0v3TjbzaovxdNOinglpJiC5YRKhR1oXSw=;
        b=qQPGMruAYazbPnYZOBxknchfd7jXk/nZ19D3z4D6vE/r+SOAXG2fCpgaOta9fEFl/4
         9sv8LOw7YkX83a4W89E9Dck2xASgGjFThepefClLVyEx49U5ZlxqMdK8NaS3KsCTYq2y
         iNX7OD+1phb5sYebSyEYCSrlkFg4xVa39PLsIIlU67d7j/i9eucW/8H/QwmH1HX2Z9Py
         CD7pOv/FGYjlVAcLLbuDjVOlnpJdMXgYx/0UMoRt27U8/4sLvQ2srwKrFbatgO/mZiiy
         HhQY1VExNQE5uCzrMdJBhTgsDgCsWr3Y4otYParyzE/OmzcGMore9JqO7W9ZDrP9lTW2
         mpcg==
X-Gm-Message-State: AOAM532/d4NBOgqYDHhQ3wQrrWfEvJby+SgLbAd26W/z7BjdobDEmjBa
	IlR1D4fq26EBbWekaSfNfIAKrhXD5o+qHQXFOoA=
X-Google-Smtp-Source: ABdhPJyEsFd4vu+IshP2h+36kGDYHmOVhrrZZPDyEXopjZb8hQN3qw54YWP+WS1P0uJDddA34Q9CAw==
X-Received: by 2002:a17:906:28cf:: with SMTP id p15mr30548417ejd.191.1618946006081;
        Tue, 20 Apr 2021 12:13:26 -0700 (PDT)
Received: from tsr-lap-08.nix.tessares.net ([2a02:578:85b0:e00:ad10:5b35:8c26:bd5b])
        by smtp.gmail.com with ESMTPSA id u24sm16759670edt.85.2021.04.20.12.13.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Apr 2021 12:13:25 -0700 (PDT)
To: Jianguo Wu <wujianguo106@163.com>, Paolo Abeni <pabeni@redhat.com>
Cc: mathew.j.martineau@linux.intel.com, Florian Westphal <fw@strlen.de>,
 mptcp@lists.linux.dev
References: <5533e6e3-b94b-4fdf-a4b9-a4fcda4ec09e@163.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
Subject: Re: [PATCH] mptcp: fix pr_debug in mptcp_token_new_connect
Message-ID: <5fd55bde-467b-398a-1164-bb3818f9abee@tessares.net>
Date: Tue, 20 Apr 2021 21:13:24 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <5533e6e3-b94b-4fdf-a4b9-a4fcda4ec09e@163.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 8bit

Hi Jianguo, Paolo,

On 20/04/2021 12:08, Jianguo Wu wrote:
> From: Jianguo Wu <wujianguo@chinatelecom.cn>
> 
> After commit 2c5ebd001d4f ("mptcp: refactor token container"),
> pr_debug() is called before mptcp_crypto_key_gen_sha() in
> mptcp_token_new_connect(), so the output local_key, token and
> idsn are 0, like:
>   MPTCP: ssk=00000000f6b3c4a2, local_key=0, token=0, idsn=0
> 
> Move pr_debug() after mptcp_crypto_key_gen_sha().

Just applied in our tree with Paolo's Acked-by tag:

- fc7e4b80941e: mptcp: fix pr_debug in mptcp_token_new_connect
- Results: e69889ce0094..1545a167aafe

Builds and tests are now in progress:
-
https://cirrus-ci.com/github/multipath-tcp/mptcp_net-next/export/20210420T202113
-
https://github.com/multipath-tcp/mptcp_net-next/actions/workflows/build-validation.yml?query=branch:export/20210420T202113

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
