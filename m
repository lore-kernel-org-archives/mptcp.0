Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC0C35394
	for <mptcp@lists.linux.dev>; Wed,  6 Jul 2022 17:19:32 +0000 (UTC)
Received: by mail-ej1-f53.google.com with SMTP id dn9so22959769ejc.7
        for <mptcp@lists.linux.dev>; Wed, 06 Jul 2022 10:19:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:cc:from:in-reply-to:content-transfer-encoding;
        bh=y39/flcK9gBKJPblPtBm5yjxp89WMJ/BUpfPGYygEiI=;
        b=41KM1slf2E5oEJnF6o5JIkW/WoYDrYzfXOvN1WAtrDuny2571f7PiMolHheq18hBJ7
         CuIJ3JyT0+RjxZvg1R/Sz9su0I2q7tjDX2a/4qIFYDywN8xLmPvO0GEvq/HrSZCzbWf5
         BjdGckWyiWBW+/N6Ttq79M5OrVhItFQS4Ga15B3BYZqGuh80GTcxFsc0Oc8b8dkjVVxW
         gJfa0JQrrB7YQJJFTO2MiJ2okuYTFb7xDLFsxEZcGu72xU2HuEsCzZq1qZkc3GMANEqD
         T00fvPxYsN+eVO74AyOCGZgPSRixNmhOtSSxEWBHBnDBHxsTLGcRjzuyRDMbWZcMNNHc
         7IBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:cc:from:in-reply-to
         :content-transfer-encoding;
        bh=y39/flcK9gBKJPblPtBm5yjxp89WMJ/BUpfPGYygEiI=;
        b=O/zi1FVoWk8kg0QzcAVNT5cxiflx6E/Ott8vLHTReRAjedC7iSxAorWettDr14SVm1
         WvinE/om8mSm+IpJBeMnBnK+7t3IVfsYw9A1QWGRYTQKsSgYlVk2PcZ9P2BypTemxTND
         gMu1EhN1sUYa9DFRHTom/8SWokF68O5W2sMbPpM/v0C1fvrEWo8YzmRWcb5g3F6vacOo
         7fHyq0kgUz9N45IWbfMClmsiNgXrzPjNjEMN90Vel/cR5COMmstYjhfheihDI54fhiMI
         NQxpmg9nq02KsI0TwLIA3HPwvcu5FnDJJjRTiRKLwFbHuAYq4KM7S4t74eeS3SH3bPau
         QD2w==
X-Gm-Message-State: AJIora+l1W+2ukO7/9EcC8v7pRzFJqpzpgdk624uH2LpqsiXedKiSiZ2
	ZP4jJNDPhUndWaqtTVtumB4cHLTJVBFVJVMb
X-Google-Smtp-Source: AGRyM1vN3kgkn5rXiIqroRamU+mAdVMjXcAJiH+2jiRnP3U6WyS14i/FTlEyoZng8shQJdNCNcGY5Q==
X-Received: by 2002:a17:906:4ccc:b0:6fe:9155:47ae with SMTP id q12-20020a1709064ccc00b006fe915547aemr39416325ejt.246.1657127970809;
        Wed, 06 Jul 2022 10:19:30 -0700 (PDT)
Received: from ?IPV6:2a02:578:8593:1200:c688:fc49:57d7:6b4c? ([2a02:578:8593:1200:c688:fc49:57d7:6b4c])
        by smtp.gmail.com with ESMTPSA id w3-20020a1709067c8300b00722fc0779e3sm17668365ejo.85.2022.07.06.10.19.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Jul 2022 10:19:30 -0700 (PDT)
Message-ID: <e0de5399-26b1-ca64-47af-6a8fdfa271cc@tessares.net>
Date: Wed, 6 Jul 2022 19:19:29 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH mptcp-next v2] Squash-to: "selftests: mptcp: tweak
 simult_flows for debug kernels"
Content-Language: en-GB
To: Mat Martineau <mathew.j.martineau@linux.intel.com>
References: <20220705235144.221591-1-mathew.j.martineau@linux.intel.com>
Cc: mptcp@lists.linux.dev
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <20220705235144.221591-1-mathew.j.martineau@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Mat,

On 06/07/2022 01:51, Mat Martineau wrote:
> kbuild is still seeing intermittent failures in the simult_flows.sh
> test. It uses a kernel config without kmemleak, but with other
> performance-affecting debug options like lockdep and kasan.
> 
> Example failures:
> kernel-selftests.net/mptcp.simult_flows.sh.unbalanced_bwidth_with_unbalanced_delay_transfer_slower_than_expected!_runtime_4339_ms_expected_4005_ms_max_4005.fail
> kernel-selftests.net/mptcp.simult_flows.sh.unbalanced_bwidth_transfer_slower_than_expected!_runtime_4285_ms_expected_4005_ms_max_4005.fail
> kernel-selftests.net/mptcp.simult_flows.sh.unbalanced_bwidth_transfer_slower_than_expected!_runtime_4346_ms_expected_4005_ms_max_4005.fail
> 
> Adjust the debug detection to look for more kernel debug features and
> further loosen the simult_flows timing constraints if any of those
> features are detected.
> 
> v2: Use kallsyms for debug feature detection, increase the debug timeout.

Thank you for the v2!

- a240e7e697a6: "squashed" in "selftests: mptcp: tweak simult_flows for
debug kernels"
- 3925007b31c6: "Signed-off-by" + "Co-developed-by"
- Results: 7d868133e0d9..bf96db80c6d5 (export)

I left the Co-dev tags because they make sense and I'm sure you will
change the tags anyway when sending them to netdev :)


Builds and tests are now in progress:

https://cirrus-ci.com/github/multipath-tcp/mptcp_net-next/export/20220706T171803
https://github.com/multipath-tcp/mptcp_net-next/actions/workflows/build-validation.yml?query=branch:export

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
