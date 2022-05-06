Received: from mail-io1-f46.google.com (mail-io1-f46.google.com [209.85.166.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D067F3D7B
	for <mptcp@lists.linux.dev>; Fri,  6 May 2022 22:24:42 +0000 (UTC)
Received: by mail-io1-f46.google.com with SMTP id r27so9557089iot.1
        for <mptcp@lists.linux.dev>; Fri, 06 May 2022 15:24:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vCER+cZdcw6N/VGxFIusbKRClQ4HAt23kfcOf1wxrBE=;
        b=KPz6NppaFeIqvV/fyw5JodOD0pAB/7SA+3vt1UjnDalEKL3MJzIXf83PCDcS6OodEh
         O6tKEjWoKDYuoqVGAgZ+/QbT8MGUeFHSLZsB0lhyMJp5oHzG95lSxnFg+03Q/J5r5K3d
         1e9VsHtroqWMuwLtN1a3d+LNX6UF+Ek+67cC92ujSYi5BXYJ7SyoPgw8XEj6/f56yYZO
         pmT46MIWEmIVyiuV5ikPh6FxNFyqrF8FgfFidhq0TW9XX3wWIlnbMIK6F0tazHe3EyWs
         jI1hRw0RVP9A5IYhZhQ4UCIannST01aeVJfUQss2rrhqHwm7YM1fCDJjJ44Qp9A8bZaw
         L6NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vCER+cZdcw6N/VGxFIusbKRClQ4HAt23kfcOf1wxrBE=;
        b=3D/ku8xdpzM+Pir0Fm2ptk4Du02VIKo5+susgKkAZCEaQVqd661bHNmRzSTVZsF/8n
         1ij8SLoSImwvGMj5JP4LjxX9et2su5BoJR/BAqjiDoITGphfOFtzZgDbuPjFqKiZgX4T
         6zswCrBI2gSnKQseBysiFAFPVJ669yIkAdsXpgjuqJYDd9Ar1UmmuWgL2NcbxoTk3iGH
         teSjxrNLdG+3vvIWd7QKAjdO6LtZV2JSMuEPxzfyFH4Yk+jz3LqJOMqQiXYaw4jky3Xe
         W8uV0295FpOwi3tNXpzqucPcx2iwwf2KGwl6K1A5VMLmhHaifhLKbcUD3uZydqmqGOeo
         oDNQ==
X-Gm-Message-State: AOAM532xMnCWRcfXKifZhbPNHmaTXdDuMbx9ZoTGbOgfiL9NkOutjNdx
	99W2XQ0laSQhh4lCsi4mM0xcwdBQ1zW7F9tcL78=
X-Google-Smtp-Source: ABdhPJyOgolGmqENHEccxh0k04YejU4QpnVg7BzBYfUKuKuGeSGqsQEalNt8THP8IsaN2697HA845IurSXeOtchUIXU=
X-Received: by 2002:a05:6638:33a1:b0:32b:8e2b:f9ba with SMTP id
 h33-20020a05663833a100b0032b8e2bf9bamr2382976jav.93.1651875881858; Fri, 06
 May 2022 15:24:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20220502211235.142250-1-mathew.j.martineau@linux.intel.com> <20220502211235.142250-5-mathew.j.martineau@linux.intel.com>
In-Reply-To: <20220502211235.142250-5-mathew.j.martineau@linux.intel.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 6 May 2022 15:24:31 -0700
Message-ID: <CAEf4BzYJ5R2Fz6hkf74c93AvNh23FQUa-_t46nBYQAeKhhtryg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 4/8] selftests: bpf: add MPTCP test base
To: Mat Martineau <mathew.j.martineau@linux.intel.com>
Cc: Networking <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>, 
	Nicolas Rybowski <nicolas.rybowski@tessares.net>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, mptcp@lists.linux.dev, 
	Matthieu Baerts <matthieu.baerts@tessares.net>, Geliang Tang <geliang.tang@suse.com>
Content-Type: text/plain; charset="UTF-8"

On Mon, May 2, 2022 at 2:12 PM Mat Martineau
<mathew.j.martineau@linux.intel.com> wrote:
>
> From: Nicolas Rybowski <nicolas.rybowski@tessares.net>
>
> This patch adds a base for MPTCP specific tests.
>
> It is currently limited to the is_mptcp field in case of plain TCP
> connection because there is no easy way to get the subflow sk from a msk
> in userspace. This implies that we cannot lookup the sk_storage attached
> to the subflow sk in the sockops program.
>
> Acked-by: Matthieu Baerts <matthieu.baerts@tessares.net>
> Co-developed-by: Geliang Tang <geliang.tang@suse.com>
> Signed-off-by: Geliang Tang <geliang.tang@suse.com>
> Signed-off-by: Nicolas Rybowski <nicolas.rybowski@tessares.net>
> Signed-off-by: Mat Martineau <mathew.j.martineau@linux.intel.com>
> ---
>  MAINTAINERS                                   |   1 +
>  tools/testing/selftests/bpf/config            |   1 +
>  tools/testing/selftests/bpf/network_helpers.c |  43 ++++--
>  tools/testing/selftests/bpf/network_helpers.h |   4 +
>  .../testing/selftests/bpf/prog_tests/mptcp.c  | 136 ++++++++++++++++++
>  .../testing/selftests/bpf/progs/mptcp_sock.c  |  50 +++++++
>  6 files changed, 227 insertions(+), 8 deletions(-)
>  create mode 100644 tools/testing/selftests/bpf/prog_tests/mptcp.c
>  create mode 100644 tools/testing/selftests/bpf/progs/mptcp_sock.c
>

[...]

>  /* ipv4 test vector */
> @@ -42,11 +43,14 @@ extern struct ipv6_packet pkt_v6;
>  int settimeo(int fd, int timeout_ms);
>  int start_server(int family, int type, const char *addr, __u16 port,
>                  int timeout_ms);
> +int start_mptcp_server(int family, const char *addr, __u16 port,
> +                      int timeout_ms);
>  int *start_reuseport_server(int family, int type, const char *addr_str,
>                             __u16 port, int timeout_ms,
>                             unsigned int nr_listens);
>  void free_fds(int *fds, unsigned int nr_close_fds);
>  int connect_to_fd(int server_fd, int timeout_ms);
> +int connect_to_mptcp_fd(int server_fd, int timeout_ms);
>  int connect_to_fd_opts(int server_fd, const struct network_helper_opts *opts);
>  int connect_fd_to_fd(int client_fd, int server_fd, int timeout_ms);
>  int fastopen_connect(int server_fd, const char *data, unsigned int data_len,
> diff --git a/tools/testing/selftests/bpf/prog_tests/mptcp.c b/tools/testing/selftests/bpf/prog_tests/mptcp.c
> new file mode 100644
> index 000000000000..cd548bb2828f
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/prog_tests/mptcp.c
> @@ -0,0 +1,136 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* Copyright (c) 2020, Tessares SA. */

2022?

> +
> +#include <test_progs.h>
> +#include "cgroup_helpers.h"
> +#include "network_helpers.h"
> +
> +struct mptcp_storage {
> +       __u32 invoked;
> +       __u32 is_mptcp;
> +};
> +
> +static int verify_sk(int map_fd, int client_fd, const char *msg, __u32 is_mptcp)
> +{
> +       int err = 0, cfd = client_fd;
> +       struct mptcp_storage val;
> +
> +       if (is_mptcp == 1)
> +               return 0;
> +
> +       if (CHECK_FAIL(bpf_map_lookup_elem(map_fd, &cfd, &val) < 0)) {

don't use CHECK and especially CHECK_FAIL, please use ASSERT_xxx()
macros instead

> +               perror("Failed to read socket storage");
> +               return -1;
> +       }
> +

[...]

> diff --git a/tools/testing/selftests/bpf/progs/mptcp_sock.c b/tools/testing/selftests/bpf/progs/mptcp_sock.c
> new file mode 100644
> index 000000000000..0d65fb889d03
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/mptcp_sock.c
> @@ -0,0 +1,50 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* Copyright (c) 2020, Tessares SA. */
> +
> +#include <linux/bpf.h>
> +#include <bpf/bpf_helpers.h>
> +
> +char _license[] SEC("license") = "GPL";
> +__u32 _version SEC("version") = 1;

version is not needed, please drop

> +
> +struct mptcp_storage {
> +       __u32 invoked;
> +       __u32 is_mptcp;
> +};

[...]
