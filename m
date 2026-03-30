Received: from canpmsgout11.his.huawei.com (canpmsgout11.his.huawei.com [113.46.200.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D78371429D
	for <mptcp@lists.linux.dev>; Mon, 30 Mar 2026 10:43:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774867393; cv=none; b=cSkm6FrGc5EyOyQiM0Fs8JC558+6wwYGecYBhxS8W+Jdx53UR5jpAxwCTiUxZi3gQCJGgCC79/UJjC0e3LEhJa4Jd3+kaC0HAwvZi5K7WzUnvLo1VEMMVIK7MVX6EoUZnMp14qGRwertVXUZUgaOfELZ3csOU7UcMWo4jOfNHfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774867393; c=relaxed/simple;
	bh=531yv0Fevuus5pVVZKvem5krvxUk0IpEdrb262gMyZM=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=bI/mx5AYhobeKTbQrLgXdVD9B0IpTNmS0/Cb0FDbznBpKfBSiyI+KY2tBn2lEXkkj9oknXGGTTG6SMj5SwDMO4BQJ+vPISdTK86L+odvnEFybcQyIgS3ZqNncuHMQohfwDXDypVYqQEbswgQqtOMgB5d8gJ1cLFX4DvjCin8cAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=1pOYxzfW; arc=none smtp.client-ip=113.46.200.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="1pOYxzfW"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=FijnqdE6OSWehu5JGbmzn2xyJ6RHFhLBH81LWWs9vNk=;
	b=1pOYxzfWs28lCmu4qi8ofr29DlGUrt+tVcnM4GKKfqO34Gw7wa+oczx0Dpw+04WNdebAe1c2k
	J5hmqRzGrlLZmmjwHEBiBrG7PVjRmZocajNx5X/Fk4S6CTBCD0kpj9M269XQGVBY3oAltMnuopm
	oUvmC3IrW+4Fd9oo4rGr818=
Received: from mail.maildlp.com (unknown [172.19.163.127])
	by canpmsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4fknjz71lpzKm76;
	Mon, 30 Mar 2026 18:36:55 +0800 (CST)
Received: from kwepemj500018.china.huawei.com (unknown [7.202.194.48])
	by mail.maildlp.com (Postfix) with ESMTPS id 70CBA402AB;
	Mon, 30 Mar 2026 18:43:06 +0800 (CST)
Received: from [10.174.178.79] (10.174.178.79) by
 kwepemj500018.china.huawei.com (7.202.194.48) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 30 Mar 2026 18:43:05 +0800
Message-ID: <2a013d86-70ea-473e-9c50-332f9b0bfd81@huawei.com>
Date: Mon, 30 Mar 2026 18:43:05 +0800
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v3] mptcp: fix soft lockup in mptcp_recvmsg()
To: Matthieu Baerts <matttbe@kernel.org>
CC: Mat Martineau <martineau@kernel.org>, Geliang Tang <geliang@kernel.org>,
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon
 Horman <horms@kernel.org>, <netdev@vger.kernel.org>, <mptcp@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <yuehaibing@huawei.com>,
	<zhangchangzhong@huawei.com>, <weiyongjun1@huawei.com>
References: <20260327075544.3622851-1-lixiasong1@huawei.com>
 <c23acf06-8d10-4a3c-a3df-d62860ba6b31@kernel.org>
From: Li Xiasong <lixiasong1@huawei.com>
In-Reply-To: <c23acf06-8d10-4a3c-a3df-d62860ba6b31@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems100002.china.huawei.com (7.221.188.206) To
 kwepemj500018.china.huawei.com (7.202.194.48)

Hi Matt,

On 3/27/2026 8:13 PM, Matthieu Baerts wrote:
> Hi Li,
> 
> On 27/03/2026 08:55, Li Xiasong wrote:
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
> Thank you for the new version!
> 
> (...)
> 
>> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
>> index cf1852b99963..60f6e6a189b7 100644
>> --- a/net/mptcp/protocol.c
>> +++ b/net/mptcp/protocol.c
> 
> (...)
> 
>> @@ -2343,7 +2347,7 @@ static int mptcp_recvmsg(struct sock *sk, struct msghdr *msg, size_t len,
>>  
>>  		pr_debug("block timeout %ld\n", timeo);
>>  		mptcp_cleanup_rbuf(msk, copied);
>> -		err = sk_wait_data(sk, &timeo, NULL);
>> +		err = sk_wait_data(sk, &timeo, last);
> 
> sashiko is saying [1] this:
> 
>> Will this cause a soft lockup if all socket buffers in the receive queue
>> have already been peeked?
>>
>> If the queue only contains already-peeked buffers, the loop in
>> __mptcp_recvmsg_mskq() skips them using a continue statement:
>>
>>     if (flags & MSG_PEEK) {
>>         /* skip already peeked skbs */
>>         if (total_data_len + data_len <= copied_total) {
>>             total_data_len += data_len;
>>             continue;
>>         }
>>
>> This means last is never assigned and remains NULL.
>>
>> When last is NULL, sk_wait_data() checks if the receive queue tail is
>> not equal to NULL. Since the queue still contains the unconsumed buffers,
>> this evaluates to true and sk_wait_data() returns immediately without
>> sleeping.
>>
>> Does this result in an infinite loop here when MSG_PEEK and MSG_WAITALL
>> are used together?
> 
> I *think* that's a false positive. When MSG_PEEK and MSG_WAITALL are
> used together, sk_wait_data() will be call with "last" != NULL and will
> be unblocked when a new data packet (skb->len > 0) is added to the
> queue. In other words, when walking the queue in __mptcp_recvmsg_mskq,
> it should never be full of already-peeked skb. Or did I miss something?
> 
> If yes, "*last = skb" could be added before the "continue".
> 
> If no, this patch can be applied in 'net' directly:
> 
> Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
> 

Through code analysis and testing, there is indeed the special scenario
sashiko described:

when receiving data with MSG_PEEK | MSG_WAITALL while waiting for data
and calling shutdown(sock_fd, SHUT_WR) in another thread simultaneously,
mptcp_close_wake_up will wake up sk_wait_data, but sk->sk_state remains
FIN_WAIT2, leading to a busy loop with CPU at 100%, which can further
lead to soft lockup.

Adding '*last = skb' before 'continue' can properly solve it. I'll send
v4 with this fix later.

Thanks,
Li Xiasong

