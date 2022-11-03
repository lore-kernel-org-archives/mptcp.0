Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7E5E63A0
	for <mptcp@lists.linux.dev>; Thu,  3 Nov 2022 17:16:36 +0000 (UTC)
Received: by mail-wr1-f52.google.com with SMTP id h9so3838895wrt.0
        for <mptcp@lists.linux.dev>; Thu, 03 Nov 2022 10:16:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Pl4qhCxLL4xkpVwXGvhnGrcqlWu+mPVYMGtsyxZOdUk=;
        b=NMMirHi8yE2dflSyoLGhy3E8BGuFqsHs5+rMox5EnEvKULue4fcJewiLR2iAh8wajD
         xIYRinRw0+wn6KkeRXc7wMNP24E3L4+ttasSgngQWTBZQRSx0Pd0Ypdyjav9Vt1eeQox
         xb90QkTJyNM/gMaVarCq3znb+UAX4M29oQ06VTw96DYoT/wI2SiCaHRurCRxMyHHXSdt
         mcEet7M8e689z7q/LWndqSRRmeHYNTf3320K1SyC/A/awq0kwOL7wyf0BPsC2YUf4pmb
         QCtrfEwy2zXQRSdi1V1uRd+ENr9Yigro0XqNFH927cTsNxADIl97+PBLk77f30zlBxxh
         mKIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Pl4qhCxLL4xkpVwXGvhnGrcqlWu+mPVYMGtsyxZOdUk=;
        b=kQRD+0n9WEBdHZf0ia/VYFSmiORsMqOcBy8FOHIWpDrh+19b0DQlbIi4NspOKYhiC2
         +3WrkYdVLcW/AUcB8nWMJBpvKvRKYKv72O6bg+UJs0wkLUBuuZOnGYIX7fP2UpZIzAKP
         3AlRup8wEn3upC8I/7COxDUZSD3JBUqGIZVnQ5TGXBdhZTyKUIolVB1mjh3SrRPYLWRK
         XtZGEoVtp55ab/XHUYdu4rJvlueR9tnnD/B52RIWsFefyXmgoMGn+Xh5de45+TEzWSbP
         iN5yk7/RljVMwQzXDZsFM1KJx2Ws0SkWiO0yUDCxvj/2jvI9eV66r6g9MVa6sDuude2e
         mi+w==
X-Gm-Message-State: ACrzQf05/IyGEx5yXd1fUH95r1F+18yGH/EuYaAtJXq6KGi65XldWBQ6
	cJ4myXWIPo96VfjTILyW/4+S1aRAlNfIAo1D
X-Google-Smtp-Source: AMsMyM4bgIv53CwfUXqLjkkXLykSFIWop89kDYZfwqBBxcOmEH1qAjAP5OvwN9S/O+0QDfjPDy9UQA==
X-Received: by 2002:a05:6000:3c3:b0:236:b2ce:593e with SMTP id b3-20020a05600003c300b00236b2ce593emr18294614wrg.580.1667495794321;
        Thu, 03 Nov 2022 10:16:34 -0700 (PDT)
Received: from ?IPV6:2a02:578:8593:1200:f4ce:89a5:47d5:7afb? ([2a02:578:8593:1200:f4ce:89a5:47d5:7afb])
        by smtp.gmail.com with ESMTPSA id hg7-20020a05600c538700b003cf4ec90938sm465830wmb.21.2022.11.03.10.16.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Nov 2022 10:16:33 -0700 (PDT)
Message-ID: <369d6887-4c0f-9e21-6679-ba76ff19c55a@tessares.net>
Date: Thu, 3 Nov 2022 18:16:32 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [PATCH mptcp-next] selftests: mptcp: use max_time instead of time
Content-Language: en-GB
To: Geliang Tang <geliang.tang@suse.com>, mptcp@lists.linux.dev
References: <20221022133528.31996-1-geliang.tang@suse.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <20221022133528.31996-1-geliang.tang@suse.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Geliang, Mat,

On 22/10/2022 15:35, Geliang Tang wrote:
> 'time' is the local variable of run_test() function, while 'max_time' is
> the local variable of do_transfer() function. So in do_transfer(),
> $max_time should be used, not $time.

Thank you for the patch and the review.

As discussed at the last meeting, this is a clean-up, not link to issue
#310 on GitHub. I just applied this patch in our tree (feat. for
net-next) with Mat's RvB tag and a small note to mention the behaviour
is not changed (so no Fixes tag).

New patches for t/upstream:
- ee199def31da: selftests: mptcp: use max_time instead of time
- Results: d841341ecc36..c40114c3c367 (export)

Tests are now in progress:

https://cirrus-ci.com/github/multipath-tcp/mptcp_net-next/export/20221103T171406

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
