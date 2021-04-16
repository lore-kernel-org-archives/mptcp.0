Received: from chinatelecom.cn (prt-mail.chinatelecom.cn [42.123.76.228])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EB5D29CA
	for <mptcp@lists.linux.dev>; Fri, 16 Apr 2021 01:30:45 +0000 (UTC)
HMM_SOURCE_IP:172.18.0.218:37910.963530093
HMM_ATTACHE_NUM:0000
HMM_SOURCE_TYPE:SMTP
Received: from clientip-36.111.140.26?logid-3d141e9e7864463f94918dc19fe522fb (unknown [172.18.0.218])
	by chinatelecom.cn (HERMES) with SMTP id 95ECD2800FE;
	Fri, 16 Apr 2021 09:30:38 +0800 (CST)
X-189-SAVE-TO-SEND: liyonglong@chinatelecom.cn
Received: from  ([172.18.0.218])
	by app0025 with ESMTP id 3d141e9e7864463f94918dc19fe522fb for wujianguo@chinatelecom.cn;
	Fri Apr 16 09:30:38 2021
X-Transaction-ID: 3d141e9e7864463f94918dc19fe522fb
X-filter-score:  filter<0>
X-Real-From: liyonglong@chinatelecom.cn
X-Receive-IP: 172.18.0.218
X-MEDUSA-Status: 0
Sender: liyonglong@chinatelecom.cn
Subject: Re: [PATCH v2 1/2] mptcp: add MSG_PEEK support
To: Paolo Abeni <pabeni@redhat.com>, mptcp@lists.linux.dev
Cc: mathew.j.martineau@linux.intel.com, matthieu.baerts@tessares.net,
 fw@strlen.de, wujianguo@chinatelecom.cn
References: <1618456752-139032-1-git-send-email-liyonglong@chinatelecom.cn>
 <cb2f684fa9dc1db6d8ddab1e091249cb08798758.camel@redhat.com>
From: Yonglong Li <liyonglong@chinatelecom.cn>
Message-ID: <dce8edda-f8d6-c7d3-3325-e645883471b8@chinatelecom.cn>
Date: Fri, 16 Apr 2021 09:30:30 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <cb2f684fa9dc1db6d8ddab1e091249cb08798758.camel@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit



On 2021/4/15 19:54, Paolo Abeni wrote:
> On Thu, 2021-04-15 at 11:19 +0800, Yonglong Li wrote:
>> This patch adds support for MSG_PEEK flag. Packets are not removed
>> from the receive_queue if MSG_PEEK set in recv() system call.
>>
>> Signed-off-by: Yonglong Li <liyonglong@chinatelecom.cn>
>> ---
>>  net/mptcp/protocol.c | 28 ++++++++++++++++------------
>>  1 file changed, 16 insertions(+), 12 deletions(-)
>>
>> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
>> index 0437fe4..521e67b 100644
>> --- a/net/mptcp/protocol.c
>> +++ b/net/mptcp/protocol.c
>> @@ -1739,12 +1739,12 @@ static void mptcp_wait_data(struct sock *sk, long *timeo)
>>  
>>  static int __mptcp_recvmsg_mskq(struct mptcp_sock *msk,
>>  				struct msghdr *msg,
>> -				size_t len)
>> +				size_t len, int flags)
>>  {
>> -	struct sk_buff *skb;
>> +	struct sk_buff *skb, *tmp;
>>  	int copied = 0;
>>  
>> -	while ((skb = skb_peek(&msk->receive_queue)) != NULL) {
>> +	skb_queue_walk_safe(&msk->receive_queue, skb, tmp) {
>>  		u32 offset = MPTCP_SKB_CB(skb)->offset;
>>  		u32 data_len = skb->len - offset;
>>  		u32 count = min_t(size_t, len - copied, data_len);
>> @@ -1760,15 +1760,18 @@ static int __mptcp_recvmsg_mskq(struct mptcp_sock *msk,
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
>> +		if (!(flags & MSG_PEEK)) {
>> +			/* we will bulk release the skb memory later */
>> +			skb->destructor = NULL;
>> +			msk->rmem_released += skb->truesize;
>> +			__skb_unlink(skb, &msk->receive_queue);
>> +			__kfree_skb(skb);
>> +		}
>>  
>>  		if (copied >= len)
>>  			break;
>> @@ -1945,7 +1948,7 @@ static int mptcp_recvmsg(struct sock *sk, struct msghdr *msg, size_t len,
>>  	int target;
>>  	long timeo;
>>  
>> -	if (msg->msg_flags & ~(MSG_WAITALL | MSG_DONTWAIT))
>> +	if (flags & ~(MSG_PEEK | MSG_WAITALL | MSG_DONTWAIT))
>>  		return -EOPNOTSUPP;
> 
> Ooops... the existing code (prior to your patch) is pure nonsense here.
> 
> Is probably better just drop this check entirely.
> 
ok, I will drop this check entirely in next patch.
