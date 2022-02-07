Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 881CB2C9C
	for <mptcp@lists.linux.dev>; Mon,  7 Feb 2022 20:23:58 +0000 (UTC)
Received: by mail-ed1-f50.google.com with SMTP id f17so15565908edd.2
        for <mptcp@lists.linux.dev>; Mon, 07 Feb 2022 12:23:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=4ph6trIdBD+9MR2S5liKDSb97sVacQQDJTgOgycAtGQ=;
        b=s7eATdPaeRxfPiNVfpQLA5lIuz3SNy7GHZIUU5IVFCYTUDM3MO2tqOmOKVTh688c6w
         ZtdE4luyJjJRrGtZtwUM1WP8ShiNpwGerKUZeMFPBThEEZSPmSOdNPmWfD8J6aC4Jc1n
         M08GRfvyPtu9gcZAgUeR+7xA3TTXZaAOjn0RsEr0H36JNSMtGPUlFbm7qa61YP1dnZSk
         6DUOTwf6YhkAG5JSBw2lG2rIByAlRF1RNFuH1P+AMTs+bBuwZZOfjjo2+1EJHc63hGWx
         n/JOGrLDFszCVqhXeRg82IWBCL7+5WQrhHm2okKIFJUr2UmRQtRTJxlyJ4yDgHBK1xCV
         Spyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=4ph6trIdBD+9MR2S5liKDSb97sVacQQDJTgOgycAtGQ=;
        b=StD8Z1XDxaLzBQ0FkGfgm9VVgxl2RiO9FDQTxd0QJdmCdYn4kvbeRsnJ9a0m8Rs3vM
         mDWRVMzbWkKGn/bU/iEI3oC9HF9o35ZXQW+uZ++NvnnsTVru7t5s370beL8bVZtgt5Kl
         BTc4RsyNtFLaJSAMPUVRYDpkLr0wtizP2JuuMBxNuyHrmAQ+3M9FFr9bbxEuI3Zq31D5
         IjM+tvg++5akva0N/9b5Uy/X/ld9h81nYrFQ0zwwhDE2SWimKUxuRTvUICXE07Epi9xH
         CPNiQTZSGklwZV6cyOJdti1tXkJvxYn3yNn4W7aggNrMI5xkkc3L2aG0LnByEj57fT6m
         AcsA==
X-Gm-Message-State: AOAM532YnuKRVNTIMbh5oFXG8m5L5gwEb3nkYB5eTgDlk8QElDxWbVXa
	R8Ivlq1b8ItwR1DNh+u/T84Su1sx4hEHyN/SM88=
X-Google-Smtp-Source: ABdhPJwPDy4yx8VgWPpVtg38AWLFgmvQU4KhUtEeOccIoUnVuNYObpeE3U+iDrR1gCIJtngoPceEdg==
X-Received: by 2002:a05:6402:34d3:: with SMTP id w19mr1162211edc.377.1644265436539;
        Mon, 07 Feb 2022 12:23:56 -0800 (PST)
Received: from ?IPV6:2a02:578:8593:1200:c5d8:4d2c:64dd:bf38? ([2a02:578:8593:1200:c5d8:4d2c:64dd:bf38])
        by smtp.gmail.com with ESMTPSA id cz12sm690834edb.30.2022.02.07.12.23.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Feb 2022 12:23:55 -0800 (PST)
Message-ID: <785a3195-7fec-5809-f632-8a97714d84a9@tessares.net>
Date: Mon, 7 Feb 2022 21:23:55 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH mptcp-next] selftests: mptcp: increase timeout to 1 hour
Content-Language: en-GB
To: Mat Martineau <mathew.j.martineau@linux.intel.com>
Cc: mptcp@lists.linux.dev
References: <20220207100022.3936015-1-matthieu.baerts@tessares.net>
 <4fc5f913-3a8-38a0-7898-8949472c83ec@linux.intel.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <4fc5f913-3a8-38a0-7898-8949472c83ec@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Mat,

On 07/02/2022 20:49, Mat Martineau wrote:
> On Mon, 7 Feb 2022, Matthieu Baerts wrote:
> 
>> With the increase number of tests, on a slow public CI with kernel debug
>> settings, it has been observed it can easily and regularly take up to 45
>> minutes to execute all tests in this very slow environment. The slowest
>> test, mptcp_join.sh takes ~30 minutes in this case.
>>
>> In such environments, the selftests timeout set in the 'settings' file
>> is disabled. But because other similar environments can be used to run
>> MPTCP selftests, it is certainly better to increase the timeout for
>> everybody else to 1h.
>>
>> Most of the time, running all MPTCP selftests takes around 5 to 10
>> minutes on decent environments and the slowest test takes less than 10
>> minutes, the current timeout.
>>
>> The timeout could be disabled but it is always good to have an extra
>> safeguard, just in case.
>>
> 
> I agree that it's good to have some timeout in place for our tests. An
> hour seems like a lot, has there been any feedback from others with CI
> as slow as ours?
> 
> The largest existing selftest timeout is 1500 (net/settings), and
> looking at the kbuild logs it takes their infrastructure 28 minutes to
> run the net tests and 11 minutes to run the MPTCP tests. What do you
> think about a smaller timeout increase for the MPTCP tests?

I can, it would be enough for my CI. But not for a setup like the public
CI where mptcp_join.sh tests can take up to 30 minutes and it keeps
increasing.

But if you prefer, I can double the current value and that's enough for
my case. What do you prefer?

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
