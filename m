Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0563168
	for <mptcp@lists.linux.dev>; Wed, 15 Dec 2021 10:38:29 +0000 (UTC)
Received: by mail-ed1-f42.google.com with SMTP id x15so74013709edv.1
        for <mptcp@lists.linux.dev>; Wed, 15 Dec 2021 02:38:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=541BD4LzwzVB+tqORaSz3q3lS4ZI30J8m1m3s3oKT1o=;
        b=3xFMr1qeXKbb/SMLY6em6/Mm7R+SAYmGrFH83PcUkDDIo4mCeEht5PciKFT76VDohe
         glmhvjNh3I/K6PjCsGeTHwT/FaMSzJPtB0GcHPcqXAHr8DVmPEgTW65EjjS1TOTUEH5P
         cwSwha36LqaXGOiXLuOoQnN+R5+X5RmQpdWHqNJq8O93r5keTrPHVBfj7oopktIzf1Xr
         d6k7m4f9IRDKitXL2ZA3j7CUQRJTM3Yp0Hf8loD9t1Ti2xf5cLRvyrDoixF4zqQtnAIY
         fNflXX/FTIamP5pF2qwwnE0qz2oi9yAAYMz3bS+mlC9+NuabS41QJdbtAC5EC5hQjnYa
         MEXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=541BD4LzwzVB+tqORaSz3q3lS4ZI30J8m1m3s3oKT1o=;
        b=jibF0iUsUfSXFs18Op0VpoH1bXyzWmTPLPuotCc4M4MMzrAyivPgGqFbVpc+xTgn8A
         NVj5YakHzsWRyCsuENBU4zjsCl8v4s1whIrjbLXdcNWKhY2ccWe1acSbU4BOzkHnpLN0
         VUej9jzISLuHepUdUPdZ3MPaCujL7smxNcwY37GWRa8DvcWE5xDEJKrVvBo5aJnNxhxP
         MwoXSC8eyRppg7bTi2kr/iG/uIP+Ccz0NQ+Gd4eZxm7cQ1oo7NIrxM8A7zVj+v2CkdX+
         Lk+8LwVxpPCUNxXwM2nHVT2KOezJnFqk1oHuxmPidHpxhxJ7L0yVw41IB0pV0F4TGH/n
         zJRw==
X-Gm-Message-State: AOAM531y+hwdCwkPYZNDkY3UHe+zjHHm9MIA5pALGKxo10SdXqrZ3jmL
	TmGr89yPIUyxI4tayJayMlgSSby0cY7wvA==
X-Google-Smtp-Source: ABdhPJzR3WoQb4fp5HibzIioSJjj5uOMHjd4N9tpFCbUdaW88zVPe8PAjPxhUrD412mkF5uiyBMASg==
X-Received: by 2002:a17:906:d797:: with SMTP id pj23mr10017342ejb.765.1639564701963;
        Wed, 15 Dec 2021 02:38:21 -0800 (PST)
Received: from [192.168.178.33] (94.105.100.208.dyn.edpnet.net. [94.105.100.208])
        by smtp.gmail.com with ESMTPSA id eg8sm785684edb.75.2021.12.15.02.38.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Dec 2021 02:38:19 -0800 (PST)
Message-ID: <88e3c0e9-f2b2-79bd-db22-84360a6c3894@tessares.net>
Date: Wed, 15 Dec 2021 11:38:19 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH v2 mptcp-next] selftests: mptcp: more stable join
 tests-cases.
Content-Language: en-GB
To: Paolo Abeni <pabeni@redhat.com>, mptcp@lists.linux.dev
References: <b6f8d2e06bfa3b15cc7fa0ac3076cfafd7448b07.1639482622.git.pabeni@redhat.com>
 <f86282ac-0bb4-7190-75d1-5d975016e591@tessares.net>
 <767e837adad000e70c0f00e420b22d87d564fe32.camel@redhat.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <767e837adad000e70c0f00e420b22d87d564fe32.camel@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 15/12/2021 11:23, Paolo Abeni wrote:
> On Wed, 2021-12-15 at 10:11 +0100, Matthieu Baerts wrote:
>> Hi Paolo,
>>
>> On 14/12/2021 12:51, Paolo Abeni wrote:
>>> MPTCP join self-tests are a bit fragile as they reply on
>>> delays instead of events to catch-up with the expected
>>> sockets states.
>>>
>>> Replace the delay with state checking where possible and
>>> reduce the number of sleeps in the most complex scenarios.
>>>
>>> This will both reduce the tests run-time and will improve
>>> stability.
>>
>> Again, thank you for looking at that!
>>
>>>
>>> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
>>> ---
>>> v1 -> v2:
>>>  - fix ipv6 addr handling
>>> ---
>>>  .../testing/selftests/net/mptcp/mptcp_join.sh | 65 ++++++++++++++-----
>>>  1 file changed, 49 insertions(+), 16 deletions(-)
>>>
>>> diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
>>> index 8f49bbd4a201..7014391d750e 100755
>>> --- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
>>> +++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
>>> @@ -238,6 +238,42 @@ is_v6()
>>>  	[ -z "${1##*:*}" ]
>>>  }
>>>  
>>> +# $1: ns, $2: port
>>> +wait_local_port_listen()
>>> +{
>>> +	local listener_ns="${1}"
>>> +	local port="${2}"
>>> +
>>> +	local port_hex i
>>> +
>>> +	port_hex="$(printf "%04X" "${port}")"
>>> +	for i in $(seq 10); do
>>
>> I think it is safe to increase the number of iterations. Most of the
>> time, we will never reach the maximum.
>>
>>> +		ip netns exec "${listener_ns}" cat /proc/net/tcp* | \
>>> +			awk "BEGIN {rc=1} {if (\$2 ~ /:${port_hex}\$/ && \$4 ~ /0A/) {rc=0; exit}} END {exit rc}" &&
>>> +			break
>>> +		sleep 0.1
>>> +	done
>>
>> Probably here, we should exit with an error, no?
> 
> No, it's better to let the caller fail, so we get better/more
> consistent error reporting.

Would it not be a useful hint to see an error like:

  Error: expected to find port ${port} in listen mode

> This code is copied verbatim from mptcp_connect.sh, I think we don't
> want to introduce differences.

Indeed but we can also modify the original one if needed :)

>>> +}
>>> +
>>> +# $1: ns, $2: endpoint id
>>> +wait_address_deleted()
>>> +{
>>> +	local ns="${1}"
>>> +	local addr="${2}"
>>> +	local cnt
>>
>> May you declare "i" as local too please?
> 
> wait_address_deleted() is bugged and the source of the reported
> failures. I'm rewriting it.

Thank you for looking at that!

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
