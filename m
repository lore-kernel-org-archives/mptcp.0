Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34BC713AC3
	for <mptcp@lists.linux.dev>; Thu, 29 Jun 2023 17:48:51 +0000 (UTC)
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-992acf67388so102645866b.1
        for <mptcp@lists.linux.dev>; Thu, 29 Jun 2023 10:48:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1688060930; x=1690652930;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jCOu5umcM4FreWiU3hTtxszBZZtwMtc0cYPS4oyqCjc=;
        b=EfaH+bQQhm0gChKOT/1pB2UwuN/VmmauN8858XZjhb4ZkkxOKD/pPY+LmJuSuiu5oc
         ULwAXlk0EirAZZVszMOvBqTvdLsepgRw+TYWf/YpZVkfR2PPGHrw87o+Ln7MV+6QNPSm
         h2evmqvVUE/klpSlAsYY0/CRo1QttKINrACmkx7GK20bu3lJ0ZhSVOWiRblLE+0RdgE4
         1r2jloFRKfdGpNULWcXyIsfMxaD65B3yPBsAeQYaSYE7VI2YGj0HxeubTXuu54Q/KdMx
         ofA0tb1y4vIfFhsrdnq7+CFSqEU9WxWeiFTekKgXg1OUpODCX4btwhwgSken3TAjZR1O
         kjMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688060930; x=1690652930;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jCOu5umcM4FreWiU3hTtxszBZZtwMtc0cYPS4oyqCjc=;
        b=AzzJvpVbp9u+Lb1frOL1FF9uMOr9Ux59cMbR6wwi3DEUKkgUnyxeLg+TD6/9Lsk1f6
         4TL0oIYI3zJrD5b7zmw8mHt6FuoF65kN7r7bZRq/ibwwiU6rW9HXYXtitdDX6/WCfrIk
         85p/+9mBUShUYoWcfR/1MNJORlUpgTFkS07EENyH/A83LS6jj6fduIYMngrwQSSJpTQH
         EJVLCL3Rl2XPa/tq5RfeknWo4x455VUsFthW/GnflCSGLveu/3eJU0ToilyoV5htqsLA
         NzWxeZiLgmM29hvkacH2QvjLZti3vox6BlYskcXMKtXX7Muwhzs6p9mhN9LO/JyFmc0e
         BeYA==
X-Gm-Message-State: ABy/qLZgXYn1or/5oR7ZALqhIG+b1SIRh7pD1AyP99JWggPmVtuT0BIU
	UsY98fQP50oFMTVyolv+1rWlA6SBI/wbFz3TKucYH7X7
X-Google-Smtp-Source: APBJJlGcORobsrJ7kRTQMM+W7+ho2f9wcSf90tBDkDunN3ripVGUaAzVHpB7HvQyfYf2URSAvGQ5Sw==
X-Received: by 2002:a17:906:85d3:b0:974:56aa:6dce with SMTP id i19-20020a17090685d300b0097456aa6dcemr135157ejy.46.1688060930107;
        Thu, 29 Jun 2023 10:48:50 -0700 (PDT)
Received: from [10.120.18.108] ([84.17.46.13])
        by smtp.gmail.com with ESMTPSA id k25-20020a17090666d900b009821ce1ea33sm7125617ejp.7.2023.06.29.10.48.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Jun 2023 10:48:49 -0700 (PDT)
Message-ID: <833abcfe-9639-7bf4-49f3-ddc301268a62@tessares.net>
Date: Thu, 29 Jun 2023 19:48:48 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH mptcp-next 1/4] selftests: mptcp: reset all the env vars
Content-Language: en-GB
To: Geliang Tang <geliang.tang@suse.com>, mptcp@lists.linux.dev
References: <cover.1688045383.git.geliang.tang@suse.com>
 <b0879a1289735ff45305ec2a7d159666b7b5219e.1688045383.git.geliang.tang@suse.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <b0879a1289735ff45305ec2a7d159666b7b5219e.1688045383.git.geliang.tang@suse.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Geliang,

Thank you for looking at that!

On 29/06/2023 15:34, Geliang Tang wrote:
> It's better to clear all the env vars in init_partial(), to let them be
> reset before runing the next test.
> 
> Signed-off-by: Geliang Tang <geliang.tang@suse.com>
> ---
>  tools/testing/selftests/net/mptcp/mptcp_join.sh | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
> index e6c9d5451c5b..b80c5e7b5a7b 100755
> --- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
> +++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
> @@ -101,6 +101,10 @@ init_partial()
>  	check_invert=0
>  	validate_checksum=$checksum
>  	FAILING_LINKS=""
> +	test_linkfail=0
> +	addr_nr_ns1=0
> +	addr_nr_ns2=0
> +	sflags=""

I think it would be better to move the declaration of these variables to
do_transfer() (or run_tests()) instead of exporting them at the
beginning of the file, no?

You could do something like:

  local test_linkfail=${test_linkfail:-0}

So by default, it will have the value 0. But if you do

  tests_linkfail=3 \
      run_tests (...)

It will have the value 3 just for this test. WDYT?

It looks better than defining the variables globally and resetting them
elsewhere.

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
