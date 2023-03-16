Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34CE42574
	for <mptcp@lists.linux.dev>; Thu, 16 Mar 2023 09:35:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1678959321; x=1710495321;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=XSdA/tzh1oA+YHWvUYbB+BNJN185VFEmxlVBOOTiIQ8=;
  b=smBMHQS9aHBStaCSKYg0tIs4y2hWksT+W8bk3OxoJ+RPMmtGo3K7zlpe
   t7RlIbP/Ztq8QI6LV8pKcb5J0whbPVBclWbPn+7NIpoUQEVr2zhziHJB1
   kIeNSaTstVTyD+S6iuRjEREnx0Pv5i2jvQ855zoFxgluwVxUR8OnKHiju
   7jzan8pxhukSCY6UWIss6A7jYR3uveu4fAzZRBOSDSMo/SjeL6nEmbMnG
   LQeivNg1NZIz+oM0L32mIETWaeYtWbF4lEwP0erkXw3T+LpfTcsaZXZcs
   3s30kZQ2yrVlFZAruNoxOmVytJBT+qjStryzmYuY24zT072pBpL7hWpZE
   A==;
X-IronPort-AV: E=Sophos;i="5.98,265,1673938800"; 
   d="scan'208";a="142345028"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 16 Mar 2023 02:35:14 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Thu, 16 Mar 2023 02:35:14 -0700
Received: from den-her-m31857h.microchip.com (10.10.115.15) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2507.21 via Frontend Transport; Thu, 16 Mar 2023 02:35:12 -0700
Message-ID: <261a7bca8f0f1f78e85d79a7be27cd809c956464.camel@microchip.com>
Subject: Re: [PATCH net] hsr: ratelimit only when errors are printed
From: Steen Hegelund <steen.hegelund@microchip.com>
To: Matthieu Baerts <matthieu.baerts@tessares.net>, <mptcp@lists.linux.dev>,
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Kristian
 Overskeid <koverskeid@gmail.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Date: Thu, 16 Mar 2023 10:35:11 +0100
In-Reply-To: <20230315-net-20230315-hsr_framereg-ratelimit-v1-1-61d2ef176d11@tessares.net>
References: <20230315-net-20230315-hsr_framereg-ratelimit-v1-1-61d2ef176d11@tessares.net>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5-0ubuntu1 
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

Hi Mattieu,

Looks good to me.

Reviewed-by: Steen Hegelund <Steen.Hegelund@microchip.com>

On Wed, 2023-03-15 at 21:25 +0100, Matthieu Baerts wrote:
> EXTERNAL EMAIL: Do not click links or open attachments unless you know the content is safe
> 
> Recently, when automatically merging -net and net-next in MPTCP devel
> tree, our CI reported [1] a conflict in hsr, the same as the one
> reported by Stephen in netdev [2].
> 
> When looking at the conflict, I noticed it is in fact the v1 [3] that
> has been applied in -net and the v2 [4] in net-next. Maybe the v1 was
> applied by accident.
> 
> As mentioned by Jakub Kicinski [5], the new condition makes more sense
> before the net_ratelimit(), not to update net_ratelimit's state which is
> unnecessary if we're not going to print either way.
> 
> Here, this modification applies the v2 but in -net.
> 
> Link: https://github.com/multipath-tcp/mptcp_net-next/actions/runs/4423171069 [1]
> Link: https://lore.kernel.org/netdev/20230315100914.53fc1760@canb.auug.org.au/ [2]
> Link: https://lore.kernel.org/netdev/20230307133229.127442-1-koverskeid@gmail.com/ [3]
> Link: https://lore.kernel.org/netdev/20230309092302.179586-1-koverskeid@gmail.com/ [4]
> Link: https://lore.kernel.org/netdev/20230308232001.2fb62013@kernel.org/ [5]
> Fixes: 28e8cabe80f3 ("net: hsr: Don't log netdev_err message on unknown prp dst node")
> Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
> ---
>  net/hsr/hsr_framereg.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/net/hsr/hsr_framereg.c b/net/hsr/hsr_framereg.c
> index 865eda39d601..b77f1189d19d 100644
> --- a/net/hsr/hsr_framereg.c
> +++ b/net/hsr/hsr_framereg.c
> @@ -415,7 +415,7 @@ void hsr_addr_subst_dest(struct hsr_node *node_src, struct sk_buff *skb,
>         node_dst = find_node_by_addr_A(&port->hsr->node_db,
>                                        eth_hdr(skb)->h_dest);
>         if (!node_dst) {
> -               if (net_ratelimit() && port->hsr->prot_version != PRP_V1)
> +               if (port->hsr->prot_version != PRP_V1 && net_ratelimit())
>                         netdev_err(skb->dev, "%s: Unknown node\n", __func__);
>                 return;
>         }
> 
> ---
> base-commit: 75014826d0826d175aa9e36cd8e118793263e3f4
> change-id: 20230315-net-20230315-hsr_framereg-ratelimit-3c8ff6e43511
> 
> Best regards,
> --
> Matthieu Baerts <matthieu.baerts@tessares.net>
> 

BR
Steen

