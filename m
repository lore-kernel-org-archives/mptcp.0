Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20B112C85
	for <mptcp@lists.linux.dev>; Thu,  4 Nov 2021 13:50:13 +0000 (UTC)
Received: by mail-ed1-f43.google.com with SMTP id j21so21479750edt.11
        for <mptcp@lists.linux.dev>; Thu, 04 Nov 2021 06:50:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=B77666WxEGQKG+Za0FH8q9ocbs9Iji+9HxWfdMHX3pM=;
        b=Z8SVgaPAWqGk6B12mH+v3e6uogWy3v+Y9MD5qd1JN0JdnNaA7iXSg4rnYE255EyT/p
         mCIilaqizZbXGAKJaDvXrl+5pneVSfUmor6MgndJbfVMq9roBc0Kxyg7iu/mXiUt8f/m
         Jb3m2p+SofAzMNLAmBiKtyEf26T7QAJejgLe8nhzf73IpbLzCoj5fjxUavcN+JxY7Dmf
         Ia+SRXtrk7OyOUQn+HWqeqc5x4PqBrizD5+hJQvtbhed2cFT8XagQop5rpq7/MkClaA7
         b4fDUAu1bQBbib0uICY2hfMxtv5ZBVEeAPDoMSNvpVufFg0mMg/j4BFztRXlzM8gR/0V
         OAiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=B77666WxEGQKG+Za0FH8q9ocbs9Iji+9HxWfdMHX3pM=;
        b=NnWtcQ225cnLMfVzJYCSUlia+rPzwvOEbv5Z7MwAfFmu6TCp8CXJI5B/aZj7kl58lI
         ggyANFGsmfMOR26kSvyJDijQsrKk9zFu3b5inwrNyIit7got+vtDMmKMUvdTh3B9VVh9
         fIcaWkL6swaoJ8yKTojiRNBhSqjhBILlRGVMw4hq6bo9EYHlhs7yoeBnHyI8hv7cxQKE
         /7h13ISZUpuuBiDfV7wGOSaizw9TXbBK1KNWHokFXmSPmXbTBKLZ6gO+denMwHum3h1d
         uDTGFYeM6p0cYRLL9bTuN9T9q9ncOsGn5NV3i724GZh4lWniJso3xnu3qfLpYwbl9G2D
         LuRg==
X-Gm-Message-State: AOAM531xwI+Qe1oB+KECeyhQYCfA1kAxe8lH5DEdjmfRLi8LdbjqPSVp
	Mh0bGtucNTJwK56Du7LRpOoKQA==
X-Google-Smtp-Source: ABdhPJz/p9qj+UEJriFnCqCwp+gz1vTehy9lWVeVk5Zv+QFGyTBL3D5TdtjZxOLSLexKYdud4lAHgA==
X-Received: by 2002:a05:6402:350e:: with SMTP id b14mr17334629edd.271.1636033811957;
        Thu, 04 Nov 2021 06:50:11 -0700 (PDT)
Received: from ?IPV6:2a02:578:85b0:e00:8bb4:2878:7380:649e? ([2a02:578:85b0:e00:8bb4:2878:7380:649e])
        by smtp.gmail.com with ESMTPSA id qb21sm3070003ejc.78.2021.11.04.06.50.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Nov 2021 06:50:11 -0700 (PDT)
Message-ID: <5884d974-e4a9-d644-aa59-865980a25247@tessares.net>
Date: Thu, 4 Nov 2021 14:50:10 +0100
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
Cc: dcaratti@redhat.com, mathew.j.martineau@linux.intel.com,
 mptcp@lists.linux.dev
References: <cover.1635481641.git.geliang.tang@suse.com>
 <ff613391540609e31cf4aff5abefaa03fbd63278.1635481641.git.geliang.tang@suse.com>
 <32bda041-3193-ac47-3d4e-5a7a7e5371c0@linux.intel.com>
 <f4467f1a-ddae-92b6-48f5-30ab03dfc77f@tessares.net>
 <20211104103003.GA5555@dhcp-10-157-36-190>
 <a59a3e4c-c4ca-c50c-6ed9-ab6a5a3a1c58@tessares.net>
 <20211104131352.GA8866@bogon>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <20211104131352.GA8866@bogon>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Geliang,

On 04/11/2021 14:13, Geliang Tang wrote:
> On Thu, Nov 04, 2021 at 12:48:38PM +0100, Matthieu Baerts wrote:
>> On 04/11/2021 11:30, Geliang Tang wrote:
>>> Is this a bug in act_pedit, or we use pedit incorrectly? How can I fix
>>> this?
>>
>> Do you mean you have this error?
>>
>>   parse error: Invalid numeric literal at line 1, column 47
>>
>> To me, it looks like a bug on printing data, so on 'tc' side.
>> Which version of 'tc' are you using? May you try to upgrade to a more
>> recent one? e.g. IPRoute2 5.15.0? Maybe it has already been fixed.
> 
> You're right, it's a tc bug. And fixed already in IPRoute2 5.15.0.

Which version were you using before?
I guess we need at least the 5.8.0 to have this commit:

https://git.kernel.org/pub/scm/network/iproute2/iproute2.git/commit/tc/m_pedit.c?id=081d6c310d3a6e0412431a9652f641dff3f72aee

If yes, we should probably skip/abort the test if we cannot parse the json.

(...)

>>>>>> +    # 1 subflow
>>>>>> +    reset
>>>>>> +    ip netns exec $ns1 ./pm_nl_ctl limits 0 2
>>>>>> +    ip netns exec $ns2 ./pm_nl_ctl limits 0 2
>>>>>> +    run_tests $ns1 $ns2 10.0.1.1 2 0 "fail_1" fast
>>>
>>> Here I passed 2 as the 4th argument of run_tests like the link_failure
>>> tests to create the bigger data files. I don't know why it dosen't work
>>> when passing 0 as the argument?
>>
>> Should we first insert the TC rule, then start the test, then look at
>> counters?
>> It would be "safer" because we would not need need to make sure we have
>> enough data to transfer. WDYT?
> 
> Good point, I'll try it.

Thanks!

May you also make sure that for this test, we transfer data only in one
direction? I don't know if for the other direction, we could not give
/dev/null or generate a 1 byte file.

>>>>>> +    chk_join_nr "MP_FAIL test, 1 subflow" 0 0 0 1 1
>>>>>> +
>>>>>> +    # multiple subflows
>>>>>> +    reset
>>>>>> +    ip netns exec $ns1 ./pm_nl_ctl limits 0 2
>>>>>> +    ip netns exec $ns2 ./pm_nl_ctl limits 0 2
>>>>>> +    ip netns exec $ns2 ./pm_nl_ctl add 10.0.3.2 dev ns2eth3 flags
>>>>>> subflow
>>>>>> +    ip netns exec $ns2 ./pm_nl_ctl add 10.0.2.2 dev ns2eth2 flags
>>>>>> subflow
>>>>>> +    run_tests $ns1 $ns2 10.0.1.1 2 0 "fail_2" fast
>>>>>> +    chk_join_nr "MP_FAIL test, multiple subflows" 2 2 2 1
>>>>>> +}
>>>>>> +
>>>>>> all_tests()
>>>>>> {
>>>>>>     subflows_tests
>>>>>> @@ -1853,6 +1907,7 @@ all_tests()
>>>>>>     checksum_tests
>>>>>>     deny_join_id0_tests
>>>>>>     fullmesh_tests
>>>>>> +    fail_tests
>>>>>> }
>>>>>>
>>>>>> usage()
>>>>>> @@ -1872,6 +1927,7 @@ usage()
>>>>>>     echo "  -S checksum_tests"
>>>>>>     echo "  -d deny_join_id0_tests"
>>>>>>     echo "  -m fullmesh_tests"
>>>>>> +    echo "  -F fail_tests"
>>>>>>     echo "  -c capture pcap files"
>>>>>>     echo "  -C enable data checksum"
>>>>>>     echo "  -h help"
>>>>>> @@ -1907,7 +1963,7 @@ if [ $do_all_tests -eq 1 ]; then
>>>>>>     exit $ret
>>>>>> fi
>>>>>>
>>>>>> -while getopts 'fsltra64bpkdmchCS' opt; do
>>>>>> +while getopts 'fsltra64bpkdmchCSF' opt; do
>>>>>>     case $opt in
>>>>>>         f)
>>>>>>             subflows_tests
>>>>>> @@ -1951,6 +2007,9 @@ while getopts 'fsltra64bpkdmchCS' opt; do
>>>>>>         m)
>>>>>>             fullmesh_tests
>>>>>>             ;;
>>>>>> +        F)
>>>>>> +            fail_tests
>>>>>> +            ;;
>>>>>>         c)
>>>>>>             ;;
>>>>>>         C)
>>>>>> -- 
>>>>>> 2.26.2
>>>>>
>>>>> When I run:
>>>>>
>>>>> $ sudo ./mptcp_join.sh -FC
>>>>>
>>>>> I get:
>>>>>
>>>>> """
>>>>> Created /tmp/tmp.UTIlkuhfRW (size 1 KB) containing data sent by client
>>>>> Created /tmp/tmp.pMPhJddNfQ (size 1 KB) containing data sent by server
>>>>> Created /tmp/tmp.OEx5cmVqbp (size 10075 KB) containing data sent by client
>>>>> Created /tmp/tmp.RAtBQXOXtR (size 6144 KB) containing data sent by server
>>>>> [ FAIL ] file received by server does not match (in, out):
>>>>> -rw-------. 1 root root 20633656 Nov  3 17:32 /tmp/tmp.HtyoJjpCOe
>>>>> Trailing bytes are:
>>>>> MPTCP_TEST_FILE_END_MARKER
>>>>> -rw-------. 1 root root 20633656 Nov  3 17:32 /tmp/tmp.j8HYN1PUVh
>>>>> Trailing bytes are:
>>>>> MPTCP_TEST_FILE_END_MARKER
>>>>> 01 MP_FAIL test, 1 subflow              syn[ ok ] - synack[ ok ] - ack[
>>>>> ok ]
>>>>>                                         sum[ ok ] - csum  [ ok ]
>>>>>                                         ftx[ ok ] - frx   [ ok ]
>>>>>                                         itx[ ok ] - irx   [ ok ]
>>>>> [ FAIL ] file received by server does not match (in, out):
>>>>> -rw-------. 1 root root 20633656 Nov  3 17:32 /tmp/tmp.HtyoJjpCOe
>>>>> Trailing bytes are:
>>>>> MPTCP_TEST_FILE_END_MARKER
>>>>> -rw-------. 1 root root 20633656 Nov  3 17:32 /tmp/tmp.j8HYN1PUVh
>>>>> Trailing bytes are:
>>>>> MPTCP_TEST_FILE_END_MARKER
>>>>> 02 MP_FAIL test, multiple subflows      syn[ ok ] - synack[ ok ] - ack[
>>>>> ok ]
>>>>>                                         sum[ ok ] - csum  [ ok ]
>>>>>                                         ftx[ ok ] - frx   [ ok ]
>>>>>                                         itx[ ok ] - irx   [ ok ]
>>>>> """
>>>>>
>>>>> The chk_join_nr output shows all [ ok ], which is good. But the file
>>>>> mismatches (I assume due to the inverted data) are failures because the
>>>>> checksums are intended to reject the bad data. Am I understanding the
>>>>> file mismatches correctly?
>>>>>
>>>>> If MP_FAIL is working, the files should match.
>>>>
>>>> I also have the same error on my side but not all the time.
>>>
>>> I got these file mismatches errors all the time. Could you please share
>>> your test script and the logs when you get the right output?
>>
>> I don't think I saw them for both tests all the time but it is possible
>> it was always there for the 1st one and not for the second one. I will
>> look at that next time.
>>
>>> The first test "01 MP_FAIL test, 1 subflow" will get the file mismatches
>>> all the time, since the checksum error data can't be retransmitted in
>>> the current codes.
>>
>> Should we disable this test then?
> 
> We should keep this test. It's useful for testing sending and receiving
> of the infinite mapping. The infinite mapping is only sent in this single
> subflow case.

We should then not check the output files if we expect not to receive
the full file. Or we should compare files up to the size of the
smallest. Because what has been given to the app should not be "corrupted".

>>> But the second test "02 MP_FAIL test, multiple subflows" shouldn't get
>>> the file mismatches. RST is sent on the checksum error subflow, so this
>>> subflow is closed. The data will be retransmitted on the other subflow.
>>> It works by using the old test case "[PATCH mptcp-next v7 8/8]
>>> DO-NOT-MERGE: mptcp: mp_fail test". Data will be retransmitted, and no
>>> the file mismatches. I don't know why it dosen't work by this new test
>>> case. In this test case, I saw the error data has been dropped, and the
>>> new data has been retransmitted in the log. I'll try to fix this.
>>
> 
> Could we merge patches 1-7 of this patchset into the export branch? Then
> I'll just iterate a new version of this test case patch. And if there's
> something I need to fix next week, I'll send the squash-to patch. Please
> discuss this with Mat in today's weekly meeting.

Sounds like a good point to me. I will wait for Mat's ACK about that!
I can raise the point at today's weekly meeting.

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
