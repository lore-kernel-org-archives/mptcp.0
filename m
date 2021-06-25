Received: from m12-12.163.com (m12-12.163.com [220.181.12.12])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D386177
	for <mptcp@lists.linux.dev>; Fri, 25 Jun 2021 01:07:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Subject:From:Message-ID:Date:MIME-Version; bh=HTSrR
	OXg4IC3kw4XJ3m7azXcL6E16kEOgPgBgTe2DDo=; b=RE7kHhAviBFxP/kDNGntR
	LXHvn2kzHXhI8IQdd8ClTkdqheILecAcX9+XrCinceaOZEqVB3AdmY5VclI/kW9b
	4UGxOu5q/yzk+pJXFgM9Olb11qYXbWF4e2Fq41wc4AKaM4Q4tkNcYcCLRC19+ytQ
	MzwQ4bTuNHCV+5Zybga2OE=
Received: from [10.8.0.206] (unknown [36.111.140.26])
	by smtp8 (Coremail) with SMTP id DMCowAA3MPyeKNVgPqCjLg--.55128S2;
	Fri, 25 Jun 2021 08:51:44 +0800 (CST)
Subject: Re: [PATCH v5 4/4] mptcp: avoid processing packet if a subflow reset
To: Paolo Abeni <pabeni@redhat.com>,
 Mat Martineau <mathew.j.martineau@linux.intel.com>
Cc: mptcp@lists.linux.dev, fw@strlen.de
References: <1623840570-42004-1-git-send-email-wujianguo106@163.com>
 <1623840570-42004-5-git-send-email-wujianguo106@163.com>
 <45dcfe4c-1918-2d78-accf-141bb4af2c5b@linux.intel.com>
 <b568316c-d0f9-9315-692d-ea83b2d49b85@163.com>
 <2024b917-84de-4dea-2244-5dce7a7f2495@linux.intel.com>
 <1ac0561c290bf87aa54277bc6b458a859b8ff080.camel@redhat.com>
 <f7e8a4f2-1725-72c3-b54e-5f6dc1af0a24@163.com>
 <7c26d28d7249536615bf945b09d683f81eb06be0.camel@redhat.com>
From: Jianguo Wu <wujianguo106@163.com>
Message-ID: <e5de2c05-ba90-1045-183f-0beb813059fb@163.com>
Date: Fri, 25 Jun 2021 08:51:42 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <7c26d28d7249536615bf945b09d683f81eb06be0.camel@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:DMCowAA3MPyeKNVgPqCjLg--.55128S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxXF4fCFykGFWDWFyxJFyrZwb_yoWrCF1fpr
	yDG3W7Jr4kXry8Jr42yF4rXr1Svry5tr4UX34Dta4Yyrn8tr1xtryUtr129F4xGrs3Ca1U
	Zw47Xa9xXw13ZaUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jAsqAUUUUU=
X-Originating-IP: [36.111.140.26]
X-CM-SenderInfo: 5zxmxt5qjx0iiqw6il2tof0z/1tbiUQC8kGDEMvFvVwAAsi



On 2021/6/24 18:02, Paolo Abeni wrote:
> On Thu, 2021-06-24 at 09:57 +0800, Jianguo Wu wrote:
>>
>> On 2021/6/23 17:48, Paolo Abeni wrote:
>>> On Tue, 2021-06-22 at 17:00 -0700, Mat Martineau wrote:
>>>> On Mon, 21 Jun 2021, Jianguo Wu wrote:
>>>>
>>>>> Hi Mat,
>>>>>
>>>>> On 2021/6/19 8:19, Mat Martineau wrote:
>>>>>> On Wed, 16 Jun 2021, wujianguo106@163.com wrote:
>>>>>>
>>>>>>> From: Jianguo Wu <wujianguo@chinatelecom.cn>
>>>>>>>
>>>>>>> If check_fully_established() causes a subflow reset, it should not
>>>>>>> continue to process the packet in tcp_data_queue().
>>>>>>>
>>>>>>> setting:
>>>>>>>     TCP_SKB_CB(skb)->end_seq = TCP_SKB_CB(skb)->seq;
>>>>>>>
>>>>>>> so that the following check will drop the pkt in
>>>>>>> tcp_data_queue():
>>>>>>>  if (TCP_SKB_CB(skb)->seq == TCP_SKB_CB(skb)->end_seq) {
>>>>>>>     __kfree_skb(skb);
>>>>>>>     return;
>>>>>>>  }
>>>>>>>
>>>>>>> Fixes: d582484726c4 ("mptcp: fix fallback for MP_JOIN subflows")
>>>>>>> Signed-off-by: Jianguo Wu <wujianguo@chinatelecom.cn>
>>>>>>> ---
>>>>>>> net/mptcp/options.c | 6 ++++++
>>>>>>> 1 file changed, 6 insertions(+)
>>>>>>>
>>>>>>> diff --git a/net/mptcp/options.c b/net/mptcp/options.c
>>>>>>> index 1aec01686c1a..be435c5421cd 100644
>>>>>>> --- a/net/mptcp/options.c
>>>>>>> +++ b/net/mptcp/options.c
>>>>>>> @@ -926,6 +926,12 @@ static bool check_fully_established(struct mptcp_sock *msk, struct sock *ssk,
>>>>>>>     return true;
>>>>>>>
>>>>>>> reset:
>>>>>>> +    /* If a subflow is reset, the packet should not continue to be
>>>>>>> +     * processed in tcp_data_queue(), so setting: end_seq = seq,
>>>>>>> +     * then tcp_data_queue() will drop the packet.
>>>>>>> +     */
>>>>>>> +    TCP_SKB_CB(skb)->end_seq = TCP_SKB_CB(skb)->seq;
>>>>>>> +
>>>>>>
>>>>>> This does have the desired effect when mptcp_incoming_options() is 
>>>>>> called from tcp_data_queue(), but mptcp_incoming_options() is also 
>>>>>> called from tcp_reset() and tcp_rcv_state_process(). The other callers 
>>>>>> appear to tolerate the sequence number modification.
>>>>>>
>>>>>> I think it would be clearer to either add a return value or output 
>>>>>> parameter to mptcp_incoming_options() to explicitly tell the caller 
>>>>>> that a reset has been sent and tcp_done() called. Then it would be 
>>>>>> clearer in tcp_data_queue() that the packet is being discarded due to 
>>>>>> mptcp header content.
>>>>>>
>>>>>
>>>>> If a reset has been sent and tcp_done() called in 
>>>>> check_fully_established(), the sk_state will be TCP_CLOSE, how about 
>>>>> just do (sk_state == TCP_CLOSE) check in tcp_data_queue() as it did in 
>>>>> the V1 of this patch?
>>>>
>>>> Oh, I see now that Paolo suggested the the end_seq assignment in order to 
>>>> only modify MPTCP code.
>>>>
>>>> I still think it's better to make it clear that we're discarding a packet 
>>>> due to the mptcp headers - using the existing sequence check (intended to 
>>>> detect acks) in tcp_data_queue() seems sneaky to me.
>>>>
>>>> Something like
>>>>
>>>> if (sk_is_mptcp(sk) && !mptcp_incoming_options(sk, skb)) {
>>>>  	__kfree_skb(skb);
>>>>  	return;
>>>> }
>>>>
>>>> seems both compact and clear. Does that seem ok Paolo?
>>>
>>> Uhmmm... we need to touch every mptcp_incoming_options() call site, and
>>> in tcp_reset() the above chunk looks a bit strange to me. Probably we
>>> could just ignore the mptcp_incoming_options() return value there. 
>>>
>>> Otherwise no big objections - not sure about upstream ;)
>>>
>>
>> Hi Mat and Paolo,
>>
>> If you both agree, I will send a new version that mptcp_incoming_options() add a return value, and only check return value in tcp_data_queue(),
>> ignore the return value in other call site.
> 
> Even the hook in tcp_rcv_state_process() can be followed by
> tcp_data_queue().
> 
> I *think* it's better ignoring the return value of
> mptcp_incoming_options() only in tcp_reset(), adding there a comment -
> something alike "mptcp can't tell us to ignore reset pkts".
> 
> Cheers,
> 
> Paolo
> 
> p.s. I'm sorry for the long, difficult and somewhat on/off review
> process. This change is indeed tricky. Don't despair, it looks like
> it's near to an happy ending!
> 

Thanks for your review and suggestions! I will send a new version.

> 

