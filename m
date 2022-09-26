Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 896D24A1E
	for <mptcp@lists.linux.dev>; Mon, 26 Sep 2022 23:27:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1664234868; x=1695770868;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=3eEN83FGptLBGWVNuc+N6UdQMdtD/faMYXdyfUdW2Ss=;
  b=eD0zSv4QiT2vaAHIS5CN4wWO2DO/AulY2rflgtuDbPPsHh+BHc9mXKVi
   9PFDgM7RGUJt4QMJ/Viw80f5xjR74788JPvJIZdQXMS+2C+Hkmx0+zcJI
   l0RVpcMhNPh2sV5OAU7vzoA0knTD2w3k3/ki/+bqSL6+jYs3WrevAV57l
   /3JmpW7gCUkNtTboXS9kPbfVvShHXebPbTk2wZMFp1WkU6xet6Q8IJzBA
   SQSuWgB21RlhbiRiZZBjStFkZciobvzS4Nb2EkbXFr8NgEw57f+GLsjTC
   Og4Nef3f3Vx+jaSCMrX5pJ71urY6VmSmmlrUYSRbMJflXQ6MS1tm/CMLv
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10482"; a="280890879"
X-IronPort-AV: E=Sophos;i="5.93,347,1654585200"; 
   d="scan'208";a="280890879"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2022 16:27:44 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10482"; a="572424288"
X-IronPort-AV: E=Sophos;i="5.93,347,1654585200"; 
   d="scan'208";a="572424288"
Received: from sankarka-mobl1.amr.corp.intel.com (HELO mjmartin-desk2.intel.com) ([10.209.3.132])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2022 16:27:44 -0700
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
Subject: [PATCH net-next 4/4] mptcp: poll allow write call before actual connect
Date: Mon, 26 Sep 2022 16:27:39 -0700
Message-Id: <20220926232739.76317-5-mathew.j.martineau@linux.intel.com>
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

If fastopen is used, poll must allow a first write that will trigger
the SYN+data

Similar to what is done in tcp_poll().

Acked-by: Paolo Abeni <pabeni@redhat.com>
Reviewed-by: Matthieu Baerts <matthieu.baerts@tessares.net>
Signed-off-by: Benjamin Hesmans <benjamin.hesmans@tessares.net>
Signed-off-by: Mat Martineau <mathew.j.martineau@linux.intel.com>
---
 net/mptcp/protocol.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index fc753896caa0..16c3a6fc347f 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -3548,6 +3548,7 @@ static int mptcp_stream_connect(struct socket *sock, struct sockaddr *uaddr,
 
 do_connect:
 	err = ssock->ops->connect(ssock, uaddr, addr_len, flags);
+	inet_sk(sock->sk)->defer_connect = inet_sk(ssock->sk)->defer_connect;
 	sock->state = ssock->state;
 
 	/* on successful connect, the msk state will be moved to established by
@@ -3698,6 +3699,9 @@ static __poll_t mptcp_poll(struct file *file, struct socket *sock,
 	if (state != TCP_SYN_SENT && state != TCP_SYN_RECV) {
 		mask |= mptcp_check_readable(msk);
 		mask |= mptcp_check_writeable(msk);
+	} else if (state == TCP_SYN_SENT && inet_sk(sk)->defer_connect) {
+		/* cf tcp_poll() note about TFO */
+		mask |= EPOLLOUT | EPOLLWRNORM;
 	}
 	if (sk->sk_shutdown == SHUTDOWN_MASK || state == TCP_CLOSE)
 		mask |= EPOLLHUP;
-- 
2.37.3

