Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 157F333C9
	for <mptcp@lists.linux.dev>; Wed,  4 May 2022 17:25:33 +0000 (UTC)
Received: by mail-qk1-f170.google.com with SMTP id e128so1431487qkd.7
        for <mptcp@lists.linux.dev>; Wed, 04 May 2022 10:25:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ieee.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=EA5hd+ONeh3r8m7IjwgM/P2KAxM8YbhbRw3CfXKRgQU=;
        b=cgk57z8pGWzn5zNc7HJYjf3+wPngKOeFGk+syOoimcB9CafI91+QFqY4oT1M1KCjuv
         YN9cVZzwBn2+xy/G0FsHOpL3cB/LLReBOaoXpS6XlCJMC2iokoxqSqaEFdfPq7N0bnCK
         Z+uamEJ0L1HVXiYgULxmxyrhk2Gx58SPdmayc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=EA5hd+ONeh3r8m7IjwgM/P2KAxM8YbhbRw3CfXKRgQU=;
        b=k8Gw0wO2OC+eKqpAin88N0zXIqkKWWaukN2n9LjJjTYWtXXk7r3bnsoyal7ikF62vs
         1XZS3zPiebzfQSJK/acUB2RD779AA1O17G/gFeR5uol1HGI7Dv4rh9f/kSrOJT5wlvkc
         DpCo8QXE3yTFoKikOJjQ36HOsbbuAm2YBJuR0X0Tq5mlJyKezYsGFBPOFFOJHwg68PDV
         qo9xRgyO80ntjzAROerUxvlQaCcZ+iDpSsNjYPfI0n8goYhxJrGb5Bu/zTTGMUOmvSa/
         4tV8PhJOoOsHHf+7auQvBViZWcpKXo4JeaawhZ6zfozeDaiDgxY3wDy8sRon5TbT0Kca
         0usg==
X-Gm-Message-State: AOAM532ONQKe3eM1+5sOGpNXp1mTwaVB1IWZVFLkokXj+d2tY/QTSGgm
	Q8ieiaZgN8Jw1t7ui+gVNRO/gQ==
X-Google-Smtp-Source: ABdhPJxf/VDUZ4uuKUAGDgbMcU+01SeQHMvtORrk3T0Ij2PvFi7R/FQojA1MBWgOdsAs8DmrURGQKQ==
X-Received: by 2002:a37:c84:0:b0:69f:c94a:a8ca with SMTP id 126-20020a370c84000000b0069fc94aa8camr14599503qkm.167.1651685132966;
        Wed, 04 May 2022 10:25:32 -0700 (PDT)
Received: from [172.22.22.4] (c-73-185-129-58.hsd1.mn.comcast.net. [73.185.129.58])
        by smtp.googlemail.com with ESMTPSA id n68-20020a37a447000000b0069fc13ce1edsm8034968qke.30.2022.05.04.10.25.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 May 2022 10:25:32 -0700 (PDT)
Message-ID: <f11b54bf-a69f-0776-2129-a089c1bd3e63@ieee.org>
Date: Wed, 4 May 2022 12:25:29 -0500
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH net-next 1/2] net: switch to netif_napi_add_tx()
Content-Language: en-US
To: Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net
Cc: netdev@vger.kernel.org, pabeni@redhat.com, edumazet@google.com,
 rafal@milecki.pl, f.fainelli@gmail.com, opendmb@gmail.com,
 dmichail@fungible.com, hauke@hauke-m.de, tariqt@nvidia.com,
 kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
 wei.liu@kernel.org, decui@microsoft.com, shshaikh@marvell.com,
 manishc@marvell.com, jiri@resnulli.us, hayashi.kunihiko@socionext.com,
 peppe.cavallaro@st.com, alexandre.torgue@foss.st.com, joabreu@synopsys.com,
 mcoquelin.stm32@gmail.com, grygorii.strashko@ti.com, elder@kernel.org,
 wintera@linux.ibm.com, wenjia@linux.ibm.com, svens@linux.ibm.com,
 mathew.j.martineau@linux.intel.com, matthieu.baerts@tessares.net,
 s-vadapalli@ti.com, chi.minghao@zte.com.cn, linux-rdma@vger.kernel.org,
 linux-hyperv@vger.kernel.org, mptcp@lists.linux.dev
References: <20220504163725.550782-1-kuba@kernel.org>
From: Alex Elder <elder@ieee.org>
In-Reply-To: <20220504163725.550782-1-kuba@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/4/22 11:37 AM, Jakub Kicinski wrote:
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
>   drivers/net/ethernet/fungible/funeth/funeth_main.c | 3 +--
>   drivers/net/ethernet/lantiq_xrx200.c               | 4 ++--
>   drivers/net/ethernet/mellanox/mlx4/en_cq.c         | 3 +--
>   drivers/net/ethernet/microsoft/mana/mana_en.c      | 2 +-
>   drivers/net/ethernet/qlogic/qlcnic/qlcnic_io.c     | 9 ++++-----
>   drivers/net/ethernet/rocker/rocker_main.c          | 3 +--
>   drivers/net/ethernet/socionext/sni_ave.c           | 3 +--
>   drivers/net/ethernet/stmicro/stmmac/stmmac_main.c  | 5 ++---
>   drivers/net/ethernet/ti/am65-cpsw-nuss.c           | 4 ++--
>   drivers/net/ethernet/ti/cpsw.c                     | 5 ++---
>   drivers/net/ethernet/ti/cpsw_new.c                 | 5 ++---
>   drivers/net/ethernet/ti/netcp_core.c               | 2 +-
>   drivers/net/ipa/gsi.c                              | 4 ++--

For drivers/net/ipa/gsi.c:

Reviewed-by: Alex Elder <elder@linaro.org>

>   drivers/net/tun.c                                  | 3 +--
>   drivers/s390/net/qeth_core_main.c                  | 3 +--
>   net/mptcp/protocol.c                               | 4 ++--
>   19 files changed, 29 insertions(+), 40 deletions(-)
> 

. . .

> diff --git a/drivers/net/ipa/gsi.c b/drivers/net/ipa/gsi.c
> index bc981043cc80..db4cb2de218c 100644
> --- a/drivers/net/ipa/gsi.c
> +++ b/drivers/net/ipa/gsi.c
> @@ -1614,8 +1614,8 @@ static int gsi_channel_setup_one(struct gsi *gsi, u32 channel_id)
>   	gsi_channel_program(channel, true);
>   
>   	if (channel->toward_ipa)
> -		netif_tx_napi_add(&gsi->dummy_dev, &channel->napi,
> -				  gsi_channel_poll, NAPI_POLL_WEIGHT);
> +		netif_napi_add_tx(&gsi->dummy_dev, &channel->napi,
> +				  gsi_channel_poll);
>   	else
>   		netif_napi_add(&gsi->dummy_dev, &channel->napi,
>   			       gsi_channel_poll, NAPI_POLL_WEIGHT);

. . .

