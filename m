Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFB1268
	for <mptcp@lists.linux.dev>; Thu,  4 Nov 2021 11:48:41 +0000 (UTC)
Received: by mail-ed1-f46.google.com with SMTP id ee33so20446359edb.8
        for <mptcp@lists.linux.dev>; Thu, 04 Nov 2021 04:48:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=amLbIEuPCm21zQW1lug/tgcxyS+nTVlFqqQ2pR4ExVM=;
        b=Tg9f7QKvth7geJUPuogBlnGFfGoz9ptZGEopoLnIEDNi71vm6iZZETA5eD5afhgWC6
         SK+Tyfwf64ZejiBcGa5kt7m8+gh7jUh7Lb+690+qhz0KOdB6EYMBJLYBlBirWVD1ipbY
         /fWPR4acUQkotniDA2aGCKnbGSzJkL0yceL+VvehOhkr/66TzpZfiIsM8TA2v/e9V08h
         gG1uTtpsFOQlmPN5j/gG1scXQYqzTFLm3VeupOI2RwZmydxKU9gBM8uEMEhwOC0f25fT
         4yU0YjKXI3z6zB8Oz8usGzoJ2eTkWWBniFszQtvM5Tx7kFJdn6ku4PVplqVsUsQTxEEc
         ANDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=amLbIEuPCm21zQW1lug/tgcxyS+nTVlFqqQ2pR4ExVM=;
        b=IucOIDm4C8vkaaq6xkNgONL/Y+BcNdqokhcmlQ1K8CAkyDn47TrUhwqDWmwCe367E8
         Oil/SKdBT5KGyyy8HES+t9hBwVFM7+Hx1K6qGFOPHIVzOLaWaUmZZV162cop80E4kg03
         LUjou+MXhXR0W5pQEfIn7hIlRB7VdkljHtIFzNOZ1R3sLo18DmyuEVE5u0M9963iSnD3
         0Qh1AFTV4cUu1flWha184/dwJKTWkJtqkJ5mDCv+1cE/Z9sc6h2tkfW4NVgCBW+28JWQ
         69CWe0YfXLuEuFY8nU9QWbxMjxyw8981EHpdiNZScoVa/dcjsmXZD01qGclGI8PPcHpa
         ts3Q==
X-Gm-Message-State: AOAM530FdXfZkeZ3EDpid0tcO/AKvB82IIm5Rdlty3zb9uMYYGUk2E1Y
	Tfgf/WZkm92ecmuzlDaLfNSC2wgMev8n+B1r
X-Google-Smtp-Source: ABdhPJwzEmrrEqjjCI/gWiXjZBB4H8unVVUT+tOoNxEiH2Iew+hRK1u7YPdi4uHLJMtk5ahZn4bqEQ==
X-Received: by 2002:a05:6402:4396:: with SMTP id o22mr801838edc.353.1636026519733;
        Thu, 04 Nov 2021 04:48:39 -0700 (PDT)
Received: from ?IPV6:2a02:578:85b0:e00:8bb4:2878:7380:649e? ([2a02:578:85b0:e00:8bb4:2878:7380:649e])
        by smtp.gmail.com with ESMTPSA id bq4sm2524293ejb.43.2021.11.04.04.48.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Nov 2021 04:48:39 -0700 (PDT)
Message-ID: <a59a3e4c-c4ca-c50c-6ed9-ab6a5a3a1c58@tessares.net>
Date: Thu, 4 Nov 2021 12:48:38 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.2
Subject: Re: [PATCH mptcp-next v8 8/8] selftests: mptcp: add mp_fail testcases
Content-Language: en-GB
To: Geliang Tang <geliang.tang@suse.com>
Cc: Davide Caratti <dcaratti@redhat.com>, mptcp@lists.linux.dev
References: <cover.1635481641.git.geliang.tang@suse.com>
 <ff613391540609e31cf4aff5abefaa03fbd63278.1635481641.git.geliang.tang@suse.com>
 <32bda041-3193-ac47-3d4e-5a7a7e5371c0@linux.intel.com>
 <f4467f1a-ddae-92b6-48f5-30ab03dfc77f@tessares.net>
 <20211104103003.GA5555@dhcp-10-157-36-190>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <20211104103003.GA5555@dhcp-10-157-36-190>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Geliang,

On 04/11/2021 11:30, Geliang Tang wrote:
> Hi Matt, Davide,
> 
> On Thu, Nov 04, 2021 at 10:14:35AM +0100, Matthieu Baerts wrote:
>> Hi Geliang,
>>
>> On 04/11/2021 01:43, Mat Martineau wrote:
>>> On Fri, 29 Oct 2021, Geliang Tang wrote:
>>>
>>>> Added the test cases for MP_FAIL, use 'tc' command to trigger the
>>>> checksum failure.
>>>>
>>>> Suggested-by: Davide Caratti <dcaratti@redhat.com>
>>>> Suggested-by: Matthieu Baerts <matthieu.baerts@tessares.net>
>>>> Signed-off-by: Geliang Tang <geliang.tang@suse.com>
>>>> ---
>>>> tools/testing/selftests/net/mptcp/config      |  5 ++
>>>> .../testing/selftests/net/mptcp/mptcp_join.sh | 75 +++++++++++++++++--
>>>> 2 files changed, 72 insertions(+), 8 deletions(-)
>>>>
>>>> diff --git a/tools/testing/selftests/net/mptcp/config
>>>> b/tools/testing/selftests/net/mptcp/config
>>>> index 0faaccd21447..f522288b2204 100644
>>>> --- a/tools/testing/selftests/net/mptcp/config
>>>> +++ b/tools/testing/selftests/net/mptcp/config
>>>> @@ -15,3 +15,8 @@ CONFIG_NETFILTER_XTABLES=m
>>>> CONFIG_NETFILTER_XT_MATCH_BPF=m
>>>> CONFIG_NF_TABLES_IPV4=y
>>>> CONFIG_NF_TABLES_IPV6=y
>>>> +CONFIG_NET_ACT_CSUM=m
>>>> +CONFIG_NET_ACT_PEDIT=m
>>>> +CONFIG_NET_CLS_ACT=m
>>>> +CONFIG_NET_CLS_FLOWER=m
>>>> +CONFIG_NET_SCH_INGRESS=m
>>>> diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh
>>>> b/tools/testing/selftests/net/mptcp/mptcp_join.sh
>>>> index 2684ef9c0d42..d33cb5ce0ff3 100755
>>>> --- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
>>>> +++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
>>>> @@ -178,6 +178,12 @@ if [ $? -ne 0 ];then
>>>>     exit $ksft_skip
>>>> fi
>>>>
>>>> +jq -V > /dev/null 2>&1
>>>> +if [ $? -ne 0 ];then
>>>> +    echo "SKIP: Could not run all tests without jq tool"
>>>> +    exit $ksft_skip
>>>> +fi
>>>> +
>>>> print_file_err()
>>>> {
>>>>     ls -l "$1" 1>&2
>>>> @@ -232,6 +238,28 @@ link_failure()
>>>>     done
>>>> }
>>>>
>>>> +checksum_failure()
>>>> +{
>>>> +    i="$1"
>>>> +
>>>> +    tc -n $ns2 qdisc add dev ns2eth$i clsact
>>>> +    tc -n $ns2 filter add dev ns2eth$i egress \
>>>> +        protocol ip prio 1000 \
>>>> +        flower ip_proto tcp \
>>>> +        action pedit munge offset 148 u32 invert \
>>>> +        pipe csum tcp \
>>>> +        index 100
>>>
>>> Could you add a comment explaining what the filter is doing? While it
>>> looks like the idea is to invert the 32-bit word at byte offset 148, I'm
>>> not tc-literate enough to know if there are other effects (and I didn't
>>> watch the email threads closely on this).
> 
> Matt, could you please add this comment for me? I didn't understand
> these tc commands very well, and I can't explain them very clearly in
> English.

Sure. Here is my proposition:

    # Modify TCP payload without corrupting the TCP packet
    #
    # This rule inverts a 32-bit word at byte offset 148 for all TCP ACK
    # packets carrying enough data.
    # Once it is done, the TCP Checksum field is updated so the packet
    # is still considered as valid at the TCP level.
    # But because the MPTCP checksum, covering the TCP options and data,
    # has not been updated, we will detect the modification and emit an
    # MP_FAIL: what we want to validate here.
    #
    # Please note that this rule will produce this pr_info() message for
    # each TCP ACK packets not carrying enough data:
    #
    #     tc action pedit offset 162 out of bounds
    #
    # But this should be limited to a very few numbers of packets as we
    # restrict this rule to outgoing TCP traffic with only the ACK flag
    # + except the 3rd ACK, only packets carrying data should be seen in
    # this direction.

This comment makes sense if you use "flower ip_proto tcp tcp_flags
0x10/0xff" and reduce incoming traffic. Otherwise, we need to remove
"ACK" and/or the last sentence but I don't think we should make this
test printing a lot of pr_info().

> 
>>
>> Yes that's correct. It takes only TCP packets on the egress side that
>> are big enough but print a message in dmesg if not. After the
>> modification, the TCP checksum is recomputed so the packet is valid.
>>
>>>
>>>> +
>>>> +    while true; do
>>>> +        local pkt=$(tc -n $ns2 -j -s action show action csum index 100 |
>>>> +                jq '.[1].actions[0].stats.packets')
> 
> Should we show the action 'pedit' here, instead of 'csum'?
> 
> The action 'csum' output is like this:
> 
> # tc -n $ns2 -j -s action show action csum index 100
> 
> [{"total acts":1},{"actions":[{"order":0,"kind":"csum","csum":"tcp","control_action":{"type":"pass"},"index":100,"ref":1,"bind":1,"installed":29,"last_used":2,"stats":{"bytes":11576,"packets":42,"drops":0,"overlimits":0,"requeues":0,"backlog":0,"qlen":0}}]}]
> 
> "overlimits" is always 0 in 'csum'.

Good point. I thought 'pedit' would not let the packet passing to csum
if it was over the limits but I guess it does if we see the same values
for packets/bytes counters in 'csum' and 'pedit' actions.

> But the action 'pedit' output is like this:
> 
> # tc -n $ns2 -j -s action show action pedit index 100
> 
> [{"total acts":1},{"actions":[{"order":0 pedit ,"control_action":{"type":"pipe"}keys 1
>  	 index 1 ref 1 bind 1,"installed":29,"last_used":2
> 	 key #0  at 148: val ffffffff mask ffffffff
>  ,"stats":{"bytes":11576,"packets":42,"drops":0,"overlimits":36,"requeues":0,"backlog":0,"qlen":0}}]}]

(When you will get the right output, may you add this in a comment in
the script as an example to explain what you have and what you try to
parse please?)

> 
> "overlimits" values are all right here

From what I see in the code, if the packet was not carrying enough data
'act_pedit' will increase the 'overlimits' counter and the other ones --
bytes and packets I guess -- as well:


https://elixir.bootlin.com/linux/latest/source/net/sched/act_pedit.c#L368

So good point, we should look at 'pedit' counters and more precisely at:

  "packets" - "overlimits" > 0

here.

> but this output can't be parsed by
> 'jq'. It looks like something wrong to show 'pedit'.
>> Is this a bug in act_pedit, or we use pedit incorrectly? How can I fix
this?

Do you mean you have this error?

  parse error: Invalid numeric literal at line 1, column 47

To me, it looks like a bug on printing data, so on 'tc' side.
Which version of 'tc' are you using? May you try to upgrade to a more
recent one? e.g. IPRoute2 5.15.0? Maybe it has already been fixed.

>>>> +        if [ $pkt -gt 0 ]; then
>>>> +            tc -n $ns2 qdisc del dev ns2eth$i clsact
>>>> +            break
>>>> +        fi
>>
>> On my side, I had to add a "sleep .1" to slow things down and have the
>> tests a bit more stable.
>>
>> I also used "flower ip_proto tcp tcp_flags 0x10/0xff" and it seems
>> working fine.
> 
> Could you please share your checksum_failure function here, I'll test it
> on my side?

I did that to have the test finishing on my side:

--------------- 8< ---------------
diff --git a/tools/testing/selftests/net/mptcp/config
b/tools/testing/selftests/net/mptcp/config
index f522288b2204..2aff41754c8f 100644
--- a/tools/testing/selftests/net/mptcp/config
+++ b/tools/testing/selftests/net/mptcp/config
@@ -17,6 +17,6 @@ CONFIG_NF_TABLES_IPV4=y
 CONFIG_NF_TABLES_IPV6=y
 CONFIG_NET_ACT_CSUM=m
 CONFIG_NET_ACT_PEDIT=m
-CONFIG_NET_CLS_ACT=m
+CONFIG_NET_CLS_ACT=y
 CONFIG_NET_CLS_FLOWER=m
 CONFIG_NET_SCH_INGRESS=m
diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh
b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index d33cb5ce0ff3..8dcd445b1532 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -245,7 +245,7 @@ checksum_failure()
        tc -n $ns2 qdisc add dev ns2eth$i clsact
        tc -n $ns2 filter add dev ns2eth$i egress \
                protocol ip prio 1000 \
-               flower ip_proto tcp \
+               flower ip_proto tcp tcp_flags 0x10/0xff \
                action pedit munge offset 148 u32 invert \
                pipe csum tcp \
                index 100
@@ -257,6 +257,7 @@ checksum_failure()
                        tc -n $ns2 qdisc del dev ns2eth$i clsact
                        break
                fi
+               sleep .1
        done
 }

--------------- 8< ---------------

> 
>>
>> But still and probably caused by the "sleep .1" that seems needed, I
>> have many messages in dmesg:
>>
>>     tc action pedit offset 162 out of bounds
>>
>> Because everything is shown on the serial, it is a bit annoying.
>>
>> Do you think it would be possible to limit to TCP ACK and also make sure
>> data are only sent in one direction or limit incoming traffic to 1 byte
>> if it is easier? With this, we should then have a very few pure ACKs
>> packets on the egress side and avoid most of the TC warning messages
>> printed by the kernel, no?
>>
>>>> +    done
>>>> +}
>>>> +
>>>> # $1: IP address
>>>> is_v6()
>>>> {
>>>> @@ -371,6 +399,9 @@ do_transfer()
>>>>     if [[ "${addr_nr_ns2}" = "fullmesh_"* ]]; then
>>>>         flags="${flags},fullmesh"
>>>>         addr_nr_ns2=${addr_nr_ns2:9}
>>>> +    elif [[ "${addr_nr_ns2}" = "fail_"* ]]; then
>>>> +        checksum_failure ${addr_nr_ns2:5}
>>>> +        addr_nr_ns2=0
>>>>     fi
>>>>
>>>>     if [ $addr_nr_ns2 -gt 0 ]; then
>>>> @@ -542,6 +573,8 @@ run_tests()
>>>> chk_csum_nr()
>>>> {
>>>>     local msg=${1:-""}
>>>> +    local csum_ns1=${2:-0}
>>>> +    local csum_ns2=${3:-0}
>>>>     local count
>>>>     local dump_stats
>>>>
>>>> @@ -553,8 +586,8 @@ chk_csum_nr()
>>>>     printf " %-36s %s" "$msg" "sum"
>>>>     count=`ip netns exec $ns1 nstat -as | grep MPTcpExtDataCsumErr |
>>>> awk '{print $2}'`
>>>>     [ -z "$count" ] && count=0
>>>> -    if [ "$count" != 0 ]; then
>>>> -        echo "[fail] got $count data checksum error[s] expected 0"
>>>> +    if [ "$count" != $csum_ns1 ]; then
>>>> +        echo "[fail] got $count data checksum error[s] expected
>>>> $csum_ns1"
>>>>         ret=1
>>>>         dump_stats=1
>>>>     else
>>>> @@ -563,8 +596,8 @@ chk_csum_nr()
>>>>     echo -n " - csum  "
>>>>     count=`ip netns exec $ns2 nstat -as | grep MPTcpExtDataCsumErr |
>>>> awk '{print $2}'`
>>>>     [ -z "$count" ] && count=0
>>>> -    if [ "$count" != 0 ]; then
>>>> -        echo "[fail] got $count data checksum error[s] expected 0"
>>>> +    if [ "$count" != $csum_ns2 ]; then
>>>> +        echo "[fail] got $count data checksum error[s] expected
>>>> $csum_ns2"
>>>>         ret=1
>>>>         dump_stats=1
>>>>     else
>>>> @@ -658,6 +691,8 @@ chk_join_nr()
>>>>     local syn_nr=$2
>>>>     local syn_ack_nr=$3
>>>>     local ack_nr=$4
>>>> +    local fail_nr=${5:-0}
>>>> +    local infi_nr=${6:-0}
>>>>     local count
>>>>     local dump_stats
>>>>
>>>> @@ -700,9 +735,9 @@ chk_join_nr()
>>>>         ip netns exec $ns2 nstat -as | grep MPTcp
>>>>     fi
>>>>     if [ $checksum -eq 1 ]; then
>>>> -        chk_csum_nr
>>>> -        chk_fail_nr 0 0
>>>> -        chk_infi_nr 0 0
>>>> +        chk_csum_nr "" $fail_nr
>>>> +        chk_fail_nr $fail_nr $fail_nr
>>>> +        chk_infi_nr $infi_nr $infi_nr
>>>>     fi
>>>> }
>>>>
>>>> @@ -1837,6 +1872,25 @@ fullmesh_tests()
>>>>     chk_add_nr 1 1
>>>> }
>>>>
>>>> +fail_tests()
>>>> +{
>>>
>>> Since MP_FAIL is only relevent with checksums enabled, I think it would
>>> be good to set $checksum=1 here and restore its previous value before
>>> returning (in case other tests run after this).
>>>
>>>> +    # 1 subflow
>>>> +    reset
>>>> +    ip netns exec $ns1 ./pm_nl_ctl limits 0 2
>>>> +    ip netns exec $ns2 ./pm_nl_ctl limits 0 2
>>>> +    run_tests $ns1 $ns2 10.0.1.1 2 0 "fail_1" fast
> 
> Here I passed 2 as the 4th argument of run_tests like the link_failure
> tests to create the bigger data files. I don't know why it dosen't work
> when passing 0 as the argument?

Should we first insert the TC rule, then start the test, then look at
counters?
It would be "safer" because we would not need need to make sure we have
enough data to transfer. WDYT?

>>>> +    chk_join_nr "MP_FAIL test, 1 subflow" 0 0 0 1 1
>>>> +
>>>> +    # multiple subflows
>>>> +    reset
>>>> +    ip netns exec $ns1 ./pm_nl_ctl limits 0 2
>>>> +    ip netns exec $ns2 ./pm_nl_ctl limits 0 2
>>>> +    ip netns exec $ns2 ./pm_nl_ctl add 10.0.3.2 dev ns2eth3 flags
>>>> subflow
>>>> +    ip netns exec $ns2 ./pm_nl_ctl add 10.0.2.2 dev ns2eth2 flags
>>>> subflow
>>>> +    run_tests $ns1 $ns2 10.0.1.1 2 0 "fail_2" fast
>>>> +    chk_join_nr "MP_FAIL test, multiple subflows" 2 2 2 1
>>>> +}
>>>> +
>>>> all_tests()
>>>> {
>>>>     subflows_tests
>>>> @@ -1853,6 +1907,7 @@ all_tests()
>>>>     checksum_tests
>>>>     deny_join_id0_tests
>>>>     fullmesh_tests
>>>> +    fail_tests
>>>> }
>>>>
>>>> usage()
>>>> @@ -1872,6 +1927,7 @@ usage()
>>>>     echo "  -S checksum_tests"
>>>>     echo "  -d deny_join_id0_tests"
>>>>     echo "  -m fullmesh_tests"
>>>> +    echo "  -F fail_tests"
>>>>     echo "  -c capture pcap files"
>>>>     echo "  -C enable data checksum"
>>>>     echo "  -h help"
>>>> @@ -1907,7 +1963,7 @@ if [ $do_all_tests -eq 1 ]; then
>>>>     exit $ret
>>>> fi
>>>>
>>>> -while getopts 'fsltra64bpkdmchCS' opt; do
>>>> +while getopts 'fsltra64bpkdmchCSF' opt; do
>>>>     case $opt in
>>>>         f)
>>>>             subflows_tests
>>>> @@ -1951,6 +2007,9 @@ while getopts 'fsltra64bpkdmchCS' opt; do
>>>>         m)
>>>>             fullmesh_tests
>>>>             ;;
>>>> +        F)
>>>> +            fail_tests
>>>> +            ;;
>>>>         c)
>>>>             ;;
>>>>         C)
>>>> -- 
>>>> 2.26.2
>>>
>>> When I run:
>>>
>>> $ sudo ./mptcp_join.sh -FC
>>>
>>> I get:
>>>
>>> """
>>> Created /tmp/tmp.UTIlkuhfRW (size 1 KB) containing data sent by client
>>> Created /tmp/tmp.pMPhJddNfQ (size 1 KB) containing data sent by server
>>> Created /tmp/tmp.OEx5cmVqbp (size 10075 KB) containing data sent by client
>>> Created /tmp/tmp.RAtBQXOXtR (size 6144 KB) containing data sent by server
>>> [ FAIL ] file received by server does not match (in, out):
>>> -rw-------. 1 root root 20633656 Nov  3 17:32 /tmp/tmp.HtyoJjpCOe
>>> Trailing bytes are:
>>> MPTCP_TEST_FILE_END_MARKER
>>> -rw-------. 1 root root 20633656 Nov  3 17:32 /tmp/tmp.j8HYN1PUVh
>>> Trailing bytes are:
>>> MPTCP_TEST_FILE_END_MARKER
>>> 01 MP_FAIL test, 1 subflow              syn[ ok ] - synack[ ok ] - ack[
>>> ok ]
>>>                                         sum[ ok ] - csum  [ ok ]
>>>                                         ftx[ ok ] - frx   [ ok ]
>>>                                         itx[ ok ] - irx   [ ok ]
>>> [ FAIL ] file received by server does not match (in, out):
>>> -rw-------. 1 root root 20633656 Nov  3 17:32 /tmp/tmp.HtyoJjpCOe
>>> Trailing bytes are:
>>> MPTCP_TEST_FILE_END_MARKER
>>> -rw-------. 1 root root 20633656 Nov  3 17:32 /tmp/tmp.j8HYN1PUVh
>>> Trailing bytes are:
>>> MPTCP_TEST_FILE_END_MARKER
>>> 02 MP_FAIL test, multiple subflows      syn[ ok ] - synack[ ok ] - ack[
>>> ok ]
>>>                                         sum[ ok ] - csum  [ ok ]
>>>                                         ftx[ ok ] - frx   [ ok ]
>>>                                         itx[ ok ] - irx   [ ok ]
>>> """
>>>
>>> The chk_join_nr output shows all [ ok ], which is good. But the file
>>> mismatches (I assume due to the inverted data) are failures because the
>>> checksums are intended to reject the bad data. Am I understanding the
>>> file mismatches correctly?
>>>
>>> If MP_FAIL is working, the files should match.
>>
>> I also have the same error on my side but not all the time.
> 
> I got these file mismatches errors all the time. Could you please share
> your test script and the logs when you get the right output?

I don't think I saw them for both tests all the time but it is possible
it was always there for the 1st one and not for the second one. I will
look at that next time.

> The first test "01 MP_FAIL test, 1 subflow" will get the file mismatches
> all the time, since the checksum error data can't be retransmitted in
> the current codes.

Should we disable this test then?

> But the second test "02 MP_FAIL test, multiple subflows" shouldn't get
> the file mismatches. RST is sent on the checksum error subflow, so this
> subflow is closed. The data will be retransmitted on the other subflow.
> It works by using the old test case "[PATCH mptcp-next v7 8/8]
> DO-NOT-MERGE: mptcp: mp_fail test". Data will be retransmitted, and no
> the file mismatches. I don't know why it dosen't work by this new test
> case. In this test case, I saw the error data has been dropped, and the
> new data has been retransmitted in the log. I'll try to fix this.

Thanks!

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
