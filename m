Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D3F917CB
	for <mptcp@lists.linux.dev>; Wed, 12 Oct 2022 10:15:16 +0000 (UTC)
Received: by mail-ej1-f49.google.com with SMTP id sc25so30836214ejc.12
        for <mptcp@lists.linux.dev>; Wed, 12 Oct 2022 03:15:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5084Z16b7E3kWwUEKJaxuLHVY1sAJHpQ2yi4TSXLJJA=;
        b=J1Zlc736aUqyM/TNaeMkBkSBYl+hlQSY7/7g7mQcjRzC2naPYrr4URR/0d8py9AaFQ
         Km9yQABZxkMQjw/lgRgYurOCGeoJvkgLILaGwXechP8ZnpThsnPwUUynSsfh4ZXGDlbZ
         mBKth+F6JD2/3wXRZ+/GGg88VFWJYHPEuD+uV3UWfoJhYsZ0d4VyHZMZK53NhsB0IB39
         mEI9G6NAfawxwh7AxGu0XR1+yQslIAiHFXvi/qsSnCwc+QsCB+vi/jmpF3qHjxX6HwZM
         ttelNjE03DVU2simDRvdbUoUIRsApZXHxNHWe//z16lkRw4JaDifxkehMkXDnmbmAoSJ
         Bx7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5084Z16b7E3kWwUEKJaxuLHVY1sAJHpQ2yi4TSXLJJA=;
        b=Mb/6/Va9PMQKAQlUrW2qkyTlltaoZizhcX284Xc71WDSf/zcqXE9S7cuAulBbcR3Qa
         OqEB9MLuls0mGU3suM7lELKM+G6RKG63NSQ21NH7LNGN89zoTxLaXJOV3dCXHQP7ymUW
         pl9X7lKn+E9sBoKLMnnu4xTI7Z4p4qXdc74tz3z+rM24JdyG6jlaJ0isjbd/qwf+GAvZ
         9mbbOyD9CuTKReXkYcNnJEJbhrSEz4hD8Y3KZRB/+FXKhtvcHBh3SH/2Pa2OjoLiom+A
         zhsZCpwMTQJfMo+oc3TJjd83laWtX/1JD8US1Ymr56z5DtXo0pZ/kqDsRMu/iYUqIUzN
         jIqw==
X-Gm-Message-State: ACrzQf3fuvdgmVKwZ2iFdldGyEe0Ms16VIGJNcB94zF3dPaK5aF+gZwq
	WQIgQVgdrshLOcwr92kDAaFLDKfTF/QYiw==
X-Google-Smtp-Source: AMsMyM4L6WdRk8AbwRtU2ypMKq+rOXWS3JmSDL2GBanNDKg6OH3TG0fZaRYMBEWlGyUh+NhBhJqZ9w==
X-Received: by 2002:a17:906:5a69:b0:78d:e65b:e5a0 with SMTP id my41-20020a1709065a6900b0078de65be5a0mr4785746ejc.544.1665569714205;
        Wed, 12 Oct 2022 03:15:14 -0700 (PDT)
Received: from ?IPV6:2a02:578:8593:1200:f07e:bd7a:c3d9:59e6? ([2a02:578:8593:1200:f07e:bd7a:c3d9:59e6])
        by smtp.gmail.com with ESMTPSA id j9-20020a17090623e900b0077fc47605b4sm959755ejg.217.2022.10.12.03.15.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Oct 2022 03:15:13 -0700 (PDT)
Message-ID: <cd057575-05e1-26e0-ca53-523608c49fd9@tessares.net>
Date: Wed, 12 Oct 2022 12:15:13 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [RFC PATCH mptcp-next v14 5/5] selftests: mptcp: mptfo
 Initiator/Listener
Content-Language: en-GB
To: Dmytro Shytyi <dmytro@shytyi.net>
Cc: mptcp@lists.linux.dev
References: <20221010221809.1792-1-dmytro@shytyi.net>
 <20221010221809.1792-6-dmytro@shytyi.net>
 <a03a004fa4ca05ba20a42fe5e092368206af793f.camel@redhat.com>
 <eb9ace54-579b-f27a-aa78-f1a2cf4b175e@tessares.net>
 <374bf0f9-c7d7-b658-c92a-816b154c69b7@shytyi.net>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <374bf0f9-c7d7-b658-c92a-816b154c69b7@shytyi.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Dmytro,

On 11/10/2022 18:35, Dmytro Shytyi wrote:
> Hi!
> 
> On 10/11/2022 5:49 PM, Matthieu Baerts wrote:
>> Hi Paolo, Dmytro,
>>
>> On 11/10/2022 17:33, Paolo Abeni wrote:
>>> On Mon, 2022-10-10 at 22:18 +0000, Dmytro Shytyi wrote:
>>>> This patch adds the selftests support for mptfo in mptcp_connect.c,.sh
>>>> We introduce mptfo option, that sets "TCP_FASTOPEN" + "MSG_FASTOPEN"
>>>> We call sendto() instead of connect().
>>>>
>>>> Signed-off-by: Dmytro Shytyi <dmytro@shytyi.net>
>> (...)
>>
>>>> diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect.sh
>>>> b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
>>>> index 621af6895f4d..d2328f94d1df 100755
>>>> --- a/tools/testing/selftests/net/mptcp/mptcp_connect.sh
>>>> +++ b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
>>>> @@ -677,6 +677,58 @@ run_tests()
>>>>       run_tests_lo $1 $2 $3 0
>>>>   }
>>> I guess mptcp_join.sh would be a better location. @Mat[s]: wdyt?
>> We only need to test with one subflow. Then mptcp_connect.sh should be
>> fine, no?
>>
>> I know Dmytro likes to duplicate code ( :) ) but I think run_tests_lo()
>> should be re-used. In this case, we reduce the modification to a few
>> lines (e.g. what is done in run_tests_peekmode()).
> 
> I also prefer avoid duplicode code ( :) ) in the resulting solution.
> I didn't notice run_tests_peekmode(). It is a better way!

I wanted to say that you like to produce code :-)

Just in case, when you create new functions with a content similar to
other existing functions but adapted to do something (slightly)
different, the best is to add a comment explaining that to help
reviewers and maintainers, e.g.

  /* Inspired by/Similar to <...>() but doing <...>. */

So when reviewing, we can directly understand why you didn't re-use
something else instead of guessing. And we can look at the history of
the original function to understand why some lines are there.
Also later, if we need to modify the original or the new functions, we
have the comment to tell us to check the other one.

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
