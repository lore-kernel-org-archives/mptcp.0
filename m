Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08B7F23A1
	for <mptcp@lists.linux.dev>; Fri, 25 Feb 2022 13:36:55 +0000 (UTC)
Received: by mail-ed1-f43.google.com with SMTP id s14so7526465edw.0
        for <mptcp@lists.linux.dev>; Fri, 25 Feb 2022 05:36:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:cc:from:in-reply-to:content-transfer-encoding;
        bh=Js8a8drVmfXGYlJBj/9woeUoGPUWPuJJhFOrR5aSSiw=;
        b=4Qnc6iiEoelBcGRWMW3pzrQI61PjSUHoED4NeVRmFW1kzproA52WQ/DaFwsvyj9ChG
         yl+AXpcES42c72A/zmqNcOkVqa+3hR/Ek25klIsbOdcnMjjMH00l772DWNmcwcnOBO4Q
         Jn/e5fg2SuMvwdjWdsATYAinxaQDgvhWzTxkbEvmvHCQvmeFM5xEkqiDlYRdpFcL2/wE
         60FjTwJ7DrmV2YKnbhYCp3b6XvvQ/EInTqa87s7hWAbNXaXq7sxdneVlD6uwKraZdS5O
         CN4Ra9sibLe617Cs3mbk2iXSR7ll+dEiH02wbWXRoEuCJqVuO582/3WwfHPl5CUEqk4r
         6jLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:cc:from:in-reply-to
         :content-transfer-encoding;
        bh=Js8a8drVmfXGYlJBj/9woeUoGPUWPuJJhFOrR5aSSiw=;
        b=7nKr7SOhf/DiFpqTKimfzNF2W92QbTSCcHGBDMdXcXJtx/5PBfET2v2coGTR20uwTR
         On0iKGz/9OoZoRNxvR2jati71D3vWSF09+qUCIeT2tyw+QzkXXqcMJ+2lBPgWdzQJq5c
         2VBN6utT2jFzE0oquVhGBmskuvRxOWQVNEoD19l+Z7v0R0XaPhDo6rIwyRKJlrc4/kmK
         vdiTsiHGYd1hEPVvpulkq7FUkqsiwjOBnPb1Jv7vs//3+og1b9K720FlOXNbY81Xo8gg
         hXKAAeExPkzSJlI/H54SCjvXlrFX5raxNCg08R31hZiai8nzzoL/0KyvnFul8iMz6iTQ
         ZavQ==
X-Gm-Message-State: AOAM533t6E0b7OPD2i2nzcXLzqZoZF6nACdPTE7ksS1Zujrf5Nvgnkuv
	sfQBZENYcfUF8k+ebn2/r5jq+oLaGE3r7Fr4
X-Google-Smtp-Source: ABdhPJxeDu0Lrh3556kcL8V6MEh4IEEIPHg5yIWVf9+l6EI3ypEsu5jTLi3PumqDXq+t/HbfQTZwJw==
X-Received: by 2002:a50:aa87:0:b0:40f:28a0:d0d6 with SMTP id q7-20020a50aa87000000b0040f28a0d0d6mr7287508edc.368.1645796214187;
        Fri, 25 Feb 2022 05:36:54 -0800 (PST)
Received: from ?IPV6:2a02:578:8593:1200:46bf:f117:2ce:9a9d? ([2a02:578:8593:1200:46bf:f117:2ce:9a9d])
        by smtp.gmail.com with ESMTPSA id e9-20020a170906c00900b006d4a45869basm1023910ejz.199.2022.02.25.05.36.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Feb 2022 05:36:53 -0800 (PST)
Message-ID: <7ea897e3-37b5-3996-ab06-b9993cf82cbc@tessares.net>
Date: Fri, 25 Feb 2022 14:36:53 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH mptcp-next v4 00/12] Refactor mptcp_join.sh
Content-Language: en-GB
To: Mat Martineau <mathew.j.martineau@linux.intel.com>
References: <20220224213406.3127061-1-matthieu.baerts@tessares.net>
Cc: MPTCP Upstream <mptcp@lists.linux.dev>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <20220224213406.3127061-1-matthieu.baerts@tessares.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Mat,

On 24/02/2022 22:33, Matthieu Baerts wrote:
> This fixes 3 issues introduced in v3:
> 
> - patch 3/12 reworks more the original patch not to increment the counter
>   per subtest. See the commit message for more details.
> 
> - patch 7/12 modifies the new 'reset' functions recently added
> 
> - patch 12/12 fixes a typo reported by Geliang
> 
> I also move "helper to filter TCP" patch sooner, before the clean-up.

Thank you for the review!

Now in our tree with your RvB tags where it was missing:

Squash-to patches:

- 3cf781e00952: "squashed" patch 01/12 in "selftests: mptcp: Add tests
for userspace PM type"
- d2eea8383653: "Signed-off-by" + "Co-developed-by"
- Results: 8fe46ed11c27..258cadbd8399

- bdc0934aee32: "squashed" patch 02/12 in "selftests: mptcp: join: allow
running -cCi"
- 36f524524558: tg:msg: adapt 'selftests-mptcp-join-allow-running-cCi'
- 3380e67af5d9: conflict in
t/selftests-mptcp-add-implicit-endpoint-test-case
- Results: 258cadbd8399..35ba827a8b1e

- 66cc24cd88ee: "squashed" patch 03/12 in "selftests: mptcp: add
implicit endpoint test case"
- 5782c65ac1fa: "Signed-off-by" + "Co-developed-by"
- Results: 35ba827a8b1e..0c1c6c50d9dd

The other patches:

- aca1cdceb825: selftests: mptcp: join: define tests groups once
- b33b509b2f26: selftests: mptcp: join: reset failing links
- 87c975a5d421: selftests: mptcp: join: option to execute specific tests
- f5c2075414ae: selftests: mptcp: join: alt. to exec specific tests
- 78fb82cf3c8c: selftests: mptcp: join: list failure at the end
- ae1b2dd743aa: selftests: mptcp: join: helper to filter TCP
- 2d273f0e7eb6: selftests: mptcp: join: clarify local/global vars
- 96961994425b: selftests: mptcp: join: avoid backquotes
- 054ac453676a: selftests: mptcp: join: make it shellcheck compliant
- Results: 0c1c6c50d9dd..64843b43f8de

Builds and tests are now in progress:

https://cirrus-ci.com/github/multipath-tcp/mptcp_net-next/export/20220225T133622
https://github.com/multipath-tcp/mptcp_net-next/actions/workflows/build-validation.yml?query=branch:export

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
