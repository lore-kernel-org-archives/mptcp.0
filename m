Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0123C2FB1
	for <mptcp@lists.linux.dev>; Thu, 13 May 2021 07:50:46 +0000 (UTC)
Received: by mail-ed1-f45.google.com with SMTP id n25so29979974edr.5
        for <mptcp@lists.linux.dev>; Thu, 13 May 2021 00:50:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=D6sxUTWJZvJkMT6GiTtpCt6hxO2UE0Y8zk79Ct7tIgY=;
        b=puoJ+LCJJK6PYpxmqqtT8lvSf3j4Zauxw4VJEMUtJ7pbODxvJB+/9fxNfht3Xug1HH
         xjkJV9Kadp951amE+Hnu3jZTDGuVLsr1BjeLHTLgaZEXdA6zIj8Cfne/RPu9NBg49y4v
         O2MuFgFdqfmY7p3dQb7+ipLMCUIMlkG6M7qRJ6NBix85Vw00VTGWVI25c2pcrvN38Mz+
         MFA52pJ9ifTyNY27Xukz7p+ArA4QgUGlgCcbu1j3SGbt7ByY9hkg5TBe1ImzsAHwOjRd
         7+mKOG81BvMuBf1ygoG7GSCmTEaBgRaJUmdwThDwA73nGZv1Aao8uci5HaxrPr/SGQZ2
         w0gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=D6sxUTWJZvJkMT6GiTtpCt6hxO2UE0Y8zk79Ct7tIgY=;
        b=MDlWsICj7D7/mSOAJN5NFrRc8pZossjxkugkMjvxRY7j0Nmp+KqdTkR+jFpnf7A7Gy
         gkva6qGTfa8koZSp/I76wVV/hocXYMHk7owkC18MJW5scS9CrC8Y74eDWnYPddtY9qx1
         PG9on5+dyDql7ROko9T98yGhrnjCISm01kF1L6Yfnh+JmfiMZmyQPj0RAsiVofTo1A/U
         H/OD+Rb7Og/duL82ZlogY7rzIuyTkx3WrjpJ1xbK50rlnYhAel/8UBQOJ6R8yMgC7sCh
         1dKhjvxxVq9fwy5PVQzrldy2kdLdFjUA3yRh8D3OetKVA51IZZxRN7IOftI+1xC/bUvk
         xzPA==
X-Gm-Message-State: AOAM532RW7zc2FnXvlSQzaY8w0su5sGvbWIaVBPApHlwvVrYb24mRpPt
	1DvF9jpVN+wKictzpdx7CVje2EprhiuD72k3
X-Google-Smtp-Source: ABdhPJyl92Gj/B0knzLuOgLtufmLm3UlvE3adFdQ8D/cVHE/Cysrg12C+K0Tenz/PSpceT2nCxSWWA==
X-Received: by 2002:a50:fc99:: with SMTP id f25mr49454066edq.147.1620892245430;
        Thu, 13 May 2021 00:50:45 -0700 (PDT)
Received: from tsr-lap-08.nix.tessares.net ([2a02:578:85b0:e00:8928:ef6b:4f39:1fcb])
        by smtp.gmail.com with ESMTPSA id kx3sm1387133ejc.44.2021.05.13.00.50.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 May 2021 00:50:45 -0700 (PDT)
Subject: Re: [PATCH] mptcp: generate subflow hmac after mptcp_finish_join()
To: Jianguo Wu <wujianguo106@163.com>,
 Mat Martineau <mathew.j.martineau@linux.intel.com>
Cc: Florian Westphal <fw@strlen.de>, Paolo Abeni <pabeni@redhat.com>,
 mptcp@lists.linux.dev
References: <79d42988-47da-dc8b-8416-4d4e76510f08@163.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
Message-ID: <549b421d-bfd6-b4d2-8c89-e6cb76de2ddb@tessares.net>
Date: Thu, 13 May 2021 09:50:44 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <79d42988-47da-dc8b-8416-4d4e76510f08@163.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit

Hi Jianguo, Mat,

On 07/05/2021 10:02, Jianguo Wu wrote:
> From: Jianguo Wu <wujianguo@chinatelecom.cn>
> 
> For outgoing subflow join, when recv SYNACK, in subflow_finish_connect(),
> the mptcp_finish_join() may return false in some cases, and send a RESET
> to remote, and no local hmac is required.
> So generate subflow hmac after mptcp_finish_join().

Should we cover this case with a packetdrill test?

> Fixes: ec3edaa7ca6c ("mptcp: Add handling of outgoing MP_JOIN requests").
> Signed-off-by: Jianguo Wu <wujianguo@chinatelecom.cn>

Thank you for the patch and the review!

Now in our tree, 'net' fix:

- cab4e45339c1: mptcp: generate subflow hmac after mptcp_finish_join()
- Results: 655ba588ab88..b8c6eee443a3

Builds and tests are now in progress:

https://cirrus-ci.com/github/multipath-tcp/mptcp_net-next/export/20210513T075025
https://github.com/multipath-tcp/mptcp_net-next/actions/workflows/build-validation.yml?query=branch:export/20210513T075025

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
