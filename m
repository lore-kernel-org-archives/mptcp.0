Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D999471
	for <mptcp@lists.linux.dev>; Wed, 16 Jun 2021 13:57:02 +0000 (UTC)
Received: by mail-ej1-f45.google.com with SMTP id hq2so4124647ejc.2
        for <mptcp@lists.linux.dev>; Wed, 16 Jun 2021 06:57:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=WLQm9bO/v4odpdaMWPykyQmaUICNaLNesahvzfGmuW8=;
        b=0oDMUY5FLnyadLjAqDCcYPLaYss7cRt0Rx+aiFGqofl/qtxl9MBsR1eGQBzDRVqd3o
         B91atDp0gACdeD/gLABKzeWOoXcp7FyDiZW0mYyBBNxfwxRjb23eo2xoMS/Me3BL93Ei
         Jlahwj6i+/dBZi7TQXUVVn82vLdsBeJX7612Lv5xSFqvMc6aHOpUr96UJfGMumo3SsUS
         P95JZX62Py8cXIrwHTbh5SuND9XfBd9ySwB5Ww3ckKwL9xBOnArF/z4ZGtvTQcJWQ7Mj
         x95abIIkVe0d7k6tf6kM1gz1Ik3Rx17XtnFwu4VOttNp2YYiXybmA193UP2/qOZsPLHV
         fdyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=WLQm9bO/v4odpdaMWPykyQmaUICNaLNesahvzfGmuW8=;
        b=LWPMYiAWjPhm2iJs8RBhpyi8OKdDPttAO5OWN6sCTohDUhU2H9Onvlq3hDtcpJafaK
         OfdG3kVayPdKxjJ+88mWRcSWltle/5h8m93H8K1BUZGOfTusspuyX2JFl3b64QAMO4nE
         xubcrDkN3/TJqfU9o6ZCyJ+u8Guqfarewir05ipj7fBIrhLZiXLKVbf0dXfFwWTziglD
         yuwUF5YhMcDIxeUa5y7rEuMW7dhhzFjMHdraRTEaltmkVuXihtHHz+h9I8yyL1bSNMr/
         pKsHUCm/V4E8wZOT0lFc49qTnwD3fNxXNrXsXjDZi+SHsuYFTq/5pVc/+8feta3u/3mS
         oyYg==
X-Gm-Message-State: AOAM533A9iGd1AUPtEm0FJzoFbIcW+4l8Ei+gR7cqSO7uiMtrOYsvoIP
	0fK+J7ylmP9NZfopWmadF+DqFg==
X-Google-Smtp-Source: ABdhPJxcq0/XyM3Rd37/7n4+sZBRDLwlNzUqlfjvypnVN1cRgv77szzmCtcoHklQAQpDaUZMevJV1g==
X-Received: by 2002:a17:906:7d0:: with SMTP id m16mr5532387ejc.319.1623851821010;
        Wed, 16 Jun 2021 06:57:01 -0700 (PDT)
Received: from tsr-lap-08.nix.tessares.net ([2a02:578:85b0:e00:9129:4177:7fbf:cf97])
        by smtp.gmail.com with ESMTPSA id q9sm1784698edw.51.2021.06.16.06.57.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Jun 2021 06:57:00 -0700 (PDT)
Subject: Re: [PATCH mptcp-next] Squash-to: "selftests: mptcp: turn rp_filter
 off on each NIC"
To: Paolo Abeni <pabeni@redhat.com>, mptcp@lists.linux.dev
Cc: Yonglong Li <liyonglong@chinatelecom.cn>
References: <69fc350d5e6b4faeb9cffbbd5d36723e236b2ca2.1623849517.git.pabeni@redhat.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
Message-ID: <e4787877-874f-c44a-38b4-0a6d8e16799b@tessares.net>
Date: Wed, 16 Jun 2021 15:57:00 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <69fc350d5e6b4faeb9cffbbd5d36723e236b2ca2.1623849517.git.pabeni@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit

Hi Paolo,

On 16/06/2021 15:20, Paolo Abeni wrote:
> "$1" is undefined in the setup loop context, $i should be used
> instead, otherwise setup (and tests) will fail.
> 
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>

Good catch!

- 94e9d2854eaa: "squashed" in "selftests: mptcp: turn rp_filter off on
each NIC"
- 7c34dfc3461b: "Signed-off-by" + "Co-developed-by"
- Results: bddebf30244a..2f591d25eeec

Builds and tests are now in progress:

https://cirrus-ci.com/github/multipath-tcp/mptcp_net-next/export/20210616T135631
https://github.com/multipath-tcp/mptcp_net-next/actions/workflows/build-validation.yml?query=branch:export/20210616T135631

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
