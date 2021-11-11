Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54FDA2C81
	for <mptcp@lists.linux.dev>; Thu, 11 Nov 2021 00:05:15 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6200,9189,10164"; a="319018695"
X-IronPort-AV: E=Sophos;i="5.87,225,1631602800"; 
   d="scan'208";a="319018695"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2021 16:05:12 -0800
X-IronPort-AV: E=Sophos;i="5.87,225,1631602800"; 
   d="scan'208";a="732943818"
Received: from pkkelley-mobl.amr.corp.intel.com ([10.209.109.110])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2021 16:05:12 -0800
Date: Wed, 10 Nov 2021 16:05:11 -0800 (PST)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Florian Westphal <fw@strlen.de>
cc: mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-next 1/3] mptcp: add TCP_INQ cmsg support
In-Reply-To: <20211110230913.GI16363@breakpoint.cc>
Message-ID: <fe895be7-ffe3-57bf-1e18-9de2d6924078@linux.intel.com>
References: <20211108105711.16200-1-fw@strlen.de> <20211108105711.16200-2-fw@strlen.de> <add0921a-4ce2-a3d4-d4d-442d4e88365f@linux.intel.com> <20211110101732.GE16363@breakpoint.cc> <9ac5fe56-ff93-613f-13a-8017b938ceb6@linux.intel.com>
 <ed6bb478-c85f-34e2-70c1-424dccb082a7@linux.intel.com> <20211110230913.GI16363@breakpoint.cc>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII

On Thu, 11 Nov 2021, Florian Westphal wrote:

> Mat Martineau <mathew.j.martineau@linux.intel.com> wrote:
>>> Still trying here, modified the test to show the inq value in case that
>>> helps debug.
>>
>> Well, that was quick:
>>
>> "tcp_inq=7ffffffe is larger than one mbyte"
>>
>> At least it's the expected INT_MAX - 1 value... I'll instrument the kernel
>> some more and try again.
>
> Great, thanks.  I'll look at this tomorrow as well.
>
> I will keep this test case as-is, but will add an extra test with
> out-of-band channel that will inform receiver about exact number of sent
> bytes so we can check reported inq hint vs. the (known) unread data value.
>

More data:

    mptcp_connect-3837    [003] .....   229.043932: mptcp_inq_hint: msk->ack_seq=14236111453981801913 cb->map_seq=14236111453981665217 cb->offset=59862, msk->sk_receive_queue_tail=0000000000000000 hint_val_raw=76834
    mptcp_connect-3837    [003] .....   229.044556: mptcp_inq_hint: msk->ack_seq=14236111453981801913 cb->map_seq=14236111453981665217 cb->offset=68054, msk->sk_receive_queue_tail=0000000000000000 hint_val_raw=68642
    mptcp_connect-3837    [003] .....   229.045875: mptcp_inq_hint: msk->ack_seq=14236111453981806393 cb->map_seq=14236111453981723649 cb->offset=17814, msk->sk_receive_queue_tail=000000007850e9d3 hint_val_raw=64930
    mptcp_connect-3837    [003] .....   229.046829: mptcp_inq_hint: msk->ack_seq=14236111453981806393 cb->map_seq=14236111453981723649 cb->offset=26006, msk->sk_receive_queue_tail=000000007850e9d3 hint_val_raw=56738
    mptcp_connect-3837    [003] .....   229.047619: mptcp_inq_hint: msk->ack_seq=14236111453981806393 cb->map_seq=14236111453981723649 cb->offset=34198, msk->sk_receive_queue_tail=000000007850e9d3 hint_val_raw=48546
    mptcp_connect-3837    [003] .....   229.048245: mptcp_inq_hint: msk->ack_seq=14236111453981806393 cb->map_seq=14236111453981723649 cb->offset=42390, msk->sk_receive_queue_tail=000000007850e9d3 hint_val_raw=40354
    mptcp_connect-3837    [003] .....   229.048761: mptcp_inq_hint: msk->ack_seq=14236111453981806393 cb->map_seq=14236111453981769521 cb->offset=16368, msk->sk_receive_queue_tail=000000007850e9d3 hint_val_raw=20504
    mptcp_connect-3837    [003] .....   229.049461: mptcp_inq_hint: msk->ack_seq=14236111453981806393 cb->map_seq=14236111453981769521 cb->offset=24560, msk->sk_receive_queue_tail=000000007850e9d3 hint_val_raw=12312
    mptcp_connect-3837    [003] .....   229.050651: mptcp_inq_hint: msk->ack_seq=14236111453981806393 cb->map_seq=14236111453981769521 cb->offset=32752, msk->sk_receive_queue_tail=000000007850e9d3 hint_val_raw=4120
    mptcp_connect-3837    [003] .....   229.051074: mptcp_inq_hint: msk->ack_seq=14236111453981806393 cb->map_seq=14236111453981769521 cb->offset=40944, msk->sk_receive_queue_tail=000000007850e9d3 hint_val_raw=18446744073709547544

So, it does seem to be related to acked data in msk->sk_receive_queue


Mat
