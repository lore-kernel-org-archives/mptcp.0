Received: from m12-17.163.com (m12-17.163.com [220.181.12.17])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE7C371
	for <mptcp@lists.linux.dev>; Wed, 21 Apr 2021 08:49:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Subject:From:Message-ID:Date:MIME-Version; bh=ZJ3t9
	IP9osmElEyCxrzPoN5j9HGUdIQWDTXaTYfNuyc=; b=IRiqNopfNVX0l1nqlXSfG
	p/uB7zfGjoeMnOXliV7PhXy6nI4ayLvkz9qDwpWcuygQw2OFTmDHOEVoOKNPsUHa
	KWoMwxsK1w9Bmv9CLJu9MFCvX89zpD72kSg+S7kI/x8yRSCmAk5eGuVub4W0fgR/
	BFu1KJ56U1qwtgqGF6oUsw=
Received: from [192.168.15.51] (unknown [120.36.226.89])
	by smtp13 (Coremail) with SMTP id EcCowAD39Y0l539gDQFnwg--.25088S2;
	Wed, 21 Apr 2021 16:49:41 +0800 (CST)
Subject: Re: [PATCH] mptcp: store remote token in mptcp sock
To: Paolo Abeni <pabeni@redhat.com>,
 Mat Martineau <mathew.j.martineau@linux.intel.com>
Cc: mptcp@lists.linux.dev, matthieu.baerts@tessares.net,
 Florian Westphal <fw@strlen.de>
References: <4e1d608e-4bcd-a432-03b7-860cd3e007c2@163.com>
 <4cf0e328-db13-9c37-e87f-f84910d01070@linux.intel.com>
 <28677691-e7f6-4192-d6c1-41e3087c5509@163.com>
 <1cae9ed8392577adab3e20fd6904a1a0af7176ab.camel@redhat.com>
From: Jianguo Wu <wujianguo106@163.com>
Message-ID: <eb233af8-0941-abb1-3da3-60453be3d849@163.com>
Date: Wed, 21 Apr 2021 16:49:41 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <1cae9ed8392577adab3e20fd6904a1a0af7176ab.camel@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:EcCowAD39Y0l539gDQFnwg--.25088S2
X-Coremail-Antispam: 1Uf129KBjvJXoW3Xw4UCF1xCFy5Jry7WrWUXFb_yoWxJF4UpF
	W7KF4Ykws5JF9Fyw1vqr4UZwnIgw4ftF98Kw42v3WxArsFvrnxtF1UGFW5C3yUWr4DtF9I
	qrW5Xa9rGFyDuaUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07bOZXrUUUUU=
X-Originating-IP: [120.36.226.89]
X-CM-SenderInfo: 5zxmxt5qjx0iiqw6il2tof0z/xtbBiAV7kFaD+o72kQAAsg



On 2021/4/21 16:01, Paolo Abeni wrote:
> On Wed, 2021-04-21 at 09:43 +0800, Jianguo Wu wrote:
>> On 2021/4/21 9:01, Mat Martineau wrote:
>>> On Tue, 20 Apr 2021, Jianguo Wu wrote:
>>>
>>>> From: Jianguo Wu <wujianguo@chinatelecom.cn>
>>>>
>>>> Now every time create a new subflow, it needs to generate remote
>>>> token in __mptcp_subflow_connect(), the remote token is the same
>>>> among all subflows in a mptcp connection, so we can store
>>>> remote token in mptcp sock.
>>>>
>>>> Signed-off-by: Jianguo Wu <wujianguo@chinatelecom.cn>
>>>> ---
>>>> net/mptcp/protocol.c | 5 +++--
>>>> net/mptcp/protocol.h | 1 +
>>>> net/mptcp/subflow.c  | 7 +++----
>>>> 3 files changed, 7 insertions(+), 6 deletions(-)
>>>>
>>>> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
>>>> index a8180a9..607fb30 100644
>>>> --- a/net/mptcp/protocol.c
>>>> +++ b/net/mptcp/protocol.c
>>>> @@ -2736,7 +2736,7 @@ struct sock *mptcp_sk_clone(const struct sock *sk,
>>>>     if (mp_opt->mp_capable) {
>>>>         msk->can_ack = true;
>>>>         msk->remote_key = mp_opt->sndr_key;
>>>> -        mptcp_crypto_key_sha(msk->remote_key, NULL, &ack_seq);
>>>> +        mptcp_crypto_key_sha(msk->remote_key, &msk->remote_token, &ack_seq);
>>>>         ack_seq++;
>>>>         WRITE_ONCE(msk->ack_seq, ack_seq);
>>>>         WRITE_ONCE(msk->rcv_wnd_sent, ack_seq);
>>>> @@ -2967,7 +2967,7 @@ void mptcp_finish_connect(struct sock *ssk)
>>>>
>>>>     pr_debug("msk=%p, token=%u", sk, subflow->token);
>>>>
>>>> -    mptcp_crypto_key_sha(subflow->remote_key, NULL, &ack_seq);
>>>> +    mptcp_crypto_key_sha(subflow->remote_key, &subflow->remote_token, &ack_seq);
>>>>     ack_seq++;
>>>>     subflow->map_seq = ack_seq;
>>>>     subflow->map_subflow_seq = 1;
>>>> @@ -2976,6 +2976,7 @@ void mptcp_finish_connect(struct sock *ssk)
>>>>      * accessing the field below
>>>>      */
>>>>     WRITE_ONCE(msk->remote_key, subflow->remote_key);
>>>> +    WRITE_ONCE(msk->remote_token, subflow->remote_token);
>>>>     WRITE_ONCE(msk->local_key, subflow->local_key);
>>>>     WRITE_ONCE(msk->write_seq, subflow->idsn + 1);
>>>>     WRITE_ONCE(msk->snd_nxt, msk->write_seq);
>>>> diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
>>>> index edc0128..abd8e31 100644
>>>> --- a/net/mptcp/protocol.h
>>>> +++ b/net/mptcp/protocol.h
>>>> @@ -226,6 +226,7 @@ struct mptcp_sock {
>>>>     u64        wnd_end;
>>>>     unsigned long    timer_ival;
>>>>     u32        token;
>>>> +    u32        remote_token;
>>>>     int        rmem_released;
>>>>     unsigned long    flags;
>>>>     bool        can_ack;
>>>> diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
>>>> index 82e91b0..ddd8c03 100644
>>>> --- a/net/mptcp/subflow.c
>>>> +++ b/net/mptcp/subflow.c
>>>> @@ -1046,6 +1046,7 @@ static bool subflow_check_data_avail(struct sock *ssk)
>>>>                 goto fatal;
>>>>             }
>>>>             WRITE_ONCE(msk->remote_key, subflow->remote_key);
>>>> +            mptcp_crypto_key_sha(READ_ONCE(msk->remote_key), &msk->remote_token, NULL);
>>>
>>> Hi Jianguo, thanks for your patch.
>>>
>>> This adds a possible extra SHA calculation in this function, on the server side of a connection that may not ever use the token. This code path is only encountered in rare conditions, though: when an MP_CAPABLE+data packet is late, retransmitted, or out-of-order.
>>>
>>> (also, if we move ahead with this patch, the token should be written to a local variable and then copied to msk->remote_token using WRITE_ONCE(). Would also be more efficient to pass subflow->remote_key as the first arg because there's no READ_ONCE() required to read from the subflow structure)
>>>
>>>>             WRITE_ONCE(msk->ack_seq, subflow->map_seq);
>>>>             WRITE_ONCE(msk->can_ack, true);
>>>>         }
>>>> @@ -1268,7 +1269,6 @@ int __mptcp_subflow_connect(struct sock *sk, const struct mptcp_addr_info *loc,
>>>>     int local_id = loc->id;
>>>>     struct socket *sf;
>>>>     struct sock *ssk;
>>>> -    u32 remote_token;
>>>>     int addrlen;
>>>>     int err;
>>>>
>>>> @@ -1308,10 +1308,9 @@ int __mptcp_subflow_connect(struct sock *sk, const struct mptcp_addr_info *loc,
>>>>     if (err)
>>>>         goto failed;
>>>>
>>>> -    mptcp_crypto_key_sha(subflow->remote_key, &remote_token, NULL);
>>>>     pr_debug("msk=%p remote_token=%u local_id=%d remote_id=%d", msk,
>>>> -         remote_token, local_id, remote_id);
>>>> -    subflow->remote_token = remote_token;
>>>> +         msk->remote_token, local_id, remote_id);
>>>> +    subflow->remote_token = msk->remote_token;
>>>
>>> And here, I think, is the tradeoff: with this patch, there is no need to recalculate the SHA on every outgoing join. That's more common on the client side of a connection, where there will not be a large number of joins initiated so the cost is not very high.
>>>
>>> Given the client/server tradeoff and the likely small number of joins on any given connection, do you think this is worth changing?
>>
>> Hi Mat, thanks for your comments!
>>
>> I think, with high CPS, it can reduce lots of recalculation, and in
>> some scenarios, such as the middle mile, server side can also
>> initiate join subflows,
> 
> Uhmm... In the connections/rate performance test I did, the crypto-
> related overhead was quite low, almost un-noticeable. Do you have any
> perf figures for the above scenario (e.g. perf report or flamegraph)?
> 

Sorry, I haven't do performance test.

> Additionally, could you please describe the usage scenario with more
> details? Is that a transparent TCP-MPTCP proxy? or what else?
> 

In CDN, we may use MPTCP between CDN nodes, which clients are not be behind NAT.


>> maybe we can generate the token on the first outgoing join and store
>> in msk->remote_token, then the following outgoing joins can reuse
>> msk->remote_token?
> 
> How many subflows do you expect for each MPTCP connections? the above

typically, 2-subflows

> will provide no gain with the typical 2-subflows use-case.
> 

yes, no gain with 2-subflows, but also no regression, and it is beneficial when more than 2-subflows,
I am not sure whether it is worth to use the extra 32-bit memory for this trade-off?

Thansk!
> Thanks!
> 
> Paolo
> 

