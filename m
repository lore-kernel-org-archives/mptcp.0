Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A83CC2FB1
	for <mptcp@lists.linux.dev>; Mon, 24 May 2021 07:07:32 +0000 (UTC)
Received: by mail-pl1-f181.google.com with SMTP id t9so5718751ply.6
        for <mptcp@lists.linux.dev>; Mon, 24 May 2021 00:07:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6tBDnem+GRr3Yp1J3jzoIdFTAD2zLVvLxYqEMafhVZ4=;
        b=NrkGjjndKSsfRjGaRYgexn0e4NXlfx9HG8zAhrzzWUUQZWWNuh49utEAZrnYslf/4P
         utLdWYxUT3qcM6C6WmO87sUwYXSqEh1XaFUFg7RO8L/7S5LpR7YKa0TJ6yy9QjYPfnAG
         tbI5Zq17fMf95SlWzHCb659FQaDIQkqETtdEQkAo/GhCNZIbV7JXaOoxoWKLtf84Z1Qu
         H9NC6g5QKxK2c0Yd9nocT5PTqhc0cLs4bQiUM40mOQGMC7FJxVLOslRYKN9DDDyFoWXe
         YHt1twTSZCAfzcW1SYWTyMCI0kzCxkFgCP3u2Dtw6uMY2zD5bE6Cg1W3AOZcMiRGQj6J
         xmsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6tBDnem+GRr3Yp1J3jzoIdFTAD2zLVvLxYqEMafhVZ4=;
        b=WSHcpSplOx9t2QCxNEND0Wzo+xWeUPz4cgi7TGZK9EjrrKyVEEFgpBejFUTjK4dy3E
         0Y/lk75/lZp1zTkcuTVmtmmRBweiYybQCb+ohfkr753JEG0hZsN85oHsuBesyyFGU0kk
         3chGjV4EG0j8KePziFvc4dzXZOwMtumovdOvyBLyyU6rFlSKGZYkj4y51AqWQ2pX7n78
         79dwLANmxUJifMojOHeNSoVjhIj+23WOZw3zbhxpKY2H/kJZiyhKAD71fkYtlMIwihME
         qnK4s98Ol25sbrvU9O9N+ihT0aRtexNrcxIVbdk6N3hsMXS3GXp/POjcE7KdojiaaFPp
         kAhA==
X-Gm-Message-State: AOAM530MVtnQyGjOY6aiO2k0ZTkKdF7PP2meQzlA3AQrTtff6lHROoXq
	jjmnguOHAmjFYORDAscs+vu/QjUs5HB7Hw==
X-Google-Smtp-Source: ABdhPJzP0N5r6YyyLLc7268ldzwdRY+HK+qUq3q64ZEiHOOj6fFquIT2CcNNbGK44QKPuIzJZabIrA==
X-Received: by 2002:a17:90a:6ace:: with SMTP id b14mr23990118pjm.142.1621840052199;
        Mon, 24 May 2021 00:07:32 -0700 (PDT)
Received: from localhost ([209.9.72.213])
        by smtp.gmail.com with ESMTPSA id d22sm10407107pgb.15.2021.05.24.00.07.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 May 2021 00:07:32 -0700 (PDT)
From: Geliang Tang <geliangtang@gmail.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliangtang@gmail.com>
Subject: [MPTCP][PATCH v7 mptcp-next 3/5] mptcp: add add_cached in mptcp_pm_data
Date: Mon, 24 May 2021 15:07:17 +0800
Message-Id: <c27772875a9bf14dd336526f48676f368758be97.1621839764.git.geliangtang@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <372e8fb0d481dfed41cf7e01c60b18c55a852f7e.1621839764.git.geliangtang@gmail.com>
References: <cover.1621839764.git.geliangtang@gmail.com> <7df5c99cf5336e3c1b0225903c75d01bbcde8daf.1621839764.git.geliangtang@gmail.com> <372e8fb0d481dfed41cf7e01c60b18c55a852f7e.1621839764.git.geliangtang@gmail.com>
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch added a new member add_cached in struct mptcp_pm_data, to
track the most recent received ADD_ADDR information. Also invalidate
it if a matching REMOVE_ADDR is received.

Signed-off-by: Geliang Tang <geliangtang@gmail.com>
---
 net/mptcp/pm.c         | 1 +
 net/mptcp/pm_netlink.c | 3 +++
 net/mptcp/protocol.h   | 1 +
 3 files changed, 5 insertions(+)

diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index 9d00fa6d22e9..edc57ff4c1dd 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -316,6 +316,7 @@ void mptcp_pm_data_init(struct mptcp_sock *msk)
 	msk->pm.subflows = 0;
 	msk->pm.rm_list_tx.nr = 0;
 	msk->pm.rm_list_rx.nr = 0;
+	msk->pm.add_cached.id = 0;
 	WRITE_ONCE(msk->pm.work_pending, false);
 	WRITE_ONCE(msk->pm.addr_signal, 0);
 	WRITE_ONCE(msk->pm.accept_addr, false);
diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index 09722598994d..795f6d84bbfc 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -515,6 +515,7 @@ static void mptcp_pm_nl_add_addr_received(struct mptcp_sock *msk)
 		remote.port = sk->sk_dport;
 	memset(&local, 0, sizeof(local));
 	local.family = remote.family;
+	msk->pm.add_cached = remote;
 
 	spin_unlock_bh(&msk->pm.lock);
 	__mptcp_subflow_connect(sk, &local, &remote, 0, 0);
@@ -631,6 +632,8 @@ static void mptcp_pm_nl_rm_addr_or_subflow(struct mptcp_sock *msk,
 			if (rm_type == MPTCP_MIB_RMADDR) {
 				msk->pm.add_addr_accepted--;
 				WRITE_ONCE(msk->pm.accept_addr, true);
+				if (msk->pm.add_cached.id == id)
+					msk->pm.add_cached.id = 0;
 			} else if (rm_type == MPTCP_MIB_RMSUBFLOW) {
 				msk->pm.local_addr_used--;
 			}
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 1201ab04bcdf..d28f6cdc9798 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -185,6 +185,7 @@ struct mptcp_pm_data {
 	struct mptcp_addr_info local;
 	struct mptcp_addr_info remote;
 	struct list_head anno_list;
+	struct mptcp_addr_info add_cached;
 
 	spinlock_t	lock;		/*protects the whole PM data */
 
-- 
2.31.1

