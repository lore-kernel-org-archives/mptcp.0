Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF3451E411D
	for <mptcp@lists.linux.dev>; Wed, 30 Oct 2024 14:02:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730296965; cv=none; b=UNfn4nc2sRHZpbp/SS61kmc3ny7WIGpg2nmMG7mrm8y0Mdniqo8O0Ep9yvkZLh0l0cD3+ZramvVP2EXmfhStjsndDAjPPSN9R51Jzjv4svhtJsrwzyZ3B0nmi3B/sv4qwTsjopTVuco1QZK6Y/gjiTjJBxRS3Ds5xWgb8B1xQBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730296965; c=relaxed/simple;
	bh=IRPUtmjRRRWTQls7HsvP5G4WzpSHfHn5+ycAibYhoto=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=B9Y0FcP6fUGU9xJnjsfVJvV/YPmmbnzA8vegKSPFu+UF4T9rZagf9hE72jEal0NHTdBqSFF1UTpQhQVKOR3LfaxCxRnes4hD9stoicxokKbcQHule9vZMlwGc3b+uJ+DlUkzZC4IOEEj9jtq0l793RuSDlS8BDVVX5nIebmnjF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a9a6b4ca29bso817677766b.3
        for <mptcp@lists.linux.dev>; Wed, 30 Oct 2024 07:02:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730296961; x=1730901761;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YGmFgroH7JaHubQUsglUYJKecaiUoqcN47UqSxEZ5cA=;
        b=WvjiSUOykTKt6hm5PRIf6j0c+1W+R6uYbxpRMwOJAdH76qvP58zP2U9zJ2oYCJo11e
         NDFpcDjpcimXYciYrrGqNO7u+dFKw92BhCbz+xjzyiDkP2s3tfT6myiUbornFWbz9uQS
         ln3LaYiURf6kF3jJrZbfIy6BFEiAVvKOC4B7SiHVQq23X83+Bza4nC7vKy4x4N3WlQnh
         0kB7jGVYasmEZOBkc/2IjD9mH69UrWRcIBwIzXn9Mw254ecPyzoHa4YnE4jsLtPOdDtH
         Mo68eHA36a5UmPGI3sFmgmhT0AceMtbVNPUi9V3VQ9KoeQ9laoexFu3/4DMilIJEkZM7
         lpmA==
X-Forwarded-Encrypted: i=1; AJvYcCUCFPYl5xyaACFm11pt4c3N5yOUDtCAwhrnUG6rw7FbFHQTYrH+IHYlCnA71aiVcv1rsZt5PA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yy2jxgKP3rlvpwiBEijGDAEBWwyGFn2eHplEEjLCPNJOlpya12/
	TeB8iz0QmFl1ZojssCcNJLwL/bplXDo8ErSseSIkb3V6jaWqP478LIO06Q==
X-Google-Smtp-Source: AGHT+IFLheYALN0Q+h1qZVZyYyfGjs+k4p0+ar7AYK/KpTy5X6XvSJSR4jgGNXMTmFntMr8STHZ0mQ==
X-Received: by 2002:a17:907:7f8b:b0:a99:499f:4cb7 with SMTP id a640c23a62f3a-a9de5ce4e4amr1512071666b.23.1730296960746;
        Wed, 30 Oct 2024 07:02:40 -0700 (PDT)
Received: from localhost (fwdproxy-lla-000.fbsv.net. [2a03:2880:30ff::face:b00c])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9b1dec7aa9sm576513066b.35.2024.10.30.07.02.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Oct 2024 07:02:40 -0700 (PDT)
From: Breno Leitao <leitao@debian.org>
To: kuba@kernel.org,
	horms@kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	Matthieu Baerts <matttbe@kernel.org>,
	Mat Martineau <martineau@kernel.org>,
	Geliang Tang <geliang@kernel.org>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	vlad.wing@gmail.com,
	max@kutsevol.com,
	kernel-team@meta.com,
	aehkn@xenhub.one,
	stable@vger.kernel.org,
	mptcp@lists.linux.dev (open list:NETWORKING [MPTCP])
Subject: [PATCH net] mptcp: Ensure RCU read lock is held when calling mptcp_sched_find()
Date: Wed, 30 Oct 2024 07:02:23 -0700
Message-ID: <20241030140224.972565-1-leitao@debian.org>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The mptcp_sched_find() function must be called with the RCU read lock
held, as it accesses RCU-protected data structures. This requirement was
not properly enforced in the mptcp_init_sock() function, leading to a
RCU list traversal in a non-reader section error when
CONFIG_PROVE_RCU_LIST is enabled.

	net/mptcp/sched.c:44 RCU-list traversed in non-reader section!!

Fix it by acquiring the RCU read lock before calling the
mptcp_sched_find() function. This ensures that the function is invoked
with the necessary RCU protection in place, as it accesses RCU-protected
data structures.

Additionally, the patch breaks down the mptcp_init_sched() call into
smaller parts, with the RCU read lock only covering the specific call to
mptcp_sched_find(). This helps minimize the critical section, reducing
the time during which RCU grace periods are blocked.

The mptcp_sched_list_lock is not held in this case, and it is not clear
if it is necessary.

Signed-off-by: Breno Leitao <leitao@debian.org>
Fixes: 1730b2b2c5a5 ("mptcp: add sched in mptcp_sock")
Cc: stable@vger.kernel.org
---
 net/mptcp/protocol.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 6d0e201c3eb2..8ece630f80d4 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -2854,6 +2854,7 @@ static void mptcp_ca_reset(struct sock *sk)
 static int mptcp_init_sock(struct sock *sk)
 {
 	struct net *net = sock_net(sk);
+	struct mptcp_sched_ops *sched;
 	int ret;
 
 	__mptcp_init_sock(sk);
@@ -2864,8 +2865,10 @@ static int mptcp_init_sock(struct sock *sk)
 	if (unlikely(!net->mib.mptcp_statistics) && !mptcp_mib_alloc(net))
 		return -ENOMEM;
 
-	ret = mptcp_init_sched(mptcp_sk(sk),
-			       mptcp_sched_find(mptcp_get_scheduler(net)));
+	rcu_read_lock();
+	sched = mptcp_sched_find(mptcp_get_scheduler(net));
+	rcu_read_unlock();
+	ret = mptcp_init_sched(mptcp_sk(sk), sched);
 	if (ret)
 		return ret;
 
-- 
2.43.5

