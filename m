Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8803710F1
	for <mptcp@lists.linux.dev>; Sat,  7 Jan 2023 01:46:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673056004; x=1704592004;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=LaWSAGD1LoOBS5f/EQBtGcxsZ/H1Mi/K5mfqwVKmmaU=;
  b=g8Ittf4RpBSVZdPJHu9pfksJxmh3xJelNRx7witIEgEprYGlEeoUHv0H
   5JP3qNUD5kAscyyp++rEEtOEjgbW7yjW08+J9kTx5b3saZocVXMng6Sih
   vT3Ww6uPwrttlI8zmWJI37p/+4yOrOYgzu7xiaPWwDHLh0TrhW8AgPVZU
   WlZr+pj3OfZGbJyXAs9UOS0g4ZoM24jqL/e/UVlUp9h9+gEAF123gDU8G
   sW+8lsceXUsbem8hcZTjK1XahRRjfT4sJZ8z94dwgvb7Fd+lgUFFLhORG
   4tWoogck+ZVq20PbbV+bjAaD6Go8DQf5sD+9lxZ8CrSmpIeSsUI7tvfuU
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10582"; a="310393559"
X-IronPort-AV: E=Sophos;i="5.96,307,1665471600"; 
   d="scan'208";a="310393559"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jan 2023 17:46:42 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10582"; a="606066135"
X-IronPort-AV: E=Sophos;i="5.96,307,1665471600"; 
   d="scan'208";a="606066135"
Received: from mechevar-mobl.amr.corp.intel.com (HELO mjmartin-desk2.intel.com) ([10.209.66.63])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jan 2023 17:46:42 -0800
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: Matthieu Baerts <matthieu.baerts@tessares.net>,
	pabeni@redhat.com,
	mptcp@lists.linux.dev,
	Mat Martineau <mathew.j.martineau@linux.intel.com>,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 5.10 2/4] mptcp: remove MPTCP 'ifdef' in TCP SYN cookies
Date: Fri,  6 Jan 2023 17:46:29 -0800
Message-Id: <20230107014631.449550-3-mathew.j.martineau@linux.intel.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230107014631.449550-1-mathew.j.martineau@linux.intel.com>
References: <20230107014631.449550-1-mathew.j.martineau@linux.intel.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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
---
 include/net/mptcp.h   | 12 ++++++++++--
 net/ipv4/syncookies.c |  7 +++----
 net/mptcp/subflow.c   | 12 +++++++++++-
 3 files changed, 24 insertions(+), 7 deletions(-)

diff --git a/include/net/mptcp.h b/include/net/mptcp.h
index 753ba7e755d6..3e529d8fce73 100644
--- a/include/net/mptcp.h
+++ b/include/net/mptcp.h
@@ -58,8 +58,6 @@ struct mptcp_out_options {
 };
 
 #ifdef CONFIG_MPTCP
-extern struct request_sock_ops mptcp_subflow_request_sock_ops;
-
 void mptcp_init(void);
 
 static inline bool sk_is_mptcp(const struct sock *sk)
@@ -133,6 +131,9 @@ void mptcp_seq_show(struct seq_file *seq);
 int mptcp_subflow_init_cookie_req(struct request_sock *req,
 				  const struct sock *sk_listener,
 				  struct sk_buff *skb);
+struct request_sock *mptcp_subflow_reqsk_alloc(const struct request_sock_ops *ops,
+					       struct sock *sk_listener,
+					       bool attach_listener);
 #else
 
 static inline void mptcp_init(void)
@@ -208,6 +209,13 @@ static inline int mptcp_subflow_init_cookie_req(struct request_sock *req,
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
diff --git a/net/ipv4/syncookies.c b/net/ipv4/syncookies.c
index 41afc9155f31..542b66783493 100644
--- a/net/ipv4/syncookies.c
+++ b/net/ipv4/syncookies.c
@@ -290,12 +290,11 @@ struct request_sock *cookie_tcp_reqsk_alloc(const struct request_sock_ops *ops,
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
 
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index 61919e2499e7..6a149da3a4d9 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -359,7 +359,7 @@ static void subflow_finish_connect(struct sock *sk, const struct sk_buff *skb)
 	mptcp_subflow_reset(sk);
 }
 
-struct request_sock_ops mptcp_subflow_request_sock_ops;
+static struct request_sock_ops mptcp_subflow_request_sock_ops __ro_after_init;
 static struct tcp_request_sock_ops subflow_request_sock_ipv4_ops __ro_after_init;
 
 static int subflow_v4_conn_request(struct sock *sk, struct sk_buff *skb)
@@ -411,6 +411,16 @@ static int subflow_v6_conn_request(struct sock *sk, struct sk_buff *skb)
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
-- 
2.39.0

