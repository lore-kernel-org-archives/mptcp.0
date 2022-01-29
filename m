Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D24012C80
	for <mptcp@lists.linux.dev>; Sat, 29 Jan 2022 11:48:25 +0000 (UTC)
Received: by mail-ej1-f52.google.com with SMTP id me13so25435585ejb.12
        for <mptcp@lists.linux.dev>; Sat, 29 Jan 2022 03:48:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=KMWd6Jpk5nQ8jkBbkTr8c4SP/Av+op+IpDlzmze/ww0=;
        b=lgFDlivOXucEkNbqdi5uUalB9nUULOitsPXLLfetXVpQX1MpXC6UPyZltHn4A5tCmt
         esT0Yjfigt+A8sSAGDqr8SLky1EwtAjxeWSWW09fwHrIeUK5iatqC84c1izZfPGVoG2v
         Bl0EqVrMbFuTqt2Ng5PbWpy0XrwUBJI1rr5RXdcb9Hi7eQUNtdabiBNpm/LYBMlRP6o+
         hL0n2M5DB6vmb0xymkfLIX7a1gT7GAQzzTo7PfTzOugBTwwwyBvpyepgyt7yZCsTj8Tj
         QWaP8e1cJr6WwKxAcsJiBrHK2z5bzffWW5ETbQrlEJB0JFOqv0CYY87SnXFloLwpiE4/
         PRSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=KMWd6Jpk5nQ8jkBbkTr8c4SP/Av+op+IpDlzmze/ww0=;
        b=t4X98uGQEYBVQdd5TwERKgEaPiFj9eOTel2aJyOcG5Ojo5i1xPn1bhdLls4l2O0l1m
         xj7HLzFGT1+hDfOR1BYgW5YDoQQW5Hx3f8Lq5MrqdCwYw+rFHvm3KVzu1rS9fZUTs8ec
         ZRwaGpB6W001UXhynihtW19KOH4RY9CbTIwndR+njhi5Izpn8A9IZWrj3Z7gXMAbuCsi
         mz6HQdB36wsnGAGOcIv6/kceCg+yj0hfpjC9ge0W9TwDHAemPaWaloduzAu+f3QWIrhQ
         ghDnP0Ne5DULhWp9TUFCRxJFfNnI6vVg9OU3X0GsC4T3vRSd4VlPBYWpzyy5G5+/OSj+
         Ofwg==
X-Gm-Message-State: AOAM533uhnkdpxiTmK6BbgoYtwyZNS+HYaKGEmQu5zwUV9IaKrVlA0QA
	HsX3kA2s+bsQtrwqIRPGcPTzsqkykppD9A==
X-Google-Smtp-Source: ABdhPJyOvaDRnT2aGWGgTzKxhGQGjVjlR2OwYxjjI3bRUcDGJWA3rfoDPQwHRZzEc3Mkpfwm5PEaqw==
X-Received: by 2002:a17:907:7e99:: with SMTP id qb25mr10125916ejc.210.1643456903387;
        Sat, 29 Jan 2022 03:48:23 -0800 (PST)
Received: from ?IPV6:2a02:578:8593:1200:aba3:53e3:9ad4:e385? ([2a02:578:8593:1200:aba3:53e3:9ad4:e385])
        by smtp.gmail.com with ESMTPSA id lt12sm10923988ejb.166.2022.01.29.03.48.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 29 Jan 2022 03:48:23 -0800 (PST)
Message-ID: <d8a8dac4-b68e-b89b-d78d-8aa8495eeda5@tessares.net>
Date: Sat, 29 Jan 2022 12:48:22 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: mptcp: use nla_parse_nested: Build Failure
Content-Language: en-GB
To: mptcp@lists.linux.dev, Geliang Tang <geliang.tang@suse.com>
References: <022caed0c9e5964f525336aced8233338c29386f.1643437533.git.geliang.tang@suse.com>
 <6a2c2ab3-1d18-0e29-5cb5-c3a7ccccb0d4@gmail.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <6a2c2ab3-1d18-0e29-5cb5-c3a7ccccb0d4@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hello,

On 29/01/2022 08:18, MPTCP CI wrote:
> Hi Geliang,
> 
> Thank you for your modifications, that's great!
> 
> But sadly, our CI spotted some issues with it when trying to build it.
> 
> You can find more details there:
> 
>   https://patchwork.kernel.org/project/mptcp/patch/022caed0c9e5964f525336aced8233338c29386f.1643437533.git.geliang.tang@suse.com/
>   https://github.com/multipath-tcp/mptcp_net-next/actions/runs/1765070423

The issue is not in the code but due to patchwork. I don't see this
patch there, nor on lore.

You can ignore this.

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
