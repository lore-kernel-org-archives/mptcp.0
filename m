Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87AC828EE
	for <mptcp@lists.linux.dev>; Thu, 19 May 2022 16:07:54 +0000 (UTC)
Received: by mail-ed1-f47.google.com with SMTP id fd25so7583023edb.3
        for <mptcp@lists.linux.dev>; Thu, 19 May 2022 09:07:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=OzXyydPOTVDjWYogoevXwjZExc8KeM0IOZQMQ6+wwkY=;
        b=29UxiTElw20v8lJV4a+RbzrnExXyFvFbFNkY1NZFO1KH8c7HYQvYBBcDClAGJOv5C1
         UEuO5akgk6O4uNsJ3tQ2Ym28OWKzCM1gb8viDHiB+r4th1IGsk/hUpm4m7xqSr1iVhOQ
         354Bs56kAWocEWYcRsVq41oD3ZV06nSn9tbYOi86XfJxYXfxtDIC86S5xk5/y7S+We0q
         HaaZtym/c/5s+Z2zgHNh9vYOMVzysPU926i92Lz3wd4BvypwOZK54lNA55c0DajGSRIV
         FaJIWaRVkzNgSjXlrEmf1dj9TMbDApL0KYTI0EJ8j3g/dpU9fhJxFPj0QLRKpjK/Njy3
         1sZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=OzXyydPOTVDjWYogoevXwjZExc8KeM0IOZQMQ6+wwkY=;
        b=ywDm6x80nNkAAfI+bZjW3v8tMIyakmt5gsEyjTAQ7fucV8UWnmz+1M+NLRhML6Q8va
         p5m2yOx4ZeNM4DPq334clL7+npn1fC8wodT52AHmDZDF7rl6DDjYd8/8u/Q6sbw/ouS0
         7ecZgGR7qDrBt2iz+IPoTHLWLV9MHydat/nE+KCW8z+9NVkIy/vSWM44KvGmK3Hq8qKF
         Dx0izR87dQHo6mKuOPfkc4pFhUhCUNmpIeSSpdqhAZYvv/aBCLAQ7tVT9xzOMB5yqrij
         duON+csShf29tbnw8XNv2UHHvjfn9rIjQdesdGnj3WxlMO5op2EH4iWZ3ti3JfIr6lUO
         8q5Q==
X-Gm-Message-State: AOAM5304+hLKr5TI4J6RK4dnSO3vCpkolKACfhSXMcpaBxFWlSZzjMpB
	wTmXECUD4v5fnQQVfHgSjdYtuA==
X-Google-Smtp-Source: ABdhPJzZd3Y3Cwgkv22yTJDqscBxaEsjufmnQKDzsgxDksihRBI448TCRYuM9fXYAceK9NUxcLL4dQ==
X-Received: by 2002:a05:6402:2547:b0:428:1dd3:2751 with SMTP id l7-20020a056402254700b004281dd32751mr6042393edb.87.1652976472469;
        Thu, 19 May 2022 09:07:52 -0700 (PDT)
Received: from ?IPV6:2a02:578:8593:1200:dd49:d598:4fbc:6d53? ([2a02:578:8593:1200:dd49:d598:4fbc:6d53])
        by smtp.gmail.com with ESMTPSA id v1-20020aa7dbc1000000b0042aa34f9e72sm2976359edt.34.2022.05.19.09.07.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 May 2022 09:07:52 -0700 (PDT)
Message-ID: <62bbf9e4-5d5f-ffc7-b28a-5e9556010cd3@tessares.net>
Date: Thu, 19 May 2022 18:07:51 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH mptcp-next 01/17] mptcp: move MPTCPOPT_HMAC_LEN to
 net/mptcp.h
Content-Language: en-GB
To: Mat Martineau <mathew.j.martineau@linux.intel.com>,
 Geliang Tang <geliang.tang@suse.com>
Cc: mptcp@lists.linux.dev
References: <cover.1652853898.git.geliang.tang@suse.com>
 <9128762ee54d7f8f5755067bbdd7511e1ead1f1a.1652853898.git.geliang.tang@suse.com>
 <6c1c291b-43d8-6e86-fcae-582a9ca5632@linux.intel.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <6c1c291b-43d8-6e86-fcae-582a9ca5632@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Geliang, Mat,

On 19/05/2022 17:06, Mat Martineau wrote:
> On Wed, 18 May 2022, Geliang Tang wrote:
> 
>> Move macro MPTCPOPT_HMAC_LEN definition from net/mptcp/protocol.h to
>> include/net/mptcp.h.
>>
>> Signed-off-by: Geliang Tang <geliang.tang@suse.com>
> 
> This one's fine for the mptcp tree (will upstream to net-next):
> 
> Reviewed-by: Mat Martineau <mathew.j.martineau@linux.intel.com>

Thank you for the patch and the review!

Now in our tree (feat. for net-next) with Mat's RvB tag:

New patches for t/upstream:

- e4afdbb036ca: mptcp: move MPTCPOPT_HMAC_LEN to net/mptcp.h

- Results: 086d4a4a0f34..52d9427a77d9 (export)

Builds and tests are now in progress:



https://cirrus-ci.com/github/multipath-tcp/mptcp_net-next/export/20220519T160645

https://github.com/multipath-tcp/mptcp_net-next/actions/workflows/build-validation.yml?query=branch:export

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
