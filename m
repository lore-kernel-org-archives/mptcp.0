Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 506016AB6
	for <mptcp@lists.linux.dev>; Thu, 12 Jan 2023 12:56:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5A93C433D2;
	Thu, 12 Jan 2023 12:56:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1673528187;
	bh=O07LJVcqGSaZclrcTc8PEdDd/8LGC+i3z/Off7pHjjE=;
	h=Subject:To:Cc:From:Date:In-Reply-To:From;
	b=xm8rjaaJS4PWcHIZGTxoq2rBNC67P16bTDxUT8VILUFBX1d7/sNPzRrF52IayeCZF
	 EvFzF3KCraKPDH+37W5KbBFldRPLAyNR/ufrmxY+8PbX7gFbMJZkhq+aTj6OmO1cP9
	 bF43+U9zeqXAqFhsSQcbSIfgecG6RMu7wXI6hUW4=
Subject: Patch "mptcp: remove MPTCP 'ifdef' in TCP SYN cookies" has been added to the 5.10-stable tree
To: gregkh@linuxfoundation.org,kuba@kernel.org,mathew.j.martineau@linux.intel.com,matthieu.baerts@tessares.net,mptcp@lists.linux.dev,pabeni@redhat.com
Cc: <stable-commits@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 12 Jan 2023 13:56:12 +0100
In-Reply-To: <20230107014631.449550-3-mathew.j.martineau@linux.intel.com>
Message-ID: <167352817239202@kroah.com>
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

    mptcp: remove MPTCP 'ifdef' in TCP SYN cookies

to the 5.10-stable tree which can be found at:
    http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary

The filename of the patch is:
     mptcp-remove-mptcp-ifdef-in-tcp-syn-cookies.patch
and it can be found in the queue-5.10 subdirectory.

If you, or anyone else, feels it should not be added to the stable tree,
please let <stable@vger.kernel.org> know about it.


From stable-owner@vger.kernel.org Sat Jan  7 02:46:48 2023
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
Date: Fri,  6 Jan 2023 17:46:29 -0800
Subject: mptcp: remove MPTCP 'ifdef' in TCP SYN cookies
To: stable@vger.kernel.org, gregkh@linuxfoundation.org
Cc: Matthieu Baerts <matthieu.baerts@tessares.net>, pabeni@redhat.com, mptcp@lists.linux.dev, Mat Martineau <mathew.j.martineau@linux.intel.com>, Jakub Kicinski <kuba@kernel.org>
Message-ID: <20230107014631.449550-3-mathew.j.martineau@linux.intel.com>

From: Mat Martineau <mathew.j.martineau@linux.intel.com>

From: Matthieu Baerts <matthieu.baerts@tessares.net>

commit 3fff88186f047627bb128d65155f42517f8e448f upstream.

To ease the maintenance, it is often recommended to avoid having #ifdef
preprocessor conditions.

Here the section related to CONFIG_MPTCP was quite short but the next
commit needs to add more code around. It is then cleaner to move
specific MPTCP code to functions located in net/mptcp directory.

Now that mptcp_subflow_request_sock_ops structure can be static, it can
also be marked as "read only after init".

Suggested-by: Paolo Abeni <pabeni@redhat.com>
Reviewed-by: Mat Martineau <mathew.j.martineau@linux.intel.com>
Cc: stable@vger.kernel.org # 5.10
Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
Signed-off-by: Mat Martineau <mathew.j.martineau@linux.intel.com>
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 include/net/mptcp.h   |   12 ++++++++++--
 net/ipv4/syncookies.c |    7 +++----
 net/mptcp/subflow.c   |   12 +++++++++++-
 3 files changed, 24 insertions(+), 7 deletions(-)

--- a/include/net/mptcp.h
+++ b/include/net/mptcp.h
@@ -58,8 +58,6 @@ struct mptcp_out_options {
 };
 
 #ifdef CONFIG_MPTCP
-extern struct request_sock_ops mptcp_subflow_request_sock_ops;
-
 void mptcp_init(void);
 
 static inline bool sk_is_mptcp(const struct sock *sk)
@@ -133,6 +131,9 @@ void mptcp_seq_show(struct seq_file *seq
 int mptcp_subflow_init_cookie_req(struct request_sock *req,
 				  const struct sock *sk_listener,
 				  struct sk_buff *skb);
+struct request_sock *mptcp_subflow_reqsk_alloc(const struct request_sock_ops *ops,
+					       struct sock *sk_listener,
+					       bool attach_listener);
 #else
 
 static inline void mptcp_init(void)
@@ -208,6 +209,13 @@ static inline int mptcp_subflow_init_coo
 {
 	return 0; /* TCP fallback */
 }
+
+static inline struct request_sock *mptcp_subflow_reqsk_alloc(const struct request_sock_ops *ops,
+							     struct sock *sk_listener,
+							     bool attach_listener)
+{
+	return NULL;
+}
 #endif /* CONFIG_MPTCP */
 
 #if IS_ENABLED(CONFIG_MPTCP_IPV6)
--- a/net/ipv4/syncookies.c
+++ b/net/ipv4/syncookies.c
@@ -290,12 +290,11 @@ struct request_sock *cookie_tcp_reqsk_al
 	struct tcp_request_sock *treq;
 	struct request_sock *req;
 
-#ifdef CONFIG_MPTCP
 	if (sk_is_mptcp(sk))
-		ops = &mptcp_subflow_request_sock_ops;
-#endif
+		req = mptcp_subflow_reqsk_alloc(ops, sk, false);
+	else
+		req = inet_reqsk_alloc(ops, sk, false);
 
-	req = inet_reqsk_alloc(ops, sk, false);
 	if (!req)
 		return NULL;
 
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -359,7 +359,7 @@ do_reset:
 	mptcp_subflow_reset(sk);
 }
 
-struct request_sock_ops mptcp_subflow_request_sock_ops;
+static struct request_sock_ops mptcp_subflow_request_sock_ops __ro_after_init;
 static struct tcp_request_sock_ops subflow_request_sock_ipv4_ops __ro_after_init;
 
 static int subflow_v4_conn_request(struct sock *sk, struct sk_buff *skb)
@@ -411,6 +411,16 @@ drop:
 }
 #endif
 
+struct request_sock *mptcp_subflow_reqsk_alloc(const struct request_sock_ops *ops,
+					       struct sock *sk_listener,
+					       bool attach_listener)
+{
+	ops = &mptcp_subflow_request_sock_ops;
+
+	return inet_reqsk_alloc(ops, sk_listener, attach_listener);
+}
+EXPORT_SYMBOL(mptcp_subflow_reqsk_alloc);
+
 /* validate hmac received in third ACK */
 static bool subflow_hmac_valid(const struct request_sock *req,
 			       const struct mptcp_options_received *mp_opt)


Patches currently in stable-queue which might be from stable-owner@vger.kernel.org are

queue-5.10/mptcp-use-proper-req-destructor-for-ipv6.patch
queue-5.10/mptcp-remove-mptcp-ifdef-in-tcp-syn-cookies.patch
queue-5.10/mptcp-dedicated-request-sock-for-subflow-in-v6.patch
queue-5.10/mptcp-mark-ops-structures-as-ro_after_init.patch
