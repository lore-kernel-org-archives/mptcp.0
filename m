Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2846633E0
	for <mptcp@lists.linux.dev>; Wed,  4 May 2022 22:01:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651701668; x=1683237668;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=85T/HK3Ljm2OuJ86i6TaZqpi0qkXHVTYq3nEoDDs7nc=;
  b=J0zLwJ0y0rstK5kscSJTpfKhAyeaLKaktUjL4oL14C/SsUM5nDbrRUOm
   FHumfdj9NELDqEhE2e5z7YNGMW0nhuGdjwjXH8fU9lYTysQW4rQjgCeYA
   rEwH68JOTXuiFs76bw8r+EJsfY7gT4AaTEmGhy+A/BiaemUH4aqSDRBft
   hKK3BbVtUwF07HJ28NYyXUIINnpg2eWscUyIc9EjZE74D+T+ZYXNcM4l+
   S9hkc3zsVHvDzLShpN+BL7idsqGntC+1aQ2NiDJAzvKURcTigqlDDqZMo
   B8eQRgDngBJ0uWhW9uAZxjdkfrVthnBS2TjMequenpSgumZJp3I8/Yw16
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10337"; a="248446472"
X-IronPort-AV: E=Sophos;i="5.91,199,1647327600"; 
   d="scan'208";a="248446472"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2022 15:01:07 -0700
X-IronPort-AV: E=Sophos;i="5.91,199,1647327600"; 
   d="scan'208";a="621003539"
Received: from jsbradle-mobl1.amr.corp.intel.com ([10.212.185.245])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2022 15:01:03 -0700
Date: Wed, 4 May 2022 15:01:01 -0700 (PDT)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Jakub Kicinski <kuba@kernel.org>
cc: davem@davemloft.net, netdev@vger.kernel.org, pabeni@redhat.com, 
    edumazet@google.com, rafal@milecki.pl, f.fainelli@gmail.com, 
    opendmb@gmail.com, dmichail@fungible.com, hauke@hauke-m.de, 
    tariqt@nvidia.com, kys@microsoft.com, haiyangz@microsoft.com, 
    sthemmin@microsoft.com, wei.liu@kernel.org, decui@microsoft.com, 
    shshaikh@marvell.com, manishc@marvell.com, jiri@resnulli.us, 
    hayashi.kunihiko@socionext.com, peppe.cavallaro@st.com, 
    alexandre.torgue@foss.st.com, joabreu@synopsys.com, 
    mcoquelin.stm32@gmail.com, grygorii.strashko@ti.com, elder@kernel.org, 
    wintera@linux.ibm.com, wenjia@linux.ibm.com, svens@linux.ibm.com, 
    matthieu.baerts@tessares.net, s-vadapalli@ti.com, chi.minghao@zte.com.cn, 
    linux-rdma@vger.kernel.org, linux-hyperv@vger.kernel.org, 
    mptcp@lists.linux.dev
Subject: Re: [PATCH net-next 1/2] net: switch to netif_napi_add_tx()
In-Reply-To: <20220504163725.550782-1-kuba@kernel.org>
Message-ID: <eb4dc61f-59a-794-d915-cfabbe469369@linux.intel.com>
References: <20220504163725.550782-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII

On Wed, 4 May 2022, Jakub Kicinski wrote:

> Switch net callers to the new API not requiring
> the NAPI_POLL_WEIGHT argument.
>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---

...

> net/mptcp/protocol.c                               | 4 ++--
> 19 files changed, 29 insertions(+), 40 deletions(-)
>

For the MPTCP content:

Acked-by: Mat Martineau <mathew.j.martineau@linux.intel.com>

> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index 52ed2c0ac901..7a9e2545884f 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -3786,8 +3786,8 @@ void __init mptcp_proto_init(void)
> 	for_each_possible_cpu(cpu) {
> 		delegated = per_cpu_ptr(&mptcp_delegated_actions, cpu);
> 		INIT_LIST_HEAD(&delegated->head);
> -		netif_tx_napi_add(&mptcp_napi_dev, &delegated->napi, mptcp_napi_poll,
> -				  NAPI_POLL_WEIGHT);
> +		netif_napi_add_tx(&mptcp_napi_dev, &delegated->napi,
> +				  mptcp_napi_poll);
> 		napi_enable(&delegated->napi);
> 	}
>
> -- 
> 2.34.1
>
>

--
Mat Martineau
Intel
