Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E9A6AD25
	for <mptcp@lists.linux.dev>; Wed, 14 Dec 2022 17:38:24 +0000 (UTC)
Received: by mail-wm1-f50.google.com with SMTP id o15so11885126wmr.4
        for <mptcp@lists.linux.dev>; Wed, 14 Dec 2022 09:38:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7qwGHtSq3U6RgQEUvvc6z4ceKHfaenKIbUU58jtbj9A=;
        b=mOGXdd63zcjXTLZrVL8QaalVBOcmuE5GhHaEH5mnFcbGnXlF5ctKrVXERRNap5WEPd
         xV6gELsxpiRBEjZXfFiTXGnHczwS761UcRFrsamvgYeJwxXGH0cLGRdFlvbNaft4xmzA
         Z65g9TJ3omSNny2lfcsoWrhR2srfG952IZDx4YlxecH0EGPerD06IRmBTYVMwRPeX5ea
         VTCSgC9V8jQ0nFZiAOgnuuWSWCTVtvonquYCt3s01xudO2j/mCgQ6gaots13qP1fZuib
         kfyn6nYV1P3vi0wyT8zKKgsxkap1ZDbINTgKpB4tzq5Frw7makwvOSyFJTfnXCrrv3fp
         RQpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7qwGHtSq3U6RgQEUvvc6z4ceKHfaenKIbUU58jtbj9A=;
        b=ptil6b5zXozeZrb6DB09SqRdODdZIhYZqLxR5CRQAMZaVPpJV/JjDhSc0OwvjAsJ98
         ea4LWbd56c+lUXk2NqB54USQ4yrtVuXVdBB6cpshbzecAuXtS1XGoprA33yU5qwB3Ce2
         1jaiiD5KeRS3OIEo1itWZg/CJ974wgOeewnnVCoPJMGRLoFetHOTNGX2Ea7a84K3qABk
         XYVDLU96p6SIt+dz1MxHtOFov5Wev00xMZ2RUtvfu5QlCs0DPAgMXpK56maxJUBTfQpj
         omf+7yQ2JJ0cXSi0mV/EFNNc1ktMxDnUNsOiUSKssJizPpQ0QX8kGNoArV5Whs5AjkB2
         qlBA==
X-Gm-Message-State: ANoB5pl27asdYIzrkbwh2Muv08Y9H3+QPQF2ifGWFLzmzk1eiz3qjZe/
	5nX6IZ7OCFcQLMzVvu/I2qFhN9PRGxDGI6QM
X-Google-Smtp-Source: AA0mqf6kxYlXbQMH2YMblq9pe4ltcbDtiyZZO2JJQsg+pcTxOHlDFAGC/CbirVVZ8AB6Mz5zW70W5A==
X-Received: by 2002:a05:600c:2ad6:b0:3c6:e63e:8163 with SMTP id t22-20020a05600c2ad600b003c6e63e8163mr18890422wme.26.1671039502529;
        Wed, 14 Dec 2022 09:38:22 -0800 (PST)
Received: from ?IPV6:2a02:578:8593:1200:22af:65bc:a1dd:1562? ([2a02:578:8593:1200:22af:65bc:a1dd:1562])
        by smtp.gmail.com with ESMTPSA id t7-20020a05600c198700b003c6f1732f65sm3933330wmq.38.2022.12.14.09.38.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Dec 2022 09:38:22 -0800 (PST)
Message-ID: <0fe3ca2a-ada9-561b-8cac-ef32678dcda8@tessares.net>
Date: Wed, 14 Dec 2022 18:38:21 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH mptcp-next 0/2] two small cleanups
Content-Language: en-GB
To: Geliang Tang <geliang.tang@suse.com>, mptcp@lists.linux.dev
References: <cover.1670575887.git.geliang.tang@suse.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <cover.1670575887.git.geliang.tang@suse.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Geliang, Mat,

On 09/12/2022 09:57, Geliang Tang wrote:
> Two small cleanups.
> 
> Geliang Tang (2):
>   mptcp: use net instead of sock_net
>   mptcp: use local variable ssk in write_options

Thank you for the patches and the reviews!

Now in our tree (feat. for net-next) with Mat's RvB tag:

New patches for t/upstream:
- 3f76289942fd: mptcp: use net instead of sock_net
- cd700ab87ddb: mptcp: use local variable ssk in write_options
- Results: 3f302724c1a3..652f1687a656 (export)

Tests are now in progress:

https://cirrus-ci.com/github/multipath-tcp/mptcp_net-next/export/20221214T173738

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
