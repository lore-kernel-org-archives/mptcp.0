Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DE2A72
	for <mptcp@lists.linux.dev>; Thu,  6 May 2021 14:28:45 +0000 (UTC)
Received: by mail-ej1-f50.google.com with SMTP id s20so3066027ejr.9
        for <mptcp@lists.linux.dev>; Thu, 06 May 2021 07:28:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20150623.gappssmtp.com; s=20150623;
        h=to:references:cc:from:subject:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=XV29JtMwQ9m2KPUSdQt9g+37tOJkGo8D0yTHmPz9pGE=;
        b=mOz+3qVsPTnU4Phu1SIdY70WILWQpsIi72DLFBZINJEl9r2pe6idVcI0wRT8esiMwh
         ckrxhd5yERqSaQp/+v5u83RhWYf59AzrTB2yrq5C7HRMD1dcv5cpUZ9YvvU1hadAwbgt
         4vdKTdIGjw1qN//kZ3YDU/Vk/8N35lQXq8aSV7RfCVTDoJp2w5xgj4SU+oVGUQsFdUp4
         Hg2q/crYm7Z7lCUM+xLocX3VwNMFJgiW3JT+vmx1tL1naFE4o7j5kuYCj14aQrFUyI8/
         ZdokG5BwCqZIqjnXvQzLr85D75mXcgVcNnsXw4/AGojaXMaPgKGqGRaUDQ/BlpDOGsXW
         lY0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:references:cc:from:subject:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=XV29JtMwQ9m2KPUSdQt9g+37tOJkGo8D0yTHmPz9pGE=;
        b=XosmTWw/wE/bP/lxLBr79dHxiayTSjdQImwD/fcOEMK6MoDdcNzGKbiNNZADYI+rf2
         GMgW/X5mpQQs3AN12gOY59v6bJO4CLLh9e7FM4mVwDEJkKEgYtWx/lZNG1zcyNjrLQdA
         8yXqjpmWxZt6r3trlusdGmXFXrqRSqBpZDM33gTaEL22xDQZY9p2QqHJOi3+sDfUfOhz
         XGQolb/g/9XaGGs/IHSZgVVzEnEX+A18KRm94FK47Ub6EoGOEKUmSJs53EBr13JrlljY
         CNL3UmZP0U3seu+BjLxq/8qO7bLBf018Jvd8Zbk4UXlZuQwJ9/CnOr9LshvmF4LMcZYx
         ANPw==
X-Gm-Message-State: AOAM5310dPGW1nkvVPEc5YzxGpRtbI85Wmj5zMUSmvyLI5gZ1h30Bwg0
	kPQy0XrjeaILqHwKZW/u3xs9DVa4Dfmf5ZeWgYqGzg==
X-Google-Smtp-Source: ABdhPJypnD+vh5mUCIG4TmmWEVI54ZijKxV/iNwJRjg31wuCoLiY/wxzdu4ctbnCwyIoe5LEbwSkdw==
X-Received: by 2002:a17:906:11d4:: with SMTP id o20mr4715607eja.247.1620311324205;
        Thu, 06 May 2021 07:28:44 -0700 (PDT)
Received: from tsr-lap-08.nix.tessares.net ([2a02:578:85b0:e00:2955:d350:566e:2ff2])
        by smtp.gmail.com with ESMTPSA id g17sm2226807edv.47.2021.05.06.07.28.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 May 2021 07:28:43 -0700 (PDT)
To: Geliang Tang <geliangtang@gmail.com>
References: <cover.1620286893.git.geliangtang@gmail.com>
Cc: mptcp@lists.linux.dev
From: Matthieu Baerts <matthieu.baerts@tessares.net>
Subject: Re: [MPTCP][PATCH v2 mptcp-next 0/5] data checksum support cleanups
Message-ID: <f82f5458-e104-5848-f146-da2729a7129c@tessares.net>
Date: Thu, 6 May 2021 16:28:43 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <cover.1620286893.git.geliangtang@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 8bit

Hi Geliang, Paolo,

On 06/05/2021 09:48, Geliang Tang wrote:
> v2:
>  - add two new squash-to patches to rename the mib DSSCSUMERR to
>    DATACSUMERR.
> 
> Please insert patch 4 (mptcp: dump csum fields in mptcp_dump_mpext) between the
> commits "mptcp: add a new sysctl checksum_enabled" and "selftests: mptcp: 
> enable checksum in mptcp_connect.sh".
> 
> Geliang Tang (5):
>   Squash to "mptcp: add csum_reqd in mptcp_out_options"
>   Squash to "mptcp: add the mib for data checksum"
>   Squash to "mptcp: add a new sysctl checksum_enabled"
>   mptcp: dump csum fields in mptcp_dump_mpext
>   Squash to "selftests: mptcp: enable checksum in mptcp_join.sh"

Thank you for the patches and the review!

- c5be02caa9e6: "squashed" patch 1/5 in "mptcp: add csum_reqd in
mptcp_out_options"
- 29f92324f1c2: "squashed" patch 2/5 in "mptcp: add the mib for data
checksum"
- ad81f7fdc6f9: "squashed" patch 3/5 in "mptcp: add a new sysctl
checksum_enabled"
- e2cc6a7fbd2e: mptcp: dump csum fields in mptcp_dump_mpext
- d92aa7cd0a27: "squashed" patch 5/5 in "selftests: mptcp: enable
checksum in mptcp_join.sh"
- Results: dd923e74b091..9e9ac1620af0

Builds and tests will be launched after having squashed an extra patch
Geliang just shared.

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
