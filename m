Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [193.142.43.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1C3E2FAF
	for <mptcp@lists.linux.dev>; Wed, 11 Aug 2021 13:15:57 +0000 (UTC)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
	(envelope-from <fw@breakpoint.cc>)
	id 1mDo5M-0008VY-0J; Wed, 11 Aug 2021 15:15:56 +0200
From: Florian Westphal <fw@strlen.de>
To: <mptcp@lists.linux.dev>
Cc: Florian Westphal <fw@strlen.de>
Subject: [PATCH mptcp-next 4/5] mptcp: add MPTCP_SUBFLOW_ADDRS getsockopt support
Date: Wed, 11 Aug 2021 15:15:22 +0200
Message-Id: <20210811131523.6339-5-fw@strlen.de>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210811131523.6339-1-fw@strlen.de>
References: <20210811131523.6339-1-fw@strlen.de>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This retrieves the address pairs of all subflows currently
active for a given mptcp connection.

It re-uses the same meta-header as for MPTCP_TCPINFO.

A new structure is provided to hold the subflow
address data:

struct mptcp_subflow_addrs {
	union {
		sa_family_t sa_family;
		struct sockaddr sa_local;
		struct sockaddr_in sin_local;
		struct sockaddr_in6 sin6_local;
		struct sockaddr_storage ss_local;
	};
	union {
		struct sockaddr sa_remote;
		struct sockaddr_in sin_remote;
		struct sockaddr_in6 sin6_remote;
		struct sockaddr_storage ss_remote;
	};
};

Usage of the new getsockopt is very similar to
MPTCP_TCPINFO one.

Userspace allocates a
'struct mptcp_subflow_data', followed by one or
more 'struct mptcp_subflow_addrs', then inits the
mptcp_subflow_data structure as follows:

struct mptcp_subflow_addrs *sf_addr;
struct mptcp_subflow_data *addr;
socklen_t olen = sizeof(*addr) + (8 * sizeof(*sf_addr));

addr = malloc(olen);
addr->size_subflow_data = sizeof(*addr);
addr->num_subflows = 0;
addr->size_kernel = 0;
addr->size_user = sizeof(struct mptcp_subflow_addrs);

sf_addr = (struct mptcp_subflow_addrs *)(addr + 1);

and then retrieves the endpoint addresses via:
ret = getsockopt(fd, SOL_MPTCP, MPTCP_SUBFLOW_ADDRS,
		 addr, &olen);

If the call succeeds, kernel will have added up to 8
endpoint addresses after the 'mptcp_subflow_data' header.

Userspace needs to re-check 'olen' value to detect how
many bytes have been filled in by the kernel.

Userspace can check addr->num_subflows to discover when
there were more subflows that available data space.

Signed-off-by: Florian Westphal <fw@strlen.de>
---
 include/uapi/linux/mptcp.h | 17 +++++++
 net/mptcp/sockopt.c        | 96 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 113 insertions(+)

diff --git a/include/uapi/linux/mptcp.h b/include/uapi/linux/mptcp.h
index 7c368fccd83e..f6cfd2c4ca5b 100644
--- a/include/uapi/linux/mptcp.h
+++ b/include/uapi/linux/mptcp.h
@@ -201,8 +201,25 @@ struct mptcp_subflow_data {
 	__u32		size_user;			/* size of one element in data[] */
 } __attribute__((aligned(8)));
 
+struct mptcp_subflow_addrs {
+	union {
+		sa_family_t sa_family;
+		struct sockaddr sa_local;
+		struct sockaddr_in sin_local;
+		struct sockaddr_in6 sin6_local;
+		struct sockaddr_storage ss_local;
+	};
+	union {
+		struct sockaddr sa_remote;
+		struct sockaddr_in sin_remote;
+		struct sockaddr_in6 sin6_remote;
+		struct sockaddr_storage ss_remote;
+	};
+};
+
 /* MPTCP socket options */
 #define MPTCP_INFO		1
 #define MPTCP_TCPINFO		2
+#define MPTCP_SUBFLOW_ADDRS	3
 
 #endif /* _UAPI_MPTCP_H */
diff --git a/net/mptcp/sockopt.c b/net/mptcp/sockopt.c
index ac8e6823db4f..a30bc848ffcb 100644
--- a/net/mptcp/sockopt.c
+++ b/net/mptcp/sockopt.c
@@ -817,6 +817,100 @@ static int mptcp_getsockopt_tcpinfo(struct mptcp_sock *msk, char __user *optval,
 	return 0;
 }
 
+static void mptcp_get_sub_addrs(const struct sock *sk, struct mptcp_subflow_addrs *a)
+{
+	struct inet_sock *inet = inet_sk(sk);
+
+	memset(a, 0, sizeof(*a));
+
+	if (sk->sk_family == AF_INET) {
+		a->sin_local.sin_family = AF_INET;
+		a->sin_local.sin_port = inet->inet_sport;
+		a->sin_local.sin_addr.s_addr = inet->inet_rcv_saddr;
+
+		if (!a->sin_local.sin_addr.s_addr)
+			a->sin_local.sin_addr.s_addr = inet->inet_saddr;
+
+		a->sin_remote.sin_family = AF_INET;
+		a->sin_remote.sin_port = inet->inet_dport;
+		a->sin_remote.sin_addr.s_addr = inet->inet_daddr;
+#if IS_ENABLED(CONFIG_IPV6)
+	} else if (sk->sk_family == AF_INET6) {
+		const struct ipv6_pinfo *np = inet6_sk(sk);
+
+		a->sin6_local.sin6_family = AF_INET6;
+		a->sin6_local.sin6_port = inet->inet_sport;
+
+		if (ipv6_addr_any(&sk->sk_v6_rcv_saddr))
+			a->sin6_local.sin6_addr = np->saddr;
+		else
+			a->sin6_local.sin6_addr = sk->sk_v6_rcv_saddr;
+
+		a->sin6_remote.sin6_family = AF_INET6;
+		a->sin6_remote.sin6_port = inet->inet_dport;
+		a->sin6_remote.sin6_addr = sk->sk_v6_daddr;
+#endif
+	}
+}
+
+static int mptcp_getsockopt_subflow_addrs(struct mptcp_sock *msk, char __user *optval,
+					  int __user *_u_optlen)
+{
+	struct mptcp_subflow_context *subflow;
+	struct sock *sk = &msk->sk.icsk_inet.sk;
+	unsigned int sfcount = 0, copied = 0;
+	struct mptcp_subflow_data sfd;
+	char __user *addrptr;
+	int len;
+
+	len = mptcp_get_subflow_data(&sfd, optval, _u_optlen);
+	if (len < 0)
+		return len;
+
+	sfd.size_kernel = sizeof(struct mptcp_subflow_addrs);
+	sfd.size_user = min_t(unsigned int, sfd.size_user,
+			      sizeof(struct mptcp_subflow_addrs));
+
+	addrptr = optval + sfd.size_subflow_data;
+
+	lock_sock(sk);
+
+	mptcp_for_each_subflow(msk, subflow) {
+		struct sock *ssk = mptcp_subflow_tcp_sock(subflow);
+
+		++sfcount;
+
+		if (len >= sfd.size_user) {
+			struct mptcp_subflow_addrs a;
+
+			mptcp_get_sub_addrs(ssk, &a);
+
+			if (copy_to_user(addrptr, &a, sfd.size_user)) {
+				release_sock(sk);
+				return -EFAULT;
+			}
+
+			addrptr += sfd.size_user;
+			copied += sfd.size_user;
+			len -= sfd.size_user;
+		}
+	}
+
+	release_sock(sk);
+
+	copied += sfd.size_subflow_data;
+
+	if (put_user(copied, _u_optlen))
+		return -EFAULT;
+
+	sfd.num_subflows = sfcount;
+
+	if (copy_to_user(optval, &sfd, sfd.size_subflow_data))
+		return -EFAULT;
+
+	return 0;
+}
+
 static int mptcp_getsockopt_sol_tcp(struct mptcp_sock *msk, int optname,
 				    char __user *optval, int __user *optlen)
 {
@@ -839,6 +933,8 @@ static int mptcp_getsockopt_sol_mptcp(struct mptcp_sock *msk, int optname,
 		return mptcp_getsockopt_info(msk, optval, optlen);
 	case MPTCP_TCPINFO:
 		return mptcp_getsockopt_tcpinfo(msk, optval, optlen);
+	case MPTCP_SUBFLOW_ADDRS:
+		return mptcp_getsockopt_subflow_addrs(msk, optval, optlen);
 	}
 
 	return -EOPNOTSUPP;
-- 
2.31.1

