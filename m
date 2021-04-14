Received: from chinatelecom.cn (prt-mail.chinatelecom.cn [42.123.76.219])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 356C271
	for <mptcp@lists.linux.dev>; Wed, 14 Apr 2021 02:48:03 +0000 (UTC)
HMM_SOURCE_IP:172.18.0.48:58390.348860279
HMM_ATTACHE_NUM:0000
HMM_SOURCE_TYPE:SMTP
Received: from clientip-36.111.140.26?logid-61307c69e6bb4321a8621a4fe2026dce (unknown [172.18.0.48])
	by chinatelecom.cn (HERMES) with SMTP id 2572A2800B1;
	Wed, 14 Apr 2021 10:39:59 +0800 (CST)
X-189-SAVE-TO-SEND: liyonglong@chinatelecom.cn
Received: from  ([172.18.0.48])
	by app0024 with ESMTP id 61307c69e6bb4321a8621a4fe2026dce for fw@strlen.de;
	Wed Apr 14 10:40:04 2021
X-Transaction-ID: 61307c69e6bb4321a8621a4fe2026dce
X-filter-score:  filter<0>
X-Real-From: liyonglong@chinatelecom.cn
X-Receive-IP: 172.18.0.48
X-MEDUSA-Status: 0
Sender: liyonglong@chinatelecom.cn
Subject: Re: [PATCH] mptcp: add MSG_PEEK support
To: Paolo Abeni <pabeni@redhat.com>, mptcp@lists.linux.dev, mptcp@lists.01.org
Cc: mathew.j.martineau@linux.intel.com, matthieu.baerts@tessares.net,
 fw@strlen.de
References: <1618298656-123756-1-git-send-email-liyonglong@chinatelecom.cn>
 <1d72e6b0f7e0838f388725b9504e0b0fe2e19a93.camel@redhat.com>
From: Yonglong Li <liyonglong@chinatelecom.cn>
Message-ID: <b164a261-2d46-b6d5-776d-1b6e967e8322@chinatelecom.cn>
Date: Wed, 14 Apr 2021 10:39:52 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <1d72e6b0f7e0838f388725b9504e0b0fe2e19a93.camel@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit

Hi Paolo,

Thanks for your review.

embarrassedly... I will prepare a v2 patch as your suggestion. And add some
self-tests for the new feature.

On 2021/4/13 17:29, Paolo Abeni wrote:
> Hello,
> 
> On Tue, 2021-04-13 at 15:24 +0800, Yonglong Li wrote:
>> This patch adds support for MSG_PEEK flag. Packets are not removed
>> from the receive_queue if MSG_PEEK set in recv() system call.
>>
>> Signed-off-by: Yonglong Li <liyonglong@chinatelecom.cn>
>> ---
>>  net/mptcp/protocol.c | 28 ++++++++++++++++++----------
>>  1 file changed, 18 insertions(+), 10 deletions(-)
>>
>> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
>> index 2d895c3..65448e1 100644
>> --- a/net/mptcp/protocol.c
>> +++ b/net/mptcp/protocol.c
>> @@ -1710,12 +1710,13 @@ static void mptcp_wait_data(struct sock *sk, long *timeo)
>>  
>>  static int __mptcp_recvmsg_mskq(struct mptcp_sock *msk,
>>  				struct msghdr *msg,
>> -				size_t len)
>> +				size_t len, int flags)
>>  {
>>  	struct sk_buff *skb;
>>  	int copied = 0;
>>  
>> -	while ((skb = skb_peek(&msk->receive_queue)) != NULL) {
>> +	skb = skb_peek(&msk->receive_queue);
>> +	while (!(skb == NULL || skb == (struct sk_buff *)(&msk->receive_queue))) {
> 
> I think you can replace the above construct with skb_queue_walk_safe().
> Will be cleaner and will avoid the skb_peek()/skb = skb->next later.
Your are right, here replace with skb_queue_walk_safe() will be cleaner.

> 
>>  		u32 offset = MPTCP_SKB_CB(skb)->offset;
>>  		u32 data_len = skb->len - offset;
>>  		u32 count = min_t(size_t, len - copied, data_len);
>> @@ -1731,15 +1732,21 @@ static int __mptcp_recvmsg_mskq(struct mptcp_sock *msk,
>>  		copied += count;
>>  
>>  		if (count < data_len) {
>> -			MPTCP_SKB_CB(skb)->offset += count;
>> +			if (!(flags & MSG_PEEK))
>> +				MPTCP_SKB_CB(skb)->offset += count;
>>  			break;
>>  		}
>>  
>> -		/* we will bulk release the skb memory later */
>> -		skb->destructor = NULL;
>> -		msk->rmem_released += skb->truesize;
>> -		__skb_unlink(skb, &msk->receive_queue);
>> -		__kfree_skb(skb);
>> +		if (!(flags & MSG_PEEK))
>> +			/* we will bulk release the skb memory later */
> 
> It looks like there is a missing bracket her>
>> +			skb->destructor = NULL;
>> +			msk->rmem_released += skb->truesize;
>> +			__skb_unlink(skb, &msk->receive_queue);
>> +			__kfree_skb(skb);
>> +			skb = skb_peek(&msk->receive_queue);
>> +		}else{
> 
> Uhm... this causes a compiler error due to missing paired opening
> bracket.
> 
> Additional minor hint, a space is needed before and after the 'else'
> 
>> +		    skb = skb->next;
>> +		}
>>  
>>  		if (copied >= len)
>>  			break;
>> @@ -1933,7 +1940,7 @@ static int mptcp_recvmsg(struct sock *sk, struct msghdr *msg, size_t len,
>>  	while (copied < len) {
>>  		int bytes_read;
>>  
>> -		bytes_read = __mptcp_recvmsg_mskq(msk, msg, len - copied);
>> +		bytes_read = __mptcp_recvmsg_mskq(msk, msg, len - copied, flags);
>>  		if (unlikely(bytes_read < 0)) {
>>  			if (!copied)
>>  				copied = bytes_read;
>> @@ -2017,7 +2024,8 @@ static int mptcp_recvmsg(struct sock *sk, struct msghdr *msg, size_t len,
>>  	pr_debug("msk=%p data_ready=%d rx queue empty=%d copied=%d",
>>  		 msk, test_bit(MPTCP_DATA_READY, &msk->flags),
>>  		 skb_queue_empty_lockless(&sk->sk_receive_queue), copied);
>> -	mptcp_rcv_space_adjust(msk, copied);
>> +	if (!(flags & MSG_PEEK))
>> +		mptcp_rcv_space_adjust(msk, copied);
>>  
>>  	release_sock(sk);
>>  	return copied;
> 
> This lacks some other changes in mptcp_recvmsg().
> Currently mptcp_recvmsg() fails with -EOPNOTSUPP if an unsupported flag
> is provided as an argument, and MSG_PEEK is not yet in the supported
> list.
> 
> Side note: we need to change the above: mptcp_recvmsg() should silently
> ignore unsupported flags.
> 
> Finally you should add some self-tests for the new feature (in a
> separate patch). You could extend the 'mptcp_connect.c' program and add
> some new script in the 'mptcp' self-test directory. That will allow you
> to test your code, as needed.
> 
> If you are interested in larger contribution to the MPTCP protocol, I
> suggest to try to join the public mtg we have every week:
> 
> https://github.com/multipath-tcp/mptcp_net-next/wiki/Meetings
> 
> The current timeslot is likely unfortunate, but we could change that.
> 
> Cheers,
> 
> Paolo
> 
> 
> 
