Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 928072FB1
	for <mptcp@lists.linux.dev>; Thu, 13 May 2021 07:32:03 +0000 (UTC)
Received: by mail-ej1-f54.google.com with SMTP id m12so38616630eja.2
        for <mptcp@lists.linux.dev>; Thu, 13 May 2021 00:32:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=l0k/az6pZfAPCF/SKNYYO20NBx9g10UVoz7B69Z4+as=;
        b=EAL/LMX8ZzjZjoPhv6QRA3ur0VoHs2LD72lS3Yg06bbUG4pWBHCxeNkw0ivRCuxsMZ
         DMMX6zMVV1umeXVtIQqZaES1bRhS0jzcRt68UUi9mI4nQWrTMducBFqE6B9oFzHTBwB1
         Fqwp1PkTrTjr4DemgxEzJKVnBDNu0poJnVGGph7EQJoTZuG0yPCywiuDioawv+l9nWbM
         HXc0ZJP8xbEbVJFdkDxr0LHIu5I8caKYPdjydvb0LhZPqb0GQI3IyBOyxGVBwkbcKovM
         drnwT/jhf94CAJQhOERjGUkHKT+4HBuHAPymhrd1cFgsdtp57Y0TJ6dYs5i4LlVbSxWN
         OQ1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=l0k/az6pZfAPCF/SKNYYO20NBx9g10UVoz7B69Z4+as=;
        b=lbV0oxDzoqQXRuFSWzCfshjfojWunPGWw2ss5utF+xkjSOzx3DzJTCsoJiyLzpXmDB
         yAnKgqUSh4leUKg37p6bbK17zOZxOGyMTygssdIKI72zZB7tCc9mY8su0uRlEVI32nO8
         bcNR7h9TG94VMNeSmd0In6vUv5cndGNcVQoenyhUUNTMSqTW9+DX9MXjMBf0Ra9nwq5+
         cF4Jzyk3a/lMS1RzWpCeNj/QUev3uIzUuE09uYfgcNzfVrCG9zNgJZq1ys1Dv1ygeUgt
         GKb/VNSsmuLahie3iKBXSURyPOt+fNA7U8/4LpxN04OmpWpyAS/hfTPEq3Rfftsuf0iX
         mtRg==
X-Gm-Message-State: AOAM532sV5yGJyZ9229WkqpeitrvRjGJXJPJb6pwzGPtozoNn/QMATIH
	45oyCxp88RrauH0eFqNo2VDGCLr1lmqdS5az
X-Google-Smtp-Source: ABdhPJxsJFy7iN+3NxsKjUMETokId1z7XHNfCkn2nQ440ssXm2+tKsVjvlfWHR5kkqfUEUgASihI8g==
X-Received: by 2002:a17:906:4d50:: with SMTP id b16mr42153877ejv.53.1620891121755;
        Thu, 13 May 2021 00:32:01 -0700 (PDT)
Received: from tsr-lap-08.nix.tessares.net ([2a02:578:85b0:e00:8928:ef6b:4f39:1fcb])
        by smtp.gmail.com with ESMTPSA id h9sm1737498ede.93.2021.05.13.00.32.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 May 2021 00:32:01 -0700 (PDT)
Subject: Re: [MPTCP][PATCH mptcp-next] Squash to "mptcp: add csum_reqd in
 mptcp_options_received"
To: Geliang Tang <geliangtang@gmail.com>, mptcp@lists.linux.dev
References: <f3808e3bfccf51a4a41e8ff3c793a464d8c3ae61.1620349748.git.geliangtang@gmail.com>
 <9d886bb5015a687a46287accd3a6f1111233eda7.1620349765.git.geliangtang@gmail.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
Message-ID: <960dca25-e519-268c-dfbd-a51f055b334f@tessares.net>
Date: Thu, 13 May 2021 09:32:00 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <9d886bb5015a687a46287accd3a6f1111233eda7.1620349765.git.geliangtang@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit

Hi Geliang, Mat,

On 07/05/2021 03:12, Geliang Tang wrote:
> Init csum_reqd in mptcp_get_options, keep mptcp_parse_option unchanged.
> 
> Signed-off-by: Geliang Tang <geliangtang@gmail.com>

Thank you for the patch and the review!

Now in our tree:

- 946635ce56b1: "squashed" in "mptcp: add csum_reqd in
mptcp_options_received"
- Results: bcf6675a2d3f..6628a7b4ea41

Builds and tests are now in progress:

https://cirrus-ci.com/github/multipath-tcp/mptcp_net-next/export/20210513T073141
https://github.com/multipath-tcp/mptcp_net-next/actions/workflows/build-validation.yml?query=branch:export/20210513T073141

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
