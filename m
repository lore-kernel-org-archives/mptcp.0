Content-Type: multipart/mixed; boundary="===============9161681781962378329=="
MIME-Version: 1.0
From: Christoph Paasch <cpaasch at apple.com>
To: mptcp at lists.01.org
Subject: Re: [MPTCP] [PATCH 1/2] mptcp: add MIB counter infrastructure
Date: Mon, 23 Sep 2019 09:55:03 -0700
Message-ID: <16BF7560-A4B0-4F63-8630-B01C6BC250E5@apple.com>
In-Reply-To: 20190920150514.1878-2-fw@strlen.de
X-Status: 
X-Keywords:                  
X-UID: 1907

--===============9161681781962378329==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hello,

some comments inline on the counters:

> On Sep 20, 2019, at 8:05 AM, Florian Westphal <fw(a)strlen.de> wrote:
> =

> Exported via same /proc file as the Linux TCP MIB counters.
> This means tools like 'nstat' will pick them up automatically.
> =

> The MPTCP MIB counters are allocated in a distinct pcpu area in order to
> avoid bloating/wasting TCP pcpu memory.
> =

> The counters are allocated once the first MPTCP socket is created in a
> network namespace.
> =

> The Names are taken from the multipath-tcp.org kernel, in case we don't
> need all of them the extra ones should be pruned.  But for now i've
> added all on the grounds that they are probably useful (i.e., make
> use of them).
> =

> Signed-off-by: Florian Westphal <fw(a)strlen.de>
> ---
> include/net/mptcp.h     |  2 +
> include/net/netns/mib.h |  3 ++
> net/ipv4/af_inet.c      |  4 ++
> net/ipv4/proc.c         |  2 +
> net/mptcp/Makefile      |  2 +-
> net/mptcp/mib.c         | 95 +++++++++++++++++++++++++++++++++++++++++
> net/mptcp/mib.h         | 67 +++++++++++++++++++++++++++++
> net/mptcp/protocol.c    |  8 +++-
> 8 files changed, 181 insertions(+), 2 deletions(-)
> create mode 100644 net/mptcp/mib.c
> create mode 100644 net/mptcp/mib.h
> =

> diff --git a/include/net/mptcp.h b/include/net/mptcp.h
> index 50cd1b31ebdd..c4f4fdd57c74 100644
> --- a/include/net/mptcp.h
> +++ b/include/net/mptcp.h
> @@ -82,6 +82,7 @@ void mptcp_write_options(__be32 *ptr, struct mptcp_out_=
options *opts);
> =

> bool mptcp_sk_is_subflow(const struct sock *sk);
> =

> +void mptcp_seq_show(struct seq_file *seq);
> #else
> =

> static inline void mptcp_init(void)
> @@ -145,5 +146,6 @@ static inline bool mptcp_sk_is_subflow(const struct s=
ock *sk)
> 	return false;
> }
> =

> +static inline void mptcp_seq_show(struct seq_file *seq) { }
> #endif /* CONFIG_MPTCP */
> #endif /* __NET_MPTCP_H */
> diff --git a/include/net/netns/mib.h b/include/net/netns/mib.h
> index 830bdf345b17..59fcaef98fb8 100644
> --- a/include/net/netns/mib.h
> +++ b/include/net/netns/mib.h
> @@ -24,6 +24,9 @@ struct netns_mib {
> #ifdef CONFIG_XFRM_STATISTICS
> 	DEFINE_SNMP_STAT(struct linux_xfrm_mib, xfrm_statistics);
> #endif
> +#ifdef CONFIG_MPTCP
> +	DEFINE_SNMP_STAT(struct mptcp_mib, mptcp_statistics);
> +#endif
> };
> =

> #endif
> diff --git a/net/ipv4/af_inet.c b/net/ipv4/af_inet.c
> index 70f92aaca411..3b2817267989 100644
> --- a/net/ipv4/af_inet.c
> +++ b/net/ipv4/af_inet.c
> @@ -1793,6 +1793,10 @@ static __net_exit void ipv4_mib_exit_net(struct ne=
t *net)
> 	free_percpu(net->mib.net_statistics);
> 	free_percpu(net->mib.ip_statistics);
> 	free_percpu(net->mib.tcp_statistics);
> +#ifdef CONFIG_MPTCP
> +	/* allocated on demand, see mptcp_init_sock() */
> +	free_percpu(net->mib.mptcp_statistics);
> +#endif
> }
> =

> static __net_initdata struct pernet_operations ipv4_mib_ops =3D {
> diff --git a/net/ipv4/proc.c b/net/ipv4/proc.c
> index cc90243ccf76..aeb9be9a9cdb 100644
> --- a/net/ipv4/proc.c
> +++ b/net/ipv4/proc.c
> @@ -32,6 +32,7 @@
> #include <net/icmp.h>
> #include <net/protocol.h>
> #include <net/tcp.h>
> +#include <net/mptcp.h>
> #include <net/udp.h>
> #include <net/udplite.h>
> #include <linux/bottom_half.h>
> @@ -483,6 +484,7 @@ static int netstat_seq_show(struct seq_file *seq, voi=
d *v)
> 					     offsetof(struct ipstats_mib, syncp)));
> =

> 	seq_putc(seq, '\n');
> +	mptcp_seq_show(seq);
> 	return 0;
> }
> =

> diff --git a/net/mptcp/Makefile b/net/mptcp/Makefile
> index 289fdf4339c1..77da3f45cc97 100644
> --- a/net/mptcp/Makefile
> +++ b/net/mptcp/Makefile
> @@ -1,4 +1,4 @@
> # SPDX-License-Identifier: GPL-2.0
> obj-$(CONFIG_MPTCP) +=3D mptcp.o
> =

> -mptcp-y :=3D protocol.o subflow.o options.o token.o crypto.o pm.o ctrl.o
> +mptcp-y :=3D protocol.o subflow.o options.o token.o crypto.o pm.o ctrl.o=
 mib.o
> diff --git a/net/mptcp/mib.c b/net/mptcp/mib.c
> new file mode 100644
> index 000000000000..975a29237260
> --- /dev/null
> +++ b/net/mptcp/mib.c
> @@ -0,0 +1,95 @@
> +/* SPDX-License-Identifier: GPL-2.0-or-later */
> +
> +#include <linux/seq_file.h>
> +#include <net/ip.h>
> +#include <net/snmp.h>
> +#include <net/net_namespace.h>
> +
> +#include "mib.h"
> +
> +static const struct snmp_mib mptcp_snmp_list[] =3D {
> +	SNMP_MIB_ITEM("MPCapableSYNRX", MPTCP_MIB_MPCAPABLEPASSIVE),
> +	SNMP_MIB_ITEM("MPCapableSYNTX", MPTCP_MIB_MPCAPABLEACTIVE),
> +	SNMP_MIB_ITEM("MPCapableSYNACKRX", MPTCP_MIB_MPCAPABLEACTIVEACK),
> +	SNMP_MIB_ITEM("MPCapableACKRX", MPTCP_MIB_MPCAPABLEPASSIVEACK),
> +	SNMP_MIB_ITEM("MPCapableFallbackACK", MPTCP_MIB_MPCAPABLEPASSIVEFALLBAC=
K),
> +	SNMP_MIB_ITEM("MPCapableFallbackSYNACK", MPTCP_MIB_MPCAPABLEACTIVEFALLB=
ACK),
> +	SNMP_MIB_ITEM("MPCapableRetransFallback", MPTCP_MIB_MPCAPABLERETRANSFAL=
LBACK),
> +	SNMP_MIB_ITEM("MPTCPCsumEnabled", MPTCP_MIB_CSUMENABLED),
> +	SNMP_MIB_ITEM("MPTCPRetrans", MPTCP_MIB_RETRANSSEGS),
> +	SNMP_MIB_ITEM("MPFailRX", MPTCP_MIB_MPFAILRX),
> +	SNMP_MIB_ITEM("MPCsumFail", MPTCP_MIB_CSUMFAIL),
> +	SNMP_MIB_ITEM("MPFastcloseRX", MPTCP_MIB_FASTCLOSERX),
> +	SNMP_MIB_ITEM("MPFastcloseTX", MPTCP_MIB_FASTCLOSETX),
> +	SNMP_MIB_ITEM("MPFallbackAckSub", MPTCP_MIB_FBACKSUB),
> +	SNMP_MIB_ITEM("MPFallbackAckInit", MPTCP_MIB_FBACKINIT),
> +	SNMP_MIB_ITEM("MPFallbackDataSub", MPTCP_MIB_FBDATASUB),
> +	SNMP_MIB_ITEM("MPFallbackDataInit", MPTCP_MIB_FBDATAINIT),
> +	SNMP_MIB_ITEM("MPRemoveAddrSubDelete", MPTCP_MIB_REMADDRSUB),
> +	SNMP_MIB_ITEM("MPJoinNoTokenFound", MPTCP_MIB_JOINNOTOKEN),
> +	SNMP_MIB_ITEM("MPJoinAlreadyFallenback", MPTCP_MIB_JOINFALLBACK),
> +	SNMP_MIB_ITEM("MPJoinSynTx", MPTCP_MIB_JOINSYNTX),
> +	SNMP_MIB_ITEM("MPJoinSynRx", MPTCP_MIB_JOINSYNRX),
> +	SNMP_MIB_ITEM("MPJoinSynAckRx", MPTCP_MIB_JOINSYNACKRX),
> +	SNMP_MIB_ITEM("MPJoinSynAckHMacFailure", MPTCP_MIB_JOINSYNACKMAC),
> +	SNMP_MIB_ITEM("MPJoinAckRx", MPTCP_MIB_JOINACKRX),
> +	SNMP_MIB_ITEM("MPJoinAckHMacFailure", MPTCP_MIB_JOINACKMAC),
> +	SNMP_MIB_ITEM("MPJoinAckMissing", MPTCP_MIB_JOINACKFAIL),
> +	SNMP_MIB_ITEM("MPJoinAckRTO", MPTCP_MIB_JOINACKRTO),
> +	SNMP_MIB_ITEM("MPJoinAckRexmit", MPTCP_MIB_JOINACKRXMIT),
> +	SNMP_MIB_ITEM("NoDSSInWindow", MPTCP_MIB_NODSSWINDOW),
> +	SNMP_MIB_ITEM("DSSNotMatching", MPTCP_MIB_DSSNOMATCH),
> +	SNMP_MIB_ITEM("InfiniteMapRx", MPTCP_MIB_INFINITEMAPRX),
> +	SNMP_MIB_ITEM("DSSNoMatchTCP", MPTCP_MIB_DSSTCPMISMATCH),
> +	SNMP_MIB_ITEM("DSSTrimHead", MPTCP_MIB_DSSTRIMHEAD),
> +	SNMP_MIB_ITEM("DSSSplitTail", MPTCP_MIB_DSSSPLITTAIL),
> +	SNMP_MIB_ITEM("DSSPurgeOldSubSegs", MPTCP_MIB_PURGEOLD),
> +	SNMP_MIB_ITEM("AddAddrRx", MPTCP_MIB_ADDADDRRX),
> +	SNMP_MIB_ITEM("AddAddrTx", MPTCP_MIB_ADDADDRTX),
> +	SNMP_MIB_ITEM("RemAddrRx", MPTCP_MIB_REMADDRRX),
> +	SNMP_MIB_ITEM("RemAddrTx", MPTCP_MIB_REMADDRTX),

I think these are roughly what we have in multipath-tcp.org <http://multipa=
th-tcp.org/>.
And I think they are a bit too extensive (I just added whatever I could thi=
nk of in multipath-tcp.org <http://multipath-tcp.org/> ;-) ). Like, ADDADDR=
TX/RX,... JoinSynTX (will be steered by the user-space path-manager),...

We are not really looking at them that much. It's more about the error-cond=
itions that are interesting in ratio with the number of established connect=
ions. For example, MPTCP_MIB_JOINNOTOKEN is very useful because it is an in=
dicator that the subflow-steering behind the loadbalancer is not working co=
rrectly.

Maybe we start with the most minimal set of counters and can add later on a=
s more ops-experience is being gathered?

> +	SNMP_MIB_SENTINEL
> +};

A very useful MIB is a counter for the currently established MPTCP-connecti=
ons, and MPTCP-subflows (similar to what TCP offers with TCP_MIB_CURRESTAB).


Christoph

> +
> +/* mptcp_mib_alloc - allocate percpu mib counters
> + *
> + * These are allocated when the first mptcp socket is created so
> + * we do not waste percpu memory if mptcp isn't in use.
> + */
> +bool mptcp_mib_alloc(struct net *net)
> +{
> +	struct mptcp_mib *mib =3D alloc_percpu(struct mptcp_mib);
> +
> +	if (!mib)
> +		return false;
> +
> +	if (cmpxchg(&net->mib.mptcp_statistics, NULL, mib))
> +		free_percpu(mib);
> +
> +	return true;
> +}
> +
> +void mptcp_seq_show(struct seq_file *seq)
> +{
> +	struct net *net =3D seq->private;
> +	int i;
> +
> +	seq_puts(seq, "MPTcpExt:");
> +	for (i =3D 0; mptcp_snmp_list[i].name; i++)
> +		seq_printf(seq, " %s", mptcp_snmp_list[i].name);
> +
> +	seq_puts(seq, "\nMPTcpExt:");
> +
> +	if (!net->mib.mptcp_statistics) {
> +		for (i =3D 0; mptcp_snmp_list[i].name; i++)
> +			seq_printf(seq, " %lu", 0ul);
> +
> +		return;
> +	}
> +
> +	for (i =3D 0; mptcp_snmp_list[i].name; i++)
> +		seq_printf(seq, " %lu",
> +			   snmp_fold_field(net->mib.mptcp_statistics,
> +					   mptcp_snmp_list[i].entry));
> +	seq_putc(seq, '\n');
> +}
> diff --git a/net/mptcp/mib.h b/net/mptcp/mib.h
> new file mode 100644
> index 000000000000..c24c41dc330c
> --- /dev/null
> +++ b/net/mptcp/mib.h
> @@ -0,0 +1,67 @@
> +/* SPDX-License-Identifier: GPL-2.0-or-later */
> +
> +enum linux_mptcp_mib_field {
> +	MPTCP_MIB_NUM =3D 0,
> +	MPTCP_MIB_MPCAPABLEPASSIVE,	/* Received SYN with MP_CAPABLE */
> +	MPTCP_MIB_MPCAPABLEACTIVE,	/* Sent SYN with MP_CAPABLE */
> +	MPTCP_MIB_MPCAPABLEACTIVEACK,	/* Received SYN/ACK with MP_CAPABLE */
> +	MPTCP_MIB_MPCAPABLEPASSIVEACK,	/* Received third ACK with MP_CAPABLE */
> +	MPTCP_MIB_MPCAPABLEPASSIVEFALLBACK,/* Server-side fallback during 3-way=
 handshake */
> +	MPTCP_MIB_MPCAPABLEACTIVEFALLBACK, /* Client-side fallback during 3-way=
 handshake */
> +	MPTCP_MIB_MPCAPABLERETRANSFALLBACK,/* Client-side stopped sending MP_CA=
PABLE after too many SYN-retransmissions */
> +	MPTCP_MIB_CSUMENABLED,		/* Created MPTCP-connection with DSS-checksum e=
nabled */
> +	MPTCP_MIB_RETRANSSEGS,		/* Segments retransmitted at the MPTCP-level */
> +	MPTCP_MIB_MPFAILRX,		/* Received an MP_FAIL */
> +	MPTCP_MIB_CSUMFAIL,		/* Received segment with invalid checksum */
> +	MPTCP_MIB_FASTCLOSERX,		/* Recevied a FAST_CLOSE */
> +	MPTCP_MIB_FASTCLOSETX,		/* Sent a FAST_CLOSE */
> +	MPTCP_MIB_FBACKSUB,		/* Fallback upon ack without data-ack on new subfl=
ow */
> +	MPTCP_MIB_FBACKINIT,		/* Fallback upon ack without data-ack on initial =
subflow */
> +	MPTCP_MIB_FBDATASUB,		/* Fallback upon data without DSS at the beginnin=
g on new subflow */
> +	MPTCP_MIB_FBDATAINIT,		/* Fallback upon data without DSS at the beginni=
ng on initial subflow */
> +	MPTCP_MIB_REMADDRSUB,		/* Remove subflow due to REMOVE_ADDR */
> +	MPTCP_MIB_JOINNOTOKEN,		/* Received MP_JOIN but the token was not found=
 */
> +	MPTCP_MIB_JOINFALLBACK,		/* Received MP_JOIN on session that has fallen=
 back to reg. TCP */
> +	MPTCP_MIB_JOINSYNTX,		/* Sent a SYN + MP_JOIN */
> +	MPTCP_MIB_JOINSYNRX,		/* Received a SYN + MP_JOIN */
> +	MPTCP_MIB_JOINSYNACKRX,		/* Received a SYN/ACK + MP_JOIN */
> +	MPTCP_MIB_JOINSYNACKMAC,	/* HMAC was wrong on SYN/ACK + MP_JOIN */
> +	MPTCP_MIB_JOINACKRX,		/* Received an ACK + MP_JOIN */
> +	MPTCP_MIB_JOINACKMAC,		/* HMAC was wrong on ACK + MP_JOIN */
> +	MPTCP_MIB_JOINACKFAIL,		/* Third ACK on new subflow did not contain an =
MP_JOIN */
> +	MPTCP_MIB_JOINACKRTO,		/* Retransmission timer for third ACK + MP_JOIN =
timed out */
> +	MPTCP_MIB_JOINACKRXMIT,		/* Retransmitted an ACK + MP_JOIN */
> +	MPTCP_MIB_NODSSWINDOW,		/* Received too many packets without a DSS-opti=
on */
> +	MPTCP_MIB_DSSNOMATCH,		/* Received a new mapping that did not match the=
 previous one */
> +	MPTCP_MIB_INFINITEMAPRX,	/* Received an infinite mapping */
> +	MPTCP_MIB_DSSTCPMISMATCH,	/* DSS-mapping did not map with TCP's sequenc=
e numbers */
> +	MPTCP_MIB_DSSTRIMHEAD,		/* Trimmed segment at the head (coalescing midd=
lebox) */
> +	MPTCP_MIB_DSSSPLITTAIL,		/* Trimmed segment at the tail (coalescing mid=
dlebox) */
> +	MPTCP_MIB_PURGEOLD,		/* Removed old skb from the rcv-queue due to missi=
ng DSS-mapping */
> +	MPTCP_MIB_ADDADDRRX,		/* Received an ADD_ADDR */
> +	MPTCP_MIB_ADDADDRTX,		/* Sent an ADD_ADDR */
> +	MPTCP_MIB_REMADDRRX,		/* Received a REMOVE_ADDR */
> +	MPTCP_MIB_REMADDRTX,		/* Sent a REMOVE_ADDR */
> +	__MPTCP_MIB_MAX
> +};
> +
> +#define LINUX_MIB_MPTCP_MAX	__MPTCP_MIB_MAX
> +struct mptcp_mib {
> +	unsigned long mibs[LINUX_MIB_MPTCP_MAX];
> +};
> +
> +static inline void MPTCP_INC_STATS(struct net *net,
> +				   enum linux_mptcp_mib_field field)
> +{
> +	if (likely(net->mib.mptcp_statistics))
> +		SNMP_INC_STATS(net->mib.mptcp_statistics, field);
> +}
> +
> +static inline void __MPTCP_INC_STATS(struct net *net,
> +				     enum linux_mptcp_mib_field field)
> +{
> +	if (likely(net->mib.mptcp_statistics))
> +		__SNMP_INC_STATS(net->mib.mptcp_statistics, field);
> +}
> +
> +bool mptcp_mib_alloc(struct net *net);
> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index 9c019e696fc7..66ac7dafe388 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -16,6 +16,7 @@
> #include <net/tcp.h>
> #include <net/mptcp.h>
> #include "protocol.h"
> +#include "mib.h"
> =

> static inline bool before64(__u64 seq1, __u64 seq2)
> {
> @@ -621,9 +622,14 @@ static int __mptcp_init_sock(struct sock *sk)
> =

> static int mptcp_init_sock(struct sock *sk)
> {
> -	if (!mptcp_is_enabled(sock_net(sk)))
> +	struct net *net =3D sock_net(sk);
> +
> +	if (!mptcp_is_enabled(net))
> 		return -ENOPROTOOPT;
> =

> +	if (unlikely(!net->mib.mptcp_statistics) && !mptcp_mib_alloc(net))
> +		return -ENOMEM;
> +
> 	return __mptcp_init_sock(sk);
> }
> =

> -- =

> 2.21.0
> =

> _______________________________________________
> mptcp mailing list
> mptcp(a)lists.01.org
> https://lists.01.org/mailman/listinfo/mptcp


--===============9161681781962378329==
Content-Type: text/html
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="attachment.html"

PGh0bWw+PGhlYWQ+PG1ldGEgaHR0cC1lcXVpdj0iQ29udGVudC1UeXBlIiBjb250ZW50PSJ0ZXh0
L2h0bWw7IGNoYXJzZXQ9dXMtYXNjaWkiPjwvaGVhZD48Ym9keSBzdHlsZT0id29yZC13cmFwOiBi
cmVhay13b3JkOyAtd2Via2l0LW5ic3AtbW9kZTogc3BhY2U7IGxpbmUtYnJlYWs6IGFmdGVyLXdo
aXRlLXNwYWNlOyIgY2xhc3M9IiI+SGVsbG8sPGRpdiBjbGFzcz0iIj48YnIgY2xhc3M9IiI+PC9k
aXY+PGRpdiBjbGFzcz0iIj5zb21lIGNvbW1lbnRzIGlubGluZSBvbiB0aGUgY291bnRlcnM6PGJy
IGNsYXNzPSIiPjxkaXY+PGJyIGNsYXNzPSIiPjxibG9ja3F1b3RlIHR5cGU9ImNpdGUiIGNsYXNz
PSIiPjxkaXYgY2xhc3M9IiI+T24gU2VwIDIwLCAyMDE5LCBhdCA4OjA1IEFNLCBGbG9yaWFuIFdl
c3RwaGFsICZsdDs8YSBocmVmPSJtYWlsdG86ZndAc3RybGVuLmRlIiBjbGFzcz0iIj5md0BzdHJs
ZW4uZGU8L2E+Jmd0OyB3cm90ZTo8L2Rpdj48YnIgY2xhc3M9IkFwcGxlLWludGVyY2hhbmdlLW5l
d2xpbmUiPjxkaXYgY2xhc3M9IiI+PGRpdiBjbGFzcz0iIj5FeHBvcnRlZCB2aWEgc2FtZSAvcHJv
YyBmaWxlIGFzIHRoZSBMaW51eCBUQ1AgTUlCIGNvdW50ZXJzLjxiciBjbGFzcz0iIj5UaGlzIG1l
YW5zIHRvb2xzIGxpa2UgJ25zdGF0JyB3aWxsIHBpY2sgdGhlbSB1cCBhdXRvbWF0aWNhbGx5Ljxi
ciBjbGFzcz0iIj48YnIgY2xhc3M9IiI+VGhlIE1QVENQIE1JQiBjb3VudGVycyBhcmUgYWxsb2Nh
dGVkIGluIGEgZGlzdGluY3QgcGNwdSBhcmVhIGluIG9yZGVyIHRvPGJyIGNsYXNzPSIiPmF2b2lk
IGJsb2F0aW5nL3dhc3RpbmcgVENQIHBjcHUgbWVtb3J5LjxiciBjbGFzcz0iIj48YnIgY2xhc3M9
IiI+VGhlIGNvdW50ZXJzIGFyZSBhbGxvY2F0ZWQgb25jZSB0aGUgZmlyc3QgTVBUQ1Agc29ja2V0
IGlzIGNyZWF0ZWQgaW4gYTxiciBjbGFzcz0iIj5uZXR3b3JrIG5hbWVzcGFjZS48YnIgY2xhc3M9
IiI+PGJyIGNsYXNzPSIiPlRoZSBOYW1lcyBhcmUgdGFrZW4gZnJvbSB0aGUgPGEgaHJlZj0iaHR0
cDovL211bHRpcGF0aC10Y3Aub3JnIiBjbGFzcz0iIj5tdWx0aXBhdGgtdGNwLm9yZzwvYT4ga2Vy
bmVsLCBpbiBjYXNlIHdlIGRvbid0PGJyIGNsYXNzPSIiPm5lZWQgYWxsIG9mIHRoZW0gdGhlIGV4
dHJhIG9uZXMgc2hvdWxkIGJlIHBydW5lZC4gJm5ic3A7QnV0IGZvciBub3cgaSd2ZTxiciBjbGFz
cz0iIj5hZGRlZCBhbGwgb24gdGhlIGdyb3VuZHMgdGhhdCB0aGV5IGFyZSBwcm9iYWJseSB1c2Vm
dWwgKGkuZS4sIG1ha2U8YnIgY2xhc3M9IiI+dXNlIG9mIHRoZW0pLjxiciBjbGFzcz0iIj48YnIg
Y2xhc3M9IiI+U2lnbmVkLW9mZi1ieTogRmxvcmlhbiBXZXN0cGhhbCAmbHQ7PGEgaHJlZj0ibWFp
bHRvOmZ3QHN0cmxlbi5kZSIgY2xhc3M9IiI+ZndAc3RybGVuLmRlPC9hPiZndDs8YnIgY2xhc3M9
IiI+LS0tPGJyIGNsYXNzPSIiPiBpbmNsdWRlL25ldC9tcHRjcC5oICZuYnNwOyZuYnNwOyZuYnNw
OyZuYnNwO3wgJm5ic3A7MiArPGJyIGNsYXNzPSIiPiBpbmNsdWRlL25ldC9uZXRucy9taWIuaCB8
ICZuYnNwOzMgKys8YnIgY2xhc3M9IiI+IG5ldC9pcHY0L2FmX2luZXQuYyAmbmJzcDsmbmJzcDsm
bmJzcDsmbmJzcDsmbmJzcDt8ICZuYnNwOzQgKys8YnIgY2xhc3M9IiI+IG5ldC9pcHY0L3Byb2Mu
YyAmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDt8ICZuYnNw
OzIgKzxiciBjbGFzcz0iIj4gbmV0L21wdGNwL01ha2VmaWxlICZuYnNwOyZuYnNwOyZuYnNwOyZu
YnNwOyZuYnNwO3wgJm5ic3A7MiArLTxiciBjbGFzcz0iIj4gbmV0L21wdGNwL21pYi5jICZuYnNw
OyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwO3wgOTUgKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKys8YnIgY2xhc3M9IiI+IG5ldC9tcHRjcC9t
aWIuaCAmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDt8IDY3
ICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrPGJyIGNsYXNzPSIiPiBuZXQvbXB0Y3AvcHJv
dG9jb2wuYyAmbmJzcDsmbmJzcDsmbmJzcDt8ICZuYnNwOzggKysrLTxiciBjbGFzcz0iIj4gOCBm
aWxlcyBjaGFuZ2VkLCAxODEgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSk8YnIgY2xhc3M9
IiI+IGNyZWF0ZSBtb2RlIDEwMDY0NCBuZXQvbXB0Y3AvbWliLmM8YnIgY2xhc3M9IiI+IGNyZWF0
ZSBtb2RlIDEwMDY0NCBuZXQvbXB0Y3AvbWliLmg8YnIgY2xhc3M9IiI+PGJyIGNsYXNzPSIiPmRp
ZmYgLS1naXQgYS9pbmNsdWRlL25ldC9tcHRjcC5oIGIvaW5jbHVkZS9uZXQvbXB0Y3AuaDxiciBj
bGFzcz0iIj5pbmRleCA1MGNkMWIzMWViZGQuLmM0ZjRmZGQ1N2M3NCAxMDA2NDQ8YnIgY2xhc3M9
IiI+LS0tIGEvaW5jbHVkZS9uZXQvbXB0Y3AuaDxiciBjbGFzcz0iIj4rKysgYi9pbmNsdWRlL25l
dC9tcHRjcC5oPGJyIGNsYXNzPSIiPkBAIC04Miw2ICs4Miw3IEBAIHZvaWQgbXB0Y3Bfd3JpdGVf
b3B0aW9ucyhfX2JlMzIgKnB0ciwgc3RydWN0IG1wdGNwX291dF9vcHRpb25zICpvcHRzKTs8YnIg
Y2xhc3M9IiI+PGJyIGNsYXNzPSIiPiBib29sIG1wdGNwX3NrX2lzX3N1YmZsb3coY29uc3Qgc3Ry
dWN0IHNvY2sgKnNrKTs8YnIgY2xhc3M9IiI+PGJyIGNsYXNzPSIiPit2b2lkIG1wdGNwX3NlcV9z
aG93KHN0cnVjdCBzZXFfZmlsZSAqc2VxKTs8YnIgY2xhc3M9IiI+ICNlbHNlPGJyIGNsYXNzPSIi
PjxiciBjbGFzcz0iIj4gc3RhdGljIGlubGluZSB2b2lkIG1wdGNwX2luaXQodm9pZCk8YnIgY2xh
c3M9IiI+QEAgLTE0NSw1ICsxNDYsNiBAQCBzdGF0aWMgaW5saW5lIGJvb2wgbXB0Y3Bfc2tfaXNf
c3ViZmxvdyhjb25zdCBzdHJ1Y3Qgc29jayAqc2spPGJyIGNsYXNzPSIiPiA8c3BhbiBjbGFzcz0i
QXBwbGUtdGFiLXNwYW4iIHN0eWxlPSJ3aGl0ZS1zcGFjZTpwcmUiPgk8L3NwYW4+cmV0dXJuIGZh
bHNlOzxiciBjbGFzcz0iIj4gfTxiciBjbGFzcz0iIj48YnIgY2xhc3M9IiI+K3N0YXRpYyBpbmxp
bmUgdm9pZCBtcHRjcF9zZXFfc2hvdyhzdHJ1Y3Qgc2VxX2ZpbGUgKnNlcSkgeyB9PGJyIGNsYXNz
PSIiPiAjZW5kaWYgLyogQ09ORklHX01QVENQICovPGJyIGNsYXNzPSIiPiAjZW5kaWYgLyogX19O
RVRfTVBUQ1BfSCAqLzxiciBjbGFzcz0iIj5kaWZmIC0tZ2l0IGEvaW5jbHVkZS9uZXQvbmV0bnMv
bWliLmggYi9pbmNsdWRlL25ldC9uZXRucy9taWIuaDxiciBjbGFzcz0iIj5pbmRleCA4MzBiZGYz
NDViMTcuLjU5ZmNhZWY5OGZiOCAxMDA2NDQ8YnIgY2xhc3M9IiI+LS0tIGEvaW5jbHVkZS9uZXQv
bmV0bnMvbWliLmg8YnIgY2xhc3M9IiI+KysrIGIvaW5jbHVkZS9uZXQvbmV0bnMvbWliLmg8YnIg
Y2xhc3M9IiI+QEAgLTI0LDYgKzI0LDkgQEAgc3RydWN0IG5ldG5zX21pYiB7PGJyIGNsYXNzPSIi
PiAjaWZkZWYgQ09ORklHX1hGUk1fU1RBVElTVElDUzxiciBjbGFzcz0iIj4gPHNwYW4gY2xhc3M9
IkFwcGxlLXRhYi1zcGFuIiBzdHlsZT0id2hpdGUtc3BhY2U6cHJlIj4JPC9zcGFuPkRFRklORV9T
Tk1QX1NUQVQoc3RydWN0IGxpbnV4X3hmcm1fbWliLCB4ZnJtX3N0YXRpc3RpY3MpOzxiciBjbGFz
cz0iIj4gI2VuZGlmPGJyIGNsYXNzPSIiPisjaWZkZWYgQ09ORklHX01QVENQPGJyIGNsYXNzPSIi
Pis8c3BhbiBjbGFzcz0iQXBwbGUtdGFiLXNwYW4iIHN0eWxlPSJ3aGl0ZS1zcGFjZTpwcmUiPgk8
L3NwYW4+REVGSU5FX1NOTVBfU1RBVChzdHJ1Y3QgbXB0Y3BfbWliLCBtcHRjcF9zdGF0aXN0aWNz
KTs8YnIgY2xhc3M9IiI+KyNlbmRpZjxiciBjbGFzcz0iIj4gfTs8YnIgY2xhc3M9IiI+PGJyIGNs
YXNzPSIiPiAjZW5kaWY8YnIgY2xhc3M9IiI+ZGlmZiAtLWdpdCBhL25ldC9pcHY0L2FmX2luZXQu
YyBiL25ldC9pcHY0L2FmX2luZXQuYzxiciBjbGFzcz0iIj5pbmRleCA3MGY5MmFhY2E0MTEuLjNi
MjgxNzI2Nzk4OSAxMDA2NDQ8YnIgY2xhc3M9IiI+LS0tIGEvbmV0L2lwdjQvYWZfaW5ldC5jPGJy
IGNsYXNzPSIiPisrKyBiL25ldC9pcHY0L2FmX2luZXQuYzxiciBjbGFzcz0iIj5AQCAtMTc5Myw2
ICsxNzkzLDEwIEBAIHN0YXRpYyBfX25ldF9leGl0IHZvaWQgaXB2NF9taWJfZXhpdF9uZXQoc3Ry
dWN0IG5ldCAqbmV0KTxiciBjbGFzcz0iIj4gPHNwYW4gY2xhc3M9IkFwcGxlLXRhYi1zcGFuIiBz
dHlsZT0id2hpdGUtc3BhY2U6cHJlIj4JPC9zcGFuPmZyZWVfcGVyY3B1KG5ldC0mZ3Q7bWliLm5l
dF9zdGF0aXN0aWNzKTs8YnIgY2xhc3M9IiI+IDxzcGFuIGNsYXNzPSJBcHBsZS10YWItc3BhbiIg
c3R5bGU9IndoaXRlLXNwYWNlOnByZSI+CTwvc3Bhbj5mcmVlX3BlcmNwdShuZXQtJmd0O21pYi5p
cF9zdGF0aXN0aWNzKTs8YnIgY2xhc3M9IiI+IDxzcGFuIGNsYXNzPSJBcHBsZS10YWItc3BhbiIg
c3R5bGU9IndoaXRlLXNwYWNlOnByZSI+CTwvc3Bhbj5mcmVlX3BlcmNwdShuZXQtJmd0O21pYi50
Y3Bfc3RhdGlzdGljcyk7PGJyIGNsYXNzPSIiPisjaWZkZWYgQ09ORklHX01QVENQPGJyIGNsYXNz
PSIiPis8c3BhbiBjbGFzcz0iQXBwbGUtdGFiLXNwYW4iIHN0eWxlPSJ3aGl0ZS1zcGFjZTpwcmUi
Pgk8L3NwYW4+LyogYWxsb2NhdGVkIG9uIGRlbWFuZCwgc2VlIG1wdGNwX2luaXRfc29jaygpICov
PGJyIGNsYXNzPSIiPis8c3BhbiBjbGFzcz0iQXBwbGUtdGFiLXNwYW4iIHN0eWxlPSJ3aGl0ZS1z
cGFjZTpwcmUiPgk8L3NwYW4+ZnJlZV9wZXJjcHUobmV0LSZndDttaWIubXB0Y3Bfc3RhdGlzdGlj
cyk7PGJyIGNsYXNzPSIiPisjZW5kaWY8YnIgY2xhc3M9IiI+IH08YnIgY2xhc3M9IiI+PGJyIGNs
YXNzPSIiPiBzdGF0aWMgX19uZXRfaW5pdGRhdGEgc3RydWN0IHBlcm5ldF9vcGVyYXRpb25zIGlw
djRfbWliX29wcyA9IHs8YnIgY2xhc3M9IiI+ZGlmZiAtLWdpdCBhL25ldC9pcHY0L3Byb2MuYyBi
L25ldC9pcHY0L3Byb2MuYzxiciBjbGFzcz0iIj5pbmRleCBjYzkwMjQzY2NmNzYuLmFlYjliZTlh
OWNkYiAxMDA2NDQ8YnIgY2xhc3M9IiI+LS0tIGEvbmV0L2lwdjQvcHJvYy5jPGJyIGNsYXNzPSIi
PisrKyBiL25ldC9pcHY0L3Byb2MuYzxiciBjbGFzcz0iIj5AQCAtMzIsNiArMzIsNyBAQDxiciBj
bGFzcz0iIj4gI2luY2x1ZGUgJmx0O25ldC9pY21wLmgmZ3Q7PGJyIGNsYXNzPSIiPiAjaW5jbHVk
ZSAmbHQ7bmV0L3Byb3RvY29sLmgmZ3Q7PGJyIGNsYXNzPSIiPiAjaW5jbHVkZSAmbHQ7bmV0L3Rj
cC5oJmd0OzxiciBjbGFzcz0iIj4rI2luY2x1ZGUgJmx0O25ldC9tcHRjcC5oJmd0OzxiciBjbGFz
cz0iIj4gI2luY2x1ZGUgJmx0O25ldC91ZHAuaCZndDs8YnIgY2xhc3M9IiI+ICNpbmNsdWRlICZs
dDtuZXQvdWRwbGl0ZS5oJmd0OzxiciBjbGFzcz0iIj4gI2luY2x1ZGUgJmx0O2xpbnV4L2JvdHRv
bV9oYWxmLmgmZ3Q7PGJyIGNsYXNzPSIiPkBAIC00ODMsNiArNDg0LDcgQEAgc3RhdGljIGludCBu
ZXRzdGF0X3NlcV9zaG93KHN0cnVjdCBzZXFfZmlsZSAqc2VxLCB2b2lkICp2KTxiciBjbGFzcz0i
Ij4gPHNwYW4gY2xhc3M9IkFwcGxlLXRhYi1zcGFuIiBzdHlsZT0id2hpdGUtc3BhY2U6cHJlIj4J
PC9zcGFuPjxzcGFuIGNsYXNzPSJBcHBsZS10YWItc3BhbiIgc3R5bGU9IndoaXRlLXNwYWNlOnBy
ZSI+CTwvc3Bhbj48c3BhbiBjbGFzcz0iQXBwbGUtdGFiLXNwYW4iIHN0eWxlPSJ3aGl0ZS1zcGFj
ZTpwcmUiPgk8L3NwYW4+PHNwYW4gY2xhc3M9IkFwcGxlLXRhYi1zcGFuIiBzdHlsZT0id2hpdGUt
c3BhY2U6cHJlIj4JPC9zcGFuPjxzcGFuIGNsYXNzPSJBcHBsZS10YWItc3BhbiIgc3R5bGU9Indo
aXRlLXNwYWNlOnByZSI+CTwvc3Bhbj4gJm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7b2Zmc2V0b2Yo
c3RydWN0IGlwc3RhdHNfbWliLCBzeW5jcCkpKTs8YnIgY2xhc3M9IiI+PGJyIGNsYXNzPSIiPiA8
c3BhbiBjbGFzcz0iQXBwbGUtdGFiLXNwYW4iIHN0eWxlPSJ3aGl0ZS1zcGFjZTpwcmUiPgk8L3Nw
YW4+c2VxX3B1dGMoc2VxLCAnXG4nKTs8YnIgY2xhc3M9IiI+KzxzcGFuIGNsYXNzPSJBcHBsZS10
YWItc3BhbiIgc3R5bGU9IndoaXRlLXNwYWNlOnByZSI+CTwvc3Bhbj5tcHRjcF9zZXFfc2hvdyhz
ZXEpOzxiciBjbGFzcz0iIj4gPHNwYW4gY2xhc3M9IkFwcGxlLXRhYi1zcGFuIiBzdHlsZT0id2hp
dGUtc3BhY2U6cHJlIj4JPC9zcGFuPnJldHVybiAwOzxiciBjbGFzcz0iIj4gfTxiciBjbGFzcz0i
Ij48YnIgY2xhc3M9IiI+ZGlmZiAtLWdpdCBhL25ldC9tcHRjcC9NYWtlZmlsZSBiL25ldC9tcHRj
cC9NYWtlZmlsZTxiciBjbGFzcz0iIj5pbmRleCAyODlmZGY0MzM5YzEuLjc3ZGEzZjQ1Y2M5NyAx
MDA2NDQ8YnIgY2xhc3M9IiI+LS0tIGEvbmV0L21wdGNwL01ha2VmaWxlPGJyIGNsYXNzPSIiPisr
KyBiL25ldC9tcHRjcC9NYWtlZmlsZTxiciBjbGFzcz0iIj5AQCAtMSw0ICsxLDQgQEA8YnIgY2xh
c3M9IiI+ICMgU1BEWC1MaWNlbnNlLUlkZW50aWZpZXI6IEdQTC0yLjA8YnIgY2xhc3M9IiI+IG9i
ai0kKENPTkZJR19NUFRDUCkgKz0gbXB0Y3AubzxiciBjbGFzcz0iIj48YnIgY2xhc3M9IiI+LW1w
dGNwLXkgOj0gcHJvdG9jb2wubyBzdWJmbG93Lm8gb3B0aW9ucy5vIHRva2VuLm8gY3J5cHRvLm8g
cG0ubyBjdHJsLm88YnIgY2xhc3M9IiI+K21wdGNwLXkgOj0gcHJvdG9jb2wubyBzdWJmbG93Lm8g
b3B0aW9ucy5vIHRva2VuLm8gY3J5cHRvLm8gcG0ubyBjdHJsLm8gbWliLm88YnIgY2xhc3M9IiI+
ZGlmZiAtLWdpdCBhL25ldC9tcHRjcC9taWIuYyBiL25ldC9tcHRjcC9taWIuYzxiciBjbGFzcz0i
Ij5uZXcgZmlsZSBtb2RlIDEwMDY0NDxiciBjbGFzcz0iIj5pbmRleCAwMDAwMDAwMDAwMDAuLjk3
NWEyOTIzNzI2MDxiciBjbGFzcz0iIj4tLS0gL2Rldi9udWxsPGJyIGNsYXNzPSIiPisrKyBiL25l
dC9tcHRjcC9taWIuYzxiciBjbGFzcz0iIj5AQCAtMCwwICsxLDk1IEBAPGJyIGNsYXNzPSIiPisv
KiBTUERYLUxpY2Vuc2UtSWRlbnRpZmllcjogR1BMLTIuMC1vci1sYXRlciAqLzxiciBjbGFzcz0i
Ij4rPGJyIGNsYXNzPSIiPisjaW5jbHVkZSAmbHQ7bGludXgvc2VxX2ZpbGUuaCZndDs8YnIgY2xh
c3M9IiI+KyNpbmNsdWRlICZsdDtuZXQvaXAuaCZndDs8YnIgY2xhc3M9IiI+KyNpbmNsdWRlICZs
dDtuZXQvc25tcC5oJmd0OzxiciBjbGFzcz0iIj4rI2luY2x1ZGUgJmx0O25ldC9uZXRfbmFtZXNw
YWNlLmgmZ3Q7PGJyIGNsYXNzPSIiPis8YnIgY2xhc3M9IiI+KyNpbmNsdWRlICJtaWIuaCI8YnIg
Y2xhc3M9IiI+KzxiciBjbGFzcz0iIj4rc3RhdGljIGNvbnN0IHN0cnVjdCBzbm1wX21pYiBtcHRj
cF9zbm1wX2xpc3RbXSA9IHs8YnIgY2xhc3M9IiI+KzxzcGFuIGNsYXNzPSJBcHBsZS10YWItc3Bh
biIgc3R5bGU9IndoaXRlLXNwYWNlOnByZSI+CTwvc3Bhbj5TTk1QX01JQl9JVEVNKCJNUENhcGFi
bGVTWU5SWCIsIE1QVENQX01JQl9NUENBUEFCTEVQQVNTSVZFKSw8YnIgY2xhc3M9IiI+KzxzcGFu
IGNsYXNzPSJBcHBsZS10YWItc3BhbiIgc3R5bGU9IndoaXRlLXNwYWNlOnByZSI+CTwvc3Bhbj5T
Tk1QX01JQl9JVEVNKCJNUENhcGFibGVTWU5UWCIsIE1QVENQX01JQl9NUENBUEFCTEVBQ1RJVkUp
LDxiciBjbGFzcz0iIj4rPHNwYW4gY2xhc3M9IkFwcGxlLXRhYi1zcGFuIiBzdHlsZT0id2hpdGUt
c3BhY2U6cHJlIj4JPC9zcGFuPlNOTVBfTUlCX0lURU0oIk1QQ2FwYWJsZVNZTkFDS1JYIiwgTVBU
Q1BfTUlCX01QQ0FQQUJMRUFDVElWRUFDSyksPGJyIGNsYXNzPSIiPis8c3BhbiBjbGFzcz0iQXBw
bGUtdGFiLXNwYW4iIHN0eWxlPSJ3aGl0ZS1zcGFjZTpwcmUiPgk8L3NwYW4+U05NUF9NSUJfSVRF
TSgiTVBDYXBhYmxlQUNLUlgiLCBNUFRDUF9NSUJfTVBDQVBBQkxFUEFTU0lWRUFDSyksPGJyIGNs
YXNzPSIiPis8c3BhbiBjbGFzcz0iQXBwbGUtdGFiLXNwYW4iIHN0eWxlPSJ3aGl0ZS1zcGFjZTpw
cmUiPgk8L3NwYW4+U05NUF9NSUJfSVRFTSgiTVBDYXBhYmxlRmFsbGJhY2tBQ0siLCBNUFRDUF9N
SUJfTVBDQVBBQkxFUEFTU0lWRUZBTExCQUNLKSw8YnIgY2xhc3M9IiI+KzxzcGFuIGNsYXNzPSJB
cHBsZS10YWItc3BhbiIgc3R5bGU9IndoaXRlLXNwYWNlOnByZSI+CTwvc3Bhbj5TTk1QX01JQl9J
VEVNKCJNUENhcGFibGVGYWxsYmFja1NZTkFDSyIsIE1QVENQX01JQl9NUENBUEFCTEVBQ1RJVkVG
QUxMQkFDSyksPGJyIGNsYXNzPSIiPis8c3BhbiBjbGFzcz0iQXBwbGUtdGFiLXNwYW4iIHN0eWxl
PSJ3aGl0ZS1zcGFjZTpwcmUiPgk8L3NwYW4+U05NUF9NSUJfSVRFTSgiTVBDYXBhYmxlUmV0cmFu
c0ZhbGxiYWNrIiwgTVBUQ1BfTUlCX01QQ0FQQUJMRVJFVFJBTlNGQUxMQkFDSyksPGJyIGNsYXNz
PSIiPis8c3BhbiBjbGFzcz0iQXBwbGUtdGFiLXNwYW4iIHN0eWxlPSJ3aGl0ZS1zcGFjZTpwcmUi
Pgk8L3NwYW4+U05NUF9NSUJfSVRFTSgiTVBUQ1BDc3VtRW5hYmxlZCIsIE1QVENQX01JQl9DU1VN
RU5BQkxFRCksPGJyIGNsYXNzPSIiPis8c3BhbiBjbGFzcz0iQXBwbGUtdGFiLXNwYW4iIHN0eWxl
PSJ3aGl0ZS1zcGFjZTpwcmUiPgk8L3NwYW4+U05NUF9NSUJfSVRFTSgiTVBUQ1BSZXRyYW5zIiwg
TVBUQ1BfTUlCX1JFVFJBTlNTRUdTKSw8YnIgY2xhc3M9IiI+KzxzcGFuIGNsYXNzPSJBcHBsZS10
YWItc3BhbiIgc3R5bGU9IndoaXRlLXNwYWNlOnByZSI+CTwvc3Bhbj5TTk1QX01JQl9JVEVNKCJN
UEZhaWxSWCIsIE1QVENQX01JQl9NUEZBSUxSWCksPGJyIGNsYXNzPSIiPis8c3BhbiBjbGFzcz0i
QXBwbGUtdGFiLXNwYW4iIHN0eWxlPSJ3aGl0ZS1zcGFjZTpwcmUiPgk8L3NwYW4+U05NUF9NSUJf
SVRFTSgiTVBDc3VtRmFpbCIsIE1QVENQX01JQl9DU1VNRkFJTCksPGJyIGNsYXNzPSIiPis8c3Bh
biBjbGFzcz0iQXBwbGUtdGFiLXNwYW4iIHN0eWxlPSJ3aGl0ZS1zcGFjZTpwcmUiPgk8L3NwYW4+
U05NUF9NSUJfSVRFTSgiTVBGYXN0Y2xvc2VSWCIsIE1QVENQX01JQl9GQVNUQ0xPU0VSWCksPGJy
IGNsYXNzPSIiPis8c3BhbiBjbGFzcz0iQXBwbGUtdGFiLXNwYW4iIHN0eWxlPSJ3aGl0ZS1zcGFj
ZTpwcmUiPgk8L3NwYW4+U05NUF9NSUJfSVRFTSgiTVBGYXN0Y2xvc2VUWCIsIE1QVENQX01JQl9G
QVNUQ0xPU0VUWCksPGJyIGNsYXNzPSIiPis8c3BhbiBjbGFzcz0iQXBwbGUtdGFiLXNwYW4iIHN0
eWxlPSJ3aGl0ZS1zcGFjZTpwcmUiPgk8L3NwYW4+U05NUF9NSUJfSVRFTSgiTVBGYWxsYmFja0Fj
a1N1YiIsIE1QVENQX01JQl9GQkFDS1NVQiksPGJyIGNsYXNzPSIiPis8c3BhbiBjbGFzcz0iQXBw
bGUtdGFiLXNwYW4iIHN0eWxlPSJ3aGl0ZS1zcGFjZTpwcmUiPgk8L3NwYW4+U05NUF9NSUJfSVRF
TSgiTVBGYWxsYmFja0Fja0luaXQiLCBNUFRDUF9NSUJfRkJBQ0tJTklUKSw8YnIgY2xhc3M9IiI+
KzxzcGFuIGNsYXNzPSJBcHBsZS10YWItc3BhbiIgc3R5bGU9IndoaXRlLXNwYWNlOnByZSI+CTwv
c3Bhbj5TTk1QX01JQl9JVEVNKCJNUEZhbGxiYWNrRGF0YVN1YiIsIE1QVENQX01JQl9GQkRBVEFT
VUIpLDxiciBjbGFzcz0iIj4rPHNwYW4gY2xhc3M9IkFwcGxlLXRhYi1zcGFuIiBzdHlsZT0id2hp
dGUtc3BhY2U6cHJlIj4JPC9zcGFuPlNOTVBfTUlCX0lURU0oIk1QRmFsbGJhY2tEYXRhSW5pdCIs
IE1QVENQX01JQl9GQkRBVEFJTklUKSw8YnIgY2xhc3M9IiI+KzxzcGFuIGNsYXNzPSJBcHBsZS10
YWItc3BhbiIgc3R5bGU9IndoaXRlLXNwYWNlOnByZSI+CTwvc3Bhbj5TTk1QX01JQl9JVEVNKCJN
UFJlbW92ZUFkZHJTdWJEZWxldGUiLCBNUFRDUF9NSUJfUkVNQUREUlNVQiksPGJyIGNsYXNzPSIi
Pis8c3BhbiBjbGFzcz0iQXBwbGUtdGFiLXNwYW4iIHN0eWxlPSJ3aGl0ZS1zcGFjZTpwcmUiPgk8
L3NwYW4+U05NUF9NSUJfSVRFTSgiTVBKb2luTm9Ub2tlbkZvdW5kIiwgTVBUQ1BfTUlCX0pPSU5O
T1RPS0VOKSw8YnIgY2xhc3M9IiI+KzxzcGFuIGNsYXNzPSJBcHBsZS10YWItc3BhbiIgc3R5bGU9
IndoaXRlLXNwYWNlOnByZSI+CTwvc3Bhbj5TTk1QX01JQl9JVEVNKCJNUEpvaW5BbHJlYWR5RmFs
bGVuYmFjayIsIE1QVENQX01JQl9KT0lORkFMTEJBQ0spLDxiciBjbGFzcz0iIj4rPHNwYW4gY2xh
c3M9IkFwcGxlLXRhYi1zcGFuIiBzdHlsZT0id2hpdGUtc3BhY2U6cHJlIj4JPC9zcGFuPlNOTVBf
TUlCX0lURU0oIk1QSm9pblN5blR4IiwgTVBUQ1BfTUlCX0pPSU5TWU5UWCksPGJyIGNsYXNzPSIi
Pis8c3BhbiBjbGFzcz0iQXBwbGUtdGFiLXNwYW4iIHN0eWxlPSJ3aGl0ZS1zcGFjZTpwcmUiPgk8
L3NwYW4+U05NUF9NSUJfSVRFTSgiTVBKb2luU3luUngiLCBNUFRDUF9NSUJfSk9JTlNZTlJYKSw8
YnIgY2xhc3M9IiI+KzxzcGFuIGNsYXNzPSJBcHBsZS10YWItc3BhbiIgc3R5bGU9IndoaXRlLXNw
YWNlOnByZSI+CTwvc3Bhbj5TTk1QX01JQl9JVEVNKCJNUEpvaW5TeW5BY2tSeCIsIE1QVENQX01J
Ql9KT0lOU1lOQUNLUlgpLDxiciBjbGFzcz0iIj4rPHNwYW4gY2xhc3M9IkFwcGxlLXRhYi1zcGFu
IiBzdHlsZT0id2hpdGUtc3BhY2U6cHJlIj4JPC9zcGFuPlNOTVBfTUlCX0lURU0oIk1QSm9pblN5
bkFja0hNYWNGYWlsdXJlIiwgTVBUQ1BfTUlCX0pPSU5TWU5BQ0tNQUMpLDxiciBjbGFzcz0iIj4r
PHNwYW4gY2xhc3M9IkFwcGxlLXRhYi1zcGFuIiBzdHlsZT0id2hpdGUtc3BhY2U6cHJlIj4JPC9z
cGFuPlNOTVBfTUlCX0lURU0oIk1QSm9pbkFja1J4IiwgTVBUQ1BfTUlCX0pPSU5BQ0tSWCksPGJy
IGNsYXNzPSIiPis8c3BhbiBjbGFzcz0iQXBwbGUtdGFiLXNwYW4iIHN0eWxlPSJ3aGl0ZS1zcGFj
ZTpwcmUiPgk8L3NwYW4+U05NUF9NSUJfSVRFTSgiTVBKb2luQWNrSE1hY0ZhaWx1cmUiLCBNUFRD
UF9NSUJfSk9JTkFDS01BQyksPGJyIGNsYXNzPSIiPis8c3BhbiBjbGFzcz0iQXBwbGUtdGFiLXNw
YW4iIHN0eWxlPSJ3aGl0ZS1zcGFjZTpwcmUiPgk8L3NwYW4+U05NUF9NSUJfSVRFTSgiTVBKb2lu
QWNrTWlzc2luZyIsIE1QVENQX01JQl9KT0lOQUNLRkFJTCksPGJyIGNsYXNzPSIiPis8c3BhbiBj
bGFzcz0iQXBwbGUtdGFiLXNwYW4iIHN0eWxlPSJ3aGl0ZS1zcGFjZTpwcmUiPgk8L3NwYW4+U05N
UF9NSUJfSVRFTSgiTVBKb2luQWNrUlRPIiwgTVBUQ1BfTUlCX0pPSU5BQ0tSVE8pLDxiciBjbGFz
cz0iIj4rPHNwYW4gY2xhc3M9IkFwcGxlLXRhYi1zcGFuIiBzdHlsZT0id2hpdGUtc3BhY2U6cHJl
Ij4JPC9zcGFuPlNOTVBfTUlCX0lURU0oIk1QSm9pbkFja1JleG1pdCIsIE1QVENQX01JQl9KT0lO
QUNLUlhNSVQpLDxiciBjbGFzcz0iIj4rPHNwYW4gY2xhc3M9IkFwcGxlLXRhYi1zcGFuIiBzdHls
ZT0id2hpdGUtc3BhY2U6cHJlIj4JPC9zcGFuPlNOTVBfTUlCX0lURU0oIk5vRFNTSW5XaW5kb3ci
LCBNUFRDUF9NSUJfTk9EU1NXSU5ET1cpLDxiciBjbGFzcz0iIj4rPHNwYW4gY2xhc3M9IkFwcGxl
LXRhYi1zcGFuIiBzdHlsZT0id2hpdGUtc3BhY2U6cHJlIj4JPC9zcGFuPlNOTVBfTUlCX0lURU0o
IkRTU05vdE1hdGNoaW5nIiwgTVBUQ1BfTUlCX0RTU05PTUFUQ0gpLDxiciBjbGFzcz0iIj4rPHNw
YW4gY2xhc3M9IkFwcGxlLXRhYi1zcGFuIiBzdHlsZT0id2hpdGUtc3BhY2U6cHJlIj4JPC9zcGFu
PlNOTVBfTUlCX0lURU0oIkluZmluaXRlTWFwUngiLCBNUFRDUF9NSUJfSU5GSU5JVEVNQVBSWCks
PGJyIGNsYXNzPSIiPis8c3BhbiBjbGFzcz0iQXBwbGUtdGFiLXNwYW4iIHN0eWxlPSJ3aGl0ZS1z
cGFjZTpwcmUiPgk8L3NwYW4+U05NUF9NSUJfSVRFTSgiRFNTTm9NYXRjaFRDUCIsIE1QVENQX01J
Ql9EU1NUQ1BNSVNNQVRDSCksPGJyIGNsYXNzPSIiPis8c3BhbiBjbGFzcz0iQXBwbGUtdGFiLXNw
YW4iIHN0eWxlPSJ3aGl0ZS1zcGFjZTpwcmUiPgk8L3NwYW4+U05NUF9NSUJfSVRFTSgiRFNTVHJp
bUhlYWQiLCBNUFRDUF9NSUJfRFNTVFJJTUhFQUQpLDxiciBjbGFzcz0iIj4rPHNwYW4gY2xhc3M9
IkFwcGxlLXRhYi1zcGFuIiBzdHlsZT0id2hpdGUtc3BhY2U6cHJlIj4JPC9zcGFuPlNOTVBfTUlC
X0lURU0oIkRTU1NwbGl0VGFpbCIsIE1QVENQX01JQl9EU1NTUExJVFRBSUwpLDxiciBjbGFzcz0i
Ij4rPHNwYW4gY2xhc3M9IkFwcGxlLXRhYi1zcGFuIiBzdHlsZT0id2hpdGUtc3BhY2U6cHJlIj4J
PC9zcGFuPlNOTVBfTUlCX0lURU0oIkRTU1B1cmdlT2xkU3ViU2VncyIsIE1QVENQX01JQl9QVVJH
RU9MRCksPGJyIGNsYXNzPSIiPis8c3BhbiBjbGFzcz0iQXBwbGUtdGFiLXNwYW4iIHN0eWxlPSJ3
aGl0ZS1zcGFjZTpwcmUiPgk8L3NwYW4+U05NUF9NSUJfSVRFTSgiQWRkQWRkclJ4IiwgTVBUQ1Bf
TUlCX0FEREFERFJSWCksPGJyIGNsYXNzPSIiPis8c3BhbiBjbGFzcz0iQXBwbGUtdGFiLXNwYW4i
IHN0eWxlPSJ3aGl0ZS1zcGFjZTpwcmUiPgk8L3NwYW4+U05NUF9NSUJfSVRFTSgiQWRkQWRkclR4
IiwgTVBUQ1BfTUlCX0FEREFERFJUWCksPGJyIGNsYXNzPSIiPis8c3BhbiBjbGFzcz0iQXBwbGUt
dGFiLXNwYW4iIHN0eWxlPSJ3aGl0ZS1zcGFjZTpwcmUiPgk8L3NwYW4+U05NUF9NSUJfSVRFTSgi
UmVtQWRkclJ4IiwgTVBUQ1BfTUlCX1JFTUFERFJSWCksPGJyIGNsYXNzPSIiPis8c3BhbiBjbGFz
cz0iQXBwbGUtdGFiLXNwYW4iIHN0eWxlPSJ3aGl0ZS1zcGFjZTpwcmUiPgk8L3NwYW4+U05NUF9N
SUJfSVRFTSgiUmVtQWRkclR4IiwgTVBUQ1BfTUlCX1JFTUFERFJUWCksPC9kaXY+PC9kaXY+PC9i
bG9ja3F1b3RlPjxkaXY+PGJyIGNsYXNzPSIiPjwvZGl2PjxkaXY+SSB0aGluayB0aGVzZSBhcmUg
cm91Z2hseSB3aGF0IHdlIGhhdmUgaW4gPGEgaHJlZj0iaHR0cDovL211bHRpcGF0aC10Y3Aub3Jn
IiBjbGFzcz0iIj5tdWx0aXBhdGgtdGNwLm9yZzwvYT4uPC9kaXY+PGRpdj5BbmQgSSB0aGluayB0
aGV5IGFyZSBhIGJpdCB0b28gZXh0ZW5zaXZlIChJIGp1c3QgYWRkZWQgd2hhdGV2ZXIgSSBjb3Vs
ZCB0aGluayBvZiBpbiA8YSBocmVmPSJodHRwOi8vbXVsdGlwYXRoLXRjcC5vcmciIGNsYXNzPSIi
Pm11bHRpcGF0aC10Y3Aub3JnPC9hPiZuYnNwOzstKSApLiBMaWtlLCBBRERBRERSVFgvUlgsLi4u
IEpvaW5TeW5UWCAod2lsbCBiZSBzdGVlcmVkIGJ5IHRoZSB1c2VyLXNwYWNlIHBhdGgtbWFuYWdl
ciksLi4uPC9kaXY+PGRpdj48YnIgY2xhc3M9IiI+PC9kaXY+PGRpdj5XZSBhcmUgbm90IHJlYWxs
eSBsb29raW5nIGF0IHRoZW0gdGhhdCBtdWNoLiBJdCdzIG1vcmUgYWJvdXQgdGhlIGVycm9yLWNv
bmRpdGlvbnMgdGhhdCBhcmUgaW50ZXJlc3RpbmcgaW4gcmF0aW8gd2l0aCB0aGUgbnVtYmVyIG9m
IGVzdGFibGlzaGVkIGNvbm5lY3Rpb25zLiBGb3IgZXhhbXBsZSwgTVBUQ1BfTUlCX0pPSU5OT1RP
S0VOIGlzIHZlcnkgdXNlZnVsIGJlY2F1c2UgaXQgaXMgYW4gaW5kaWNhdG9yIHRoYXQgdGhlIHN1
YmZsb3ctc3RlZXJpbmcgYmVoaW5kIHRoZSBsb2FkYmFsYW5jZXIgaXMgbm90IHdvcmtpbmcgY29y
cmVjdGx5LjwvZGl2PjxkaXY+PGJyIGNsYXNzPSIiPjwvZGl2PjxkaXY+TWF5YmUgd2Ugc3RhcnQg
d2l0aCB0aGUgbW9zdCBtaW5pbWFsIHNldCBvZiBjb3VudGVycyBhbmQgY2FuIGFkZCBsYXRlciBv
biBhcyBtb3JlIG9wcy1leHBlcmllbmNlIGlzIGJlaW5nIGdhdGhlcmVkPzwvZGl2PjxiciBjbGFz
cz0iIj48YmxvY2txdW90ZSB0eXBlPSJjaXRlIiBjbGFzcz0iIj48ZGl2IGNsYXNzPSIiPjxkaXYg
Y2xhc3M9IiI+KzxzcGFuIGNsYXNzPSJBcHBsZS10YWItc3BhbiIgc3R5bGU9IndoaXRlLXNwYWNl
OnByZSI+CTwvc3Bhbj5TTk1QX01JQl9TRU5USU5FTDxiciBjbGFzcz0iIj4rfTs8YnIgY2xhc3M9
IiI+PC9kaXY+PC9kaXY+PC9ibG9ja3F1b3RlPjxkaXY+PGJyIGNsYXNzPSIiPjwvZGl2PjxkaXY+
QSB2ZXJ5IHVzZWZ1bCBNSUIgaXMgYSBjb3VudGVyIGZvciB0aGUgY3VycmVudGx5IGVzdGFibGlz
aGVkIE1QVENQLWNvbm5lY3Rpb25zLCBhbmQgTVBUQ1Atc3ViZmxvd3MgKHNpbWlsYXIgdG8gd2hh
dCBUQ1Agb2ZmZXJzIHdpdGggVENQX01JQl9DVVJSRVNUQUIpLjwvZGl2PjxkaXY+PGJyIGNsYXNz
PSIiPjwvZGl2PjxkaXY+PGJyIGNsYXNzPSIiPjwvZGl2PjxkaXY+Q2hyaXN0b3BoPC9kaXY+PGJy
IGNsYXNzPSIiPjxibG9ja3F1b3RlIHR5cGU9ImNpdGUiIGNsYXNzPSIiPjxkaXYgY2xhc3M9IiI+
PGRpdiBjbGFzcz0iIj4rPGJyIGNsYXNzPSIiPisvKiBtcHRjcF9taWJfYWxsb2MgLSBhbGxvY2F0
ZSBwZXJjcHUgbWliIGNvdW50ZXJzPGJyIGNsYXNzPSIiPisgKjxiciBjbGFzcz0iIj4rICogVGhl
c2UgYXJlIGFsbG9jYXRlZCB3aGVuIHRoZSBmaXJzdCBtcHRjcCBzb2NrZXQgaXMgY3JlYXRlZCBz
bzxiciBjbGFzcz0iIj4rICogd2UgZG8gbm90IHdhc3RlIHBlcmNwdSBtZW1vcnkgaWYgbXB0Y3Ag
aXNuJ3QgaW4gdXNlLjxiciBjbGFzcz0iIj4rICovPGJyIGNsYXNzPSIiPitib29sIG1wdGNwX21p
Yl9hbGxvYyhzdHJ1Y3QgbmV0ICpuZXQpPGJyIGNsYXNzPSIiPit7PGJyIGNsYXNzPSIiPis8c3Bh
biBjbGFzcz0iQXBwbGUtdGFiLXNwYW4iIHN0eWxlPSJ3aGl0ZS1zcGFjZTpwcmUiPgk8L3NwYW4+
c3RydWN0IG1wdGNwX21pYiAqbWliID0gYWxsb2NfcGVyY3B1KHN0cnVjdCBtcHRjcF9taWIpOzxi
ciBjbGFzcz0iIj4rPGJyIGNsYXNzPSIiPis8c3BhbiBjbGFzcz0iQXBwbGUtdGFiLXNwYW4iIHN0
eWxlPSJ3aGl0ZS1zcGFjZTpwcmUiPgk8L3NwYW4+aWYgKCFtaWIpPGJyIGNsYXNzPSIiPis8c3Bh
biBjbGFzcz0iQXBwbGUtdGFiLXNwYW4iIHN0eWxlPSJ3aGl0ZS1zcGFjZTpwcmUiPgk8L3NwYW4+
PHNwYW4gY2xhc3M9IkFwcGxlLXRhYi1zcGFuIiBzdHlsZT0id2hpdGUtc3BhY2U6cHJlIj4JPC9z
cGFuPnJldHVybiBmYWxzZTs8YnIgY2xhc3M9IiI+KzxiciBjbGFzcz0iIj4rPHNwYW4gY2xhc3M9
IkFwcGxlLXRhYi1zcGFuIiBzdHlsZT0id2hpdGUtc3BhY2U6cHJlIj4JPC9zcGFuPmlmIChjbXB4
Y2hnKCZhbXA7bmV0LSZndDttaWIubXB0Y3Bfc3RhdGlzdGljcywgTlVMTCwgbWliKSk8YnIgY2xh
c3M9IiI+KzxzcGFuIGNsYXNzPSJBcHBsZS10YWItc3BhbiIgc3R5bGU9IndoaXRlLXNwYWNlOnBy
ZSI+CTwvc3Bhbj48c3BhbiBjbGFzcz0iQXBwbGUtdGFiLXNwYW4iIHN0eWxlPSJ3aGl0ZS1zcGFj
ZTpwcmUiPgk8L3NwYW4+ZnJlZV9wZXJjcHUobWliKTs8YnIgY2xhc3M9IiI+KzxiciBjbGFzcz0i
Ij4rPHNwYW4gY2xhc3M9IkFwcGxlLXRhYi1zcGFuIiBzdHlsZT0id2hpdGUtc3BhY2U6cHJlIj4J
PC9zcGFuPnJldHVybiB0cnVlOzxiciBjbGFzcz0iIj4rfTxiciBjbGFzcz0iIj4rPGJyIGNsYXNz
PSIiPit2b2lkIG1wdGNwX3NlcV9zaG93KHN0cnVjdCBzZXFfZmlsZSAqc2VxKTxiciBjbGFzcz0i
Ij4rezxiciBjbGFzcz0iIj4rPHNwYW4gY2xhc3M9IkFwcGxlLXRhYi1zcGFuIiBzdHlsZT0id2hp
dGUtc3BhY2U6cHJlIj4JPC9zcGFuPnN0cnVjdCBuZXQgKm5ldCA9IHNlcS0mZ3Q7cHJpdmF0ZTs8
YnIgY2xhc3M9IiI+KzxzcGFuIGNsYXNzPSJBcHBsZS10YWItc3BhbiIgc3R5bGU9IndoaXRlLXNw
YWNlOnByZSI+CTwvc3Bhbj5pbnQgaTs8YnIgY2xhc3M9IiI+KzxiciBjbGFzcz0iIj4rPHNwYW4g
Y2xhc3M9IkFwcGxlLXRhYi1zcGFuIiBzdHlsZT0id2hpdGUtc3BhY2U6cHJlIj4JPC9zcGFuPnNl
cV9wdXRzKHNlcSwgIk1QVGNwRXh0OiIpOzxiciBjbGFzcz0iIj4rPHNwYW4gY2xhc3M9IkFwcGxl
LXRhYi1zcGFuIiBzdHlsZT0id2hpdGUtc3BhY2U6cHJlIj4JPC9zcGFuPmZvciAoaSA9IDA7IG1w
dGNwX3NubXBfbGlzdFtpXS5uYW1lOyBpKyspPGJyIGNsYXNzPSIiPis8c3BhbiBjbGFzcz0iQXBw
bGUtdGFiLXNwYW4iIHN0eWxlPSJ3aGl0ZS1zcGFjZTpwcmUiPgk8L3NwYW4+PHNwYW4gY2xhc3M9
IkFwcGxlLXRhYi1zcGFuIiBzdHlsZT0id2hpdGUtc3BhY2U6cHJlIj4JPC9zcGFuPnNlcV9wcmlu
dGYoc2VxLCAiICVzIiwgbXB0Y3Bfc25tcF9saXN0W2ldLm5hbWUpOzxiciBjbGFzcz0iIj4rPGJy
IGNsYXNzPSIiPis8c3BhbiBjbGFzcz0iQXBwbGUtdGFiLXNwYW4iIHN0eWxlPSJ3aGl0ZS1zcGFj
ZTpwcmUiPgk8L3NwYW4+c2VxX3B1dHMoc2VxLCAiXG5NUFRjcEV4dDoiKTs8YnIgY2xhc3M9IiI+
KzxiciBjbGFzcz0iIj4rPHNwYW4gY2xhc3M9IkFwcGxlLXRhYi1zcGFuIiBzdHlsZT0id2hpdGUt
c3BhY2U6cHJlIj4JPC9zcGFuPmlmICghbmV0LSZndDttaWIubXB0Y3Bfc3RhdGlzdGljcykgezxi
ciBjbGFzcz0iIj4rPHNwYW4gY2xhc3M9IkFwcGxlLXRhYi1zcGFuIiBzdHlsZT0id2hpdGUtc3Bh
Y2U6cHJlIj4JPC9zcGFuPjxzcGFuIGNsYXNzPSJBcHBsZS10YWItc3BhbiIgc3R5bGU9IndoaXRl
LXNwYWNlOnByZSI+CTwvc3Bhbj5mb3IgKGkgPSAwOyBtcHRjcF9zbm1wX2xpc3RbaV0ubmFtZTsg
aSsrKTxiciBjbGFzcz0iIj4rPHNwYW4gY2xhc3M9IkFwcGxlLXRhYi1zcGFuIiBzdHlsZT0id2hp
dGUtc3BhY2U6cHJlIj4JPC9zcGFuPjxzcGFuIGNsYXNzPSJBcHBsZS10YWItc3BhbiIgc3R5bGU9
IndoaXRlLXNwYWNlOnByZSI+CTwvc3Bhbj48c3BhbiBjbGFzcz0iQXBwbGUtdGFiLXNwYW4iIHN0
eWxlPSJ3aGl0ZS1zcGFjZTpwcmUiPgk8L3NwYW4+c2VxX3ByaW50ZihzZXEsICIgJWx1IiwgMHVs
KTs8YnIgY2xhc3M9IiI+KzxiciBjbGFzcz0iIj4rPHNwYW4gY2xhc3M9IkFwcGxlLXRhYi1zcGFu
IiBzdHlsZT0id2hpdGUtc3BhY2U6cHJlIj4JPC9zcGFuPjxzcGFuIGNsYXNzPSJBcHBsZS10YWIt
c3BhbiIgc3R5bGU9IndoaXRlLXNwYWNlOnByZSI+CTwvc3Bhbj5yZXR1cm47PGJyIGNsYXNzPSIi
Pis8c3BhbiBjbGFzcz0iQXBwbGUtdGFiLXNwYW4iIHN0eWxlPSJ3aGl0ZS1zcGFjZTpwcmUiPgk8
L3NwYW4+fTxiciBjbGFzcz0iIj4rPGJyIGNsYXNzPSIiPis8c3BhbiBjbGFzcz0iQXBwbGUtdGFi
LXNwYW4iIHN0eWxlPSJ3aGl0ZS1zcGFjZTpwcmUiPgk8L3NwYW4+Zm9yIChpID0gMDsgbXB0Y3Bf
c25tcF9saXN0W2ldLm5hbWU7IGkrKyk8YnIgY2xhc3M9IiI+KzxzcGFuIGNsYXNzPSJBcHBsZS10
YWItc3BhbiIgc3R5bGU9IndoaXRlLXNwYWNlOnByZSI+CTwvc3Bhbj48c3BhbiBjbGFzcz0iQXBw
bGUtdGFiLXNwYW4iIHN0eWxlPSJ3aGl0ZS1zcGFjZTpwcmUiPgk8L3NwYW4+c2VxX3ByaW50Zihz
ZXEsICIgJWx1Iiw8YnIgY2xhc3M9IiI+KzxzcGFuIGNsYXNzPSJBcHBsZS10YWItc3BhbiIgc3R5
bGU9IndoaXRlLXNwYWNlOnByZSI+CTwvc3Bhbj48c3BhbiBjbGFzcz0iQXBwbGUtdGFiLXNwYW4i
IHN0eWxlPSJ3aGl0ZS1zcGFjZTpwcmUiPgk8L3NwYW4+PHNwYW4gY2xhc3M9IkFwcGxlLXRhYi1z
cGFuIiBzdHlsZT0id2hpdGUtc3BhY2U6cHJlIj4JPC9zcGFuPiAmbmJzcDsmbmJzcDtzbm1wX2Zv
bGRfZmllbGQobmV0LSZndDttaWIubXB0Y3Bfc3RhdGlzdGljcyw8YnIgY2xhc3M9IiI+KzxzcGFu
IGNsYXNzPSJBcHBsZS10YWItc3BhbiIgc3R5bGU9IndoaXRlLXNwYWNlOnByZSI+CTwvc3Bhbj48
c3BhbiBjbGFzcz0iQXBwbGUtdGFiLXNwYW4iIHN0eWxlPSJ3aGl0ZS1zcGFjZTpwcmUiPgk8L3Nw
YW4+PHNwYW4gY2xhc3M9IkFwcGxlLXRhYi1zcGFuIiBzdHlsZT0id2hpdGUtc3BhY2U6cHJlIj4J
PC9zcGFuPjxzcGFuIGNsYXNzPSJBcHBsZS10YWItc3BhbiIgc3R5bGU9IndoaXRlLXNwYWNlOnBy
ZSI+CTwvc3Bhbj48c3BhbiBjbGFzcz0iQXBwbGUtdGFiLXNwYW4iIHN0eWxlPSJ3aGl0ZS1zcGFj
ZTpwcmUiPgk8L3NwYW4+ICZuYnNwOyZuYnNwO21wdGNwX3NubXBfbGlzdFtpXS5lbnRyeSkpOzxi
ciBjbGFzcz0iIj4rPHNwYW4gY2xhc3M9IkFwcGxlLXRhYi1zcGFuIiBzdHlsZT0id2hpdGUtc3Bh
Y2U6cHJlIj4JPC9zcGFuPnNlcV9wdXRjKHNlcSwgJ1xuJyk7PGJyIGNsYXNzPSIiPit9PGJyIGNs
YXNzPSIiPmRpZmYgLS1naXQgYS9uZXQvbXB0Y3AvbWliLmggYi9uZXQvbXB0Y3AvbWliLmg8YnIg
Y2xhc3M9IiI+bmV3IGZpbGUgbW9kZSAxMDA2NDQ8YnIgY2xhc3M9IiI+aW5kZXggMDAwMDAwMDAw
MDAwLi5jMjRjNDFkYzMzMGM8YnIgY2xhc3M9IiI+LS0tIC9kZXYvbnVsbDxiciBjbGFzcz0iIj4r
KysgYi9uZXQvbXB0Y3AvbWliLmg8YnIgY2xhc3M9IiI+QEAgLTAsMCArMSw2NyBAQDxiciBjbGFz
cz0iIj4rLyogU1BEWC1MaWNlbnNlLUlkZW50aWZpZXI6IEdQTC0yLjAtb3ItbGF0ZXIgKi88YnIg
Y2xhc3M9IiI+KzxiciBjbGFzcz0iIj4rZW51bSBsaW51eF9tcHRjcF9taWJfZmllbGQgezxiciBj
bGFzcz0iIj4rPHNwYW4gY2xhc3M9IkFwcGxlLXRhYi1zcGFuIiBzdHlsZT0id2hpdGUtc3BhY2U6
cHJlIj4JPC9zcGFuPk1QVENQX01JQl9OVU0gPSAwLDxiciBjbGFzcz0iIj4rPHNwYW4gY2xhc3M9
IkFwcGxlLXRhYi1zcGFuIiBzdHlsZT0id2hpdGUtc3BhY2U6cHJlIj4JPC9zcGFuPk1QVENQX01J
Ql9NUENBUEFCTEVQQVNTSVZFLDxzcGFuIGNsYXNzPSJBcHBsZS10YWItc3BhbiIgc3R5bGU9Indo
aXRlLXNwYWNlOnByZSI+CTwvc3Bhbj4vKiBSZWNlaXZlZCBTWU4gd2l0aCBNUF9DQVBBQkxFICov
PGJyIGNsYXNzPSIiPis8c3BhbiBjbGFzcz0iQXBwbGUtdGFiLXNwYW4iIHN0eWxlPSJ3aGl0ZS1z
cGFjZTpwcmUiPgk8L3NwYW4+TVBUQ1BfTUlCX01QQ0FQQUJMRUFDVElWRSw8c3BhbiBjbGFzcz0i
QXBwbGUtdGFiLXNwYW4iIHN0eWxlPSJ3aGl0ZS1zcGFjZTpwcmUiPgk8L3NwYW4+LyogU2VudCBT
WU4gd2l0aCBNUF9DQVBBQkxFICovPGJyIGNsYXNzPSIiPis8c3BhbiBjbGFzcz0iQXBwbGUtdGFi
LXNwYW4iIHN0eWxlPSJ3aGl0ZS1zcGFjZTpwcmUiPgk8L3NwYW4+TVBUQ1BfTUlCX01QQ0FQQUJM
RUFDVElWRUFDSyw8c3BhbiBjbGFzcz0iQXBwbGUtdGFiLXNwYW4iIHN0eWxlPSJ3aGl0ZS1zcGFj
ZTpwcmUiPgk8L3NwYW4+LyogUmVjZWl2ZWQgU1lOL0FDSyB3aXRoIE1QX0NBUEFCTEUgKi88YnIg
Y2xhc3M9IiI+KzxzcGFuIGNsYXNzPSJBcHBsZS10YWItc3BhbiIgc3R5bGU9IndoaXRlLXNwYWNl
OnByZSI+CTwvc3Bhbj5NUFRDUF9NSUJfTVBDQVBBQkxFUEFTU0lWRUFDSyw8c3BhbiBjbGFzcz0i
QXBwbGUtdGFiLXNwYW4iIHN0eWxlPSJ3aGl0ZS1zcGFjZTpwcmUiPgk8L3NwYW4+LyogUmVjZWl2
ZWQgdGhpcmQgQUNLIHdpdGggTVBfQ0FQQUJMRSAqLzxiciBjbGFzcz0iIj4rPHNwYW4gY2xhc3M9
IkFwcGxlLXRhYi1zcGFuIiBzdHlsZT0id2hpdGUtc3BhY2U6cHJlIj4JPC9zcGFuPk1QVENQX01J
Ql9NUENBUEFCTEVQQVNTSVZFRkFMTEJBQ0ssLyogU2VydmVyLXNpZGUgZmFsbGJhY2sgZHVyaW5n
IDMtd2F5IGhhbmRzaGFrZSAqLzxiciBjbGFzcz0iIj4rPHNwYW4gY2xhc3M9IkFwcGxlLXRhYi1z
cGFuIiBzdHlsZT0id2hpdGUtc3BhY2U6cHJlIj4JPC9zcGFuPk1QVENQX01JQl9NUENBUEFCTEVB
Q1RJVkVGQUxMQkFDSywgLyogQ2xpZW50LXNpZGUgZmFsbGJhY2sgZHVyaW5nIDMtd2F5IGhhbmRz
aGFrZSAqLzxiciBjbGFzcz0iIj4rPHNwYW4gY2xhc3M9IkFwcGxlLXRhYi1zcGFuIiBzdHlsZT0i
d2hpdGUtc3BhY2U6cHJlIj4JPC9zcGFuPk1QVENQX01JQl9NUENBUEFCTEVSRVRSQU5TRkFMTEJB
Q0ssLyogQ2xpZW50LXNpZGUgc3RvcHBlZCBzZW5kaW5nIE1QX0NBUEFCTEUgYWZ0ZXIgdG9vIG1h
bnkgU1lOLXJldHJhbnNtaXNzaW9ucyAqLzxiciBjbGFzcz0iIj4rPHNwYW4gY2xhc3M9IkFwcGxl
LXRhYi1zcGFuIiBzdHlsZT0id2hpdGUtc3BhY2U6cHJlIj4JPC9zcGFuPk1QVENQX01JQl9DU1VN
RU5BQkxFRCw8c3BhbiBjbGFzcz0iQXBwbGUtdGFiLXNwYW4iIHN0eWxlPSJ3aGl0ZS1zcGFjZTpw
cmUiPgk8L3NwYW4+PHNwYW4gY2xhc3M9IkFwcGxlLXRhYi1zcGFuIiBzdHlsZT0id2hpdGUtc3Bh
Y2U6cHJlIj4JPC9zcGFuPi8qIENyZWF0ZWQgTVBUQ1AtY29ubmVjdGlvbiB3aXRoIERTUy1jaGVj
a3N1bSBlbmFibGVkICovPGJyIGNsYXNzPSIiPis8c3BhbiBjbGFzcz0iQXBwbGUtdGFiLXNwYW4i
IHN0eWxlPSJ3aGl0ZS1zcGFjZTpwcmUiPgk8L3NwYW4+TVBUQ1BfTUlCX1JFVFJBTlNTRUdTLDxz
cGFuIGNsYXNzPSJBcHBsZS10YWItc3BhbiIgc3R5bGU9IndoaXRlLXNwYWNlOnByZSI+CTwvc3Bh
bj48c3BhbiBjbGFzcz0iQXBwbGUtdGFiLXNwYW4iIHN0eWxlPSJ3aGl0ZS1zcGFjZTpwcmUiPgk8
L3NwYW4+LyogU2VnbWVudHMgcmV0cmFuc21pdHRlZCBhdCB0aGUgTVBUQ1AtbGV2ZWwgKi88YnIg
Y2xhc3M9IiI+KzxzcGFuIGNsYXNzPSJBcHBsZS10YWItc3BhbiIgc3R5bGU9IndoaXRlLXNwYWNl
OnByZSI+CTwvc3Bhbj5NUFRDUF9NSUJfTVBGQUlMUlgsPHNwYW4gY2xhc3M9IkFwcGxlLXRhYi1z
cGFuIiBzdHlsZT0id2hpdGUtc3BhY2U6cHJlIj4JPC9zcGFuPjxzcGFuIGNsYXNzPSJBcHBsZS10
YWItc3BhbiIgc3R5bGU9IndoaXRlLXNwYWNlOnByZSI+CTwvc3Bhbj4vKiBSZWNlaXZlZCBhbiBN
UF9GQUlMICovPGJyIGNsYXNzPSIiPis8c3BhbiBjbGFzcz0iQXBwbGUtdGFiLXNwYW4iIHN0eWxl
PSJ3aGl0ZS1zcGFjZTpwcmUiPgk8L3NwYW4+TVBUQ1BfTUlCX0NTVU1GQUlMLDxzcGFuIGNsYXNz
PSJBcHBsZS10YWItc3BhbiIgc3R5bGU9IndoaXRlLXNwYWNlOnByZSI+CTwvc3Bhbj48c3BhbiBj
bGFzcz0iQXBwbGUtdGFiLXNwYW4iIHN0eWxlPSJ3aGl0ZS1zcGFjZTpwcmUiPgk8L3NwYW4+Lyog
UmVjZWl2ZWQgc2VnbWVudCB3aXRoIGludmFsaWQgY2hlY2tzdW0gKi88YnIgY2xhc3M9IiI+Kzxz
cGFuIGNsYXNzPSJBcHBsZS10YWItc3BhbiIgc3R5bGU9IndoaXRlLXNwYWNlOnByZSI+CTwvc3Bh
bj5NUFRDUF9NSUJfRkFTVENMT1NFUlgsPHNwYW4gY2xhc3M9IkFwcGxlLXRhYi1zcGFuIiBzdHls
ZT0id2hpdGUtc3BhY2U6cHJlIj4JPC9zcGFuPjxzcGFuIGNsYXNzPSJBcHBsZS10YWItc3BhbiIg
c3R5bGU9IndoaXRlLXNwYWNlOnByZSI+CTwvc3Bhbj4vKiBSZWNldmllZCBhIEZBU1RfQ0xPU0Ug
Ki88YnIgY2xhc3M9IiI+KzxzcGFuIGNsYXNzPSJBcHBsZS10YWItc3BhbiIgc3R5bGU9IndoaXRl
LXNwYWNlOnByZSI+CTwvc3Bhbj5NUFRDUF9NSUJfRkFTVENMT1NFVFgsPHNwYW4gY2xhc3M9IkFw
cGxlLXRhYi1zcGFuIiBzdHlsZT0id2hpdGUtc3BhY2U6cHJlIj4JPC9zcGFuPjxzcGFuIGNsYXNz
PSJBcHBsZS10YWItc3BhbiIgc3R5bGU9IndoaXRlLXNwYWNlOnByZSI+CTwvc3Bhbj4vKiBTZW50
IGEgRkFTVF9DTE9TRSAqLzxiciBjbGFzcz0iIj4rPHNwYW4gY2xhc3M9IkFwcGxlLXRhYi1zcGFu
IiBzdHlsZT0id2hpdGUtc3BhY2U6cHJlIj4JPC9zcGFuPk1QVENQX01JQl9GQkFDS1NVQiw8c3Bh
biBjbGFzcz0iQXBwbGUtdGFiLXNwYW4iIHN0eWxlPSJ3aGl0ZS1zcGFjZTpwcmUiPgk8L3NwYW4+
PHNwYW4gY2xhc3M9IkFwcGxlLXRhYi1zcGFuIiBzdHlsZT0id2hpdGUtc3BhY2U6cHJlIj4JPC9z
cGFuPi8qIEZhbGxiYWNrIHVwb24gYWNrIHdpdGhvdXQgZGF0YS1hY2sgb24gbmV3IHN1YmZsb3cg
Ki88YnIgY2xhc3M9IiI+KzxzcGFuIGNsYXNzPSJBcHBsZS10YWItc3BhbiIgc3R5bGU9IndoaXRl
LXNwYWNlOnByZSI+CTwvc3Bhbj5NUFRDUF9NSUJfRkJBQ0tJTklULDxzcGFuIGNsYXNzPSJBcHBs
ZS10YWItc3BhbiIgc3R5bGU9IndoaXRlLXNwYWNlOnByZSI+CTwvc3Bhbj48c3BhbiBjbGFzcz0i
QXBwbGUtdGFiLXNwYW4iIHN0eWxlPSJ3aGl0ZS1zcGFjZTpwcmUiPgk8L3NwYW4+LyogRmFsbGJh
Y2sgdXBvbiBhY2sgd2l0aG91dCBkYXRhLWFjayBvbiBpbml0aWFsIHN1YmZsb3cgKi88YnIgY2xh
c3M9IiI+KzxzcGFuIGNsYXNzPSJBcHBsZS10YWItc3BhbiIgc3R5bGU9IndoaXRlLXNwYWNlOnBy
ZSI+CTwvc3Bhbj5NUFRDUF9NSUJfRkJEQVRBU1VCLDxzcGFuIGNsYXNzPSJBcHBsZS10YWItc3Bh
biIgc3R5bGU9IndoaXRlLXNwYWNlOnByZSI+CTwvc3Bhbj48c3BhbiBjbGFzcz0iQXBwbGUtdGFi
LXNwYW4iIHN0eWxlPSJ3aGl0ZS1zcGFjZTpwcmUiPgk8L3NwYW4+LyogRmFsbGJhY2sgdXBvbiBk
YXRhIHdpdGhvdXQgRFNTIGF0IHRoZSBiZWdpbm5pbmcgb24gbmV3IHN1YmZsb3cgKi88YnIgY2xh
c3M9IiI+KzxzcGFuIGNsYXNzPSJBcHBsZS10YWItc3BhbiIgc3R5bGU9IndoaXRlLXNwYWNlOnBy
ZSI+CTwvc3Bhbj5NUFRDUF9NSUJfRkJEQVRBSU5JVCw8c3BhbiBjbGFzcz0iQXBwbGUtdGFiLXNw
YW4iIHN0eWxlPSJ3aGl0ZS1zcGFjZTpwcmUiPgk8L3NwYW4+PHNwYW4gY2xhc3M9IkFwcGxlLXRh
Yi1zcGFuIiBzdHlsZT0id2hpdGUtc3BhY2U6cHJlIj4JPC9zcGFuPi8qIEZhbGxiYWNrIHVwb24g
ZGF0YSB3aXRob3V0IERTUyBhdCB0aGUgYmVnaW5uaW5nIG9uIGluaXRpYWwgc3ViZmxvdyAqLzxi
ciBjbGFzcz0iIj4rPHNwYW4gY2xhc3M9IkFwcGxlLXRhYi1zcGFuIiBzdHlsZT0id2hpdGUtc3Bh
Y2U6cHJlIj4JPC9zcGFuPk1QVENQX01JQl9SRU1BRERSU1VCLDxzcGFuIGNsYXNzPSJBcHBsZS10
YWItc3BhbiIgc3R5bGU9IndoaXRlLXNwYWNlOnByZSI+CTwvc3Bhbj48c3BhbiBjbGFzcz0iQXBw
bGUtdGFiLXNwYW4iIHN0eWxlPSJ3aGl0ZS1zcGFjZTpwcmUiPgk8L3NwYW4+LyogUmVtb3ZlIHN1
YmZsb3cgZHVlIHRvIFJFTU9WRV9BRERSICovPGJyIGNsYXNzPSIiPis8c3BhbiBjbGFzcz0iQXBw
bGUtdGFiLXNwYW4iIHN0eWxlPSJ3aGl0ZS1zcGFjZTpwcmUiPgk8L3NwYW4+TVBUQ1BfTUlCX0pP
SU5OT1RPS0VOLDxzcGFuIGNsYXNzPSJBcHBsZS10YWItc3BhbiIgc3R5bGU9IndoaXRlLXNwYWNl
OnByZSI+CTwvc3Bhbj48c3BhbiBjbGFzcz0iQXBwbGUtdGFiLXNwYW4iIHN0eWxlPSJ3aGl0ZS1z
cGFjZTpwcmUiPgk8L3NwYW4+LyogUmVjZWl2ZWQgTVBfSk9JTiBidXQgdGhlIHRva2VuIHdhcyBu
b3QgZm91bmQgKi88YnIgY2xhc3M9IiI+KzxzcGFuIGNsYXNzPSJBcHBsZS10YWItc3BhbiIgc3R5
bGU9IndoaXRlLXNwYWNlOnByZSI+CTwvc3Bhbj5NUFRDUF9NSUJfSk9JTkZBTExCQUNLLDxzcGFu
IGNsYXNzPSJBcHBsZS10YWItc3BhbiIgc3R5bGU9IndoaXRlLXNwYWNlOnByZSI+CTwvc3Bhbj48
c3BhbiBjbGFzcz0iQXBwbGUtdGFiLXNwYW4iIHN0eWxlPSJ3aGl0ZS1zcGFjZTpwcmUiPgk8L3Nw
YW4+LyogUmVjZWl2ZWQgTVBfSk9JTiBvbiBzZXNzaW9uIHRoYXQgaGFzIGZhbGxlbiBiYWNrIHRv
IHJlZy4gVENQICovPGJyIGNsYXNzPSIiPis8c3BhbiBjbGFzcz0iQXBwbGUtdGFiLXNwYW4iIHN0
eWxlPSJ3aGl0ZS1zcGFjZTpwcmUiPgk8L3NwYW4+TVBUQ1BfTUlCX0pPSU5TWU5UWCw8c3BhbiBj
bGFzcz0iQXBwbGUtdGFiLXNwYW4iIHN0eWxlPSJ3aGl0ZS1zcGFjZTpwcmUiPgk8L3NwYW4+PHNw
YW4gY2xhc3M9IkFwcGxlLXRhYi1zcGFuIiBzdHlsZT0id2hpdGUtc3BhY2U6cHJlIj4JPC9zcGFu
Pi8qIFNlbnQgYSBTWU4gKyBNUF9KT0lOICovPGJyIGNsYXNzPSIiPis8c3BhbiBjbGFzcz0iQXBw
bGUtdGFiLXNwYW4iIHN0eWxlPSJ3aGl0ZS1zcGFjZTpwcmUiPgk8L3NwYW4+TVBUQ1BfTUlCX0pP
SU5TWU5SWCw8c3BhbiBjbGFzcz0iQXBwbGUtdGFiLXNwYW4iIHN0eWxlPSJ3aGl0ZS1zcGFjZTpw
cmUiPgk8L3NwYW4+PHNwYW4gY2xhc3M9IkFwcGxlLXRhYi1zcGFuIiBzdHlsZT0id2hpdGUtc3Bh
Y2U6cHJlIj4JPC9zcGFuPi8qIFJlY2VpdmVkIGEgU1lOICsgTVBfSk9JTiAqLzxiciBjbGFzcz0i
Ij4rPHNwYW4gY2xhc3M9IkFwcGxlLXRhYi1zcGFuIiBzdHlsZT0id2hpdGUtc3BhY2U6cHJlIj4J
PC9zcGFuPk1QVENQX01JQl9KT0lOU1lOQUNLUlgsPHNwYW4gY2xhc3M9IkFwcGxlLXRhYi1zcGFu
IiBzdHlsZT0id2hpdGUtc3BhY2U6cHJlIj4JPC9zcGFuPjxzcGFuIGNsYXNzPSJBcHBsZS10YWIt
c3BhbiIgc3R5bGU9IndoaXRlLXNwYWNlOnByZSI+CTwvc3Bhbj4vKiBSZWNlaXZlZCBhIFNZTi9B
Q0sgKyBNUF9KT0lOICovPGJyIGNsYXNzPSIiPis8c3BhbiBjbGFzcz0iQXBwbGUtdGFiLXNwYW4i
IHN0eWxlPSJ3aGl0ZS1zcGFjZTpwcmUiPgk8L3NwYW4+TVBUQ1BfTUlCX0pPSU5TWU5BQ0tNQUMs
PHNwYW4gY2xhc3M9IkFwcGxlLXRhYi1zcGFuIiBzdHlsZT0id2hpdGUtc3BhY2U6cHJlIj4JPC9z
cGFuPi8qIEhNQUMgd2FzIHdyb25nIG9uIFNZTi9BQ0sgKyBNUF9KT0lOICovPGJyIGNsYXNzPSIi
Pis8c3BhbiBjbGFzcz0iQXBwbGUtdGFiLXNwYW4iIHN0eWxlPSJ3aGl0ZS1zcGFjZTpwcmUiPgk8
L3NwYW4+TVBUQ1BfTUlCX0pPSU5BQ0tSWCw8c3BhbiBjbGFzcz0iQXBwbGUtdGFiLXNwYW4iIHN0
eWxlPSJ3aGl0ZS1zcGFjZTpwcmUiPgk8L3NwYW4+PHNwYW4gY2xhc3M9IkFwcGxlLXRhYi1zcGFu
IiBzdHlsZT0id2hpdGUtc3BhY2U6cHJlIj4JPC9zcGFuPi8qIFJlY2VpdmVkIGFuIEFDSyArIE1Q
X0pPSU4gKi88YnIgY2xhc3M9IiI+KzxzcGFuIGNsYXNzPSJBcHBsZS10YWItc3BhbiIgc3R5bGU9
IndoaXRlLXNwYWNlOnByZSI+CTwvc3Bhbj5NUFRDUF9NSUJfSk9JTkFDS01BQyw8c3BhbiBjbGFz
cz0iQXBwbGUtdGFiLXNwYW4iIHN0eWxlPSJ3aGl0ZS1zcGFjZTpwcmUiPgk8L3NwYW4+PHNwYW4g
Y2xhc3M9IkFwcGxlLXRhYi1zcGFuIiBzdHlsZT0id2hpdGUtc3BhY2U6cHJlIj4JPC9zcGFuPi8q
IEhNQUMgd2FzIHdyb25nIG9uIEFDSyArIE1QX0pPSU4gKi88YnIgY2xhc3M9IiI+KzxzcGFuIGNs
YXNzPSJBcHBsZS10YWItc3BhbiIgc3R5bGU9IndoaXRlLXNwYWNlOnByZSI+CTwvc3Bhbj5NUFRD
UF9NSUJfSk9JTkFDS0ZBSUwsPHNwYW4gY2xhc3M9IkFwcGxlLXRhYi1zcGFuIiBzdHlsZT0id2hp
dGUtc3BhY2U6cHJlIj4JPC9zcGFuPjxzcGFuIGNsYXNzPSJBcHBsZS10YWItc3BhbiIgc3R5bGU9
IndoaXRlLXNwYWNlOnByZSI+CTwvc3Bhbj4vKiBUaGlyZCBBQ0sgb24gbmV3IHN1YmZsb3cgZGlk
IG5vdCBjb250YWluIGFuIE1QX0pPSU4gKi88YnIgY2xhc3M9IiI+KzxzcGFuIGNsYXNzPSJBcHBs
ZS10YWItc3BhbiIgc3R5bGU9IndoaXRlLXNwYWNlOnByZSI+CTwvc3Bhbj5NUFRDUF9NSUJfSk9J
TkFDS1JUTyw8c3BhbiBjbGFzcz0iQXBwbGUtdGFiLXNwYW4iIHN0eWxlPSJ3aGl0ZS1zcGFjZTpw
cmUiPgk8L3NwYW4+PHNwYW4gY2xhc3M9IkFwcGxlLXRhYi1zcGFuIiBzdHlsZT0id2hpdGUtc3Bh
Y2U6cHJlIj4JPC9zcGFuPi8qIFJldHJhbnNtaXNzaW9uIHRpbWVyIGZvciB0aGlyZCBBQ0sgKyBN
UF9KT0lOIHRpbWVkIG91dCAqLzxiciBjbGFzcz0iIj4rPHNwYW4gY2xhc3M9IkFwcGxlLXRhYi1z
cGFuIiBzdHlsZT0id2hpdGUtc3BhY2U6cHJlIj4JPC9zcGFuPk1QVENQX01JQl9KT0lOQUNLUlhN
SVQsPHNwYW4gY2xhc3M9IkFwcGxlLXRhYi1zcGFuIiBzdHlsZT0id2hpdGUtc3BhY2U6cHJlIj4J
PC9zcGFuPjxzcGFuIGNsYXNzPSJBcHBsZS10YWItc3BhbiIgc3R5bGU9IndoaXRlLXNwYWNlOnBy
ZSI+CTwvc3Bhbj4vKiBSZXRyYW5zbWl0dGVkIGFuIEFDSyArIE1QX0pPSU4gKi88YnIgY2xhc3M9
IiI+KzxzcGFuIGNsYXNzPSJBcHBsZS10YWItc3BhbiIgc3R5bGU9IndoaXRlLXNwYWNlOnByZSI+
CTwvc3Bhbj5NUFRDUF9NSUJfTk9EU1NXSU5ET1csPHNwYW4gY2xhc3M9IkFwcGxlLXRhYi1zcGFu
IiBzdHlsZT0id2hpdGUtc3BhY2U6cHJlIj4JPC9zcGFuPjxzcGFuIGNsYXNzPSJBcHBsZS10YWIt
c3BhbiIgc3R5bGU9IndoaXRlLXNwYWNlOnByZSI+CTwvc3Bhbj4vKiBSZWNlaXZlZCB0b28gbWFu
eSBwYWNrZXRzIHdpdGhvdXQgYSBEU1Mtb3B0aW9uICovPGJyIGNsYXNzPSIiPis8c3BhbiBjbGFz
cz0iQXBwbGUtdGFiLXNwYW4iIHN0eWxlPSJ3aGl0ZS1zcGFjZTpwcmUiPgk8L3NwYW4+TVBUQ1Bf
TUlCX0RTU05PTUFUQ0gsPHNwYW4gY2xhc3M9IkFwcGxlLXRhYi1zcGFuIiBzdHlsZT0id2hpdGUt
c3BhY2U6cHJlIj4JPC9zcGFuPjxzcGFuIGNsYXNzPSJBcHBsZS10YWItc3BhbiIgc3R5bGU9Indo
aXRlLXNwYWNlOnByZSI+CTwvc3Bhbj4vKiBSZWNlaXZlZCBhIG5ldyBtYXBwaW5nIHRoYXQgZGlk
IG5vdCBtYXRjaCB0aGUgcHJldmlvdXMgb25lICovPGJyIGNsYXNzPSIiPis8c3BhbiBjbGFzcz0i
QXBwbGUtdGFiLXNwYW4iIHN0eWxlPSJ3aGl0ZS1zcGFjZTpwcmUiPgk8L3NwYW4+TVBUQ1BfTUlC
X0lORklOSVRFTUFQUlgsPHNwYW4gY2xhc3M9IkFwcGxlLXRhYi1zcGFuIiBzdHlsZT0id2hpdGUt
c3BhY2U6cHJlIj4JPC9zcGFuPi8qIFJlY2VpdmVkIGFuIGluZmluaXRlIG1hcHBpbmcgKi88YnIg
Y2xhc3M9IiI+KzxzcGFuIGNsYXNzPSJBcHBsZS10YWItc3BhbiIgc3R5bGU9IndoaXRlLXNwYWNl
OnByZSI+CTwvc3Bhbj5NUFRDUF9NSUJfRFNTVENQTUlTTUFUQ0gsPHNwYW4gY2xhc3M9IkFwcGxl
LXRhYi1zcGFuIiBzdHlsZT0id2hpdGUtc3BhY2U6cHJlIj4JPC9zcGFuPi8qIERTUy1tYXBwaW5n
IGRpZCBub3QgbWFwIHdpdGggVENQJ3Mgc2VxdWVuY2UgbnVtYmVycyAqLzxiciBjbGFzcz0iIj4r
PHNwYW4gY2xhc3M9IkFwcGxlLXRhYi1zcGFuIiBzdHlsZT0id2hpdGUtc3BhY2U6cHJlIj4JPC9z
cGFuPk1QVENQX01JQl9EU1NUUklNSEVBRCw8c3BhbiBjbGFzcz0iQXBwbGUtdGFiLXNwYW4iIHN0
eWxlPSJ3aGl0ZS1zcGFjZTpwcmUiPgk8L3NwYW4+PHNwYW4gY2xhc3M9IkFwcGxlLXRhYi1zcGFu
IiBzdHlsZT0id2hpdGUtc3BhY2U6cHJlIj4JPC9zcGFuPi8qIFRyaW1tZWQgc2VnbWVudCBhdCB0
aGUgaGVhZCAoY29hbGVzY2luZyBtaWRkbGVib3gpICovPGJyIGNsYXNzPSIiPis8c3BhbiBjbGFz
cz0iQXBwbGUtdGFiLXNwYW4iIHN0eWxlPSJ3aGl0ZS1zcGFjZTpwcmUiPgk8L3NwYW4+TVBUQ1Bf
TUlCX0RTU1NQTElUVEFJTCw8c3BhbiBjbGFzcz0iQXBwbGUtdGFiLXNwYW4iIHN0eWxlPSJ3aGl0
ZS1zcGFjZTpwcmUiPgk8L3NwYW4+PHNwYW4gY2xhc3M9IkFwcGxlLXRhYi1zcGFuIiBzdHlsZT0i
d2hpdGUtc3BhY2U6cHJlIj4JPC9zcGFuPi8qIFRyaW1tZWQgc2VnbWVudCBhdCB0aGUgdGFpbCAo
Y29hbGVzY2luZyBtaWRkbGVib3gpICovPGJyIGNsYXNzPSIiPis8c3BhbiBjbGFzcz0iQXBwbGUt
dGFiLXNwYW4iIHN0eWxlPSJ3aGl0ZS1zcGFjZTpwcmUiPgk8L3NwYW4+TVBUQ1BfTUlCX1BVUkdF
T0xELDxzcGFuIGNsYXNzPSJBcHBsZS10YWItc3BhbiIgc3R5bGU9IndoaXRlLXNwYWNlOnByZSI+
CTwvc3Bhbj48c3BhbiBjbGFzcz0iQXBwbGUtdGFiLXNwYW4iIHN0eWxlPSJ3aGl0ZS1zcGFjZTpw
cmUiPgk8L3NwYW4+LyogUmVtb3ZlZCBvbGQgc2tiIGZyb20gdGhlIHJjdi1xdWV1ZSBkdWUgdG8g
bWlzc2luZyBEU1MtbWFwcGluZyAqLzxiciBjbGFzcz0iIj4rPHNwYW4gY2xhc3M9IkFwcGxlLXRh
Yi1zcGFuIiBzdHlsZT0id2hpdGUtc3BhY2U6cHJlIj4JPC9zcGFuPk1QVENQX01JQl9BRERBRERS
UlgsPHNwYW4gY2xhc3M9IkFwcGxlLXRhYi1zcGFuIiBzdHlsZT0id2hpdGUtc3BhY2U6cHJlIj4J
PC9zcGFuPjxzcGFuIGNsYXNzPSJBcHBsZS10YWItc3BhbiIgc3R5bGU9IndoaXRlLXNwYWNlOnBy
ZSI+CTwvc3Bhbj4vKiBSZWNlaXZlZCBhbiBBRERfQUREUiAqLzxiciBjbGFzcz0iIj4rPHNwYW4g
Y2xhc3M9IkFwcGxlLXRhYi1zcGFuIiBzdHlsZT0id2hpdGUtc3BhY2U6cHJlIj4JPC9zcGFuPk1Q
VENQX01JQl9BRERBRERSVFgsPHNwYW4gY2xhc3M9IkFwcGxlLXRhYi1zcGFuIiBzdHlsZT0id2hp
dGUtc3BhY2U6cHJlIj4JPC9zcGFuPjxzcGFuIGNsYXNzPSJBcHBsZS10YWItc3BhbiIgc3R5bGU9
IndoaXRlLXNwYWNlOnByZSI+CTwvc3Bhbj4vKiBTZW50IGFuIEFERF9BRERSICovPGJyIGNsYXNz
PSIiPis8c3BhbiBjbGFzcz0iQXBwbGUtdGFiLXNwYW4iIHN0eWxlPSJ3aGl0ZS1zcGFjZTpwcmUi
Pgk8L3NwYW4+TVBUQ1BfTUlCX1JFTUFERFJSWCw8c3BhbiBjbGFzcz0iQXBwbGUtdGFiLXNwYW4i
IHN0eWxlPSJ3aGl0ZS1zcGFjZTpwcmUiPgk8L3NwYW4+PHNwYW4gY2xhc3M9IkFwcGxlLXRhYi1z
cGFuIiBzdHlsZT0id2hpdGUtc3BhY2U6cHJlIj4JPC9zcGFuPi8qIFJlY2VpdmVkIGEgUkVNT1ZF
X0FERFIgKi88YnIgY2xhc3M9IiI+KzxzcGFuIGNsYXNzPSJBcHBsZS10YWItc3BhbiIgc3R5bGU9
IndoaXRlLXNwYWNlOnByZSI+CTwvc3Bhbj5NUFRDUF9NSUJfUkVNQUREUlRYLDxzcGFuIGNsYXNz
PSJBcHBsZS10YWItc3BhbiIgc3R5bGU9IndoaXRlLXNwYWNlOnByZSI+CTwvc3Bhbj48c3BhbiBj
bGFzcz0iQXBwbGUtdGFiLXNwYW4iIHN0eWxlPSJ3aGl0ZS1zcGFjZTpwcmUiPgk8L3NwYW4+Lyog
U2VudCBhIFJFTU9WRV9BRERSICovPGJyIGNsYXNzPSIiPis8c3BhbiBjbGFzcz0iQXBwbGUtdGFi
LXNwYW4iIHN0eWxlPSJ3aGl0ZS1zcGFjZTpwcmUiPgk8L3NwYW4+X19NUFRDUF9NSUJfTUFYPGJy
IGNsYXNzPSIiPit9OzxiciBjbGFzcz0iIj4rPGJyIGNsYXNzPSIiPisjZGVmaW5lIExJTlVYX01J
Ql9NUFRDUF9NQVg8c3BhbiBjbGFzcz0iQXBwbGUtdGFiLXNwYW4iIHN0eWxlPSJ3aGl0ZS1zcGFj
ZTpwcmUiPgk8L3NwYW4+X19NUFRDUF9NSUJfTUFYPGJyIGNsYXNzPSIiPitzdHJ1Y3QgbXB0Y3Bf
bWliIHs8YnIgY2xhc3M9IiI+KzxzcGFuIGNsYXNzPSJBcHBsZS10YWItc3BhbiIgc3R5bGU9Indo
aXRlLXNwYWNlOnByZSI+CTwvc3Bhbj51bnNpZ25lZCBsb25nIG1pYnNbTElOVVhfTUlCX01QVENQ
X01BWF07PGJyIGNsYXNzPSIiPit9OzxiciBjbGFzcz0iIj4rPGJyIGNsYXNzPSIiPitzdGF0aWMg
aW5saW5lIHZvaWQgTVBUQ1BfSU5DX1NUQVRTKHN0cnVjdCBuZXQgKm5ldCw8YnIgY2xhc3M9IiI+
KzxzcGFuIGNsYXNzPSJBcHBsZS10YWItc3BhbiIgc3R5bGU9IndoaXRlLXNwYWNlOnByZSI+CTwv
c3Bhbj48c3BhbiBjbGFzcz0iQXBwbGUtdGFiLXNwYW4iIHN0eWxlPSJ3aGl0ZS1zcGFjZTpwcmUi
Pgk8L3NwYW4+PHNwYW4gY2xhc3M9IkFwcGxlLXRhYi1zcGFuIiBzdHlsZT0id2hpdGUtc3BhY2U6
cHJlIj4JPC9zcGFuPjxzcGFuIGNsYXNzPSJBcHBsZS10YWItc3BhbiIgc3R5bGU9IndoaXRlLXNw
YWNlOnByZSI+CTwvc3Bhbj4gJm5ic3A7Jm5ic3A7ZW51bSBsaW51eF9tcHRjcF9taWJfZmllbGQg
ZmllbGQpPGJyIGNsYXNzPSIiPit7PGJyIGNsYXNzPSIiPis8c3BhbiBjbGFzcz0iQXBwbGUtdGFi
LXNwYW4iIHN0eWxlPSJ3aGl0ZS1zcGFjZTpwcmUiPgk8L3NwYW4+aWYgKGxpa2VseShuZXQtJmd0
O21pYi5tcHRjcF9zdGF0aXN0aWNzKSk8YnIgY2xhc3M9IiI+KzxzcGFuIGNsYXNzPSJBcHBsZS10
YWItc3BhbiIgc3R5bGU9IndoaXRlLXNwYWNlOnByZSI+CTwvc3Bhbj48c3BhbiBjbGFzcz0iQXBw
bGUtdGFiLXNwYW4iIHN0eWxlPSJ3aGl0ZS1zcGFjZTpwcmUiPgk8L3NwYW4+U05NUF9JTkNfU1RB
VFMobmV0LSZndDttaWIubXB0Y3Bfc3RhdGlzdGljcywgZmllbGQpOzxiciBjbGFzcz0iIj4rfTxi
ciBjbGFzcz0iIj4rPGJyIGNsYXNzPSIiPitzdGF0aWMgaW5saW5lIHZvaWQgX19NUFRDUF9JTkNf
U1RBVFMoc3RydWN0IG5ldCAqbmV0LDxiciBjbGFzcz0iIj4rPHNwYW4gY2xhc3M9IkFwcGxlLXRh
Yi1zcGFuIiBzdHlsZT0id2hpdGUtc3BhY2U6cHJlIj4JPC9zcGFuPjxzcGFuIGNsYXNzPSJBcHBs
ZS10YWItc3BhbiIgc3R5bGU9IndoaXRlLXNwYWNlOnByZSI+CTwvc3Bhbj48c3BhbiBjbGFzcz0i
QXBwbGUtdGFiLXNwYW4iIHN0eWxlPSJ3aGl0ZS1zcGFjZTpwcmUiPgk8L3NwYW4+PHNwYW4gY2xh
c3M9IkFwcGxlLXRhYi1zcGFuIiBzdHlsZT0id2hpdGUtc3BhY2U6cHJlIj4JPC9zcGFuPiAmbmJz
cDsmbmJzcDsmbmJzcDsmbmJzcDtlbnVtIGxpbnV4X21wdGNwX21pYl9maWVsZCBmaWVsZCk8YnIg
Y2xhc3M9IiI+K3s8YnIgY2xhc3M9IiI+KzxzcGFuIGNsYXNzPSJBcHBsZS10YWItc3BhbiIgc3R5
bGU9IndoaXRlLXNwYWNlOnByZSI+CTwvc3Bhbj5pZiAobGlrZWx5KG5ldC0mZ3Q7bWliLm1wdGNw
X3N0YXRpc3RpY3MpKTxiciBjbGFzcz0iIj4rPHNwYW4gY2xhc3M9IkFwcGxlLXRhYi1zcGFuIiBz
dHlsZT0id2hpdGUtc3BhY2U6cHJlIj4JPC9zcGFuPjxzcGFuIGNsYXNzPSJBcHBsZS10YWItc3Bh
biIgc3R5bGU9IndoaXRlLXNwYWNlOnByZSI+CTwvc3Bhbj5fX1NOTVBfSU5DX1NUQVRTKG5ldC0m
Z3Q7bWliLm1wdGNwX3N0YXRpc3RpY3MsIGZpZWxkKTs8YnIgY2xhc3M9IiI+K308YnIgY2xhc3M9
IiI+KzxiciBjbGFzcz0iIj4rYm9vbCBtcHRjcF9taWJfYWxsb2Moc3RydWN0IG5ldCAqbmV0KTs8
YnIgY2xhc3M9IiI+ZGlmZiAtLWdpdCBhL25ldC9tcHRjcC9wcm90b2NvbC5jIGIvbmV0L21wdGNw
L3Byb3RvY29sLmM8YnIgY2xhc3M9IiI+aW5kZXggOWMwMTllNjk2ZmM3Li42NmFjN2RhZmUzODgg
MTAwNjQ0PGJyIGNsYXNzPSIiPi0tLSBhL25ldC9tcHRjcC9wcm90b2NvbC5jPGJyIGNsYXNzPSIi
PisrKyBiL25ldC9tcHRjcC9wcm90b2NvbC5jPGJyIGNsYXNzPSIiPkBAIC0xNiw2ICsxNiw3IEBA
PGJyIGNsYXNzPSIiPiAjaW5jbHVkZSAmbHQ7bmV0L3RjcC5oJmd0OzxiciBjbGFzcz0iIj4gI2lu
Y2x1ZGUgJmx0O25ldC9tcHRjcC5oJmd0OzxiciBjbGFzcz0iIj4gI2luY2x1ZGUgInByb3RvY29s
LmgiPGJyIGNsYXNzPSIiPisjaW5jbHVkZSAibWliLmgiPGJyIGNsYXNzPSIiPjxiciBjbGFzcz0i
Ij4gc3RhdGljIGlubGluZSBib29sIGJlZm9yZTY0KF9fdTY0IHNlcTEsIF9fdTY0IHNlcTIpPGJy
IGNsYXNzPSIiPiB7PGJyIGNsYXNzPSIiPkBAIC02MjEsOSArNjIyLDE0IEBAIHN0YXRpYyBpbnQg
X19tcHRjcF9pbml0X3NvY2soc3RydWN0IHNvY2sgKnNrKTxiciBjbGFzcz0iIj48YnIgY2xhc3M9
IiI+IHN0YXRpYyBpbnQgbXB0Y3BfaW5pdF9zb2NrKHN0cnVjdCBzb2NrICpzayk8YnIgY2xhc3M9
IiI+IHs8YnIgY2xhc3M9IiI+LTxzcGFuIGNsYXNzPSJBcHBsZS10YWItc3BhbiIgc3R5bGU9Indo
aXRlLXNwYWNlOnByZSI+CTwvc3Bhbj5pZiAoIW1wdGNwX2lzX2VuYWJsZWQoc29ja19uZXQoc2sp
KSk8YnIgY2xhc3M9IiI+KzxzcGFuIGNsYXNzPSJBcHBsZS10YWItc3BhbiIgc3R5bGU9IndoaXRl
LXNwYWNlOnByZSI+CTwvc3Bhbj5zdHJ1Y3QgbmV0ICpuZXQgPSBzb2NrX25ldChzayk7PGJyIGNs
YXNzPSIiPis8YnIgY2xhc3M9IiI+KzxzcGFuIGNsYXNzPSJBcHBsZS10YWItc3BhbiIgc3R5bGU9
IndoaXRlLXNwYWNlOnByZSI+CTwvc3Bhbj5pZiAoIW1wdGNwX2lzX2VuYWJsZWQobmV0KSk8YnIg
Y2xhc3M9IiI+IDxzcGFuIGNsYXNzPSJBcHBsZS10YWItc3BhbiIgc3R5bGU9IndoaXRlLXNwYWNl
OnByZSI+CTwvc3Bhbj48c3BhbiBjbGFzcz0iQXBwbGUtdGFiLXNwYW4iIHN0eWxlPSJ3aGl0ZS1z
cGFjZTpwcmUiPgk8L3NwYW4+cmV0dXJuIC1FTk9QUk9UT09QVDs8YnIgY2xhc3M9IiI+PGJyIGNs
YXNzPSIiPis8c3BhbiBjbGFzcz0iQXBwbGUtdGFiLXNwYW4iIHN0eWxlPSJ3aGl0ZS1zcGFjZTpw
cmUiPgk8L3NwYW4+aWYgKHVubGlrZWx5KCFuZXQtJmd0O21pYi5tcHRjcF9zdGF0aXN0aWNzKSAm
YW1wOyZhbXA7ICFtcHRjcF9taWJfYWxsb2MobmV0KSk8YnIgY2xhc3M9IiI+KzxzcGFuIGNsYXNz
PSJBcHBsZS10YWItc3BhbiIgc3R5bGU9IndoaXRlLXNwYWNlOnByZSI+CTwvc3Bhbj48c3BhbiBj
bGFzcz0iQXBwbGUtdGFiLXNwYW4iIHN0eWxlPSJ3aGl0ZS1zcGFjZTpwcmUiPgk8L3NwYW4+cmV0
dXJuIC1FTk9NRU07PGJyIGNsYXNzPSIiPis8YnIgY2xhc3M9IiI+IDxzcGFuIGNsYXNzPSJBcHBs
ZS10YWItc3BhbiIgc3R5bGU9IndoaXRlLXNwYWNlOnByZSI+CTwvc3Bhbj5yZXR1cm4gX19tcHRj
cF9pbml0X3NvY2soc2spOzxiciBjbGFzcz0iIj4gfTxiciBjbGFzcz0iIj48YnIgY2xhc3M9IiI+
LS0gPGJyIGNsYXNzPSIiPjIuMjEuMDxiciBjbGFzcz0iIj48YnIgY2xhc3M9IiI+X19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX188YnIgY2xhc3M9IiI+bXB0Y3Ag
bWFpbGluZyBsaXN0PGJyIGNsYXNzPSIiPjxhIGhyZWY9Im1haWx0bzptcHRjcEBsaXN0cy4wMS5v
cmciIGNsYXNzPSIiPm1wdGNwQGxpc3RzLjAxLm9yZzwvYT48YnIgY2xhc3M9IiI+aHR0cHM6Ly9s
aXN0cy4wMS5vcmcvbWFpbG1hbi9saXN0aW5mby9tcHRjcDxiciBjbGFzcz0iIj48L2Rpdj48L2Rp
dj48L2Jsb2NrcXVvdGU+PC9kaXY+PGJyIGNsYXNzPSIiPjwvZGl2PjwvYm9keT48L2h0bWw+
--===============9161681781962378329==--
