Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91DF36ADC
	for <mptcp@lists.linux.dev>; Tue, 25 Apr 2023 15:22:00 +0000 (UTC)
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-3f1728c2a57so61765755e9.0
        for <mptcp@lists.linux.dev>; Tue, 25 Apr 2023 08:22:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1682436118; x=1685028118;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/J65ouOO+jtH5pHEE8UbVQLVe6QX3UVKQhqrwr+QWz4=;
        b=466me34kAlEjw6aKH0EWKu2rIaiGRikKOi1Y2uNIYWmHxx20pxDFHoWxkxO/bI92y8
         nSMJfRNHwH3FX/tX+zVKhp50L2FlfVJbkJ1aGveNyAe++Blr7plWfpk0wlmcK7DRNVLY
         1J6nndC5uG855iBq+4es5I82CruVaLt8uVCtkoQtjPqKM2SnQBxAbnt3I2nr9V3bvcw+
         1WUXcVbADSlE07S3MlQZFk3txJGtknH8ihNCNKGxkeU9q1MpaODF76DnWuk6qeZIB/B3
         AjaBoT+h2sPjBX2gvEJ2JUzjwqGshbxt21hm/xGhuCb6dXGXXyvWaqEESreg1kVuqetp
         5WoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682436118; x=1685028118;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/J65ouOO+jtH5pHEE8UbVQLVe6QX3UVKQhqrwr+QWz4=;
        b=LlTGHgxMfKtheZpD03TRDoFqRQ533AFLnsCXMGtLtJnH+XxmlcmY+iWGfHEGAqKabd
         8y5u3y1t2oVlClcqM/6rqYk8C7WVqPwWUbWoRevJ6OjNNKitI56qKrbHO/vpaMqFUM5C
         tp60o+fpjgbOTgMrBrHy5qk/tNvU5Y9IxghoYtT1r1xU5MLSlOFvNnGjQEkFL4PzOPw5
         vWBd2ol2qJgZG17IJmoDBcxmvyQ6Vx9wHoPeVCYFVZGTIsWa3DtHv1Cs+TzckXS2wG9O
         xj6NEF6ehC3eIRNCxW9ieXrMX/Zcf/bZf7wszQSiTvRGzlND50OsCFFEcdK5NiysZtB1
         wOew==
X-Gm-Message-State: AAQBX9d7mBy1ah0Ls4o9qr6sABWq/fvsHMu+gkLMSzT6PGUIFwDTUix2
	xsa8pxCsf7uaUneaAdtaTIpKbLGMSuCssw+eObi4XA==
X-Google-Smtp-Source: AKy350YMAtg4BTauUQBip9lRWirQVTtFy7OHCKPOOOs1XEjpg8wsmmxDcPGCsqYsIlYq3q4pcl+L4A==
X-Received: by 2002:a7b:ce8d:0:b0:3f1:6fca:d5a5 with SMTP id q13-20020a7bce8d000000b003f16fcad5a5mr9454876wmj.17.1682436118329;
        Tue, 25 Apr 2023 08:21:58 -0700 (PDT)
Received: from [10.124.6.89] ([195.181.172.155])
        by smtp.gmail.com with ESMTPSA id f15-20020a7bcd0f000000b003f182cc55c4sm15257530wmj.12.2023.04.25.08.21.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Apr 2023 08:21:58 -0700 (PDT)
Message-ID: <26c26e1f-0d18-d38c-c8ad-a6d78c3cd4b0@tessares.net>
Date: Tue, 25 Apr 2023 17:21:56 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH mptcp-next v9 0/6] update userspace pm mptcp_info fields,
 pt 1
Content-Language: en-GB
To: Geliang Tang <geliang.tang@suse.com>, mptcp@lists.linux.dev
References: <cover.1682409247.git.geliang.tang@suse.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <cover.1682409247.git.geliang.tang@suse.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Geliang,

On 25/04/2023 09:55, Geliang Tang wrote:
> v9:
>  - address Matt's commets in v8.

Thank you for this v9. It looks better!

It looks like the CI spot some issues with the userspace_pm selftest:

> - KVM Validation: normal (except selftest_mptcp_join):
>   - Unstable: 1 failed test(s): selftest_userspace_pm 🔴:
>   - Task: https://cirrus-ci.com/task/6754937204375552
>   - Summary: https://api.cirrus-ci.com/v1/artifact/task/6754937204375552/summary/summary.txt
> 
> - KVM Validation: debug (except selftest_mptcp_join):
>   - Unstable: 1 failed test(s): selftest_userspace_pm 🔴:
>   - Task: https://cirrus-ci.com/task/5629861931253760
>   - Summary: https://api.cirrus-ci.com/v1/artifact/task/5629861931253760/summary/summary.txt

I have a few comments and ideas, I'm going to share that in each
individual patch.

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
