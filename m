Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8729E2F50
	for <mptcp@lists.linux.dev>; Fri, 15 Apr 2022 10:54:37 +0000 (UTC)
Received: by mail-ej1-f44.google.com with SMTP id i27so14774487ejd.9
        for <mptcp@lists.linux.dev>; Fri, 15 Apr 2022 03:54:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:cc:from:in-reply-to:content-transfer-encoding;
        bh=y47DHE7FLxIPuTHxGYsf4/Yr/1dc1pvg9lyx7aktF0A=;
        b=DwvujaUF1VvxvTVGs1rTVkXjksayH5mf+j2CN8l1ccul78pI/QWFAyJuAhzGV+sRiA
         ED6GUTnYnD2RS5EM4PR7hCQkmDAn0CiQA5Wk0Dr1FBlLKCh9E81HsIV2CXt2KyoAtzQd
         BHmSsNjfYRntoMNBY7XjrRbPptxx1VrUhg0RVa9p9PdQCPAjMXh/mCjK0A6oynr2zrmW
         t//VHbpiZFIUVV53XWCsl3lXaqlUYY1mYXaOVEsFoDHFOZ5nxSwSvpczpw8lhRjTl9UB
         uvQYxA9Ih5qAf3v0NoI/7zelXM0fgIBfPR3jEv4MTujnKyZxjuqh1ij0Euq8/gLNJ3x/
         wnsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:cc:from:in-reply-to
         :content-transfer-encoding;
        bh=y47DHE7FLxIPuTHxGYsf4/Yr/1dc1pvg9lyx7aktF0A=;
        b=K65EqB6Qx9XJVyWO7bH4eUlVlSWx0u4QZwWXmtYvrd1uJqA7knbj5ratoLvpNKH98I
         yySZt85nvQupOceBdWEf7lepiBRnkJW9awd5E/mGv8jsmweoo1Guh5L77tG/ChKL4bOg
         CZ8EPNqHbg0oFM/Db9V7c3QudMIHwBksQZbHZS5WLPrudeZuOUpyQ6YOq8eIzPNVn4nG
         i8Yn1+zujrkYsGnUiR+QUIW3eWcGPUp0CEE/wZOliy2Eehllpg0H5ahAdmNCRWonwCLr
         HBsZc2z/RVz45BWCRuvxiingy6rIA5LwT1U+59myIWXcx9dZgTYvGTNB8AER05k+FSPJ
         iP5g==
X-Gm-Message-State: AOAM533qLukRIc4o0DPR1SnZOqeFY4tV/3Q3tECUHlPJCJBMp/Y/vfm5
	1mdGsbutXN82myPrA7Ec/uxzbw==
X-Google-Smtp-Source: ABdhPJwF7giVGP2Gk3HSbhr7/vnICwdSK6DsaKQhktEJUw/zJ7bXt3Gy/+aE/a+bftqnO5nhubLalg==
X-Received: by 2002:a17:906:1384:b0:6e8:46b6:d42e with SMTP id f4-20020a170906138400b006e846b6d42emr5834144ejc.366.1650020075677;
        Fri, 15 Apr 2022 03:54:35 -0700 (PDT)
Received: from ?IPV6:2a02:578:8593:1200:8ba4:ab5d:8b2a:caa? ([2a02:578:8593:1200:8ba4:ab5d:8b2a:caa])
        by smtp.gmail.com with ESMTPSA id e19-20020a056402105300b004162d0b4cbbsm2509371edu.93.2022.04.15.03.54.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Apr 2022 03:54:35 -0700 (PDT)
Message-ID: <af711184-4972-ac24-8a13-835c1196c32d@tessares.net>
Date: Fri, 15 Apr 2022 12:54:34 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH mptcp-next v10 00/14] mptcp: APIs and self-tests for
 userspace path management
Content-Language: en-GB
To: Kishen Maloor <kishen.maloor@intel.com>,
 Mat Martineau <mathew.j.martineau@linux.intel.com>,
 Paolo Abeni <pabeni@redhat.com>
References: <20220414211920.1987961-1-kishen.maloor@intel.com>
Cc: mptcp@lists.linux.dev
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <20220414211920.1987961-1-kishen.maloor@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Kishen, Mat, Paolo,

On 14/04/2022 23:19, Kishen Maloor wrote:
> This patch series brings together the base functionality
> and new netlink APIs for flexible path management from userspace.
> Further it extends the MPTCP self-testing framework to support the new
> netlink APIs along with the ability to capture MPTCP netlink events
> to aid in functional/behavioral validations. Lastly, it adds a
> self-testing script with a suite of test cases covering the entire
> range of the new userspace path management capabilities.

Thank you for these patches and reviews!

I just applied these patches (feat. for net-next next) with Mat's RvB
tag, Paolo's Ack:

New patches for t/upstream:

- c2dcdbadfac0: mptcp: allow ADD_ADDR reissuance by userspace PMs

- 26c71440e307: mptcp: handle local addrs announced by userspace PMs

- 5a865082c99a: mptcp: read attributes of addr entries managed by
userspace PMs

- 899ec4b7d092: mptcp: netlink: split mptcp_pm_parse_addr into two functions

- 37d4d520025a: mptcp: netlink: Add MPTCP_PM_CMD_ANNOUNCE

- 90e75a0f1e7a: selftests: mptcp: support MPTCP_PM_CMD_ANNOUNCE

- 151abf946ec6: mptcp: netlink: Add MPTCP_PM_CMD_REMOVE

- 961b8d01cd00: selftests: mptcp: support MPTCP_PM_CMD_REMOVE

- 68f10488da73: mptcp: netlink: allow userspace-driven subflow establishment

- 04de6ee0fd99: selftests: mptcp: support MPTCP_PM_CMD_SUBFLOW_CREATE

- 337354cbefde: selftests: mptcp: support MPTCP_PM_CMD_SUBFLOW_DESTROY

- feac5b7157cd: selftests: mptcp: capture netlink events

- 802a0fcee8de: selftests: mptcp: create listeners to receive MPJs

- 7a589792c590: selftests: mptcp: functional tests for the userspace PM type

- Results: dd31cb34f82b..f0428dbd45eb (export)

And an extra fix for the CI:

- 6505be1e8a40: Squash to "mptcp: handle local addrs announced by
userspace PMs"
- (no co-dev for that)
- 66af7c7950d4: mptcp: remove dup mptcp_pm_addr_entry
- c14d95c1413b: conflict in
t/mptcp-netlink-allow-userspace-driven-subflow-establishment
- Results: f0428dbd45eb..4fa4540bfc5e (export)

Builds and tests are now in progress:



https://cirrus-ci.com/github/multipath-tcp/mptcp_net-next/export/20220415T105031

https://github.com/multipath-tcp/mptcp_net-next/actions/workflows/build-validation.yml?query=branch:export

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
