Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4BE4173
	for <mptcp@lists.linux.dev>; Wed, 23 Jun 2021 00:00:28 +0000 (UTC)
IronPort-SDR: DQ5mYHDcY0QelM7cLisVSzwVSwUMiGE548t8uGpM+JzcLr9zxnsbhh/ZdnkMZWMShQceDBGi7v
 WqNZwhrsJiMQ==
X-IronPort-AV: E=McAfee;i="6200,9189,10023"; a="207104332"
X-IronPort-AV: E=Sophos;i="5.83,292,1616482800"; 
   d="scan'208";a="207104332"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2021 17:00:27 -0700
IronPort-SDR: 9OL5kdTFe5HA4YuAF6z0DdAUsD/P9mqfdNvAa3ojLAL3ZeS3gLlDuvs0W94zL5/mCp25IwJ9ne
 Au6hWbcuuHxw==
X-IronPort-AV: E=Sophos;i="5.83,292,1616482800"; 
   d="scan'208";a="487096171"
Received: from mrsastry-mobl1.amr.corp.intel.com ([10.212.137.16])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2021 17:00:27 -0700
Date: Tue, 22 Jun 2021 17:00:27 -0700 (PDT)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Jianguo Wu <wujianguo106@163.com>
cc: mptcp@lists.linux.dev, pabeni@redhat.com, fw@strlen.de
Subject: Re: [PATCH v5 4/4] mptcp: avoid processing packet if a subflow
 reset
In-Reply-To: <b568316c-d0f9-9315-692d-ea83b2d49b85@163.com>
Message-ID: <2024b917-84de-4dea-2244-5dce7a7f2495@linux.intel.com>
References: <1623840570-42004-1-git-send-email-wujianguo106@163.com> <1623840570-42004-5-git-send-email-wujianguo106@163.com> <45dcfe4c-1918-2d78-accf-141bb4af2c5b@linux.intel.com> <b568316c-d0f9-9315-692d-ea83b2d49b85@163.com>
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="0-508769315-1624406427=:21759"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--0-508769315-1624406427=:21759
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8BIT

On Mon, 21 Jun 2021, Jianguo Wu wrote:

> Hi Mat,
>
> On 2021/6/19 8:19, Mat Martineau wrote:
>> On Wed, 16 Jun 2021, wujianguo106@163.com wrote:
>>
>>> From: Jianguo Wu <wujianguo@chinatelecom.cn>
>>>
>>> If check_fully_established() causes a subflow reset, it should not
>>> continue to process the packet in tcp_data_queue().
>>>
>>> setting:
>>>     TCP_SKB_CB(skb)->end_seq = TCP_SKB_CB(skb)->seq;
>>>
>>> so that the following check will drop the pkt in
>>> tcp_data_queue():
>>>  if (TCP_SKB_CB(skb)->seq == TCP_SKB_CB(skb)->end_seq) {
>>>     __kfree_skb(skb);
>>>     return;
>>>  }
>>>
>>> Fixes: d582484726c4 ("mptcp: fix fallback for MP_JOIN subflows")
>>> Signed-off-by: Jianguo Wu <wujianguo@chinatelecom.cn>
>>> ---
>>> net/mptcp/options.c | 6 ++++++
>>> 1 file changed, 6 insertions(+)
>>>
>>> diff --git a/net/mptcp/options.c b/net/mptcp/options.c
>>> index 1aec01686c1a..be435c5421cd 100644
>>> --- a/net/mptcp/options.c
>>> +++ b/net/mptcp/options.c
>>> @@ -926,6 +926,12 @@ static bool check_fully_established(struct mptcp_sock *msk, struct sock *ssk,
>>>     return true;
>>>
>>> reset:
>>> +    /* If a subflow is reset, the packet should not continue to be
>>> +     * processed in tcp_data_queue(), so setting: end_seq = seq,
>>> +     * then tcp_data_queue() will drop the packet.
>>> +     */
>>> +    TCP_SKB_CB(skb)->end_seq = TCP_SKB_CB(skb)->seq;
>>> +
>>
>> This does have the desired effect when mptcp_incoming_options() is 
>> called from tcp_data_queue(), but mptcp_incoming_options() is also 
>> called from tcp_reset() and tcp_rcv_state_process(). The other callers 
>> appear to tolerate the sequence number modification.
>>
>> I think it would be clearer to either add a return value or output 
>> parameter to mptcp_incoming_options() to explicitly tell the caller 
>> that a reset has been sent and tcp_done() called. Then it would be 
>> clearer in tcp_data_queue() that the packet is being discarded due to 
>> mptcp header content.
>>
>
> If a reset has been sent and tcp_done() called in 
> check_fully_established(), the sk_state will be TCP_CLOSE, how about 
> just do (sk_state == TCP_CLOSE) check in tcp_data_queue() as it did in 
> the V1 of this patch?

Oh, I see now that Paolo suggested the the end_seq assignment in order to 
only modify MPTCP code.

I still think it's better to make it clear that we're discarding a packet 
due to the mptcp headers - using the existing sequence check (intended to 
detect acks) in tcp_data_queue() seems sneaky to me.

Something like

if (sk_is_mptcp(sk) && !mptcp_incoming_options(sk, skb)) {
 	__kfree_skb(skb);
 	return;
}

seems both compact and clear. Does that seem ok Paolo?

The optimizer would probably share instructions with the following 
"end_seq == seq" condition for the kfree+return path anyway.


>
>> (It also looks like it unexpected behavior may be possible if we get a 
>> strange TCP_RST + MP_JOIN packet when not fully established, but that's 
>> unrelated to this patch. Maybe I'll try to create a packetdrill test to 
>> see what happens)
>>
>>>     mptcp_subflow_reset(ssk);
>>>     return false;
>>> }

--
Mat Martineau
Intel
--0-508769315-1624406427=:21759--
