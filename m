Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C3852596
	for <mptcp@lists.linux.dev>; Wed,  4 May 2022 17:07:30 +0000 (UTC)
Received: by mail-pl1-f175.google.com with SMTP id j8so1956993pll.11
        for <mptcp@lists.linux.dev>; Wed, 04 May 2022 10:07:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=5heQlZbmjl3R/ScgbWjY3UOlALlpc5dyNuQE2J2tTh8=;
        b=PYGn8cyOYJe7mUdyDAprPahcuw7uwaYeqc+0nVFaR6gawsQBFxMTWvkwZH/bqb3sAO
         N0Ncz1b27atKy9ekgZOUYq8XgUvyg2kCVQf/kexa3P9ysLxH7h69nh4sXRBkC5IwBuCU
         lvDyw1lV89wkkkItT4fsGfUBTGVxqmFrcFUIMCLOdTsvLIJvnKYz9zTpsn69h6CggRVL
         wnJeHZ86dibGEhFYGLcA9xHFAtNnuag4oce8bW9hRT7w1lnQI3wzymNLYEGTOvTegbC6
         i+1IulZwNL0CqPF3/nykpMzjJrWoRina/vvqquTC/eXDrcuWKo0GxhEPoa2CCgDTfFMz
         jluA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=5heQlZbmjl3R/ScgbWjY3UOlALlpc5dyNuQE2J2tTh8=;
        b=zfnjqCB/AI8aZRkvsnz7M1dGoaJs9+wCHIdNikiBuj4r9TfESkG+VGSxtF7cAPYoLR
         Nkoj5KCF8WHEy189NBQVjVSTxpGbdt/qz8kwF/WJc3G7i5wUbgwrPb9s8/zMKj8DByyQ
         MPtB2FJOEurEeuo3XCGFPYuybAmaaDTH2mjsBp28CD9I41gF5/bWQ/cSk50BrZ/S6rSE
         2Fah5riZzmZBPHLJM6puohon7vEZrL5X5WMPWp92YkX7NXmmRg+jPM/+T+MIezHOABzK
         /Rzw7diRjN0Dup64+dY55Kk2pT8YVePOY9xUYGVZw9YG4lOY5++0JHYI0z0C7u0d/U2n
         UdNQ==
X-Gm-Message-State: AOAM533zROr7xXTC2a1uCXOaAZ2VoiF8tgzNvOoaGztP/O1wj8VkYw1S
	DQ45+IQVbOqock9gnkGd0pc=
X-Google-Smtp-Source: ABdhPJzuNG+G7WrVCnZo6oM5E1j+8EOpXMiSJct3FZoI4MOoDiNL6HXgay/Dmjg9M7ZFvLy9XbMCjw==
X-Received: by 2002:a17:902:70c1:b0:154:667f:e361 with SMTP id l1-20020a17090270c100b00154667fe361mr22914608plt.148.1651684049858;
        Wed, 04 May 2022 10:07:29 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id i15-20020a170902c94f00b0015e8e7db067sm2502228pla.4.2022.05.04.10.07.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 May 2022 10:07:28 -0700 (PDT)
Message-ID: <5480dd4a-5626-a6e4-c4e4-90c9e10554f9@gmail.com>
Date: Wed, 4 May 2022 10:07:02 -0700
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH net-next 1/2] net: switch to netif_napi_add_tx()
Content-Language: en-US
To: Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net
Cc: netdev@vger.kernel.org, pabeni@redhat.com, edumazet@google.com,
 rafal@milecki.pl, opendmb@gmail.com, dmichail@fungible.com,
 hauke@hauke-m.de, tariqt@nvidia.com, kys@microsoft.com,
 haiyangz@microsoft.com, sthemmin@microsoft.com, wei.liu@kernel.org,
 decui@microsoft.com, shshaikh@marvell.com, manishc@marvell.com,
 jiri@resnulli.us, hayashi.kunihiko@socionext.com, peppe.cavallaro@st.com,
 alexandre.torgue@foss.st.com, joabreu@synopsys.com,
 mcoquelin.stm32@gmail.com, grygorii.strashko@ti.com, elder@kernel.org,
 wintera@linux.ibm.com, wenjia@linux.ibm.com, svens@linux.ibm.com,
 mathew.j.martineau@linux.intel.com, matthieu.baerts@tessares.net,
 s-vadapalli@ti.com, chi.minghao@zte.com.cn, linux-rdma@vger.kernel.org,
 linux-hyperv@vger.kernel.org, mptcp@lists.linux.dev
References: <20220504163725.550782-1-kuba@kernel.org>
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20220504163725.550782-1-kuba@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/4/22 09:37, Jakub Kicinski wrote:
> Switch net callers to the new API not requiring
> the NAPI_POLL_WEIGHT argument.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
> CC: rafal@milecki.pl
> CC: f.fainelli@gmail.com
> CC: opendmb@gmail.com
> CC: dmichail@fungible.com
> CC: hauke@hauke-m.de
> CC: tariqt@nvidia.com
> CC: kys@microsoft.com
> CC: haiyangz@microsoft.com
> CC: sthemmin@microsoft.com
> CC: wei.liu@kernel.org
> CC: decui@microsoft.com
> CC: shshaikh@marvell.com
> CC: manishc@marvell.com
> CC: jiri@resnulli.us
> CC: hayashi.kunihiko@socionext.com
> CC: peppe.cavallaro@st.com
> CC: alexandre.torgue@foss.st.com
> CC: joabreu@synopsys.com
> CC: mcoquelin.stm32@gmail.com
> CC: grygorii.strashko@ti.com
> CC: elder@kernel.org
> CC: wintera@linux.ibm.com
> CC: wenjia@linux.ibm.com
> CC: svens@linux.ibm.com
> CC: mathew.j.martineau@linux.intel.com
> CC: matthieu.baerts@tessares.net
> CC: s-vadapalli@ti.com
> CC: chi.minghao@zte.com.cn
> CC: linux-rdma@vger.kernel.org
> CC: linux-hyperv@vger.kernel.org
> CC: mptcp@lists.linux.dev
> ---
>   drivers/net/ethernet/broadcom/bcm4908_enet.c       | 2 +-
>   drivers/net/ethernet/broadcom/bcmsysport.c         | 2 +-
>   drivers/net/ethernet/broadcom/genet/bcmgenet.c     | 3 +--

For the above:

Acked-by: Florian Fainelli <f.fainelli@gmail.com>
-- 
Florian
