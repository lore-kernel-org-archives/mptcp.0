Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32258186B
	for <mptcp@lists.linux.dev>; Wed, 29 Mar 2023 09:35:07 +0000 (UTC)
Received: by mail-wm1-f49.google.com with SMTP id o32so8491708wms.1
        for <mptcp@lists.linux.dev>; Wed, 29 Mar 2023 02:35:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1680082506;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nC7VmK2udpQWueSvYtntbgsGynSiAu0Uc9Raif0uGpQ=;
        b=ZWSpkboaIJsRZ/f+pJJdmU/VgJ0zxR+qBKFk3DFiqniq1TEmYt3U85rUhfc+E0LEzz
         pv59XlJuxucoUhyA037bb7pjQZr8UK1Bx7HShHZWzcYQeBJLhMQMHsVfl7HFFZPQYyi6
         AvSkRrHOOV2M2kEcshCx4htlZBcNatTAx5CcZkCrzjHB0gCoOvTKfL7mUAgaUO7tgBqO
         3lM5WHoWL/KiT9eg7oEo3j2Pn7gF5qmMfKxhumm685Ne/gLPqIUaoenYtFWItwDUFXW4
         rFu6Qx5JwnG60wuuH4Uvx+A0SJxyDnMGzA71d9sDfAkxfix6DY/UdpxtOjtZj/k//INZ
         EsgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680082506;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nC7VmK2udpQWueSvYtntbgsGynSiAu0Uc9Raif0uGpQ=;
        b=1hSuHR8TLT5Q1uc9mR/2EKj7Hqw0pd6DBI1mJ1cEhzqTzL0jQXsOMuC+6llTsZDEF8
         F3/ZKaSMNc8CFpovDyronJ4FH42PWdRS1H9wbubJEgPWajj2M1qsAYEHrnQTqUurWm3E
         SWyThQmNUhKB2qfOlOWnwTC+HkFzOq00mnB0I0Rsm16az3KTH09qXbYxXFT5O6dsqDZK
         vJjRfjt6BOR+K09dPDJnodCRweR2DOp+DeZn1Bd+cjIjQ5qAW0MLXR3wXf4Y8J95E1Mj
         srrUKug5DRTCt9gX4kjWZOyj1zB/moeemqYDF6QgXdhyg77mH+4mDMksTrq/PiqJ0OFL
         RWDw==
X-Gm-Message-State: AO0yUKV7ZCCp+ZvI2o7ZZr9maGAxvfilt27PkJY7/I3Dk8tiuCyDezNW
	yj5sJkMwhnKdthCcyu6LJwEiCQ==
X-Google-Smtp-Source: AK7set8rsxyL3ntnPuI8N7QJfpuEgl3CsHeE9XZm2SiPjmetbCVIRpmrS8byYXoqLhWRMhl9kc1SLw==
X-Received: by 2002:a7b:c4cb:0:b0:3ee:d7f:6676 with SMTP id g11-20020a7bc4cb000000b003ee0d7f6676mr14896271wmk.11.1680082506176;
        Wed, 29 Mar 2023 02:35:06 -0700 (PDT)
Received: from ?IPV6:2a02:578:8593:1200:79fe:97a:4a91:5b93? ([2a02:578:8593:1200:79fe:97a:4a91:5b93])
        by smtp.gmail.com with ESMTPSA id l7-20020a05600c4f0700b003ef5deb4188sm1709866wmq.17.2023.03.29.02.35.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Mar 2023 02:35:06 -0700 (PDT)
Message-ID: <c14c5a19-5a88-0dba-b58a-ea5cfe8a6211@tessares.net>
Date: Wed, 29 Mar 2023 11:35:05 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: MPTCP_Up_Stream
Content-Language: en-GB
To: Iheb Zannina <iheb.zannina@gmail.com>, mptcp@lists.linux.dev
References: <CAKdABxssnqVYwgJnhqD4653-n8+aCX1CCqNOxN-EWG+YWaGRyg@mail.gmail.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <CAKdABxssnqVYwgJnhqD4653-n8+aCX1CCqNOxN-EWG+YWaGRyg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hello,

On 29/03/2023 10:55, Iheb Zannina wrote:
> I am working on MPTCPv1 schedulers in linux V5.15.

There is only one MPTCP packet schedulers in v5.15. Same in the latest
version. The work is in progress:

https://github.com/multipath-tcp/mptcp_net-next/issues/75


> But I can't find the MPTCP scheduler in "
> /proc/net/mptcp_net/rbs/schedulers " nor the
> " /proc/net/mptcp_net/rbs/default " file.
> Where should I find the schedulers files?

There is no such things in the upstream version.

With the fork (kernels < 5.6, [1][2]), there was something under
"/proc/net/mptcp_net/" but no "rbs" directory there. I don't know where
you got that from.

Cheers,
Matt

[1] https://github.com/multipath-tcp/mptcp
[2]
https://github.com/multipath-tcp/mptcp_net-next/wiki#upstream-vs-out-of-tree-implementations
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
