Received: from canpmsgout01.his.huawei.com (canpmsgout01.his.huawei.com [113.46.200.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A6542874FF
	for <mptcp@lists.linux.dev>; Wed, 25 Mar 2026 02:39:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.216
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774406352; cv=none; b=T00raCV+lH7NmdTcM9//x5W5EMEmgH/5ieMaZunrg7XHWQ1F+erNE6Z09IzgHzhoWJ/0h4HOABan0c1oKHuWJe36TtwOE/e31EqJxlOjHUxemTnTwR371HHSkFNekgaSHCsj/SYFBXHhYRYhB3Szz7dot/fPEUqRZZESIRNQJs4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774406352; c=relaxed/simple;
	bh=tQAu0jm1kX0ppMikCJFUNAJd6Iw62diSkDbvaRgAVQo=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=CMHeA5YUMhlXwQRODVhdDvOmAxTTecYIUPtIa4zhCf0DB5pBf8nFlLnkwUzEgwLoNfvZzbPKLcJ5DFuxZ67T4JSuIQhUFE2mlDMZJ2TClXD6PZsmWscDy9VHNurweWnbHricF+Z+1OucGTBlaVoimd4MkmNlYMtRyntf4hyf708=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=D6FT7Yu+; arc=none smtp.client-ip=113.46.200.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="D6FT7Yu+"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=2KHcoEZPDiLl6N30smgqqmnldeFbyCyk1rIWaG45Ruc=;
	b=D6FT7Yu+ElxikcHB6JVUplKG9jqJaQ5pPjbQB1eWqiSqGKjvo/QPgSsu/m2r3t9V2IqutRma5
	rgKrXmQr8bIs0qx+Vp+QmG1gIT4AgNQCuneZLK7V22sLwSsi+vrUmzRPqv2AwM2l2XUa1o6+nYd
	nx3brWmwFWpN5dWhTn2gyzI=
Received: from mail.maildlp.com (unknown [172.19.163.0])
	by canpmsgout01.his.huawei.com (SkyGuard) with ESMTPS id 4fgWDb6JXpz1T4Fq;
	Wed, 25 Mar 2026 10:33:35 +0800 (CST)
Received: from kwepemj500018.china.huawei.com (unknown [7.202.194.48])
	by mail.maildlp.com (Postfix) with ESMTPS id 8B56740561;
	Wed, 25 Mar 2026 10:39:06 +0800 (CST)
Received: from [10.174.178.79] (10.174.178.79) by
 kwepemj500018.china.huawei.com (7.202.194.48) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 25 Mar 2026 10:39:05 +0800
Message-ID: <2da353a7-96cf-40ed-9d83-f256ec6965e1@huawei.com>
Date: Wed, 25 Mar 2026 10:39:05 +0800
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2] mptcp: fix soft lockup in mptcp_recvmsg()
To: Matthieu Baerts <matttbe@kernel.org>
CC: Mat Martineau <martineau@kernel.org>, Geliang Tang <geliang@kernel.org>,
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon
 Horman <horms@kernel.org>, <netdev@vger.kernel.org>, <mptcp@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <yuehaibing@huawei.com>,
	<zhangchangzhong@huawei.com>, <weiyongjun1@huawei.com>
References: <20260324085131.4187473-1-lixiasong1@huawei.com>
 <12ad947e-f386-4fcc-9043-bf4f95a7db83@kernel.org>
From: Li Xiasong <lixiasong1@huawei.com>
In-Reply-To: <12ad947e-f386-4fcc-9043-bf4f95a7db83@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems500002.china.huawei.com (7.221.188.17) To
 kwepemj500018.china.huawei.com (7.202.194.48)

Hi Matt,

On 3/25/2026 3:23 AM, Matthieu Baerts wrote:
> Hi Li,
> 
> On 24/03/2026 09:51, Li Xiasong wrote:
>> syzbot reported a soft lockup in mptcp_recvmsg() [0].
>>
>> When receiving data with MSG_PEEK | MSG_WAITALL flags, the skb is not
>> removed from the sk_receive_queue. This causes sk_wait_data() to always
>> find available data and never perform actual waiting, leading to a soft
>> lockup.
>>
>> Fix this by adding a 'last' parameter to track the last peeked skb.
>> This allows sk_wait_data() to make informed waiting decisions and prevent
>> infinite loops when MSG_PEEK is used.
> 
> (...)
> 
>> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
>> index cf1852b99963..401fb2b17685 100644
>> --- a/net/mptcp/protocol.c
>> +++ b/net/mptcp/protocol.c
>> @@ -2006,7 +2006,7 @@ static void mptcp_eat_recv_skb(struct sock *sk, struct sk_buff *skb)
>>  static int __mptcp_recvmsg_mskq(struct sock *sk, struct msghdr *msg,
>>  				size_t len, int flags, int copied_total,
>>  				struct scm_timestamping_internal *tss,
>> -				int *cmsg_flags)
>> +				int *cmsg_flags, struct sk_buff **last)
>>  {
>>  	struct mptcp_sock *msk = mptcp_sk(sk);
>>  	struct sk_buff *skb, *tmp;
>> @@ -2048,6 +2048,7 @@ static int __mptcp_recvmsg_mskq(struct sock *sk, struct msghdr *msg,
>>  		}
>>  
>>  		copied += count;
>> +		*last = skb;
> 
> My bad, my recommendation to move this assignment here was not a good
> idea, because 'skb' can be freed at some points after mptcp_eat_recv_skb
> that can be called here below.
> 
> If I'm not mistaken, when MSG_PEEK is not used, sk_wait_data() can
> always be called with NULL for the last skb, because the queue is
> supposed to be empty. If not, no need to wait for new packets, so NULL
> can be used. Is that correct?
> 
> If yes, then I guess 'last' can be initialised to NULL before calling
> __mptcp_recvmsg_mskq (limit scope), and only set to 'skb' here below,
> when MSG_PEEK is not used (what you had in v1).
> 
> Would that work for you?
> 
> Cheers,
> Matt

Thanks for the review. I analyzed the concern about the 'last' pointer.

When writing the v2 patch, I did consider this case - in non-MSG_PEEK
scenario, the skb is freed by mptcp_eat_recv_skb() after setting *last =
skb, making 'last' point to freed memory. However, in sk_wait_data(), the
'last' parameter is only used for pointer comparison:

    skb_peek_tail(&sk->sk_receive_queue) != skb

It only compares the pointer value without dereferencing, so there's no
actual UAF issue.

However, I agree it's still risky to keep a dangling pointer around. I
appreciate your suggestion and will adopt it in v3.

Best regards,
Li Xiasong
