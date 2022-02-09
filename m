Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ED192F24
	for <mptcp@lists.linux.dev>; Wed,  9 Feb 2022 12:24:12 +0000 (UTC)
Received: by mail-ej1-f47.google.com with SMTP id ka4so6717080ejc.11
        for <mptcp@lists.linux.dev>; Wed, 09 Feb 2022 04:24:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=vdbJVspABOQcaXCoCvAj4ccG+htx7NQD7qym78msHro=;
        b=BsWqIqOEyfIOuUxujOBbu3DKRQyus6vdISFa+vDW9uBLbNtuoIIHhWKDzbX52OKEg5
         g5Ys+NtMlxRV1jhef03nlJljq7EnKcBeV2mCHKJhnMpCsUzOtCMASMYAc8hLOd3o3ZHR
         Sv5mxtv4N+1KgvFuGj55oY4Ete+wT6Ol6lSV7jOpXYx97er9s6l+DTIGxp/hYNsy9SCH
         ayCCGxUJ+z59MKt+qz/0bObIaZZJBBDFxQijTgCfp2Blakyl7ySvntfN5paLrhct7AjS
         57N64CqU8dzjSpTYpukOfewtn3aOXC6G/OoJPNEEhKW91d0FWTwiOB6cKtje8h/kK1lR
         Om6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=vdbJVspABOQcaXCoCvAj4ccG+htx7NQD7qym78msHro=;
        b=FgqsJKU5LOYbiE/7ex1+yivIxsNa5VoGBUvXKMnUGzSnFfQD/dO1g/NuRwj8RN+qOJ
         r+lWNSB2viMX8uIOjTZ7l2qPggHwJz6Dq0qM+0sFLH2KBC+Rs2t/7Dw1A0XVHx5jXQE9
         tUT45A2Y1XnfQ09nJTgMTMoLHdiceTR29bQyTFRfE7N0Mo9rgg0W34R5TNjw8rwDuJse
         LWY9DXdlBZDjMVU1ij9meGpiduh2rXpMNrcRRr0NCAU7VH/ozqSa9G55ZiSUsPRiP13Z
         7e6xKmnKVM1zHbqrOU9Do31F4CKyJq14p9Jv8jsuIVKb1UYJv5ESbbcBAeXKr56V1sW0
         3WTg==
X-Gm-Message-State: AOAM532sdB01ojU0U175Ph7G9oHFLv0NBXZq/BvBl1SObrq0zkXiYlAT
	/6tLEFgMJQHTvq1DbmBrgAMRGg==
X-Google-Smtp-Source: ABdhPJwD8tXEGb0Q02pGABZQMKovoDU+4bajQgbl8pgQoYdPccwcUwquFKR38IE2T+q5ABFlc1RoTw==
X-Received: by 2002:a17:906:b098:: with SMTP id x24mr1689483ejy.744.1644409450678;
        Wed, 09 Feb 2022 04:24:10 -0800 (PST)
Received: from ?IPV6:2a02:578:8593:1200:42a6:e0be:778a:86e8? ([2a02:578:8593:1200:42a6:e0be:778a:86e8])
        by smtp.gmail.com with ESMTPSA id cn15sm2822489edb.37.2022.02.09.04.24.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Feb 2022 04:24:10 -0800 (PST)
Message-ID: <6c6de1be-eb21-76e9-a8d2-c594c8881c7d@tessares.net>
Date: Wed, 9 Feb 2022 13:24:09 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH mptcp-next 0/2] fix mptcp bpf selftest error
Content-Language: en-GB
To: Mat Martineau <mathew.j.martineau@linux.intel.com>,
 Geliang Tang <geliang.tang@suse.com>
Cc: mptcp@lists.linux.dev
References: <cover.1644300192.git.geliang.tang@suse.com>
 <3fa7c8c7-6210-35cd-d038-6e6975539ff9@linux.intel.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <3fa7c8c7-6210-35cd-d038-6e6975539ff9@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Geliang, Mat,

On 09/02/2022 01:21, Mat Martineau wrote:
> On Tue, 8 Feb 2022, Geliang Tang wrote:
> 
>> Fix the mptcp bpf selftest build break.
>>
>> Geliang Tang (2):
>>  Squash to "bpf:selftests: add MPTCP test base"
>>  mptcp: add SNDTIMEO setsockopt support
>>
>> net/mptcp/sockopt.c                            | 2 ++
>> tools/testing/selftests/bpf/prog_tests/mptcp.c | 2 +-
>> 2 files changed, 3 insertions(+), 1 deletion(-)
>>
>> -- 
>> 2.34.1
> 
> These look good for the export branch.
> 
> We did talk about SO_SNDTIMEO about a year ago:
> https://lore.kernel.org/mptcp/5e465bd5f4b3f7e883e09e3f4bc5a566edba045f.camel@redhat.com/
> 
> 
> But Paolo's concern there no longer applies, because the socket option
> changes since then will apply the sndtimeo value to the msk instead of
> the first subflow.
> 
> Reviewed-by: Mat Martineau <mathew.j.martineau@linux.intel.com>

Thank you for the patches and the reviews!

Now in our tree (feat. for net-next) with Mat's RvB tag (on patch 2/2 only):

- 9e3b7120da20: "squashed" patch 1/2 in "selftests: bpf: add MPTCP test
base"
- 0cc76a0dbc16: "Signed-off-by" + "Co-developed-by"
- 0e4737981bcc: mptcp: add SNDTIMEO setsockopt support

Also renamed the title of two patches: s/bpf:selftests:/selftests: bpf:/

- e93e37b063eb: tg:msg: fix prefix order and space
- 0df242af6c98: tg:msg: fix prefix order and space

- Results: 56333e0f13bc..3484d41ff4f2

Builds and tests are now in progress:

https://cirrus-ci.com/github/multipath-tcp/mptcp_net-next/export/20220209T122329
https://github.com/multipath-tcp/mptcp_net-next/actions/workflows/build-validation.yml?query=branch:export

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
