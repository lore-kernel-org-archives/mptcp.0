Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5B2468
	for <mptcp@lists.linux.dev>; Wed, 17 Nov 2021 01:22:25 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6200,9189,10170"; a="233695071"
X-IronPort-AV: E=Sophos;i="5.87,239,1631602800"; 
   d="scan'208";a="233695071"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Nov 2021 17:22:24 -0800
X-IronPort-AV: E=Sophos;i="5.87,239,1631602800"; 
   d="scan'208";a="645667253"
Received: from dassaura-mobl1.amr.corp.intel.com ([10.209.30.106])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Nov 2021 17:22:24 -0800
Date: Tue, 16 Nov 2021 17:22:14 -0800 (PST)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Phil Greenland <phil@quantulum.co.uk>
cc: mptcp@lists.linux.dev
Subject: Re: Subflow Creation / Management Issues
In-Reply-To: <EF21766C-4DF4-4F06-8076-16391C7D56D5@quantulum.co.uk>
Message-ID: <e34629ee-034-1544-163b-368d3ad9641@linux.intel.com>
References: <EF21766C-4DF4-4F06-8076-16391C7D56D5@quantulum.co.uk>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="0-242437660-1637098985=:38173"
Content-ID: <51cb7549-c8eb-1631-879b-9e8bd981ac90@linux.intel.com>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--0-242437660-1637098985=:38173
Content-Type: text/plain; CHARSET=UTF-8; format=flowed
Content-Transfer-Encoding: 8BIT
Content-ID: <f2d3ceb0-344a-ad64-2266-a8b6a260ccf3@linux.intel.com>


Hello Phil,

On Mon, 15 Nov 2021, Phil Greenland wrote:

> Hi,
>
> I’m currently working with a client, integrating MPTCP into their platform, with a goal of achieving reliable connectivity over a mix of WAN technologies.
>
> We started using 5.14 but were having problems getting MPTCP to handover between subflows when connectivity on individual links became poor.
>
> Updating to 5.15 brought a massive improvement. With the scheduler updates (stale subflow detection) handovers between links are now virtually seamless. Great work :-)
>
> We’ve started looking at corner cases that we might experience in the field.
>
> In our use case all connections originate from the client, to a server on the internet. The client has multiple endpoint addresses registered via “ip mptcp”, over which multiple subflows are created.
>
> ———————————
>
> Scenario 1)
>
> If we take network links up and down, adding and removing endpoint addresses as we do so, everything appears to work well, subflows are connected and disconnected as expected.
>
> However if a subflow fails, for example due to reception of a TCP RST from a NAT this seems to cause problems.
>
> The next time a link is taken down (a link other than the failing one), the associated subflow is disconnected as expected.
>
> When the link is brought back up, more often than not the failed subflow (the one stopped by a TCP RST) it re-connected and the newly added endpoint address, associated with the interface that was just brought up is not used.
>
> I believe this behaviour is due to an interaction between the local_addr_used variable within the MPTCP meta socket pm structure and the logic in select_local_address.
>
> The variable is incremented and decremented on subflow connection / disconnection (following endpoint addition / removal), but it's not decremented following the failure of a subflow.
>
> The select_local_address function only seems to check if a local address is currently in use before returning it.
>
> Therefore when an address is removed / re-added a single new subflow is permitted to be created (due to local_addr_used < local_addr_max), however the select_local_address function returns the first available address.
>
> Scenario 2)
>
> Following the initial MPTCP flow creation (with id 0?), if a subflow connection fails to be established, due to a connect timeout for example, no further subflows are established for the connection.
>
> It appears that the subflow connection success handler mptcp_pm_nl_subflow_established triggers the establishment of the next. Such that once the chain is broken by a failed connection no further subflows are established, even if unused endpoint addresses remain.
>
> Scenario 3)
>
> As a continuation of scenario 1, if for some strange reason all subflows were to fail, all at once, or over time. I'm left with just the MPTCP meta socket. The application believes it's still connected but there’s no way it seems to recover the connection. Other than adding a new endpoint address, which will trigger one of the subflows (again not necessarily the new endpoint) to be re-connected.
>
> ———————————
>

First, thank you for the feedback - it's very helpful to know how this 
MPTCP implementation is getting used and what issues people are running in 
to.

Paolo covered your questions well in relation to the existing in-kernel 
path manager that's responsible for controlling subflow establishment. 
(Thanks Paolo!)

> Is there anything on your roadmap that might help address these few issues above?
>

I think we may have something in development that will fit your needs 
better on the client side: userspace path management.

The existing in-kernel path manager is best suited to server-side use 
cases. We can still improve it to better handle the issues you've 
observed, and Paolo's advice on github issues 
(https://github.com/multipath-tcp/mptcp_net-next/issues) will help with 
that.

Userspace path management will add more netlink calls that allow a 
userspace program like mptcpd (https://github.com/intel/mptcpd) to control 
the establishement of subflows - and to customize path management without 
requiring changes to the kernel. The tradeoff is the overhead of using the 
netlink API, so this is better suited to client devices with a smaller 
number of connections, as opposed to a server with hundreds or thousands 
of connections.

Does that sound like a fit for what you're doing on the client side?

> I’ve been considering a temporary hack, which I hope would address all three. Adding a netlink call, based heavily on your add address handler, to walk the meta socket list, and try to reconnect any / all failed subflows. Which I can call periodically or in response to network events.
>
> I’d happily attempt to develop a more formal fix, with some guidance, but haven’t done lot of Linux kernel development in the past.
>
> Apologies for the long email / keep up the great work! It’s really good to see MPTCP make it into the mainline kernel.
>

Thanks again for the long email and the encouragement!


--
Mat Martineau
Intel
--0-242437660-1637098985=:38173--
