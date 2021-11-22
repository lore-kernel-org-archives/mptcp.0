Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [193.142.43.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D0612C81
	for <mptcp@lists.linux.dev>; Mon, 22 Nov 2021 11:22:23 +0000 (UTC)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
	(envelope-from <fw@breakpoint.cc>)
	id 1mp7Oo-0001QC-P4; Mon, 22 Nov 2021 12:22:14 +0100
From: Florian Westphal <fw@strlen.de>
To: <mptcp@lists.linux.dev>
Cc: Florian Westphal <fw@strlen.de>
Subject: [PATCH mptcp-next 1/2] mptcp: getsockopt: add support for IP_TOS
Date: Mon, 22 Nov 2021 12:22:04 +0100
Message-Id: <20211122112205.16752-1-fw@strlen.de>
X-Mailer: git-send-email 2.32.0
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

earlier patch added IP_TOS setsockopt support, this allows to get
the value set by earlier setsockopt.

Signed-off-by: Florian Westphal <fw@strlen.de>
---
 net/mptcp/sockopt.c | 33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/net/mptcp/sockopt.c b/net/mptcp/sockopt.c
index 11cda8629993..5626b49c0270 100644
--- a/net/mptcp/sockopt.c
+++ b/net/mptcp/sockopt.c
@@ -1066,6 +1066,24 @@ static int mptcp_put_int_option(struct mptcp_sock *msk, char __user *optval,
 	return 0;
 }
 
+static int mptcp_put_int8_option(struct mptcp_sock *msk, char __user *optval,
+				 int __user *optlen, u8 val)
+{
+	int len;
+
+	if (get_user(len, optlen))
+		return -EFAULT;
+
+	if (len) {
+		if (put_user(1, optlen))
+			return -EFAULT;
+		if (copy_to_user(optval, &val, 1))
+			return -EFAULT;
+	}
+
+	return 0;
+}
+
 static int mptcp_getsockopt_sol_tcp(struct mptcp_sock *msk, int optname,
 				    char __user *optval, int __user *optlen)
 {
@@ -1082,6 +1100,19 @@ static int mptcp_getsockopt_sol_tcp(struct mptcp_sock *msk, int optname,
 	return -EOPNOTSUPP;
 }
 
+static int mptcp_getsockopt_v4(struct mptcp_sock *msk, int optname,
+			       char __user *optval, int __user *optlen)
+{
+	struct sock *sk = (void *)msk;
+
+	switch (optname) {
+	case IP_TOS:
+		return mptcp_put_int8_option(msk, optval, optlen, inet_sk(sk)->tos);
+	}
+
+	return -EOPNOTSUPP;
+}
+
 static int mptcp_getsockopt_sol_mptcp(struct mptcp_sock *msk, int optname,
 				      char __user *optval, int __user *optlen)
 {
@@ -1117,6 +1148,8 @@ int mptcp_getsockopt(struct sock *sk, int level, int optname,
 	if (ssk)
 		return tcp_getsockopt(ssk, level, optname, optval, option);
 
+	if (level == SOL_IP)
+		return mptcp_getsockopt_v4(msk, optname, optval, option);
 	if (level == SOL_TCP)
 		return mptcp_getsockopt_sol_tcp(msk, optname, optval, option);
 	if (level == SOL_MPTCP)
-- 
2.32.0

