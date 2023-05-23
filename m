Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6530A1E501
	for <mptcp@lists.linux.dev>; Tue, 23 May 2023 10:10:05 +0000 (UTC)
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-3090d3e9c92so7101339f8f.2
        for <mptcp@lists.linux.dev>; Tue, 23 May 2023 03:10:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1684836603; x=1687428603;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2wIiWmrQndJJobdVcvQvmioXkTTIficaPf6RxuVui14=;
        b=whsaXm5I74xNU+FyHqAXGXbfsuNG98SKZMGIod6BLZj9swjIH0bEncJAs2e9oau0SG
         pE0ZpNFKcSoYunQYHW3Hx+uJx5OcZCaE182p6qHItq+yanowhK7J6f2n4Y9BfZDzWD4A
         0q3EVz86ckXBBm37gz9l/NHKnbeAWg2cRDGbtXXo2wEH5d2YuGfZjLuK1CnAugJ61ig9
         keqoa8Mk59eZK68c3310KpcDzra/ojmjLmJnX4OKMKfyEFMWhqd59wAuOi7yERyRNREQ
         lCduWz/jSjrDopraN+TrVByQMXKp9/dMytCY4Q0xdI5C7vY7EUzj9cb9BRigTa6aYz14
         lcPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684836603; x=1687428603;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2wIiWmrQndJJobdVcvQvmioXkTTIficaPf6RxuVui14=;
        b=NqWEtOx/iPzvQaxREj5qjZoELs1APUC32273JDHCKBU1idZHmR9mI6crRA5rFTKKMk
         swEZATlL2hjNKd4DjOvmgvr66VUlAeh5BaPgZQJBonJkqWUh8U34+MlwrWExlICn6WxE
         KKga6eJz5PDCR6b77XD/rVNWIGKWQtrnyt9Nvb4biG2FgKwZlNXoMopmKV0WjhXCo9kL
         g3EKtcBT2jW4BpDlliBRar2ARwsau6d9ggnVWOpwEfEecbOOsyWKL/hHza+ItJOMHU4I
         /1n4qQCX+Zph/+TUhAgDFJuw3KoZphfMXY6yYI7AnQyjBjO73/VbxT5MGfUB7fJShhBV
         Ki0g==
X-Gm-Message-State: AC+VfDxojq28vzB2pE/tDBGaNDhJttVT7Gd6+uBQ9LbBtY5MNA1Aq1Dy
	Ktm2lMldAwNyv3hmK6qkO8SzPg==
X-Google-Smtp-Source: ACHHUZ4lh2/CIjoPJfIz4KsfdlLuJszBAK0M4dCx6AcDr2UFJdOHb4d4/UvJPP/FdFDEV6c6Jw3/1Q==
X-Received: by 2002:a05:6000:188:b0:306:44a9:76a0 with SMTP id p8-20020a056000018800b0030644a976a0mr10352493wrx.9.1684836603375;
        Tue, 23 May 2023 03:10:03 -0700 (PDT)
Received: from ?IPV6:2a02:578:8593:1200:7ae3:96f4:110c:3f46? ([2a02:578:8593:1200:7ae3:96f4:110c:3f46])
        by smtp.gmail.com with ESMTPSA id p15-20020a5d458f000000b003090cb7a9e6sm10619169wrq.31.2023.05.23.03.10.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 May 2023 03:10:03 -0700 (PDT)
Message-ID: <9fd5c9fc-3926-4eef-84d5-60c85b1ed61b@tessares.net>
Date: Tue, 23 May 2023 12:10:02 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH mptcp-net v2 26/37] selftests: mptcp: join: skip test if
 iptables/tc cmds fail
Content-Language: en-GB
To: Paolo Abeni <pabeni@redhat.com>, mptcp@lists.linux.dev
References: <20230406-mptcp-issue-368-selftests-old-kernels-v2-0-50313e4f83ab@tessares.net>
 <20230406-mptcp-issue-368-selftests-old-kernels-v2-26-50313e4f83ab@tessares.net>
 <e530b465c8aaabc0f85297ee484af62e571b1906.camel@redhat.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <e530b465c8aaabc0f85297ee484af62e571b1906.camel@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Paolo,

On 22/05/2023 19:42, Paolo Abeni wrote:
> On Mon, 2023-05-22 at 18:37 +0200, Matthieu Baerts wrote:
>> Selftests are supposed to run on any kernels, including the old ones not
>> supporting all MPTCP features.
>>
>> Some tests are using IPTables and/or TC commands to force some
>> behaviours. If one of these commands fails -- likely because some
>> features are not available -- we should intercept the error and skip the
>> tests requiring these features.

(...)

> All the above tc/nf features look quite old. I thought even older them
> mptcp itself. Do we really need to check for them?!?

It should indeed not be required but when doing the validation on older
kernels, I had issues with 'iptables-nft'. We could also have similar
issues if a kconfig is missing or if there is something wrong with the
Netfilter stack.

The consequence is that either the test was finishing in the middle
(because of the "exit 1" next to some commands) or the errors were
ignored and it was not clear why.

What is mainly interesting here is that we check we can add the specific
rules before starting a test and we stop only the subtest in case of
issue. If it doesn't hurt, maybe safer to keep this?

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
