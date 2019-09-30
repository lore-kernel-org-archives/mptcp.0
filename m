Content-Type: multipart/mixed; boundary="===============2851700515608944042=="
MIME-Version: 1.0
From: Florian Westphal <fw at strlen.de>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH v2 1/2] mptcp: add MIB counter infrastructure
Date: Mon, 30 Sep 2019 16:51:57 +0200
Message-ID: <20190930145158.5331-2-fw@strlen.de>
In-Reply-To: 20190930145158.5331-1-fw@strlen.de
X-Status: 
X-Keywords:                  
X-UID: 1965

--===============2851700515608944042==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Exported via same /proc file as the Linux TCP MIB counters, so "netstat -s"
or "nstat" will show them automatically.

The MPTCP MIB counters are allocated in a distinct pcpu area in order to
avoid bloating/wasting TCP pcpu memory.

Counters are allocated once the first MPTCP socket is created in a
network namespace and free'd on exit.

If no sockets have been allocated, all-zero mptcp counters are shown.

The MIB counter list is taken from the multipath-tcp.org kernel, but
only a few counters have been picked up so far.  The counter list can
be increased at any time later on.

Signed-off-by: Florian Westphal <fw(a)strlen.de>
---
 v2: only pick up counters that will be incremented in the
 next patch.

 include/net/mptcp.h     |  2 ++
 include/net/netns/mib.h |  3 ++
 net/ipv4/af_inet.c      |  4 +++
 net/ipv4/proc.c         |  2 ++
 net/mptcp/Makefile      |  2 +-
 net/mptcp/mib.c         | 65 +++++++++++++++++++++++++++++++++++++++++
 net/mptcp/mib.h         | 37 +++++++++++++++++++++++
 net/mptcp/protocol.c    | 14 ++++++---
 8 files changed, 124 insertions(+), 5 deletions(-)
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
index 000000000000..38f6e63335bf
--- /dev/null
+++ b/net/mptcp/mib.c
@@ -0,0 +1,65 @@
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
+	SNMP_MIB_ITEM("MPCapableACKRX", MPTCP_MIB_MPCAPABLEPASSIVEACK),
+	SNMP_MIB_ITEM("MPCapableFallbackACK", MPTCP_MIB_MPCAPABLEPASSIVEFALLBACK),
+	SNMP_MIB_ITEM("MPCapableFallbackSYNACK", MPTCP_MIB_MPCAPABLEACTIVEFALLBAC=
K),
+	SNMP_MIB_ITEM("MPTCPRetrans", MPTCP_MIB_RETRANSSEGS),
+	SNMP_MIB_ITEM("MPJoinNoTokenFound", MPTCP_MIB_JOINNOTOKEN),
+	SNMP_MIB_ITEM("MPJoinSynRx", MPTCP_MIB_JOINSYNRX),
+	SNMP_MIB_ITEM("MPJoinAckHMacFailure", MPTCP_MIB_JOINACKMAC),
+	SNMP_MIB_ITEM("DSSNotMatching", MPTCP_MIB_DSSNOMATCH),
+	SNMP_MIB_ITEM("InfiniteMapRx", MPTCP_MIB_INFINITEMAPRX),
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
+			seq_puts(seq, " 0");
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
index 000000000000..d50b53e8209b
--- /dev/null
+++ b/net/mptcp/mib.h
@@ -0,0 +1,37 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+
+enum linux_mptcp_mib_field {
+	MPTCP_MIB_NUM =3D 0,
+	MPTCP_MIB_MPCAPABLEPASSIVE,	/* Received SYN with MP_CAPABLE */
+	MPTCP_MIB_MPCAPABLEPASSIVEACK,	/* Received third ACK with MP_CAPABLE */
+	MPTCP_MIB_MPCAPABLEPASSIVEFALLBACK,/* Server-side fallback during 3-way h=
andshake */
+	MPTCP_MIB_MPCAPABLEACTIVEFALLBACK, /* Client-side fallback during 3-way h=
andshake */
+	MPTCP_MIB_RETRANSSEGS,		/* Segments retransmitted at the MPTCP-level */
+	MPTCP_MIB_JOINNOTOKEN,		/* Received MP_JOIN but the token was not found */
+	MPTCP_MIB_JOINSYNRX,		/* Received a SYN + MP_JOIN */
+	MPTCP_MIB_JOINACKMAC,		/* HMAC was wrong on ACK + MP_JOIN */
+	MPTCP_MIB_DSSNOMATCH,		/* Received a new mapping that did not match the p=
revious one */
+	MPTCP_MIB_INFINITEMAPRX,	/* Received an infinite mapping */
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
index 3b13e0576a9b..093c7dac997c 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -18,6 +18,7 @@
 #include <net/tcp.h>
 #include <net/mptcp.h>
 #include "protocol.h"
+#include "mib.h"
 =

 static struct percpu_counter mptcp_sockets_allocated;
 =

@@ -862,16 +863,21 @@ static int __mptcp_init_sock(struct sock *sk)
 =

 static int mptcp_init_sock(struct sock *sk)
 {
-	int ret =3D __mptcp_init_sock(sk);
+	struct net *net =3D sock_net(sk);
+	int ret;
+
+	if (!mptcp_is_enabled(net))
+		return -ENOPROTOOPT;
 =

+	if (unlikely(!net->mib.mptcp_statistics) && !mptcp_mib_alloc(net))
+		return -ENOMEM;
+
+	ret =3D __mptcp_init_sock(sk);
 	if (ret)
 		return ret;
 =

 	sk_sockets_allocated_inc(sk);
 =

-	if (!mptcp_is_enabled(sock_net(sk)))
-		return -ENOPROTOOPT;
-
 	return 0;
 }
 =

-- =

2.21.0

--===============2851700515608944042==--
