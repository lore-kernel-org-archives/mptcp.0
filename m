Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A9722F27
	for <mptcp@lists.linux.dev>; Mon, 23 May 2022 18:20:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1653330054; x=1684866054;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=FvMPSbf1RkFEXuW8wPohUwXosu3qibhi5AnHRlu7V/4=;
  b=mmYYauXZsdeN0/WzErt5lrSKhQd5TAmmJTsjbamGwRt/9C65THPSTzlD
   YQLRI04uXtESHQd66a9WKhii1EDGFNCUhMFNHXUbSJJ78gX2WoXTnC//U
   RIkZUpIg7KIpw+wL7Xv+Iy5SBgzBoKwDo9v9eJOOj1+KtoZBeJVmA7lNZ
   ZYv02Co+7HoMr6S1tA9JMLL09/wA9mv7CS418vpnpie4UhPyxJv2eCQdw
   prQ2ZhHcY7XGHgH+3YLbaUnl9dabujcREWOySA6M/etuY/T4WVayXIrtU
   V7MWHv7bIstGBU+xpGEbI9JjVujBbws04s5CxZCRqIlVco5pmo762MM3F
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10356"; a="336370509"
X-IronPort-AV: E=Sophos;i="5.91,246,1647327600"; 
   d="scan'208";a="336370509"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 May 2022 11:20:53 -0700
X-IronPort-AV: E=Sophos;i="5.91,246,1647327600"; 
   d="scan'208";a="526070248"
Received: from samuelal-mobl.amr.corp.intel.com ([10.212.199.128])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 May 2022 11:20:53 -0700
Date: Mon, 23 May 2022 11:20:46 -0700 (PDT)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Matthieu Baerts <matthieu.baerts@tessares.net>
cc: Paolo Abeni <pabeni@redhat.com>, MPTCP Upstream <mptcp@lists.linux.dev>
Subject: Re: Patch "mptcp: strict local address ID selection" has been added
 to the 5.17-stable tree
In-Reply-To: <a2af92c5-5258-cd5c-33e4-c745281422a5@tessares.net>
Message-ID: <92bc25d-f6eb-e969-d45e-d7c1944b5dd@linux.intel.com>
References: <20220523030625.741995-1-sashal@kernel.org> <4668b747-35fa-d6b0-8390-24c0f8f62a71@tessares.net> <a2af92c5-5258-cd5c-33e4-c745281422a5@tessares.net>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII

On Mon, 23 May 2022, Matthieu Baerts wrote:

> On 23/05/2022 17:33, Matthieu Baerts wrote:
>> Hi Mat, Paolo,
>>
>> (- stable list and netdev maintainers, + mptcp list)
>>
>> On 23/05/2022 05:06, Sasha Levin wrote:
>>> This is a note to let you know that I've just added the patch titled
>>>
>>>     mptcp: strict local address ID selection
>>>
>>> to the 5.17-stable tree which can be found at:
>>>     http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary
>>>
>>> The filename of the patch is:
>>>      mptcp-strict-local-address-id-selection.patch
>>> and it can be found in the queue-5.17 subdirectory.
>>>
>>> If you, or anyone else, feels it should not be added to the stable tree,
>>> please let <stable@vger.kernel.org> know about it.
>>
>>
>> Do we want the patch below to be backported to stable?
>>
>> It think it is slightly changing the behaviour and we might not want it
>> there, no?
>
> (...)
>
>>> diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
>>> index aec767ee047a..e4413b3e50c2 100644
>>> --- a/net/mptcp/protocol.h
>>> +++ b/net/mptcp/protocol.h
>>> @@ -442,7 +442,8 @@ struct mptcp_subflow_context {
>>>  		rx_eof : 1,
>>>  		can_ack : 1,        /* only after processing the remote a key */
>>>  		disposable : 1,	    /* ctx can be free at ulp release time */
>>> -		stale : 1;	    /* unable to snd/rcv data, do not use for xmit */
>>> +		stale : 1,	    /* unable to snd/rcv data, do not use for xmit */
>>> +		local_id_valid : 1; /* local_id is correctly initialized */
>
> I guess the reason this patch has been added to the stable queue is
> because this patch adds 'local_id_valid' element here in
> 'mptcp_subflow_context' structure.
>
> If you look at "mptcp: Do TCP fallback on early DSS checksum failure"
> patch, Mat added 'valid_csum_seen' just after 'local_id_valid'.
>
> If we don't want  "mptcp: strict local address ID selection" to be
> backported, we can probably easily resolve the conflict and send a new
> version adding 'valid_csum_seen' just after 'stale'.
>

Like Paolo, I don't have a strong preference - but since the dependency is 
only because of diff context (not because of any actual functionality) the 
choice seems less clear!

I'm not aware of any negative impacts from "mptcp: strict local address ID 
selection", so I lean in Paolo's direction to let -stable cherry-pick the 
"extra" commit to make the stable process easier.

I'll try running the self tests on 5.15 and 5.17 -stable with these 
commits and see if there is any problem there.

--
Mat Martineau
Intel
