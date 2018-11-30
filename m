Content-Type: multipart/mixed; boundary="===============4623015915970935266=="
MIME-Version: 1.0
From: Christoph Paasch <cpaasch at apple.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH 5/5] mptcp: Correctly initialize IPv6 fields
Date: Thu, 29 Nov 2018 17:05:14 -0800
Message-ID: <20181130010514.18251-6-cpaasch@apple.com>
In-Reply-To: 20181130010514.18251-1-cpaasch@apple.com
X-Status: 
X-Keywords:                  
X-UID: 851

--===============4623015915970935266==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

We are not correctly initializing all the IPv6 fields when creating an
IPv6 socket in mptcp_alloc_mpcb.
This creates problems when IPv6 extensions are being used.

Github-issue: https://github.com/multipath-tcp/mptcp/issues/266

Fixes: Zero-day bug
Reported-by: https://github.com/fduchene
Signed-off-by: Christoph Paasch <cpaasch(a)apple.com>
Signed-off-by: Matthieu Baerts <matthieu.baerts(a)tessares.net>
(cherry picked from commit 708e2af4d23882c74b08bcbb67eb9c42bbeb5aee)
Signed-off-by: Christoph Paasch <cpaasch(a)apple.com>
---
 net/mptcp/mptcp_ctrl.c | 30 ++++++++++++++++--------------
 1 file changed, 16 insertions(+), 14 deletions(-)

diff --git a/net/mptcp/mptcp_ctrl.c b/net/mptcp/mptcp_ctrl.c
index 626ccedd0878..916438e31b59 100644
--- a/net/mptcp/mptcp_ctrl.c
+++ b/net/mptcp/mptcp_ctrl.c
@@ -1159,32 +1159,34 @@ static int mptcp_alloc_mpcb(struct sock *meta_sk, _=
_u64 remote_key,
 =

 #if IS_ENABLED(CONFIG_IPV6)
 	if (meta_icsk->icsk_af_ops =3D=3D &mptcp_v6_mapped) {
+		struct tcp6_sock *master_tp6 =3D (struct tcp6_sock *)master_sk;
 		struct ipv6_pinfo *newnp, *np =3D inet6_sk(meta_sk);
 =

-		inet_sk(master_sk)->pinet6 =3D &((struct tcp6_sock *)master_sk)->inet6;
+		inet_sk(master_sk)->pinet6 =3D &master_tp6->inet6;
 =

 		newnp =3D inet6_sk(master_sk);
 		memcpy(newnp, np, sizeof(struct ipv6_pinfo));
-
-		newnp->ipv6_mc_list =3D NULL;
-		newnp->ipv6_ac_list =3D NULL;
-		newnp->ipv6_fl_list =3D NULL;
-		newnp->opt =3D NULL;
-		newnp->pktoptions =3D NULL;
-		(void)xchg(&newnp->rxpmtu, NULL);
 	} else if (meta_sk->sk_family =3D=3D AF_INET6) {
+		struct tcp6_sock *master_tp6 =3D (struct tcp6_sock *)master_sk;
 		struct ipv6_pinfo *newnp, *np =3D inet6_sk(meta_sk);
+		struct ipv6_txoptions *opt;
 =

-		inet_sk(master_sk)->pinet6 =3D &((struct tcp6_sock *)master_sk)->inet6;
+		inet_sk(master_sk)->pinet6 =3D &master_tp6->inet6;
 =

+		/* The following heavily inspired from tcp_v6_syn_recv_sock() */
 		newnp =3D inet6_sk(master_sk);
 		memcpy(newnp, np, sizeof(struct ipv6_pinfo));
 =

-		newnp->hop_limit	=3D -1;
-		newnp->mcast_hops	=3D IPV6_DEFAULT_MCASTHOPS;
-		newnp->mc_loop	=3D 1;
-		newnp->pmtudisc	=3D IPV6_PMTUDISC_WANT;
-		master_sk->sk_ipv6only =3D sock_net(master_sk)->ipv6.sysctl.bindv6only;
+		opt =3D rcu_dereference(np->opt);
+		if (opt) {
+			opt =3D ipv6_dup_options(master_sk, opt);
+			RCU_INIT_POINTER(newnp->opt, opt);
+		}
+		inet_csk(master_sk)->icsk_ext_hdr_len =3D 0;
+		if (opt)
+			inet_csk(master_sk)->icsk_ext_hdr_len =3D opt->opt_nflen +
+								opt->opt_flen;
+
 	}
 #endif
 =

-- =

2.16.2


--===============4623015915970935266==--
