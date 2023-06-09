Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A025182D4
	for <mptcp@lists.linux.dev>; Fri,  9 Jun 2023 15:30:56 +0000 (UTC)
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-514924ca903so2906288a12.2
        for <mptcp@lists.linux.dev>; Fri, 09 Jun 2023 08:30:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1686324654; x=1688916654;
        h=content-transfer-encoding:in-reply-to:from:cc:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Djb50LqnJu4qOT4BChLR5+whsLOEZjk0Yw+KvqO3sO4=;
        b=hLsBSUhkkkdiJMDjNw887EVRnUhxbHkZXQPtwYhP2+iM0BZsprtKtP6vWuVRei/jdA
         FVXQb4CFVB5fxyO0H8Fyhy5QylJgcRKcubbW1AbqDtt1wXQtiS94D1xz7lkRtpPMNDUv
         TvLS4ckXfwE+m+olsHvA/sKG0AH8blgwyuMXlh24yKzTzy6uzWdwW6uVMgtAYspQwZcT
         V4TS9gGVQ5IoWENS3l4FIezkkVT6CAsFJ/0Sj08MDw21X7qud2md3cAtOwkLLPKidRmM
         aBwbUOvSAjCRAn1Cb3DlgzKehGiBvhUGwHW4STdyeIQcdxzgYUlLGzTfAD2XdVmJ94kY
         4RdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686324654; x=1688916654;
        h=content-transfer-encoding:in-reply-to:from:cc:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Djb50LqnJu4qOT4BChLR5+whsLOEZjk0Yw+KvqO3sO4=;
        b=S/aOwSpf2XIEyUTGJ4yINYXFAGZYNqt7FI0ye/E9IBspeBAMZT9niuCHIV4aOieYH3
         X+TB1XEjgx2IHyyJWmBXKd7rNYGKrQF12uVhWjul+AAa6Evjfrar1hQo3RTMVPOtN5/4
         XEvPLPh0ncHdG0VaCleGpo6WCsBqWKgnmwK1J6myAkNe06Izb0puDFF8R9PBvdqcc0xI
         v93gDzE8pq4gCvnoNFp6nIQWqLwr+pmhtEw2bUJR1ku9nSRLXyuxS1xo+9iUR9LM1ZbD
         dFSEiXYhBtlXI9QxRBa8GEFPhQmc0yj/vKxyC8GoaGbeEYORvLrcNHN234R9ETl23N+U
         StMw==
X-Gm-Message-State: AC+VfDxsjgFj7RQcjJN6CU62PYwVnr8RgeZ3T+QesIPTdsrUpNFBlBZn
	/qWDE4wfumcTP0xlkAde94/YrA==
X-Google-Smtp-Source: ACHHUZ4ZbDEPcmMvQOPN/zLCWwLXP5zBbmD5a/XrQ9kTvgkwqICO7nNee/vS8t+qzNDBeUIugEOr8w==
X-Received: by 2002:a05:6402:344f:b0:514:9904:c8fe with SMTP id l15-20020a056402344f00b005149904c8femr1316808edc.39.1686324654183;
        Fri, 09 Jun 2023 08:30:54 -0700 (PDT)
Received: from [10.44.2.5] ([81.246.10.41])
        by smtp.gmail.com with ESMTPSA id c13-20020aa7c74d000000b0051823c1a10bsm144235eds.54.2023.06.09.08.30.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Jun 2023 08:30:53 -0700 (PDT)
Message-ID: <099a23c1-b2b9-d532-679d-fdac4e61d171@tessares.net>
Date: Fri, 9 Jun 2023 17:30:53 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH mptcp-next v17 0/7] update userspace pm mptcp_info fields
 part 2
Content-Language: en-GB
To: Geliang Tang <geliang.tang@suse.com>, Paolo Abeni <pabeni@redhat.com>
References: <cover.1686138130.git.geliang.tang@suse.com>
Cc: mptcp@lists.linux.dev
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <cover.1686138130.git.geliang.tang@suse.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Geliang, Paolo,

On 07/06/2023 13:44, Geliang Tang wrote:
> v17:
>  - rebased on export/20230607T094151
> 
> v16:
>  - address Matt's comments in v15.
>  - the last two patches in v15 is deponed on "selftests: mptcp: skip
>  tests when features are not supported", split them into a new series.
>  - this series have no conflect with "selftests: mptcp: skip tests when
>  features are not supported" now.

Thank you for the new version!

I have a few questions if you don't mind, please see the individual patches.

There is also a question for Paolo on patch 7/7 if you don't mind :)

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
