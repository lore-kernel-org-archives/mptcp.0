Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6B832568
	for <mptcp@lists.linux.dev>; Tue, 22 Feb 2022 11:00:56 +0000 (UTC)
Received: by mail-wm1-f52.google.com with SMTP id k3-20020a1ca103000000b0037bdea84f9cso1472362wme.1
        for <mptcp@lists.linux.dev>; Tue, 22 Feb 2022 03:00:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=Rgikvoae1we/0I9hf93y4h5vmKEylYHCLt/+36dJdE0=;
        b=OPCUDqB5M3XV0FRwAtr8IJFDJL7sPfe/RGBYF7GZ6T1pkYsdcTdiTuUrfFjCGwiwGG
         BZCR34FScGBxCGqSBI1oLO+Zo5F656o9QqfyJixGQ9b1Mlv/zqRoK0VHfRePGIty4n/D
         gIZTnBhCzKhlDVg7HkmKE9PTOUgf5owziMGLgAPtAGbsa16nE++LH1j8DtHIZwG/Er9y
         v/uXDlyIRvDdC/BIHHc1e2lo+xkMlo4PhWXYSerlYE4Jxa2VfCnYMdxl3D921FBW/w5p
         GxBvpvDRidr2xlxAExQ4VYwuHjQTZUJnM3xeqXNvGqLdC5wS0ETDhs6ngakvilGQSzU2
         7G6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Rgikvoae1we/0I9hf93y4h5vmKEylYHCLt/+36dJdE0=;
        b=0CtN1k0jMsSobXpGt9xfOeef1vvPzFRwhQDLZtuR/QMg9/3rivgT7dV6ca6bBCsafE
         ljhU8R0MMRD4iEopxWdNGznm6EJHfo3XzYM/4bVj98yhHvvNjqYNmvY6Q+D7Ln3xga4N
         yRHsZ2RsrAnOUt/JR2rscY5BGQfI1UEc5DhO/3QSu2OsuOg5CD1PYXoH8xWg80lMDpK/
         +ojT/GQbmS4uWM2wX95Kplo9pg4jiafsRpSKzPrtkIO78zGkAOUukJYAEejCq9UuV/iv
         8Y/XmsmXJfCytHvPFFoMBepy42hSznj79799OMBnjSEAaQSakH6f5s7vg47ZfOvTpNhf
         HKLw==
X-Gm-Message-State: AOAM532jqppB5w8CifSdkmwNEXuHqXWzEm90aQj/inhfCfuVfpnSNmtr
	2tLSlUABIqr0K6slCaJHtTW5YQ==
X-Google-Smtp-Source: ABdhPJxChq3jmko4l+NTqHnFww6/9V1gF+1UjSivnxXhTcKjE8hZMwYwIiRkxVAV2cUUm945WkrNPQ==
X-Received: by 2002:a05:600c:215:b0:37c:729:f84d with SMTP id 21-20020a05600c021500b0037c0729f84dmr2870587wmi.131.1645527654639;
        Tue, 22 Feb 2022 03:00:54 -0800 (PST)
Received: from [10.44.2.26] (84-199-106-91.ifiber.telenet-ops.be. [84.199.106.91])
        by smtp.gmail.com with ESMTPSA id j6-20020a05600c190600b0037c3659a12fsm2612271wmq.6.2022.02.22.03.00.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Feb 2022 03:00:54 -0800 (PST)
Message-ID: <5eea9634-7238-5dec-80e2-043d3cdead50@tessares.net>
Date: Tue, 22 Feb 2022 12:00:53 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH mptcp-next] Squash-to: "mptcp: more careful RM_ADDR
 generation"
Content-Language: en-GB
To: Paolo Abeni <pabeni@redhat.com>, mptcp@lists.linux.dev
References: <a38625a058afb93ca629e300124cfc07a0bc43fa.1645462092.git.pabeni@redhat.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <a38625a058afb93ca629e300124cfc07a0bc43fa.1645462092.git.pabeni@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Paolo,

On 21/02/2022 17:54, Paolo Abeni wrote:
> When the self-tests flushed the subflows on both sides of
> the MPTCP connections, the number of subflows actually deleted
> on each side is unreliable.
> 
> The test code always flushes  first the client side, but the
> actual delete operations is performed asynchronously, and one
> on more subflows could be processed after that the other end
> already deleted it.
> 
> The grand total of the deleted subflows is expected to be
> in the [nr_subflows: 2* nr_subflows] range.
> 
> Address the issue checking the total number of deleted subflows
> in the simult flush cases and enforcing the above constraint

Thank you for the update!

It is now in our tree, I hope that's OK for you Mat!

- 939b82e97af4: "squashed" in "mptcp: more careful RM_ADDR generation"
- Results: ffd93449fa08..489fdaf33250

Builds and tests are now in progress:

https://cirrus-ci.com/github/multipath-tcp/mptcp_net-next/export/20220222T105959
https://github.com/multipath-tcp/mptcp_net-next/actions/workflows/build-validation.yml?query=branch:export

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
