Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 134912FAE
	for <mptcp@lists.linux.dev>; Fri,  6 May 2022 19:18:11 +0000 (UTC)
Received: by mail-ej1-f48.google.com with SMTP id z2so14624042ejj.3
        for <mptcp@lists.linux.dev>; Fri, 06 May 2022 12:18:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:cc:from:in-reply-to:content-transfer-encoding;
        bh=2KeSWKuPXMC0ijDpm6mA8+RY9mzzYLxHHvPNMnX1/hM=;
        b=01a8PNfom6o6MQPdKt4Q0f1qhTraBC1+X8VMZFDyHf/nQy0JgPx2blv8XIS6GA8vhK
         9weQEMTD8F75DzBT3fuZ4V8+Bu3YL+0dCqUWsDvWkJSe2TXE37r1i3R4L12+XI7Nnjw4
         k4jG16rNwnwpdGYKttrvrjauB6asR7uQL2wWojMqP3ofuz6YHpQ2W1WP+kcAB6Kjy/0a
         XD9sggI9d16tP8dgYDntCipb9NFy0uY+PxzbEJ+aHbDgIE4jF6p1w8I94INstkROgPPN
         9YaMtdfg+7Pp5a5KHY1hRaV+ersjHgtRsw34VM2KG/ZAfiJs1GbIXegEwoQvSqgxRm3C
         zxLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:cc:from:in-reply-to
         :content-transfer-encoding;
        bh=2KeSWKuPXMC0ijDpm6mA8+RY9mzzYLxHHvPNMnX1/hM=;
        b=mYMoaAW3smXApvSS5GDwqLBUqvkgS6Na0jNbCOB1piPrcPuXc+Fi1oyOuOkKyZATcG
         YzA8QliU18ppULG69q1NG7kusSIZWdc5FhGc+wYeIBWrbX4FF8rX5fmjk9L2B8VbXTQm
         X0GCfYn9DvzM2A1iaFI+FESgcCXfnEP+FMOVv/r8R2kWJHNb+Ml3dprlxoDHF1J30Uhp
         ugs3Wby4lutzt8HqsKODwKCNsHcfRwZ0dfEBLGgHvJkN3AknjWA9FPwGEZhJIk9VtnWY
         B3IAXm/0Qx2X843fc2LDG3hV+3jPLedaclTzc+GfPM4GTafZE6537zXOzvdzvHaQLkk7
         vGhg==
X-Gm-Message-State: AOAM5328U9WahgwwL2BUzkWZKb1lEFy/xFTtBxo7QpJJtXaaeqCVzCfe
	bZj/DL/DMRh9U2fSNVJ0lwxhqVFW6KtZj3tG
X-Google-Smtp-Source: ABdhPJyPrMSTG/IQQvIg7fmU3btuhTVXAtP4eW9rpnL0ZvDweZkNiyZZxtKfbYV2pzRwGyYO7u4+hg==
X-Received: by 2002:a17:907:d01:b0:6f4:d873:d7a0 with SMTP id gn1-20020a1709070d0100b006f4d873d7a0mr4387332ejc.717.1651864689815;
        Fri, 06 May 2022 12:18:09 -0700 (PDT)
Received: from ?IPV6:2a02:578:8593:1200:b63e:f9ca:c9c4:cf8a? ([2a02:578:8593:1200:b63e:f9ca:c9c4:cf8a])
        by smtp.gmail.com with ESMTPSA id wi22-20020a170906fd5600b006f3ef214de0sm2211804ejb.70.2022.05.06.12.18.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 May 2022 12:18:09 -0700 (PDT)
Message-ID: <403dfad5-185b-eaef-0abc-2ad7167de025@tessares.net>
Date: Fri, 6 May 2022 21:18:08 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH mptcp-next] mptcp: sockopt: add TCP_DEFER_ACCEPT support
Content-Language: en-GB
To: Florian Westphal <fw@strlen.de>
References: <20220502163624.6110-1-fw@strlen.de>
Cc: mptcp@lists.linux.dev
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <20220502163624.6110-1-fw@strlen.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Florian, Mat,

On 02/05/2022 18:36, Florian Westphal wrote:
> Support this via passthrough to the underlaying tcp listener socket.

Thank you for the patch and the review!

Now in our tree (feat. for net-next) with Mat's RvB tag.

New patches for t/upstream:
- 3476c1a3846c: mptcp: sockopt: add TCP_DEFER_ACCEPT support
- Results: 22856348dac5..9a52d7243fda (export)

Builds and tests are now in progress:

https://cirrus-ci.com/github/multipath-tcp/mptcp_net-next/export/20220506T191513
https://github.com/multipath-tcp/mptcp_net-next/actions/workflows/build-validation.yml?query=branch:export

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
