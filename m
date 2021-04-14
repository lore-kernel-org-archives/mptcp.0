Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A1DA6D28
	for <mptcp@lists.linux.dev>; Wed, 14 Apr 2021 16:07:12 +0000 (UTC)
Received: by mail-ed1-f50.google.com with SMTP id m3so24370231edv.5
        for <mptcp@lists.linux.dev>; Wed, 14 Apr 2021 09:07:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20150623.gappssmtp.com; s=20150623;
        h=to:references:cc:from:subject:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=eezzS+bu+xdrsjiGBL2I8GftIkeUle4uhxWsQgQETnM=;
        b=JgJXgrNv0nPeMQYcK6Bkrr/x7Cy04UP+47yDF/ze1XemmBi/SwChcj3W+p0rElRI8e
         iKJXw4FuraTUid0yQ45ZzWXD01nOwp5jjuXjPx57hCMnL5mLT4z5apDbsorSsvWOoVjb
         Vx3Oarpi7Ihjl5FywD2LrVkei4tpmKrhTkSh87eP/4gdewLslPtGxNBA3X1WI0Kv841r
         SC9yuy/d93NudpJMWT1NXMS4S421Zr+vt0n2aZKejUDNExrq1+aTn6uguM6nFhyYH5Fe
         s+wicQQ31v5dNrJxnZUoJE0FyTtRYJuEsXL9PwI1pEMJA+Vxni+s5L2pAoaNDRakx+4Z
         ngVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:references:cc:from:subject:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=eezzS+bu+xdrsjiGBL2I8GftIkeUle4uhxWsQgQETnM=;
        b=o6hZU9wy1Zik+yJqFgC/E4D+u0OOw2+BbKjxJi7N8r/aCGPaFpOAGWFmbAuZdEKz0S
         TSnTp+D6nzCmMOQI5rmPSuIQO3Db+i7vlF44XOQEW1laTsmQVHy/2yYhDz+d1Lj/m5/U
         +c9YnurINrgFf5L4i3PbEyTndO7hxiqrQnDYBSi2rxZzxrG1A95wEjEwNcX5BHrzjIYB
         4kNl71qaQSZTNJC/Ky6jzKsh+r7B0EZSx4XTgLv796n957ZHOsmSn6+BgahVvv+WdtIH
         vk1wUFkLRLWWJ5cezJtjkR4jREm0iQ5jvI5qKQsYNEp18izn23GQBfmljx507xJD3edV
         IaOw==
X-Gm-Message-State: AOAM5338BgvlXUqBdboYLL+G1SB76GEmv7HKUg9NPcYedddToqPlZHeS
	UnDOF066NXLy2jD0cWyu1yxsRmp7NASt6w==
X-Google-Smtp-Source: ABdhPJxrj5UZx3Wj6PWj1bVxsSWglimt9ZIk/un741KwzBhDWrU8e/WGBO4fvQKTaJK3BN01kYZWQw==
X-Received: by 2002:a05:6402:518b:: with SMTP id q11mr41787032edd.151.1618416430506;
        Wed, 14 Apr 2021 09:07:10 -0700 (PDT)
Received: from tsr-lap-08.nix.tessares.net ([2a02:578:85b0:e00:29e9:f851:10c:9912])
        by smtp.gmail.com with ESMTPSA id r19sm10192766ejr.55.2021.04.14.09.07.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Apr 2021 09:07:10 -0700 (PDT)
To: Florian Westphal <fw@strlen.de>, Paolo Abeni <pabeni@redhat.com>
References: <20210413155447.14043-1-fw@strlen.de>
Cc: mptcp@lists.linux.dev
From: Matthieu Baerts <matthieu.baerts@tessares.net>
Subject: Re: [PATCH mptcp-next v2 00/10] mptcp: add SOL_SOCKET support
Message-ID: <e0e79a1e-537f-632b-1157-e25e70bd817e@tessares.net>
Date: Wed, 14 Apr 2021 18:07:09 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20210413155447.14043-1-fw@strlen.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 8bit

Hi Florian, Paolo,

On 13/04/2021 17:54, Florian Westphal wrote:
> This patch set improves support for several SOL_SOCKET tuneables,
> addressing comments received for v1 patch set.
> 
> Changes since v1:
>   - In patch 1, move addition of a variable to patch 2 (Paolo)
>   - In patch 2, restrict overflow of sequence count to lower 24 bits (Mat)
>   - In patch 2, remove a obsolete check on msk->setsockopt_check (Paolo)

Thank you for the patches and the reviews!

Just applied in our tree with Paolo's Acked-by tags and a small conflict 
resolution:

- 6a63626d8b65: mptcp: add skeleton to sync msk socket options to subflows
- 8d64e3af6a01: mptcp: tag sequence_seq with socket state
- d3123e0f11d5: mptcp: setsockopt: handle SO_KEEPALIVE and SO_PRIORITY
- 312dafe0427f: mptcp: setsockopt: handle receive/send buffer and device 
bind
- 0c26e2e19d8c: mptcp: setsockopt: support SO_LINGER
- 796f06044fcd: mptcp: setsockopt: add SO_MARK support
- 5380a8b59dd4: mptcp: setsockopt: add SO_INCOMING_CPU
- 56063458e089: mptcp: setsockopt: SO_DEBUG and no-op options
- a403361b4aca: mptcp: sockopt: add TCP_CONGESTION and TCP_INFO
- 2857df86a4b9: selftests: mptcp: add packet mark test case
- 0d4cddd31dc4: conflict in t/DO-NOT-MERGE-mptcp-use-kmalloc-on-kasan-build
- Results: f90b3d445732..f15eff9346bc

Export + builds are in progress!

Cheers,
Matt
--
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
