Received: from mail-m155101.qiye.163.com (mail-m155101.qiye.163.com [101.71.155.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3567F2FD1CA
	for <mptcp@lists.linux.dev>; Tue, 11 Aug 2026 05:35:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=101.71.155.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786426526; cv=none; b=FxbMHjVzAJMDEiCm7VXB9Oa1v1FhY48iHPhMW64gqY1GgbAeRfp/PmnOiWaf/Py4Qs8BzLNz9fLl+AvIwcgi4iO3f5KtPGCO2mMyb8X/+iVA0nn0wiy+gpTHaxD9GqdK7Mutk43Y1BfERbnN84EcdiYfTr2zolpxfMD6fbW8ykw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786426526; c=relaxed/simple;
	bh=aWmM7i79Sf9A3sGfbhbZNIJbuRUI5oNCsjKZwtIq4mI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=JZZbhHxxIidIWnn4GbBkK8CAGlQq4e+AOiYg36fTn3pNOdosRhcwgpLQtN/eueFKKHsokeQyIH7+vqGoJ+JNL07kJu4XhH2DtrvWH1W/HmQW1NmMZY0ZQv67FyzD5kdJxEx05rtcBwtXshBcJCWU4dKOAysgXiztn2gaQNlic4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn; spf=pass smtp.mailfrom=seu.edu.cn; dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b=YwK3TA6K; arc=none smtp.client-ip=101.71.155.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b="YwK3TA6K"
Received: from PC-202605011814.localdomain (unknown [222.191.246.242])
	by smtp.qiye.163.com (Hmail) with ESMTP id 4986103fe;
	Tue, 11 Aug 2026 13:35:17 +0800 (GMT+08:00)
From: Runyu Xiao <runyu.xiao@seu.edu.cn>
To: mptcp@lists.linux.dev
Cc: Matthieu Baerts <matttbe@kernel.org>,
	Mat Martineau <martineau@kernel.org>,
	Geliang Tang <geliang@kernel.org>,
	Gang Yan <gang.yan@linux.dev>,
	Eric Dumazet <edumazet@google.com>,
	Runyu Xiao <runyu.xiao@seu.edu.cn>,
	Jianhao Xu <jianhao.xu@seu.edu.cn>
Subject: [PATCH net v2] mptcp: upgrade network refcount before socket lock
Date: Tue, 11 Aug 2026 13:35:07 +0800
Message-Id: <20260811053507.354166-1-runyu.xiao@seu.edu.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260809091949.3618191-1-runyu.xiao@seu.edu.cn>
References: <20260809091949.3618191-1-runyu.xiao@seu.edu.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9fef5165c703a1kunmc5a696f1d1d23
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVkZTx5DVhkdGBpMTE9LGUJMTVYeHw
	5VEwETFhoSFyQUDg9ZV1kYEgtZQVlJSUlVSkJKVUlPTVVJT0lZV1kWGg8SFR0UWUFZT0tIVUpLSE
	pPSExVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=YwK3TA6Kxn/MAOhCnwjkcmORyvL6GcQjeI6UdeHsIhHNdgbIjhxkrQCpl8suiE4EddYhKe/rFLsFWOk3IyrBuDIfKKTx6yUFCUYx9EDKSP5U6jSgXBBn/Ni8YJcqrn1jeNwXI9QEGBoRV+E36J2/zucC6IB+aPQ3Xsa1Niptktk=; s=default; c=relaxed/relaxed; d=seu.edu.cn; v=1;
	bh=FK/1bCUxO9nuOjUZBSqxv7UY6YqQug+/zIprXJ16hjA=;
	h=date:mime-version:subject:message-id:from;

sk_net_refcnt_upgrade() is called after lock_sock_nested() in
mptcp_subflow_create_socket(), while other callers perform the upgrade
before taking the socket lock.

Move sk_net_refcnt_upgrade() before lock_sock_nested(). The subflow
socket is newly created and unpublished at this point, so sk_net_refcnt
and ns_tracker are not accessed concurrently, and the existing error
path via sock_release() remains unchanged.

Acked-by: Gang Yan <gang.yan@linux.dev>
Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Runyu Xiao <runyu.xiao@seu.edu.cn>
---
Changes in v2:
- Shorten the commit message and remove the validation-method details.
- Describe the change in terms of the pre-lock upgrade ordering.
- Add Acked-by from Gang Yan.
- Add Reviewed-by from Matthieu Baerts.

 net/mptcp/subflow.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index e1f20ff8fdb4..a9f951cc6a0e 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -1786,6 +1786,12 @@ int mptcp_subflow_create_socket(struct sock *sk, unsigned short family,
 	if (err)
 		return err;
 
+	/* kernel sockets do not by default acquire net ref, but TCP timer
+	 * needs it.
+	 * Update ns_tracker to current stack trace and refcounted tracker.
+	 */
+	sk_net_refcnt_upgrade(sf->sk);
+
 	lock_sock_nested(sf->sk, SINGLE_DEPTH_NESTING);
 
 	err = security_mptcp_add_subflow(sk, sf->sk);
@@ -1795,11 +1801,6 @@ int mptcp_subflow_create_socket(struct sock *sk, unsigned short family,
 	/* the newly created socket has to be in the same cgroup as its parent */
 	mptcp_attach_cgroup(sk, sf->sk);
 
-	/* kernel sockets do not by default acquire net ref, but TCP timer
-	 * needs it.
-	 * Update ns_tracker to current stack trace and refcounted tracker.
-	 */
-	sk_net_refcnt_upgrade(sf->sk);
 	err = tcp_set_ulp(sf->sk, "mptcp");
 	if (err)
 		goto err_free;
-- 
2.34.1
