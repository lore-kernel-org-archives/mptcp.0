Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 885C45393
	for <mptcp@lists.linux.dev>; Thu, 26 Jan 2023 21:05:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1674767143;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6yk3fZvWNgjlk3GQ3ggLSDs9N8Q4cmj4PtwjF0e9eLc=;
	b=a4bTepa5qfjz32cUn52DiE8i7+uBNZM9Bk6z0W39zcUD15SElXNj9DBWRE9OApd7jOQNFn
	KQwYJJwib4WR3qAeSHVq0Y/GD+LEtCnzucNUNuORAkmU7uXOSPJ7PWMi6/CgoJZtbBxP9m
	82XdQT0Y5pgXMgaikvVBny6+mJHFJ+o=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-6-SHq9pmP3NAqPoXLmZ86atw-1; Thu, 26 Jan 2023 16:05:42 -0500
X-MC-Unique: SHq9pmP3NAqPoXLmZ86atw-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B96CA858F09
	for <mptcp@lists.linux.dev>; Thu, 26 Jan 2023 21:05:41 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.39.192.60])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 4DD5E492C14
	for <mptcp@lists.linux.dev>; Thu, 26 Jan 2023 21:05:41 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Subject: [PATCH v3 mptcp-next 03/15] mptcp: fix locking for in-kernel listener creation.
Date: Thu, 26 Jan 2023 22:05:08 +0100
Message-Id: <49dd249aa0f18b65be06020fa038799e3482ac9d.1674767058.git.pabeni@redhat.com>
In-Reply-To: <cover.1674767058.git.pabeni@redhat.com>
References: <cover.1674767058.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"; x-default=true

For consistency, in mptcp_pm_nl_create_listen_socket(), we need to
call the __mptcp_nmpc_socket() under the msk socket lock.

Note that as a side effect, mptcp_subflow_create_socket() needs a
'nested' lockdep annotation, as it will acquire the subflow (kernel)
socket lock under the in-kernel listener msk socket lock.

The current lack of locking is almost harmless, because the relevant
socket is not exposed to the user space, but in future we will add
more complexity to the mentioned helper, let's play safe.

Fixes: 1729cf186d8a ("mptcp: create the listening socket for new port")
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
 net/mptcp/pm_netlink.c | 10 ++++++----
 net/mptcp/subflow.c    |  2 +-
 2 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index e82a112b8779..155916174841 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -999,8 +999,8 @@ static int mptcp_pm_nl_create_listen_socket(struct sock *sk,
 {
 	int addrlen = sizeof(struct sockaddr_in);
 	struct sockaddr_storage addr;
-	struct mptcp_sock *msk;
 	struct socket *ssock;
+	struct sock *newsk;
 	int backlog = 1024;
 	int err;
 
@@ -1009,11 +1009,13 @@ static int mptcp_pm_nl_create_listen_socket(struct sock *sk,
 	if (err)
 		return err;
 
-	msk = mptcp_sk(entry->lsk->sk);
-	if (!msk)
+	newsk = entry->lsk->sk;
+	if (!newsk)
 		return -EINVAL;
 
-	ssock = __mptcp_nmpc_socket(msk);
+	lock_sock(newsk);
+	ssock = __mptcp_nmpc_socket(mptcp_sk(newsk));
+	release_sock(newsk);
 	if (!ssock)
 		return -EINVAL;
 
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index bd53d83ef2c9..801d887d4b97 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -1677,7 +1677,7 @@ int mptcp_subflow_create_socket(struct sock *sk, unsigned short family,
 	if (err)
 		return err;
 
-	lock_sock(sf->sk);
+	lock_sock_nested(sf->sk, SINGLE_DEPTH_NESTING);
 
 	/* the newly created socket has to be in the same cgroup as its parent */
 	mptcp_attach_cgroup(sk, sf->sk);
-- 
2.39.1

