Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FE9F19E69
	for <mptcp@lists.linux.dev>; Wed, 24 May 2023 17:04:04 +0000 (UTC)
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-306dbad5182so804492f8f.1
        for <mptcp@lists.linux.dev>; Wed, 24 May 2023 10:04:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1684947842; x=1687539842;
        h=content-transfer-encoding:in-reply-to:from:cc:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UQuqqugWygjt37NKm5vFZ3FoQs8jD5va24AMe1h/148=;
        b=KXwRkntR/se1HWY0CiXgoc7rUC+aLZpuVJD8tIR0kW6SGfKEG7ozoNLcSN2KQ9IyEM
         bPsvQ2tH1kkcBlKCl/fHxCA5Hn/xnhNKSI/UMCZuSRBZXfAcToVMEI+jj7Ck97tVCeHc
         B0xjmN9V6lltEbNvfuxjG5X3wrNzpUT4QOqWKmYXC1+e7+GAby+YDk+ecjJwg3BK7Fqh
         IEDiaUgTKwkSamI1DZXRF2Z81UAmkg9KJV+NyxVMZWXp61Iem1Ux2p3M944S5dfDDyiR
         4UhNWaitS7M58Hy4fAiyGFa0VopdM1Kpohyfmb0vOxCLql2iyc51qO//XovT8NRgue7q
         7SaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684947842; x=1687539842;
        h=content-transfer-encoding:in-reply-to:from:cc:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UQuqqugWygjt37NKm5vFZ3FoQs8jD5va24AMe1h/148=;
        b=XBwxccqaGVclWYPl2YWtXhK5KNnRazljc/ofzNvMnR5a7ARqqHOqrW2dzqB7IsiCQB
         NQde6E28gqI0mQ6iEAUaHVa2KHcJxxjzXRVJZqScUbm0qw8twV2bEpRuhNuLjnIVtiDg
         pAj9kZlze0mryRGsmY6BNMfK66rHZlNeA2lIXOuxVHHSWnn7Qqq+2yiHhbAPID3B6MbU
         +/72pr3rrbrytfZl6qAo42gHoUx7fJ1gNMKcBEYlLuDnCjT27+TYECka04ZZbutpTjyt
         ed9TkzCqw6Y2/UddpFcQeCbmg4hgAFs5V5jkXOK+jhu0qKkoQfE9NmSPunPAFeWUfKs1
         4fSA==
X-Gm-Message-State: AC+VfDyNuwbwz8H+V9Jz6baEGB608Akv8sy2HwRJ9iginWkQoU6vlRPR
	zD2DFisVlJvFMxIa2hF2qN5vkGIigJ/6CRXkuOEZwA==
X-Google-Smtp-Source: ACHHUZ4f+LlIt+JhkSxrGgkJGXXK4LRjc1FSrBdRA+PpSX6/RrTqxdE7s77TebbqkH6twPIr/Mqw3g==
X-Received: by 2002:a5d:58d5:0:b0:309:3698:7feb with SMTP id o21-20020a5d58d5000000b0030936987febmr294268wrf.46.1684947842206;
        Wed, 24 May 2023 10:04:02 -0700 (PDT)
Received: from ?IPV6:2a02:578:8593:1200:f96c:b035:8e06:9e3c? ([2a02:578:8593:1200:f96c:b035:8e06:9e3c])
        by smtp.gmail.com with ESMTPSA id e9-20020adffc49000000b003078a3f3a24sm15175053wrs.114.2023.05.24.10.04.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 May 2023 10:04:01 -0700 (PDT)
Message-ID: <e64bd67a-af85-d573-a0dc-2d8c17837072@tessares.net>
Date: Wed, 24 May 2023 19:04:01 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH mptcp-net v2 00/37] selftests: mptcp: skip tests when
 features are not supported
Content-Language: en-GB
To: Paolo Abeni <pabeni@redhat.com>
References: <20230406-mptcp-issue-368-selftests-old-kernels-v2-0-50313e4f83ab@tessares.net>
Cc: MPTCP Upstream <mptcp@lists.linux.dev>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <20230406-mptcp-issue-368-selftests-old-kernels-v2-0-50313e4f83ab@tessares.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Paolo,

(and anybody interested by this ;-) )

On 22/05/2023 18:37, Matthieu Baerts wrote:
> Selftests are supposed to run on any kernels, including the old ones not
> supporting all MPTCP features.

We discussed about this series at the meeting yesterday but I don't
think the next steps are clear, at least not to me :-)

Here is a short recap of the current situation:

- The first patches skipping MPTCP if it is not supported have been applied.

- check kernel version: what about adding an env var that can be set to
skip the versions check? So it works if a new feature is backported to
an older kernel.

- get_counter() to get the MIB counters: I can help the stable team with
the backports that will not be difficult I think but will cause conflicts

- check nf/tc issues: looks safer just in case a kconfig is missing or
an issue with nf/tc but can be removed if you prefer (still I don't
think we should exit in the middle of a test)

- one check per block of tests around the same theme: it would indeed
avoid re-doing the same check 2 or 3 times but it would break the IDs (+
maybe less obvious a test might be skipped when reviewing code)

- backports: at the end, we just need all these new checks to be
backported on the last stable kernel (6.3) because that's what is used
by the different CIs. It is fine if it is not backported after. (but
still I can help with the backports, I'm used to :) )

WDYT?

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
