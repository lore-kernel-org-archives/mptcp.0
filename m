Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6BF22F25
	for <mptcp@lists.linux.dev>; Wed, 11 May 2022 18:24:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652293463; x=1683829463;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=LfqyO4B2u7FQcKvROmlZHAZ5Ma1IkSO3ib/+XdA48hQ=;
  b=GKg3IBJfq/UX1niqTXn00cvKE0dad65advJ3uF04dihMfVVZhpnWUOZy
   zCuiJ2XCMIIk7KQrfU5hjJQ4UlxOCzHhBCYXJajbb6MgiMGxkNv89NcJ+
   HP7xYsrxeGtvB/LCH3sY8/nDUXEWLrHvo14zIBxajURe8meu8fzqf/k/+
   SoSIN3vNvETMxt8zEISvn0Y2hBczemV4XzgpUwAsyctRbPmYZ3ZUv6f2j
   3M3s7rqquZAbZ5JSblwDFEpkES5sGaUife9ndIu5WEN2OsJZeULw5/zJJ
   eVmOnFUCVkUwSXhR1C8O6XY2JBR/ru04Pqi9fxrjRDsC8LQsPov5MudvS
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10344"; a="356202978"
X-IronPort-AV: E=Sophos;i="5.91,217,1647327600"; 
   d="scan'208";a="356202978"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2022 11:24:22 -0700
X-IronPort-AV: E=Sophos;i="5.91,217,1647327600"; 
   d="scan'208";a="542424609"
Received: from rdstein-mobl.amr.corp.intel.com ([10.212.177.197])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2022 11:24:21 -0700
Date: Wed, 11 May 2022 11:24:20 -0700 (PDT)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Paolo Abeni <pabeni@redhat.com>
cc: mptcp@lists.linux.dev, Geliang Tang <geliang.tang@suse.com>
Subject: Re: problems with MP_FAIL timer
In-Reply-To: <487184c3ac424c9613bb4811564babbbf096b29e.camel@redhat.com>
Message-ID: <e6434d14-9d2b-f67c-a292-72776d807ab9@linux.intel.com>
References: <cf419fbb3022f54fa63476a75361a016a7051367.camel@redhat.com>  <88834512-46aa-604e-9e25-a17c13a6986@linux.intel.com> <487184c3ac424c9613bb4811564babbbf096b29e.camel@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Wed, 11 May 2022, Paolo Abeni wrote:

> On Wed, 2022-05-11 at 08:32 -0700, Mat Martineau wrote:
>> On Wed, 11 May 2022, Paolo Abeni wrote:
>>
>>> Hello,
>>>
>>> re-reviewing again the commit:
>>>
>>> mptcp: reset subflow when MP_FAIL doesn't respond
>>>
>>> There are a few issue with sk_timer handling, specifically:
>>> - no additional mptcp_data_lock is needed to stop/reset it
>>> - I think overlapping infinite mapping reception and close may lead to
>>> some inconsistent timer usage
>>>
>>
>> I'm working on a patch for this.
>>
>> The issues you describe are what I was trying to comment on in
>> https://lore.kernel.org/mptcp/bdde3a40-1471-c8b9-65bd-f53ddebacdb4@linux.intel.com/,
>> but my proposed solution (deferred events for coordinating with
>> msk->sk_state) isn't the way to fix it.
>
> I think there is anoter issue: in mptcp_timeout_timer(), via
> mptcp_check_mp_fail_response() -> mp_fail_response_expect_subflow() ->
> mp_fail_response_expect_subflow(), the code traverse the conn_list
> under the msk socket spin_lock. That is not enough: it should instead
> acquire the full msk socket lock.

Agreed.

> We can use the is_not_owned || defer to release_cb schema, but I think
> we are simply better off reverting such patch. Any strong opinion
> against that?

I don't think we can just revert: it's important to either fall back or 
reset, and not leave the connection in some indefinite state after sending 
a MP_FAIL that's ignored (the RFC is specific that the peer must respond 
with MP_FAIL). So we need to use some timer to implement that behavior, or 
use other events (rx/tx/etc) to check for a timely MP_FAIL reply and reset 
if it hasn't arrived. The timer approach seems simpler.


--
Mat Martineau
Intel
