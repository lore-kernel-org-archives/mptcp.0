Content-Type: multipart/mixed; boundary="===============0131724265415612202=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH mptcp-next v2 4/5] bpf:selftests: add MPTCP test
 base
Date: Fri, 04 Sep 2020 17:28:24 +0200
Message-ID: <e66ceee3-55d6-ed77-ddd6-5de15bb77921@tessares.net>
In-Reply-To: 20200902170443.272113-5-nicolas.rybowski@tessares.net
X-Status: 
X-Keywords:                  
X-UID: 5721

--===============0131724265415612202==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Nicolas,

On 02/09/2020 19:04, Nicolas Rybowski wrote:
> This patch adds a base for MPTCP specific tests.
> =

> It is currently limited to the is_mptcp field in case of plain TCP
> connection because there is no easy way to get the subflow sk from a msk
> in userspace. This implies that we cannot lookup the sk_storage attached
> to the subflow sk in the sockops program.
> =

> Acked-by: Matthieu Baerts <matthieu.baerts(a)tessares.net>
> Signed-off-by: Nicolas Rybowski <nicolas.rybowski(a)tessares.net>

(...)

> diff --git a/tools/testing/selftests/bpf/network_helpers.c b/tools/testin=
g/selftests/bpf/network_helpers.c
> index 12ee40284da0..9295a5d8e001 100644
> --- a/tools/testing/selftests/bpf/network_helpers.c
> +++ b/tools/testing/selftests/bpf/network_helpers.c

(...)

> @@ -66,8 +70,8 @@ static int settimeo(int fd, int timeout_ms)
>   =

>   #define save_errno_close(fd) ({ int __save =3D errno; close(fd); errno =
=3D __save; })
>   =

> -int start_server(int family, int type, const char *addr_str, __u16 port,
> -		 int timeout_ms)
> +static int start_server_proto(int family, int type, int protocol,
> +			       const char *addr_str, __u16 port, int timeout_ms)

Here I add to remove an extra space (before const) to satisfy checkpatch.pl.

(...)

> diff --git a/tools/testing/selftests/bpf/progs/mptcp.c b/tools/testing/se=
lftests/bpf/progs/mptcp.c
> new file mode 100644
> index 000000000000..936edc8517df
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/mptcp.c
> @@ -0,0 +1,48 @@
> +// SPDX-License-Identifier: GPL-2.0
> +#include <linux/bpf.h>
> +#include <bpf/bpf_helpers.h>
> +
> +char _license[] SEC("license") =3D "GPL";
> +__u32 _version SEC("version") =3D 1;
> +
> +struct mptcp_storage {
> +	__u32 invoked;
> +	__u32 is_mptcp;
> +};
> +
> +struct {
> +	__uint(type, BPF_MAP_TYPE_SK_STORAGE);
> +	__uint(map_flags, BPF_F_NO_PREALLOC);
> +	__type(key, int);
> +	__type(value, struct mptcp_storage);
> +} socket_storage_map SEC(".maps");
> +
> +SEC("sockops")
> +int _sockops(struct bpf_sock_ops *ctx)
> +{
> +	struct mptcp_storage *storage;
> +	struct bpf_tcp_sock *tcp_sk;
> +	int op =3D (int) ctx->op;

Here I had to remove the space between (int) and ctx.

Cheers,
Matt
-- =

Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
--===============0131724265415612202==--
