Received: from out30-43.freemail.mail.aliyun.com (out30-43.freemail.mail.aliyun.com [115.124.30.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4DD22C9D
	for <mptcp@lists.linux.dev>; Fri, 28 Jan 2022 13:55:02 +0000 (UTC)
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R761e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04426;MF=alibuda@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0V32luS0_1643378086;
Received: from 192.168.1.13(mailfrom:alibuda@linux.alibaba.com fp:SMTPD_---0V32luS0_1643378086)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 28 Jan 2022 21:54:52 +0800
Message-ID: <e0d9d02f-6863-5ee0-4353-cd4194fec1de@linux.alibaba.com>
Date: Fri, 28 Jan 2022 21:54:45 +0800
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.5.0
Subject: Re: [PATCH net-next 3/3] net/smc: Fallback when handshake workqueue
 congested
To: Matthieu Baerts <matthieu.baerts@tessares.net>, kgraul@linux.ibm.com
Cc: kuba@kernel.org, davem@davemloft.net, netdev@vger.kernel.org,
 linux-s390@vger.kernel.org, linux-rdma@vger.kernel.org,
 MPTCP Upstream <mptcp@lists.linux.dev>
References: <cover.1643284658.git.alibuda@linux.alibaba.com>
 <ed4781cde8e3b9812d4a46ce676294a812c80e8f.1643284658.git.alibuda@linux.alibaba.com>
 <1825f5e8-6d13-a317-4a96-f4a4fcf07409@tessares.net>
From: "D. Wythe" <alibuda@linux.alibaba.com>
In-Reply-To: <1825f5e8-6d13-a317-4a96-f4a4fcf07409@tessares.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


This is a spelling error, which has nothing to do with MPTCP. I'll fix 
it soon.


在 2022/1/28 上午1:09, Matthieu Baerts 写道:
> Hi,
> 
> (+cc MPTCP ML)
> 
> On 27/01/2022 13:08, D. Wythe wrote:
>> From: "D. Wythe" <alibuda@linux.alibaba.com>
>>
>> This patch intends to provide a mechanism to allow automatic fallback to
>> TCP according to the pressure of SMC handshake process. At present,
>> frequent visits will cause the incoming connections to be backlogged in
>> SMC handshake queue, raise the connections established time. Which is
>> quite unacceptable for those applications who base on short lived
>> connections.
> 
> (...)
> 
>> diff --git a/net/smc/Kconfig b/net/smc/Kconfig
>> index 1ab3c5a..1903927 100644
>> --- a/net/smc/Kconfig
>> +++ b/net/smc/Kconfig
>> @@ -19,3 +19,15 @@ config SMC_DIAG
>>   	  smcss.
>>   
>>   	  if unsure, say Y.
>> +
>> +if MPTCP
> 
> After having read the code and the commit message, it is not clear to me
>   why this new feature requires to have MPTCP enabled. May you share some
> explanations about that please?
> 
>> +
>> +config SMC_AUTO_FALLBACK
>> +	bool "SMC: automatic fallback to TCP"
>> +	default y
>> +	help
>> +	  Allow automatic fallback to TCP accroding to the pressure of SMC-R
>> +	  handshake process.
>> +
>> +	  If that's not what you except or unsure, say N.
>> +endif
> 
> Cheers,
> Matt
