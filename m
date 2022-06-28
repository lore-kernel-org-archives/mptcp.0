Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 496EE7A
	for <mptcp@lists.linux.dev>; Tue, 28 Jun 2022 09:42:34 +0000 (UTC)
Received: by mail-wr1-f44.google.com with SMTP id e28so11648519wra.0
        for <mptcp@lists.linux.dev>; Tue, 28 Jun 2022 02:42:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=pU8aRTsvKtbD2Q+oPIOFeZ00oSdCebpL4fFU2CnZhFU=;
        b=erUPjVVWFAf8JUZNwDf9NBx2Jx5SUxrL+Foz6yv498fPJFmXguqse6ZZAOnf86qr4t
         xtaw+baKj+6rbWlc9OIrynZMnAiVWbWNT1OScNunXb+87CIf6i0+JX7tSOcsKhK9imkD
         qXFaAZXdVu0MvSGc3joXxgPlPWvDCMVIwY4Gp/8gMKgIigcTADyZkxp40OyHdSpkBeMY
         vQ9qk1z4gMfqr8VHzN9H7gvJdi8m1ibBTAxPNIRb/YpHaS4ZWLqOAlKY0xnhe1mzIhBe
         DKP96ey2l6AVwG3WlwCMZMfnax1Szlg4pHcK5wpA22XCWEMF/QL2smjKmTNgYmcZUCLc
         OfYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=pU8aRTsvKtbD2Q+oPIOFeZ00oSdCebpL4fFU2CnZhFU=;
        b=sh4KfR7thG3Y5FekxeQkxldnFbPSGe/S+G67L9u0kE3PPQxCnNyOmbW13NLjC9nuPe
         Svsm74/EHD4JVcfoSkzPpED577wi727rALlxnIjJn4sjW97Fi9OE/4NhLoQkNloMkQXZ
         d1MRVnF5Ar2viM0Hr+tVY8oolB3ng3bAsKHJNJwAaj+9Gw1hW5hwrapR6hSNxR/mW7Xy
         ZSY8sP1EWXLMW9yLLCXOaLXedBw67xvKt/WzCMTBTEfdxrU/GQSoJgTV4xhkIbKTEnjv
         fb2a6w3wgIDcYCkqWvmhBIdm5f5L/3CljrYlPC9oYsjY/Hnht4iRadYKLWCpXXl2go8c
         S/gw==
X-Gm-Message-State: AJIora+3kbc8KAUCwl09rXMvH71Mj3WiQr0zkRuPwwYLCV0ypthXec9n
	a4Q91LBHMVU374KUv2Ju5kvja//flqPXIr4k
X-Google-Smtp-Source: AGRyM1sO8oFdKJDkLUdHKFUqLu3VCj23mH7GZZuIiqC8HImSHhRUmA+U+qBIn38O/1iUAW3R73/P/w==
X-Received: by 2002:a5d:4a48:0:b0:21b:9ee2:a6e0 with SMTP id v8-20020a5d4a48000000b0021b9ee2a6e0mr16508358wrs.468.1656409353145;
        Tue, 28 Jun 2022 02:42:33 -0700 (PDT)
Received: from [10.44.2.26] ([81.246.10.41])
        by smtp.gmail.com with ESMTPSA id n7-20020a5d67c7000000b0021b9e8d4c22sm13219434wrw.61.2022.06.28.02.42.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Jun 2022 02:42:32 -0700 (PDT)
Message-ID: <acfcb031-4be5-c5a2-6858-02fed78a89f3@tessares.net>
Date: Tue, 28 Jun 2022 11:42:32 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH mptcp-next] Squash-to: "selftests: mptcp: tweak
 simult_flows for debug kernels"
Content-Language: en-GB
To: Mat Martineau <mathew.j.martineau@linux.intel.com>, mptcp@lists.linux.dev
Cc: pabeni@redhat.com
References: <20220627214438.17887-1-mathew.j.martineau@linux.intel.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <20220627214438.17887-1-mathew.j.martineau@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Mat,

On 27/06/2022 23:44, Mat Martineau wrote:
> kbuild is still seeing intermittent failures in the simult_flows.sh
> test. It uses a kernel config without kmemleak, but with other
> performance-affecting debug options like lockdep and kasan.
> 
> Example failures:
> kernel-selftests.net/mptcp.simult_flows.sh.unbalanced_bwidth_with_unbalanced_delay_transfer_slower_than_expected!_runtime_4339_ms_expected_4005_ms_max_4005.fail
> kernel-selftests.net/mptcp.simult_flows.sh.unbalanced_bwidth_transfer_slower_than_expected!_runtime_4285_ms_expected_4005_ms_max_4005.fail
> kernel-selftests.net/mptcp.simult_flows.sh.unbalanced_bwidth_transfer_slower_than_expected!_runtime_4346_ms_expected_4005_ms_max_4005.fail

If I'm not mistaken, adding 200ms would not prevent these failures if
you got 4346ms instead of 4005ms, right? It looks like we need to extend
the time to something around 350ms.

> Adjust the debug detection to loosen the simult_flows timing constraints
> if either kmemleak or lockdep are configured.

Good idea!
I didn't find any "safe" ways to easily check that KASAN is used.

Checking dmesg doesn't seem to be a safe way for all environments.

But maybe we could do this? (with '-q')

  $ grep mm/kasan /sys/devices/system/cpu/hotplug/states/sys/devices
  /system/cpu/hotplug/states:70:214: mm/kasan:online

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
