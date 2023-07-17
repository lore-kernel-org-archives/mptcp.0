Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B73ABA24
	for <mptcp@lists.linux.dev>; Mon, 17 Jul 2023 13:47:46 +0000 (UTC)
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-3fbf1b82de7so27915655e9.1
        for <mptcp@lists.linux.dev>; Mon, 17 Jul 2023 06:47:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1689601664; x=1692193664;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ItuRb+tNdw80MoGYLCtAJ1Ky8DIPu/hihz2qGM1EmaY=;
        b=8t0oUexLzdOWOy9tAKL39sj7JT67H3vvXwn5XFuuPY+kcfPINxeuD6/tvQrS3Pkze1
         evI14UVz/N3xAeHpjhQ+y8ME2Kc99tl1Fb58SnbpS8P5Aav1Yc222rSzO7koG4KOQMNm
         TufJFwjbKJ5zitW2+/ATYgzkbxKcZSbdg6c8iCwUZwX7oyG66fiEqFLXK8A+NDZ/IrI7
         vKB4PeXXkF+ZcO6LaglF8ddTBZ5DQ8BIvzZGWABLJ2biDOXNvLoXPB1XcH8Ji76r+j0Y
         dmboMc+p6PZMeejn6+sZp8+Jib2wwla2JEuxz88+Jhk+P+UO0lW9JSesO/zyHQKT3Z0W
         P3Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689601664; x=1692193664;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ItuRb+tNdw80MoGYLCtAJ1Ky8DIPu/hihz2qGM1EmaY=;
        b=dsLs5gmB5IpQ8iaFXcHIhccqQVPIZzH8eSPOOOMumVOYWJdbdjd+ZkSPaUAW8LTfDQ
         p+UqVi31eFlbmkIINWVE0Hr4GvqV3O0fPJoCllVS7bDFpbaHI82E7UOwBs+qACU8AigZ
         TFBOngMoZTAtOrrQlhJ1CDzfOqIpxTN1+B/PZeEfz2R9HqnVKihdv3Mz1iUKuiRHu3p0
         c1ZmRuGoXSiFSKXFW7aAKGM+z37MqjJHegpSSAqSLluH6GRE3zvQKqKQF9FqYr4vVUnf
         mZgtiJdn5A2R8ZhQoKTNerB6hbD2oRpULyTdu/3G3XyGOM1G1ENHmotEJYo+8eoMJGvz
         OAJg==
X-Gm-Message-State: ABy/qLaoEU/aMqkfSQZjHqPSBAVRwbw1EUkORBw0OiJgNr+15dyxpFzg
	4trP0ORvY/oljlMYJmpeFIJw7oW8c2hgl0ZSIYHxVw==
X-Google-Smtp-Source: APBJJlEGzqbZToZ+j/tmwCPU+0Fv7Iv37zJsHBQXi7MFdSfgYsBZeZxo+1m2usnT7DsQi8AnflG6/Q==
X-Received: by 2002:a05:600c:3b0a:b0:3fb:ebe2:6f5f with SMTP id m10-20020a05600c3b0a00b003fbebe26f5fmr7739600wms.13.1689601664468;
        Mon, 17 Jul 2023 06:47:44 -0700 (PDT)
Received: from [10.44.2.5] ([81.246.10.41])
        by smtp.gmail.com with ESMTPSA id 12-20020a05600c020c00b003fba6a0c881sm7901472wmi.43.2023.07.17.06.47.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Jul 2023 06:47:44 -0700 (PDT)
Message-ID: <bac62009-5c3b-52eb-9b06-7c03e9948a4f@tessares.net>
Date: Mon, 17 Jul 2023 15:47:43 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH mptcp-next v2 0/2] selftests: mptcp: pm_nl_ctl: display
 errors if any
Content-Language: en-GB
To: Mat Martineau <martineau@kernel.org>
Cc: mptcp@lists.linux.dev
References: <20230713-mptcp-issue-368-pm_nl_ctl_ack-v2-0-eb9582b8e24b@tessares.net>
 <05f43fb0-66e2-e737-85c8-96e6aac50091@kernel.org>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <05f43fb0-66e2-e737-85c8-96e6aac50091@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Mat,

On 15/07/2023 01:37, Mat Martineau wrote:
> On Thu, 13 Jul 2023, Matthieu Baerts wrote:
> 
>> Recently, I wanted to understand why the userspace_pm.sh test was
>> failing on some arch according to lkft reports. There was nothing in the
>> logs apart from seeing the expected event had been missing. I then
>> realised the output of pm_nl_ctl was muted but also this tool was not
>> looking if there were errors after having sent some Netlink commands.
>>
>> I don't think it is a good idea to mute the output and ignore errors,
>> especially here in the tests where we do want to validate these Netlink
>> commands. So now the tool checks for errors and the output is no longer
>> discarded.
>>
>> Note that I didn't manage to read the error message set by the kernel. I
>> think the rtattr pointer in nl_error() is wrong. I think it should get
>> info from &err->msg instead of nh. Anyway, here we at least print errno
>> and just in case someone wants to have a look, it is easy to test:
>>
>>  ./pm_nl_ctl ann 1.1.1.1 token 12 id 0
>>
>> Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
>> ---
>> Changes in v2:
>> - Patch 1/2: mute expected errors in selftests
>> - Link to v1:
>> https://lore.kernel.org/r/20230705-mptcp-issue-368-pm_nl_ctl_ack-v1-0-40bcff40cb6b@tessares.net
>>
> 
> Thanks for the fix, v2 LGTM:
> 
> Reviewed-by: Mat Martineau <martineau@kernel.org>

Thank you for your review!

Now in our tree (feat. for net-next) with your RvB tag:

New patches for t/upstream:
- 5f1f8d5f478a: selftests: mptcp: pm_nl_ctl: always look for errors
- 9ed40a078338: selftests: mptcp: userspace_pm: unmute unexpected errors
- Results: 0c9d206ff536..87ca9f6d4f74 (export)

Tests are now in progress:

https://cirrus-ci.com/github/multipath-tcp/mptcp_net-next/export/20230717T134429

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
