Received: from mail-io1-f47.google.com (mail-io1-f47.google.com [209.85.166.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26BFF3D7B
	for <mptcp@lists.linux.dev>; Fri,  6 May 2022 22:27:11 +0000 (UTC)
Received: by mail-io1-f47.google.com with SMTP id m6so9553976iob.4
        for <mptcp@lists.linux.dev>; Fri, 06 May 2022 15:27:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YJWiJkdYGbBSzS+2Wxslwj9TmG4q/ytv0/hJtkg8UQg=;
        b=ktcUjwf3H30s1wm61j3zKM6tKWY1rfKoW8d54w9wNM6bfoYJPvn8uNDW0i/BTaf7Ih
         n/crwQWaJXGVKgNJPeLFb1LPGVQnxKJcQGwslGxFyuQ64tA9T5Gxx0KDEba39g3Eqx/L
         CcSNL4FFmBIu61JFHYxatFI2rVA6jgHGp1iajc0v6KLmlG120keCx5CLXP0Za1vCSb5F
         eauf5mBaXWoFmb00tr80prjDvzS7u57HQFxDYmFgpS9+8Yuj9zjpgn1Bfw/V8pDZt0Ko
         YXrWgr+s2mxgI/WkTz7mQbZZ3TSSvp6A8PTkBzl6N8f3avwzRokMhOmIOpsO3zJd+JdQ
         rsWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YJWiJkdYGbBSzS+2Wxslwj9TmG4q/ytv0/hJtkg8UQg=;
        b=vXAUDus8f6Fwhbj46Bf6D3aT4n3BeGCfPAhFsqRxALHdrNv1HxXC32Ti29yUFFqW8X
         yfkogVZbPI7GHxhuvbD4aiGDNjuA/oaxKT3pF9mksLp1d5llmaG0D7sDqGu0iA4NEi0b
         kjQ5rQ9/kNhz+Fpya4KXxYyCZm0hGHKrxuiWJ80PjWUoYd4nsu+ecr5M5VE53l4fMH3Y
         00F3leAqNklh5PmH2YRr+DePexOrS+oAdBXjOwVXI8BQdxP0flbuH2uc7MXj7ZalwuAG
         tcgVH5CjrwF/ux8FJ2NBV2O/kCG3DkKaRaefGyi7WxdRnZfsciRcobmkM0JxmFkEojIW
         oRYw==
X-Gm-Message-State: AOAM5312Z50C+0/RfeLjk7VjtinqyJK50yl4WZDMS9IGzx+WNQfvDDU6
	pirSe91oSw6VLzFoQEwqzkpnKNHdfGH0QU1+pnA=
X-Google-Smtp-Source: ABdhPJzaj0DIFHrLtlkn84RWVvdJ/q3hiqsgHOI7ZpI37NHJVB/7z/MEMSqjQnZqZbefbKdJKKLOhOjszH4B5vTnS1k=
X-Received: by 2002:a05:6638:33a1:b0:32b:8e2b:f9ba with SMTP id
 h33-20020a05663833a100b0032b8e2bf9bamr2386086jav.93.1651876030268; Fri, 06
 May 2022 15:27:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20220502211235.142250-1-mathew.j.martineau@linux.intel.com> <20220502211235.142250-6-mathew.j.martineau@linux.intel.com>
In-Reply-To: <20220502211235.142250-6-mathew.j.martineau@linux.intel.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 6 May 2022 15:26:59 -0700
Message-ID: <CAEf4BzY-t=ZtmU+6yeSo5DD6+C==NUN=twAKq=OQyVb2rS2ENw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 5/8] selftests: bpf: test bpf_skc_to_mptcp_sock
To: Mat Martineau <mathew.j.martineau@linux.intel.com>
Cc: Networking <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>, 
	Geliang Tang <geliang.tang@suse.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, mptcp@lists.linux.dev, 
	Matthieu Baerts <matthieu.baerts@tessares.net>
Content-Type: text/plain; charset="UTF-8"

On Mon, May 2, 2022 at 2:12 PM Mat Martineau
<mathew.j.martineau@linux.intel.com> wrote:
>
> From: Geliang Tang <geliang.tang@suse.com>
>
> This patch extends the MPTCP test base, to test the new helper
> bpf_skc_to_mptcp_sock().
>
> Define struct mptcp_sock in bpf_tcp_helpers.h, use bpf_skc_to_mptcp_sock
> to get the msk socket in progs/mptcp_sock.c and store the infos in
> socket_storage_map.
>
> Get the infos from socket_storage_map in prog_tests/mptcp.c. Add a new
> function verify_msk() to verify the infos of MPTCP socket, and rename
> verify_sk() to verify_tsk() to verify TCP socket only.
>
> v2: Add CONFIG_MPTCP check for clearer error messages
>
> Acked-by: Matthieu Baerts <matthieu.baerts@tessares.net>
> Signed-off-by: Geliang Tang <geliang.tang@suse.com>
> Signed-off-by: Mat Martineau <mathew.j.martineau@linux.intel.com>
> ---
>  MAINTAINERS                                   |  1 +
>  .../testing/selftests/bpf/bpf_mptcp_helpers.h | 14 ++++++++
>  .../testing/selftests/bpf/prog_tests/mptcp.c  | 36 +++++++++++++++----
>  .../testing/selftests/bpf/progs/mptcp_sock.c  | 24 ++++++++++---
>  4 files changed, 65 insertions(+), 10 deletions(-)
>  create mode 100644 tools/testing/selftests/bpf/bpf_mptcp_helpers.h
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 359afc617b92..d48d3cb6abbc 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -13780,6 +13780,7 @@ F:      include/net/mptcp.h
>  F:     include/trace/events/mptcp.h
>  F:     include/uapi/linux/mptcp.h
>  F:     net/mptcp/
> +F:     tools/testing/selftests/bpf/bpf_mptcp_helpers.h
>  F:     tools/testing/selftests/bpf/*/*mptcp*.c
>  F:     tools/testing/selftests/net/mptcp/
>
> diff --git a/tools/testing/selftests/bpf/bpf_mptcp_helpers.h b/tools/testing/selftests/bpf/bpf_mptcp_helpers.h
> new file mode 100644
> index 000000000000..18da4cc65e89
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/bpf_mptcp_helpers.h
> @@ -0,0 +1,14 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/* Copyright (c) 2022, SUSE. */
> +
> +#ifndef __BPF_MPTCP_HELPERS_H
> +#define __BPF_MPTCP_HELPERS_H
> +
> +#include "bpf_tcp_helpers.h"
> +
> +struct mptcp_sock {
> +       struct inet_connection_sock     sk;
> +
> +} __attribute__((preserve_access_index));

why can't all this live in bpf_tcp_helpers.h? why do we need extra header?

> +
> +#endif
> diff --git a/tools/testing/selftests/bpf/prog_tests/mptcp.c b/tools/testing/selftests/bpf/prog_tests/mptcp.c
> index cd548bb2828f..4b40bbdaf91f 100644
> --- a/tools/testing/selftests/bpf/prog_tests/mptcp.c
> +++ b/tools/testing/selftests/bpf/prog_tests/mptcp.c
> @@ -10,14 +10,12 @@ struct mptcp_storage {
>         __u32 is_mptcp;
>  };
>

[...]
