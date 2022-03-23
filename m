Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF4E0614D
	for <mptcp@lists.linux.dev>; Wed, 23 Mar 2022 17:10:38 +0000 (UTC)
Received: by mail-ed1-f48.google.com with SMTP id h1so2668325edj.1
        for <mptcp@lists.linux.dev>; Wed, 23 Mar 2022 10:10:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=1pO+Azkfm9FmvroZO3aUyzcCPwr33URwVfXscVBfqvE=;
        b=YFtK3L5MFxLlLb9Qjy39kYtdhUsfyVZcC6KmpxTRslKzDRLIUWQqJ8tNwN7UCzvsWx
         U0Lf80CtNkKCzf4A8lGEvlz+E5X/8FIrDNBS+axrzeq+53iFpPDmxILWp86Z72dx/bqg
         8zTXF8U+gvDyONAez1Slm3DCKLl59oUOFl8Xm+0/cwYv3EoPUojkEmA+QdGYS95MhTH8
         dvx4V7wjIQK9RiVP9WKfbnQKmA7mhMYZSEBHoBkru+/Q/ZUORjqynJWt5tt6wuIRlyD/
         zbsHgphqDllSusOnd0wyOJtl/3VomWv5cKmXXm8jXEUtgQ1RBXUTMao5gtgcOJmCMWhy
         LgZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=1pO+Azkfm9FmvroZO3aUyzcCPwr33URwVfXscVBfqvE=;
        b=zvAQuVaogRjyUguIRLJeUrUkRaM5m3ENelsQWEjFbSAEmJlGIX2VJ+0aPoe/zNEwhb
         g2kC7d/BydTh+cdCpaUCxq4d9Q+2aMcHwKSn4aPTRuLWpmgh80IEyWUGKlOYiepXBkna
         ANuIVh5c9Eh4qHY1iDjLmyYrSLYp1DoHCAfXiT0odLQhTw9whbQK/V2f48FBlY3/q3MW
         QHUS/dn8G8fJuS0AZ5l06JVI2l7i2xAxRhU5GCVS97fxghwr7A44+hZFVb6gGSE4dVBb
         YCZ5iJbjRZp3vdqGZ/SjGOSqHC0txIHHgt8h8RXdoMinfQQWOomsT8ytFz/6wbQVfpnV
         jgDA==
X-Gm-Message-State: AOAM532eSIkRC9fg8WdPSX4t1ExHHBBgP68sS6pRIC3f8G4doLI/ogLH
	KCcCnOxrIVtMKjCfmxk/guxpjeUlCfatFZmQ
X-Google-Smtp-Source: ABdhPJzV+6NKIGAXWI6D1cM4OE8mCHUHBAEEr9h/b2aPQ4VLGtyC9pDRquz4tafMdDKjo/V4m/MeSA==
X-Received: by 2002:a05:6402:34d6:b0:419:4dc2:91c5 with SMTP id w22-20020a05640234d600b004194dc291c5mr1392074edc.329.1648055436743;
        Wed, 23 Mar 2022 10:10:36 -0700 (PDT)
Received: from ?IPV6:2a02:578:8593:1200:5c66:3b6a:a041:aaaa? ([2a02:578:8593:1200:5c66:3b6a:a041:aaaa])
        by smtp.gmail.com with ESMTPSA id m17-20020a17090672d100b006df98bb199dsm159719ejl.129.2022.03.23.10.10.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Mar 2022 10:10:36 -0700 (PDT)
Message-ID: <722dce5d-b1f1-27b8-84c5-40684ab90ffc@tessares.net>
Date: Wed, 23 Mar 2022 18:10:35 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH mptcp-next v5 0/6] MP_FAIL echo and retrans
Content-Language: en-GB
To: Mat Martineau <mathew.j.martineau@linux.intel.com>,
 Geliang Tang <geliang.tang@suse.com>
Cc: mptcp@lists.linux.dev
References: <cover.1647327162.git.geliang.tang@suse.com>
 <2775913c-722b-65b9-13f4-cfdcd5217e36@linux.intel.com>
 <bfe8bd4-abf-5637-e2d8-a025313bd380@linux.intel.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <bfe8bd4-abf-5637-e2d8-a025313bd380@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Geliang, Mat,

On 19/03/2022 00:19, Mat Martineau wrote:
> On Wed, 16 Mar 2022, Mat Martineau wrote:
> 
>> On Tue, 15 Mar 2022, Geliang Tang wrote:
>>
>>> v5:
>>> - re-check for TCP_CLOSE.
>>> - add a new helper mptcp_check_mp_fail_response().
>>> - add two timers cleanup patches.
>>>
>>
>> Hi Geliang -
>>
>> v5 is looking good to me so far, but I still need to run some tests.
>>
> 
> Ok, I got a chance to look at the packet traces from the self tests. I
> also tested with a shorter timeout and commented out the echo, and the
> subflow was reset as expected.
> 
> Looks good for the export branch:
> 
> Reviewed-by: Mat Martineau <mathew.j.martineau@linux.intel.com>

With a bit of delay, sorry for that, these patches are now in our tree!

Thank you for the patches and the reviews!

New patches for t/upstream:
- cf0e4660d69e: mptcp: use mptcp_stop_timer
- 4afa5bc41699: mptcp: add data lock for sk timers
- d1919f72133d: mptcp: add MP_FAIL response support
- bb04e167b541: mptcp: reset subflow when MP_FAIL doesn't respond
- 735b7655b253: selftests: mptcp: check MP_FAIL response mibs
- 054951083391: selftests: mptcp: print extra msg in chk_csum_nr
- Results: b3fcb6331ff3..73b94fb27a8c (export)

Builds and tests are now in progress:

https://cirrus-ci.com/github/multipath-tcp/mptcp_net-next/export/20220323T170824
https://github.com/multipath-tcp/mptcp_net-next/actions/workflows/build-validation.yml?query=branch:export


> It would be good to have a packetdrill test for this, even if it does
> take a couple of minutes to fail. We wouldn't have to run it in the
> normal CI.

I didn't close #261 for this reason then.

https://github.com/multipath-tcp/mptcp_net-next/issues/261

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
