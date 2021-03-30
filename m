Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E56770
	for <mptcp@lists.linux.dev>; Tue, 30 Mar 2021 12:30:17 +0000 (UTC)
Received: by mail-ed1-f42.google.com with SMTP id bf3so17987880edb.6
        for <mptcp@lists.linux.dev>; Tue, 30 Mar 2021 05:30:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20150623.gappssmtp.com; s=20150623;
        h=to:cc:references:from:subject:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=RNEgRRLQ9f2+dSEqvL8BZj0BwLbCmpPJMeVsPxhRxtc=;
        b=crErHfCa7kS23+BdJCzHLLvH5ws5SJOdSUgcgXEpMMBjzN3hFQDpH2OD49WaKvUwsN
         pPnDZi7HvW/v1tw2HPDJAwEGIKro4Q3HP3/1pRA9IxNW5e0HUlU/aSMZCpVqKjWobRIV
         mQSGU9o5lssnZQIhqnHKBV7v9gS1J34V8jGq3ScRSQ0egBb6HhLUrwlhoufViVbJWk+p
         UXMEw0oC+jySonQOspTypFz/hqA5LxcHKgVZeeOSTcZiYjKka13ZnFrNohH8LufYsCR8
         gRpf+/xuoNT8tsF3bqqzR5KDhNx9fe50ygXrwL19pH6qx9BWDTDJpTReteRbjZZ7FbK1
         9NAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:references:from:subject:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=RNEgRRLQ9f2+dSEqvL8BZj0BwLbCmpPJMeVsPxhRxtc=;
        b=ZzwlNup9ugb4dLqlB25hK1j5YoPmKM14dt3P4P+NJRWq0gOhTJJKK6YKi5jMoH6NED
         Joi9wv7sMOC5CwArMgYBcW1ozgfWHu3vsPwqHRu2A0QSsovEfSl69QxzkT9PYNzVGk/z
         kOSCAOBgdXrJd/6YKcKcxu3ytclCDLSBXAaxhiP9S2uYKFly3hOa79j/aCVYlnOyV0bK
         7RBNPuVY2i0awqeVr/1q0kcivfreyLQTe9z1on2dLPU1ymN4XB5deoIUTLnN/l7sOLzk
         ksqPfZepHhsOBCLHPxNjnyoAlpeNcygkoUk8pRND41sEeDfB/D2+42EDqYGgjFIeSY96
         s+wA==
X-Gm-Message-State: AOAM532U7HKJ/RO3z6IUEqvAhfqQx5mpaxWp1Q586z4FLSiomi/SOXaE
	hW8jHpUpupDk5MacOyaACEqkHg==
X-Google-Smtp-Source: ABdhPJy3WYNdiL010G8hrnYwC6t7oZOj0q2DLNhfMvypISkRmGXbjh5mxur81ihGWPUCaHeNxbTg6g==
X-Received: by 2002:aa7:dbd3:: with SMTP id v19mr33202697edt.314.1617107415551;
        Tue, 30 Mar 2021 05:30:15 -0700 (PDT)
Received: from tsr-lap-08.nix.tessares.net ([2a02:578:85b0:e00:8c77:a440:107c:fad8])
        by smtp.gmail.com with ESMTPSA id v8sm11147026edq.76.2021.03.30.05.30.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Mar 2021 05:30:15 -0700 (PDT)
To: Geliang Tang <geliangtang@gmail.com>
Cc: mptcp@lists.linux.dev, mptcp <mptcp@lists.01.org>
References: <9fe955db44222c638db73c3f8446d9d248b8a11c.1616039100.git.geliangtang@gmail.com>
 <594ef822-2f57-7b80-4651-2d0b4ef7d4ec@tessares.net>
 <CA+WQbwuEwCaSAKLf_DVOytApD0D=8CFV9cGXOjL2maoiYq-SmQ@mail.gmail.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
Subject: Re: [MPTCP] [MPTCP][PATCH v2 mptcp-next] Squash to "bpf:selftests:
 add MPTCP test base"
Message-ID: <7cf133a1-b47a-a8d2-6eaf-ad1232b3ce15@tessares.net>
Date: Tue, 30 Mar 2021 14:30:14 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <CA+WQbwuEwCaSAKLf_DVOytApD0D=8CFV9cGXOjL2maoiYq-SmQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 8bit

Hi Geliang,

Thank you for your reply!

On 30/03/2021 12:32, Geliang Tang wrote:
> Hi Matt,
> 
> Thanks for your review.
> 
> Matthieu Baerts <matthieu.baerts@tessares.net> 于2021年3月20日周六 下午7:31写道：
> 
>>
>> Hi Geliang,
>>
>> On 18/03/2021 04:47, Geliang Tang wrote:
>>> When I ran the bpf mptcp test "./test_progs -n 67", I got a "fallback to
>>> TCP" error and a "Attempt to release TCP socket in state 8" error in the
>>> kernel log:
>>
>> (...)
>>
>>> For the first error, adding send_byte can fix it. The send_byte function is
>>> copied from tools/testing/selftests/bpf/prog_tests/tcp_rtt.c.
>>
>> (maybe better to continue the discussion about that in the v1, I'm not
>> sure I understand what is causing this fallback and I'm not able to
>> reproduce it with another program)
>>
>>> For the second error, we need to close the server fd before closing the
>>> client fd.
>>
>> Do you know why we have to do that?
>> Do we have the same warning with tcp_rtt.c for example where the server
>> is also closed after the client.
>>
>> Again, I don't think it is normal to have these warnings with simple
>> userspace programs except if here, some modifications are done from BPF?
> 
> Did you reproduce this issue using the bpf selftest? Did you test my fix?
> It's simple and it works.
> 
> Do you think it's worth to find out the root cause of this issue? It may
> take a lot of time. If so, I'll open a ticket on GitHub to trace it later,
> I'll try to fix it after finishing the "checksum support" issue.

I think it is worth finding out the root of this issue. It is not urgent 
at all.

As far as I understand, these two warnings are not blocking, right? In 
this case, maybe better not to "hide" them because the current version 
looks good to me: I mean, I don't see why it would not be OK to close a 
connection where no bytes were transferred nor closing the server fd 
before the client one.

So yes, please open a new ticket on GitHub if you don't mind :)

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
