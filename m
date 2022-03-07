Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EB567A
	for <mptcp@lists.linux.dev>; Mon,  7 Mar 2022 14:04:32 +0000 (UTC)
Received: by mail-wm1-f50.google.com with SMTP id 19so8981335wmy.3
        for <mptcp@lists.linux.dev>; Mon, 07 Mar 2022 06:04:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=7jpu9y43I8brwrqklZhYkRoFva2SBDrErqVbdkhvVqo=;
        b=wEy3jsPWP6zHYsvujZyA9I1MwU59hENBsEh5s2DsifrKypS+KApWZGFe3T+cYC0IH9
         1EwLRRKfmOrhMb6AuEyqVtC8HWPP382ucTWP6O5zJ8tTU+mSXQXCaeiRlji7fgTq2lOG
         pvqj8DFXYIklOhmdJa3TBJjezgZcRMYuAydtoKGr4JmoP4F3a/Cv70n0u8xeKloIYbrv
         3XC3tw1k7eUXTJrEe1oZnPZpNrmRDQ/S3SzdTgAjWeQNjF33Yyv6cP4KL+f8SZFBGQz4
         XblN1yhUvz08A98jdeznuNjgmdoo8uuo71OTptYCBtLsoBmkWhUfS/8vQtN0MrvPkUGI
         oydg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=7jpu9y43I8brwrqklZhYkRoFva2SBDrErqVbdkhvVqo=;
        b=v14m1akpiV4NaK/EaHYy4eu7lpaZFw8U7kKSrcdKdI7tpBMHZ6ixg1NYjw6vU3d8uP
         9jAF5HfHq3/6eegJyFHSu0zuKfL+FWoOCz+of72oaayDJhVNsiJZTE/gmCcSdBJ7KA+n
         u3OWW/giPE2YXWicx7dAjgaQ9pa6YiW6CdSfcrVp3vPtDzqy9wE2pdt4vCvmK9W+RYme
         8Fss8V0+gDK4BfkhjUao6raG2fmQM9WLLtE9BR1w/9hcl+lplpNad/KoVQKEtZIQExZG
         hNtelE8ItNTkxaYlixtrIAUQuLS9fhWt4H2CUVga8WRp+6M0kCsLHtsn6zBW/GtOQpFq
         Zhmw==
X-Gm-Message-State: AOAM533TFFu+TBcw3oZrDAy7ZyUnN9Op3QHf+CatTcY4ZaazQ01GO73O
	DjAhR1reXQHV3ryd9ORz4aiphyATomHcYA==
X-Google-Smtp-Source: ABdhPJy95+oboinsuIDxckdoR5gGuOb07ywSBOuaSlg8BAp6kcl+5y219SKKYse9AfkCqx1lQUUs0g==
X-Received: by 2002:a1c:2bc3:0:b0:381:3dd5:5707 with SMTP id r186-20020a1c2bc3000000b003813dd55707mr17802342wmr.31.1646661870829;
        Mon, 07 Mar 2022 06:04:30 -0800 (PST)
Received: from [10.44.1.26] ([81.246.10.41])
        by smtp.gmail.com with ESMTPSA id d18-20020adff2d2000000b001f025ea3a20sm19365412wrp.0.2022.03.07.06.04.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Mar 2022 06:04:30 -0800 (PST)
Message-ID: <8365785d-2000-9d44-fe28-78bd077c3f17@tessares.net>
Date: Mon, 7 Mar 2022 15:04:29 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH mptcp-next v6 3/4] bpf: add skc_to_mptcp_sock helper
Content-Language: en-GB
To: Geliang Tang <geliang.tang@suse.com>, mptcp@lists.linux.dev
References: <cover.1646528337.git.geliang.tang@suse.com>
 <c5594343d3100143e8f24974d893e57a645942e3.1646528337.git.geliang.tang@suse.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <c5594343d3100143e8f24974d893e57a645942e3.1646528337.git.geliang.tang@suse.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Geliang,

On 06/03/2022 02:01, Geliang Tang wrote:
> This patch implemented bpf_skc_to_mptcp_sock helper. Defined a new bpf_id
> BTF_SOCK_TYPE_MPTCP, and added a new helper bpf_mptcp_sock_from_subflow()
> to get struct bpf_mptcp_sock from a given subflow socket.

Thank you for the new version. It looks more like what I had in mind
after having re-read Alexei's review!

Patches 1-3/4 looks good to me but I just have two small suggestions for
this patch 3/4. My review for patch 4/4 will follow.

Do you mind if I re-add Nicolas' SoB as a co-developer? It is fine for
me to change the commiter name because after the recent review
iterations we had recently, the code has been almost fully rewritten.
But still, I would prefer to keep him as Co-dev as a "reward" for what
he did as a student :)

So we would have:

  Co-developed-by: Nicolas Rybowski <nicolas.rybowski@tessares.net>
  Signed-off-by: Nicolas Rybowski <nicolas.rybowski@tessares.net>
  Signed-off-by: Geliang Tang <geliang.tang@suse.com>

No objection from you?

(...)

> diff --git a/net/mptcp/bpf.c b/net/mptcp/bpf.c
> new file mode 100644
> index 000000000000..d140979181f9
> --- /dev/null
> +++ b/net/mptcp/bpf.c
> @@ -0,0 +1,17 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* Multipath TCP
> + *
> + * Copyright (c) 2022, SUSE.

I understand your modification but is it OK if I re-add the previous
before the new one?

  Copyright (c) 2020, Tessares SA.

(I would prefer to keep it not to forget about very small companies
contributing to the Linux kernel and I'm not sure it can be easily
replaced :) )

I can do these modifications when applying the patches if there are no
objections.

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
