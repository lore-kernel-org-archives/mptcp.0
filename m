Received: from chinatelecom.cn (prt-mail.chinatelecom.cn [42.123.76.223])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E92F329CA
	for <mptcp@lists.linux.dev>; Fri, 16 Apr 2021 01:40:33 +0000 (UTC)
HMM_SOURCE_IP:172.18.0.218:56214.1283753602
HMM_ATTACHE_NUM:0000
HMM_SOURCE_TYPE:SMTP
Received: from clientip-36.111.140.26?logid-9a6c62816d204e8db19c8f8801e02ca0 (unknown [172.18.0.218])
	by chinatelecom.cn (HERMES) with SMTP id 4AF642800F4;
	Fri, 16 Apr 2021 09:31:19 +0800 (CST)
X-189-SAVE-TO-SEND: liyonglong@chinatelecom.cn
Received: from  ([172.18.0.218])
	by app0025 with ESMTP id 9a6c62816d204e8db19c8f8801e02ca0 for wujianguo@chinatelecom.cn;
	Fri Apr 16 09:31:19 2021
X-Transaction-ID: 9a6c62816d204e8db19c8f8801e02ca0
X-filter-score:  filter<0>
X-Real-From: liyonglong@chinatelecom.cn
X-Receive-IP: 172.18.0.218
X-MEDUSA-Status: 0
Sender: liyonglong@chinatelecom.cn
Subject: Re: [PATCH v2 2/2] selftests: mptcp: add a test case for MSG_PEEK
To: Matthieu Baerts <matthieu.baerts@tessares.net>,
 Paolo Abeni <pabeni@redhat.com>, mptcp@lists.linux.dev
Cc: mathew.j.martineau@linux.intel.com, fw@strlen.de,
 wujianguo@chinatelecom.cn
References: <1618456752-139032-1-git-send-email-liyonglong@chinatelecom.cn>
 <1618456752-139032-2-git-send-email-liyonglong@chinatelecom.cn>
 <f646a6a219589e55b98085adfd88094f418cc54c.camel@redhat.com>
 <e33f0087-11b8-2d5f-7a27-329436e420d9@tessares.net>
From: Yonglong Li <liyonglong@chinatelecom.cn>
Message-ID: <f83c3d2c-034c-ccc7-3cb3-72db38ff3e13@chinatelecom.cn>
Date: Fri, 16 Apr 2021 09:31:12 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <e33f0087-11b8-2d5f-7a27-329436e420d9@tessares.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit

ok, I will prepare a v3 patch as your suggestion.

On 2021/4/15 18:20, Matthieu Baerts wrote:
> Hello,
> 
> Thank you for the patches and the review!
> 
> On 15/04/2021 11:42, Paolo Abeni wrote:
>> On Thu, 2021-04-15 at 11:19 +0800, Yonglong Li wrote:
>>> Extend mptcp_connect tool with MSG_PEEK support and add a test case in
>>> mptcp_connect.sh that checks the data recvived from/after recv() with
>>> MSG_PEEK.
>>>
>>> eg: sh mptcp_connect.sh -4 -m poll -P
>>
>> The code LGTM overall. I would prever having the peek test enabled by
>> default, and I think that covering all the netns matrix is a bit
>> overkill.
>>
>> What about running a single saveWithPeek and a single saveAfterPeek on
>> loopback before the main loop?
> 
> Yes, good idea otherwise I'm not sure it will be tested often.
> 
> Cheers,
> Matt
