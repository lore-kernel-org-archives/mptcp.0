Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A68B11843
	for <mptcp@lists.linux.dev>; Wed, 22 Jun 2022 21:09:31 +0000 (UTC)
Received: by mail-ej1-f51.google.com with SMTP id u15so9209366ejc.10
        for <mptcp@lists.linux.dev>; Wed, 22 Jun 2022 14:09:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=UVnc1/D2M2HuNd8eGab4a/MAg1UAuEOxjMcXJ86VjiQ=;
        b=cIQsfqIBEYU6u2qxpjuOITXPzolU+HmKHAlMnllP+ddQfOb+/yoZfB5iHqQjy/RlYg
         oXMARbDrjuTXVsUypTeJGxf3Wm0G/sZAT7+L07fD+2fH1vpb/kfcmzpWphaWR9Bn5gza
         KPYxp9RNwwhDWlJTZve4TN/ygIm+Ru0w+9naOw/eioTshByNFO+2hbzDmanwP9iJo5nO
         zVGJuL6o5LZ15cWGY6en+mZNV4Ko/pNVYyIdc/ntGvFa+sXc7zMZ4OhcWXdJZcFhbGzZ
         5xRO2jwgoNY80uUWmqfdzj8rWAbABwVzEGcTEfzXmBvd1eT/3hkMEiEnFpVZnI4EGOYe
         25jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=UVnc1/D2M2HuNd8eGab4a/MAg1UAuEOxjMcXJ86VjiQ=;
        b=Q04JLFZ3reaiBUaeDYasG4jKRIWo83F5wc5F2FHCzk0E0hiZS4pCPxssjLpU4KsZpx
         R1G2M/ZRARwcKgN3vcJGctzrIc1mTowf5rEp7FwcQ5SHGxfdOh+Z1F73sbmekPHdd9w2
         VLNSyWpX7R7KrCobSCpCoxlq9zxNIONE3NBc71N9NuOMX4PLhaa/DQkQzdjoxIj+Wu11
         kp+WTtH4sWOrLlwk5k0oMr+Fm1au6DyF9SOWnPZbTA8k+Z5a3Ftz3sA9ExGkScuQrEKz
         sWRjcrsGE9VuBBQdeOWWWPyoEaG0XkKA0eYOgO6MquD2mXY9g7vQ9wmpfz+KvY9bybti
         PJjA==
X-Gm-Message-State: AJIora+8ZRsdlyHL9/3cDt6tRL56UPC2aEyvrWc6NKB2TU+nsxnJQdNE
	O5qq4R+u1G16WXDcGPKzpCxuxw==
X-Google-Smtp-Source: AGRyM1tfxC4G8M058x0084Yk/AND2thPwaQKv5BgvV8M5CZuVTB3IKG+kf52yLmDkeQEx9omYsV/PQ==
X-Received: by 2002:a17:906:3087:b0:6f4:2901:608a with SMTP id 7-20020a170906308700b006f42901608amr5062873ejv.646.1655932169631;
        Wed, 22 Jun 2022 14:09:29 -0700 (PDT)
Received: from ?IPV6:2a02:578:8593:1200:e063:12b5:8fdc:749e? ([2a02:578:8593:1200:e063:12b5:8fdc:749e])
        by smtp.gmail.com with ESMTPSA id x6-20020aa7d386000000b004355998ec1asm14255533edq.14.2022.06.22.14.09.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Jun 2022 14:09:29 -0700 (PDT)
Message-ID: <8069adb9-85a8-8423-a7ee-e8e079883708@tessares.net>
Date: Wed, 22 Jun 2022 23:09:28 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v4 mptcp-next 4/4] net: remove SK_RECLAIM_THRESHOLD and
 SK_RECLAIM_CHUNK
Content-Language: en-GB
To: Mat Martineau <mathew.j.martineau@linux.intel.com>,
 Paolo Abeni <pabeni@redhat.com>
Cc: mptcp@lists.linux.dev
References: <630f7e13d7226f8c37a9cc0c66008a298c1e6b9e.1655828070.git.pabeni@redhat.com>
 <746be47fdbbf4c5fadb9d5dcb2ee2e9cff0dacf5.1655828070.git.pabeni@redhat.com>
 <b324f6a1-6f17-c52b-4725-22893fc13cd4@linux.intel.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <b324f6a1-6f17-c52b-4725-22893fc13cd4@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Paolo, Mat,

On 22/06/2022 00:38, Mat Martineau wrote:
> On Tue, 21 Jun 2022, Paolo Abeni wrote:
> 
>> There are no more users for the mentioned macros, just
>> drop them.
>>
>> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> 
> Looks good:
> 
> Acked-by: Mat Martineau <mathew.j.martineau@linux.intel.com>

Thank you for the patches and the reviews!

Now in our tree (feat. for net-next) with Mat's RvB/ACK tags:

- 37c90ab38feb: mptcp: never fetch fwd memory from the subflow
- b6e446432fd3: mptcp: drop SK_RECLAIM_* macros
- 31d82b289435: mptcp: refine memory scheduling
- fcc809e3a1d4: net: remove SK_RECLAIM_THRESHOLD and SK_RECLAIM_CHUNK
- Results: d99676bfce76..8346c4604d29 (export)

Builds and tests are now in progress:

https://cirrus-ci.com/github/multipath-tcp/mptcp_net-next/export/20220622T210613
https://github.com/multipath-tcp/mptcp_net-next/actions/workflows/build-validation.yml?query=branch:export


Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
