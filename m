Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E1CB7E
	for <mptcp@lists.linux.dev>; Fri, 20 May 2022 15:20:13 +0000 (UTC)
Received: by mail-wr1-f42.google.com with SMTP id f2so11973550wrc.0
        for <mptcp@lists.linux.dev>; Fri, 20 May 2022 08:20:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=RyFUxt9z62+UdCVduPZXeTSjVRgbARkRsKGv3BU8HMM=;
        b=0/NC5UvgVXhs4NkPJWzfDhkPN0S+nKgRxQF3uT1hgXtnx0/eIG7U4WhhIedJMuXtH5
         lvqOLb4Mj2IiJA5LdY18P3dyAZZIfvbhmdEvO7CH1G9V5pvUy/w6YhKv5GYOMkqYkmlv
         5g9VKkuuKHujLL1pIK+6KMJbLFL2af9SsJs6ce9+t8pQxruDLlVoh2nDh6fqhQr/L9Dl
         IjcL/uRItKmpNJK3vmucMDDaPPVM+RDYq3FBoYqfp9PXr3OBN83eCgcmpZBcfUqcm+7S
         WVEnvOzJ6aF/1Z34Evida+0fw7mNFRHhpWB24DKlix4Ou/nM5qOKEDkVdXt2NzJqOsRE
         VvGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=RyFUxt9z62+UdCVduPZXeTSjVRgbARkRsKGv3BU8HMM=;
        b=cUPnzOLrkfK4VdsSFn5e5YA9dKh9fEWIfV4bWqWjXF1LjncXNQViRIjI4caqwsKKi1
         l+MPShF4nV6eAz/mxPfWkkPgK4j4cKeKy83imQhO7as6g22JAIci6teOw7h2RLgyk8Bj
         cmiETprqAi6mLkvf+hrT0iAyGwZ+qTUuhXPDN/ni6xy0XajvPhmdy8Jutfg5drp513MD
         202wAd7FpluETczTjg1zbgNH1mTm1VAlN7lzc/WERN2jX2RY+xTkLl9sswq8l1mB+XKV
         DJrficOf7ks5egIPa33t6JwMeaAU1quCfHhkg7I/aP/X/7WA49qrGyAsoWCy/nvcZ5vD
         +Fuw==
X-Gm-Message-State: AOAM531wjzMxmsqkg375HYP7pvU0ZK/l2Ioo62Rjmu+pknuYB7iY4H4O
	e81a6toq1l0dEA89O8NfovYcwzleZ3yAuw==
X-Google-Smtp-Source: ABdhPJxEuDp9JQiz9w3iDsT9+MSD21+FNj4joqufT4Ep17PdW46IlBBGrjWXs+pvst1Gghh1ImnbZg==
X-Received: by 2002:a5d:650f:0:b0:20d:77b:702b with SMTP id x15-20020a5d650f000000b0020d077b702bmr8824241wru.78.1653060011391;
        Fri, 20 May 2022 08:20:11 -0700 (PDT)
Received: from [10.44.2.26] ([81.246.10.41])
        by smtp.gmail.com with ESMTPSA id d24-20020adf9b98000000b0020e617ccd10sm2765047wrc.59.2022.05.20.08.20.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 May 2022 08:20:11 -0700 (PDT)
Message-ID: <e5d644c4-b190-412f-967a-8a79bfaf0f9b@tessares.net>
Date: Fri, 20 May 2022 17:20:10 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH mptcp-next] mptcp: fix conflict with <netinet/in.h>
Content-Language: en-GB
To: Mat Martineau <mathew.j.martineau@linux.intel.com>,
 Ossama Othman <ossama.othman@gmail.com>
Cc: mptcp@lists.linux.dev, Ossama Othman <ossama.othman@intel.com>
References: <20220519153929.214331-1-ossama.othman@intel.com>
 <f4baa4-81e6-21df-80a5-13eb15317559@linux.intel.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <f4baa4-81e6-21df-80a5-13eb15317559@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Ossama, Mat,

On 20/05/2022 02:05, Mat Martineau wrote:
> On Thu, 19 May 2022, Ossama Othman wrote:
> 
>> Including <linux/mptcp.h> before the C library <netinet/in.h> header
>> causes symbol redefinition errors at compile-time due to duplicate
>> declarations and definitions in the <linux/in.h> header included by
>> <linux/mptcp.h>.
>>
>> Explicitly include <netinet/in.h> before <linux/in.h> in
>> <linux/mptcp.h> when __KERNEL__ is not defined so that the C library
>> compatibility logic in <linux/libc-compat.h> is enabled when including
>> <linux/mptcp.h> in user space code.
>>
>> Signed-off-by: Ossama Othman <ossama.othman@intel.com>
> 
> Looks good to me, I think this makes things easier for userspace.
> 
> Reviewed-by: Mat Martineau <mathew.j.martineau@linux.intel.com>

Thank you for the patch and the review!

Do you mind if I add this Fixes tag?

Fixes: c11c5906bc0a ("mptcp: add MPTCP_SUBFLOW_ADDRS getsockopt support")

Or do you prefer without it not to have it backported?

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
