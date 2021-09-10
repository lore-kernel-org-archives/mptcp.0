Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07E603FE2
	for <mptcp@lists.linux.dev>; Fri, 10 Sep 2021 00:00:12 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6200,9189,10102"; a="284648939"
X-IronPort-AV: E=Sophos;i="5.85,281,1624345200"; 
   d="scan'208";a="284648939"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2021 17:00:09 -0700
X-IronPort-AV: E=Sophos;i="5.85,281,1624345200"; 
   d="scan'208";a="694393354"
Received: from jabusaid-mobl.amr.corp.intel.com ([10.255.231.212])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2021 17:00:06 -0700
Date: Thu, 9 Sep 2021 17:00:06 -0700 (PDT)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Paolo Abeni <pabeni@redhat.com>
cc: Geliang Tang <geliangtang@gmail.com>, mptcp@lists.linux.dev, 
    Geliang Tang <geliangtang@xiaomi.com>
Subject: Re: [PATCH mptcp-next v2 1/9] mptcp: add noncontiguous flag
In-Reply-To: <7147f377124eaa4445aa11e8f8f4efbd72d69261.camel@redhat.com>
Message-ID: <4e24a896-b1bf-c6ee-2db9-4d1d572c99cd@linux.intel.com>
References: <cover.1631188109.git.geliangtang@xiaomi.com>  <138e3913108d313b11a261e6c9e3db2cc788183f.1631188109.git.geliangtang@xiaomi.com> <7147f377124eaa4445aa11e8f8f4efbd72d69261.camel@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Thu, 9 Sep 2021, Paolo Abeni wrote:

> On Thu, 2021-09-09 at 19:51 +0800, Geliang Tang wrote:
>> From: Geliang Tang <geliangtang@xiaomi.com>
>>
>> This patch added a "noncontiguous" flag in the msk to track whether the
>> data is contiguous on a subflow. When retransmission happens, we could
>> set this flag, and once all retransmissions are DATA_ACK'd that flag
>> could be cleared.
>>
>> When a bad checksum is detected and a single contiguous subflow is in
>> use, don't send RST + MP_FAIL, send data_ack + MP_FAIL instead.
>>
>> Signed-off-by: Geliang Tang <geliangtang@xiaomi.com>
>> ---
>>  net/mptcp/protocol.c |  7 +++++++
>>  net/mptcp/protocol.h |  2 ++
>>  net/mptcp/subflow.c  | 12 ++++++------
>>  3 files changed, 15 insertions(+), 6 deletions(-)
>>
>> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
>> index bb8a2a231479..81ea03b9fff6 100644
>> --- a/net/mptcp/protocol.c
>> +++ b/net/mptcp/protocol.c
>> @@ -1095,6 +1095,9 @@ static void __mptcp_clean_una(struct sock *sk)
>>
>>  		dfrag_uncharge(sk, delta);
>>  		cleaned = true;
>> +
>> +		if (dfrag->resend_count == 0)
>> +			WRITE_ONCE(msk->noncontiguous, false);
>>  	}
>>
>>  	/* all retransmitted data acked, recovery completed */
>> @@ -1171,6 +1174,7 @@ mptcp_carve_data_frag(const struct mptcp_sock *msk, struct page_frag *pfrag,
>>  	dfrag->overhead = offset - orig_offset + sizeof(struct mptcp_data_frag);
>>  	dfrag->offset = offset + sizeof(struct mptcp_data_frag);
>>  	dfrag->already_sent = 0;
>> +	dfrag->resend_count = 0;
>>  	dfrag->page = pfrag->page;
>>
>>  	return dfrag;
>> @@ -2454,6 +2458,8 @@ static void __mptcp_retrans(struct sock *sk)
>>  		dfrag->already_sent = max(dfrag->already_sent, info.sent);
>>  		tcp_push(ssk, 0, info.mss_now, tcp_sk(ssk)->nonagle,
>>  			 info.size_goal);
>> +		dfrag->resend_count++;
>> +		WRITE_ONCE(msk->noncontiguous, true);
>>  	}
>>
>>  	release_sock(ssk);
>> @@ -2872,6 +2878,7 @@ struct sock *mptcp_sk_clone(const struct sock *sk,
>>  	WRITE_ONCE(msk->fully_established, false);
>>  	if (mp_opt->suboptions & OPTION_MPTCP_CSUMREQD)
>>  		WRITE_ONCE(msk->csum_enabled, true);
>> +	WRITE_ONCE(msk->noncontiguous, false);
>>
>>  	msk->write_seq = subflow_req->idsn + 1;
>>  	msk->snd_nxt = msk->write_seq;
>> diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
>> index d3e6fd1615f1..011f84ae1593 100644
>> --- a/net/mptcp/protocol.h
>> +++ b/net/mptcp/protocol.h
>> @@ -213,6 +213,7 @@ struct mptcp_data_frag {
>>  	u16 offset;
>>  	u16 overhead;
>>  	u16 already_sent;
>> +	u16 resend_count;
>>  	struct page *page;
>>  };
>
> Ouch, the above increases mptcp_data_frag size by 8 bytes, due to
> holes.
>

What about rearranging the struct to eliminate the holes? (Full 
disclosure: I asked Geliang to add this, but am open to other solutions)

I was also thinking it could be useful to have this information around for 
retransmission metrics, but that doesn't seem too important.

> Is this necessary? I think the packet scheduler never reinject with a
> single subflow. It used to do that, but it should not do anymore.
>

There may be a single subflow now, but multiple subflows (with 
unacked reinjections) a very short time ago.

> Even if the scheduler re-inject with a single subflow, can we instead
> keep track of the last retrans sequence number - in __mptcp_retrans().
>
> msk stream is 'continuous' if and only if 'before64(last_retrnas_seq,
> msk->snd_una)'
>

If last_retrans_seq is checked only when msk->noncontiguous is true, I 
think that works out. Otherwise the last_retrans_seq is stale/invalid if 
retransmission never happened, or any retransmissions have been fully 
acked.


--
Mat Martineau
Intel
