Content-Type: multipart/mixed; boundary="===============3326415455915630928=="
MIME-Version: 1.0
From: Peter Krystad <peter.krystad at linux.intel.com>
To: mptcp at lists.01.org
Subject: Re: [MPTCP] [RFC PATCH] mptcp: new sysctl to control the activation
 per NS
Date: Tue, 16 Jul 2019 16:12:53 -0700
Message-ID: <370dae104e2525514986afdcf599ace90d8ff624.camel@linux.intel.com>
In-Reply-To: 20190711190007.20106-1-matthieu.baerts@tessares.net
X-Status: 
X-Keywords:                  
X-UID: 1501

--===============3326415455915630928==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable


Thanks for this patch Matthieu, I have a few tardy comments.

As a general comment another approach would be to use this enabled flag to
control whether MP_CAPABLE options are sent when establishing/accepting an
MPTCP connection. You can see my "/* @@ if MTPCP enabled */" comments where
subflow->request_mptcp is being set in protocol.c. This would be the simili=
ar
behaviour to the mptcp.org version, you just get a (inefficient) TCP socket
when requesting MPTCP. You get the benefit of not surprising applications
coded to use MPTCP at the drawback of some security exposure, as the new MP=
TCP
fallback layer would still be used. But this is a pretty thin layer.

See my comments to this specific patch below.

On Thu, 2019-07-11 at 21:00 +0200, Matthieu Baerts wrote:
> New MPTCP sockets will return -ENOPROTOOPT if MPTCP support is disabled
> for the current net namespace.
> =

> For security reasons, it is interesting to have a global switch for
> MPTCP. To start, MPTCP will be disabled by default and only privileged
> users will be able to modify this. The reason is that because MPTCP is
> new, it will not be tested and reviewed by many and security issues can
> then take time to be discovered and fixed.
> =

> The value of this new sysctl can be different per namespace. We can then
> restrict the usage of MPTCP to the selected NS. In case of serious
> issues with MPTCP, administrators can now easily turn MPTCP off.
> =

> MPTCP' kselftest has been modified to validate that the correct error is
> reported when creating a socket while MPTCP support is disabled.
> =

> Signed-off-by: Matthieu Baerts <matthieu.baerts(a)tessares.net>
> ---
> =

> Notes:
>     As just discussed at the meeting we just had, here is a RFC patch to
>     add a new sysctl for MPTCP.
>     =

>     Because it is not linked to the protocol itself, I simply created a n=
ew
>     file, ctrl.c like in mptcp.org.
>     =

>     A few questions:
>     - Is it OK to reserve space per ns via the "pernet_operations"
>       structure? Because MPTCP would not be compiled as a module, we could
>       directly store stuff in the net structure as other parts of the code
>       do but maybe better to keep MPTCP code on the side as done here.
>     - In mptcp.org, all sysctls are prepended with 'mptcp_', e.g.
>       'net.mptcp.mptcp_enabled'. Do we need this? Is it better to keep the
>       same names if possible or better to differentiate? In this version,
>       'mptcp_' is not prepended.

Differentiate, as you have done.

>     - This sysctl will only block new sockets to be created. Is it enough?
>     - ENOPROTOOPT is returned, maybe something else to return? EPERM is
>       maybe too generic? ENOTSUPP is not translated by perror().
>     - Should we start the documentation now for the sysctl?
>     - A simple test has been added, because it is not linked to the rest,=
 I
>       put separeted as first test.
>     - Of course do not hesitate to comment. Even on the idea of having a
>       sysctl for this purpose.
> =

>  net/mptcp/Makefile                            |   2 +-
>  net/mptcp/ctrl.c                              | 109 ++++++++++++++++++
>  net/mptcp/protocol.c                          |  12 +-
>  net/mptcp/protocol.h                          |   4 +
>  .../selftests/net/mptcp/mptcp_connect.sh      |  24 ++++
>  5 files changed, 148 insertions(+), 3 deletions(-)
>  create mode 100644 net/mptcp/ctrl.c
> =

> diff --git a/net/mptcp/Makefile b/net/mptcp/Makefile
> index 7fe7aa64eda0..289fdf4339c1 100644
> --- a/net/mptcp/Makefile
> +++ b/net/mptcp/Makefile
> @@ -1,4 +1,4 @@
>  # SPDX-License-Identifier: GPL-2.0
>  obj-$(CONFIG_MPTCP) +=3D mptcp.o
>  =

> -mptcp-y :=3D protocol.o subflow.o options.o token.o crypto.o pm.o
> +mptcp-y :=3D protocol.o subflow.o options.o token.o crypto.o pm.o ctrl.o
> diff --git a/net/mptcp/ctrl.c b/net/mptcp/ctrl.c

The prefix 'ctl' is used in this file a bunch, so maybe ctl.c is a better
name, or even 'sysctl.c'. That it is named this is mptcp.org version isn't
much of a reason IMHO. :)

> new file mode 100644
> index 000000000000..4c9a6a2cfeb3
> --- /dev/null
> +++ b/net/mptcp/ctrl.c
> @@ -0,0 +1,109 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* Multipath TCP
> + *
> + * Copyright (c) 2019, Tessares SA.
> + */
> +
> +#include <linux/sysctl.h>
> +
> +#include <net/net_namespace.h>
> +#include <net/netns/generic.h>
> +
> +#include "protocol.h"
> +
> +#define MPTCP_SYSCTL_PATH "net/mptcp"
> +
> +static int mptcp_pernet_id;
> +struct mptcp_pernet {
> +	struct ctl_table_header *ctl_table_hdr;
> +
> +	int mptcp_enabled;
> +};
> +
> +static struct mptcp_pernet *mptcp_get_pernet(struct net *net)
> +{
> +	return net_generic(net, mptcp_pernet_id);
> +}
> +
> +int mptcp_is_enabled(struct net *net)
> +{
> +	return mptcp_get_pernet(net)->mptcp_enabled;
> +}
> +
> +static struct ctl_table mptcp_sysctl_table[] =3D {
> +	{
> +		.procname =3D "enabled",
> +		.maxlen =3D sizeof(int),
> +		.mode =3D 0644,
> +		.proc_handler =3D proc_dointvec,
> +	},
> +	{}
> +};
> +
> +static int mptcp_pernet_new_table(struct net *net, struct mptcp_pernet *=
pernet)
> +{
> +	struct ctl_table_header *hdr;
> +	struct ctl_table *table;
> +
> +	table =3D mptcp_sysctl_table;
> +	if (!net_eq(net, &init_net)) {
> +		table =3D kmemdup(table, sizeof(mptcp_sysctl_table), GFP_KERNEL);
> +		if (!table)
> +			goto err_alloc;
> +	}
> +
> +	table[0].data =3D &pernet->mptcp_enabled;
> +
> +	hdr =3D register_net_sysctl(net, MPTCP_SYSCTL_PATH, table);
> +	if (!hdr)
> +		goto err_reg;
> +
> +	pernet->ctl_table_hdr =3D hdr;
> +
> +	return 0;
> +
> +err_reg:
> +	if (!net_eq(net, &init_net))
> +		kfree(table);
> +err_alloc:
> +	return -ENOMEM;
> +}
> +
> +static void mptcp_pernet_del_table(struct mptcp_pernet *pernet)
> +{
> +	struct ctl_table *table =3D pernet->ctl_table_hdr->ctl_table_arg;
> +
> +	unregister_net_sysctl_table(pernet->ctl_table_hdr);
> +
> +	kfree(table);
> +}
> +
> +static int __net_init mptcp_net_init(struct net *net)
> +{
> +	struct mptcp_pernet *pernet =3D mptcp_get_pernet(net);
> +
> +	return mptcp_pernet_new_table(net, pernet);
> +}
> +
> +/* Note: the callback will only be called per extra netns */
> +static void __net_exit mptcp_net_exit(struct net *net)
> +{
> +	struct mptcp_pernet *pernet =3D mptcp_get_pernet(net);
> +
> +	mptcp_pernet_del_table(pernet);
> +}
> +
> +static struct pernet_operations mptcp_pernet_ops =3D {
> +	.init =3D mptcp_net_init,
> +	.exit =3D mptcp_net_exit,
> +	.id =3D &mptcp_pernet_id,
> +	.size =3D sizeof(struct mptcp_pernet),
> +};
> +
> +void __init mptcp_init(void)

I would prefer that the mptcp_init() in protocol.c remain the top-level init
routine and that it call a sub-level routine in this file the same as other
files in "module". When TCP is calling mptcp_init() it is registering
protocols, so the protocol routine should be at the top I think.

> +{
> +	mptcp_proto_init();
> +
> +	if (register_pernet_subsys(&mptcp_pernet_ops) < 0)
> +		panic("Failed to register MPTCP pernet subsystem.\n");
> +}
> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index 774ed25d3b6d..18399cb63f35 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -559,6 +559,14 @@ static int mptcp_init_sock(struct sock *sk)
>  	return 0;
>  }
>  =

> +static int mptcp_init_sock_cb(struct sock *sk)
> +{
> +	if (!mptcp_is_enabled(sock_net(sk)))
> +		return -ENOPROTOOPT;

Can we just add this check to mptcp_init_sock() and not add the extra routi=
ne?

Peter.

> +
> +	return mptcp_init_sock(sk);
> +}
> +
>  static void mptcp_close(struct sock *sk, long timeout)
>  {
>  	struct mptcp_sock *msk =3D mptcp_sk(sk);
> @@ -801,7 +809,7 @@ bool mptcp_sk_is_subflow(const struct sock *sk)
>  static struct proto mptcp_prot =3D {
>  	.name		=3D "MPTCP",
>  	.owner		=3D THIS_MODULE,
> -	.init		=3D mptcp_init_sock,
> +	.init		=3D mptcp_init_sock_cb,
>  	.close		=3D mptcp_close,
>  	.accept		=3D mptcp_accept,
>  	.setsockopt	=3D mptcp_setsockopt,
> @@ -993,7 +1001,7 @@ static struct inet_protosw mptcp_protosw =3D {
>  	.flags		=3D INET_PROTOSW_ICSK,
>  };
>  =

> -void __init mptcp_init(void)
> +void mptcp_proto_init(void)
>  {
>  	mptcp_prot.h.hashinfo =3D tcp_prot.h.hashinfo;
>  	mptcp_stream_ops =3D inet_stream_ops;
> diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
> index 7f15f6aab93d..715ce80d0ae1 100644
> --- a/net/mptcp/protocol.h
> +++ b/net/mptcp/protocol.h
> @@ -183,11 +183,15 @@ mptcp_subflow_tcp_socket(const struct subflow_conte=
xt *subflow)
>  	return subflow->tcp_sock;
>  }
>  =

> +int mptcp_is_enabled(struct net *net);
> +
>  void subflow_init(void);
>  int subflow_create_socket(struct sock *sk, struct socket **new_sock);
>  =

>  extern const struct inet_connection_sock_af_ops ipv4_specific;
>  =

> +void mptcp_proto_init(void);
> +
>  void mptcp_get_options(const struct sk_buff *skb,
>  		       struct tcp_options_received *opt_rx);
>  =

> diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect.sh b/tools/t=
esting/selftests/net/mptcp/mptcp_connect.sh
> index 4418163af001..d029bdc5946d 100755
> --- a/tools/testing/selftests/net/mptcp/mptcp_connect.sh
> +++ b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
> @@ -45,6 +45,7 @@ trap cleanup EXIT
>  for i in 1 2 3 4;do
>  	ip netns add ns$i || exit $ksft_skip
>  	ip -net ns$i link set lo up
> +	ip netns exec ns$i sysctl -q net.mptcp.enabled=3D1
>  done
>  =

>  #  ns1              ns2                    ns3                     ns4
> @@ -106,6 +107,27 @@ check_transfer()
>  	return 0
>  }
>  =

> +check_mptcp_disabled()
> +{
> +	disabled_ns=3D"ns_disabled"
> +	ip netns add ${disabled_ns} || exit $ksft_skip
> +	# by default: sysctl net.mptcp.enabled=3D0
> +
> +	local err=3D0
> +	LANG=3DC ip netns exec ${disabled_ns} ./mptcp_connect -t $timeout -p 10=
000 -s MPTCP 127.0.0.1 < "$cin" 2>&1 | \
> +		grep -q "^socket: Protocol not available$" && err=3D1
> +	ip netns delete ${disabled_ns}
> +
> +	if [ ${err} -eq 0 ]; then
> +		echo -e "MPTCP is not disabled by default as expected\t[ FAIL ]"
> +		ret=3D1
> +		return 1
> +	fi
> +
> +	echo -e "MPTCP is disabled by default as expected\t[ OK ]"
> +	return 0
> +}
> +
>  do_ping()
>  {
>  	listener_ns=3D"$1"
> @@ -241,6 +263,8 @@ run_tests()
>  make_file "$cin" "client"
>  make_file "$sin" "server"
>  =

> +check_mptcp_disabled
> +
>  for sender in 1 2 3 4;do
>  	do_ping ns1 ns$sender 10.0.1.1
>  =



--===============3326415455915630928==--
