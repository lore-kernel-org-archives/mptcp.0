Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D58513D6C
	for <mptcp@lists.linux.dev>; Wed, 29 Jun 2022 16:07:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656518830; x=1688054830;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=JcJuKyQXdMqU/X4dFKdSKZmflzQzaO0nyMJJjT8+pU4=;
  b=GIEf0uUaWFMy70UOyFUYN8AJQf/c3ao8FgEQzBP4aGw5TkXYYqMU45G/
   ZM6FkfgaSaskBpByZDl7QYIujUl39Ok1idO7gVOFmkbRYL6GHfzOOntOh
   XDztQqu1Dzu46+M+P7YxNcbHswauC94EIq8asFxCzU51cSb75zXaGJVFa
   cV6rcnw2ENW0LyJCwz8lTgtDaeKmwrvYpdq7S51Vfj5L0UG/ZiyI2sqCZ
   td6z0wykhjt5WlvoI8lTMOoZ58cNS26qBQZ7oSQI5lZL1XO6662h4b+49
   HMjoMPIgNaDVdYBR7l0pduVYIpgzBI85HcuevmFHvCQN7WsSTXxDPTob9
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10393"; a="265107787"
X-IronPort-AV: E=Sophos;i="5.92,231,1650956400"; 
   d="scan'208";a="265107787"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jun 2022 09:07:10 -0700
X-IronPort-AV: E=Sophos;i="5.92,231,1650956400"; 
   d="scan'208";a="837178645"
Received: from bschenc3-mobl.amr.corp.intel.com ([10.209.57.164])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jun 2022 09:07:09 -0700
Date: Wed, 29 Jun 2022 09:07:09 -0700 (PDT)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Paolo Abeni <pabeni@redhat.com>
cc: mptcp@lists.linux.dev
Subject: Re: [PATCH RFC 3/4] mptcp: allow the in kernel PM to set MPC subflow
 priority
In-Reply-To: <08338fd031ddcb369d37f765cfbddf933cc3fdad.camel@redhat.com>
Message-ID: <6129115f-b3c0-24e0-d7d4-f9ec9bf4383@linux.intel.com>
References: <cover.1656088406.git.pabeni@redhat.com>  <8a80c3bf12e43985e00b4fb04beccd38d69e505b.1656088406.git.pabeni@redhat.com>  <31cf8780-ea9f-fdf7-dffa-b77c831747@linux.intel.com> <08338fd031ddcb369d37f765cfbddf933cc3fdad.camel@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Wed, 29 Jun 2022, Paolo Abeni wrote:

> On Tue, 2022-06-28 at 17:11 -0700, Mat Martineau wrote:
>> On Fri, 24 Jun 2022, Paolo Abeni wrote:
>>
>>> Any local endpoints configured on the address matching the
>>> MPC subflow are currently ignored.
>>>
>>> Specifically, setting a backup flag on them has no effect
>>> on the first subflow, as the MPC handshake can't carry such
>>> info.
>>>
>>> This change refactors the MPC endpoint id accounting to
>>> additionally fetch the priority info from the relevant endpoint
>>> and eventually trigger the MP_PRIO handshake as needed.
>>>
>>> As a result, the MPC subflow now switches to backup priority
>>> after that the MPTCP socket is fully established, according
>>> to the local endpoint configuration.
>>>
>>> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
>>> ---
>>> net/mptcp/pm_netlink.c | 37 +++++++++++++++----------------------
>>> 1 file changed, 15 insertions(+), 22 deletions(-)
>>>
>>> diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
>>> index 91f6ed2a076a..a6eb501e5031 100644
>>> --- a/net/mptcp/pm_netlink.c
>>> +++ b/net/mptcp/pm_netlink.c
>>> @@ -505,30 +505,14 @@ __lookup_addr(struct pm_nl_pernet *pernet, const struct mptcp_addr_info *info,
>>> 	struct mptcp_pm_addr_entry *entry;
>>>
>>> 	list_for_each_entry(entry, &pernet->local_addr_list, list) {
>>> -		if ((!lookup_by_id && mptcp_addresses_equal(&entry->addr, info, true)) ||
>>> +		if ((!lookup_by_id &&
>>> +		     mptcp_addresses_equal(&entry->addr, info, entry->addr.port)) ||
>>
>> It seems like we could have multiple entries in the local_addr_list with
>> the same address, but with different entries having port==0 or nonzero
>> ports. If mptcp_nl_cmd_set_flags() is called with a nonzero port, but this
>> lookup function encounters the port==0 entry first, this will match an
>> unexpected entry in local_addr_list.
>>
>> Is there some other constraint preventing this?
>
> Uhmmm.. I updated the mptcp_addresses_equal() statement to match the
> existing one in lookup_id_by_addr() below.
>
> You are right, this check is uncorrect, and generally speaking the
> mptcp_addresses_equal() invocations are a bit fuzzy. I'll try to
> clarify that with an additional patches:
>
> - mptcp_addresses_equal() on subflow list use port matching if the
> looked-up address has  non 0 port (the current code looks correct)
>
> - mptcp_addresses_equal on local_addr_list should use port matching if
> address_use_port(entry), and entry with port matching should be
> preferred over entries without port-matching. The latter can be
> enforces adding entries with address_use_port(entry) at the list head
> and entries with !address_use_port(entry) at tail
>
> WDYT?

That looks like a good plan - thanks

--
Mat Martineau
Intel
