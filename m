Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0D0A6D39
	for <mptcp@lists.linux.dev>; Mon, 20 Feb 2023 16:10:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1676909419;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=ukswy3s/NxM7YEfazf2FVWSr1n3HoIEtrjvZXcHfCP0=;
	b=SOf7QrhyoDi+YTb1k5KN4CUxn7jh3o8d2xcD2bB8LXYN3JA/mFk49BpHv2K170ws0I3gxC
	MhpmRXcK/szg19NOwh5SaYfjNmqmcwsaJBsc71I40uN0jAGRX/LSu4k/IBOqGPRLz8zEU2
	2uQHw16lUkHUsh0KXepk3nq836po6xU=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-199-TwbRQaPeN5Wp7pAGZ49eGQ-1; Mon, 20 Feb 2023 11:10:18 -0500
X-MC-Unique: TwbRQaPeN5Wp7pAGZ49eGQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 1EDCE101A55E
	for <mptcp@lists.linux.dev>; Mon, 20 Feb 2023 16:10:18 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.39.192.157])
	by smtp.corp.redhat.com (Postfix) with ESMTP id A30252166B26
	for <mptcp@lists.linux.dev>; Mon, 20 Feb 2023 16:10:17 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Subject: [PATCH mptcp-net] Revert "mptcp: fix locking for in-kernel listener creation"
Date: Mon, 20 Feb 2023 17:10:14 +0100
Message-Id: <1cde3460ddf2e5fa7be0e81dd2c3060a663d4ccc.1676909181.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"; x-default=true

Christoph reports a lockdep splat in the mptcp_subflow_create_socket()
error path, when such function is invoked by
mptcp_pm_nl_create_listen_socket().

Such code path acquires two separates, nested socket lock, with the
internal lock operation lacking the "nested" annotation. Adding that
in sock_release() for mptcp's sake only could be confusing.

Instead we can revert the commit introducing the outermost lock as the
relevant socket is not exposted in any way to ther user not to the
stack and can't be touched by any other entity.

Reported-by: Christoph Paasch <cpaasch@apple.com>
Fixes: ad2171009d96 ("mptcp: fix locking for in-kernel listener creation")
Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/354
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
 net/mptcp/pm_netlink.c | 14 ++++++++------
 net/mptcp/subflow.c    |  2 +-
 2 files changed, 9 insertions(+), 7 deletions(-)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index d1d859517d91..54b0aeb8bb01 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -999,8 +999,8 @@ static int mptcp_pm_nl_create_listen_socket(struct sock *sk,
 {
 	int addrlen = sizeof(struct sockaddr_in);
 	struct sockaddr_storage addr;
+	struct mptcp_sock *msk;
 	struct socket *ssock;
-	struct sock *newsk;
 	int backlog = 1024;
 	int err;
 
@@ -1009,13 +1009,15 @@ static int mptcp_pm_nl_create_listen_socket(struct sock *sk,
 	if (err)
 		return err;
 
-	newsk = entry->lsk->sk;
-	if (!newsk)
+	msk = mptcp_sk(entry->lsk->sk);
+	if (!msk)
 		return -EINVAL;
 
-	lock_sock(newsk);
-	ssock = __mptcp_nmpc_socket(mptcp_sk(newsk));
-	release_sock(newsk);
+	/* No other code-paths can touch the msk at this point and acquiring
+	 * the msk the socket lock will trigger a lockdep false positive in
+	 * the mptcp_subflow_create_socket error path.
+	 */
+	ssock = __mptcp_nmpc_socket(msk);
 	if (IS_ERR(ssock))
 		return PTR_ERR(ssock);
 
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index 28c64811a8af..90895733860f 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -1708,7 +1708,7 @@ int mptcp_subflow_create_socket(struct sock *sk, unsigned short family,
 	if (err)
 		return err;
 
-	lock_sock_nested(sf->sk, SINGLE_DEPTH_NESTING);
+	lock_sock(sf->sk);
 
 	err = security_mptcp_add_subflow(sk, sf->sk);
 	if (err)
-- 
2.39.2

