Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74CD72C80
	for <mptcp@lists.linux.dev>; Fri, 28 Jan 2022 16:45:04 +0000 (UTC)
Received: by mail-wr1-f45.google.com with SMTP id w11so11984580wra.4
        for <mptcp@lists.linux.dev>; Fri, 28 Jan 2022 08:45:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=QEhEGOSqEmWHsJESar2BWKetGa7cWQGVKs3aVaYaAT4=;
        b=fj4wTzdA3HxmR0qnzB29X1Skxz/xawiDiZIcbs9mbnBJYnHOMMANZY/aWfxcgnELxj
         DKv4nAngE0S0hqkmnDTtl9vjdYRz9tmmZOCUplVsnXK+cjsXcQ/m7PAv3TjEo3nsK/78
         VpwtwShuh2XxbzazCqpQTcV8oCSu4cgkIfCQ+gSKgJSZYBZeI6YmiK+KcIDjd1BRe7jO
         GlZ2F3FzKXMFWfwjjveL/Ij1ADAhWtYnlhtu2GDUIRbvgkbAG1cdyYJ2p40BA6DxGICw
         3wHwRWtMDkiAi9bsdiUfrfPB9UywIH8/YUvqINWJOtuDHkGk4Z6YhLobhDTL2z6/45cK
         8VgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=QEhEGOSqEmWHsJESar2BWKetGa7cWQGVKs3aVaYaAT4=;
        b=utyqLFGqgbKy0J6zoAGcPT7xiqq7DxAloFqSj2nq4I5QnyoTKdMwtq+uYoypY9VoSE
         9nFx4njt/IYJeHEVa6Z9GKWp2e8Fjs4I6OZ4368GxrRMyaS9aZR4Bh9zkNG1KLeI6iyl
         tKDxMODC7dEDEVQWmuCkmkns96s4TkcG/5ixkKFT3nodWry1gopJQG/zRJBwfPUHYPfe
         l84s+8mdFEmxZPTkC94tvqtgaYkaxgtFRTXpdWmC34ybkshCrVn3Q8691MYOtzPpcOEV
         NIr7KEgnBRNqmcuQfZ9INqDgNJWtlS+8QLy8I4i9C9tdk7F7GeZrFjPJFPhpyGd6qnhG
         6wbw==
X-Gm-Message-State: AOAM532cxkmvc/JkgisQN3B1IHKIGni31Q2TVWUFSr6qKLlXQFqQlPzJ
	Nweie4ibM36+96/zZBdMBP2EDg==
X-Google-Smtp-Source: ABdhPJxaIxglm2hnB9497kN/8O2j4w8OQvPYjJS6xKPmqPhj0+TERv4WLdt9OajbYHvKpKvT8yk8BA==
X-Received: by 2002:adf:9d92:: with SMTP id p18mr7860067wre.137.1643388302269;
        Fri, 28 Jan 2022 08:45:02 -0800 (PST)
Received: from [10.44.2.26] (84-199-106-91.ifiber.telenet-ops.be. [84.199.106.91])
        by smtp.gmail.com with ESMTPSA id l6sm5592050wrs.51.2022.01.28.08.44.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Jan 2022 08:44:57 -0800 (PST)
Message-ID: <70fc08d0-0113-bf2e-6f5c-e4b743168ddb@tessares.net>
Date: Fri, 28 Jan 2022 17:44:56 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH mptcp-net 2/2] selftests: mptcp: add missing join check
Content-Language: en-GB
To: Mat Martineau <mathew.j.martineau@linux.intel.com>
Cc: Geliang Tang <geliangtang@gmail.com>,
 MPTCP Upstream <mptcp@lists.linux.dev>, Paolo Abeni <pabeni@redhat.com>
References: <20220122093135.4023846-1-matthieu.baerts@tessares.net>
 <20220122093135.4023846-3-matthieu.baerts@tessares.net>
 <CA+WQbwuSJ-WZuQFEjTAtD5ycodbiC0mZ7dwDWQa0VEWsOPSO=g@mail.gmail.com>
 <fc920e6d-72fe-49c8-e31f-920fbd15c952@tessares.net>
 <3f68e731-3c0-d74-2040-28ef4485a3b@linux.intel.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <3f68e731-3c0-d74-2040-28ef4485a3b@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Mat, Geliang, Paolo,

On 26/01/2022 02:26, Mat Martineau wrote:
> On Mon, 24 Jan 2022, Matthieu Baerts wrote:
> 
>> Hi Geliang,
>>
>> Thank you for looking at that!
>>
>> On 22/01/2022 15:04, Geliang Tang wrote:
>>> I think in this test chk_join_nr is omitted on purpose, since it is more
>>> likely to fail. As we can see, chk_add_nr failed sometimes, if we add
>>> this
>>> chk_join_nr, it will fail more frequently.
>>
>> May you explain why this tests is likely to fail? Both the commit
>> message and the comment in the code don't explain that.
>>
>>> Matthieu Baerts <matthieu.baerts@tessares.net> 于2022年1月22日周六
>>> 17:32写道：
>>>>
>>>> This function also writes the name of the test with its ID, making
>>>> clear
>>>> a new test has been executed.
>>>>
>>>> Without that, the ADD_ADDR results from this test was appended at the
>>>> end of the previous test causing confusions. Especially when the second
>>>> test was failing, we had:
>>>>
>>>>   17 signal invalid addresses     syn[ ok ] - synack[ ok ] - ack[ ok ]
>>>>                                   add[ ok ] - echo  [ ok ]
>>>>                                   add[fail] got 2 ADD_ADDR[s]
>>>> expected 3
>>>>
>>>> In fact, this 17th test was OK but not the 18th one.
>>>>
>>>> Now we have:
>>>>
>>>>   17 signal invalid addresses     syn[ ok ] - synack[ ok ] - ack[ ok ]
>>>>                                   add[ ok ] - echo  [ ok ]
>>>>   18 signal addresses race test   syn[ ok ] - synack[ ok ] - ack[ ok ]
>>>>                                   add[fail] got 2 ADD_ADDR[s]
>>>> expected 3
>>>
>>> I think if chk_add_nr fail here, chk_join_nr must fail too. If we got 2
>>> ADD_ADDR[s], we got 2 JOIN[s] syn too, not 3. Furthermore, if chk_add_nr
>>> passed, we can't make sure chk_join_nr will pass too. Since MP_JOIN is
>>> translated after ADD_ADDR, it may be lost.
>>
>> Indeed, to simplify the commit message, I mixed both a "success" and a
>> "failure" output. I should not have done that and only put a "success"
>> one to keep the output small.
>>
> 
> Given that Geliang withdrew his comments, and I don't have changes to
> request, I think this looks ok for the export branch:
> 
> Reviewed-by: Mat Martineau <mathew.j.martineau@linux.intel.com>

Thank you for the reviews and suggestions!

> Not sure if you want to adjust the commit message as you mention just
> above.

Yes, just did by writing output from the CI:

https://api.cirrus-ci.com/v1/artifact/task/5375837896704000/summary/summary.txt


- 948d50855388: mptcp: mptcp_parse_option is no longer exported
- ee286fda85da: selftests: mptcp: add missing join check
- Results: 419c18898efd..d57649f20e6e

Builds and tests are now in progress:

https://cirrus-ci.com/github/multipath-tcp/mptcp_net-next/export/20220128T164437
https://github.com/multipath-tcp/mptcp_net-next/actions/workflows/build-validation.yml?query=branch:export

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
