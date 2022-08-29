Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4A7753A4
	for <mptcp@lists.linux.dev>; Mon, 29 Aug 2022 15:13:54 +0000 (UTC)
Received: by mail-wr1-f49.google.com with SMTP id bs25so10613455wrb.2
        for <mptcp@lists.linux.dev>; Mon, 29 Aug 2022 08:13:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=g7+53mUGzurcVBobsSlcLd0AXzkF73wUSRWux0A/pG4=;
        b=q5J50dfepDnmuinJo8StvRsuG6wLSv4j5rUXG1g1KaqH9EpF03Kt22z03Ho9kNkk7P
         JRHUwLXzBHE8d1xYd+LHJjNSm4tLmcwIZN0HzX5uisrr0sHnRnbULR/I8oEvIdQ0mOWB
         3HHLf4/6pNjNjlc13IY5Anou3iMjZR9WgBxQIYG3zvBR0pvAAsl6FR+CEU8o7snX8dA7
         2ylpqM/1qnpehQ46yeDlT8d2sLaduSmUiC5y7k4H7rdjvZDHA9bLLxc6b+cjNkFhL5KN
         Z0me5mQEsYiWE0DbbieW4sW5LbTqJSHfKOr3/7WU6wWgSqs2h2w5yQ+r3Mnn5nHqEWXJ
         t3yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=g7+53mUGzurcVBobsSlcLd0AXzkF73wUSRWux0A/pG4=;
        b=yR2m857sFwAyHAm6ZLyj1KA1vWDWZCkEtGXsiHEaSBFXKnFfGjgRRKcUHoq29nMFf/
         cnyPenrIGJ5j23f70noOx8DhEJJiXPAj5bmbaSV2NQ7eaAPIwUXSGG/0HMjHo0Y9X0BD
         VplJO39c4pkXIOBmQSfZGzdt4XIayR3KPgw/cDQh/lKupgRPlJePuvICGtsS+IBHCwZZ
         v7oFFK9ckCfRUpAHb8+9Ll92gGy/Sqswslj4mqaEMSAc2pyuNV50mVO6YIcjB69g93k8
         Qi6Hoc1VK6rrnTOE8rjfYXFA8Cx98e1ZTYJATTbBRSee4SavFuSCWIhW4SC/WUTqERVj
         BlKw==
X-Gm-Message-State: ACgBeo0/K7x6oU3u6TlLsPnIUcwleJoCIXE0W7yHfKXsQN4bA04QaXQX
	nhswilBvxwRUB5ke5dL+eNDAXw==
X-Google-Smtp-Source: AA6agR4hk/+Tchjy7K9whMSS4G3Vful/HZgtXAr6avIZnW1rv24T1e8Cd3+aAwGs2q5ZGM6PyFq6SA==
X-Received: by 2002:a5d:6c6f:0:b0:225:3cbf:eab7 with SMTP id r15-20020a5d6c6f000000b002253cbfeab7mr6744144wrz.264.1661786032656;
        Mon, 29 Aug 2022 08:13:52 -0700 (PDT)
Received: from [10.44.2.26] ([81.246.10.41])
        by smtp.gmail.com with ESMTPSA id s9-20020a1cf209000000b003a60f0f34b7sm9051134wmc.40.2022.08.29.08.13.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Aug 2022 08:13:52 -0700 (PDT)
Message-ID: <6fcba5a4-c4a1-eee9-25da-5429835603cf@tessares.net>
Date: Mon, 29 Aug 2022 17:13:51 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.2
Subject: Re: [PATCH mptcp-next v2 1/2] mptcp: allow priviledged operations
 from user namespaces
Content-Language: en-GB
To: Thomas Haller <thaller@redhat.com>,
 Mat Martineau <mathew.j.martineau@linux.intel.com>
Cc: mptcp@lists.linux.dev, Florian Westphal <fw@strlen.de>,
 Paolo Abeni <pabeni@redhat.com>
References: <e95949bf-53cf-bdf-27c8-8cbc3eeda450@linux.intel.com>
 <20220810074251.31887-1-thaller@redhat.com>
 <3af41bc6-436a-5849-b2d-9564dd8f46c7@linux.intel.com>
 <49976d61-c3e1-3991-37b3-4751f8a96a5c@tessares.net>
 <c359cd4e1ea2970d0bd3d3127773d08041ae2acd.camel@redhat.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <c359cd4e1ea2970d0bd3d3127773d08041ae2acd.camel@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Thomas,

On 24/08/2022 22:37, Thomas Haller wrote:
> On Thu, 2022-08-11 at 12:34 +0200, Matthieu Baerts wrote:

(...)

>> @Thomas: BTW, thank you for maintaining libnl!
>> Funny that you sent these patches to MPTCP while earlier this week I
>> sent the latest libnl version to Debian :)
>>
>> https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=1016867
>> https://tracker.debian.org/pkg/libnl3
> 
> Oh, that's nice. After I rather neglected libnl for quite some time, I
> want do to a better job in the future. :)

:-)

> On an unrelated note: upcoming NetworkManager 1.40.0 release will have
> basic MPTCP support and configure endpoints. Similar to what mptcpd
> does. This was the backstory for the patches.

That's a really good news! Thank you for having worked on that,
preparing a setup to be used with MPTCP is going to be easier now!

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
