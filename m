Content-Type: multipart/mixed; boundary="===============8073652078822005707=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [RFC PATCH 3/5] tcp: init MPTCP option before parsing.
Date: Fri, 24 Apr 2020 19:14:10 +0200
Message-ID: <606694a5d5c7a74aa90f2bf6f8275933a17b626d.1587738345.git.pabeni@redhat.com>
In-Reply-To: cover.1587738345.git.pabeni@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 4244

--===============8073652078822005707==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The sub_options field carries per packet information,
The MPTCP option parsing will set the relevant bits according
to the ingress option.

Currently the sub_option field is cleared only on option
reset, so that a sub_option set by e.g. a packet later dropped
due to seq checks, will remain visible on next good packet.

The above allows out-of-windows packets to corrupt the mptcp
stream.

Fix the above clearing the sub_options field before options
parsing.

Additionally avoid explicitly clearing the add_addr sub-option
after processing it - no more needed, as it's now always
cleared before parsing.

Fixes: 648ef4b88673 ("mptcp: Implement MPTCP receive path")
Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>
---
 include/linux/tcp.h  | 1 -
 net/ipv4/tcp_input.c | 1 +
 net/mptcp/options.c  | 1 -
 3 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/include/linux/tcp.h b/include/linux/tcp.h
index b2b34db4f424..bc16bb3bcbd1 100644
--- a/include/linux/tcp.h
+++ b/include/linux/tcp.h
@@ -152,7 +152,6 @@ static inline void tcp_clear_options(struct tcp_options=
_received *rx_opt)
 #if IS_ENABLED(CONFIG_SMC)
 	rx_opt->smc_ok =3D 0;
 #endif
-	mptcp_init_options(rx_opt);
 }
 =

 /* This is the max number of SACKS that we'll generate and process. It's s=
afe
diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index bf4ced9273e8..738a0db29f77 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -3848,6 +3848,7 @@ void tcp_parse_options(const struct net *net,
 =

 	ptr =3D (const unsigned char *)(th + 1);
 	opt_rx->saw_tstamp =3D 0;
+	mptcp_init_options(opt_rx);
 =

 	while (length > 0) {
 		int opcode =3D *ptr++;
diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index 27e2ef63edcb..282f12772fe2 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -843,7 +843,6 @@ void mptcp_incoming_options(struct sock *sk, struct sk_=
buff *skb,
 #endif
 		if (!mp_opt->echo)
 			mptcp_pm_add_addr_received(msk, &addr);
-		mp_opt->sub_options &=3D ~BIT(MPTCPOPT_ADD_ADDR);
 	}
 =

 	if (!mptcp_option_dss(opt_rx))
-- =

2.21.1

--===============8073652078822005707==--
