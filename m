Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08F6C72
	for <mptcp@lists.linux.dev>; Wed, 28 Jul 2021 17:41:53 +0000 (UTC)
Received: by mail-ed1-f52.google.com with SMTP id n2so4314855eda.10
        for <mptcp@lists.linux.dev>; Wed, 28 Jul 2021 10:41:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20150623.gappssmtp.com; s=20150623;
        h=to:cc:references:from:subject:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=fUNGu9HxVSbUQuktCxJ7+TksvSemQ1jsSvLDfzzPfZ0=;
        b=bvXpxnNZjfBgdEiZlzFN+7ObcjVQC+Lr5nFQpc2QEfBorQ439ditEk67so8ARA8fgr
         8MyNMhLHZxQ6yPQnFUFKvGVY1p6jr4wTVQWjoMEzOPo1ajLnAmpNKiz54IPOySwvUEUP
         iqdxk6BDL349UyqTrNwG/midNWmGvDmgA3L7wrNM6MWc1k5q/k2NSizjP4EBby9rDGbZ
         eRCYr10oM6/wd/PyljUnWrXdSoDudvekNIvjqCG99eAoE41EqXP5mu8Xsl0TMdY5Sq5v
         L75Y43RqKbekvp8SKYim+YaBZmj0EaTA1r10rgpnlPEJgmyfjXFDtlfcEap37X9TMOTF
         VXsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:references:from:subject:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=fUNGu9HxVSbUQuktCxJ7+TksvSemQ1jsSvLDfzzPfZ0=;
        b=WC658jvmXXsIh6w5PdDfvG5TwcfK7Ly1PmJNCmYRFHrb3otfBIv/uGreQ81r25+r6K
         p4HNExV4E0wb8X2spt81Vxo+awAuA7r++eSx9cpJfsNZW3fYjjRGi/fFB9Pqjxa7d5dV
         q/jc5xYzmxDxVfVyTOesT+Uu+lovY53lqnVFrylCz7FpiG9SChnFeK78BM2dDlSQmklJ
         GxsNZ49MQ4pzhVB92WsRBm6TM8nDQJqY9jB8a+ZY7d3VjjBTD3pNbjhedXzsYO7eGQZl
         ni8FynGwHE0xlcDvhhnNEebX2qc8WYisj0Q5wEjf2MfLjEIy82PMCzrQ8kmyZHHmtvZI
         +cZw==
X-Gm-Message-State: AOAM532lO48YbU7cjDpdYbr/0L/EBL5SOClt+kzljrpFzg//HktHgfDM
	Bh9pFwJfpaBhPfZ2WzASWGMU65i9l/nCgg==
X-Google-Smtp-Source: ABdhPJzYl4apl8pXoI+Y2NZdh7IaQjS6kO3lUujMhOl8mi+b+zN7BclIhnGdZSxnxxG4hG2A/U9msA==
X-Received: by 2002:a05:6402:896:: with SMTP id e22mr1202999edy.246.1627494111950;
        Wed, 28 Jul 2021 10:41:51 -0700 (PDT)
Received: from tsr-lap-08.nix.tessares.net ([2a02:578:85b0:e00:c852:afa0:c279:c071])
        by smtp.gmail.com with ESMTPSA id n10sm133943ejk.86.2021.07.28.10.41.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Jul 2021 10:41:51 -0700 (PDT)
To: Paolo Abeni <pabeni@redhat.com>, Geliang Tang <geliangtang@gmail.com>
Cc: Geliang Tang <geliangtang@xiaomi.com>, mptcp@lists.linux.dev
References: <cover.1627391588.git.geliangtang@xiaomi.com>
 <703a40cb47f2f4c0ddb25bb61f97cfb4b973dc5e.1627391588.git.geliangtang@xiaomi.com>
 <87310b54d3987e94138953e171bad7b081b63df5.1627391588.git.geliangtang@xiaomi.com>
 <10a327d0ce8f917d17166ae7de561a8b2af23ff3.1627391588.git.geliangtang@xiaomi.com>
 <cb461bd9ebbbfda680c2d1fea3bc7467596e3d5d.1627391588.git.geliangtang@xiaomi.com>
 <44581bdbef617928052995d5e7ec0a6420023f9b.camel@redhat.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
Subject: Re: [MPTCP][PATCH v6 mptcp-next 4/5] selftests: mptcp: add fullmesh
 testcases
Message-ID: <2e7f9ac3-0ac4-24b7-5530-192362405467@tessares.net>
Date: Wed, 28 Jul 2021 19:41:50 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <44581bdbef617928052995d5e7ec0a6420023f9b.camel@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 8bit

Hi Geliang, Paolo,

Thank you for the new version.

On 28/07/2021 19:21, Paolo Abeni wrote:
> On Tue, 2021-07-27 at 21:24 +0800, Geliang Tang wrote:
>> From: Geliang Tang <geliangtang@xiaomi.com>
>>
>> This patch added the testcases for the fullmesh address flag of the path
>> manager.
>>
>> Reuse the above 10 address numbers for the fullmesh test.
>>
>> Signed-off-by: Geliang Tang <geliangtang@xiaomi.com>
>> ---
>>  .../testing/selftests/net/mptcp/mptcp_join.sh | 57 ++++++++++++++++++-
>>  1 file changed, 54 insertions(+), 3 deletions(-)
>>
>> diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
>> index 937e861e9490..2a27d6240f5b 100755
>> --- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
>> +++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
>> @@ -367,7 +367,13 @@ do_transfer()
>>  	fi
>>  
>>  	if [ $addr_nr_ns2 -gt 0 ]; then
>> -		let add_nr_ns2=addr_nr_ns2
>> +		if [ $addr_nr_ns2 -gt 10 ]; then

Maybe more explicit if we pass 'fullmesh-X' where X is the number of
addresses we need with the fullmesh flag.

  local flags="subflow"

  (...)

  if [[ "${addr_nr_ns2}" = "fullmesh-"* ]]; then
          flags="${flags},fullmesh"
          addr_nr_ns2=${addr_nr_ns2:9}
  fi

  if [ $addr_nr_ns2 -gt 0 ]; then
          counter=3
          (...)

This can also be fixed with a squash-to patch ;)

>> +			let add_nr_ns2=addr_nr_ns2-10
>> +			flags=subflow,fullmesh
>> +		else
>> +			let add_nr_ns2=addr_nr_ns2
>> +			flags=subflow
>> +		fi
>>  		counter=3
>>  		sleep 1
>>  		while [ $add_nr_ns2 -gt 0 ]; do
>> @@ -377,7 +383,7 @@ do_transfer()
>>  			else
>>  				addr="10.0.$counter.2"
>>  			fi
>> -			ip netns exec $ns2 ./pm_nl_ctl add $addr flags subflow
>> +			ip netns exec $ns2 ./pm_nl_ctl add $addr flags $flags
>>  			let counter+=1
>>  			let add_nr_ns2-=1
>>  		done
>> @@ -1697,6 +1703,46 @@ deny_join_id0_tests()
>>  	chk_join_nr "subflow and address allow join id0 2" 1 1 1
>>  }
>>  
>> +fullmesh_tests()
>> +{
>> +	# fullmesh 1
>> +	reset
>> +	ip netns exec $ns1 ./pm_nl_ctl limits 0 4
>> +	ip netns exec $ns2 ./pm_nl_ctl limits 1 4
>> +	ip netns exec $ns2 ./pm_nl_ctl add 10.0.2.2 flags subflow,fullmesh
>> +	ip netns exec $ns2 ./pm_nl_ctl add 10.0.3.2 flags subflow,fullmesh
>> +	run_tests $ns1 $ns2 10.0.1.1 0 1 0 slow
>> +	chk_join_nr "fullmesh test 1" 4 4 4
>> +	chk_add_nr 1 1
>> +
>> +	# fullmesh 2
>> +	reset
>> +	ip netns exec $ns1 ./pm_nl_ctl limits 1 3
>> +	ip netns exec $ns2 ./pm_nl_ctl limits 1 3
>> +	ip netns exec $ns1 ./pm_nl_ctl add 10.0.2.1 flags signal
>> +	run_tests $ns1 $ns2 10.0.1.1 0 0 11 slow
> 
> It still took me a bit follow topology creation here. I think a comment
> is deserved, the first time this kind of argument is used.

Good idea!

It could be good to also rename the tests: "fullmesh test [1234]" are
not very explicit.
It could be nice to put the topology there, e.g. "2x2", "2x2 w/ signal"? :)

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
