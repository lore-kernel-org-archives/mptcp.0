Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33C7770
	for <mptcp@lists.linux.dev>; Thu, 20 May 2021 18:39:25 +0000 (UTC)
Received: by mail-ed1-f43.google.com with SMTP id w12so12815236edx.1
        for <mptcp@lists.linux.dev>; Thu, 20 May 2021 11:39:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=eSBj7Q7obpm7zM40FEypFkmI2flUoSPar7DbpxDF4gg=;
        b=rcea4ASx5ode4jZt82emp85LXrbxPM1++MuRwikwAL+j60O4P7wqbKG1Pjac19Abl+
         kL/SX4wel7RsNqwC4Axd/i1U0CcWxTjoBcKGCiX/shA3vH4vqUdZgB+IKKqDBQeEvNRY
         ko14asU3Acq8ClKPBDqZUsC/g1sY8KQ4bYFreuGsLeAsihJfAP3uhryKb4P5EU6+rRus
         5ts1K5/YJ+Nql55RSn4xcpRA0/JaDoW3BKybpF07my9osOLb4O6egiv/+0o+eFiKq8Bt
         4e2F7Kvk47ShMvJph/s4PagLDAvBnZHXY8thgch/MKnVgRfZdVF+yngkvM4MlnJ0mbDU
         5y6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=eSBj7Q7obpm7zM40FEypFkmI2flUoSPar7DbpxDF4gg=;
        b=toAsTJVZhk40iayRkH706mpH4Z054+8qBVcWCKX3hEXsxIsSzw90cXOtiL/km6+CJ5
         Gy11t7wE1jL3kCFfxa7A3AwgIQbqYQhxWSBtHXrm7ihy2+iwPOV+Bwok3YBPlGWbjlhr
         agD8WpvCwZMy3BwqYd5c9NSdbkK/FpwG0/sAtg+h9xX/aWIJ/3A1dx9dzcUEtAo8RiME
         vyAJ3K+DsQizfafe0P7sX72ids3DSx0MjoH7pC+7m95PTYZaMQTie0N3wumwDF1TQgVZ
         HF4U1fDLlWZ45kWtTb9zKn/OTCXQAzo2BKvbuH4r5DCMnbKGn91XYDVFv4R0hN3QHxrM
         m3TA==
X-Gm-Message-State: AOAM5308V4q7kBbKqLYEGRvuiBjnPk/+lMlXVHgslTT9jq/kWtV6Qjer
	VZwUPFT5vGYBQq5bqpDSY6k6BDYTw31a0bZ/
X-Google-Smtp-Source: ABdhPJzlLxxta4tMIMeERwNyzp3eA9eC2mr3Kb4jWr6CLuR8GP+TYREYR1h8uArf7kAvQ9Tud+p4XQ==
X-Received: by 2002:a05:6402:4251:: with SMTP id g17mr5521560edb.238.1621535963736;
        Thu, 20 May 2021 11:39:23 -0700 (PDT)
Received: from tsr-lap-08.nix.tessares.net ([2a02:578:85b0:e00:c9db:d048:1d4c:cd82])
        by smtp.gmail.com with ESMTPSA id bm13sm1926719ejb.75.2021.05.20.11.39.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 May 2021 11:39:23 -0700 (PDT)
Subject: Re: [PATCH net] mptcp: validate 'id' when stopping the ADD_ADDR
 retransmit timer
To: Davide Caratti <dcaratti@redhat.com>, mptcp@lists.linux.dev
Cc: Geliang Tang <geliangtang@gmail.com>,
 Mat Martineau <mathew.j.martineau@linux.intel.com>
References: <876dfafb9ec7b090a1da4c2af777be20973649ec.1621359292.git.dcaratti@redhat.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
Message-ID: <81242d9e-f947-5387-9ae6-8c9b4c37cc69@tessares.net>
Date: Thu, 20 May 2021 20:39:22 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <876dfafb9ec7b090a1da4c2af777be20973649ec.1621359292.git.dcaratti@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 8bit

Hi Davide, Mat,

On 18/05/2021 19:36, Davide Caratti wrote:
> when Linux receives an echo-ed ADD_ADDR, it checks the IP address against
> the list of "announced" addresses. In case of a positive match, the timer
> that handles retransmissions is stopped regardless of the 'Address Id' in
> the received packet: this behaviour does not comply with RFC8684 §3.4.1.
> 
> Fix it by validating the 'Address Id' in received echo-ed ADD_ADDRs.

Thank you for the patch and the review!

- 64705a88e6f0: mptcp: validate 'id' when stopping the ADD_ADDR
retransmit timer
- Results: bffd86183cb5..02925519e50e

Builds and tests are now in progress:

https://cirrus-ci.com/github/multipath-tcp/mptcp_net-next/export/20210520T183902
https://github.com/multipath-tcp/mptcp_net-next/actions/workflows/build-validation.yml?query=branch:export/20210520T183902

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
