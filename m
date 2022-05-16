Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CD3110E0
	for <mptcp@lists.linux.dev>; Mon, 16 May 2022 16:18:50 +0000 (UTC)
Received: by mail-wm1-f53.google.com with SMTP id a14-20020a7bc1ce000000b00393fb52a386so11250319wmj.1
        for <mptcp@lists.linux.dev>; Mon, 16 May 2022 09:18:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=TJsDl8znQgrUMsk/j2LiMfl+ZDq7MKItHhiqd6dmquo=;
        b=ig5BstA7I7zXBMDZf7Av42FKakYxdP+GQ9Gdn8XocSQ4/i2VlW3e/HlhjGNOqG5Zzz
         YMVxJUNyv9yFRSkrnB0kXFv7XYc/vPZRbYhd8Il2pFBkGoLbXO35b+UZp0RuKI6kaICZ
         w33FAyg8HeG37bpry/wAj/0gIh2KMR3qWg2R5UjTFfq5/I+VHbmS5MpuEpudt/KVNs1Z
         nASC25APr/VnWLVbcr5L4k8q27uJXPNxmyhsgPI8e++do6bCsNInZH2kFLAW9o2t2ecj
         oUWVladXCAoE8mNqI57pxUbQI4+bBqZRNPQWKfYGacRX8B/OjiKvt2niA2s6t2D2F78f
         d9Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=TJsDl8znQgrUMsk/j2LiMfl+ZDq7MKItHhiqd6dmquo=;
        b=I8pVv0IshmOPqOD0V5HEGtjPJJFiRbFeLOujQiDLPDLUKgeOUoh77LRh9+GZ+hBEXA
         P48grAtEwNCkGZrPFA0b+yF5t5YHMq46xU9mGyYZCbyZN5HpTtKFvBQcVb6J4DdENOrt
         xxO7ZsrC9wkqrTmdJWQIisFxUvi0jVmpn/Xqh08GTaXMm0w67ZDmjunO/J83kkDT/SNd
         YIW9pV8fatSltgC+X1CR8iYN2lhBwL49BWZXmrmAYcqDmmAnQyQqKqwxnxdsbREH143B
         z9D8x6R77AGlVciLJ6Am3wPs5A3kDzfswMBtwaUsC0FT2aONywi341iBSAnemBm4vzDq
         Is0w==
X-Gm-Message-State: AOAM5301F6KQU3fTJo8LP07oYtWXCgwcpAHbgH9Gcq3gHaRnjclJ5eUC
	ZHFHogR3zwZqwH5ZbO+d/+EDIg==
X-Google-Smtp-Source: ABdhPJzvmNmXfyUxpSCD6MvHsS9Rolp/j/rE0LRKilVhxI9SptAGxy5IPCoWPxFcTy94jjXnfQ5y9w==
X-Received: by 2002:a05:600c:3b93:b0:394:57c8:5901 with SMTP id n19-20020a05600c3b9300b0039457c85901mr17748661wms.77.1652717928295;
        Mon, 16 May 2022 09:18:48 -0700 (PDT)
Received: from [10.44.2.26] ([81.246.10.41])
        by smtp.gmail.com with ESMTPSA id 8-20020a05600c024800b00394975e14f4sm10510595wmj.8.2022.05.16.09.18.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 May 2022 09:18:48 -0700 (PDT)
Message-ID: <9c84d083-f556-f439-9b47-fd0ad768b0bc@tessares.net>
Date: Mon, 16 May 2022 18:18:47 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH mptcp-next] mptcp: stop using the
 mptcp_has_another_subflow() helper
Content-Language: en-GB
To: Paolo Abeni <pabeni@redhat.com>, mptcp@lists.linux.dev
References: <5e05ab9275671ea3018eaa02028197817715de65.1652275377.git.pabeni@redhat.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <5e05ab9275671ea3018eaa02028197817715de65.1652275377.git.pabeni@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Paolo, Mat, Geliang,

On 11/05/2022 15:23, Paolo Abeni wrote:
> The mentioned helper requires the msk socket lock, and the
> current callers don't own it nor can't acquire it, so the
> access is racy.
> 
> All the current callers are really checking for infinite mapping
> fallback, and the latter condition is explicitly tracked by
> the relevant msk variable: we can safely remove the caller usage
> - and the caller itself.
> 
> The issue is present since MP_FAIL implementation, but the
> fix only applies since the infinite fallback support, ence the
> somewhat unexpected fixes tag.

Thank you for the patch, review and validation!

Just applied in our tree (fixes for net-next) with Mat's RvB and
Geliang's ACK+Test tag.

New patches for t/upstream:

- 9dc556bbb2c6: mptcp: stop using the mptcp_has_another_subflow() helper

- Results: 2cb58f40e877..7e5581f27ee6 (export)

Builds and tests are now in progress:



https://cirrus-ci.com/github/multipath-tcp/mptcp_net-next/export/20220516T161647

https://github.com/multipath-tcp/mptcp_net-next/actions/workflows/build-validation.yml?query=branch:export

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
