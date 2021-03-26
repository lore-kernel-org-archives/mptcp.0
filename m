Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52E1C5F
	for <mptcp@lists.linux.dev>; Fri, 26 Mar 2021 00:14:25 +0000 (UTC)
IronPort-SDR: X/cIbdvn0Kn2aNxTT36dW+zYx5zLraL39aUFKRKMDvzuNLkb3wq599YVBF6yEXjz/DZmr3kk7t
 2MQ0Iqc4fijw==
X-IronPort-AV: E=McAfee;i="6000,8403,9934"; a="191143373"
X-IronPort-AV: E=Sophos;i="5.81,278,1610438400"; 
   d="scan'208";a="191143373"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2021 17:14:22 -0700
IronPort-SDR: N1zen8uu+EO9sx7XaJGR6pfbwPKIjxEK6tufqa34E5lcPziGNH7r+26m0IYsK2pdWitDHbg/ot
 PDQtzG/ftWDg==
X-IronPort-AV: E=Sophos;i="5.81,278,1610438400"; 
   d="scan'208";a="453289888"
Received: from shasan-mobl.amr.corp.intel.com ([10.255.230.27])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2021 17:14:22 -0700
Date: Thu, 25 Mar 2021 17:14:22 -0700 (PDT)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Florian Westphal <fw@strlen.de>
cc: mptcp@lists.linux.dev, mptcp@lists.01.org
Subject: Re: [RFC PATCH mptcp-next v2 5/8] mptcp: setsockopt: add SO_MARK
 support
In-Reply-To: <20210325093206.GA26567@breakpoint.cc>
Message-ID: <76159eb6-ec62-931-a360-581430b223@linux.intel.com>
References: <20210324131546.13730-1-fw@strlen.de> <20210324131546.13730-6-fw@strlen.de> <c4fbd91c-2873-956b-df8-7bba2da711f@linux.intel.com> <20210325093206.GA26567@breakpoint.cc>
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Thu, 25 Mar 2021, Florian Westphal wrote:

> Mat Martineau <mathew.j.martineau@linux.intel.com> wrote:
>> On Wed, 24 Mar 2021, Florian Westphal wrote:
>>
>>> Value is synced to all subflows.
>>>
>>
>> The use case I remember for SO_MARK with MPTCP was to designate different
>> interfaces for different subflows:
>>
>> https://lore.kernel.org/mptcp/CAKD1Yr2sBCdUO48cp=rZQ6s4v13ytpPd9oPT+U=iYrdXtba5HA@mail.gmail.com/
>>
>>
>> Once we have a way to set individual subflow options, it could both be
>> useful to set sk_mark on all subflows, and also to not override individual
>> settings. The current sync mechanism would overwrite all supported options
>> when any single option changes.
>>
>> There's no way for these options to diverge yet, so we could wait on solving
>> that problem. Do you think it's better to stick with the current syncing
>> method for now, or to do more detailed tracking of which options need to be
>> synced?
>
> Looks like same issue as with TCP_CONGESTION.
> Q is how we can expose the individual subflows.
>
> I see
> https://tools.ietf.org/html/draft-hesmans-mptcp-socket-03
>
> Should that be implemented instead of this?
>

I had a chance to look at the linked draft, and I think where we ended up 
in the discussion earlier today was this:

  * per-subflow options are useful (SO_MASK, etc)

  * overall settings like this patch set does are also helpful, I think 
especially to make MPTCP sockets behave more like TCP sockets.


The two should be compatible, and the concern I'm pointing out is that the 
proposed sync would clobber individual subflow options even if the 
matching MPTCP-level sockopts had never been set. That may be addressible 
by only syncing "new" subflows rather than all of them in the list.

--
Mat Martineau
Intel
