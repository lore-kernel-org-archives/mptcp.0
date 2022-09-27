Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 168C7653
	for <mptcp@lists.linux.dev>; Tue, 27 Sep 2022 08:02:52 +0000 (UTC)
Received: by mail-ej1-f50.google.com with SMTP id sb3so18945160ejb.9
        for <mptcp@lists.linux.dev>; Tue, 27 Sep 2022 01:02:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=vnkUNMqAdVyOSaNbKOl+afip4x37ChdQTdIZiVVBGr8=;
        b=mUG4OdjUkmJyfP0pQ5DY+eN21sddar7cRtLLosf6c2E8hnsKHjl4T+W348S2xsHMXF
         MyHTykAT+bCILaumJ3BWTSr2BICVwkzbvUyEYCDZdTJROF4835d4r1onwsCwmYPXly3I
         8xq0mIH2ZEWwaFYev0+Ybk7JOYl9YtDjh9TQofZ5v1qLsea7P2zBPxXKRIalvfXlKUMB
         TdTMkzcUuYsA8SqYDUnHEb2WGZyxwKZSLWdoFRqFUqVWsrxUDT38N1PxmoHgIKZe3i/R
         8ax/9hGXjI78Fr/Gw0JytZGKv3L4psbM8wR+GoKWXGMBStkGogAddg3jTbcG+QxRXFy3
         OBBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=vnkUNMqAdVyOSaNbKOl+afip4x37ChdQTdIZiVVBGr8=;
        b=gpX9iWGfU6xTkxdthu05kEnAQa6VGLxKkoXQ2zz9PrrNL6LpF3iryRv1ve/lFyYMPZ
         DdyoYNyQNnpXp1a8VVqX9F5YzYTeM/6usdSu4YVVKyhm5nuFrHoWD3F6xk+UvSLI8U5M
         PA/ALetLDH6ggJ0GIv7GTaSprbyBUeDqReAuT7WkPcP7DhEYbTGO49vPSxWmsXVUje+v
         bMbtmlCp4jzG5Z6q+l5hsOJrPeCrfGukWwIOhmZr7rUWBftG4pS3bowjLrdFzjlMu31T
         RhrUe/GlNLwkjb/Oag0Ib7XVyhrD9AYpnUjDS1d9PeQBwfvFklHYlf/L5cpeqGR7ug9c
         3yRw==
X-Gm-Message-State: ACrzQf2/MxXMpe60p0a1EuU78XdqoHjqacSmXocCLmoxXL5PscLOEdMw
	etFdNuTz4mRXvEqIOhhrN9NsWpdqstI2lFCI
X-Google-Smtp-Source: AMsMyM6iZGRghzpeCXodRGwiEW+QAGJGU4Q+5VqeiAFKCPswQjGFrBm916QJn5tvW1Up4U3oOPRnzw==
X-Received: by 2002:a17:906:7621:b0:750:c4a3:8fcd with SMTP id c1-20020a170906762100b00750c4a38fcdmr22145723ejn.180.1664265770867;
        Tue, 27 Sep 2022 01:02:50 -0700 (PDT)
Received: from ?IPV6:2a02:578:8593:1200:9302:e21:26be:f795? ([2a02:578:8593:1200:9302:e21:26be:f795])
        by smtp.gmail.com with ESMTPSA id u17-20020a1709061db100b0078135401b9csm386280ejh.130.2022.09.27.01.02.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Sep 2022 01:02:50 -0700 (PDT)
Message-ID: <56daa6c0-bcaf-4060-215e-f2a42e90b99b@tessares.net>
Date: Tue, 27 Sep 2022 10:02:49 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCH mptcp-next] mptcp: update misleading comments.
Content-Language: en-GB
To: Paolo Abeni <pabeni@redhat.com>, mptcp@lists.linux.dev
References: <870262a8c7ca7eb682da90684f2ff193a818924b.1664205929.git.pabeni@redhat.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <870262a8c7ca7eb682da90684f2ff193a818924b.1664205929.git.pabeni@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Paolo, Mat,

On 26/09/2022 17:27, Paolo Abeni wrote:
> The MPTCP data path is quite complex and hard to understend even
> without some foggy comments referring to modified code and/or
> completely misleading from the beginning.
> 
> Update a few of them to more accurately describing the current
> status.

Good idea, thank you for the patch and the review!

Now in our tree (feat. for net-next) with Mat's RvB tag:

New patches for t/upstream:
- 2bf3d5448679: mptcp: update misleading comments.
- Results: 676709a1f80b..34c4fe0fbc95 (export)


Tests are now in progress:

https://cirrus-ci.com/github/multipath-tcp/mptcp_net-next/export/20220927T075707

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
