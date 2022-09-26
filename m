Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5D894A1E
	for <mptcp@lists.linux.dev>; Mon, 26 Sep 2022 23:27:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1664234866; x=1695770866;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=pFuL3oGB1skylBc+oR2zLed0XO1DUoAGU+z8uS8xsQU=;
  b=bYIUrc2bqCq485cnCz25SmEMsHkOyws9WGdqrNrxKUCYoXPYdOA+rM/a
   QC7t/iBbIYb67jdVYiDT8jvqY+8nJzWAU8VyGci0uJ2Xb2tsb8TQdQmwf
   U5H5qP/6ZSAMzq9axI6u531HysXw2KxihFqG3Lv5YWQShI4kIZvU4su7u
   WLM7ceknwPFspg1BNavfsZL74aulrOvyMwbKTXidf/w7wG2i8W8ZJgGBh
   kuejQ+xO8169GDJMikJnBEaajZheq0vteJuz/n69IesTiguiEnPjDaroh
   MzYqRMlwGB+51PTI0IEJna4jplkpmUJIadnLG30nYbH20Al34SirrlFKq
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10482"; a="280890871"
X-IronPort-AV: E=Sophos;i="5.93,347,1654585200"; 
   d="scan'208";a="280890871"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2022 16:27:44 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10482"; a="572424286"
X-IronPort-AV: E=Sophos;i="5.93,347,1654585200"; 
   d="scan'208";a="572424286"
Received: from sankarka-mobl1.amr.corp.intel.com (HELO mjmartin-desk2.intel.com) ([10.209.3.132])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2022 16:27:43 -0700
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: netdev@vger.kernel.org
Cc: Benjamin Hesmans <benjamin.hesmans@tessares.net>,
	davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	dmytro@shytyi.net,
	matthieu.baerts@tessares.net,
	mptcp@lists.linux.dev,
	Mat Martineau <mathew.j.martineau@linux.intel.com>
Subject: [PATCH net-next 2/4] tcp: export tcp_sendmsg_fastopen
Date: Mon, 26 Sep 2022 16:27:37 -0700
Message-Id: <20220926232739.76317-3-mathew.j.martineau@linux.intel.com>
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

From: Benjamin Hesmans <benjamin.hesmans@tessares.net>

It will be used to support TCP FastOpen with MPTCP in the following
commit.

Acked-by: Paolo Abeni <pabeni@redhat.com>
Reviewed-by: Matthieu Baerts <matthieu.baerts@tessares.net>
Co-developed-by: Dmytro Shytyi <dmytro@shytyi.net>
Signed-off-by: Dmytro Shytyi <dmytro@shytyi.net>
Signed-off-by: Benjamin Hesmans <benjamin.hesmans@tessares.net>
Signed-off-by: Mat Martineau <mathew.j.martineau@linux.intel.com>
---
 include/net/tcp.h | 2 ++
 net/ipv4/tcp.c    | 5 ++---
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/include/net/tcp.h b/include/net/tcp.h
index 27e8d378c70a..4f71cc15ff8e 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -327,6 +327,8 @@ void tcp_remove_empty_skb(struct sock *sk);
 int tcp_v4_tw_remember_stamp(struct inet_timewait_sock *tw);
 int tcp_sendmsg(struct sock *sk, struct msghdr *msg, size_t size);
 int tcp_sendmsg_locked(struct sock *sk, struct msghdr *msg, size_t size);
+int tcp_sendmsg_fastopen(struct sock *sk, struct msghdr *msg, int *copied,
+			 size_t size, struct ubuf_info *uarg);
 int tcp_sendpage(struct sock *sk, struct page *page, int offset, size_t size,
 		 int flags);
 int tcp_sendpage_locked(struct sock *sk, struct page *page, int offset,
diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index 5702ca9b952d..5237a3f08c94 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -1162,9 +1162,8 @@ void tcp_free_fastopen_req(struct tcp_sock *tp)
 	}
 }
 
-static int tcp_sendmsg_fastopen(struct sock *sk, struct msghdr *msg,
-				int *copied, size_t size,
-				struct ubuf_info *uarg)
+int tcp_sendmsg_fastopen(struct sock *sk, struct msghdr *msg, int *copied,
+			 size_t size, struct ubuf_info *uarg)
 {
 	struct tcp_sock *tp = tcp_sk(sk);
 	struct inet_sock *inet = inet_sk(sk);
-- 
2.37.3

