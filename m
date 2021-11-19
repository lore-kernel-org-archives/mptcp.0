Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CD5368
	for <mptcp@lists.linux.dev>; Fri, 19 Nov 2021 16:09:25 +0000 (UTC)
Received: by mail-ed1-f52.google.com with SMTP id o20so260614eds.10
        for <mptcp@lists.linux.dev>; Fri, 19 Nov 2021 08:09:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:cc:from:in-reply-to:content-transfer-encoding;
        bh=dOT74ODyMk4j1TcBxq+ymfbyTG/GYtYL81AQq7DvKyg=;
        b=J6np/KeDPY/dxcDhf//THMg85wyy6oAMHzr2ddCZTVaX+J3ssLDUPM9CWry/E1qCFP
         hBYdwXNwXRprq7v0Mu6DEYLrCejNbuCepeRVZXkuoNm5MfKxNQpA4qZ1XBEdI30xuMoY
         ydFw/tCBJ44BZ828/ETQevzJXIET7NZcWKuAqmR2FBfRcls5tBxIShKvoYAI/f3k/v/u
         b79WgDNLvwZjD98S3Wxioat114k7aQo8b59B+k06EtAmn1JUK5OnRfXIbBMGhRcMCykV
         z9MyL1MoU3ba+IR8thR/yIGkrpJGuCyqsM7XfyG/iO3rwhBqG/PTuiTga7JPDBGFjN6+
         Hd9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:cc:from:in-reply-to
         :content-transfer-encoding;
        bh=dOT74ODyMk4j1TcBxq+ymfbyTG/GYtYL81AQq7DvKyg=;
        b=WNHNFojKp0bpf6NrguW5iaXnTDCf5cOOtCX9LKv16r67LtGNka5jfN+elhswWBZoFV
         dtlcRKZtQ07tTKWLHHKK6EnR/cUjLGHFjudcH4ZQl2e6eMhgn6U5iGiSj0j0YDLxZ29Z
         dpiGRz1x5CjI3ELullZUVhjWE9tXReHGYe3uZ9aL0RhnHq0SMHfIJrsJYCSRHMGD1LM+
         OmjG1vdFVUOgzNGZ2RcuZEWRIBU10WKMCj2N0HB2bZqHzRszeRO2KWtjFiXUZn98I8bQ
         dQrLz5/dNptkJA13oa/6M3lpNTXMA9FYoLG+SZbZ/dFGytwb3Socd+/2kh8Z/FZz0my4
         U3Uw==
X-Gm-Message-State: AOAM532MepWa2SPQuH2vpzYWsE+uKE1PZWZSYLH2ThpC+Qv3ZJvWUAtS
	ZsSyCdHKN/euAzD+H/pmavbMUPAkwMOO4w==
X-Google-Smtp-Source: ABdhPJzyMzKiyO4qQ2VdG5n8g9xxiyZJmJHUexKdg2RcZU6ZJFde4qYoxCWeK0vSDmwaH5M4kGGE9A==
X-Received: by 2002:a05:6402:4301:: with SMTP id m1mr21462358edc.54.1637338163924;
        Fri, 19 Nov 2021 08:09:23 -0800 (PST)
Received: from [192.168.178.33] ([213.211.139.36])
        by smtp.gmail.com with ESMTPSA id ar2sm124393ejc.20.2021.11.19.08.09.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Nov 2021 08:09:23 -0800 (PST)
Message-ID: <af2bda56-ea65-cfec-8671-1b3605f66590@tessares.net>
Date: Fri, 19 Nov 2021 17:09:22 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.1
Subject: Re: [PATCH v3 mptcp-next 0/4] TCP_INQ support
Content-Language: en-GB
To: Florian Westphal <fw@strlen.de>,
 Mat Martineau <mathew.j.martineau@linux.intel.com>
References: <20211116134804.30090-1-fw@strlen.de>
Cc: mptcp@lists.linux.dev
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <20211116134804.30090-1-fw@strlen.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Florian, Mat,

On 16/11/2021 14:48, Florian Westphal wrote:
> No major changes since v2, see individual patches for details.
> 
> This adds TCP_INQ for mptcp and extends the selftest infra.
> Patch 3 adds ioctls to retrieve amount of in-sequence bytes
> ready to for read() (older version of TCP_INQ) and counters for
> unsent and unacked byte count.
> 
> Last patch is new in v2, its a more specific TCP_INQ test case.
> See individual patches for changes since v1.

Thank you for the patches, the reviews and the reply to my question
about the ChangeLog!

Now in our tree (features for next) with Mat's RvB tag (and without some
warnings from checkpatch in the .c files of the selftests, nothing
important)

- 2633e427d5c5: mptcp: add TCP_INQ cmsg support

- 18b1970dd676: selftests: mptcp: add TCP_INQ support

- b85f910f78d7: mptcp: add SIOCINQ, OUTQ and OUTQNSD ioctls

- 75e2fd074427: selftests: mptcp: add inq test case

- Results: 3bb02e3cfe5d..3ebf8b8d1426

Builds and tests are now in progress:

https://cirrus-ci.com/github/multipath-tcp/mptcp_net-next/export/20211119T160804
https://github.com/multipath-tcp/mptcp_net-next/actions/workflows/build-validation.yml?query=branch:export

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
