Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6884C2C80
	for <mptcp@lists.linux.dev>; Wed,  9 Feb 2022 09:23:59 +0000 (UTC)
Received: by mail-ej1-f46.google.com with SMTP id k25so5446072ejp.5
        for <mptcp@lists.linux.dev>; Wed, 09 Feb 2022 01:23:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=apvVgoZvEmcNwSVEsggJrG2EvZUFR0w8QFAsx1BviD0=;
        b=cWx6z05TDhC7AJVLHrrX5FxzuA+rj6aTLhL3Yh78My08bu+KyHlqUnYYbcSa0rGY/u
         lKAA2knfUFABUFiv7ppmsjkqCNgqs9QsjtsN0git5b33SFNFoTAMiAJSXAH+BOgGWFxt
         ICWRWPvjcCI5R8hTCb+um6e4eoioFv9AGeac+8a5zTFiN1Ilbg3qwXsx6obPNRv8Szga
         ZL+3I9qx6OLkxe9pujB9UGszM8pK5jfI6xDIO9RAjWKoTKQC6BexCaNEzL5wnknfli5f
         84RGZY497nbZZrVM9w9yiybhteq794QrMvbq71S4KrBZOV/DDteItIf1vj7szCAUbM8Y
         Zw+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=apvVgoZvEmcNwSVEsggJrG2EvZUFR0w8QFAsx1BviD0=;
        b=wji/5PMNUT6pRCna46lsvi0kSh4nPUH/Mi+zBx1ylrpyGyhEuOyTyfdoqx3QvfAPx7
         W4Ubp5hUP1SmKeUjPEHkyp0GGvZAYz5r6MBsVKgDiUrulAqz5ooVrVyvOHEkprmj/rPY
         u0gN7stElE+YIZT2ULOTEFK4gpeLCOh8J7DsOPrXsZenPfugDL0pNjqzeHjJZiwrCoKJ
         YPnZEfk5yBSDDICRJELM9VfmSCUJiTHmxRwt7k+QqjTIvhTyyLD+Fis5Bc2DPXp3qFTq
         CNmkshwuEt7ya+818OqpwKGz+XH3ExTjwn1jPFCDH3NAI9wxmA6NKNc2Ek158W/BSfX6
         1Nnw==
X-Gm-Message-State: AOAM533G8s7e8YvVmAnG5rddZLLscltb58pLur+4PXMUyJ/fuMEWiVWg
	KI3mzf2gV/GAXExp/B4jB3bqYSE5H9ijrqUa
X-Google-Smtp-Source: ABdhPJyFP8UuBEAQYv66LS21/4it7XgTu7vV9fjaV+jQKwM3CG7rRbPT6fQoLXE0741jbKdmB43nxg==
X-Received: by 2002:a17:907:1c02:: with SMTP id nc2mr1154117ejc.661.1644398634178;
        Wed, 09 Feb 2022 01:23:54 -0800 (PST)
Received: from ?IPV6:2a02:578:8593:1200:268e:dc63:f3ef:de99? ([2a02:578:8593:1200:268e:dc63:f3ef:de99])
        by smtp.gmail.com with ESMTPSA id g6sm5892468ejz.170.2022.02.09.01.23.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Feb 2022 01:23:53 -0800 (PST)
Message-ID: <55e50da5-25ec-3a66-6264-10d712c5ba6e@tessares.net>
Date: Wed, 9 Feb 2022 10:23:52 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH mptcp-next v4 5/5] selftests: mptcp: add mp_fail testcases
Content-Language: en-GB
To: Geliang Tang <geliang.tang@suse.com>, mptcp@lists.linux.dev
Cc: Davide Caratti <dcaratti@redhat.com>
References: <cover.1644396927.git.geliang.tang@suse.com>
 <7b3e19b0e0b8c3b651320897b25464e0f76806ff.1644396927.git.geliang.tang@suse.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <7b3e19b0e0b8c3b651320897b25464e0f76806ff.1644396927.git.geliang.tang@suse.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Geliang,

On 09/02/2022 09:57, Geliang Tang wrote:
> Added the test cases for MP_FAIL, the multiple subflows test for the MP_RST
> case and the single subflow one for the infinite mapping case.

Thank you for the new version!

> These tests used the new test_linkfail value 3 to make 512KB test files for
> both the client and server.
> 
> Added a new function reset_with_fail(), in it use 'iptables' and 'tc
> action pedit' commands to trigger the checksum failures.
> 
> Added a new global variable pedit_action to trace whether the tc pedit
> action happened during the test. Check and set it in the new function
> pedit_action_happened(). Show it in the test description and pass it to
> chk_join_nr() to check the numbers of the checksum failures, MP_FAIL

Related to my comment in the v2: I don't think it is a good idea to pass
it to chk_join_nr(): we expect an MP_FAIL, we should not ignore it if it
was not there.

(...)

> +	ip netns exec $ns2 $tables \
> +		-t mangle \
> +		-A OUTPUT \
> +		-o ns2eth$i \
> +		-p tcp \
> +		-m length --length 150:9999 \
> +		-m statistic --mode nth --packet 1 --every 99999 \
> +		-j MARK --set-mark 42
> +	if [ $? -ne 0 ];then
> +		echo "SKIP: Couldn not add the $tables rule"
> +		exit $ksft_skip
> +	fi

Related to my comment in the v2: I think we should exit with an error if
the IPTables command fails.

  (...)
  -j MARK --set-mark 42 || exit 1

The error message from IPTables should be enough I think.

In Mat's case, it was confusing because the test continued and even
succeeded!

> +
> +	tc -n $ns2 qdisc add dev ns2eth$i clsact
> +	tc -n $ns2 filter add dev ns2eth$i egress \
> +		protocol ip prio 1000 \
> +		handle 42 fw \
> +		action pedit munge offset 148 u8 invert \
> +		pipe csum tcp \
> +		index 100

Same for these two tc commands, we can add "|| exit 1".

(...)

> +pedit_action_happened()
> +{
> +	local i="$1"
> +
> +	local action=$(tc -n $ns2 -j -s action show action pedit index 100)
> +	local packets=$(echo $action | jq '.[1].actions[0].stats.packets')
> +
> +	if [ $packets != "null" ] && [ $packets -gt 0 ]; then
> +		pedit_action=1
> +	fi
> +	tc -n $ns2 qdisc del dev ns2eth$i clsact

It is a good idea to keep this just in case there was an issue with TC.
But then, I think we should print the number of packets, that's enough no?

(also we don't need to delete the clsact, it will be removed when the NS
will be removed)

So it would be enough to have:

--------
pedit_action_pkt()
{
    tc -n $ns2 -j -s action show action pedit index 100 | \
        jq '.[1].actions[0].stats.packets'
}

(...)

chk_join_nr "MP_FAIL MP_RST: $(pedit_action_pkt) corrupted pkt" 2 2 2 1 1
--------

We can even remove the dependence to 'jq' for this simple command:

    tc -n $ns2 -j -s action show action pedit index 100 | \
        sed 's/.*"packets":\([0-9]\+\),.*/\1/'

WDYT?

> +fail_tests()
> +{
> +	# multiple subflows
> +	reset_with_fail 2
> +	pm_nl_set_limits $ns1 0 2
> +	pm_nl_set_limits $ns2 0 2
> +	pm_nl_add_endpoint $ns2 10.0.2.2 dev ns2eth2 flags subflow
> +	pm_nl_add_endpoint $ns2 10.0.3.2 dev ns2eth3 flags subflow
> +	run_tests $ns1 $ns2 10.0.1.1 3
> +	pedit_action_happened 2
> +	chk_join_nr "MP_FAIL MP_RST: $pedit_action pedit action" 2 2 2 \
> +		$pedit_action $pedit_action

Related to my comment in the v2: we should not use $pedit_action in the
args we need to verify I think. Instead we should probably then have:

  chk_join_nr "(...)" 2 2 2 1 1

> +
> +	# single subflow
> +	reset_with_fail 1
> +	pm_nl_set_limits $ns1 0 2
> +	pm_nl_set_limits $ns2 0 2
> +	run_tests $ns1 $ns2 10.0.1.1 3
> +	pedit_action_happened 1
> +	chk_join_nr "MP_FAIL infinite map: $pedit_action pedit action" 0 0 0 \
> +		$pedit_action 0 $pedit_action

Same here:

  chk_join_nr "(...)" 0 0 0 1 0 1

No?

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
