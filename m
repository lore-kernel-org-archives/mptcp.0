Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C2D16AB6
	for <mptcp@lists.linux.dev>; Thu, 12 Jan 2023 12:56:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97EE4C433EF;
	Thu, 12 Jan 2023 12:56:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1673528190;
	bh=A3l1nWY6KH3OdOBoYw+ByfxHSaQ0KxfP5aBz4jIh5Po=;
	h=Subject:To:Cc:From:Date:In-Reply-To:From;
	b=q6ayFW6bdqi2GXcELP44S6rxlMNSz6YaIJgBXZxTryAE9bmIGBRGpKFnQ92jVvxaa
	 8/NkGrJ2KRwb02XNNbffdHf0710jWaV2JbDzx8in60uDdEEQn9rgOGMflOwfGcIeoR
	 BXWMeg5uzO3E+1V3x+LRHo/2ZIcjhryv/dMOUAU8=
Subject: Patch "mptcp: use proper req destructor for IPv6" has been added to the 5.10-stable tree
To: gregkh@linuxfoundation.org,kuba@kernel.org,mathew.j.martineau@linux.intel.com,matthieu.baerts@tessares.net,mptcp@lists.linux.dev,pabeni@redhat.com
Cc: <stable-commits@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 12 Jan 2023 13:56:13 +0100
In-Reply-To: <20230107014631.449550-5-mathew.j.martineau@linux.intel.com>
Message-ID: <1673528173190200@kroah.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-stable: commit
X-Patchwork-Hint: ignore 


This is a note to let you know that I've just added the patch titled

    mptcp: use proper req destructor for IPv6

to the 5.10-stable tree which can be found at:
    http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary

The filename of the patch is:
     mptcp-use-proper-req-destructor-for-ipv6.patch
and it can be found in the queue-5.10 subdirectory.

If you, or anyone else, feels it should not be added to the stable tree,
please let <stable@vger.kernel.org> know about it.


From stable-owner@vger.kernel.org Sat Jan  7 02:46:50 2023
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
Date: Fri,  6 Jan 2023 17:46:31 -0800
Subject: mptcp: use proper req destructor for IPv6
To: stable@vger.kernel.org, gregkh@linuxfoundation.org
Cc: Matthieu Baerts <matthieu.baerts@tessares.net>, pabeni@redhat.com, mptcp@lists.linux.dev, Mat Martineau <mathew.j.martineau@linux.intel.com>, Jakub Kicinski <kuba@kernel.org>
Message-ID: <20230107014631.449550-5-mathew.j.martineau@linux.intel.com>

From: Mat Martineau <mathew.j.martineau@linux.intel.com>

From: Matthieu Baerts <matthieu.baerts@tessares.net>

commit d3295fee3c756ece33ac0d935e172e68c0a4161b upstream.

Before, only the destructor from TCP request sock in IPv4 was called
even if the subflow was IPv6.

It is important to use the right destructor to avoid memory leaks with
some advanced IPv6 features, e.g. when the request socks contain
specific IPv6 options.

Fixes: 79c0949e9a09 ("mptcp: Add key generation and token tree")
Reviewed-by: Mat Martineau <mathew.j.martineau@linux.intel.com>
Cc: stable@vger.kernel.org # 5.10
Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
Signed-off-by: Mat Martineau <mathew.j.martineau@linux.intel.com>
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/mptcp/subflow.c |   19 ++++++++++++++++---
 1 file changed, 16 insertions(+), 3 deletions(-)

--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -40,7 +40,6 @@ static void subflow_req_destructor(struc
 		sock_put((struct sock *)subflow_req->msk);
 
 	mptcp_token_destroy_request(req);
-	tcp_request_sock_ops.destructor(req);
 }
 
 static void subflow_generate_hmac(u64 key1, u64 key2, u32 nonce1, u32 nonce2,
@@ -380,6 +379,12 @@ drop:
 	return 0;
 }
 
+static void subflow_v4_req_destructor(struct request_sock *req)
+{
+	subflow_req_destructor(req);
+	tcp_request_sock_ops.destructor(req);
+}
+
 #if IS_ENABLED(CONFIG_MPTCP_IPV6)
 static struct request_sock_ops mptcp_subflow_v6_request_sock_ops __ro_after_init;
 static struct tcp_request_sock_ops subflow_request_sock_ipv6_ops __ro_after_init;
@@ -410,6 +415,12 @@ drop:
 	tcp_listendrop(sk);
 	return 0; /* don't send reset */
 }
+
+static void subflow_v6_req_destructor(struct request_sock *req)
+{
+	subflow_req_destructor(req);
+	tcp6_request_sock_ops.destructor(req);
+}
 #endif
 
 struct request_sock *mptcp_subflow_reqsk_alloc(const struct request_sock_ops *ops,
@@ -1401,8 +1412,6 @@ static int subflow_ops_init(struct reque
 	if (!subflow_ops->slab)
 		return -ENOMEM;
 
-	subflow_ops->destructor = subflow_req_destructor;
-
 	return 0;
 }
 
@@ -1410,6 +1419,8 @@ void __init mptcp_subflow_init(void)
 {
 	mptcp_subflow_v4_request_sock_ops = tcp_request_sock_ops;
 	mptcp_subflow_v4_request_sock_ops.slab_name = "request_sock_subflow_v4";
+	mptcp_subflow_v4_request_sock_ops.destructor = subflow_v4_req_destructor;
+
 	if (subflow_ops_init(&mptcp_subflow_v4_request_sock_ops) != 0)
 		panic("MPTCP: failed to init subflow v4 request sock ops\n");
 
@@ -1431,6 +1442,8 @@ void __init mptcp_subflow_init(void)
 
 	mptcp_subflow_v6_request_sock_ops = tcp6_request_sock_ops;
 	mptcp_subflow_v6_request_sock_ops.slab_name = "request_sock_subflow_v6";
+	mptcp_subflow_v6_request_sock_ops.destructor = subflow_v6_req_destructor;
+
 	if (subflow_ops_init(&mptcp_subflow_v6_request_sock_ops) != 0)
 		panic("MPTCP: failed to init subflow v6 request sock ops\n");
 


Patches currently in stable-queue which might be from stable-owner@vger.kernel.org are

queue-5.10/mptcp-use-proper-req-destructor-for-ipv6.patch
queue-5.10/mptcp-remove-mptcp-ifdef-in-tcp-syn-cookies.patch
queue-5.10/mptcp-dedicated-request-sock-for-subflow-in-v6.patch
queue-5.10/mptcp-mark-ops-structures-as-ro_after_init.patch
