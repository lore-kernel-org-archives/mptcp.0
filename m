Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98B68808
	for <mptcp@lists.linux.dev>; Tue, 31 Jan 2023 09:17:48 +0000 (UTC)
Received: by mail-wr1-f45.google.com with SMTP id m7so13540496wru.8
        for <mptcp@lists.linux.dev>; Tue, 31 Jan 2023 01:17:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Bb2itHEn1g7oX5Gb2cb5bAnASZgCXnCadFyPo8E6KBQ=;
        b=GOPMKxWN0/V6Pzw0zXiiIF6BH83LlKweFbAW2TTtXGRyTT1nOIbAkc2yFmcoWRQYT7
         GuO/8oQx/+0zh0GnJM+TqgPa3ylEVuhH6TxdbEsbD3QesXn6pkBVVaC55CAGMKWUiSxd
         PqbeOs8J8jrtfemdmT3/he/eXFR8tG2wPhXtO3f2+JgZbyDUyHknOPGCRLm5sUxMIm2o
         /EQIuE9OpWdUlmbAI2WgdWVb6vHzGgFxnpPCKz5FXAUbzxqcQQy5tRfgKAf5KGmkhd7v
         LIWI6rYKwDr7P7XdM/HA++khVA6and4fFy28BhhqxscLRQAF1g/mBF+N0ilXlZrkWxK1
         S0UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Bb2itHEn1g7oX5Gb2cb5bAnASZgCXnCadFyPo8E6KBQ=;
        b=p1AW2jMaFi4Y+krfUPxUxCthxCE9uOy9TG873yihUuoLSYo/UmdnvyMq5G1Or8gfvd
         d0Sk19YEKn3+kUJJ6TCbJkdFj1KwdHljeIyUdQbOpPQh6RAj9OnvTU3dfSNVw/MRPoBM
         X4yxWSrqriA7FR/aqYNB40yoKwzvzFiG8Te7Plb24VEkasDMGzzChFDKRVZL550Dju20
         kyUHEmRPHYmXbTOUL2Lo2g50eDXbqsuEYr4JLOa2/Nb0cpnRomGYFX+Qo0HafcLuf1o2
         8exdq3uGlW795EMzibVPbNNqW4ZX2BwKZnFfxxNDf+7VRG4pVZJHB28zhZxe3Q0h7lLl
         xHFA==
X-Gm-Message-State: AO0yUKVkIHvRJAjWtKE9QhwKAsULoAQai9BHOVkf3ZJ5NXyt8Hsh5hFT
	poNH8gS8ABzJXBp3uLeqkDhYDA==
X-Google-Smtp-Source: AK7set8yUQqzgd4kA04Fe9AYPszv1Q9M/X0MzGX55J2/gST2L1zrwvSPoY/qYnKVEBarpldcg4UYtw==
X-Received: by 2002:a05:6000:1a4f:b0:2bf:e9dc:5552 with SMTP id t15-20020a0560001a4f00b002bfe9dc5552mr7613759wry.40.1675156666418;
        Tue, 31 Jan 2023 01:17:46 -0800 (PST)
Received: from ?IPV6:2a02:578:8593:1200:8fe6:f95f:22e9:6db7? ([2a02:578:8593:1200:8fe6:f95f:22e9:6db7])
        by smtp.gmail.com with ESMTPSA id j15-20020a5d452f000000b002be505ab59asm14110162wra.97.2023.01.31.01.17.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 31 Jan 2023 01:17:46 -0800 (PST)
Message-ID: <b9712815-1ab9-a355-ce97-519a243b68d9@tessares.net>
Date: Tue, 31 Jan 2023 10:17:45 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH mptcp-net v3] mptcp: be careful on subflow status
 propagation on errors
Content-Language: en-GB
To: Paolo Abeni <pabeni@redhat.com>, mptcp@lists.linux.dev
References: <b9cfd415281fc206300a3adbcdbd36047facb31c.1675095773.git.pabeni@redhat.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <b9cfd415281fc206300a3adbcdbd36047facb31c.1675095773.git.pabeni@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Paolo,

On 30/01/2023 17:23, Paolo Abeni wrote:
> Currently the subflow error report callback unconditionally
> propagates the fallback subflow status to the owning msk.
> 
> If the msk is already orphaned, the above prevents the code
> from correctly tracking the msk moving to the TCP_CLOSE state
> and doing the appropriate cleanup.
> 
> All the above causes increasing memory usage over time and
> sporadic self-tests failures.
> 
> There is a great deal of infrastructure trying to propagate
> correctly the fallback subflow status to the owning mptcp socket,
> e.g. via mptcp_subflow_eof() and subflow_sched_work_if_closed():
> in the error propagation path we need only to cope with unorphaned
> sockets.

Thank you for the patch!

Now in our tree (fix for -net):

New patches for t/upstream-net:
- 8db5a7061505: mptcp: be careful on subflow status propagation on errors
- Results: bc024ce64d00..2215d62f4f56 (export-net)
- Results: c8daebf53701..0825e0ffa158 (export)

Tests are now in progress:

https://cirrus-ci.com/github/multipath-tcp/mptcp_net-next/export-net/20230131T091051
https://cirrus-ci.com/github/multipath-tcp/mptcp_net-next/export/20230131T091051

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
