Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D29F11D0E0
	for <mptcp@lists.linux.dev>; Wed, 12 Jul 2023 16:45:07 +0000 (UTC)
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-4fb960b7c9dso11708244e87.0
        for <mptcp@lists.linux.dev>; Wed, 12 Jul 2023 09:45:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1689180305; x=1691772305;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bmlHqANXBYLyUv0ihWW5EwWZrQNehOwI6bFOWjXAYmU=;
        b=7Eux7SKH8d4DZW4TysyDYJWcposH/VJG8B0wN8OFBGPYoOaao7BrHSzz+D4vbbPm4y
         nIqVq8o7LcpS1kyvutgQ21XaCRKBg0fKqK+KNYGJHhFNNEJ6ngXoyI+MrJyqZ5GRbbw5
         bX4Eyb+iI/dbx0ts1JU7bFfq+NgAQuDAFMYjFyFQraqOgv6WKOBEVGW7+c+eDzJtou+m
         2tlJEdqxpBgs/5PeSMruFQio2/DWUvwfi3MTOZQDJ0Cz2eLVWl3GjJ97WqUKEOZXuSik
         YSYFcfckN8cIZhbw6dU3V7johZR4+aomv9M3cGP9i3r7u/LXKQngU6XHr/BUCl6T00l7
         vhXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689180305; x=1691772305;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bmlHqANXBYLyUv0ihWW5EwWZrQNehOwI6bFOWjXAYmU=;
        b=dc9qTVsvvK+l4QBGSg3y2x5odKfpmU+1SPAqsmazx8fLuu4MEiBQRpw+lm/m774P4V
         +AKNfxKAsbvQYlLVElh2HhGWcIwV1daBAMsycUJeHv9CIrWPz8uoTIllJpwZimM7ukgs
         ayffsPhRw2/ak3ZQ2POwSoAO+FHxilRufqTv4ig1JmtCgXjk1Dz8epqiaPc9OP/fX0N3
         /KMSWpeUFDwB6+u5bHMwDohQu1cxDZwXuoTNIk3eWdSswi/gI+tomwehmC62diMcbM6P
         GK/86TsL+yqwPueYI+486SbAVSk9HA4dEcikcBsFcDJGvuDXWLW5tgcNy4P60ah80Pyo
         NIvg==
X-Gm-Message-State: ABy/qLYjH0yMi25HBJy472TqyXwASde2zmOzCLbJmAbmTzqxHqpY9e5G
	jgi1d4uC5IJb3s+hy6FQ7P9tR8UN0LKQHjgOHB2e/C2z
X-Google-Smtp-Source: APBJJlEWaP3e7scxkbqNsMBA45rlH9eNvyNkwV3/b9cfi7Ee/G2JQCN5iBhFFX8I+738reBaNorBfw==
X-Received: by 2002:a05:6512:29b:b0:4fb:89b3:3374 with SMTP id j27-20020a056512029b00b004fb89b33374mr13830189lfp.54.1689180305596;
        Wed, 12 Jul 2023 09:45:05 -0700 (PDT)
Received: from ?IPV6:2a02:578:8593:1200:ef4b:f9b8:e94a:ea27? ([2a02:578:8593:1200:ef4b:f9b8:e94a:ea27])
        by smtp.gmail.com with ESMTPSA id c21-20020aa7c995000000b0051d9de03516sm2971168edt.52.2023.07.12.09.45.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Jul 2023 09:45:05 -0700 (PDT)
Message-ID: <58ce9745-91c3-4421-a171-c47020efb313@tessares.net>
Date: Wed, 12 Jul 2023 18:45:04 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH mptcp-next 00/10] BPF packet scheduler updates part 2
Content-Language: en-GB
To: Geliang Tang <geliang.tang@suse.com>, mptcp@lists.linux.dev
References: <cover.1687829823.git.geliang.tang@suse.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <cover.1687829823.git.geliang.tang@suse.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Geliang, Mat,

On 27/06/2023 03:39, Geliang Tang wrote:
> - Add time metrics for sched tests.
> - Add bpf_stale and bpf_burst schedulers.
> 
> Geliang Tang (10):
>   Squash to "selftests/bpf: Add bpf_first test"
>   selftests/bpf: Add bpf_first test
>   Squash to "selftests/bpf: Add bpf_bkup test"
>   Squash to "selftests/bpf: Add bpf_rr test"
>   Squash to "selftests/bpf: Add bpf_red test"

Thank you for the patches and the reviews!

I just applied these 5 first patches in our tree (feat. for other trees)
with Mat's RvB tag. Please check if the result is the expected one.

I squashed the first patch with the previous version of "selftests/bpf:
Add bpf_first test" and inserted it just before "selftests/bpf: Add
bpf_first scheduler".

New patches for t/upstream:
- 623a40f22358: selftests/bpf: Add bpf scheduler test
- 0624ffbc4277: conflict in t/selftests-bpf-add-bpf_first-test
- 875e9054d305: conflict in t/selftests-bpf-Add-bpf_bkup-test
- Results: 71a6b14c30ab..ad99473d0690 (export)

- 117ad55b0a69: "squashed" (with conflicts) patch 2/10 in
"selftests/bpf: Add bpf_first test"
- 5f014cabbfbc: conflict in t/selftests-bpf-Add-bpf_bkup-test
- Results: ad99473d0690..835132fc94ee (export)

- b6f5458c8236: tg:msg: apply new commit message from Geliang
- Results: 23ee68c3fa88..c8f03d57ef57 (export)

- d5beca01e1bc: "squashed" patch 3/10 in "selftests/bpf: Add bpf_bkup test"
- e3221affcf4d: "squashed" patch 4/10 in "selftests/bpf: Add bpf_rr test"
- 8216c7624546: "squashed" patch 5/10 in "selftests/bpf: Add bpf_red test"
- Results: 835132fc94ee..23ee68c3fa88 (export)

Tests are now in progress:

https://cirrus-ci.com/github/multipath-tcp/mptcp_net-next/export/20230712T164345

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
