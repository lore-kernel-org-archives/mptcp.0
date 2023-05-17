Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D460E33D5
	for <mptcp@lists.linux.dev>; Wed, 17 May 2023 15:09:14 +0000 (UTC)
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-3f41dceb9d4so8978665e9.1
        for <mptcp@lists.linux.dev>; Wed, 17 May 2023 08:09:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1684336153; x=1686928153;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=A0ubo6KDZ039/ONj4kFUULNG5EkJiaRsQ3wFNON9BLI=;
        b=LyNX1xinlwqMmDx1f2BBPN1cgBXzdrj0EjNsI4wFD6af2taoClfx4aBLeqNwDR8sAL
         jtjH17PSMNgvRoeVJZlwRheVAAfx3MRiKaTV8rAXnOEfMHj4nEQGnpr1z6N1dRyU8bNJ
         D1FaC0gwth/GHmX6R6K8QIbW9ZFeKuXqk8IxEmxUjnp5exolENKUrChxWF51h5hPg1Y5
         fT8VCyXZvs8FiID2ihjNf5WoseaZ1zW9VXolLb113wRsfaj8QfKLyL2BduAUmjJ0WUJa
         ndSFvx+H2PUG4z0sbaA1jxza05wYv8f5bM9GkvmgxzS2TgTjrnl13i7K8DPbMgkQvFgZ
         0RtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684336153; x=1686928153;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=A0ubo6KDZ039/ONj4kFUULNG5EkJiaRsQ3wFNON9BLI=;
        b=bcBRo0n2L02HrJ3HjDUtg1biBLvVQ+Ie3eDn8OXi3J1hskYyrgn3UQ6M4qvvKOFSVL
         Fr1oNiWIPQUJuWahp1CAjUkESKa7WXq02mkGduuZxVlEG9gb85tNZnbuiw4mBx2B8oIn
         BPtLnIgRE819+C/t/H49EoAw0xL/o+Yck2lNM1mEWYOPgc0nUFJdK/rEGievWhhXcIVC
         Z4G1owCA9LzBNffgtyb2E/Lzu6VpVk84XKN11NR9fe7/vO167uKuyZ7RI7C3o15c2xGA
         csYtRboBJa//ZXnL2E3GKDfijYgtWvYCgk2l3o4WzCY6vYuwEffQjq3hdcICTqO4Kczj
         lVfg==
X-Gm-Message-State: AC+VfDwoyhW0sMfZw9kWPYVfcls0OGSMM83kyIUhd0/eoOsvyH9S5c89
	ot/nUDSdyTmm8MIdVDUV50v7IDP7NYHB8S4UGYM=
X-Google-Smtp-Source: ACHHUZ544wDI/o5PpBGrsSWRZtlaIHp+0VWFR3Fr35m+H2TwddzwWk1rmJsA2YDAZH36sRD7WoHXhg==
X-Received: by 2002:a1c:7913:0:b0:3f4:2e13:ccdc with SMTP id l19-20020a1c7913000000b003f42e13ccdcmr21454068wme.0.1684336152379;
        Wed, 17 May 2023 08:09:12 -0700 (PDT)
Received: from ?IPV6:2a02:578:8593:1200:a66b:672f:3b69:b6da? ([2a02:578:8593:1200:a66b:672f:3b69:b6da])
        by smtp.gmail.com with ESMTPSA id w19-20020a1cf613000000b003f42461ac75sm2545733wmc.12.2023.05.17.08.09.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 May 2023 08:09:11 -0700 (PDT)
Message-ID: <26685dad-1696-ac8d-8562-ceca9948907d@tessares.net>
Date: Wed, 17 May 2023 17:09:11 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH mptcp-next v3 1/6] selftests/bpf: add two mptcp netns
 helpers
Content-Language: en-GB
To: Geliang Tang <geliang.tang@suse.com>, mptcp@lists.linux.dev
References: <cover.1684331602.git.geliang.tang@suse.com>
 <2447b5f6250b3070b53030ec83514932a1c15a97.1684331602.git.geliang.tang@suse.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <2447b5f6250b3070b53030ec83514932a1c15a97.1684331602.git.geliang.tang@suse.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Geliang,

On 17/05/2023 15:57, Geliang Tang wrote:
> Add two netns helpers for mptcp tests: create_netns() and
> cleanup_netns(). Use them in test_base().
> 
> Signed-off-by: Geliang Tang <geliang.tang@suse.com>
> ---
>  .../testing/selftests/bpf/prog_tests/mptcp.c  | 29 +++++++++++++------
>  1 file changed, 20 insertions(+), 9 deletions(-)
> 
> diff --git a/tools/testing/selftests/bpf/prog_tests/mptcp.c b/tools/testing/selftests/bpf/prog_tests/mptcp.c
> index de8b6c68fc30..d008388554de 100644
> --- a/tools/testing/selftests/bpf/prog_tests/mptcp.c
> +++ b/tools/testing/selftests/bpf/prog_tests/mptcp.c
> @@ -142,6 +142,23 @@ static int run_test(int cgroup_fd, int server_fd, bool is_mptcp)
>  	return err;
>  }
>  
> +static struct nstoken *create_netns(void)
> +{
> +	SYS(fail, "ip netns add %s", NS_TEST);
> +	SYS(fail, "ip -net %s link set dev lo up", NS_TEST);
> +
> +fail:

Should you not return NULL in case of error not to start the test if the
environment is not OK?

	SYS(fail, "ip netns add %s", NS_TEST);
	SYS(fail, "ip -net %s link set dev lo up", NS_TEST);

	return open_netns(NS_TEST);

  fail:
	return NULL;

> +	return open_netns(NS_TEST);
> +}

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
