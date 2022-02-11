Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC3237A
	for <mptcp@lists.linux.dev>; Fri, 11 Feb 2022 17:31:00 +0000 (UTC)
Received: by mail-ed1-f51.google.com with SMTP id s7so17583663edd.3
        for <mptcp@lists.linux.dev>; Fri, 11 Feb 2022 09:31:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=m9Bpe1JOhZ7o5HxdvB9DN7Ihga9XnvqaXO7wD0jAd9Q=;
        b=Fx6JT5rcC5vinQ5CEYsqeHewQ8A50Xt9yoyTb0TXMxTdTaK0FJmsvpcSaS4C2VAJKS
         Hw7gORfCUgdTgY01qCvtOh++9/6f05xBMyz0l0vOgof+tWyPvBDRtZLehrEdw4Lo/Rpg
         cVArui9lFvhQg75GEjsc9gineRAkmTFUYi7z2+faCIF7+tK+clhMed3GZAoSqDbKjril
         wJjpiecyW/Gviiq/0XGd6h5uYeOv8Oqn+KRO6TQioXjTbpOpfM4Jg2evA17VKXibYIlD
         5KuQ/jQF5zEYPZrwHNkn7CzGi4B7eHGqpipertIlXw/doyvN7w4TJv8vKOjtdqS147l1
         24Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=m9Bpe1JOhZ7o5HxdvB9DN7Ihga9XnvqaXO7wD0jAd9Q=;
        b=hbw3SYO9ioFkUY0uUzeiK/IPO/jOZPBJ1XDKVEAjE/YbXGPJzOrHeFc2qOtlVJ+dqL
         /HjeV9Xq2l3IGkG0nuZgc4krtPimeMvbW3n4zV/4i2QDRu1ryWhrDSVgP36KcaHBqOxD
         gvaCa9yK3872dh1jzHM35X+FCqyi+HEODS5s/7yfEE9Ns+GmaCRT0iOoL5uBQHq0HfoL
         1o1vBPkXEPi5UCLaeNq+unMoZSvgIZcY9ARRBkm7Q8FJV6P2x11aVjXxySb8ErySbrEa
         Y93Vs75IUm2MAJkOO5U4DIInrhyDLJYmvEi58S9mn0igRG/zF2oPZgcufcCgoMIT7SgI
         Z0Ug==
X-Gm-Message-State: AOAM533W5WBIwns6W5pvjU7DPodvErIxOAZZdMxOwVPpxftpN9TzWfzC
	SGKWc2qxGSyNfnZBwNJpEQiTcw==
X-Google-Smtp-Source: ABdhPJyYGOpyDZV+DQbJa+YdCUZLfRo3iP9MKwfu9yHzzU6xjaWUqNOB6NRCBNmdC14CCT0qhjygBQ==
X-Received: by 2002:a50:fd05:: with SMTP id i5mr3066293eds.181.1644600658780;
        Fri, 11 Feb 2022 09:30:58 -0800 (PST)
Received: from ?IPV6:2a02:578:8593:1200:fea5:b1fd:66cc:fe97? ([2a02:578:8593:1200:fea5:b1fd:66cc:fe97])
        by smtp.gmail.com with ESMTPSA id eo14sm7855088edb.46.2022.02.11.09.30.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Feb 2022 09:30:58 -0800 (PST)
Message-ID: <46a0d57f-4f9e-1313-1b29-70cfc48aab42@tessares.net>
Date: Fri, 11 Feb 2022 18:30:57 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH mptcp-next 1/9] selftests: mptcp: join: allow running -cCi
Content-Language: en-GB
To: Paolo Abeni <pabeni@redhat.com>, mptcp@lists.linux.dev
References: <20220209212520.2989291-1-matthieu.baerts@tessares.net>
 <20220209212520.2989291-2-matthieu.baerts@tessares.net>
 <71915c57b64e6f32480673c03a53a92a72f3fdd0.camel@redhat.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <71915c57b64e6f32480673c03a53a92a72f3fdd0.camel@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Paolo,

On 10/02/2022 15:53, Paolo Abeni wrote:
> On Wed, 2022-02-09 at 22:25 +0100, Matthieu Baerts wrote:
>> Without this patch, no tests would be ran when launching:
>>
>>   mptcp_join.sh -cCi
>>
>> In any order or a combination with 2 of these letters.
>>
>> Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
>> ---
>>  tools/testing/selftests/net/mptcp/mptcp_join.sh | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
>> index 66ac990415e6..9bbb95837f73 100755
>> --- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
>> +++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
>> @@ -2242,7 +2242,7 @@ for arg in "$@"; do
>>  	fi
>>  
>>  	# exception for the capture/checksum/ip_mptcp options, the rest means: a part of the tests
>> -	if [ "${arg}" != "-c" ] && [ "${arg}" != "-C" ] && [ "${arg}" != "-i" ]; then
>> +	if ! [[ "${arg}" =~ ^"-"[cCi]+$ ]]; then
>>  		do_all_tests=0
>>  	fi
>>  done
> 
> At this point I think it would be better consolidate argument parsing
> with getopts, and dropping the above regexp.
> 
> While parsing the test group selectors, we could build the list of 
> groups to be executed (possibly a string contaning all the function to
> be invoked), and run them after argument parsing - or run all if such
> list (string) is empty

I just applied the patches in our tree and saw this message after, sorry
about that.

Indeed, good idea, that would be the proper way to handle options!
It would also be good not to do anything if the -h option is given with
others.

I will try to remember about this idea next time I modify this part! I
can also remove this commit from our tree if you prefer.

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
