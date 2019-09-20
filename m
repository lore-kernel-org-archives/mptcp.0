Content-Type: multipart/mixed; boundary="===============2149920733144666018=="
MIME-Version: 1.0
From: Florian Westphal <fw at strlen.de>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH 1/2] mptcp: add MIB counter infrastructure
Date: Fri, 20 Sep 2019 17:05:13 +0200
Message-ID: <20190920150514.1878-2-fw@strlen.de>
In-Reply-To: 20190920150514.1878-1-fw@strlen.de
X-Status: 
X-Keywords:                  
X-UID: 1889

--===============2149920733144666018==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Exported via same /proc file as the Linux TCP MIB counters.
This means tools like 'nstat' will pick them up automatically.

The MPTCP MIB counters are allocated in a distinct pcpu area in order to
avoid bloating/wasting TCP pcpu memory.

The counters are allocated once the first MPTCP socket is created in a
network namespace.

The Names are taken from the multipath-tcp.org kernel, in case we don't
need all of them the extra ones should be pruned.  But for now i've
added all on the grounds that they are probably useful (i.e., make
use of them).

Signed-off-by: Florian Westphal <fw(a)strlen.de>
---
 include/net/mptcp.h     |  2 +
 include/net/netns/mib.h |  3 ++
 net/ipv4/af_inet.c      |  4 ++
 net/ipv4/proc.c         |  2 +
 net/mptcp/Makefile      |  2 +-
 net/mptcp/mib.c         | 95 +++++++++++++++++++++++++++++++++++++++++
 net/mptcp/mib.h         | 67 +++++++++++++++++++++++++++++
 net/mptcp/protocol.c    |  8 +++-
 8 files changed, 181 insertions(+), 2 deletions(-)
 create mode 100644 net/mptcp/mib.c
 create mode 100644 net/mptcp/mib.h

diff --git a/include/net/mptcp.h b/include/net/mptcp.h
index 50cd1b31ebdd..c4f4fdd57c74 100644
--- a/include/net/mptcp.h
+++ b/include/net/mptcp.h
@@ -82,6 +82,7 @@ void mptcp_write_options(__be32 *ptr, struct mptcp_out_op=
tions *opts);
 =

 bool mptcp_sk_is_subflow(const struct sock *sk);
 =

+void mptcp_seq_show(struct seq_file *seq);
 #else
 =

 static inline void mptcp_init(void)
@@ -145,5 +146,6 @@ static inline bool mptcp_sk_is_subflow(const struct soc=
k *sk)
 	return false;
 }
 =

+static inline void mptcp_seq_show(struct seq_file *seq) { }
 #endif /* CONFIG_MPTCP */
 #endif /* __NET_MPTCP_H */
diff --git a/include/net/netns/mib.h b/include/net/netns/mib.h
index 830bdf345b17..59fcaef98fb8 100644
--- a/include/net/netns/mib.h
+++ b/include/net/netns/mib.h
@@ -24,6 +24,9 @@ struct netns_mib {
 #ifdef CONFIG_XFRM_STATISTICS
 	DEFINE_SNMP_STAT(struct linux_xfrm_mib, xfrm_statistics);
 #endif
+#ifdef CONFIG_MPTCP
+	DEFINE_SNMP_STAT(struct mptcp_mib, mptcp_statistics);
+#endif
 };
 =

 #endif
diff --git a/net/ipv4/af_inet.c b/net/ipv4/af_inet.c
index 70f92aaca411..3b2817267989 100644
--- a/net/ipv4/af_inet.c
+++ b/net/ipv4/af_inet.c
@@ -1793,6 +1793,10 @@ static __net_exit void ipv4_mib_exit_net(struct net =
*net)
 	free_percpu(net->mib.net_statistics);
 	free_percpu(net->mib.ip_statistics);
 	free_percpu(net->mib.tcp_statistics);
+#ifdef CONFIG_MPTCP
+	/* allocated on demand, see mptcp_init_sock() */
+	free_percpu(net->mib.mptcp_statistics);
+#endif
 }
 =

 static __net_initdata struct pernet_operations ipv4_mib_ops =3D {
diff --git a/net/ipv4/proc.c b/net/ipv4/proc.c
index cc90243ccf76..aeb9be9a9cdb 100644
--- a/net/ipv4/proc.c
+++ b/net/ipv4/proc.c
@@ -32,6 +32,7 @@
 #include <net/icmp.h>
 #include <net/protocol.h>
 #include <net/tcp.h>
+#include <net/mptcp.h>
 #include <net/udp.h>
 #include <net/udplite.h>
 #include <linux/bottom_half.h>
@@ -483,6 +484,7 @@ static int netstat_seq_show(struct seq_file *seq, void =
*v)
 					     offsetof(struct ipstats_mib, syncp)));
 =

 	seq_putc(seq, '\n');
+	mptcp_seq_show(seq);
 	return 0;
 }
 =

diff --git a/net/mptcp/Makefile b/net/mptcp/Makefile
index 289fdf4339c1..77da3f45cc97 100644
--- a/net/mptcp/Makefile
+++ b/net/mptcp/Makefile
@@ -1,4 +1,4 @@
 # SPDX-License-Identifier: GPL-2.0
 obj-$(CONFIG_MPTCP) +=3D mptcp.o
 =

-mptcp-y :=3D protocol.o subflow.o options.o token.o crypto.o pm.o ctrl.o
+mptcp-y :=3D protocol.o subflow.o options.o token.o crypto.o pm.o ctrl.o m=
ib.o
diff --git a/net/mptcp/mib.c b/net/mptcp/mib.c
new file mode 100644
index 000000000000..975a29237260
--- /dev/null
+++ b/net/mptcp/mib.c
@@ -0,0 +1,95 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+
+#include <linux/seq_file.h>
+#include <net/ip.h>
+#include <net/snmp.h>
+#include <net/net_namespace.h>
+
+#include "mib.h"
+
+static const struct snmp_mib mptcp_snmp_list[] =3D {
+	SNMP_MIB_ITEM("MPCapableSYNRX", MPTCP_MIB_MPCAPABLEPASSIVE),
+	SNMP_MIB_ITEM("MPCapableSYNTX", MPTCP_MIB_MPCAPABLEACTIVE),
+	SNMP_MIB_ITEM("MPCapableSYNACKRX", MPTCP_MIB_MPCAPABLEACTIVEACK),
+	SNMP_MIB_ITEM("MPCapableACKRX", MPTCP_MIB_MPCAPABLEPASSIVEACK),
+	SNMP_MIB_ITEM("MPCapableFallbackACK", MPTCP_MIB_MPCAPABLEPASSIVEFALLBACK),
+	SNMP_MIB_ITEM("MPCapableFallbackSYNACK", MPTCP_MIB_MPCAPABLEACTIVEFALLBAC=
K),
+	SNMP_MIB_ITEM("MPCapableRetransFallback", MPTCP_MIB_MPCAPABLERETRANSFALLB=
ACK),
+	SNMP_MIB_ITEM("MPTCPCsumEnabled", MPTCP_MIB_CSUMENABLED),
+	SNMP_MIB_ITEM("MPTCPRetrans", MPTCP_MIB_RETRANSSEGS),
+	SNMP_MIB_ITEM("MPFailRX", MPTCP_MIB_MPFAILRX),
+	SNMP_MIB_ITEM("MPCsumFail", MPTCP_MIB_CSUMFAIL),
+	SNMP_MIB_ITEM("MPFastcloseRX", MPTCP_MIB_FASTCLOSERX),
+	SNMP_MIB_ITEM("MPFastcloseTX", MPTCP_MIB_FASTCLOSETX),
+	SNMP_MIB_ITEM("MPFallbackAckSub", MPTCP_MIB_FBACKSUB),
+	SNMP_MIB_ITEM("MPFallbackAckInit", MPTCP_MIB_FBACKINIT),
+	SNMP_MIB_ITEM("MPFallbackDataSub", MPTCP_MIB_FBDATASUB),
+	SNMP_MIB_ITEM("MPFallbackDataInit", MPTCP_MIB_FBDATAINIT),
+	SNMP_MIB_ITEM("MPRemoveAddrSubDelete", MPTCP_MIB_REMADDRSUB),
+	SNMP_MIB_ITEM("MPJoinNoTokenFound", MPTCP_MIB_JOINNOTOKEN),
+	SNMP_MIB_ITEM("MPJoinAlreadyFallenback", MPTCP_MIB_JOINFALLBACK),
+	SNMP_MIB_ITEM("MPJoinSynTx", MPTCP_MIB_JOINSYNTX),
+	SNMP_MIB_ITEM("MPJoinSynRx", MPTCP_MIB_JOINSYNRX),
+	SNMP_MIB_ITEM("MPJoinSynAckRx", MPTCP_MIB_JOINSYNACKRX),
+	SNMP_MIB_ITEM("MPJoinSynAckHMacFailure", MPTCP_MIB_JOINSYNACKMAC),
+	SNMP_MIB_ITEM("MPJoinAckRx", MPTCP_MIB_JOINACKRX),
+	SNMP_MIB_ITEM("MPJoinAckHMacFailure", MPTCP_MIB_JOINACKMAC),
+	SNMP_MIB_ITEM("MPJoinAckMissing", MPTCP_MIB_JOINACKFAIL),
+	SNMP_MIB_ITEM("MPJoinAckRTO", MPTCP_MIB_JOINACKRTO),
+	SNMP_MIB_ITEM("MPJoinAckRexmit", MPTCP_MIB_JOINACKRXMIT),
+	SNMP_MIB_ITEM("NoDSSInWindow", MPTCP_MIB_NODSSWINDOW),
+	SNMP_MIB_ITEM("DSSNotMatching", MPTCP_MIB_DSSNOMATCH),
+	SNMP_MIB_ITEM("InfiniteMapRx", MPTCP_MIB_INFINITEMAPRX),
+	SNMP_MIB_ITEM("DSSNoMatchTCP", MPTCP_MIB_DSSTCPMISMATCH),
+	SNMP_MIB_ITEM("DSSTrimHead", MPTCP_MIB_DSSTRIMHEAD),
+	SNMP_MIB_ITEM("DSSSplitTail", MPTCP_MIB_DSSSPLITTAIL),
+	SNMP_MIB_ITEM("DSSPurgeOldSubSegs", MPTCP_MIB_PURGEOLD),
+	SNMP_MIB_ITEM("AddAddrRx", MPTCP_MIB_ADDADDRRX),
+	SNMP_MIB_ITEM("AddAddrTx", MPTCP_MIB_ADDADDRTX),
+	SNMP_MIB_ITEM("RemAddrRx", MPTCP_MIB_REMADDRRX),
+	SNMP_MIB_ITEM("RemAddrTx", MPTCP_MIB_REMADDRTX),
+	SNMP_MIB_SENTINEL
+};
+
+/* mptcp_mib_alloc - allocate percpu mib counters
+ *
+ * These are allocated when the first mptcp socket is created so
+ * we do not waste percpu memory if mptcp isn't in use.
+ */
+bool mptcp_mib_alloc(struct net *net)
+{
+	struct mptcp_mib *mib =3D alloc_percpu(struct mptcp_mib);
+
+	if (!mib)
+		return false;
+
+	if (cmpxchg(&net->mib.mptcp_statistics, NULL, mib))
+		free_percpu(mib);
+
+	return true;
+}
+
+void mptcp_seq_show(struct seq_file *seq)
+{
+	struct net *net =3D seq->private;
+	int i;
+
+	seq_puts(seq, "MPTcpExt:");
+	for (i =3D 0; mptcp_snmp_list[i].name; i++)
+		seq_printf(seq, " %s", mptcp_snmp_list[i].name);
+
+	seq_puts(seq, "\nMPTcpExt:");
+
+	if (!net->mib.mptcp_statistics) {
+		for (i =3D 0; mptcp_snmp_list[i].name; i++)
+			seq_printf(seq, " %lu", 0ul);
+
+		return;
+	}
+
+	for (i =3D 0; mptcp_snmp_list[i].name; i++)
+		seq_printf(seq, " %lu",
+			   snmp_fold_field(net->mib.mptcp_statistics,
+					   mptcp_snmp_list[i].entry));
+	seq_putc(seq, '\n');
+}
diff --git a/net/mptcp/mib.h b/net/mptcp/mib.h
new file mode 100644
index 000000000000..c24c41dc330c
--- /dev/null
+++ b/net/mptcp/mib.h
@@ -0,0 +1,67 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+
+enum linux_mptcp_mib_field {
+	MPTCP_MIB_NUM =3D 0,
+	MPTCP_MIB_MPCAPABLEPASSIVE,	/* Received SYN with MP_CAPABLE */
+	MPTCP_MIB_MPCAPABLEACTIVE,	/* Sent SYN with MP_CAPABLE */
+	MPTCP_MIB_MPCAPABLEACTIVEACK,	/* Received SYN/ACK with MP_CAPABLE */
+	MPTCP_MIB_MPCAPABLEPASSIVEACK,	/* Received third ACK with MP_CAPABLE */
+	MPTCP_MIB_MPCAPABLEPASSIVEFALLBACK,/* Server-side fallback during 3-way h=
andshake */
+	MPTCP_MIB_MPCAPABLEACTIVEFALLBACK, /* Client-side fallback during 3-way h=
andshake */
+	MPTCP_MIB_MPCAPABLERETRANSFALLBACK,/* Client-side stopped sending MP_CAPA=
BLE after too many SYN-retransmissions */
+	MPTCP_MIB_CSUMENABLED,		/* Created MPTCP-connection with DSS-checksum ena=
bled */
+	MPTCP_MIB_RETRANSSEGS,		/* Segments retransmitted at the MPTCP-level */
+	MPTCP_MIB_MPFAILRX,		/* Received an MP_FAIL */
+	MPTCP_MIB_CSUMFAIL,		/* Received segment with invalid checksum */
+	MPTCP_MIB_FASTCLOSERX,		/* Recevied a FAST_CLOSE */
+	MPTCP_MIB_FASTCLOSETX,		/* Sent a FAST_CLOSE */
+	MPTCP_MIB_FBACKSUB,		/* Fallback upon ack without data-ack on new subflow=
 */
+	MPTCP_MIB_FBACKINIT,		/* Fallback upon ack without data-ack on initial su=
bflow */
+	MPTCP_MIB_FBDATASUB,		/* Fallback upon data without DSS at the beginning =
on new subflow */
+	MPTCP_MIB_FBDATAINIT,		/* Fallback upon data without DSS at the beginning=
 on initial subflow */
+	MPTCP_MIB_REMADDRSUB,		/* Remove subflow due to REMOVE_ADDR */
+	MPTCP_MIB_JOINNOTOKEN,		/* Received MP_JOIN but the token was not found */
+	MPTCP_MIB_JOINFALLBACK,		/* Received MP_JOIN on session that has fallen b=
ack to reg. TCP */
+	MPTCP_MIB_JOINSYNTX,		/* Sent a SYN + MP_JOIN */
+	MPTCP_MIB_JOINSYNRX,		/* Received a SYN + MP_JOIN */
+	MPTCP_MIB_JOINSYNACKRX,		/* Received a SYN/ACK + MP_JOIN */
+	MPTCP_MIB_JOINSYNACKMAC,	/* HMAC was wrong on SYN/ACK + MP_JOIN */
+	MPTCP_MIB_JOINACKRX,		/* Received an ACK + MP_JOIN */
+	MPTCP_MIB_JOINACKMAC,		/* HMAC was wrong on ACK + MP_JOIN */
+	MPTCP_MIB_JOINACKFAIL,		/* Third ACK on new subflow did not contain an MP=
_JOIN */
+	MPTCP_MIB_JOINACKRTO,		/* Retransmission timer for third ACK + MP_JOIN ti=
med out */
+	MPTCP_MIB_JOINACKRXMIT,		/* Retransmitted an ACK + MP_JOIN */
+	MPTCP_MIB_NODSSWINDOW,		/* Received too many packets without a DSS-option=
 */
+	MPTCP_MIB_DSSNOMATCH,		/* Received a new mapping that did not match the p=
revious one */
+	MPTCP_MIB_INFINITEMAPRX,	/* Received an infinite mapping */
+	MPTCP_MIB_DSSTCPMISMATCH,	/* DSS-mapping did not map with TCP's sequence =
numbers */
+	MPTCP_MIB_DSSTRIMHEAD,		/* Trimmed segment at the head (coalescing middle=
box) */
+	MPTCP_MIB_DSSSPLITTAIL,		/* Trimmed segment at the tail (coalescing middl=
ebox) */
+	MPTCP_MIB_PURGEOLD,		/* Removed old skb from the rcv-queue due to missing=
 DSS-mapping */
+	MPTCP_MIB_ADDADDRRX,		/* Received an ADD_ADDR */
+	MPTCP_MIB_ADDADDRTX,		/* Sent an ADD_ADDR */
+	MPTCP_MIB_REMADDRRX,		/* Received a REMOVE_ADDR */
+	MPTCP_MIB_REMADDRTX,		/* Sent a REMOVE_ADDR */
+	__MPTCP_MIB_MAX
+};
+
+#define LINUX_MIB_MPTCP_MAX	__MPTCP_MIB_MAX
+struct mptcp_mib {
+	unsigned long mibs[LINUX_MIB_MPTCP_MAX];
+};
+
+static inline void MPTCP_INC_STATS(struct net *net,
+				   enum linux_mptcp_mib_field field)
+{
+	if (likely(net->mib.mptcp_statistics))
+		SNMP_INC_STATS(net->mib.mptcp_statistics, field);
+}
+
+static inline void __MPTCP_INC_STATS(struct net *net,
+				     enum linux_mptcp_mib_field field)
+{
+	if (likely(net->mib.mptcp_statistics))
+		__SNMP_INC_STATS(net->mib.mptcp_statistics, field);
+}
+
+bool mptcp_mib_alloc(struct net *net);
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 9c019e696fc7..66ac7dafe388 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -16,6 +16,7 @@
 #include <net/tcp.h>
 #include <net/mptcp.h>
 #include "protocol.h"
+#include "mib.h"
 =

 static inline bool before64(__u64 seq1, __u64 seq2)
 {
@@ -621,9 +622,14 @@ static int __mptcp_init_sock(struct sock *sk)
 =

 static int mptcp_init_sock(struct sock *sk)
 {
-	if (!mptcp_is_enabled(sock_net(sk)))
+	struct net *net =3D sock_net(sk);
+
+	if (!mptcp_is_enabled(net))
 		return -ENOPROTOOPT;
 =

+	if (unlikely(!net->mib.mptcp_statistics) && !mptcp_mib_alloc(net))
+		return -ENOMEM;
+
 	return __mptcp_init_sock(sk);
 }
 =

-- =

2.21.0


--===============2149920733144666018==--
