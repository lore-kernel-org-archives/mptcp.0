Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 344067F
	for <mptcp@lists.linux.dev>; Wed,  4 May 2022 13:08:56 +0000 (UTC)
Received: by mail-ed1-f48.google.com with SMTP id t5so1619252edw.11
        for <mptcp@lists.linux.dev>; Wed, 04 May 2022 06:08:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=5CJnEcbDuxRRstFBITIgaGw2ycr1kMr0JJVcxrx9C4s=;
        b=ryeXj3jOpobRzbXV8tGLW5f9jCVm6aiGedsaie+ktU4Uf5qRzv/1ZLWvNu3amNhHqI
         dH+HY57ytOWE6WzLuWV7idn9TUCLt0OrKimn5CHXYvs1csZT/2q2afXlJYSTVTz34Ekd
         sdx9IKIoUwe/9rab0K1+6mSF6DW3K/4DvfYiHv+9CLfTFGp6wYlBakZb/JcM8kO2WfwF
         N3iZT72XhxGXR6DenE5Hfz7aioI3MF5yzBxrIfnO6fniPI5+NzqdtJldEV2JK3V/u0ha
         yvSXtqmTjrMWJ1vWk+Te5zkcnNB3x5HMlsvxEIRx5Idq06OKYZQDsbWKiDqufVVxJfmL
         Yp5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=5CJnEcbDuxRRstFBITIgaGw2ycr1kMr0JJVcxrx9C4s=;
        b=4KlcAGJFhULi6aOXe2sk/eWNkoGpVmFeAV7O4ZyjTgijfrjCSqkEiuhPvhFsZUdAmc
         dxgtQ1QLuM43v1s2lxPgU/MrkZLfM27dTiwe0wgVE/fERHKLPYHeygRzvMpJqqaIWH1+
         JR1wjPqWSqx4eOKSYMXJMZzZpLPa6N9CG7EIVeKCxPg17pU9ZOeMGehDg6LJvccIo5A+
         UuGNEmVhV6FLNGAjoWt82EVJ4i+VhGvEmw38KYzwXX1rUjmqwGbNrt79UoO7omcXygTj
         2DRzYAgabfz6IpO1bDHJzgm21IQoUGH2540sjvMjCGFtd8QdPMe/3QS8PtJ2R6RzVXPk
         geyw==
X-Gm-Message-State: AOAM5300i4wpEyZ4XlXkcYQT8ejkxCiUTgi3u6o4rPE1TVuQ5voUGXmB
	ZbOuvQ5sS/pd8vcrBCDGQA0ny6IEaDxvZ7cw
X-Google-Smtp-Source: ABdhPJxW2EghT/bp0ytQQ2jiFRIPfFVc4mHkdcIutkFIq2W7jrqMoN86NRAZGwh3jEmzHrss4uTsow==
X-Received: by 2002:aa7:d38d:0:b0:427:331b:4f38 with SMTP id x13-20020aa7d38d000000b00427331b4f38mr22691235edq.0.1651669735035;
        Wed, 04 May 2022 06:08:55 -0700 (PDT)
Received: from ?IPV6:2a02:578:8593:1200:e57b:38b2:b6d2:346c? ([2a02:578:8593:1200:e57b:38b2:b6d2:346c])
        by smtp.gmail.com with ESMTPSA id g15-20020aa7dd8f000000b0042617ba63adsm9259999edv.55.2022.05.04.06.08.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 May 2022 06:08:54 -0700 (PDT)
Message-ID: <c3f829cc-9610-aa7e-cb88-041b4de22d04@tessares.net>
Date: Wed, 4 May 2022 15:08:53 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH mptcp-next] Squash to "selftests: mptcp: add MP_FAIL reset
 testcase" - cleanups
Content-Language: en-GB
To: Paolo Abeni <pabeni@redhat.com>, Geliang Tang <geliang.tang@suse.com>,
 mptcp@lists.linux.dev
References: <cdcd6b9963a1c15b20ffcf71e06b6de70f67ec4a.1651664645.git.geliang.tang@suse.com>
 <20220504121429.GA18870@bogon.HOST>
 <d4546526351251a86d13673baa3f88de5655fb13.camel@redhat.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <d4546526351251a86d13673baa3f88de5655fb13.camel@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Paolo, Geliang,

On 04/05/2022 15:03, Paolo Abeni wrote:
> Hi Geliang,
> 
> On Wed, 2022-05-04 at 20:14 +0800, Geliang Tang wrote:
>> On Wed, May 04, 2022 at 07:44:24PM +0800, Geliang Tang wrote:
>>> Two small cleanups for MP_FAIL reset test case:
>>>
>>> Reduce the test files size from 1024 to 128, to make the test faster.
>>
>> The original commit log needs to update too:
>>
>>  1024KB -> 128KB
>>
>> '''
>> Add the multiple subflows test case for MP_FAIL, to test the MP_FAIL
>> reset case. Use the test_linkfail value to make 128KB test files.
>>
>> ...
>> ...
>> '''
>>
>>> With Paolo's fix [2] for MP_FAIL test-case, the test becomes very slow.
>>>
>>> Drop '+'s passed to chk_csum_nr, with Paolo's fix [1] for act_pedit, no
>>> extra checksum failures now, no need to add '+'s anymore.
>>>
>>> Depends on Paolo's commits:
>>> [1] net/sched: act_pedit: really ensure the skb is writable
>>> [2] selftests: mptcp: fix MP_FAIL test-case
>>>
>>> Signed-off-by: Geliang Tang <geliang.tang@suse.com>
> 
> I noticed the the time increase. Unfortunatelly, it may be necessary to
> be reliable in all environment, comprising the slowers one.

I might have not follow what's the root cause but would it help to add
some latency on the primary link to force the kernel to use the second one?

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
