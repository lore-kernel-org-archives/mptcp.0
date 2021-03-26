Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B519F5F
	for <mptcp@lists.linux.dev>; Fri, 26 Mar 2021 18:39:18 +0000 (UTC)
IronPort-SDR: /BdvG8PiheVvYO3HkxZYNYPaX4AHOm9mvvXZK0lUxI54RPHsUtFXYvoa97MqENfHfA4Z+pRj9P
 7f5AXeuQK0Og==
X-IronPort-AV: E=McAfee;i="6000,8403,9935"; a="170581114"
X-IronPort-AV: E=Sophos;i="5.81,281,1610438400"; 
   d="scan'208";a="170581114"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2021 11:39:18 -0700
IronPort-SDR: zR70JK7PVgmwPNDBIf6bNm+7ch7hD0oCgu4LCCfplSWL1oStrQkWs/wNjvFlaZFayy0TpwLeu8
 QkjOJex1QjuA==
X-IronPort-AV: E=Sophos;i="5.81,281,1610438400"; 
   d="scan'208";a="443461279"
Received: from hhussin-mobl.gar.corp.intel.com ([10.251.24.138])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2021 11:39:17 -0700
Date: Fri, 26 Mar 2021 11:39:17 -0700 (PDT)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Davide Caratti <dcaratti@redhat.com>
cc: mptcp@lists.linux.dev, Matthieu Baerts <matthieu.baerts@tessares.net>, 
    mptcp@lists.01.org
Subject: Re: [PATCH net-next] mptcp: drop all sub-options except ADD_ADDR
 when the echo bit is set
In-Reply-To: <aeb4b7f3044e2f869ae026f950eb70c4398dad63.1616761454.git.dcaratti@redhat.com>
Message-ID: <5e58a6a0-7470-7498-4f45-a61641c3691@linux.intel.com>
References: <aeb4b7f3044e2f869ae026f950eb70c4398dad63.1616761454.git.dcaratti@redhat.com>
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed


On Fri, 26 Mar 2021, Davide Caratti wrote:

> Current Linux carries echo-ed ADD_ADDR over pure TCP ACKs, so there is no
> need to add a DSS element that would fit only ADD_ADDR with IPv4 address.
> Drop the DSS from echo-ed ADD_ADDR, regardless of the IP version.
>
> Signed-off-by: Davide Caratti <dcaratti@redhat.com>
> ---
> net/mptcp/options.c | 3 ++-
> 1 file changed, 2 insertions(+), 1 deletion(-)

Thanks Davide, looks good to me. This didn't land in patchwork without the 
mptcp@lists.01.org cc, but we should have mptcp@lists.linux.dev routed in 
to patchwork by Monday (Australia time).

Reviewed-by: Mat Martineau <mathew.j.martineau@linux.intel.com>


>
> diff --git a/net/mptcp/options.c b/net/mptcp/options.c
> index c7eb61d0564c..d51c3ad54d9a 100644
> --- a/net/mptcp/options.c
> +++ b/net/mptcp/options.c
> @@ -624,7 +624,8 @@ static bool mptcp_established_options_add_addr(struct sock *sk, struct sk_buff *
> 	int len;
>
> 	if ((mptcp_pm_should_add_signal_ipv6(msk) ||
> -	     mptcp_pm_should_add_signal_port(msk)) &&
> +	     mptcp_pm_should_add_signal_port(msk) ||
> +	     mptcp_pm_should_add_signal_echo(msk)) &&
> 	    skb && skb_is_tcp_pure_ack(skb)) {
> 		pr_debug("drop other suboptions");
> 		opts->suboptions = 0;
> -- 
> 2.30.2

--
Mat Martineau
Intel
