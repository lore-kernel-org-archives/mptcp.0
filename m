Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B3AC68
	for <mptcp@lists.linux.dev>; Fri,  5 Nov 2021 13:05:55 +0000 (UTC)
Received: by mail-ed1-f46.google.com with SMTP id x15so1605736edv.1
        for <mptcp@lists.linux.dev>; Fri, 05 Nov 2021 06:05:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:cc:from:in-reply-to:content-transfer-encoding;
        bh=ci5xVJMFhSxK4FB7pbCVvm5fCbOrTqoXTaIjPAwe75w=;
        b=mfi+vlZyyWnaUxCIRN/vC5V95ntK9STzihUYpgm1MZI6qW74te0o7YxbLGVD+l0U/W
         dcILCtSbJnDRoORZsqefXfzMkSp1gMeW8GX5/4eVq19lDpizFdNqvIF9SPBxiqF5cIz+
         IO/6CVL+TYzZHLgrVIBbuF04zT6YXFxMYo2mAL/zNHkeX1cIgBnMyuWuES0lyBrq6ZJV
         zGES2KICDifWm0qxofuV9cT6SQKVp+k0rAr+vzBcKU5sJ5wDfBB6BfWeVFwptM7WkBNP
         ERPfNksLK8yBBnFhSwESzdZ7b4BSNHzPdBCigikhjCs55wb6BF7MXxPvXHMT35uDHxFq
         PtCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:cc:from:in-reply-to
         :content-transfer-encoding;
        bh=ci5xVJMFhSxK4FB7pbCVvm5fCbOrTqoXTaIjPAwe75w=;
        b=4RJnZy9njdVKU/Y/dv/RV61ugSMqN1IBLEbtopXnV9DNhQis4PCDt6SPRgCl8DywVC
         mo2ws3YuHO3ANu04DmkuLUwEhyljhr2Fm4lCMjMCPBn23QHpzn7+IfA0UMb7ASdeBGbx
         KSPEBUN1JPnichflm1sf/YYzDcmrMSEDrZ6d/d8EMA29VFS5GNSLBB+npvmBvl5dsnzo
         ga0CCCDJKvCScl5lQiaZzFsA3li5m4zYFVY+VvrcGm1oN0TazUYvho3A66poo89WWIN7
         d6o9J340uPfNjEuI+bC3vIWGReqI7wPBDRw9x5MT0DTxwIesTjfP6EY4ITGVZssoYyHk
         p/5Q==
X-Gm-Message-State: AOAM5306CLQBKkH+Ux7zZZbWkbASzYp9grw9CgaKB5cABwcu/kpII/XS
	25YvRUiWcbO1Q3HiomuKJYsz/NzqvarycQ==
X-Google-Smtp-Source: ABdhPJwhK9XecoCuRNKBZDaPbMHUk46DvlU6OuOBh8hGGJHrqK2doEmJqGt+Xkkx6d7lrRVxRQ1HZQ==
X-Received: by 2002:a05:6402:350b:: with SMTP id b11mr20769549edd.184.1636117553441;
        Fri, 05 Nov 2021 06:05:53 -0700 (PDT)
Received: from [192.168.178.46] ([213.211.156.121])
        by smtp.gmail.com with ESMTPSA id go10sm2076356ejc.115.2021.11.05.06.05.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Nov 2021 06:05:53 -0700 (PDT)
Message-ID: <5ee8402c-64a8-98f4-54d1-c2605578b616@tessares.net>
Date: Fri, 5 Nov 2021 14:05:52 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.2
Subject: Re: [PATCH mptcp-next v8 0/8] The infinite mapping support
Content-Language: en-GB
To: Geliang Tang <geliang.tang@suse.com>
References: <cover.1635481641.git.geliang.tang@suse.com>
Cc: mptcp@lists.linux.dev, Mat Martineau <mathew.j.martineau@linux.intel.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <cover.1635481641.git.geliang.tang@suse.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Geliang, Mat,

On 29/10/2021 06:40, Geliang Tang wrote:
> v8:
>  - Patches 1-6 are unchanged, only updated the selftests scripts.
>  - The patch (Squash to "mptcp: infinite mapping receiving" for v7) is
> dropped too. Since this series only implemented MP_FAIL in one direction.
> The TODO items, "MP_FAIL echo" and "MP_FAIL retrans", will implement later
> as new patches.

(...)

Thank you for the patches and the reviews!

As discussed at the meeting yesterday, to help you moving forward, I
applied the first seven patches (without Mat's RvB tag for the moment).

What is then left to do if I'm not mistaken:

- drop more data from the receive queue c.f. discussions with Mat and
Christoph on the ML on v7

- Improvements around the tests for patch 8/8:
  - Comment around the TC command
  - Add 'tcp_flags 0x10/0xff'
  - Comment around the parsing (example of what you are parsing)
  - Break if jq returns 'null' or nothing.
  - Sleep in the while loop for "tc show"
  - Look for "pedit" counter ("packets" - "overlimits")
  - Not compare the output file if it is normal they are different
  - Remove/Reduce data sent by the host not having the tc command (send
only in one direction)
  - Insert the TC rules, then start the test, then look at counters
  - Force checksum=1 for "fail_tests()"


And for later:

- "MP_FAIL echo"

- "MP_FAIL retrans"

Did I miss anything?


The first patches are now in our tree (features for net-next):

- 19ca240f0cdf: mptcp: don't send RST for single subflow
- 89de2a435c1e: mptcp: add the fallback check
- df3d448153f1: mptcp: track and update contiguous data status
- 44b73ea648cc: mptcp: infinite mapping sending
- e35a1a951132: mptcp: infinite mapping receiving
- 9feb4bc20bf6: mptcp: add mib for infinite map sending
- ac67c5b1d612: selftests: mptcp: add infinite map mibs check
- Results: c1d29ad013b4..0fad1b3cf9ef


Builds and tests are now in progress:

https://cirrus-ci.com/github/multipath-tcp/mptcp_net-next/export/20211105T130530
https://github.com/multipath-tcp/mptcp_net-next/actions/workflows/build-validation.yml?query=branch:export


> Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/216

Because there are still stuff to implement, this ticket has not been closed.

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
