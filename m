Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0504C2F84
	for <mptcp@lists.linux.dev>; Sat, 17 Apr 2021 08:02:51 +0000 (UTC)
Received: by mail-ej1-f52.google.com with SMTP id v6so44099180ejo.6
        for <mptcp@lists.linux.dev>; Sat, 17 Apr 2021 01:02:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=PLuLkF1IGWypPI+HiFb6Lc3kbaqrvgXd5rUpp6F9OyA=;
        b=f+fB8uprWV4VzDEpOVgLGalnWXSkba8mHn2f/QgTiso7d+EBzMNLlXbHyXVbmU9/SU
         8Toc6/TybN0Tm32Iuf39deCQf/CDvKOghOYk/pRERBtjMI4iomcdBdGkpI3hsu/xHMOf
         sTO7wkJj0piCgTtOL5WwyCohvOpc8UATN2j/YyiyO/SK5AA1vlFQcUmohKN/aVRKLP06
         JNolTMYL+cDFXUHMbqMhXrxjLx7qwBxf9aQS73B2jyqg0tmHzReT8gPMYvFdxMIPSjca
         nT0j7cE4klZDLfvOJIcHP92M4tD60c+bZ4bv2m8nmToU3O0abLogE76OPzw8setdqz8l
         TJAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=PLuLkF1IGWypPI+HiFb6Lc3kbaqrvgXd5rUpp6F9OyA=;
        b=fP0vPHzLruFZ5u/8iyJV6OrMHwxtL7VbSt/k5ECrLgzRejgL0X4tVFxOZjlioCKV7E
         wUIeXTlhialrm30hqsnTH4RJ3DR0HdQVeqds3PUPjApwr5gLmLt54xSbUMZcyq5SNZQS
         E9UqbNrIpK25EAGPpkujMKSvBwm9lO5U0TSG7v5zARCMaAanLu6qUnrgP6kzZ+tqnj0w
         yl72z8IrqcC2n4j7lTJ5bkX5HcWtgU6j/+g4Q2u8bFLYzwknqHQhk1pUmGdN6sokovkG
         S0vlisMjsxJE61/6msDAkN3HRJ/o48neLC1AMDgdDylxDO4rPaHB2//1ou3kfcsVxPVk
         vFFQ==
X-Gm-Message-State: AOAM532boTl+j52mT21dEbgz2UHogilfvKxW8O40XeaLf2unwLhAK/Sv
	rg4HSFjt2JXCY5FPAtg2p8JDL79CkhPRG8Aa
X-Google-Smtp-Source: ABdhPJyIqgVZdxEPXFYbJlfPKeXXYMcbzGuCDPRZzGHX6+Kox4v/z173UZ4qXydlYv5wMfKAokc0oA==
X-Received: by 2002:a17:906:9a81:: with SMTP id ag1mr12006771ejc.464.1618646570130;
        Sat, 17 Apr 2021 01:02:50 -0700 (PDT)
Received: from tsr-lap-08.nix.tessares.net ([2a02:578:85b0:e00:5c1f:7c5f:b466:7696])
        by smtp.gmail.com with ESMTPSA id mj7sm5853512ejb.39.2021.04.17.01.02.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 17 Apr 2021 01:02:49 -0700 (PDT)
Subject: Re: [PATCH v2 5/6] kunit: mptcp: adhear to KUNIT formatting standard
To: David Gow <davidgow@google.com>, Nico Pache <npache@redhat.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Brendan Higgins <brendanhiggins@google.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-ext4@vger.kernel.org,
 Networking <netdev@vger.kernel.org>, rafael@kernel.org,
 linux-m68k@lists.linux-m68k.org, Geert Uytterhoeven <geert@linux-m68k.org>,
 Theodore Ts'o <tytso@mit.edu>, mathew.j.martineau@linux.intel.com,
 davem@davemloft.net, Mark Brown <broonie@kernel.org>,
 Shuah Khan <skhan@linuxfoundation.org>, mptcp@lists.linux.dev
References: <cover.1618388989.git.npache@redhat.com>
 <0fa191715b236766ad13c5f786d8daf92a9a0cf2.1618388989.git.npache@redhat.com>
 <e26fbcc8-ba3e-573a-523d-9c5d5f84bc46@tessares.net>
 <CABVgOSm9Lfcu--iiFo=PNLCWCj4vkxqAqO0aZT9B2r3Kw5Fhaw@mail.gmail.com>
 <b57a1cc8-4921-6ed5-adb8-0510d1918d28@tessares.net>
 <CABVgOS=QDATYk3nn1jLHhVRh7rXoTp1+jQhUE5pZq8P9M0VpUA@mail.gmail.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
Message-ID: <8b8aecaa-2651-2401-e5ad-499b2c920c6d@tessares.net>
Date: Sat, 17 Apr 2021 10:02:48 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <CABVgOS=QDATYk3nn1jLHhVRh7rXoTp1+jQhUE5pZq8P9M0VpUA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit

Hi David, Nico,

On 17/04/2021 06:24, David Gow wrote:
> Hi Matt,
> 
>> Like patch 1/6, I can apply it in MPTCP tree and send it later to
>> net-next with other patches.
>> Except if you guys prefer to apply it in KUnit tree and send it to
>> linux-next?
> 
> Given 1/6 is going to net-next, it makes sense to send this out that
> way too, then, IMHO.

Great!
Mat sent this patch to net-next and David already applied it (thanks!):

https://git.kernel.org/netdev/net-next/c/3fcc8a25e391

> The only slight concern I have is that the m68k test config patch in
> the series will get split from the others, but that should resolve
> itself when they pick up the last patch.

I see. I guess for this MPTCP patch, we are fine because 
MPTCP_KUNIT_TESTS was not used in m68k config.

 > At the very least, this shouldn't cause any conflicts with anything
 > we're doing in the KUnit tree.

Thanks for having checked!

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
