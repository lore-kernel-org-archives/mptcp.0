Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20FC3525A
	for <mptcp@lists.linux.dev>; Fri, 24 Feb 2023 12:02:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1677240124;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=3YXvfYk7RELLRjWLx6RrZAQOtSqbfSY7fu5MO1KRC+8=;
	b=RCcvtM2b2YfdCkrgxG5IOg0oqQlBX4198jaM1lOoRONIcyRPnBgii+FzEIv92s3UJNny4n
	xylft4aXQLkooaRMuvPaYQUVClVJRDGPj+2M81uUTIbAx07QfiorOlcHHORvTaUuDYyVjT
	PU6sWZIMT8Z6/77ez7T0q0czqO+u7UM=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-619-bvqlzIxzM2q7E0ulZCtXyg-1; Fri, 24 Feb 2023 07:02:03 -0500
X-MC-Unique: bvqlzIxzM2q7E0ulZCtXyg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A5B3C18E0043
	for <mptcp@lists.linux.dev>; Fri, 24 Feb 2023 12:02:02 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.39.192.194])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 35739C15BA0
	for <mptcp@lists.linux.dev>; Fri, 24 Feb 2023 12:02:02 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Subject: [PATCH mptcp-net] mptcp: fix lockdep false positive in mptcp_pm_nl_create_listen_socket()
Date: Fri, 24 Feb 2023 13:01:57 +0100
Message-Id: <011f8740491f4cbbdc7b568551a2b44fab942ab5.1677240111.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
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

Instead just add a new lockclass to the in-kernel msk socket,
re-initializing the lockdep infra after the socket creation.

Reported-by: Christoph Paasch <cpaasch@apple.com>
Fixes: ad2171009d96 ("mptcp: fix locking for in-kernel listener creation")
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
 net/mptcp/pm_netlink.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index d1d859517d91..6048fdee404b 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -994,9 +994,13 @@ static int mptcp_pm_nl_append_new_local_addr(struct pm_nl_pernet *pernet,
 	return ret;
 }
 
+static struct lock_class_key mptcp_slock_keys[2];
+static struct lock_class_key mptcp_keys[2];
+
 static int mptcp_pm_nl_create_listen_socket(struct sock *sk,
 					    struct mptcp_pm_addr_entry *entry)
 {
+	bool is_ipv6 = sk->sk_family == AF_INET6;
 	int addrlen = sizeof(struct sockaddr_in);
 	struct sockaddr_storage addr;
 	struct socket *ssock;
@@ -1013,6 +1017,19 @@ static int mptcp_pm_nl_create_listen_socket(struct sock *sk,
 	if (!newsk)
 		return -EINVAL;
 
+	/* The subflow socket lock is acquired in a nested to the msk one
+	 * in several places, even by the TCP stack, and this msk is a kernel
+	 * socket: lockdep complains. Instead of propagating the _nested
+	 * modifiers in several places, re-init the lock class for the msk
+	 * socket to an mptcp specific one.
+	 */
+	sock_lock_init_class_and_name(
+			newsk,
+			is_ipv6 ? "mlock-AF_INET6" : "mlock-AF_INET",
+			&mptcp_slock_keys[is_ipv6],
+			is_ipv6 ? "msk_lock-AF_INET6": "msk_lock-AF_INET",
+			&mptcp_keys[is_ipv6]);
+
 	lock_sock(newsk);
 	ssock = __mptcp_nmpc_socket(mptcp_sk(newsk));
 	release_sock(newsk);
-- 
2.39.2

