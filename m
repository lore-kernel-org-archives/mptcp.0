Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 166CE6AB6
	for <mptcp@lists.linux.dev>; Thu, 12 Jan 2023 12:56:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02145C433EF;
	Thu, 12 Jan 2023 12:56:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1673528183;
	bh=ryFSNv1xyXySge2W+08S/Cw5bOHNbm9fcttoniqjQlc=;
	h=Subject:To:Cc:From:Date:In-Reply-To:From;
	b=KtCymxL/oGkYuzWGARcruDhJ5t25rQgvulF7fqOCjSgDXqzkZevfMcHvtELXYde8P
	 IkEcU4W89Y1ZYEedC+SGMUS9/Qv5CvKg9jUaoAP2K/eUsE1YBhiJcOutV+3wgkn5rz
	 Kh61EZ5pekFI3QncR9H1fJLJSoVRSm0I7AZhIPFw=
Subject: Patch "mptcp: mark ops structures as ro_after_init" has been added to the 5.10-stable tree
To: fw@strlen.de,gregkh@linuxfoundation.org,kuba@kernel.org,mathew.j.martineau@linux.intel.com,matthieu.baerts@tessares.net,mptcp@lists.linux.dev,pabeni@redhat.com
Cc: <stable-commits@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 12 Jan 2023 13:56:11 +0100
In-Reply-To: <20230107014631.449550-2-mathew.j.martineau@linux.intel.com>
Message-ID: <167352817111419@kroah.com>
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

    mptcp: mark ops structures as ro_after_init

to the 5.10-stable tree which can be found at:
    http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary

The filename of the patch is:
     mptcp-mark-ops-structures-as-ro_after_init.patch
and it can be found in the queue-5.10 subdirectory.

If you, or anyone else, feels it should not be added to the stable tree,
please let <stable@vger.kernel.org> know about it.


From stable-owner@vger.kernel.org Sat Jan  7 02:46:46 2023
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
Date: Fri,  6 Jan 2023 17:46:28 -0800
Subject: mptcp: mark ops structures as ro_after_init
To: stable@vger.kernel.org, gregkh@linuxfoundation.org
Cc: Florian Westphal <fw@strlen.de>, matthieu.baerts@tessares.net, pabeni@redhat.com, mptcp@lists.linux.dev, Mat Martineau <mathew.j.martineau@linux.intel.com>, Jakub Kicinski <kuba@kernel.org>
Message-ID: <20230107014631.449550-2-mathew.j.martineau@linux.intel.com>

From: Mat Martineau <mathew.j.martineau@linux.intel.com>

From: Florian Westphal <fw@strlen.de>

commit 51fa7f8ebf0e25c7a9039fa3988a623d5f3855aa upstream.

These structures are initialised from the init hooks, so we can't make
them 'const'.  But no writes occur afterwards, so we can use ro_after_init.

Also, remove bogus EXPORT_SYMBOL, the only access comes from ip
stack, not from kernel modules.

Cc: stable@vger.kernel.org # 5.10
Signed-off-by: Florian Westphal <fw@strlen.de>
Signed-off-by: Mat Martineau <mathew.j.martineau@linux.intel.com>
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/mptcp/subflow.c |   15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -360,8 +360,7 @@ do_reset:
 }
 
 struct request_sock_ops mptcp_subflow_request_sock_ops;
-EXPORT_SYMBOL_GPL(mptcp_subflow_request_sock_ops);
-static struct tcp_request_sock_ops subflow_request_sock_ipv4_ops;
+static struct tcp_request_sock_ops subflow_request_sock_ipv4_ops __ro_after_init;
 
 static int subflow_v4_conn_request(struct sock *sk, struct sk_buff *skb)
 {
@@ -382,9 +381,9 @@ drop:
 }
 
 #if IS_ENABLED(CONFIG_MPTCP_IPV6)
-static struct tcp_request_sock_ops subflow_request_sock_ipv6_ops;
-static struct inet_connection_sock_af_ops subflow_v6_specific;
-static struct inet_connection_sock_af_ops subflow_v6m_specific;
+static struct tcp_request_sock_ops subflow_request_sock_ipv6_ops __ro_after_init;
+static struct inet_connection_sock_af_ops subflow_v6_specific __ro_after_init;
+static struct inet_connection_sock_af_ops subflow_v6m_specific __ro_after_init;
 
 static int subflow_v6_conn_request(struct sock *sk, struct sk_buff *skb)
 {
@@ -636,7 +635,7 @@ dispose_child:
 	return child;
 }
 
-static struct inet_connection_sock_af_ops subflow_specific;
+static struct inet_connection_sock_af_ops subflow_specific __ro_after_init;
 
 enum mapping_status {
 	MAPPING_OK,
@@ -1017,7 +1016,7 @@ static void subflow_write_space(struct s
 	}
 }
 
-static struct inet_connection_sock_af_ops *
+static const struct inet_connection_sock_af_ops *
 subflow_default_af_ops(struct sock *sk)
 {
 #if IS_ENABLED(CONFIG_MPTCP_IPV6)
@@ -1032,7 +1031,7 @@ void mptcpv6_handle_mapped(struct sock *
 {
 	struct mptcp_subflow_context *subflow = mptcp_subflow_ctx(sk);
 	struct inet_connection_sock *icsk = inet_csk(sk);
-	struct inet_connection_sock_af_ops *target;
+	const struct inet_connection_sock_af_ops *target;
 
 	target = mapped ? &subflow_v6m_specific : subflow_default_af_ops(sk);
 


Patches currently in stable-queue which might be from stable-owner@vger.kernel.org are

queue-5.10/mptcp-use-proper-req-destructor-for-ipv6.patch
queue-5.10/mptcp-remove-mptcp-ifdef-in-tcp-syn-cookies.patch
queue-5.10/mptcp-dedicated-request-sock-for-subflow-in-v6.patch
queue-5.10/mptcp-mark-ops-structures-as-ro_after_init.patch
