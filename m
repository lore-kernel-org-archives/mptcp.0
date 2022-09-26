Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 330B44A14
	for <mptcp@lists.linux.dev>; Mon, 26 Sep 2022 23:27:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1664234868; x=1695770868;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=9am/bieXiysWtUx7w/8/1msQI6g+HrLkELye1uXSmPM=;
  b=V9xGZK5bYBT3tKVL0ffTG8GNXkuTkMwllm38e4HO8iW5o1c/YR2rxk6u
   bHfVimuWKbmbImhthapevetQ4UBOHo9tkyA1Vem2MZ17urtc/XOdhSWFs
   GK1OUeidKtFyNalzB/01ylCNh8Tq0ilrTs0vWjYkzcDfLwFfySwTJuoQP
   YyibbMwu5vjCJwe4Te6pTGg6mZHS3vC8aIeHOclbdvOPTK3wMDzyxDHKV
   sUgZgX4M+7TO6talsem9E/SGvZsmyxRKddvdQe4CfkuvyA1ID1fcXYn7d
   SkugFKUu4tHwPL4/VU5sOeehwDK8M8qjDItdeTmiSHfMnethTNbSqd0qN
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10482"; a="280890875"
X-IronPort-AV: E=Sophos;i="5.93,347,1654585200"; 
   d="scan'208";a="280890875"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2022 16:27:44 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10482"; a="572424287"
X-IronPort-AV: E=Sophos;i="5.93,347,1654585200"; 
   d="scan'208";a="572424287"
Received: from sankarka-mobl1.amr.corp.intel.com (HELO mjmartin-desk2.intel.com) ([10.209.3.132])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2022 16:27:44 -0700
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: netdev@vger.kernel.org
Cc: Dmytro Shytyi <dmytro@shytyi.net>,
	davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	benjamin.hesmans@tessares.net,
	matthieu.baerts@tessares.net,
	mptcp@lists.linux.dev,
	Mat Martineau <mathew.j.martineau@linux.intel.com>
Subject: [PATCH net-next 3/4] mptcp: handle defer connect in mptcp_sendmsg
Date: Mon, 26 Sep 2022 16:27:38 -0700
Message-Id: <20220926232739.76317-4-mathew.j.martineau@linux.intel.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20220926232739.76317-1-mathew.j.martineau@linux.intel.com>
References: <20220926232739.76317-1-mathew.j.martineau@linux.intel.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Dmytro Shytyi <dmytro@shytyi.net>

When TCP_FASTOPEN_CONNECT has been set on the socket before a connect,
the defer flag is set and must be handled when sendmsg is called.

This is similar to what is done in tcp_sendmsg_locked().

Acked-by: Paolo Abeni <pabeni@redhat.com>
Reviewed-by: Matthieu Baerts <matthieu.baerts@tessares.net>
Co-developed-by: Benjamin Hesmans <benjamin.hesmans@tessares.net>
Signed-off-by: Benjamin Hesmans <benjamin.hesmans@tessares.net>
Signed-off-by: Dmytro Shytyi <dmytro@shytyi.net>
Signed-off-by: Mat Martineau <mathew.j.martineau@linux.intel.com>
---
 net/mptcp/protocol.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 866dfad3cde6..fc753896caa0 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1677,6 +1677,7 @@ static int mptcp_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
 {
 	struct mptcp_sock *msk = mptcp_sk(sk);
 	struct page_frag *pfrag;
+	struct socket *ssock;
 	size_t copied = 0;
 	int ret = 0;
 	long timeo;
@@ -1690,6 +1691,27 @@ static int mptcp_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
 
 	lock_sock(sk);
 
+	ssock = __mptcp_nmpc_socket(msk);
+	if (unlikely(ssock && inet_sk(ssock->sk)->defer_connect)) {
+		struct sock *ssk = ssock->sk;
+		int copied_syn = 0;
+
+		lock_sock(ssk);
+
+		ret = tcp_sendmsg_fastopen(ssk, msg, &copied_syn, len, NULL);
+		copied += copied_syn;
+		if (ret == -EINPROGRESS && copied_syn > 0) {
+			/* reflect the new state on the MPTCP socket */
+			inet_sk_state_store(sk, inet_sk_state_load(ssk));
+			release_sock(ssk);
+			goto out;
+		} else if (ret) {
+			release_sock(ssk);
+			goto out;
+		}
+		release_sock(ssk);
+	}
+
 	timeo = sock_sndtimeo(sk, msg->msg_flags & MSG_DONTWAIT);
 
 	if ((1 << sk->sk_state) & ~(TCPF_ESTABLISHED | TCPF_CLOSE_WAIT)) {
-- 
2.37.3

