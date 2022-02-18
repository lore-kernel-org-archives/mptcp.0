Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0BEB48A3
	for <mptcp@lists.linux.dev>; Fri, 18 Feb 2022 10:40:07 +0000 (UTC)
Received: by mail-ej1-f41.google.com with SMTP id a8so13990557ejc.8
        for <mptcp@lists.linux.dev>; Fri, 18 Feb 2022 02:40:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=3no1OkXIcYGVoCLgg6Tz6L9gjdFetgcwVXZ9QnK/ut8=;
        b=k3zOYWwb3zwFz9xHmNUeGtvLiO09Tee+vx04jvBePPTGCsl8bxZzlZ3qri5Loj7hE8
         MIlSLQWLGhH8M5ffubRY8fvy/GQNf+ufzZ7yIQ8ftzl3RL94BC547dLjbecSS5SwI57T
         rim2vqbE/uLjS9h4jC/tbb0Gwg2D8s0LPAaI9H+Fj8apRE8Lrj2nsKEG2t/SMTrR5pap
         iV75x7VPLyS5zV+gh4kpyxTGXqngIYs0yRysrDa1n+0ZZ7lLzXcGwqZr8JIwMcnnRxJz
         0LHXbvs9NIbL27J/vlMRuqJsgmghwL2SyBhbEQPh3EWhCfgTnUrKtUQl1ztCz7N8QTB4
         bMxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=3no1OkXIcYGVoCLgg6Tz6L9gjdFetgcwVXZ9QnK/ut8=;
        b=OsLZlhRcz/WKkviT5MG0sLueq6NDrFlD3yyh87oEVmhWHiAbj1SThTH3hK+l5B0yV2
         FEfbphy6GNJV7QyYiKeyet7xg0wqKrJg4Zp/rVYafoaza/Odb86O4umdwqVXm9zroAoF
         GBC0pJgwLPqwyvDPhBk3OiKkNUoWIdBpi4tmJnGWgO8YhrfV0dxXUJGWMJuVG5g//H7Z
         LQxOAzOsR9embNXbO1efkjkHXNOfz8Ybtk0hcfRyDEB9jlWkehksd3G8O2PAAWuETyGw
         doFchPV30flmMBAVRJL07pGoNHzt9DGbtbBTRIPW7YO2hkNfh0wETphgSMA2A4+4iSuc
         PP9g==
X-Gm-Message-State: AOAM530yJTDuz+3r9y2ujegnAxZH/CI7u0Bv3tw8g1qYXgvbMraJq0EI
	PBnn2hpDcHa+LZvPBhDCtt5NgUhPHGDNL+lr
X-Google-Smtp-Source: ABdhPJxsM2xJHGKkzM4XQuAhsqIrTL6V41hWryZASSJegZWDhgqLefu98w4Qg8NOlp28FQSD0A/AHw==
X-Received: by 2002:a17:907:2bd1:b0:6ce:484:f653 with SMTP id gv17-20020a1709072bd100b006ce0484f653mr5847049ejc.391.1645180805611;
        Fri, 18 Feb 2022 02:40:05 -0800 (PST)
Received: from [10.44.2.26] ([81.246.10.41])
        by smtp.gmail.com with ESMTPSA id p12sm1601845edc.49.2022.02.18.02.40.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Feb 2022 02:40:05 -0800 (PST)
Message-ID: <1bd2f732-a158-ebc9-3360-61a2ff115e00@tessares.net>
Date: Fri, 18 Feb 2022 11:40:04 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH mptcp-next v2 5/9] selftests: mptcp: join: alt. to exec
 specific tests
Content-Language: en-GB
To: Mat Martineau <mathew.j.martineau@linux.intel.com>
Cc: mptcp@lists.linux.dev
References: <20220217174329.826430-1-matthieu.baerts@tessares.net>
 <20220217174329.826430-6-matthieu.baerts@tessares.net>
 <5a7dabe8-c4bf-99d0-4b8e-96c6823ba8f7@linux.intel.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <5a7dabe8-c4bf-99d0-4b8e-96c6823ba8f7@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Mat,

On 18/02/2022 01:35, Mat Martineau wrote:
> On Thu, 17 Feb 2022, Matthieu Baerts wrote:
> 
>> Running a specific test by giving the ID is often what we want: the CI
>> reports an issue with the Nth test, it is reproduceable with

(should be "reproducible")

>> ./mptcp_join.sh N
>>
>> But this doesn't work when a test is unstable and it is needed to find
>> since when it is unstable because the ID is a counter and new tests can
>> be added before changing the ID of a specific test.
>>
> 
> Could you rephrase or split up this sentence to make it easier to parse?

Wow, I was really tired when I wrote and even reviewed that :)

I hope the following text is better:

 But this might not work when there is a need to find which commit has

 introduced a regression making a test unstable: failing from time to

 time. Indeed, a specific test is not attached to one ID: the ID is in

 fact a counter. It means the same test can have a different ID if other

 tests have been added/removed before this unstable one.

> 
>> Remembering the current test can also help listing failed tests at the
>> end.
>>
>> Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
