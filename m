Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5015DEA0
	for <mptcp@lists.linux.dev>; Wed, 24 May 2023 00:20:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E76ABC433EF;
	Wed, 24 May 2023 00:20:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1684887612;
	bh=N2A/XvVmbCC9xMIVXLSqjSo3WHzwIp8zf7/imcv+1/A=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=o8a9XyVBlztOmrFZzgOAplh+2jyE62e5yc51ykSGpf1wUdwgoKagJZi5B952qjt5j
	 KAhNcE6ur80ptpxDcCdmP0OcrNOo89WA/CHDOHYQqSjI49x8uJoVGU41PMzcscu48G
	 /9DzuWCyKC7Jk5W/aCL/PJvVr/IpdxU0tXWwJRlWHyDt2N05tLWBXXW5BxucjnH1Au
	 o6S+g4xuTX5hIm803Sl182/26TM9Y10+SY0GCSEotluhVZejosXMZIIcfAF2mx9RNc
	 burLPIWa9DjhxC7heKAK/czNq5Gwx75+EdcJf76pbJKdaCrPR3z25VvSifOcimr8ti
	 BUQYomt8l0hkg==
Date: Tue, 23 May 2023 17:20:11 -0700 (PDT)
From: Mat Martineau <martineau@kernel.org>
To: Matthieu Baerts <matthieu.baerts@tessares.net>
cc: mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-next] net: skip printing "link become ready" v6
 msg
In-Reply-To: <20230522-mptcp-skip_print_link_becomes_ready-v1-1-9d5f28f19440@tessares.net>
Message-ID: <614e76ac-184e-c553-af72-084f792e60b0@kernel.org>
References: <20230522-mptcp-skip_print_link_becomes_ready-v1-1-9d5f28f19440@tessares.net>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Mon, 22 May 2023, Matthieu Baerts wrote:

> This following message is printed in the console each time a network
> device configured with an IPv6 addresses is ready to be used:
>
>  ADDRCONF(NETDEV_CHANGE): <iface>: link becomes ready
>
> When netns are being extensively used, e.g. by re-creating netns with
> veth to discuss with each other for testing purposes like mptcp_join.sh
> selftest is doing, it generates a lot of messages: more than 700 with
> the latest version.
>
> This message can be useful in many situations but in some, it floods the
> logs without providing any useful input. The proposition here is to have
> a new sysctl knob to easily skip this specific message.
>
> Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
> ---
> include/net/netns/ipv6.h                        | 1 +
> net/ipv6/addrconf.c                             | 5 +++--
> net/ipv6/sysctl_net_ipv6.c                      | 9 +++++++++
> tools/testing/selftests/net/mptcp/mptcp_join.sh | 1 +
> 4 files changed, 14 insertions(+), 2 deletions(-)
>

Hi Matthieu -

Using a sysctl for this seems like overkill. I noticed a similar change 
for ADDRCONF(NETDEV_UP) that changed a pr_info() to pr_debug():

7c62b8dd5ca89dabd9f455d19e663bad60951bd5

Maybe that's more suitable?


If you did want to keep pursuing the sysctl, the patch would need to 
update Documentation/networking/ip-sysctl.rst


Thanks,
Mat


> diff --git a/include/net/netns/ipv6.h b/include/net/netns/ipv6.h
> index 3cceb3e9320b..721abf86052f 100644
> --- a/include/net/netns/ipv6.h
> +++ b/include/net/netns/ipv6.h
> @@ -56,6 +56,7 @@ struct netns_sysctl_ipv6 {
> 	bool skip_notify_on_dev_down;
> 	u8 fib_notify_on_flag_change;
> 	u8 icmpv6_error_anycast_as_unicast;
> +	bool skip_print_link_becomes_ready;
> };
>
> struct netns_ipv6 {
> diff --git a/net/ipv6/addrconf.c b/net/ipv6/addrconf.c
> index 3797917237d0..9cf7b4932309 100644
> --- a/net/ipv6/addrconf.c
> +++ b/net/ipv6/addrconf.c
> @@ -3633,8 +3633,9 @@ static int addrconf_notify(struct notifier_block *this, unsigned long event,
> 				idev->if_flags |= IF_READY;
> 			}
>
> -			pr_info("ADDRCONF(NETDEV_CHANGE): %s: link becomes ready\n",
> -				dev->name);
> +			if (!net->ipv6.sysctl.skip_print_link_becomes_ready)
> +				pr_info("ADDRCONF(NETDEV_CHANGE): %s: link becomes ready\n",
> +					dev->name);
>
> 			run_pending = 1;
> 		}
> diff --git a/net/ipv6/sysctl_net_ipv6.c b/net/ipv6/sysctl_net_ipv6.c
> index 94a0a294c6a1..c9e82377a8fa 100644
> --- a/net/ipv6/sysctl_net_ipv6.c
> +++ b/net/ipv6/sysctl_net_ipv6.c
> @@ -213,6 +213,15 @@ static struct ctl_table ipv6_table_template[] = {
> 		.proc_handler	= proc_doulongvec_minmax,
> 		.extra2		= &ioam6_id_wide_max,
> 	},
> +	{
> +		.procname	= "skip_print_link_becomes_ready",
> +		.data		= &init_net.ipv6.sysctl.skip_print_link_becomes_ready,
> +		.maxlen		= sizeof(int),
> +		.mode		= 0644,
> +		.proc_handler	= proc_dointvec_minmax,
> +		.extra1         = SYSCTL_ZERO,
> +		.extra2         = SYSCTL_ONE,
> +	},
> 	{ }
> };
>
> diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
> index 0044d87556dd..27179e9175be 100755
> --- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
> +++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
> @@ -84,6 +84,7 @@ init_partial()
> 		ip netns exec $netns sysctl -q net.mptcp.pm_type=0
> 		ip netns exec $netns sysctl -q net.ipv4.conf.all.rp_filter=0
> 		ip netns exec $netns sysctl -q net.ipv4.conf.default.rp_filter=0
> +		ip netns exec $netns sysctl -q net.ipv6.skip_print_link_becomes_ready=1 2>/dev/null || true
> 		if [ $checksum -eq 1 ]; then
> 			ip netns exec $netns sysctl -q net.mptcp.checksum_enabled=1
> 		fi
>
> ---
> base-commit: 194dd0efe579cb5d3a746d248b3476f4b3fc0b48
> change-id: 20230522-mptcp-skip_print_link_becomes_ready-af50c71a9daa
>
> Best regards,
> -- 
> Matthieu Baerts <matthieu.baerts@tessares.net>
>
>
>
