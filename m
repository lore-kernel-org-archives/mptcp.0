Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A5A72580
	for <mptcp@lists.linux.dev>; Mon, 20 Jun 2022 16:52:25 +0000 (UTC)
Received: by mail-ej1-f47.google.com with SMTP id n20so15521444ejz.10
        for <mptcp@lists.linux.dev>; Mon, 20 Jun 2022 09:52:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=q7rIbk16p8jaUo848u/VyuiFwd/CPg37jS/tHPKkbd8=;
        b=C52izw4/8lEmQS0fug5DG2vUWwuGdPsjV3MciLJMF9Vlje5/nmTKO23IRmDQnZkhUI
         DMRRtwnjAa3RWhDy3GbUsZiKKvv7CGU8wnzNBQOQ5WtZZb2DFH2lWYUtwblBWd/h8/sA
         uuHsYdH+XL2X4zgjPnGTHX+tjvmObq4VH7vVjKhJzlDGJvA/QQBpuIyfE5wCS3FKAOLp
         3u6852VNkKysYqtIPbsPKjj3AaVd8N4e3/WXo/ovlU4EVr0R84fkfC/fYq8FvLamUjoQ
         B43yeIZnUs6p3OGghCodon2GpHsLKqpk1/MB0AZEVlneBUcbeHR+NqeDACBnq+uBGbyc
         KMAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=q7rIbk16p8jaUo848u/VyuiFwd/CPg37jS/tHPKkbd8=;
        b=ux6+7uJmV3jIseuPRFG23Nl8sqCvaGxZOP1P92+w+gsAi2iecI/NeDmdlFYzlAwXGI
         OeNhau6n7PnT/dH/LS4lY8j8fFLXwRfjTcuo5T7881jvgoXaQYRkRmuxnLDcv7JSU2k9
         PF5ckvZsGYIIsMEE2mTas1rfUTLzPbdelHJ9kOV91cFwDGto3qqr9N6BGHmhroTaexwv
         gFe5yAGH+jJnkrsK7H6trKwNSPUsK4Y7jKj48Cv6unfcs+bzpyLw7IdbBlJ/I/roPLNk
         DQZvjE2iMiTStEE9ON/DhCMB1Egv54/s9mosDaYBrUIzx+nCUK2+JNiHu/EBcLDnMN9O
         5w8g==
X-Gm-Message-State: AJIora/9IfJb48UAfp1VIz/t5RBp2lA5mAKK2HWkMknrPqhSt2GVmZJa
	WhV0SOf4bzzS7V0xVk0LySepc9bgNXO7edTp
X-Google-Smtp-Source: AGRyM1tLpMqlEDhICY4Cl7WrYt1uoVhi4uDLvMGXOsZzocZ0/83rQoQAizH9S6S8zW10LjDbV5eNHg==
X-Received: by 2002:a17:907:629a:b0:6d7:b33e:43f4 with SMTP id nd26-20020a170907629a00b006d7b33e43f4mr22132355ejc.149.1655743943543;
        Mon, 20 Jun 2022 09:52:23 -0700 (PDT)
Received: from ?IPV6:2a02:578:8593:1200:dab4:d6b9:b46d:dda6? ([2a02:578:8593:1200:dab4:d6b9:b46d:dda6])
        by smtp.gmail.com with ESMTPSA id 4-20020a170906300400b00722dcb4629bsm410964ejz.14.2022.06.20.09.52.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Jun 2022 09:52:23 -0700 (PDT)
Message-ID: <a2116590-580e-9b95-3224-48cbad6786cf@tessares.net>
Date: Mon, 20 Jun 2022 18:52:22 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH mptcp-next v3 3/5] selftests: mptcp: userspace pm subflow
 tests
Content-Language: en-GB
To: Mat Martineau <mathew.j.martineau@linux.intel.com>,
 Geliang Tang <geliang.tang@suse.com>
Cc: mptcp@lists.linux.dev
References: <cover.1655355422.git.geliang.tang@suse.com>
 <3fe28e031020b282b23e906b1095f1cce16af111.1655355422.git.geliang.tang@suse.com>
 <655c24a-a36-d7af-5b1d-925191d17c43@linux.intel.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <655c24a-a36-d7af-5b1d-925191d17c43@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Mat,

On 18/06/2022 00:10, Mat Martineau wrote:
> On Thu, 16 Jun 2022, Geliang Tang wrote:
> 
>> This patch adds userspace pm subflow tests support for mptcp_join.sh
>> script. Add userpace pm create subflow and destroy test cases in
>> userspace_tests().
>>
>> Signed-off-by: Geliang Tang <geliang.tang@suse.com>
>> ---
>> .../testing/selftests/net/mptcp/mptcp_join.sh | 40 ++++++++++++++++++-
>> 1 file changed, 38 insertions(+), 2 deletions(-)
>>
>> diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh
>> b/tools/testing/selftests/net/mptcp/mptcp_join.sh
>> index 977c59c540b2..bec22fa38415 100755
>> --- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
>> +++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
>> @@ -657,6 +657,8 @@ do_transfer()
>>     local userspace_pm=0
>>     local evts_ns1
>>     local evts_ns1_pid
>> +    local evts_ns2
>> +    local evts_ns2_pid
>>
>>     :> "$cout"
>>     :> "$sout"
>> @@ -702,13 +704,20 @@ do_transfer()
>>         # disconnect
>>         extra_args="$extra_args -I ${addr_nr_ns2:10}"
>>         addr_nr_ns2=0
>> +    elif [[ "${addr_nr_ns2}" = "userspace_"* ]]; then
>> +        userspace_pm=1
>> +        addr_nr_ns2=${addr_nr_ns2:10}
>>     fi
>>
>>     if [ $userspace_pm -eq 1 ]; then
>>         evts_ns1=$(mktemp)
>> +        evts_ns2=$(mktemp)
>>         :> "$evts_ns1"
>> +        :> "$evts_ns2"
>>         ip netns exec ${listener_ns} ./pm_nl_ctl events >> "$evts_ns1"
>> 2>&1 &
>>         evts_ns1_pid=$!
>> +        ip netns exec ${connector_ns} ./pm_nl_ctl events >>
>> "$evts_ns2" 2>&1 &
>> +        evts_ns2_pid=$!
>>     fi
>>
>>     local local_addr
>> @@ -830,6 +839,8 @@ do_transfer()
>>     if [ $addr_nr_ns2 -gt 0 ]; then
>>         local add_nr_ns2=${addr_nr_ns2}
>>         local counter=3
>> +        local id=20
>> +        local tk da dp sp
>>         while [ $add_nr_ns2 -gt 0 ]; do
>>             local addr
>>             if is_v6 "${connect_addr}"; then
>> @@ -837,9 +848,23 @@ do_transfer()
>>             else
>>                 addr="10.0.$counter.2"
>>             fi
>> -            pm_nl_add_endpoint $ns2 $addr flags $flags
>> +            if [ $userspace_pm -eq 0 ]; then
>> +                pm_nl_add_endpoint $ns2 $addr flags $flags
>> +            else
>> +                tk=$(sed -n
>> 's/.*\(token:\)\([[:digit:]]*\).*$/\2/p;q' "$evts_ns2")
>> +                da=$(sed -n 's/.*\(daddr4:\)\([0-9.]*\).*$/\2/p;q'
>> "$evts_ns2")
>> +                dp=$(sed -n
>> 's/.*\(dport:\)\([[:digit:]]*\).*$/\2/p;q' "$evts_ns2")
>> +                ip netns exec ${connector_ns} ./pm_nl_ctl csf lip
>> $addr lid $id \
>> +                                    rip $da rport $dp token $tk
>> +                sleep 1
>> +                sp=$(grep "type:10" "$evts_ns2" |
>> +                     sed -n 's/.*\(sport:\)\([[:digit:]]*\).*$/\2/p;q')
>> +                ip netns exec ${connector_ns} ./pm_nl_ctl dsf lip
>> $addr lport $sp \
>> +                                    rip $da rport $dp token $tk
>> +            fi
>>             counter=$((counter + 1))
>>             add_nr_ns2=$((add_nr_ns2 - 1))
>> +            id=$((id + 1))
>>         done
>>     elif [ $addr_nr_ns2 -lt 0 ]; then
>>         local rm_nr_ns2=$((-addr_nr_ns2))
>> @@ -919,7 +944,9 @@ do_transfer()
>>     if [ $userspace_pm -eq 1 ]; then
>>         kill $evts_ns1_pid
>>         wait $evts_ns1_pid 2>/dev/null
>> -        rm -rf $evts_ns1
>> +        kill $evts_ns2_pid
>> +        wait $evts_ns2_pid 2>/dev/null
> 
> Would be nice to use the kill_wait function from "selftests: mptcp: avoid
> Terminated messages in userspace_pm" here. Can you send a squash-to for
> that "avoid Terminated messages..." commit that uses kill_wait?

It might be fine not to have this function as the only "kill + wait" we
have are here: just these two. It might then not be needed to create
this "kill_wait" helper in mptcp_join.sh.

But up to you :)

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
