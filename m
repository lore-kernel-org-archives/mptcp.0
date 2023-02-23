Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2731258F
	for <mptcp@lists.linux.dev>; Thu, 23 Feb 2023 13:57:38 +0000 (UTC)
Received: by mail-wm1-f45.google.com with SMTP id m14-20020a7bce0e000000b003e00c739ce4so8251248wmc.5
        for <mptcp@lists.linux.dev>; Thu, 23 Feb 2023 05:57:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UbcvmyhmGRSLBr+eAltWguFjXpBODgvjSkirdJBFF3c=;
        b=SMnUko1qXbILEESCBZPZsSHp/dgRXD1gSLR7+GdKSNu1pXzY4fxYxb7RdGBUbrYaQk
         NIeJHF+5VjKVufi4ByiwuyTMwEAfkHuaWKAsHhfOhgNyUl3A8LpwkXdLuECg7uX2tSkx
         +GKBQ8s1HCWeadXaEMzXEezCI0C8vuRBazrRtvlitO/EIQADutPOJ/FuXc2nTChJpY33
         c2gjVdSQ6KxlyFuLJr0//FGcswFM58jBd2Hi0HfaY+AbTeOyhUH9lvVg+N+pKsu7wUs8
         kFj6wlyIOmONkleFroPJuB5LfEQ6yIXdsIIX3MxzIMWrK0rhIxaPu/mi7BltujMtUD13
         zV6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UbcvmyhmGRSLBr+eAltWguFjXpBODgvjSkirdJBFF3c=;
        b=GudmYQ3EEeujZEKkrWiv1OlT/FbCfdHV4FlDhgXn5TgP8y7ChvknO9khFdFhipxNem
         s8VWCjqItf3dsU9HUrBszFjQkEFSEglE80FTCOEMjw4LgCMrhd32zqySJdBRP67U1V+D
         xQQk0++Dk0m1/VwjB7iiJ7gauBbk5CCWWMLlImTFM6ipvC0FjEE/sk/N7Gdzi4B7T/k5
         /ZXi1Rt6UOhY+fmKozeupGONU04uVQ8BD8/ptAfyorq7mMpK/x/2+U3vEA4SVVGJ3Ml6
         JR7M8vqhfApC4bm4YimYAsD3pTNMKvdAz4LD+jyybCzaXWzVEfvXdyPPDUOk0OEu76ce
         L0ww==
X-Gm-Message-State: AO0yUKVSDjasyL1baUT01jTB1DapQzKlQM/1fwjMC6+mIJv00AI64Qo0
	rZC80MHHaPMBNguwS/bzoZ2F5RBmmGfqt1/9EFE=
X-Google-Smtp-Source: AK7set8P6OcN4GDNoir3eEJqb4sbhD+pcuxjw7YoKxiD23S65ACFB72fZGmekO8G9xNemmqKVZQP1w==
X-Received: by 2002:a05:600c:44d5:b0:3e2:185d:7d1e with SMTP id f21-20020a05600c44d500b003e2185d7d1emr9241018wmo.11.1677160656818;
        Thu, 23 Feb 2023 05:57:36 -0800 (PST)
Received: from ?IPV6:2a02:578:8593:1200:b5a0:3898:2dad:3d15? ([2a02:578:8593:1200:b5a0:3898:2dad:3d15])
        by smtp.gmail.com with ESMTPSA id r125-20020a1c2b83000000b003db0bb81b6asm1722490wmr.1.2023.02.23.05.57.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Feb 2023 05:57:36 -0800 (PST)
Message-ID: <4ff31862-96a4-53d2-37ce-9fd69c38c7ae@tessares.net>
Date: Thu, 23 Feb 2023 14:57:35 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH mptcp-next] mptcp: add ro_after_init for
 tcp{,v6}_prot_override
Content-Language: en-GB
To: Geliang Tang <geliang.tang@suse.com>, mptcp@lists.linux.dev
References: <f2d3a14b9382645f8770ad6496fcba6db699ad19.1677123443.git.geliang.tang@suse.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <f2d3a14b9382645f8770ad6496fcba6db699ad19.1677123443.git.geliang.tang@suse.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Geliang,

On 23/02/2023 04:37, Geliang Tang wrote:
> Add __ro_after_init labels for the variables tcp_prot_override and
> tcpv6_prot_override, just like other variables adjacent to them, to
> indicate that they are initialised from the init hoos and no writes
> occur afterwards.

Thank you for the patch!

Now in our tree (fix for -net):

New patches for t/upstream-net and t/upstream:
- 14b7f49f8c61: mptcp: add ro_after_init for tcp{,v6}_prot_override
- Results: 32f1046d667c..2d0e2918d1a9 (export-net)
- Results: 7264bacd3544..e438a165544f (export)

Tests are now in progress:

https://cirrus-ci.com/github/multipath-tcp/mptcp_net-next/export-net/20230223T135546
https://cirrus-ci.com/github/multipath-tcp/mptcp_net-next/export/20230223T135546

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
