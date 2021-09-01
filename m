Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A7E53FC1
	for <mptcp@lists.linux.dev>; Wed,  1 Sep 2021 08:27:56 +0000 (UTC)
Received: by mail-ej1-f41.google.com with SMTP id lc21so4872919ejc.7
        for <mptcp@lists.linux.dev>; Wed, 01 Sep 2021 01:27:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20150623.gappssmtp.com; s=20150623;
        h=to:cc:references:from:subject:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Yv4dWe+5zR9Eg17o3TiXVhCmDqK5uxEiNmwREZM7k+M=;
        b=s11nzr5W2xmvSzzuoGIbKbr2b4UapW6iOYvNJkVtMT22tO5onkrO4XMOQD5EKzRg50
         Uy3x5CYCAZbtYZ4G5cI4aPp/wV9DIrRy5B7P+cl2SDGnS1gGtqTtEbaHdDKuGOfVtv3D
         wnCs74mKqpWprqcxymbGe0sEpgNhQ99iksZefxyDRZWSJR5w+5AdBkb1hNXv8rf81lwS
         oZaM77z/mBalUaO58AGFlT/UQr5VkMGKz+puQEdXhElRrPKQjbBCb4hrGTtDzCvMtMO3
         BVBEoTE4f3gKD1amwaPZhjFYGv/yAe7ruFdY3zAX9P3s0mmdY/ODEYQbQ8kGdIVe/Xdm
         roVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:references:from:subject:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Yv4dWe+5zR9Eg17o3TiXVhCmDqK5uxEiNmwREZM7k+M=;
        b=iGmsu5Rajdvfsp672mP9Y4KDUNla2SjswwK6gODdwk9wJA3MbyaxdvUJYj5hXyagfB
         Hg+aCaibSyTgFc8LXFwIpiN4RdkN9M3ySflXasABEAGNy02KGPXAQt98K0AMEUpR27vu
         5RQC9ekmlzR8UtQQNr8kchAYkB5+/k8ZJAShLIphd9JsoTtibZne0+ZcEJ75YiuhR7ev
         kDan4XZY2gvZD+xbvC1C+28evXidpxQxpsDgVsA7RDtf7uDagU3N5OAHbgzuu02Yxl59
         hcKUXCT6/P/CjIroj0QFmisWjj33LiFaEMM0wyHR3CDiyj1gaJ3t0tWZjNSytNggzHP/
         /snQ==
X-Gm-Message-State: AOAM5310If0VG1dvK+Y3u9K7np2MXJtIevkMhTsA2V4n9kS2FnYRcFI0
	SkI0dp7EdIeivnxK/1HEQQeoNQ==
X-Google-Smtp-Source: ABdhPJwGSqy5H7eFISaGvwvWddFd9h/Va3PXa82CtDhJWtiUqdHbvdgm/vd+oTOeotxcnkSSwAKCqQ==
X-Received: by 2002:a17:906:e82:: with SMTP id p2mr35579875ejf.50.1630484874379;
        Wed, 01 Sep 2021 01:27:54 -0700 (PDT)
Received: from tsr-lap-08.nix.tessares.net (94.105.103.227.dyn.edpnet.net. [94.105.103.227])
        by smtp.gmail.com with ESMTPSA id v1sm9895342ejd.31.2021.09.01.01.27.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Sep 2021 01:27:54 -0700 (PDT)
To: Wan Jiabing <wanjiabing@vivo.com>,
 Mat Martineau <mathew.j.martineau@linux.intel.com>,
 "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
 mptcp@lists.linux.dev, linux-kernel@vger.kernel.org
Cc: kael_w@yeah.net
References: <20210901031932.7734-1-wanjiabing@vivo.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
Subject: Re: [PATCH] [v3] mptcp: Fix duplicated argument in protocol.h
Message-ID: <c519edd0-f263-0df0-40a3-8ba342c0a0fa@tessares.net>
Date: Wed, 1 Sep 2021 10:27:53 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20210901031932.7734-1-wanjiabing@vivo.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 8bit

Hi Wan,

On 01/09/2021 05:19, Wan Jiabing wrote:
> Fix the following coccicheck warning:
> ./net/mptcp/protocol.h:36:50-73: duplicated argument to & or |
> 
> The OPTION_MPTCP_MPJ_SYNACK here is duplicate.
> Here should be OPTION_MPTCP_MPJ_ACK.
> 
> Fixes: 74c7dfbee3e18 ("mptcp: consolidate in_opt sub-options fields in a bitmask")
> Signed-off-by: Wan Jiabing <wanjiabing@vivo.com>

Thank you for the patch!

It looks good to me too and MPTCP selftests are still happy with this patch.

Reviewed-by: Matthieu Baerts <matthieu.baerts@tessares.net>

Just one thing: please next time mention for which "net" tree this patch
is for. That's why you got one warning on Patchwork [1]. See [2] for
more details.

Here this patch is for -net: [PATCH net].

[1]
https://patchwork.kernel.org/project/netdevbpf/patch/20210901031932.7734-1-wanjiabing@vivo.com/
[2] https://www.kernel.org/doc/html/latest/networking/netdev-FAQ.html

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
