Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53959364
	for <mptcp@lists.linux.dev>; Wed,  5 Oct 2022 00:24:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1664929461; x=1696465461;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=L7WzBgKIfVJvclEg7fDuMREACs/0zTIRBF+mu2xikwU=;
  b=W/jH06kE1ZWp9hD2hXIzu7/VCZh51rRT3qdSQRLtdbRHtMtKV3PrMtEW
   nwOgVVIva8GEmPi9ciWtfBbd6hrahKgj87qs25vZ6eYvw2nbLG/6FzF6Q
   uDAkcJp6SArl+LejK1aN/FvLYyq4n0QUH7Ora/8ETgBLYxlQvGNQKHuO8
   5aew7/eVHu3+fe9jh684038mXzPqQAj9sLr4zHZF8CN2iMCat6usidP4S
   Kl6ZBHVNHGwNPhPLQbwcQJ4awjJnN+W9iufVmQoIknVICPUNAZ9GxBToQ
   +U7In0qlj9J+BqZSHXfdoMjepz893ql0pHWCEyf2pi0ONfYv4VEKSX7xT
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10490"; a="364981365"
X-IronPort-AV: E=Sophos;i="5.95,159,1661842800"; 
   d="scan'208";a="364981365"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Oct 2022 17:24:20 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10490"; a="657347809"
X-IronPort-AV: E=Sophos;i="5.95,159,1661842800"; 
   d="scan'208";a="657347809"
Received: from jessicat-mobl.amr.corp.intel.com ([10.209.12.163])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Oct 2022 17:24:20 -0700
Date: Tue, 4 Oct 2022 17:24:20 -0700 (PDT)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Geliang Tang <geliang.tang@suse.com>
cc: mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-next v4 03/11] mptcp: move burst check out of
 subflow_get_send
In-Reply-To: <d489a13f-2cc0-a46d-0725-f232a2d05af3@linux.intel.com>
Message-ID: <313019cb-d97e-ae20-7ecf-58798edaf23e@linux.intel.com>
References: <cover.1664720538.git.geliang.tang@suse.com> <8beaaa2c182775909a6040433497b1b69ef882eb.1664720538.git.geliang.tang@suse.com> <d489a13f-2cc0-a46d-0725-f232a2d05af3@linux.intel.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Tue, 4 Oct 2022, Mat Martineau wrote:

> On Sun, 2 Oct 2022, Geliang Tang wrote:
>
>> This patch moves the burst check conditions out of the function
>> mptcp_subflow_get_send(), check them in __mptcp_push_pending() and
>> __mptcp_subflow_push_pending() in the inner "for each pending dfrag" loop.
>> 
>> Signed-off-by: Geliang Tang <geliang.tang@suse.com>
>
> This patch changes behavior in a way that would break MPTCP sends if someone 
> was bisecting git commits. I recommend squashing this with the next patch and 
> making sure the code tests ok.
>
>> ---
>> net/mptcp/protocol.c | 27 +++++++++++++++------------
>> 1 file changed, 15 insertions(+), 12 deletions(-)
>> 
>> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
>> index bbc43212a20f..785c52b738cf 100644
>> --- a/net/mptcp/protocol.c
>> +++ b/net/mptcp/protocol.c
>> @@ -1417,14 +1417,6 @@ struct sock *mptcp_subflow_get_send(struct 
>> mptcp_sock *msk)
>> 	u64 linger_time;
>> 	long tout = 0;
>> 
>> -	/* re-use last subflow, if the burst allow that */
>> -	if (msk->last_snd && msk->snd_burst > 0 &&
>> -	    sk_stream_memory_free(msk->last_snd) &&
>> -	    mptcp_subflow_active(mptcp_subflow_ctx(msk->last_snd))) {
>> -		mptcp_set_timeout(sk);
>> -		return msk->last_snd;
>
> Once msk->last_snd is removed here, that member of msk is no longer used and 
> it can be removed from struct mptcp_sock. I think I mentioned this in a 
> previous review - if I'm mistaken please correct me here. Otherwise I will 
> keep making the same suggestion :)
>
>

Also, if msk->last_snd is removed, MPTCP_RESET_SCHEDULER can be removed 
too.

- Mat
>
>
>> -	}
>> -
>> 	/* pick the subflow with the lower wmem/wspace ratio */
>> 	for (i = 0; i < SSK_MODE_MAX; ++i) {
>> 		send_info[i].ssk = NULL;
>> @@ -1477,16 +1469,13 @@ struct sock *mptcp_subflow_get_send(struct 
>> mptcp_sock *msk)
>>
>> 	burst = min_t(int, MPTCP_SEND_BURST_SIZE, mptcp_wnd_end(msk) - 
>> msk->snd_nxt);
>> 	wmem = READ_ONCE(ssk->sk_wmem_queued);
>> -	if (!burst) {
>> -		msk->last_snd = NULL;
>> +	if (!burst)
>> 		return ssk;
>> -	}
>>
>> 	subflow = mptcp_subflow_ctx(ssk);
>> 	subflow->avg_pacing_rate = div_u64((u64)subflow->avg_pacing_rate * 
>> wmem +
>> 					   READ_ONCE(ssk->sk_pacing_rate) * 
>> burst,
>> 					   burst + wmem);
>> -	msk->last_snd = ssk;
>> 	msk->snd_burst = burst;
>> 	return ssk;
>> }
>> @@ -1579,6 +1568,13 @@ void __mptcp_push_pending(struct sock *sk, unsigned 
>> int flags)
>> 			mptcp_update_post_push(msk, dfrag, ret);
>> 		}
>> 		WRITE_ONCE(msk->first_pending, mptcp_send_next(sk));
>> +
>> +		if (msk->snd_burst <= 0 ||
>> +		    !sk_stream_memory_free(ssk) ||
>> +		    !mptcp_subflow_active(mptcp_subflow_ctx(ssk))) {
>> +			goto out;
>> +		}
>> +		mptcp_set_timeout(sk);
>> 	}
>>
>> 	/* at this point we held the socket lock for the last subflow we used 
>> */
>> @@ -1637,6 +1633,13 @@ static void __mptcp_subflow_push_pending(struct sock 
>> *sk, struct sock *ssk,
>> 			mptcp_update_post_push(msk, dfrag, ret);
>> 		}
>> 		WRITE_ONCE(msk->first_pending, mptcp_send_next(sk));
>> +
>> +		if (msk->snd_burst <= 0 ||
>> +		    !sk_stream_memory_free(ssk) ||
>> +		    !mptcp_subflow_active(mptcp_subflow_ctx(ssk))) {
>> +			goto out;
>> +		}
>> +		mptcp_set_timeout(sk);
>> 	}
>> 
>> out:
>> -- 
>> 2.35.3
>> 
>> 
>> 
>
> --
> Mat Martineau
> Intel
>
>

--
Mat Martineau
Intel
