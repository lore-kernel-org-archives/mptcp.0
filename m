Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DADEA3FF0
	for <mptcp@lists.linux.dev>; Thu,  9 Sep 2021 16:16:10 +0000 (UTC)
Received: by mail-ej1-f54.google.com with SMTP id x11so4781558ejv.0
        for <mptcp@lists.linux.dev>; Thu, 09 Sep 2021 09:16:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=DAARLv69cGsH10jK11frOW3HmXXFqcJBBx/6Z38x/48=;
        b=J8HgWa4rnxmJtEb63gJPgYCe2wndddmzD/FWECQotef++mvh61BimkUxm0mcNCpLcl
         pAWvQVff1y/DtmfQLFuo330316l2LXZj50jAvYVfY38SKvketmB2Z2GNR5lcegV9k2aH
         yYV66FJkiG5R5RaZp6sCwPOOfz7/2v/wIlRw+XGhJ/PBCEVd56a2S8h8FNFvmCBz8G8Z
         DAZun6BYxgmdxuKsEEOF6zt8cRiKCgmp5BYYxpFAGUEb/FtOpUpzv+bF9ObT6P7w/ZuQ
         SNAgi3yG6+9PaPFUTksRcY89+ARropoffu7NaW81HeFG2j1Mu37/Z4RysKEGiShcfW4t
         3/1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=DAARLv69cGsH10jK11frOW3HmXXFqcJBBx/6Z38x/48=;
        b=EbtsnUHWRIMOPVvpLANsGx2eHCtuwjLBzl4RQRPhTKSBT3cv9gqVe2OLeRtpVPsdD6
         lwivI9h5Ba19ZRgHrOd1jp244sn9d0ifxo0xW8djjOJNJ9iHj7bwN00rbKTdzx+M+b8A
         JR7fC3lu1QgwX58fQcwkofOC4SVLRb1MTODTIrY7rV4Qye81+H9GA95o6nZySxoVutfy
         ynOff1lER5QGKyNhiErv2j36HS53jFIHDx2Aps/xMLjvyYM2reiTiAHjLKKW/9r8GkRK
         V2rSCU3Flv7lKst2OdM6bInSbgxJF9osTGn3Ues6lDthxOMpsnf6sVPpbYRocPBEWkpE
         kRmw==
X-Gm-Message-State: AOAM530y3zPM7oXzFPIgC7+VQDj0Dc3/CY5SMVmQaT+1ZPLVa4mue4k8
	+4mD89G3Fy5SBHDNw0RkRTnsLWWbU5HBZFMg
X-Google-Smtp-Source: ABdhPJzMr/z8tQUAwzkIwL1GYr9vgfRUiQgRMH++zd/AKFUyDQV1T7MLBG5jgkT5SVcM0m8PJ6k3TQ==
X-Received: by 2002:a17:907:75ca:: with SMTP id jl10mr4451496ejc.302.1631204168726;
        Thu, 09 Sep 2021 09:16:08 -0700 (PDT)
Received: from tsr-lap-08.nix.tessares.net (94.105.103.227.dyn.edpnet.net. [94.105.103.227])
        by smtp.gmail.com with ESMTPSA id jx21sm1127962ejb.41.2021.09.09.09.16.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Sep 2021 09:16:08 -0700 (PDT)
Subject: Re: MPTCP export branch - build errors due to -Werror
To: Mat Martineau <mathew.j.martineau@linux.intel.com>, mptcp@lists.linux.dev
References: <ddbdbbb6-ee39-40a1-c1d2-e0f1b1b3aa91@linux.intel.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
Message-ID: <35134dd7-3139-fd79-d41d-e25873815f00@tessares.net>
Date: Thu, 9 Sep 2021 18:16:07 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <ddbdbbb6-ee39-40a1-c1d2-e0f1b1b3aa91@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit

Hi Mat,

On 09/09/2021 18:08, Mat Martineau wrote:
> 
> I mentioned in the meeting today, kbuild's build step is failing due to
> warnings being treated as errors.
> 
> The fix to change -Werror to be under the COMPILE_TEST config flag is
> commit b339ec9c229aaf399296a120d7be0e34fbc355ca in Linus' tree:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=b339ec9c229aaf399296a120d7be0e34fbc355ca
> 
> https://lore.kernel.org/all/YTfkO2PdnBXQXvsm@elver.google.com/
> 
> Not sure when it will show up in net-next (hopefully soon!), but it
> would be good to cherry-pick in the export branch in the mean time.

Sure, good idea, just did:

- 23ec8f63bcac: kbuild: Only default to -Werror if COMPILE_TEST
- Results: 96216d5da9df..5fabcaa6857a

Builds and tests are now in progress:

https://cirrus-ci.com/github/multipath-tcp/mptcp_net-next/export/20210909T161526
https://github.com/multipath-tcp/mptcp_net-next/actions/workflows/build-validation.yml?query=branch:export/20210909T161526

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
