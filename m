Received: from chinatelecom.cn (prt-mail.chinatelecom.cn [42.123.76.223])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 879AF72
	for <mptcp@lists.linux.dev>; Fri, 11 Jun 2021 01:47:39 +0000 (UTC)
HMM_SOURCE_IP:172.18.0.48:54018.2052127694
HMM_ATTACHE_NUM:0000
HMM_SOURCE_TYPE:SMTP
Received: from clientip-36.111.140.26?logid-20f3e438967a427c9d824f695afa29fd (unknown [172.18.0.48])
	by chinatelecom.cn (HERMES) with SMTP id B53742800A7;
	Fri, 11 Jun 2021 09:47:30 +0800 (CST)
X-189-SAVE-TO-SEND: liyonglong@chinatelecom.cn
Received: from  ([172.18.0.48])
	by app0024 with ESMTP id 20f3e438967a427c9d824f695afa29fd for geliangtang@gmail.com;
	Fri Jun 11 09:47:31 2021
X-Transaction-ID: 20f3e438967a427c9d824f695afa29fd
X-filter-score:  filter<0>
X-Real-From: liyonglong@chinatelecom.cn
X-Receive-IP: 172.18.0.48
X-MEDUSA-Status: 0
Sender: liyonglong@chinatelecom.cn
Subject: Re: [PATCH] mptcp: use icsk_rto of first subflow as ADD_ADDR timeout
 value
To: Mat Martineau <mathew.j.martineau@linux.intel.com>
Cc: mptcp@lists.linux.dev, pabeni@redhat.com, matthieu.baerts@tessares.net,
 geliangtang@gmail.com
References: <1623219886-69610-1-git-send-email-liyonglong@chinatelecom.cn>
 <d5e81793-bdda-9a32-7da3-1f79e8d923d0@linux.intel.com>
From: Yonglong Li <liyonglong@chinatelecom.cn>
Message-ID: <68cf533c-7109-6377-7704-d858bfd317d1@chinatelecom.cn>
Date: Fri, 11 Jun 2021 09:47:25 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <d5e81793-bdda-9a32-7da3-1f79e8d923d0@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit



On 2021/6/11 6:11, Mat Martineau wrote:
>>
> 
> There are a few issues with this part of the patch:
> 
> 1. Changes the meaning of the sysctl
> 2. Not sure millisecond granularity is needed
> 3. Like above, don't want to allow very short timeouts that could affect userspace path managers
> 
> Like I asked above, it would be helpful to understand the problem you're solving so we can discuss possible solutions. It's also very helpful information to explain the motivation in the commit message.

In my test if ADD_ADDR-echo process right after ADD_ADDR, ADD_ADDR event will be flush
by ADD_ADDR-echo, so ADD_ADDR will process after add_timer timeout. And the timeout of
add_timer too long to trigger before connection closed.

The key point of this issue: timeout of add_timer is too long. As your advice we can only
change to a shorter timeout.
