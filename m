Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C2EB71
	for <mptcp@lists.linux.dev>; Wed, 19 May 2021 18:06:03 +0000 (UTC)
IronPort-SDR: q2MjqYxXjy1BuwSZoTeSDbbTYuOfQYNcIkjDyrMtGsGncAvcGOtuQY6cZ9E/9MeA7YUgrD8lrD
 syswBRINfQPQ==
X-IronPort-AV: E=McAfee;i="6200,9189,9989"; a="264961023"
X-IronPort-AV: E=Sophos;i="5.82,313,1613462400"; 
   d="scan'208";a="264961023"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2021 11:06:02 -0700
IronPort-SDR: 0StTh8U+dGt/hBCLBAzMmhdkcLXbMRczJWrP/Ykn5EbVsSuQZyaOY0/tC+80g5c/7Mrh5+6QiC
 O8fKxnJIWQwQ==
X-IronPort-AV: E=Sophos;i="5.82,313,1613462400"; 
   d="scan'208";a="474731722"
Received: from rmacfarl-mobl1.amr.corp.intel.com ([10.255.228.18])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2021 11:06:01 -0700
Date: Wed, 19 May 2021 11:06:01 -0700 (PDT)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Paolo Abeni <pabeni@redhat.com>
cc: Florian Westphal <fw@strlen.de>, Geliang Tang <geliangtang@gmail.com>, 
    mptcp@lists.linux.dev
Subject: Re: [MPTCP][PATCH v6 mptcp-next 0/6] add MP_CAPABLE 'C' flag
In-Reply-To: <ef31d1b4b0456a02f0e8515c449ea4fd4e7c1611.camel@redhat.com>
Message-ID: <56ee8dc0-e1b1-84c1-acbd-154cc24ee098@linux.intel.com>
References: <cover.1621002341.git.geliangtang@gmail.com>   <10c0783f0b81ab279dbbf202033295e7891c18d6.camel@redhat.com>   <11169a25-2e4-a879-2c92-bad09a28a18@linux.intel.com>  <ccc1707df9391e1552ac67f6b358e879ab3aed0a.camel@redhat.com> 
 <dd9d31d-134-8b8b-7f40-f34e4be75956@linux.intel.com> <ef31d1b4b0456a02f0e8515c449ea4fd4e7c1611.camel@redhat.com>
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed


On Wed, 19 May 2021, Paolo Abeni wrote:

> On Tue, 2021-05-18 at 12:07 -0700, Mat Martineau wrote:
>> On Tue, 18 May 2021, Paolo Abeni wrote:
>>> The in-kernel path manager is want to be as simple as possible. As soon
>>> as we start allocating memory on peer req it's very easy to be prone to
>>> DoS. Memory accounting and limits could save us or at least mitigate
>>> the problem, but they will add more complexity.
>>
>> My assumption was that high-connection-count servers would probably have
>> their limits set in a way that ADD_ADDRs would not be accepted anyway.
>> This is the use case where clients may be behind a NAT and the server is
>> accepting MP_JOINs from the client (but the server is never sending
>> MP_JOINs), and the server is possibly sending ADD_ADDRs to the client. The
>> configurable limit is already there from the existing in-kernel PM code.
>>
>> I do agree with "as simple as possible", but the RFC requirements are
>> constraining that. Even though the C bit is ignored in Linux
>> implementations so far, I don't think it should stay that way. The current
>> code always tries to connect to the initial subflow, so we need to do
>> *something* different to remember an alternate peer address. There are
>> other options (like remembering only the most recent ADD_ADDR), but given
>> the configurable limits we have it doesn't seem that different
>> memory-wise. What's important is implementing this RFC functionality well,
>> so it's really helpful to explore the alternatives here - and your
>> understanding of the resource issues and DoS tradeoffs is very useful.
>
> Uhmmm... I start feeling I misunderstand the RFC WRT to 'C' bit
> handling.
>
> """
> 		 The third bit, labeled "C", is set to 1 to indicate
>                 that the sender of this option will not accept
>                 additional MPTCP subflows to the source address and
>                 port, and therefore the receiver MUST NOT try to open
>                 any additional subflows toward this address and port.
> """
>
> To avoid creating additional subflows towards the MPC server
> address/port, we don't need to store any additional information beyond
> the 'C' flag: net-next uses that pair only for new subflow with
> 'subflow' type (yep, the type name is not very self-explaining :(
>
> We just need to forbit them:
>
> ---
> diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
> index d094588afad8..2ae9fac00623 100644
> --- a/net/mptcp/pm_netlink.c
> +++ b/net/mptcp/pm_netlink.c
> @@ -451,7 +451,7 @@ static void mptcp_pm_create_subflow_or_signal_addr(struct mptcp_sock *msk)
>
>        /* check if should create a new subflow */
>        if (msk->pm.local_addr_used < local_addr_max &&
> -           msk->pm.subflows < subflows_max) {
> +           msk->pm.subflows < subflows_max && !msk->pm.remote_deny_join_id0) {
>                local = select_local_address(pernet, msk);
>                if (local) {
>                        struct mptcp_addr_info remote = { 0 };
>
> ---
>
>>> Just does not seam worthy to me, I really think we should start with
>>> the bare minumum to respect the RFC itself, avoiding as much complexity
>>> as possible:
>>> - setting C always to 0 on server
>>> - when the peer send C==1, cache the MPC addr/port, and do not attempt
>>> other connection to such endpoint.
>>>
>>> I'm not even sure the latter step is strictly necessary.
>>
>> For the former, it is certainly simpler to always send C==0, but sending
>> C==1 from a high-connection-count server behind a load balancer is the
>> primary use case.
>
> I *think* it would be far better (and possibly not that complex!!!
> @Florian: WDYT? ) implementing an MPTCP aware load balancer. The MPJ
> syn pkt carries the remote token, so it's possible for the load
> balancer to make the "correct" decision.
>
>> I think the "MUST NOT" wording of the RFC does require the latter step
>> (server or client), and that implies a minimally functional in-kernel PM
>> would need to track some other address to connect to.
>
> This part is unclear to me. Why should the kernel cache more
> addresses?
>
> It's already capabale of using as many ADD_ADDRs as the peer provides
> with the current options handling. Sure, there are some constraints.
> The stricter one posed by the current implementation is that the kernel
> fully processes (up to subflow creation) a given ADD_ADDR option before
> using another one.
>
> That is useful to avoid transforming an MPTCP client in a DDOS tool
> controlled by an (evil) MPTCP server, and sounds like a reasonable
> tread-off between complexity and flexibility.
>
> Looks like we have some topic for tomorrow's mtg :)
>

Yeah, I think it will be far easier to discuss in that format!

--
Mat Martineau
Intel
