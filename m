Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 791F63481
	for <mptcp@lists.linux.dev>; Wed, 28 Jul 2021 07:18:53 +0000 (UTC)
Received: by mail-ej1-f51.google.com with SMTP id hp25so2925755ejc.11
        for <mptcp@lists.linux.dev>; Wed, 28 Jul 2021 00:18:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=c2dYJ0PpFxcLQ4UJa0fuPXGjJS/b2UkmK6p1537x6Cc=;
        b=nVlnf/LCOuwWEVcUIVv2Ns6OpfyoQXNGVjddbNLh+tEyJcRRs9SLloX4VDEaUmJs/o
         St4v+fvfpAHdw98tJtGgEZlU+y4uF3B+y4dhIggIxEiHVuXSkuVHPseTbowtmW2KNtW7
         tIYBil5JKFah2Aq3LBOAx9h5km3QechsFsA/aCRX0NgXFw99A0lqxyA7l0LYWp06fUkN
         2hOOigtUE9uDg0OQUpURFTSw/9qRWQTvDCNFKdrDI0HBMf/5WjWFiYW/yNTo7mR9Ieqz
         ugErpqZ2QB4axev4Cc/GLFE5E7z9ZJTgiAfxFmAZvKW3qW0xUaXrwWKjy8Aa9LPr5rzA
         mL8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=c2dYJ0PpFxcLQ4UJa0fuPXGjJS/b2UkmK6p1537x6Cc=;
        b=b3dxYMstgvCjbNWpM0e2JCa5RqI6zzUfjwkgYksI3n/ipOKV/yFhbCyW9bTjt6OiOl
         pCDjD7pyyuF+dAGR5MKFhUZ7RDwcH+beRevVh8n0rkE7DlJK6o8T2yNOucnIEmbfbWMb
         8Xulzj6U/YIvG5pb9ozrUYnC3xK2NV5x+UtLgf7ssp4zFq+sjCZlzLAk1KtVFNftn4gX
         OGnf7NcVtSx0Nd6nVKG4Cxzg+Fs9Z4pXEUrlfaumCCdn4cxKayEoPiK4NAIFmpZ1FMsH
         /TpGmoz/mHT64ijORoPSrbERrNzIb7fvKIWTO9MRR5XfH7xQSOlyyRGkMTX/OS5o8aiY
         62zw==
X-Gm-Message-State: AOAM53115RRJ8HEC5NWtNdSmTPEb8fZCqnAeLw8C+Lue56DnICdZyqNJ
	LxTjstWQOKfBpJUXT+gL/GbJa2YfeAb9Bg==
X-Google-Smtp-Source: ABdhPJzfTrmngGERHtCa/4HgVAd9BMaaFs28lT3a5+vy5V++q5cszm/sAMeB2BwROigMakAcbcAJ3Q==
X-Received: by 2002:a17:906:d20a:: with SMTP id w10mr26712484ejz.426.1627456731555;
        Wed, 28 Jul 2021 00:18:51 -0700 (PDT)
Received: from tsr-lap-08.nix.tessares.net ([2a02:578:85b0:e00:c852:afa0:c279:c071])
        by smtp.gmail.com with ESMTPSA id k3sm2176952edv.2.2021.07.28.00.18.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Jul 2021 00:18:51 -0700 (PDT)
Subject: Re: [MPTCP][PATCH v2 mptcp-next] Squash to "Squash-to: mptcp: build
 ADD_ADDR/echo-ADD_ADDR option according pm.add_signal"
To: Geliang Tang <geliangtang@gmail.com>, Paolo Abeni <pabeni@redhat.com>,
 Mat Martineau <mathew.j.martineau@linux.intel.com>
References: <ba5a3eff994cf1adf069c0e708adcea0d90daedb.1627222024.git.geliangtang@xiaomi.com>
Cc: mptcp@lists.linux.dev
From: Matthieu Baerts <matthieu.baerts@tessares.net>
Message-ID: <71e65977-78e7-6d48-89a7-1bfa81a48ddc@tessares.net>
Date: Wed, 28 Jul 2021 09:18:50 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <ba5a3eff994cf1adf069c0e708adcea0d90daedb.1627222024.git.geliangtang@xiaomi.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit

Hi Geliang, Paolo, Mat,

On 25/07/2021 16:18, Geliang Tang wrote:
> Paolo's patch (Squash-to: "mptcp: build ADD_ADDR/echo-ADD_ADDR option
> according pm.add_signal") reverts back to a single 'addr' field in
> struct mptcp_addr_info.
> 
> Then no need to change the argument of mptcp_pm_add_addr_signal to
> mptcp_out_options and no need to modify the code in mptcp_write_options
> now, the original code is fine.
> 
> So this patch reverts back more code.
> 
> And the commit log needs to be updated:
> 
> '''
> According to the MPTCP_ADD_ADDR_SIGNAL or MPTCP_ADD_ADDR_ECHO flag, build
> the ADD_ADDR/ADD_ADDR_ECHO option.
> 
> In mptcp_pm_add_addr_signal(), use opts->addr to save the announced
> ADD_ADDR or ADD_ADDR_ECHO address.
> '''
> 
> v2:
> - rename the 'saddr' argument of mptcp_pm_add_addr_signal to 'addr'.

Thank you for the patch, reviews and tests!

- 210b1030d1b1: "squashed" in "mptcp: build ADD_ADDR/echo-ADD_ADDR
option according pm.add_signal"
- b2e3a05bbcd4: tg: update msg after having applied 2 squash-to patches
- Results: fcc436834cac..49320b30c955

Builds and tests are now in progress:



https://cirrus-ci.com/github/multipath-tcp/mptcp_net-next/export/20210728T071836

https://github.com/multipath-tcp/mptcp_net-next/actions/workflows/build-validation.yml?query=branch:export/20210728T071836

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
