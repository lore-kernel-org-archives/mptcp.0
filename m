Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7331F2C9C
	for <mptcp@lists.linux.dev>; Thu, 10 Feb 2022 12:03:04 +0000 (UTC)
Received: by mail-wr1-f53.google.com with SMTP id i14so9082727wrc.10
        for <mptcp@lists.linux.dev>; Thu, 10 Feb 2022 04:03:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=iA3CuRHMTiWKQDq5e2d9LquJ3P3l9S/LVQlbnHTKT+I=;
        b=waQGdl7mM1VlpZvYogIJZTr5nvwuw3FvZyfGcOgalZLFwpRP5MoYVcfYEvYsA38h0t
         2JMpt0Sqvo879Kv7GrZw9r4Yq8chR1CqMM6w0aU2e13sTrI0quLq+JyRT+T0dw6HY8K3
         7AdsIikmgII/CnnyhYFQSsVqbYxYTaQ+Q950yHDWLl+VtJeyPwy/0K/ojRyAeHwbtdxK
         dz4WGXKWCp3TbqIMh85Q2p3mgb9ZMdMI2sr4ZzbQahtsin//q8rdzrRcvompELSIKLnl
         pFrjKcw3JcfTfC8sJZfLS/LF8AiNhx4PzwHmAtpdn++McNzU+LCvjiOZJUZGy4Rl85Ky
         NOCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=iA3CuRHMTiWKQDq5e2d9LquJ3P3l9S/LVQlbnHTKT+I=;
        b=v38N0gNS3Z54RUfvPGz8+wDxuDrEXvn0u3lVuZgJ2AFawXAqec4KliztgfH1gTH6dt
         CxJ7E33nvC3XiCiz+X/kK4dhDZKs0JdCALhz0VmpMPLx7VoTnpNYCxMkyT+S/k4oBkGX
         tjU0aeF4puSSMcjdn/2hikjiQyJqPZk9L5qoHY/E/ojsE/f+sUyyqqyVGekDzT+1e4qc
         LiAtWNrhhRIWqbULS7orMd23Y+IA2CqpEJqj2P4F+iHqGFLH4fupPXBXsO5lpISkoAsB
         qUM3Gd1RHxqKZM07Ovz0zRAANbPvc+gekyeYraiyuEu2qIUJQXp7i8SYCYKNysM91A+s
         vg+Q==
X-Gm-Message-State: AOAM533H0XCQbYDKOhqTsZ0RQBoE+z2QPApCpuE/w+M5Prjopb5XmPfH
	RBrxAGkCkp6sXyOe8nVHZ6UXLKYGKJMy91pg
X-Google-Smtp-Source: ABdhPJwYjQFb97N2olNbhr8rqA47GjlvhsRP+C4LQBowQEuznM0jLESTOQUW8HAkZq+gWC6TUeGzWw==
X-Received: by 2002:a5d:6ca5:: with SMTP id a5mr6157533wra.140.1644494582731;
        Thu, 10 Feb 2022 04:03:02 -0800 (PST)
Received: from [10.44.2.26] (84-199-106-91.ifiber.telenet-ops.be. [84.199.106.91])
        by smtp.gmail.com with ESMTPSA id e8sm4018181wru.37.2022.02.10.04.03.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Feb 2022 04:03:02 -0800 (PST)
Message-ID: <60ef8629-d9d4-3bc2-00cb-d8c286d934aa@tessares.net>
Date: Thu, 10 Feb 2022 13:03:01 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH v2 mptcp-next] mptcp: strict local address ID selection.
Content-Language: en-GB
To: Paolo Abeni <pabeni@redhat.com>, mptcp@lists.linux.dev
References: <75e02d63aa8b03b873ad94f5b4d901776f9a81ea.1644487551.git.pabeni@redhat.com>
 <47e854cf68fdc2a1e0b2c9e79813d4212393faac.camel@redhat.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <47e854cf68fdc2a1e0b2c9e79813d4212393faac.camel@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Paolo,

On 10/02/2022 11:36, Paolo Abeni wrote:
> On Thu, 2022-02-10 at 11:07 +0100, Paolo Abeni wrote:
>> The address ID selection for MPJ subflows created in response
>> to incoming ADD_ADDR option is currently unreliable: it happens
>> at MPJ socket creation time, when the local address could be
>> unknown.
>>
>> Additionally, if the no local endpoint is available for the local
>> address, a new dummy endpoint is created, confusing the user-land.
>>
>> This change refactor the code to move the address ID seleciton inside
>> the rebuild_header() helper, when the local address eventually
>> selected by the route lookup is finally known. If the address used
>> is not mapped by any endpoint - and thus can't be advertised/removed
>> pick the id 0 instead of allocate a new endpoint.
>>
>> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
>> ---
>> Note: send v2 to address the build issue, to help the discussion
> 
> It looks like I was too hasty and this is badly broken. Please ignore,
> I'll try to cook something better later.

Funny, the CI doesn't agree with you :)

--------------
- KVM Validation: normal:
  - Success! ✅:
  - Task: https://cirrus-ci.com/task/5993050752155648
  - Summary:
https://api.cirrus-ci.com/v1/artifact/task/5993050752155648/summary/summary.txt

- KVM Validation: debug:
  - Success! ✅:
  - Task: https://cirrus-ci.com/task/5430100798734336
  - Summary:
https://api.cirrus-ci.com/v1/artifact/task/5430100798734336/summary/summary.txt

Initiator: Patchew Applier
Commits:
https://github.com/multipath-tcp/mptcp_net-next/commits/d90c337f0c5a
--------------

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
