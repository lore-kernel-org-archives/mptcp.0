Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E940F5F
	for <mptcp@lists.linux.dev>; Thu, 25 Mar 2021 00:11:29 +0000 (UTC)
IronPort-SDR: PgbIS1AOudc2nPSe/1CTI1RyOMJVPZ9VNHyA+IMoc2Xq+IuyJti0G+QRoHtveoG7ltbUgl54b7
 fMDM3oK6VTPA==
X-IronPort-AV: E=McAfee;i="6000,8403,9933"; a="254801529"
X-IronPort-AV: E=Sophos;i="5.81,276,1610438400"; 
   d="scan'208";a="254801529"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2021 17:11:28 -0700
IronPort-SDR: iNukDdrD4LZqh0RBWLZArAq5nW3NttZEoaJiO+sNjSQyZnnZH9jmc4HaDSbjUT5bM8gVRAu+Mt
 U9rjXfr4W59Q==
X-IronPort-AV: E=Sophos;i="5.81,276,1610438400"; 
   d="scan'208";a="514390807"
Received: from yuanzha5-mobl.amr.corp.intel.com ([10.252.129.242])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2021 17:11:28 -0700
Date: Wed, 24 Mar 2021 17:11:27 -0700 (PDT)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Davide Caratti <dcaratti@redhat.com>
cc: mptcp@lists.linux.dev, mptcp@lists.01.org, 
    Matthieu Baerts <matthieu.baerts@tessares.net>
Subject: Re: [RFC PATCH net-next] mptcp: drop all sub-options except ADD_ADDR
 when the echo bit is set
In-Reply-To: <aeb4b7f3044e2f869ae026f950eb70c4398dad63.1616620119.git.dcaratti@redhat.com>
Message-ID: <c4dc9962-64a6-30f1-84ac-8be76ac9c68c@linux.intel.com>
References: <aeb4b7f3044e2f869ae026f950eb70c4398dad63.1616620119.git.dcaratti@redhat.com>
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Wed, 24 Mar 2021, Davide Caratti wrote:

> Current Linux carries echo-ed ADD_ADDR over pure TCP ACKs, so there is no
> need to add a DSS element that would fit only ADD_ADDR with IPv4 address.
> Drop the DSS from echo-ed ADD_ADDR, regardless of the IP version.
>
> Signed-off-by: Davide Caratti <dcaratti@redhat.com>
> ---
>
> Notes:
>    hello,
>
>    maybe this is a known issue, maybe not. In case it is, TLDR:
>
>    while working on packetdrill with REMOVE_ADDR, I noticed that the following
>    inbound packet:
>
>     +0.0      <   .  1:1(0)  ack 101  win 256  <nop, nop, TS val 705 ecr 305, add_address addr[saddr] hmac=auto>
>
>    had wrong length TCPOLEN_ADD_ADDR_V4_HMAC (18 Byte) in the IPv6 case, so the
>    address carried in the option was something that probably can't be used by the
>    client, because it doesn't belong to the same address family of the source
>    address used by the (client) kernel socket.
>
>    So, I wrote a fix for packetdrill and now it selects the correct ADD_ADDR length
>    both for IPv4 and IPv6 inbound packets.
>
>    However, matching the subsequent outbound echo-ed ADD_ADDR became problematic:
>    the IPv4 echoed ADD_ADDR has a trailing DSS option that's not existent in the
>    IPv6 equivalent of the test (because it does not fit the max TCP option space).
>    Is there a reason for not saving the DSS option space in the IPv4 case? If not,
>    can we harmonize at least echo-ed IPv4 and IPv6 ADD_ADDRs?
>
>    any feedback appreciated, thank you in advance!

Only reason I can think of to include the DSS is to carry the MPTCP-level 
ACK, since a previous MPTCP-level ACK could have been lost if it was 
carried on a pure TCP ack.

I don't think we gain a lot from adding the DSS option to these ADD_ADDR 
echoes, because:

  * the MPTCP-level ACK is very likely a duplicate

  * the protocol will recover from a lost ACK

  * ADD_ADDR echoes are not sent very often


I'm ok with skipping the DSS option in this case.


Mat


> net/mptcp/options.c | 3 ++-
> 1 file changed, 2 insertions(+), 1 deletion(-)
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
