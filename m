Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A077C70
	for <mptcp@lists.linux.dev>; Fri,  4 Jun 2021 20:07:41 +0000 (UTC)
Received: by mail-ej1-f47.google.com with SMTP id ce15so16284083ejb.4
        for <mptcp@lists.linux.dev>; Fri, 04 Jun 2021 13:07:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20150623.gappssmtp.com; s=20150623;
        h=to:references:cc:from:subject:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=W/41+cYSJzu5W9/iuzcKnNKh4Lz2f3PcTNxDrtOWLvg=;
        b=FKwTtPLkPBmq0cjMxtHM5A0wI7uYYS84sEPZOyPeJ5d9EDQ2FjOVO87+bYtK8whh45
         Ro76SfpxHJtQgYm+GClaVBqCbNneTh29r35uAET3AE+/35gf2mR15bwXMTVlgTueysGL
         Kj2RnGFAwfbAYWfQwUZw4DHklZA0YAEcefgj3JOncqIjU0zjqzsaqvy8v5CNcmRHoci5
         3IXOm4V4aJ4n5KnIBgiDTszvphAAvh0mxJrX+z/9qlwjGkrV+mMRkYkRDa6pvBSRb49b
         gerexGbEHWDeChkT8K3PG/KAlCtNzSG2V2lUGN5XTCyyzEuxUqY1psscrzk4RnnImRWv
         ExzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:references:cc:from:subject:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=W/41+cYSJzu5W9/iuzcKnNKh4Lz2f3PcTNxDrtOWLvg=;
        b=ZX0YMTXmeQogE8yV4ljEhZb7CJl9jZtfVgCfRQiHr5jt8PYV4RvZPCZ3AdIvP01CVS
         uTvzDNTEgyyuh46l97DapKmMFKiC1JHEwiiV5g9uoMb6gpS2gsLijqVrg6yUbxm6G0pj
         BUydlvn+DAA6//Q0KRHVEogmn52o7ESnGXTFutYzz9efanztGbmW2x3F9CRZY/TS8rfB
         c7dbey42FLRRY0FMgy6DEeKHIxEjjlOuDSCBu7FM4g4zHIm2E0Evgo7ZbtLlXphWy1Yk
         z7tn54GaJ2GyKlisvpVDxFDpB1RLy03VrpKmPHq+/SHXaWl3GsQp5JW1oUM/x4qHEmUY
         zp4g==
X-Gm-Message-State: AOAM532VIHfzXYSizTIZKPfcTiiS21G6LXwjbhcLKnIskZynozzQe0wX
	0+XxIHq8ISQwql0KoCU2wugGy/Q8/xG2HrI6
X-Google-Smtp-Source: ABdhPJw6eICzsBRNO0MGc6pRFOeczi2Y1DKR8gdW8YJUjdgUOKs/S+olwm2RCQmVwxnW4rSacO6Ggg==
X-Received: by 2002:a17:906:c311:: with SMTP id s17mr5767202ejz.202.1622837260092;
        Fri, 04 Jun 2021 13:07:40 -0700 (PDT)
Received: from tsr-lap-08.nix.tessares.net ([2a02:578:85b0:e00:c047:d46c:d45:3868])
        by smtp.gmail.com with ESMTPSA id v7sm3728694edx.38.2021.06.04.13.07.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Jun 2021 13:07:39 -0700 (PDT)
To: Paolo Abeni <pabeni@redhat.com>,
 Mat Martineau <mathew.j.martineau@linux.intel.com>
References: <637fc17e2c0f833e820f7f8097fdc1212b4c968f.1622719886.git.pabeni@redhat.com>
Cc: mptcp@lists.linux.dev
From: Matthieu Baerts <matthieu.baerts@tessares.net>
Subject: Re: [PATCH v2 mptcp-net] mptcp: do not warn on bad input from the
 network
Message-ID: <07a8ab9a-3fef-6004-80df-74eb3f86feca@tessares.net>
Date: Fri, 4 Jun 2021 22:07:39 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <637fc17e2c0f833e820f7f8097fdc1212b4c968f.1622719886.git.pabeni@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 8bit

Hi Paolo, Mat,

On 03/06/2021 13:31, Paolo Abeni wrote:
> warn_bad_map() produces a kernel WARN on bad input coming
> from the network. Use pr_debug() to avoid spamming the system
> log.
> 
> Additionally, when the right bound check fails, warn_bad_map() reports
> the wrong ssn value, let's fix it.
> 
> Fixes: 648ef4b88673 ("mptcp: Implement MPTCP receive path")
> Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/107
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>

Thank you for the patch and the review!

- a88964048fec: mptcp: do not warn on bad input from the network
- Results: 02c88cfc4215..102ad1154235

Builds and tests are now in progress:

https://cirrus-ci.com/github/multipath-tcp/mptcp_net-next/export/20210604T200651
https://github.com/multipath-tcp/mptcp_net-next/actions/workflows/build-validation.yml?query=branch:export/20210604T200651

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
