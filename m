Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB05C1FB0
	for <mptcp@lists.linux.dev>; Tue, 17 Jan 2023 07:37:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1673941035;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0NQpx2O11ITsvam4FhyJVJSItB8MdbllQV8nyfkH+aU=;
	b=DrV+s45ck9G3UK2BFP/EWDvfq12HCRdS4lPU4cgeI7k4giPHQ34WjOBrcw1uvRgzF56Luq
	CkXQ4/tklAb8mjor/60EIRBO4e0KcMP/Z1FtUrtJFIYtgXUj9549EH8BbLTmwprDgxjwEq
	FhfaPR7EoLxiCKd7o6dZS9zRh9jVvOI=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-664-cTct4M7LMomB4236YlDdHg-1; Tue, 17 Jan 2023 02:37:14 -0500
X-MC-Unique: cTct4M7LMomB4236YlDdHg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 068DC101A521
	for <mptcp@lists.linux.dev>; Tue, 17 Jan 2023 07:37:14 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.39.192.87])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 86D4E40C2004
	for <mptcp@lists.linux.dev>; Tue, 17 Jan 2023 07:37:13 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Subject: [PATCH mptcp-next v2 02/13] mptcp: fix locking for in-kernel listener creation.
Date: Tue, 17 Jan 2023 08:36:22 +0100
Message-Id: <bcc3c5cec24dc11108a1c9e811d6e1ddf6a56e9e.1673940640.git.pabeni@redhat.com>
In-Reply-To: <cover.1673940640.git.pabeni@redhat.com>
References: <cover.1673940640.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
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
index ec54413fb31f..a3e5026bee5b 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -1679,7 +1679,7 @@ int mptcp_subflow_create_socket(struct sock *sk, unsigned short family,
 	if (err)
 		return err;
 
-	lock_sock(sf->sk);
+	lock_sock_nested(sf->sk, SINGLE_DEPTH_NESTING);
 
 	/* the newly created socket has to be in the same cgroup as its parent */
 	mptcp_attach_cgroup(sk, sf->sk);
-- 
2.39.0

