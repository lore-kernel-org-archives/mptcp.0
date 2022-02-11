Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A5D17A
	for <mptcp@lists.linux.dev>; Fri, 11 Feb 2022 17:34:51 +0000 (UTC)
Received: by mail-ed1-f50.google.com with SMTP id bx2so17515839edb.11
        for <mptcp@lists.linux.dev>; Fri, 11 Feb 2022 09:34:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=V6nbeZk6lpW/51LoM8HmDBd2jyyVbyVoNXnDY2ciqa0=;
        b=yi1lYEBHXfYeWUjTHJY6pjdZRPRAcyk4o5aIXDbnY0T2F4pEpbzCo2zWWSOyFaCZPQ
         6osl94gupuQrbgiroe311WTkLktiAYJqyhQ0FjKww3x4tWwNS8rBijih/OsTDbflI8h3
         Ga77iAyR71OPE2r2Hwu2Jm6lgP3qwO6Ry8VmlxBFpE+MCDPKEixh2ldIh4ccc3nvoS/h
         zg4QTruQezSTy9lKD86cd59Ur3ZW7PA5suvawNJjL9x5buKjSaLup+VQqcK6hvpB2w4Z
         2FFgFbLs0ChLIByZrV8vxjZ2ec2RqBg91zkkekkbw663rLeqiu/zz+uIDBwkieHCiMEc
         VvzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=V6nbeZk6lpW/51LoM8HmDBd2jyyVbyVoNXnDY2ciqa0=;
        b=VC/rEikQrU1l/kV7san6UWVv4ycxi543iLSl0OIh9FsP3Nd/xIFYRhV+8XIU5vFhW0
         bjm7OLgoocHevBxJIcxBYTSzzl03ZQSvDNR3djHk0qOAB9JaR8f1a344dGZylfcLYT5j
         aTUErve+Tw/l9dqIzGJlHMJWbH/cKKmeNX5FDodf3jpRbR3Cv1sg7VHeXrk/nbgx0pnm
         mDzRP0n4rMV0RWZv0bmVT5LqrqseEYcpQsLjc7wtp1I/SPTe8Zq71VX8sl+0JGD2z8px
         r70i9+y6Q2ZEsG0Sni9FbPTYrvubIJtj18wJoloYf1rhPaQ2CyxA04xVlwpevPUepnFx
         s7rA==
X-Gm-Message-State: AOAM530cuE/DCJYrjrnYeewJxNmmnIPgwaSqhv9q0SmJCnWtcAO3F1e5
	OzIEqnQG884dj62/q06t3TduJhLVDCjWaA==
X-Google-Smtp-Source: ABdhPJw4NsqAfH+Ta30Wcg5RDjVeHMm4VsDvBvAFcJivtLwUu7rO5ArYhd8EDKOWm2dpsVr1oGCkBQ==
X-Received: by 2002:a05:6402:49a:: with SMTP id k26mr3048917edv.143.1644600890048;
        Fri, 11 Feb 2022 09:34:50 -0800 (PST)
Received: from ?IPV6:2a02:578:8593:1200:fea5:b1fd:66cc:fe97? ([2a02:578:8593:1200:fea5:b1fd:66cc:fe97])
        by smtp.gmail.com with ESMTPSA id p5sm6446444ejr.105.2022.02.11.09.34.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Feb 2022 09:34:49 -0800 (PST)
Message-ID: <99f9d59b-5a0b-b618-f8ee-d12c9530cfef@tessares.net>
Date: Fri, 11 Feb 2022 18:34:49 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH mptcp-next 0/9] Refactor mptcp_join.sh
Content-Language: en-GB
To: Mat Martineau <mathew.j.martineau@linux.intel.com>
Cc: mptcp@lists.linux.dev
References: <20220209212520.2989291-1-matthieu.baerts@tessares.net>
 <fc54b044-53bd-60ed-5aa0-6e1dc460ef8@linux.intel.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <fc54b044-53bd-60ed-5aa0-6e1dc460ef8@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Mat, Paolo,

On 10/02/2022 01:22, Mat Martineau wrote:
> On Wed, 9 Feb 2022, Matthieu Baerts wrote:
> 
>> I started this series to be able to launch a specific test without
>> having to modify the script to comment tests from the subgroup I didn't
>> want to validate when trying to reproduce a specific issue in a loop.
>> That's what we can find in patch 3/9.
>>
>> While at it, I:
>> - fixed one issue with the options (patch 1/9)
>> - stop if an option doesn't exist (patch 2/9)
>> - removed unused vars (patch 4/9)
>> - delay some actions to the first test not to do them if no test is
>>  launched (patches 5-6/9)
>>
>> But after having seen all modified lines, why stopping there? So I:
>> - clarify local vs global variables to avoid Bash's classical pitfall
>>  (patch 7/9)
>> - fixed all issues reported by ShellCheck except one (patch 8-9/9)
>>
>> These last 3 patches (+ patch 3/9) will create a lot of conflicts. If
>> we are OK with them, probably best not to wait to long before applying
>> them to avoid big rebases.
> 
> I think 1, 2, 4, 5, and 6 look good for the export branch now:
> 
> Reviewed-by: Mat Martineau <mathew.j.martineau@linux.intel.com>

Thank you for the reviews!

I just applied these 5 patches to our tree with your RvB tag (and fixed
s/KSFT_SKIP/ksft_skip/g I left by mistake when splitting commits).

- 1e4cd0e4eae7: selftests: mptcp: join: allow running -cCi
- 251e4354c1c0: selftests: mptcp: join: exit after usage()
- 7e59a8ad9b44: selftests: mptcp: join: remove unused vars
- 739ef6848c45: selftests: mptcp: join: create tmp files only if needed
- 50c4db8022d3: selftests: mptcp: join: check for tools only if needed
- Results: 178780fe8241..dd0f23150c09

I will look at the other patches from this series later.

Builds and tests are now in progress:



https://cirrus-ci.com/github/multipath-tcp/mptcp_net-next/export/20220211T173324

https://github.com/multipath-tcp/mptcp_net-next/actions/workflows/build-validation.yml?query=branch:export

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
