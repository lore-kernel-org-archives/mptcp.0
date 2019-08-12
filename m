Content-Type: multipart/mixed; boundary="===============7389276900313920958=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: Re: [MPTCP] [PATCH] mptcp: new sysctl to control the activation per NS
Date: Mon, 12 Aug 2019 17:28:48 +0200
Message-ID: <644d5ed8-05d5-1563-ca5c-3bd23e91aae0@tessares.net>
In-Reply-To: 20190808165303.7516-1-matthieu.baerts@tessares.net
X-Status: 
X-Keywords:                  
X-UID: 1614

--===============7389276900313920958==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Peter,

On 08/08/2019 18:53, Matthieu Baerts wrote:
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

Thank you for the previous review. I just added this patch at the end of
the series.

https://github.com/multipath-tcp/mptcp_net-next/commits/export

Tests are still OK.

Cheers,
Matt

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
>     - This sysctl will only block new sockets to be created. Is it enough?
>     - ENOPROTOOPT is returned, maybe something else to return? EPERM is
>       maybe too generic? ENOTSUPP is not translated by perror().
>     - Should we start the documentation now for the sysctl?
>     - A simple test has been added, because it is not linked to the rest,=
 I
>       put separeted as first test.
>     - Of course do not hesitate to comment. Even on the idea of having a
>       sysctl for this purpose.
>     =

>     RFC -> v1:
>      - mptcp_init_sock_cb() -> mptcp_init_sock() (Peter)
>      - add comments about who can change the sysctl (Ossama)
> =

>  net/mptcp/Makefile                            |   2 +-
>  net/mptcp/ctrl.c                              | 112 ++++++++++++++++++
>  net/mptcp/protocol.c                          |  14 ++-
>  net/mptcp/protocol.h                          |   4 +
>  .../selftests/net/mptcp/mptcp_connect.sh      |  24 ++++
>  5 files changed, 152 insertions(+), 4 deletions(-)
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
> new file mode 100644
> index 000000000000..8d9f15f02369
> --- /dev/null
> +++ b/net/mptcp/ctrl.c
> @@ -0,0 +1,112 @@
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
> +		/* users with CAP_NET_ADMIN or root (not and) can change thi
> +		 * value, same as other sysctl or the 'net' tree.
> +		 */
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
> +{
> +	mptcp_proto_init();
> +
> +	if (register_pernet_subsys(&mptcp_pernet_ops) < 0)
> +		panic("Failed to register MPTCP pernet subsystem.\n");
> +}
> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index 4d2844bff36f..6a4337c631f7 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -579,7 +579,7 @@ static int mptcp_recvmsg(struct sock *sk, struct msgh=
dr *msg, size_t len,
>  	return copied;
>  }
>  =

> -static int mptcp_init_sock(struct sock *sk)
> +static int __mptcp_init_sock(struct sock *sk)
>  {
>  	struct mptcp_sock *msk =3D mptcp_sk(sk);
>  =

> @@ -590,6 +590,14 @@ static int mptcp_init_sock(struct sock *sk)
>  	return 0;
>  }
>  =

> +static int mptcp_init_sock(struct sock *sk)
> +{
> +	if (!mptcp_is_enabled(sock_net(sk)))
> +		return -ENOPROTOOPT;
> +
> +	return __mptcp_init_sock(sk);
> +}
> +
>  static void mptcp_close(struct sock *sk, long timeout)
>  {
>  	struct mptcp_sock *msk =3D mptcp_sk(sk);
> @@ -654,7 +662,7 @@ static struct sock *mptcp_accept(struct sock *sk, int=
 flags, int *err,
>  			return NULL;
>  		}
>  =

> -		mptcp_init_sock(new_mptcp_sock);
> +		__mptcp_init_sock(new_mptcp_sock);
>  =

>  		msk =3D mptcp_sk(new_mptcp_sock);
>  		msk->remote_key =3D subflow->remote_key;
> @@ -1076,7 +1084,7 @@ static struct inet_protosw mptcp_protosw =3D {
>  	.flags		=3D INET_PROTOSW_ICSK,
>  };
>  =

> -void __init mptcp_init(void)
> +void mptcp_proto_init(void)
>  {
>  	mptcp_prot.h.hashinfo =3D tcp_prot.h.hashinfo;
>  	mptcp_stream_ops =3D inet_stream_ops;
> diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
> index 4c098acf4170..cfcae781de23 100644
> --- a/net/mptcp/protocol.h
> +++ b/net/mptcp/protocol.h
> @@ -184,11 +184,15 @@ mptcp_subflow_tcp_socket(const struct subflow_conte=
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

> =


-- =

Matthieu Baerts | R&D Engineer
matthieu.baerts(a)tessares.net
Tessares SA | Hybrid Access Solutions
www.tessares.net
1 Avenue Jean Monnet, 1348 Louvain-la-Neuve, Belgium

--===============7389276900313920958==--
