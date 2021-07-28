Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E023D3481
	for <mptcp@lists.linux.dev>; Wed, 28 Jul 2021 08:09:33 +0000 (UTC)
Received: by mail-ej1-f54.google.com with SMTP id go31so3171397ejc.6
        for <mptcp@lists.linux.dev>; Wed, 28 Jul 2021 01:09:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20150623.gappssmtp.com; s=20150623;
        h=to:cc:references:from:subject:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=zK7hY6/jxRZs9+Tau5Gpn9UEYGCD5J+o35B+wVIaTIo=;
        b=l8Z1QhBsfDASHgms/T3scifo4rJLncih4lBFdoU1/h16y7927/BQqlDgqjbTMXahOb
         onJcjaMu4xwQ6Jt+NMjXsmKGD1Am1DmUy7jibKysMM0PbQbR9LjzqxDehhz3X2BrhOvQ
         yTYq0gIIpWIvFjtH/YCRkOglUIxRArgZdO2eGapgf3RL4NrH50WwHJeG87pG1c1HS8RF
         n+xuZ/J4c7WzI0PYAjcI3eDMulWPZUbMENY5rUR5C1681w+XQxHLq2Sly9Xa3M4LXRJ4
         +x7iX9FyKY7jSVQYyeAdmT4Zn4xBUGP+4hF7SerH23g0ixzaWsn1n5KTM9+JPKsYvt74
         wFDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:references:from:subject:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=zK7hY6/jxRZs9+Tau5Gpn9UEYGCD5J+o35B+wVIaTIo=;
        b=qyKu7D+/K7U9yiBQeM+qqW+6pAQ3MGD+zyfRdzNWKOZZt0VR/e6dmPzmp50BcWHQXe
         lD/MKvUIvW9IkReD3sXsgngNULy0dWGhdTpDHCXIPFOwJyPGlfULgen9OQlGv68oiXKY
         ts1HdMUfvh7gRi1QyWoPxo4J44eeHqe7QLGi1V+ocW9L/I/yoVKBMkG9a0ZW+Lu62jcx
         1naQkA+9MCE+57z32QhZvluCtOAohKYkjjro8bD24QAHZlsa7JPyPCslpg/2IEEuo9IA
         5JoC1d8NB4AxokdbgvbgoDJleBU77pAB8vzFFJFOXJyp1YDuT8bLFDqGh+CcrcoBsPK3
         ZElA==
X-Gm-Message-State: AOAM533zySOV3O595RFxAOF7wB+53DjOzl8EAYYeT6oMrk/aRYlb7USI
	WxDyiN4zHO0yCe0TfwPJdUw6QA==
X-Google-Smtp-Source: ABdhPJzJgEVW3/NPO12u2vHNEbev4fkExfHr+f8QYlT2jPHTUJ/SGGhs0SlsveSJvs9lux3lQvt4Dw==
X-Received: by 2002:a17:906:95cf:: with SMTP id n15mr25870354ejy.531.1627459771988;
        Wed, 28 Jul 2021 01:09:31 -0700 (PDT)
Received: from tsr-lap-08.nix.tessares.net ([2a02:578:85b0:e00:c852:afa0:c279:c071])
        by smtp.gmail.com with ESMTPSA id r27sm2229152edb.66.2021.07.28.01.09.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Jul 2021 01:09:31 -0700 (PDT)
To: Paolo Abeni <pabeni@redhat.com>, mptcp@lists.linux.dev
Cc: Geliang Tang <geliangtang@gmail.com>
References: <cover.1627296764.git.pabeni@redhat.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
Subject: Re: [PATCH v3 mptcp-next 0/3] mptcp: minor out optimization
Message-ID: <aca30f71-bc68-7e33-65c5-c5bcb79fd043@tessares.net>
Date: Wed, 28 Jul 2021 10:09:31 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <cover.1627296764.git.pabeni@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 8bit

Hi Paolo, Geliang, Mat,

On 26/07/2021 12:55, Paolo Abeni wrote:
> This series implements a few ideas discussed in the past mtg,
> specifcally:
> 
> https://github.com/multipath-tcp/mptcp_net-next/issues/15
> https://github.com/multipath-tcp/mptcp_net-next/issues/42

Should we close any of them? e.g. the issue #15?

> The final goal is shrink the mptcp_out_options struct, which is
> always zeroed by the plain TCP protocol in the output path.

Thank you for looking at that!

> This iteration covers the feedback provided by Geliang (many thanks!)
> on v1:
>  - some code moved to new squash-to patch 1/3
>  - some cleanup in 2/3

And thanks Geliang for the notes about the conflicts!

> please see the individual patch changelog for the details
> 
> Paolo Abeni (3):
>   Squash-to: "mptcp: move drop_other_suboptions check under pm lock"
>   mptcp: optimize out option generation
>   mptcp: shrink mptcp_out_options struct

Thank you for the patches, reviews and tests!

I split the series in two: the squash-to patch first and then the two
new patches.

Part 1: squash-to + update commit msg:

- 9030cfa001f6: "squashed" (with conflicts) in "mptcp: move
drop_other_suboptions check under pm lock"
- fb6c1d39264e: "Signed-off-by" + "Co-developed-by"
- b6a51f709e5b: tg: update msg after having applied 1 squash-to patch
- a4f59d64a674: conflict in
t/mptcp-remove-MPTCP_ADD_ADDR_IPV6-and-MPTCP_ADD_ADDR_PORT
- Results: 49320b30c955..14a78d3af24a

Builds and tests are now in progress:



https://cirrus-ci.com/github/multipath-tcp/mptcp_net-next/export/20210728T074049

https://github.com/multipath-tcp/mptcp_net-next/actions/workflows/build-validation.yml?query=branch:export/20210728T074049


Part 2: new patches with Mat's RvB tag and a few checkpatch fixes:

- ef6b13c8bbad: mptcp: optimize out option generation
- 7547285ef776: mptcp: shrink mptcp_out_options struct
- Results: 14a78d3af24a..4c599993729d

Builds and tests are now in progress:



https://cirrus-ci.com/github/multipath-tcp/mptcp_net-next/export/20210728T080904

https://github.com/multipath-tcp/mptcp_net-next/actions/workflows/build-validation.yml?query=branch:export/20210728T080904

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
