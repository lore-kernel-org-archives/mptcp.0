Received: from canpmsgout05.his.huawei.com (canpmsgout05.his.huawei.com [113.46.200.220])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E38217BCA
	for <mptcp@lists.linux.dev>; Wed,  4 Mar 2026 11:33:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772623997; cv=none; b=nN/kxqk8+7pAWrTOjFR/SQzx5MkrD0U6J43vC5cz7ec3OFpbQMLyyIzL+2EgkZDlKA0Z8YpFXN22W018FVI6HtrQUv1FiOrzjnuWHZFyFN2PaVi3k3MrcrjgKstOFZ2RuCaBIeatpg5Yucy/Z93asUlzCXKSPEiVDyRgYS36CrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772623997; c=relaxed/simple;
	bh=wk7qrXfDrYD6cJFDXktxKGoJNqd2Xpl/v52eEJv+3MI=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:CC:
	 In-Reply-To:Content-Type; b=n9VzEViCjlyq2BDCoLjKsUuhmS9PHjrBetpi6ygftcTSl196p6+f0mX2DrLvX8K7S2lhFAowt8MF+3VCKSwUx6s8TjZ5LQLaAq+t2Mh+a7ZePsIAF5EHkZTWnrpCmHdM1f1VDPs7mhGHPeB47ddHFObIW/K/JCN3kqJxo3vIAeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=rHjF4s7c; arc=none smtp.client-ip=113.46.200.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="rHjF4s7c"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=eEYIAbhssCXP/hvMfg0IJSwg33oSZSj04dcBiemSHFk=;
	b=rHjF4s7cSbzKNWekoCMwNPRZQr3RBfn1E5Dnrf4q6BIK/jKX6H4uf+PWJwkByyjh47eO2vmbM
	BbKe1LyMebuSgqOfYURP1oepyH/GSG03se8JNDKz/x957foLTQwn1ZV/L9wU11QkvvG0ERAxvMJ
	4IJ3QXupa7pCcWHpP2/9bRg=
Received: from mail.maildlp.com (unknown [172.19.163.104])
	by canpmsgout05.his.huawei.com (SkyGuard) with ESMTPS id 4fQr5b4tqBz12LCr;
	Wed,  4 Mar 2026 19:28:35 +0800 (CST)
Received: from kwepemj500018.china.huawei.com (unknown [7.202.194.48])
	by mail.maildlp.com (Postfix) with ESMTPS id 1FB444056A;
	Wed,  4 Mar 2026 19:33:12 +0800 (CST)
Received: from [10.174.178.79] (10.174.178.79) by
 kwepemj500018.china.huawei.com (7.202.194.48) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 4 Mar 2026 19:33:11 +0800
Message-ID: <11702093-2cda-4d02-ac26-31d9c827c63e@huawei.com>
Date: Wed, 4 Mar 2026 19:33:10 +0800
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] mptcp: fix soft lockup in mptcp_recvmsg()
To: Paolo Abeni <pabeni@redhat.com>
References: <20260302052651.1466983-1-lixiasong1@huawei.com>
 <64132462-e640-4ea6-82e8-48ca07a6ad44@redhat.com>
From: Li Xiasong <lixiasong1@huawei.com>
CC: <davem@davemloft.net>, <edumazet@google.com>, <geliang@kernel.org>,
	<horms@kernel.org>, <kuba@kernel.org>, <linux-kernel@vger.kernel.org>,
	<martineau@kernel.org>, Matthieu Baerts <matttbe@kernel.org>,
	<mptcp@lists.linux.dev>, <netdev@vger.kernel.org>, <weiyongjun1@huawei.com>,
	<yuehaibing@huawei.com>, <zhangchangzhong@huawei.com>
In-Reply-To: <64132462-e640-4ea6-82e8-48ca07a6ad44@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems100001.china.huawei.com (7.221.188.238) To
 kwepemj500018.china.huawei.com (7.202.194.48)

Hi Paolo,

On 3/4/2026 5:07 PM, Paolo Abeni wrote:
> On 3/2/26 6:26 AM, Li Xiasong wrote:
>> @@ -2343,7 +2347,7 @@ static int mptcp_recvmsg(struct sock *sk, struct msghdr *msg, size_t len,
>>  
>>  		pr_debug("block timeout %ld\n", timeo);
>>  		mptcp_cleanup_rbuf(msk, copied);
>> -		err = sk_wait_data(sk, &timeo, NULL);
>> +		err = sk_wait_data(sk, &timeo, last);
> 
> Isn't
> 		err = sk_wait_data(sk, &timeo,  skb_peek_tail(&sk->sk_receive_queue));
> 
> Enough?

Thanks for the review! In the general case, letting sk_wait_data block is
correct. The exception is within __mptcp_recvmsg_mskq, where a failure in
skb_copy_datagram_msg will cause a break in the consumption loop. This
leaves the actual processing position inconsistent with
skb_peek_tail(&sk->sk_receive_queue), and at that point, we must not wait.

> 
> Also, could you please add a paired tests-case? Thanks!
> 

Further to our discussion, a minimal reproduction case for this scenario is
available here:
https://lore.kernel.org/netdev/e91bf909-bf4d-4f90-a370-688a9424478b@huawei.com/

When running the reproduced program, you can observe the server's sy
(system) CPU usage hitting 100%.

Thanks,
Li Xiasong

