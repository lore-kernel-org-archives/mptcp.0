Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B815263B7
	for <mptcp@lists.linux.dev>; Thu,  2 Feb 2023 13:32:04 +0000 (UTC)
Received: by mail-wr1-f48.google.com with SMTP id h12so1698836wrv.10
        for <mptcp@lists.linux.dev>; Thu, 02 Feb 2023 05:32:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vdNDhLYTOgJmkGCOO3LenmZk4wcDyO/fXbVMbMYA0GM=;
        b=bMHUmtIKHJC5499L4G3BsP3oWQPcrMK/5wAD9yQi2ucFDAwCAfa6HKO4T2di15sHec
         AQ229A/8P7RAYYfZsLXi+ZaeJBlr2vCHmdl3qD643XaPcqS0EUX37ZUwB9f6WOc7zhOc
         qLBMRJXAG22zFMWU5W7zm6xZqpN3oOQxbxbirypDIUwDOcLYruT1Il5DjTsMEwsZmCmX
         +WSK0ENMBWmKrroZU9NOga8uSGfjvHOuxMAhrTcSVCby+W2NwEp2kF77dif/VMqvnSSH
         RSlbTD336YrMcbXtCfLYqGI4bIipD2+acFAv+u+tdnmP2z/Z5HA4hsqZzmemuwhH+zN+
         NMDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vdNDhLYTOgJmkGCOO3LenmZk4wcDyO/fXbVMbMYA0GM=;
        b=A8XXpA3f8ADXONrjvaeJ55qUAqzwRaKY4m5U+7stgiK+Glf6w3jjlisdqS5OEW+6Wh
         9B2/SmlP//uK4xGejSY11/cLnuUr7JXV4IbkcdrLGY4U+MtD5dv3Mu15Rr2VvkC3E3yo
         /kQ6TBXbJ0j3VSy3SVYj8shRrMXAeExfn4JWFOinnu54ISgc7PmpbT+3ZzJtNpGT7uuC
         1mUG7BMkrBWd7H0TPF9TqvSnmpySNnbuVuQrtSyQ1e7iAqedk8y3mo1PfzfX5R6c2xwl
         qsL2jJRCFh3/p63Kh3pwjwbDJkOlV066gALvOS9QCOt+GMjlHeKNukQCxOVQXXDiP9zb
         OWHA==
X-Gm-Message-State: AO0yUKVyDnfG3P2P9rHV0BbC3pn4Qs+SG0GyIUtFCTM8lZFECO94644P
	7vO1U1vr8NTYHdeshj7QG0YdyGm9VlOlEl5eyw0=
X-Google-Smtp-Source: AK7set/0BAyQThO1psPKTQBRjSg/jOBuldHgvwSHli98RAbmsfm5lr/Y19S7b3JG0EDgYZxBtGGUxQ==
X-Received: by 2002:a05:6000:3c6:b0:2bf:ae18:34dd with SMTP id b6-20020a05600003c600b002bfae1834ddmr5551359wrg.56.1675344722276;
        Thu, 02 Feb 2023 05:32:02 -0800 (PST)
Received: from [192.168.3.222] ([213.211.148.158])
        by smtp.gmail.com with ESMTPSA id t16-20020adfe450000000b002bbdcd15e44sm19467609wrm.37.2023.02.02.05.32.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Feb 2023 05:32:01 -0800 (PST)
Message-ID: <2133472e-0f43-2a9c-f3f9-af3f57a930a8@tessares.net>
Date: Thu, 2 Feb 2023 14:32:00 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH mptcp-net v2 0/2] selftests: mptcp: stabilise 'endpoint'
 Join tests
To: mptcp@lists.linux.dev, Geliang Tang <geliangtang@gmail.com>
Cc: Paolo Abeni <pabeni@redhat.com>
References: <20230131-mptcp-issue-323-join-delete-re-add-v2-0-8de2421163c9@tessares.net>
Content-Language: en-GB
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <20230131-mptcp-issue-323-join-delete-re-add-v2-0-8de2421163c9@tessares.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hello,

On 31/01/2023 12:23, Matthieu Baerts wrote:
> The first patch is the one of Paolo where I only added the
> initialisation of "dump_stats" var as discussed on the mailing list.
> 
> The second patch is also somehow a fix as it stops the test earlier not
> to wait quite a bit of time for nothing. It is good to have it now as
> after the modification of patch 1/2, the waiting time is longer.

I just applied these two patches after having replied to Geliang's
questions. I hope that's OK

@Geliang: can I add your Acked-by? (I didn't added yet as they were not
explicitly there, thus my script didn't add them automatically :) )

New patches for t/upstream-net:
- 23bbeff9e3c6: selftests: mptcp: allow more slack for slow test-case
- 98d24d468734: selftests: mptcp: stop tests earlier
- Results: b5041e5446ed..d1ac838733b6 (export-net)
- Results: c22959a266e5..8b2ca48295cf (export)

Tests are now in progress:

https://cirrus-ci.com/github/multipath-tcp/mptcp_net-next/export-net/20230202T133022
https://cirrus-ci.com/github/multipath-tcp/mptcp_net-next/export/20230202T133022

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
