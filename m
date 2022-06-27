Received: from mail-pj1-f68.google.com (mail-pj1-f68.google.com [209.85.216.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 573DA2C9E
	for <mptcp@lists.linux.dev>; Mon, 27 Jun 2022 12:16:44 +0000 (UTC)
Received: by mail-pj1-f68.google.com with SMTP id 73-20020a17090a0fcf00b001eaee69f600so9263737pjz.1
        for <mptcp@lists.linux.dev>; Mon, 27 Jun 2022 05:16:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=gzxBbJxhdHK6PNoavR99hps1yhOfCLiWPLboRKYj7ko=;
        b=ZRFbVcvsBqhinQXNr/BOVOG9sV99j1Dkygit4IkDetSqhua+BHHR6GqN5kV1qSnThz
         xIaiZ3SYUUAoXBZVhNgovSnGPg6F2yJOiZ/JVVa7dFDoHGNLVGe8FROiDZwnMefWq/G6
         ohPY9NdesHaJYPKSfhgQgU/xcW8rzUT9kgrzm8SuVV1BbKTi1VxbLATSiE13Zwkeg0Mn
         N1A9yQ8ekUkK8wWu6MKX09H4SNITQrJZZR/uzQeI360+EnGCpXu6srsBvpmDwdJ/G13o
         WWIg1foMw6ZmcZoDMjvA0khfRBdx8qnwYADyLxoNpFup+fno95QRfRBgVRoun4OBFpUE
         2G7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=gzxBbJxhdHK6PNoavR99hps1yhOfCLiWPLboRKYj7ko=;
        b=qsMSu6Wyti1MsDJt7phvrrUYP0D+WmgFRAyGkak/fxccQRukr371bEtGM0peDQJBxv
         7hhVmPr1TbGTaoCDrK57OGb89pxg42t+qp8C/dHpmt0cZQxdX5XzkwIwFL7ue/wqBxbB
         boVfdxGNs+Ustq+kQl4P3Ujx3iZrLjnNxQD6J2lKsV9KGWJY5QBFJFfOEdwXnHxOm/k2
         dv0g6Xzy1xoLF4u1LRSOCtjkdzV5ddG8wN3yNQUXX+Nk62HOocQakp6IyRnU1r0aFQS+
         MpMByCg+F9j2akqun1bjK/1n2ZfQj0Nt66YkantAeqtsFQrER+iSWmVoA4l00a2gYeXD
         nRAA==
X-Gm-Message-State: AJIora/iGKTba8HzY6CL/5YrgszjIH9Gkb3wbSWSY0jM7j2q9sJzvypz
	ufh91FXD8xhizjXdutrw0I8=
X-Google-Smtp-Source: AGRyM1tg6C4UQ21pl4+ohFSN9n9PXFWmzvYebZbqdMhPyjty+7iSxesWjR6H5X46le/MTfoHBdLS4A==
X-Received: by 2002:a17:90b:1d84:b0:1ed:5918:74e3 with SMTP id pf4-20020a17090b1d8400b001ed591874e3mr8785846pjb.173.1656332203802;
        Mon, 27 Jun 2022 05:16:43 -0700 (PDT)
Received: from localhost.localdomain ([203.205.141.82])
        by smtp.gmail.com with ESMTPSA id h6-20020a170902680600b00163ffe73300sm7057389plk.137.2022.06.27.05.16.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jun 2022 05:16:43 -0700 (PDT)
From: menglong8.dong@gmail.com
X-Google-Original-From: imagedong@tencent.com
To: kuba@kernel.org
Cc: mathew.j.martineau@linux.intel.com,
	matthieu.baerts@tessares.net,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	netdev@vger.kernel.org,
	mptcp@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Menglong Dong <imagedong@tencent.com>
Subject: [PATCH net-next] net: mptcp: fix some spelling mistake in mptcp
Date: Mon, 27 Jun 2022 20:16:25 +0800
Message-Id: <20220627121626.1595732-1-imagedong@tencent.com>
X-Mailer: git-send-email 2.36.1
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Menglong Dong <imagedong@tencent.com>

codespell finds some spelling mistake in mptcp:

net/mptcp/subflow.c:1624: interaces ==> interfaces
net/mptcp/pm_netlink.c:1130: regarless ==> regardless

Just fix them.

Signed-off-by: Menglong Dong <imagedong@tencent.com>
---
 net/mptcp/pm_netlink.c | 2 +-
 net/mptcp/subflow.c    | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index e099f2a12504..3de83e2a2611 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -1127,7 +1127,7 @@ void mptcp_pm_nl_subflow_chk_stale(const struct mptcp_sock *msk, struct sock *ss
 			}
 			unlock_sock_fast(ssk, slow);
 
-			/* always try to push the pending data regarless of re-injections:
+			/* always try to push the pending data regardless of re-injections:
 			 * we can possibly use backup subflows now, and subflow selection
 			 * is cheap under the msk socket lock
 			 */
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index 654cc602ff2c..8c3e699d3387 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -1621,7 +1621,7 @@ int mptcp_subflow_create_socket(struct sock *sk, struct socket **new_sock)
 	/* the newly created socket really belongs to the owning MPTCP master
 	 * socket, even if for additional subflows the allocation is performed
 	 * by a kernel workqueue. Adjust inode references, so that the
-	 * procfs/diag interaces really show this one belonging to the correct
+	 * procfs/diag interfaces really show this one belonging to the correct
 	 * user.
 	 */
 	SOCK_INODE(sf)->i_ino = SOCK_INODE(sk->sk_socket)->i_ino;
-- 
2.36.1

