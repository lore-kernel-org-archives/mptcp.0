Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C496415BA
	for <mptcp@lists.linux.dev>; Thu, 28 Sep 2023 20:56:51 +0000 (UTC)
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-5041d6d8b10so21993133e87.2
        for <mptcp@lists.linux.dev>; Thu, 28 Sep 2023 13:56:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1695934609; x=1696539409; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vTGjh0vQVsUf+R+Ns3yz5U/L9gFQ3z2dOaFUubteweo=;
        b=O4TAJgK4UQDMVhWC+4MNUj8UMHkLav3evmPW2QTyON26Z8TBEdm90qFjbgVzYVAwra
         e4DIdQ4Dzc0aPyXjqJylmzFKT73aLmqK/JoMxbH0lsNb0uIOGt7EJE4V0f/oga1JFLzL
         ybWHmuGfP0a+avJe1gL27mRtUOr86kSgsK+iw1JmhrcYze51joJx9ObfqZ99UVDLKsEI
         zLLKp2Wm8B1tzl6nwos7DX9YRm2oS5RloBjLlX0w6twlX+tzU7DEBGnXyCih+3NNizQN
         SSy7OYMxS9goBHJdtmy1YCf6n9V6wbB1GQA3TM3mvPFYLPly9SzrW8vjJWxftC4U5m2O
         zq3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695934609; x=1696539409;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vTGjh0vQVsUf+R+Ns3yz5U/L9gFQ3z2dOaFUubteweo=;
        b=JDgXrQhaPHsM5sD9ghybr3pKW7N6K7KVsNOwaiIoDTrjh/WUSUey4f5sfMYDALoQW9
         uadLdmFsg0A6LQr8r4VnHsJ5IPoNH4RNEOHBiNV3THPBF/qzroH2QyogBNrVGH0WWEGy
         O0LLeDzoMZHl2GlEXLkYOMObtGzc2s+i9c0k9K875DLnFcTNt3pd5q7NNT0sn/ifZjGQ
         d72FVVGBpzurn1ZdtGN45mri0PeVIuR6MyJaSKyPTNAw3mJ0I4FeJy/jQ7piTa5DUFqH
         tfUdWsWlj5bS/uKLk4wKDnV5zE2FS7fAPNbvF6cMiC6ZAqLCnpOEpS/ThmRLGaNIQk+F
         svmw==
X-Gm-Message-State: AOJu0Yy+0IWamBZcLlOzeBhczqZTAPZNvEPZwiMwegaG3jC0BTxIJhHC
	o6X+o0HRxChxKGgbwmv3On3jS7si9k5uyMwefpzLlw==
X-Google-Smtp-Source: AGHT+IGvlus12b0PSdfcAHIws6CKVP+rLS+YAHqRRXAcT+9OknZB9/mwKEFMV2nsPSO3RiiL/HsK0Q==
X-Received: by 2002:a05:6512:2508:b0:502:a588:6609 with SMTP id be8-20020a056512250800b00502a5886609mr3011292lfb.3.1695934609336;
        Thu, 28 Sep 2023 13:56:49 -0700 (PDT)
Received: from ?IPV6:2a02:578:8593:1200:ff86:e30:98cd:120? ([2a02:578:8593:1200:ff86:e30:98cd:120])
        by smtp.gmail.com with ESMTPSA id ec20-20020a0564020d5400b005346a263bb1sm3950153edb.63.2023.09.28.13.56.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Sep 2023 13:56:49 -0700 (PDT)
Message-ID: <060967a9-d00a-43b8-9604-7784648e4601@tessares.net>
Date: Thu, 28 Sep 2023 22:56:48 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH mptcp-next v3 11/29] selftests: mptcp: update userspace pm
 test helpers
Content-Language: en-GB, fr-BE
To: Geliang Tang <geliang.tang@suse.com>, mptcp@lists.linux.dev
References: <cover.1695631132.git.geliang.tang@suse.com>
 <b710fb0a444af95d66de887fe535d889ac53d119.1695631132.git.geliang.tang@suse.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
Autocrypt: addr=matthieu.baerts@tessares.net; keydata=
 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
In-Reply-To: <b710fb0a444af95d66de887fe535d889ac53d119.1695631132.git.geliang.tang@suse.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Geliang,

On 25/09/2023 10:41, Geliang Tang wrote:
> This patch adds a new argument namespace to userspace_pm_add_addr() and
> userspace_pm_add_sf() to make these two helper more versatile.
> 
> Add two more versatile helpers for userspace pm remove subflow or address:
> userspace_pm_rm_addr() and userspace_pm_rm_sf(). The original test helpers
> userspace_pm_rm_sf_addr_ns1() and userspace_pm_rm_sf_addr_ns2() can be
> replaced by these new helpers.

Thank you for cleaning this!

> diff --git a/tools/testing/selftests/net/mptcp/mptcp_lib.sh b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
> index def35395a254..bb95dd967eb3 100644
> --- a/tools/testing/selftests/net/mptcp/mptcp_lib.sh
> +++ b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
> @@ -8,6 +8,8 @@ readonly KSFT_SKIP=4
>  # shellcheck disable=SC2155 # declare and assign separately
>  readonly KSFT_TEST=$(basename "${0}" | sed 's/\.sh$//g')
>  
> +SUB_ESTABLISHED=10 # MPTCP_EVENT_SUB_ESTABLISHED

Because variables are "global" by default in Bash, it might be good to
prefix this variable with MPTCP_LIB_ (or "MPTCP_EVENT_SUB_ESTABLISHED")
to avoid any accidental conflicts when using "too generic names". But
then the name will be long and you will have to rename it in many places
in userspace_pm.sh and that's not nice I think...

If we want to keep it short, maybe easier to declare SUB_ESTABLISHED in
both userspace_pm.sh and mptcp_join.sh. It might be better like that
because otherwise it looks strange to only declare this one in the lib
and not the other ones (ANNOUNCED, REMOVED, etc.).

If we only need to copy it in mptcp_join.sh and userspace_pm.sh, I can
do that when applying the patches.

Cheers,
Matt

> +
>  MPTCP_LIB_SUBTESTS=()
>  
>  # only if supported (or forced) and not disabled, see no-color.org
> diff --git a/tools/testing/selftests/net/mptcp/userspace_pm.sh b/tools/testing/selftests/net/mptcp/userspace_pm.sh
> index 2413059a42e5..283c62deb628 100755
> --- a/tools/testing/selftests/net/mptcp/userspace_pm.sh
> +++ b/tools/testing/selftests/net/mptcp/userspace_pm.sh
> @@ -25,7 +25,6 @@ fi
>  
>  ANNOUNCED=6        # MPTCP_EVENT_ANNOUNCED
>  REMOVED=7          # MPTCP_EVENT_REMOVED
> -SUB_ESTABLISHED=10 # MPTCP_EVENT_SUB_ESTABLISHED
>  SUB_CLOSED=11      # MPTCP_EVENT_SUB_CLOSED
>  LISTENER_CREATED=15 #MPTCP_EVENT_LISTENER_CREATED
>  LISTENER_CLOSED=16  #MPTCP_EVENT_LISTENER_CLOSED

-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
