Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69239168
	for <mptcp@lists.linux.dev>; Fri, 16 Jul 2021 09:17:41 +0000 (UTC)
Received: by mail-ej1-f50.google.com with SMTP id oz7so10326581ejc.2
        for <mptcp@lists.linux.dev>; Fri, 16 Jul 2021 02:17:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=HUE2avorM7HYXXWssAO/qqUQAm0XuON3Xv8+j0LOMv4=;
        b=0ulra3rg4MxzDH8lYUZM04Uu7GnNZSzYP2K3uHdIeTwmibwEooxuE2UljcSM3dICty
         piSRWS4WjXHgGzs3IxN6YhTLb0FpFQ7+BKy4EXIMfz0cBAbBmDclf1+JWS9zd+o+MorJ
         pOojUcHPMFpahk5i5A1FdIcMCJH1kUrYAN8Hl7QqdS7BRisyNJzwFgaXE2XefHKam2Jc
         pZLyeh0fpAiFLJNXWYYDdniX7ikE7iq3nb/lfpFOTRGHuKslJ2+SsJrLqSvk1gAh1WK2
         pB4Axwhzj4OOH/CjV2GsP+y8JtmBAZLk7NUvUMdtx17jBWg+BXJ86khiJEZLURY/OSyB
         kF1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=HUE2avorM7HYXXWssAO/qqUQAm0XuON3Xv8+j0LOMv4=;
        b=CHwAdsn5bYV6blc2L4JqBKhCB94xGHUOOQVmuFQZ6JszA3u1o+0ax/EU7Jtj+BCoDY
         33srbUKrmOxoR5XX6Q/7t2OBYe2rvj125Fd2IVSdT7mD9DflLwJ43CtEcQBg+LXE9ps1
         kHsfMrbcXhQ/SGamkTMvW4G1LYPgd6m3YBywQ8c+VjEAgPnUO2EQVWbuqITO2jsWvXIT
         osJbgyyYz2Ii+yMdQ6cWH4twGw5cLtUW8wk4NC427sXuQ0ks+aCMiF+hrFUR/zXMeXB/
         QCH1//E4jbw8tugI1V6awcjLTdSY4zWt9l2Gq4jPleNqzDpZtfgGNAenxAMk0d5Zhfl6
         yYyg==
X-Gm-Message-State: AOAM530UJZzEDYsBV1In4SohfQl2Tsc1WGOeXdRdFZOJ0c2hPESHGzx5
	x9hMsflZMyPOmz9vAkEJNVMw9OoXAT7arg==
X-Google-Smtp-Source: ABdhPJxby3LQyJxrkYFmpI619zHpCJsWkPIo6lEvu7eqhCXBodK8Yco6QrnxdCOIIb56nJPyIs0dbA==
X-Received: by 2002:a17:906:69cc:: with SMTP id g12mr10819411ejs.550.1626427059362;
        Fri, 16 Jul 2021 02:17:39 -0700 (PDT)
Received: from tsr-lap-08.nix.tessares.net ([2a02:578:85b0:e00:b258:fe9e:46f7:ea69])
        by smtp.gmail.com with ESMTPSA id y17sm2699286ejd.16.2021.07.16.02.17.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Jul 2021 02:17:39 -0700 (PDT)
Subject: Re: [MPTCP][PATCH mptcp-next] mptcp: drop unuse rcu in
 mptcp_pm_addr_entry
To: Geliang Tang <geliangtang@gmail.com>, mptcp@lists.linux.dev
References: <75536cfb651328a9c8446676ec123b84e5f4c35f.1625829674.git.geliangtang@gmail.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
Message-ID: <89d3e400-66ee-28bc-d93b-daa0b247ac1e@tessares.net>
Date: Fri, 16 Jul 2021 11:17:38 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <75536cfb651328a9c8446676ec123b84e5f4c35f.1625829674.git.geliangtang@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit

Hi Geliang, Mat,

On 09/07/2021 13:22, Geliang Tang wrote:
> kfree_rcu() had been removed from pm_netlink.c, so this rcu field in
> struct mptcp_pm_addr_entry became useless. Let's drop it.

Thank you for the patch and the review!

I just applied it in our tree with a Fixes tag and Mat's RvB one. I
think this one can be sent to the -net tree:

- 1d500114ddb0: mptcp: drop unuse rcu in mptcp_pm_addr_entry

- Results: 471dab437a02..1187a6e1e0e7

Builds and tests are now in progress:



https://cirrus-ci.com/github/multipath-tcp/mptcp_net-next/export/20210716T091701

https://github.com/multipath-tcp/mptcp_net-next/actions/workflows/build-validation.yml?query=branch:export/20210716T091701

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
