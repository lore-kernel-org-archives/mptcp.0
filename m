Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2FFF70
	for <mptcp@lists.linux.dev>; Wed, 26 May 2021 22:51:36 +0000 (UTC)
IronPort-SDR: M2Us2ICfrzxKK1QcRclIlcWqDGa9fq0aP6kTn204vUbUJKc1dyfCYKUwi3dNruSWzvb4Z/YKpu
 mFN8GYGzHsvA==
X-IronPort-AV: E=McAfee;i="6200,9189,9996"; a="200703203"
X-IronPort-AV: E=Sophos;i="5.82,333,1613462400"; 
   d="scan'208";a="200703203"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 May 2021 15:51:34 -0700
IronPort-SDR: foHDzfKonwpawJQlxMM7aEEHCxYJyrraSlI8ZTCGkF/kov8fgxfzZEHq0ENray28P9ZUj5gCap
 JF01YSR7VRPg==
X-IronPort-AV: E=Sophos;i="5.82,333,1613462400"; 
   d="scan'208";a="477167310"
Received: from oelenito-mobl1.amr.corp.intel.com ([10.212.180.42])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 May 2021 15:51:33 -0700
Date: Wed, 26 May 2021 15:51:32 -0700 (PDT)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Paolo Abeni <pabeni@redhat.com>
cc: mptcp@lists.linux.dev
Subject: Re: [PATCH v2 mptcp-next] mptcp: drop tx skb cache
In-Reply-To: <32a776b7dd322f114e385ca406f5ca879c7831cd.camel@redhat.com>
Message-ID: <8636f1cb-12c2-5cf7-361a-b83880ea904@linux.intel.com>
References: <8dd3343ea83a7a631acfe4940a9dea841b32c52a.1621613936.git.pabeni@redhat.com>  <e9657dbd-f455-61e9-2118-e2b2443fafb@linux.intel.com> <32a776b7dd322f114e385ca406f5ca879c7831cd.camel@redhat.com>
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Wed, 26 May 2021, Paolo Abeni wrote:

> On Fri, 2021-05-21 at 15:57 -0700, Mat Martineau wrote:
>> On Fri, 21 May 2021, Paolo Abeni wrote:
>>
>>> The mentioned cache was introduced to reduce the number of skb
>>> allocation in atomic context, but the required complexity is
>>> excessive.
>>>
>>> This change remove the mentioned cache.
>>>
>>> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
>>> ---
>>> v1 -> v2:
>>> - drop unused field skb_tx_cache
>>
>> There's also a size_goal_cache field in struct mptcp_sock that's now
>> unused.
>
> yep, will do in v3 (sorry, I lost track of this review)
>
>> I like the simplification! Do the self tests trigger enough memory
>> pressure to test allocation in that scenario?
>
> Will ensure that before posting v3
>
>> The commit that introduced the skb_tx_cache did so to allow removal of the
>> skb_ext cache. It looks like both caches are now unnecessary because the
>> skb and skb_ext allocations are handled together in the
>> __mptcp_{do_,}alloc_tx_skb() functions - so an allocation failure can be
>> handled without the complexity of the caches.
>
> The cache goal was avoid/reduce skb allocation in atomic context. That
> is still true (e.g. with skb_tx_cache we have less skb allocation in
> atomic context, expecially when the transfer is link/pacing/peer
> limited). Plain TCP can allocare skbs in atomic context, but that does
> not happen often. MPTCP will do that almost for each skb,
> when link/pacing/peer limited.
>
> I think we can ignore the above, as e.g. high performance NIC device
> driver always allocate skb in atomic context.
>

I think you have a better sense of the tradeoffs with the allocation 
context than I do - from what you describe it doesn't seem like the extra 
complexity to avoid atomic allocation has a significant payoff.

>>  Does that match your
>> understanding? If so, it would be helpful information for the commit
>> message.
>
> The main trick, imho is that we still use the sk->sk_tx_skb_cache to
> prevent the TCP stack from allocating extension-less skb. That trick
> was introduced with the mptcp tx_cache.
>
> Not sure if the above clarify anything ?!?

Yes - it's helpful background, thanks!

--
Mat Martineau
Intel
