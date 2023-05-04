Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65CF57E
	for <mptcp@lists.linux.dev>; Thu,  4 May 2023 13:07:06 +0000 (UTC)
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-3062db220a3so324137f8f.0
        for <mptcp@lists.linux.dev>; Thu, 04 May 2023 06:07:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1683205624; x=1685797624;
        h=content-transfer-encoding:in-reply-to:references:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zpwvCE33ee5dWfyPd6MmQrVsyZybqNQ/XeoqgO+Bl28=;
        b=jyLVHkwrWxGUYKTHDKIkE3NJKOcCyZydNGsiut2LQHIJ+/JdvTJDVfkbdTqSeI2SbO
         hxXLvWmF1xjuZE8WsMp1l2jm/duUw/YPrTb8EVGZQpEpMChFE9BGwdhrvjkhskiWVqHR
         mIFsMuq7qK52JQ7Y2qAPg8XB7JKB47gpNSVKNnFmYnekKnMuNqwyYgAgTw3Dl/GbzFUq
         WMMaTSPCJXqxuGCD3kmvKEw8bmCSOBmU4kM012MbrO5h0s4TpIV5+uFZLlrHHlTVf7sQ
         lYNkiAUO4btRMQ1lO0Fc2EvSutlKjqGjSMaR/j9pAsK88s9xU1NDU5Ta+6MKs1On7klI
         chXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683205624; x=1685797624;
        h=content-transfer-encoding:in-reply-to:references:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zpwvCE33ee5dWfyPd6MmQrVsyZybqNQ/XeoqgO+Bl28=;
        b=RykzD3nVg6ezw/Kdfy2OnkWwT/42goWjcRY7xW2kxdISOOehYDwmhMzBh/EcPBl/r4
         gctLRKPHbJDole2y9E914dohecCDQXqWWLZPbRgCBh7EPNKmel0TojsHHwx5uZYGN6w9
         0bndnZDN40sER+utaP5tKRqVioSkvry35E+svBEGLel7bNc7zuQoc1WUMgU8OiKo8uOC
         22fH8ms2No6f3da3AoLh7CrtYNruGbTnSLe7fIm4nCgecdETZN+MGSYVJyFeb8dqOV5a
         yLtvJ5wNSazLcvWj5yzLZK//bpgF1g7633jQ5jBsI7LDb3z1zAMvmXcf9Pky3K3IkjZD
         SnAQ==
X-Gm-Message-State: AC+VfDzmKbuBnXY+srSDiXv3/g0NRtv3hCEA3e0gRx2Nbf7baVFOK1As
	w1S6lSCw4CywPQMCcVQSScVzNWb3TrEExg/4nEg=
X-Google-Smtp-Source: ACHHUZ68yaMrMzLSXF1pAjeLLwldkxVI+dN4Evc0KISf38Rsfxd7+TRVxaRVpsOXRADirD9/ajRrDg==
X-Received: by 2002:a05:6000:50f:b0:2f4:9f46:6865 with SMTP id a15-20020a056000050f00b002f49f466865mr2565020wrf.30.1683205624432;
        Thu, 04 May 2023 06:07:04 -0700 (PDT)
Received: from ?IPV6:2a02:578:8593:1200:6b04:8b76:7dd3:7b25? ([2a02:578:8593:1200:6b04:8b76:7dd3:7b25])
        by smtp.gmail.com with ESMTPSA id h16-20020a5d5490000000b00304b5b2f5ffsm18545296wrv.53.2023.05.04.06.07.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 May 2023 06:07:04 -0700 (PDT)
Message-ID: <4873cb19-a65a-72a8-2932-0a4a8887ed16@tessares.net>
Date: Thu, 4 May 2023 15:07:03 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH mptcp-next v10 2/6] selftests: mptcp: update userspace pm
 addr tests
Content-Language: en-GB
From: Matthieu Baerts <matthieu.baerts@tessares.net>
To: Geliang Tang <geliang.tang@suse.com>, mptcp@lists.linux.dev
References: <cover.1682499136.git.geliang.tang@suse.com>
 <2663cbe9ab1203202f2ae587475abc36fa93e4fb.1682499136.git.geliang.tang@suse.com>
 <658236c6-dd35-dd20-b72a-8794fab1d36a@tessares.net>
In-Reply-To: <658236c6-dd35-dd20-b72a-8794fab1d36a@tessares.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Geliang,

On 03/05/2023 19:33, Matthieu Baerts wrote:
> Hi Geliang,
> 
> On 26/04/2023 10:56, Geliang Tang wrote:
>> This patch is linked to the previous commit ("mptcp: only send RM_ADDR in
>> nl_cmd_remove").
>>
>> To align with what is done by the in-kernel PM, update userspace pm addr
>> selftests, by sending a remove_subflows command together after the
>> remove_addrs command.
>>
>> Fixes: d9a4594edabf ("mptcp: netlink: Add MPTCP_PM_CMD_REMOVE")
>> Fixes: 97040cf9806e ("selftests: mptcp: userspace pm address tests")
>> Signed-off-by: Geliang Tang <geliang.tang@suse.com>
>> ---
>>  tools/testing/selftests/net/mptcp/mptcp_join.sh | 8 ++++++++
>>  1 file changed, 8 insertions(+)
>>
>> diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
>> index 26310c17b4c6..67d5d724266a 100755
>> --- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
>> +++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
>> @@ -850,6 +850,14 @@ do_transfer()
>>  				ip netns exec ${listener_ns} ./pm_nl_ctl ann $addr token $tk id $id
>>  				sleep 1
>>  				ip netns exec ${listener_ns} ./pm_nl_ctl rem token $tk id $id
> 
> Out of curiosity, why did you have to move this command before the
> destruction of the subflow (just below)? Is it because since v10, we
> cannot remove the subflow if the subflow has been destroyed?
> 
> For the moment, I guess it is OK because if I'm not mistaken, we don't
> check that the subflow destruction has been done, right?
> 
> If at some points we do verify the following command is doing what we
> expect to do, my fear is that the next command might not work if we are
> unlucky: when the RM_ADDR from the previous step will be received, the
> other peer will destroy the associated subflows, no? If yes and if it is
> done quicker than launching the following command, the subflow could
> already be destroyed and the following command might fail, no?
> 
> Maybe that's not an issue because we don't check for errors in pm_nl_ctl
> (which is maybe not a good thing but that's another problem). So fine to
> keep this like that, right?

Does what I saying above correct: the next command could fail but that's
fine because we ignore errors?

>> +				sp=$(grep "type:10" "$evts_ns1" |
>> +				     sed -n 's/.*\(sport:\)\([[:digit:]]*\).*$/\2/p;q')
>> +				da=$(grep "type:10" "$evts_ns1" |
>> +				     sed -n 's/.*\(daddr6:\)\([0-9a-f:.]*\).*$/\2/p;q')
>> +				dp=$(grep "type:10" "$evts_ns1" |
>> +				     sed -n 's/.*\(dport:\)\([[:digit:]]*\).*$/\2/p;q')
>> +				ip netns exec ${listener_ns} ./pm_nl_ctl dsf lip "::ffff:$addr" \
>> +							lport $sp rip $da rport $dp token $tk
>>  			fi
>>  
>>  			counter=$((counter + 1))
> 
> Cheers,
> Matt

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
