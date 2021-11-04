Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9992E2C80
	for <mptcp@lists.linux.dev>; Thu,  4 Nov 2021 09:14:38 +0000 (UTC)
Received: by mail-ed1-f53.google.com with SMTP id c8so2263940ede.13
        for <mptcp@lists.linux.dev>; Thu, 04 Nov 2021 02:14:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=/Ju8DdxfOrj+B4IbA9WlqkBwdmt50m7x77nHzAcr29g=;
        b=7AO0lL3ZnlAdRQKMCOrl5VJksfCAJ5eUBl7Ct87NQWKkMJ9OCB06+LKwgGJITWWz28
         3/dSSgp3x+nF5DNwAJ1YF79IjcN24Vcd5keiKB7KJnysyoO6XfIyAosTIBpi4ycqAxpk
         W2Wx4+Ruhzpfi0NY64ItWo5w42rLJ1DlI47ckp1NG7UfSw/F5OPO4QdsYtWZeVqDIikm
         lPWDEc/1GXAG2VOtLEPiIOkOCqvwHkjDIZl2Rpw8B32+gdY3PiohFu8gBAcDqJIhR/Ub
         +rbr5E3C6fJg+gh7ypuektS4M+AyAw7xznOXK88t7mrzw5k5cIdi02ba7wsdMXj52+Hi
         zNjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=/Ju8DdxfOrj+B4IbA9WlqkBwdmt50m7x77nHzAcr29g=;
        b=I+EY2pDy91ix6YfRgLG2d5UvAAydGhncEbIPOaoxHGKTP1GNu02tnvolhIEsVkwpfl
         rDRV2ICOtb7mbYCPNBWQklSvFPUz4q6xSCBLKGLKixkSkGDhSLdlIPudyqWtf7SgoUjE
         0AYu/6O6t7nKosvhCUeqsJc2omW3Snxe7bY5fZJXU0RTNV03a9/ijCKPyBd+mOO3uqlk
         uE7asNsV570YX160b1alyMQ1LW7x4nU7nODnM3UX+qQxxsTG+ibsdqbqBZoUenD5SCSO
         8MqMzCCJk7jTzsl7CjzD5HG0+etAJKedTdqrM0/hDOT7Q8PO3WOCIobQLhpguEFt94zS
         AC6w==
X-Gm-Message-State: AOAM532wS532JrCm+TU5riuiI0LT/hmbSQhHRhXqCVq+r3SKP9n3IF66
	EXBa54u2yqwG6/Pi4d+M+URKsQ==
X-Google-Smtp-Source: ABdhPJwcieyk752Hw/c7FR8kGVI+a2ODiz9SO/a4RPqkBSBHrcmQJ4u5vuMrcDfBSxEFSvA/HXvTfw==
X-Received: by 2002:a17:907:7b8d:: with SMTP id ne13mr62162025ejc.269.1636017276394;
        Thu, 04 Nov 2021 02:14:36 -0700 (PDT)
Received: from [192.168.178.46] ([213.211.156.121])
        by smtp.gmail.com with ESMTPSA id sb8sm707988ejc.51.2021.11.04.02.14.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Nov 2021 02:14:36 -0700 (PDT)
Message-ID: <f4467f1a-ddae-92b6-48f5-30ab03dfc77f@tessares.net>
Date: Thu, 4 Nov 2021 10:14:35 +0100
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
To: Mat Martineau <mathew.j.martineau@linux.intel.com>,
 Geliang Tang <geliang.tang@suse.com>
Cc: mptcp@lists.linux.dev, Davide Caratti <dcaratti@redhat.com>
References: <cover.1635481641.git.geliang.tang@suse.com>
 <ff613391540609e31cf4aff5abefaa03fbd63278.1635481641.git.geliang.tang@suse.com>
 <32bda041-3193-ac47-3d4e-5a7a7e5371c0@linux.intel.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <32bda041-3193-ac47-3d4e-5a7a7e5371c0@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Geliang,

On 04/11/2021 01:43, Mat Martineau wrote:
> On Fri, 29 Oct 2021, Geliang Tang wrote:
> 
>> Added the test cases for MP_FAIL, use 'tc' command to trigger the
>> checksum failure.
>>
>> Suggested-by: Davide Caratti <dcaratti@redhat.com>
>> Suggested-by: Matthieu Baerts <matthieu.baerts@tessares.net>
>> Signed-off-by: Geliang Tang <geliang.tang@suse.com>
>> ---
>> tools/testing/selftests/net/mptcp/config      |  5 ++
>> .../testing/selftests/net/mptcp/mptcp_join.sh | 75 +++++++++++++++++--
>> 2 files changed, 72 insertions(+), 8 deletions(-)
>>
>> diff --git a/tools/testing/selftests/net/mptcp/config
>> b/tools/testing/selftests/net/mptcp/config
>> index 0faaccd21447..f522288b2204 100644
>> --- a/tools/testing/selftests/net/mptcp/config
>> +++ b/tools/testing/selftests/net/mptcp/config
>> @@ -15,3 +15,8 @@ CONFIG_NETFILTER_XTABLES=m
>> CONFIG_NETFILTER_XT_MATCH_BPF=m
>> CONFIG_NF_TABLES_IPV4=y
>> CONFIG_NF_TABLES_IPV6=y
>> +CONFIG_NET_ACT_CSUM=m
>> +CONFIG_NET_ACT_PEDIT=m
>> +CONFIG_NET_CLS_ACT=m
>> +CONFIG_NET_CLS_FLOWER=m
>> +CONFIG_NET_SCH_INGRESS=m
>> diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh
>> b/tools/testing/selftests/net/mptcp/mptcp_join.sh
>> index 2684ef9c0d42..d33cb5ce0ff3 100755
>> --- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
>> +++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
>> @@ -178,6 +178,12 @@ if [ $? -ne 0 ];then
>>     exit $ksft_skip
>> fi
>>
>> +jq -V > /dev/null 2>&1
>> +if [ $? -ne 0 ];then
>> +    echo "SKIP: Could not run all tests without jq tool"
>> +    exit $ksft_skip
>> +fi
>> +
>> print_file_err()
>> {
>>     ls -l "$1" 1>&2
>> @@ -232,6 +238,28 @@ link_failure()
>>     done
>> }
>>
>> +checksum_failure()
>> +{
>> +    i="$1"
>> +
>> +    tc -n $ns2 qdisc add dev ns2eth$i clsact
>> +    tc -n $ns2 filter add dev ns2eth$i egress \
>> +        protocol ip prio 1000 \
>> +        flower ip_proto tcp \
>> +        action pedit munge offset 148 u32 invert \
>> +        pipe csum tcp \
>> +        index 100
> 
> Could you add a comment explaining what the filter is doing? While it
> looks like the idea is to invert the 32-bit word at byte offset 148, I'm
> not tc-literate enough to know if there are other effects (and I didn't
> watch the email threads closely on this).

Yes that's correct. It takes only TCP packets on the egress side that
are big enough but print a message in dmesg if not. After the
modification, the TCP checksum is recomputed so the packet is valid.

> 
>> +
>> +    while true; do
>> +        local pkt=$(tc -n $ns2 -j -s action show action csum index 100 |
>> +                jq '.[1].actions[0].stats.packets')
>> +        if [ $pkt -gt 0 ]; then
>> +            tc -n $ns2 qdisc del dev ns2eth$i clsact
>> +            break
>> +        fi

On my side, I had to add a "sleep .1" to slow things down and have the
tests a bit more stable.

I also used "flower ip_proto tcp tcp_flags 0x10/0xff" and it seems
working fine.

But still and probably caused by the "sleep .1" that seems needed, I
have many messages in dmesg:

    tc action pedit offset 162 out of bounds

Because everything is shown on the serial, it is a bit annoying.

Do you think it would be possible to limit to TCP ACK and also make sure
data are only sent in one direction or limit incoming traffic to 1 byte
if it is easier? With this, we should then have a very few pure ACKs
packets on the egress side and avoid most of the TC warning messages
printed by the kernel, no?

>> +    done
>> +}
>> +
>> # $1: IP address
>> is_v6()
>> {
>> @@ -371,6 +399,9 @@ do_transfer()
>>     if [[ "${addr_nr_ns2}" = "fullmesh_"* ]]; then
>>         flags="${flags},fullmesh"
>>         addr_nr_ns2=${addr_nr_ns2:9}
>> +    elif [[ "${addr_nr_ns2}" = "fail_"* ]]; then
>> +        checksum_failure ${addr_nr_ns2:5}
>> +        addr_nr_ns2=0
>>     fi
>>
>>     if [ $addr_nr_ns2 -gt 0 ]; then
>> @@ -542,6 +573,8 @@ run_tests()
>> chk_csum_nr()
>> {
>>     local msg=${1:-""}
>> +    local csum_ns1=${2:-0}
>> +    local csum_ns2=${3:-0}
>>     local count
>>     local dump_stats
>>
>> @@ -553,8 +586,8 @@ chk_csum_nr()
>>     printf " %-36s %s" "$msg" "sum"
>>     count=`ip netns exec $ns1 nstat -as | grep MPTcpExtDataCsumErr |
>> awk '{print $2}'`
>>     [ -z "$count" ] && count=0
>> -    if [ "$count" != 0 ]; then
>> -        echo "[fail] got $count data checksum error[s] expected 0"
>> +    if [ "$count" != $csum_ns1 ]; then
>> +        echo "[fail] got $count data checksum error[s] expected
>> $csum_ns1"
>>         ret=1
>>         dump_stats=1
>>     else
>> @@ -563,8 +596,8 @@ chk_csum_nr()
>>     echo -n " - csum  "
>>     count=`ip netns exec $ns2 nstat -as | grep MPTcpExtDataCsumErr |
>> awk '{print $2}'`
>>     [ -z "$count" ] && count=0
>> -    if [ "$count" != 0 ]; then
>> -        echo "[fail] got $count data checksum error[s] expected 0"
>> +    if [ "$count" != $csum_ns2 ]; then
>> +        echo "[fail] got $count data checksum error[s] expected
>> $csum_ns2"
>>         ret=1
>>         dump_stats=1
>>     else
>> @@ -658,6 +691,8 @@ chk_join_nr()
>>     local syn_nr=$2
>>     local syn_ack_nr=$3
>>     local ack_nr=$4
>> +    local fail_nr=${5:-0}
>> +    local infi_nr=${6:-0}
>>     local count
>>     local dump_stats
>>
>> @@ -700,9 +735,9 @@ chk_join_nr()
>>         ip netns exec $ns2 nstat -as | grep MPTcp
>>     fi
>>     if [ $checksum -eq 1 ]; then
>> -        chk_csum_nr
>> -        chk_fail_nr 0 0
>> -        chk_infi_nr 0 0
>> +        chk_csum_nr "" $fail_nr
>> +        chk_fail_nr $fail_nr $fail_nr
>> +        chk_infi_nr $infi_nr $infi_nr
>>     fi
>> }
>>
>> @@ -1837,6 +1872,25 @@ fullmesh_tests()
>>     chk_add_nr 1 1
>> }
>>
>> +fail_tests()
>> +{
> 
> Since MP_FAIL is only relevent with checksums enabled, I think it would
> be good to set $checksum=1 here and restore its previous value before
> returning (in case other tests run after this).
> 
>> +    # 1 subflow
>> +    reset
>> +    ip netns exec $ns1 ./pm_nl_ctl limits 0 2
>> +    ip netns exec $ns2 ./pm_nl_ctl limits 0 2
>> +    run_tests $ns1 $ns2 10.0.1.1 2 0 "fail_1" fast
>> +    chk_join_nr "MP_FAIL test, 1 subflow" 0 0 0 1 1
>> +
>> +    # multiple subflows
>> +    reset
>> +    ip netns exec $ns1 ./pm_nl_ctl limits 0 2
>> +    ip netns exec $ns2 ./pm_nl_ctl limits 0 2
>> +    ip netns exec $ns2 ./pm_nl_ctl add 10.0.3.2 dev ns2eth3 flags
>> subflow
>> +    ip netns exec $ns2 ./pm_nl_ctl add 10.0.2.2 dev ns2eth2 flags
>> subflow
>> +    run_tests $ns1 $ns2 10.0.1.1 2 0 "fail_2" fast
>> +    chk_join_nr "MP_FAIL test, multiple subflows" 2 2 2 1
>> +}
>> +
>> all_tests()
>> {
>>     subflows_tests
>> @@ -1853,6 +1907,7 @@ all_tests()
>>     checksum_tests
>>     deny_join_id0_tests
>>     fullmesh_tests
>> +    fail_tests
>> }
>>
>> usage()
>> @@ -1872,6 +1927,7 @@ usage()
>>     echo "  -S checksum_tests"
>>     echo "  -d deny_join_id0_tests"
>>     echo "  -m fullmesh_tests"
>> +    echo "  -F fail_tests"
>>     echo "  -c capture pcap files"
>>     echo "  -C enable data checksum"
>>     echo "  -h help"
>> @@ -1907,7 +1963,7 @@ if [ $do_all_tests -eq 1 ]; then
>>     exit $ret
>> fi
>>
>> -while getopts 'fsltra64bpkdmchCS' opt; do
>> +while getopts 'fsltra64bpkdmchCSF' opt; do
>>     case $opt in
>>         f)
>>             subflows_tests
>> @@ -1951,6 +2007,9 @@ while getopts 'fsltra64bpkdmchCS' opt; do
>>         m)
>>             fullmesh_tests
>>             ;;
>> +        F)
>> +            fail_tests
>> +            ;;
>>         c)
>>             ;;
>>         C)
>> -- 
>> 2.26.2
> 
> When I run:
> 
> $ sudo ./mptcp_join.sh -FC
> 
> I get:
> 
> """
> Created /tmp/tmp.UTIlkuhfRW (size 1 KB) containing data sent by client
> Created /tmp/tmp.pMPhJddNfQ (size 1 KB) containing data sent by server
> Created /tmp/tmp.OEx5cmVqbp (size 10075 KB) containing data sent by client
> Created /tmp/tmp.RAtBQXOXtR (size 6144 KB) containing data sent by server
> [ FAIL ] file received by server does not match (in, out):
> -rw-------. 1 root root 20633656 Nov  3 17:32 /tmp/tmp.HtyoJjpCOe
> Trailing bytes are:
> MPTCP_TEST_FILE_END_MARKER
> -rw-------. 1 root root 20633656 Nov  3 17:32 /tmp/tmp.j8HYN1PUVh
> Trailing bytes are:
> MPTCP_TEST_FILE_END_MARKER
> 01 MP_FAIL test, 1 subflow              syn[ ok ] - synack[ ok ] - ack[
> ok ]
>                                         sum[ ok ] - csum  [ ok ]
>                                         ftx[ ok ] - frx   [ ok ]
>                                         itx[ ok ] - irx   [ ok ]
> [ FAIL ] file received by server does not match (in, out):
> -rw-------. 1 root root 20633656 Nov  3 17:32 /tmp/tmp.HtyoJjpCOe
> Trailing bytes are:
> MPTCP_TEST_FILE_END_MARKER
> -rw-------. 1 root root 20633656 Nov  3 17:32 /tmp/tmp.j8HYN1PUVh
> Trailing bytes are:
> MPTCP_TEST_FILE_END_MARKER
> 02 MP_FAIL test, multiple subflows      syn[ ok ] - synack[ ok ] - ack[
> ok ]
>                                         sum[ ok ] - csum  [ ok ]
>                                         ftx[ ok ] - frx   [ ok ]
>                                         itx[ ok ] - irx   [ ok ]
> """
> 
> The chk_join_nr output shows all [ ok ], which is good. But the file
> mismatches (I assume due to the inverted data) are failures because the
> checksums are intended to reject the bad data. Am I understanding the
> file mismatches correctly?
> 
> If MP_FAIL is working, the files should match.

I also have the same error on my side but not all the time.

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
