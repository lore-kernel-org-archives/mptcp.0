Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC67772
	for <mptcp@lists.linux.dev>; Thu,  3 Jun 2021 23:24:45 +0000 (UTC)
IronPort-SDR: E45kW6A0BgBE5M1YaBikV2EZLHDgnMVCPU8KoA+qQzSYrSZdDp7WDcaRzM9mX7ej1GpiXVVEWS
 Kp89q3PiPGWQ==
X-IronPort-AV: E=McAfee;i="6200,9189,10004"; a="225487495"
X-IronPort-AV: E=Sophos;i="5.83,246,1616482800"; 
   d="scan'208";a="225487495"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2021 16:24:42 -0700
IronPort-SDR: l5WghZtRl96e7L0Cz4qoQakpjERN2TKNtFXS1Gl3Bom+bEAg+6IZ+yksfj8VOPEmud/kkl4UmN
 sYcEUI7ijF9A==
X-IronPort-AV: E=Sophos;i="5.83,246,1616482800"; 
   d="scan'208";a="483669041"
Received: from mjmartin-desk2.amr.corp.intel.com (HELO mjmartin-desk2.intel.com) ([10.251.3.143])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2021 16:24:42 -0700
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: netdev@vger.kernel.org
Cc: Florian Westphal <fw@strlen.de>,
	davem@davemloft.net,
	kuba@kernel.org,
	matthieu.baerts@tessares.net,
	mptcp@lists.linux.dev,
	Paolo Abeni <pabeni@redhat.com>,
	Mat Martineau <mathew.j.martineau@linux.intel.com>
Subject: [PATCH net-next 2/7] sock: expose so_timestamping options for mptcp
Date: Thu,  3 Jun 2021 16:24:28 -0700
Message-Id: <20210603232433.260703-3-mathew.j.martineau@linux.intel.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210603232433.260703-1-mathew.j.martineau@linux.intel.com>
References: <20210603232433.260703-1-mathew.j.martineau@linux.intel.com>
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Florian Westphal <fw@strlen.de>

Similar to previous patch: expose SO_TIMESTAMPING helper so we do not
have to copy & paste this into the mptcp core.

Acked-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Florian Westphal <fw@strlen.de>
Signed-off-by: Mat Martineau <mathew.j.martineau@linux.intel.com>
---
 include/net/sock.h |  2 ++
 net/core/sock.c    | 71 +++++++++++++++++++++++-----------------------
 2 files changed, 38 insertions(+), 35 deletions(-)

diff --git a/include/net/sock.h b/include/net/sock.h
index 7e0116b1a73f..9b341c2c924f 100644
--- a/include/net/sock.h
+++ b/include/net/sock.h
@@ -2744,6 +2744,8 @@ void sock_def_readable(struct sock *sk);
 
 int sock_bindtoindex(struct sock *sk, int ifindex, bool lock_sk);
 void sock_set_timestamp(struct sock *sk, int optname, bool valbool);
+int sock_set_timestamping(struct sock *sk, int optname, int val);
+
 void sock_enable_timestamps(struct sock *sk);
 void sock_no_linger(struct sock *sk);
 void sock_set_keepalive(struct sock *sk);
diff --git a/net/core/sock.c b/net/core/sock.c
index 5b85dd37b562..bd887cb075ce 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -794,6 +794,40 @@ void sock_set_timestamp(struct sock *sk, int optname, bool valbool)
 	}
 }
 
+int sock_set_timestamping(struct sock *sk, int optname, int val)
+{
+	if (val & ~SOF_TIMESTAMPING_MASK)
+		return -EINVAL;
+
+	if (val & SOF_TIMESTAMPING_OPT_ID &&
+	    !(sk->sk_tsflags & SOF_TIMESTAMPING_OPT_ID)) {
+		if (sk->sk_protocol == IPPROTO_TCP &&
+		    sk->sk_type == SOCK_STREAM) {
+			if ((1 << sk->sk_state) &
+			    (TCPF_CLOSE | TCPF_LISTEN))
+				return -EINVAL;
+			sk->sk_tskey = tcp_sk(sk)->snd_una;
+		} else {
+			sk->sk_tskey = 0;
+		}
+	}
+
+	if (val & SOF_TIMESTAMPING_OPT_STATS &&
+	    !(val & SOF_TIMESTAMPING_OPT_TSONLY))
+		return -EINVAL;
+
+	sk->sk_tsflags = val;
+	sock_valbool_flag(sk, SOCK_TSTAMP_NEW, optname == SO_TIMESTAMPING_NEW);
+
+	if (val & SOF_TIMESTAMPING_RX_SOFTWARE)
+		sock_enable_timestamp(sk,
+				      SOCK_TIMESTAMPING_RX_SOFTWARE);
+	else
+		sock_disable_timestamp(sk,
+				       (1UL << SOCK_TIMESTAMPING_RX_SOFTWARE));
+	return 0;
+}
+
 void sock_set_keepalive(struct sock *sk)
 {
 	lock_sock(sk);
@@ -1012,43 +1046,10 @@ int sock_setsockopt(struct socket *sock, int level, int optname,
 	case SO_TIMESTAMPNS_NEW:
 		sock_set_timestamp(sk, valbool, optname);
 		break;
+
 	case SO_TIMESTAMPING_NEW:
 	case SO_TIMESTAMPING_OLD:
-		if (val & ~SOF_TIMESTAMPING_MASK) {
-			ret = -EINVAL;
-			break;
-		}
-
-		if (val & SOF_TIMESTAMPING_OPT_ID &&
-		    !(sk->sk_tsflags & SOF_TIMESTAMPING_OPT_ID)) {
-			if (sk->sk_protocol == IPPROTO_TCP &&
-			    sk->sk_type == SOCK_STREAM) {
-				if ((1 << sk->sk_state) &
-				    (TCPF_CLOSE | TCPF_LISTEN)) {
-					ret = -EINVAL;
-					break;
-				}
-				sk->sk_tskey = tcp_sk(sk)->snd_una;
-			} else {
-				sk->sk_tskey = 0;
-			}
-		}
-
-		if (val & SOF_TIMESTAMPING_OPT_STATS &&
-		    !(val & SOF_TIMESTAMPING_OPT_TSONLY)) {
-			ret = -EINVAL;
-			break;
-		}
-
-		sk->sk_tsflags = val;
-		sock_valbool_flag(sk, SOCK_TSTAMP_NEW, optname == SO_TIMESTAMPING_NEW);
-
-		if (val & SOF_TIMESTAMPING_RX_SOFTWARE)
-			sock_enable_timestamp(sk,
-					      SOCK_TIMESTAMPING_RX_SOFTWARE);
-		else
-			sock_disable_timestamp(sk,
-					       (1UL << SOCK_TIMESTAMPING_RX_SOFTWARE));
+		ret = sock_set_timestamping(sk, optname, val);
 		break;
 
 	case SO_RCVLOWAT:
-- 
2.31.1

