Received: from chinatelecom.cn (prt-mail.chinatelecom.cn [42.123.76.223])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0E4B173
	for <mptcp@lists.linux.dev>; Thu, 15 Jul 2021 06:13:30 +0000 (UTC)
HMM_SOURCE_IP:172.18.0.218:55966.457409766
HMM_ATTACHE_NUM:0000
HMM_SOURCE_TYPE:SMTP
Received: from clientip-36.111.140.26?logid-aa9cb3d70904416a853d71e9b4cfd4a6 (unknown [172.18.0.218])
	by chinatelecom.cn (HERMES) with SMTP id CB31828008E;
	Thu, 15 Jul 2021 14:13:21 +0800 (CST)
X-189-SAVE-TO-SEND: liyonglong@chinatelecom.cn
Received: from  ([172.18.0.218])
	by app0025 with ESMTP id aa9cb3d70904416a853d71e9b4cfd4a6 for mptcp@lists.linux.dev;
	Thu Jul 15 14:13:21 2021
X-Transaction-ID: aa9cb3d70904416a853d71e9b4cfd4a6
X-filter-score:
X-Real-From: liyonglong@chinatelecom.cn
X-Receive-IP: 172.18.0.218
X-MEDUSA-Status: 0
Sender: liyonglong@chinatelecom.cn
Subject: Re: [MPTCP][PATCH mptcp-next] Squash to "mptcp: remove
 MPTCP_ADD_ADDR_IPV6 and MPTCP_ADD_ADDR_PORT"
To: Geliang Tang <geliangtang@gmail.com>
Cc: mptcp@lists.linux.dev
References: <756dcceaa255c54b7bd195c719ede1f7ae791eb3.1626158100.git.geliangtang@gmail.com>
 <7eaa18f3391aa9862bb8274f6288ed1888af8f72.1626158161.git.geliangtang@gmail.com>
 <1e219d3d-9ea5-26ec-ae2c-dac4563bd345@chinatelecom.cn>
 <CA+WQbwtK0expftc6LPrLY701iippBZ3f7EMoTKR=WTu5p1qxjg@mail.gmail.com>
 <f7ef8d86-d644-89c5-6153-f9fb4f31b897@chinatelecom.cn>
 <CA+WQbwsJJyzpCH8-uiNj9mkd=xHHtk5kq-8ooxJCdN4sRqqkYA@mail.gmail.com>
From: Yonglong Li <liyonglong@chinatelecom.cn>
Message-ID: <c3b5260d-e52c-6f6d-a67f-c095d6961b20@chinatelecom.cn>
Date: Thu, 15 Jul 2021 14:13:15 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <CA+WQbwsJJyzpCH8-uiNj9mkd=xHHtk5kq-8ooxJCdN4sRqqkYA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit



On 2021/7/15 11:45, Geliang Tang wrote:
> Yonglong Li <liyonglong@chinatelecom.cn> 于2021年7月14日周三 下午5:49写道：
>>
>> Hi Geliang,
>>
>> On 2021/7/14 11:10, Geliang Tang wrote:
>>> Hi Yonglong,
>>>
>>> Yonglong Li <liyonglong@chinatelecom.cn> 于2021年7月13日周二 下午6:30写道：
>>>>
>>>>
>>>>
>>>> On 2021/7/13 14:44, Geliang Tang wrote:
>>>>> Keep the debug info for "send ack".
>>>>>
>>>>> Don't drop mptcp_pm_should_add_signal_ipv6() and
>>>>> mptcp_pm_should_add_signal_port().
>>>>>
>>>>> Signed-off-by: Geliang Tang <geliangtang@gmail.com>
>>>>> ---
>>>>>  net/mptcp/pm_netlink.c | 7 +++++--
>>>>>  1 file changed, 5 insertions(+), 2 deletions(-)
>>>>>
>>>>> diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
>>>>> index 3e35720317ae..2cd6caaedb08 100644
>>>>> --- a/net/mptcp/pm_netlink.c
>>>>> +++ b/net/mptcp/pm_netlink.c
>>>>> @@ -543,8 +543,11 @@ void mptcp_pm_nl_addr_send_ack(struct mptcp_sock *msk)
>>>>>               bool slow;
>>>>>
>>>>>               spin_unlock_bh(&msk->pm.lock);
>>>>> -             pr_debug("send ack for %s",
>>>>> -                      mptcp_pm_should_add_signal(msk) ? "add_addr" : "rm_addr");
>>>>> +             pr_debug("send ack for %s%s%s",
>>>>> +                      mptcp_pm_should_add_signal_addr(msk) ? "add_addr" :
>>>>> +                      (mptcp_pm_should_add_signal_echo(msk) ? "add_echo" : "rm_addr"),
>>>>> +                      mptcp_pm_should_add_signal_ipv6(msk) ? " [ipv6]" : "",
>>>>> +                      mptcp_pm_should_add_signal_port(msk) ? " [port]" : "");
>>>>>
>>>>>               slow = lock_sock_fast(ssk);
>>>>>               tcp_send_ack(ssk);
>>>>>
>>>> Hi Geliang,
>>>>
>>>> I think the debug log will be incorrect if add_addr and add_echo events trigger at the same time.
>>>> WDYT?
>>>
>>> Yes, how about moving this pr_debug line under the pm lock, just swap this
>>> pr_debug line with the spin_unlock_bh line?
>>>
>>> If so, no need to use READ_ONCE() in mptcp_pm_should_add_signal_ipv6/port
>>> too.
>> I prefer to remove ipv6 check just like v8. if you want to debug we can get more detail info
>> from debug log in mptcp_established_options_add_addr.
> 
> Sure, I had removed mptcp_pm_should_add_signal_ipv6/port in v9.
> 
>>
>>>
>>>
>>> I had tested this squash-to patches all night yesterday. And I got this
>>> error in the debug log:
>>>
>>> add_signal error, add_addr=2, echo=1
>>>
>>> This means the race occurs, right?
>>>
>> It seams like anther race case or bug? if more than one 'echo add addr' event be trigger at the same
>> time this log will be show.
> 
> And I had used your testcase to test v9 all night yesterday, and everything
> is fine, no this error anymore. It has been tested over 18000 times. So I
> think v9 works well. I'll do more test and send out v9 recently.
> 
> Do you think 18000 times is enough?  How many times do you usually test
> before?
> 
I think 18000 times is enough. Thanks for your patience.

>>
>>> Does it mean that this version cannot deal with the race either? I'm not
>>> sure.
>>>
>>> Could you please share your test scripts to me?
>>>
>> I add a test case in mptcp_join.sh, and run 'mptcp_join.sh -X -c' in a loop, if test case failed the race maybe occurs.
>> and then analsys the pcap file to check the race.
>>
>> the test case add in mptcp_join.sh:
>>
>> diff --git a/mptcp_join.sh b/mptcp_join.sh
>> index 523c779..162a451 100755
>> --- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
>> +++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
>> @@ -1462,6 +1462,24 @@ checksum_tests()
>>         chk_csum_nr "checksum test 1 0"
>>  }
>>
>> +xxoo()
>> +{
>> +       reset
>> +       ip netns exec $ns1 ./pm_nl_ctl limits 4 4
>> +       ip netns exec $ns2 ./pm_nl_ctl limits 4 4
>> +       ip netns exec $ns1 ./pm_nl_ctl add 10.0.1.1 flags signal
>> +       ip netns exec $ns1 ./pm_nl_ctl add 10.0.2.1 flags signal
>> +       ip netns exec $ns1 ./pm_nl_ctl add 10.0.3.1 flags signal
>> +       ip netns exec $ns1 ./pm_nl_ctl add 10.0.4.1 flags signal
>> +       ip netns exec $ns2 ./pm_nl_ctl add 10.0.1.2 flags signal
>> +       ip netns exec $ns2 ./pm_nl_ctl add 10.0.2.2 flags signal
>> +       ip netns exec $ns2 ./pm_nl_ctl add 10.0.3.2 flags signal
>> +       ip netns exec $ns2 ./pm_nl_ctl add 10.0.4.2 flags signal
>> +       run_tests $ns1 $ns2 10.0.1.1
>> +       chk_add_nr 4 4
>> +}
> 
> I think this testcase is worth to be added into the selftests script at
> the end of the function signal_address_tests() as an extra signal address
> test. Do you agree?
> 
> If so, I'll add this testcase into v9 and sign your name as the author.
> 
> Thanks,
> -Geliang
> 
> 
Agree. Thank you again.

> 
> 
>> +
>> +
>>  all_tests()
>>  {
>>         subflows_tests
>> @@ -1566,6 +1584,9 @@ while getopts 'fsltra64bpkchCS' opt; do
>>                 S)
>>                         checksum_tests
>>                         ;;
>> +               X)
>> +                       xxoo
>> +                       ;;
>>                 c)
>>                         ;;
>>                 C)
>>
>>
>>> Thanks,
>>> -Geliang
>>>
>>>
>>>
>>>>
>>>> --
>>>> Li YongLong
>>>
>>>
>>
>> --
>> Li YongLong
>>
> 

-- 
Li YongLong
