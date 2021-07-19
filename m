Received: from chinatelecom.cn (prt-mail.chinatelecom.cn [42.123.76.220])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A155173
	for <mptcp@lists.linux.dev>; Mon, 19 Jul 2021 09:58:01 +0000 (UTC)
HMM_SOURCE_IP:172.18.0.48:48394.613381384
HMM_ATTACHE_NUM:0000
HMM_SOURCE_TYPE:SMTP
Received: from clientip-36.111.140.26?logid-ce1e7d2d653e4b5c81e54bca2d52b3ae (unknown [172.18.0.48])
	by chinatelecom.cn (HERMES) with SMTP id CB527280072;
	Mon, 19 Jul 2021 17:57:49 +0800 (CST)
X-189-SAVE-TO-SEND: liyonglong@chinatelecom.cn
Received: from  ([172.18.0.48])
	by app0024 with ESMTP id ce1e7d2d653e4b5c81e54bca2d52b3ae for mptcp@lists.linux.dev;
	Mon Jul 19 17:57:52 2021
X-Transaction-ID: ce1e7d2d653e4b5c81e54bca2d52b3ae
X-filter-score:
X-Real-From: liyonglong@chinatelecom.cn
X-Receive-IP: 172.18.0.48
X-MEDUSA-Status: 0
Sender: liyonglong@chinatelecom.cn
Subject: Re: [MPTCP][PATCH v9 mptcp-next 0/6] mptcp: fix conflicts when using
 pm.add_signal in ADD_ADDR/echo and RM_ADDR process
To: Geliang Tang <geliangtang@gmail.com>
Cc: mptcp@lists.linux.dev
References: <cover.1626404090.git.geliangtang@gmail.com>
 <4898e7f6-8d2a-ec1f-8c17-a51c4ac7d559@chinatelecom.cn>
 <CA+WQbwvUCNtoHRX-7xVxY1AAVirym2mN1N+bPUY0R0jD6hDpEA@mail.gmail.com>
From: Yonglong Li <liyonglong@chinatelecom.cn>
Message-ID: <c340a979-1e87-b4c5-0955-b10890144fbe@chinatelecom.cn>
Date: Mon, 19 Jul 2021 17:57:36 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <CA+WQbwvUCNtoHRX-7xVxY1AAVirym2mN1N+bPUY0R0jD6hDpEA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit

Hi Geliang,

I tested v9 and don't get any issue last weekend and today.
I think v9 is ok.

On 2021/7/16 18:13, Geliang Tang wrote:
> Thanks, Yonglong,
> 
> I'll do more tests for v9. And please test v9 on your computer too.
> 
> Yonglong Li <liyonglong@chinatelecom.cn> 于2021年7月16日周五 下午5:36写道：
>>
>>
>> Hi Geliang,
>>
>> The v9 LGTM. Thank you for your help and efforts.
>>
>> On 2021/7/16 11:04, Geliang Tang wrote:
>>> From: Yonglong Li <liyonglong@chinatelecom.cn>
>>>
>>> fix issue: ADD_ADDR and RM_ADDR use pm.add_signal to mark event, so
>>> in some case pm.add_signal will be flush when ADD_ADDR/RM_ADDR in
>>> process.
>>>
>>> fix issue: if ADD_ADDR and ADD_ADDR-echo process at the same time,
>>> only one event can write pm.add_signal. so ADD_ADDR will process
>>> after add_timer timeout or ADD_ADDR-echo will not be process.
>>>
>>> Patch 1 fix ADD_ADDR and RM_ADDR maybe clear addr_signal each other.
>>>
>>> Patch 2 and 3 deal ADD_ADDR and ADD_ADDR-echo with separately to fix
>>> conflicts in using pm.addr_signal porcess.
>>>
>>> Patch 4 MPTCP_ADD_ADDR_IPV6 and MPTCP_ADD_ADDR_PORT is not necessary.
>>>
>>> v1->v2:
>>>  - remove READ_ONCE under the pm spin lock.
>>>
>>> v2->v3:
>>>  - Patch 2: mptcp_pm_should_add_addr => mptcp_pm_should_add_signal_addr
>>>  - Patch 3: avoid read-modify-write of msk->pm.addr_signal and change
>>>    mptcp_pm_add_addr_signal to return void.
>>>
>>> v3->v4:
>>>  - Patch 1: use ~(BIT(MPTCP_ADD_ADDR_SIGNAL) | BIT(MPTCP_ADD_ADDR_ECHO))
>>>    instead of BIT(MPTCP_RM_ADDR_SIGNAL)
>>>  - Patch 3: simple the code; init flags; fix wrong goto logic code;
>>>
>>> v4->v5:
>>>  - Patch 3: simple the code of 'mptcp_established_options_add_addr'
>>>
>>> v5->v6:
>>>  - Patch2: fix fails of 'mptcp_join.sh -t'. In mptcp_pm_add_addr_send_ack
>>>    without MPTCP_ADD_ADDR_SIGNAL check so pure ack can not be sent for
>>>    ADD_ADDR. That cause ADD_ADDR can not be sent in time.
>>>  - Patch3: refactor some code according Geliang's suggestions.
>>>  - Patch4: modify commit comment
>>>
>>> v6->v7:
>>>  - Patch1: use reverse xmas tree order for variables definition
>>>  - Patch3: refactor some code according Geliang's suggestions.
>>>  - add a Patch4: remove some double-check
>>>
>>> v7->v8:
>>>  - Patch1,2: exchange patch1 and patch2
>>>  - Patch3: refactor some code according Geliang's suggestions.
>>>  - remove patch "remove some double check", Geliang think it's unnecessary
>>>
>>> v8->v9:
>>>  - Keep mptcp_add_addr_len unchanged.
>>>  - populate opts->local or opts->remote after the length check, don't
>>>    populate both of them.
>>>  - add back 'echo' and 'port' arguments of mptcp_pm_add_addr_signal().
>>>  - add a new arguments drop_other_suboptions for
>>>    mptcp_pm_add_addr_signal(), and do the drop_other_suboptions check in it.
>>>  - drop other suboptions in mptcp_established_options_add_addr() after the
>>>    length check.
>>>  - split the drop_other_suboptions code into a new patch.
>>>  - add a new selftest case.
>>>
>>> Yonglong Li (6):
>>>   mptcp: move drop_other_suboptions check under pm lock
>>>   mptcp: make MPTCP_ADD_ADDR_SIGNAL and MPTCP_ADD_ADDR_ECHO separate
>>>   mptcp: fix ADD_ADDR and RM_ADDR maybe flush addr_signal each other
>>>   mptcp: build ADD_ADDR/echo-ADD_ADDR option according pm.add_signal
>>>   mptcp: remove MPTCP_ADD_ADDR_IPV6 and MPTCP_ADD_ADDR_PORT
>>>   selftests: mptcp: add_addr and echo race test
>>>
>>>  include/net/mptcp.h                           |  3 +-
>>>  net/mptcp/options.c                           | 54 +++++++++---------
>>>  net/mptcp/pm.c                                | 57 +++++++++++++------
>>>  net/mptcp/pm_netlink.c                        | 10 ++--
>>>  net/mptcp/protocol.h                          | 24 ++++----
>>>  .../testing/selftests/net/mptcp/mptcp_join.sh | 15 +++++
>>>  6 files changed, 97 insertions(+), 66 deletions(-)
>>>
>>
>> --
>> Li YongLong
> 

-- 
Li YongLong
