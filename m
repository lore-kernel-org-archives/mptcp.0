Received: from m12-11.163.com (m12-11.163.com [220.181.12.11])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7865671
	for <mptcp@lists.linux.dev>; Mon, 21 Jun 2021 06:35:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Subject:From:Message-ID:Date:MIME-Version; bh=pEg04
	RRpTKl0qdosLprjTx36awhVHbrTrOM7IAILxNY=; b=Q9jutITJQUtETBhW4igCo
	E3SejYfH5mqyho7vn5CHjsGLEV9FgXxzuCSULK/XwfpY/VsDXV27q8RfOpTqss3B
	lBbjQptdreX4vtpq+w7KuKTJwDILcZzKOyeMLtFuUI9v47bTDBKwsHyRuJcG2zcK
	csAMqytGyoW/D+ZxUFAwoM=
Received: from [10.8.1.202] (unknown [36.111.140.26])
	by smtp7 (Coremail) with SMTP id C8CowAB3bo4tM9BgOGmOjA--.2341S2;
	Mon, 21 Jun 2021 14:35:28 +0800 (CST)
Subject: Re: [PATCH v5 4/4] mptcp: avoid processing packet if a subflow reset
To: Mat Martineau <mathew.j.martineau@linux.intel.com>
Cc: mptcp@lists.linux.dev, pabeni@redhat.com, fw@strlen.de
References: <1623840570-42004-1-git-send-email-wujianguo106@163.com>
 <1623840570-42004-5-git-send-email-wujianguo106@163.com>
 <45dcfe4c-1918-2d78-accf-141bb4af2c5b@linux.intel.com>
From: Jianguo Wu <wujianguo106@163.com>
Message-ID: <b568316c-d0f9-9315-692d-ea83b2d49b85@163.com>
Date: Mon, 21 Jun 2021 14:35:25 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <45dcfe4c-1918-2d78-accf-141bb4af2c5b@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:C8CowAB3bo4tM9BgOGmOjA--.2341S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7tr1ktr4xZw4rurW8Ww4fGrg_yoW5Jr4Upr
	92g3W3GrWkXryfJ3yIyr4rXr1S9rWFyry3J3yvya4Yyrn8Grn2k34rtr429F47GFZY9a1U
	Z3W2vasrXw12qaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jHJP_UUUUU=
X-Originating-IP: [36.111.140.26]
X-CM-SenderInfo: 5zxmxt5qjx0iiqw6il2tof0z/xtbBiBC4kFaD-XvYTgAAs1

Hi Mat,

On 2021/6/19 8:19, Mat Martineau wrote:
> On Wed, 16 Jun 2021, wujianguo106@163.com wrote:
> 
>> From: Jianguo Wu <wujianguo@chinatelecom.cn>
>>
>> If check_fully_established() causes a subflow reset, it should not
>> continue to process the packet in tcp_data_queue().
>>
>> setting:
>>     TCP_SKB_CB(skb)->end_seq = TCP_SKB_CB(skb)->seq;
>>
>> so that the following check will drop the pkt in
>> tcp_data_queue():
>>  if (TCP_SKB_CB(skb)->seq == TCP_SKB_CB(skb)->end_seq) {
>>     __kfree_skb(skb);
>>     return;
>>  }
>>
>> Fixes: d582484726c4 ("mptcp: fix fallback for MP_JOIN subflows")
>> Signed-off-by: Jianguo Wu <wujianguo@chinatelecom.cn>
>> ---
>> net/mptcp/options.c | 6 ++++++
>> 1 file changed, 6 insertions(+)
>>
>> diff --git a/net/mptcp/options.c b/net/mptcp/options.c
>> index 1aec01686c1a..be435c5421cd 100644
>> --- a/net/mptcp/options.c
>> +++ b/net/mptcp/options.c
>> @@ -926,6 +926,12 @@ static bool check_fully_established(struct mptcp_sock *msk, struct sock *ssk,
>>     return true;
>>
>> reset:
>> +    /* If a subflow is reset, the packet should not continue to be
>> +     * processed in tcp_data_queue(), so setting: end_seq = seq,
>> +     * then tcp_data_queue() will drop the packet.
>> +     */
>> +    TCP_SKB_CB(skb)->end_seq = TCP_SKB_CB(skb)->seq;
>> +
> 
> This does have the desired effect when mptcp_incoming_options() is called from tcp_data_queue(), but mptcp_incoming_options() is also called from tcp_reset() and tcp_rcv_state_process(). The other callers appear to tolerate the sequence number modification.
> 
> I think it would be clearer to either add a return value or output parameter to mptcp_incoming_options() to explicitly tell the caller that a reset has been sent and tcp_done() called. Then it would be clearer in tcp_data_queue() that the packet is being discarded due to mptcp header content.
> 

If a reset has been sent and tcp_done() called in check_fully_established(), the sk_state will be TCP_CLOSE, how about just do (sk_state == TCP_CLOSE) check in tcp_data_queue() as it did
in the V1 of this patch?

> (It also looks like it unexpected behavior may be possible if we get a strange TCP_RST + MP_JOIN packet when not fully established, but that's unrelated to this patch. Maybe I'll try to create a packetdrill test to see what happens)
> 
>>     mptcp_subflow_reset(ssk);
>>     return false;
>> }
>> -- 
>> 1.8.3.1
> 
> -- 
> Mat Martineau
> Intel

