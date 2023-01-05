Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E03F621
	for <mptcp@lists.linux.dev>; Thu,  5 Jan 2023 00:14:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1672877651; x=1704413651;
  h=date:from:to:subject:message-id:mime-version;
  bh=EEQs6tAx3/O2ktT40Q8VnUQZtcj7xhrIBHefFNtU6/w=;
  b=mtTbinEVJN1U7P1obbQIvN+zP1SdmqEWKfhNU+rVK4BMWQRhjM61PYI+
   M801pcq/wKgnaZVG8lC/vHldMQRuZhZQY5ryAODu08k2yYJS8q1EXyvyL
   fauKzSMZ4JLjqiZ++sL+ilX/KYfHVeHWU6T4GcrIrMHEbVywneoTZphPv
   ZTmunID6j12yfA9PsTMXvhA3kfTWcPQUURYOVWb3Ag4aa2f0l4+BOeH1x
   3FTD2m7uFbJbXTjENYkh7837ketf9zyPH8tPYJ9+fsTnXHkTN1pVyrhn6
   6M8uMiZF0kFOqcoO2sxRx5tyMSnLtqfFNObTtEiimqnSgjmoK+Uuto206
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10580"; a="323309217"
X-IronPort-AV: E=Sophos;i="5.96,301,1665471600"; 
   d="scan'208";a="323309217"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jan 2023 16:14:11 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10580"; a="657297222"
X-IronPort-AV: E=Sophos;i="5.96,301,1665471600"; 
   d="scan'208";a="657297222"
Received: from lakkired-mobl1.amr.corp.intel.com ([10.212.143.9])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jan 2023 16:14:10 -0800
Date: Wed, 4 Jan 2023 16:14:10 -0800 (PST)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: mptcp@lists.linux.dev, Matthieu Baerts <matthieu.baerts@tessares.net>, 
    Paolo Abeni <pabeni@redhat.com>
Subject: Patch "mptcp: remove MPTCP 'ifdef' in TCP SYN cookies" has been
 added to the 5.15-stable tree (fwd)
Message-ID: <83ca6b33-db3f-3c38-ea63-05db4e18d265@linux.intel.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII


Matthieu and Paolo -

We all received a number of stable backport messages related to this 
series that was upstreamed about a month ago:

https://lore.kernel.org/netdev/20221210002810.289674-1-mathew.j.martineau@linux.intel.com/

Matthieu Baerts (3):
   mptcp: remove MPTCP 'ifdef' in TCP SYN cookies
   mptcp: dedicated request sock for subflow in v6
   mptcp: use proper req destructor for IPv6

Wei Yongjun (1):
   mptcp: netlink: fix some error return code


The process went smoothly for 6.0-stable and 6.1-stable, but the more 
important request_sock patches didn't apply to 5.15-stable:

   mptcp: dedicated request sock for subflow in v6
   mptcp: use proper req destructor for IPv6

Even though "mptcp: remove MPTCP 'ifdef' in TCP SYN cookies" doesn't do 
much on its own, it seems worthwhile to leave it in the current 5.15 
stable queue so we can backport the two additional patches that depend on 
it.

None of the 4 patches above applied to 5.10-stable. It looks like the code 
has not changed a lot and the backport should not be tricky - I lean 
toward backporting Matthieu's 3 patches. Wei's patch fixes code added in 
5.19, so isn't relevant in these older stable kernels.

Both 5.15-stable and 5.10-stable manual backporting plans sound good?


Thanks,
Mat



---------- Forwarded message ----------
Date: Wed, 4 Jan 2023 06:02:28
From: gregkh@linuxfoundation.org
To: gregkh@linuxfoundation.org, kuba@kernel.org,
     mathew.j.martineau@linux.intel.com, matthieu.baerts@tessares.net,
     pabeni@redhat.com
Cc: stable-commits@vger.kernel.org
Subject: Patch "mptcp: remove MPTCP 'ifdef' in TCP SYN cookies" has been added
     to the 5.15-stable tree


This is a note to let you know that I've just added the patch titled

     mptcp: remove MPTCP 'ifdef' in TCP SYN cookies

to the 5.15-stable tree which can be found at:
     http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary

The filename of the patch is:
      mptcp-remove-mptcp-ifdef-in-tcp-syn-cookies.patch
and it can be found in the queue-5.15 subdirectory.

If you, or anyone else, feels it should not be added to the stable tree,
please let <stable@vger.kernel.org> know about it.


>From 3fff88186f047627bb128d65155f42517f8e448f Mon Sep 17 00:00:00 2001
From: Matthieu Baerts <matthieu.baerts@tessares.net>
Date: Fri, 9 Dec 2022 16:28:08 -0800
Subject: mptcp: remove MPTCP 'ifdef' in TCP SYN cookies

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
Cc: stable@vger.kernel.org
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
@@ -93,8 +93,6 @@ struct mptcp_out_options {
  };

  #ifdef CONFIG_MPTCP
-extern struct request_sock_ops mptcp_subflow_request_sock_ops;
-
  void mptcp_init(void);

  static inline bool sk_is_mptcp(const struct sock *sk)
@@ -182,6 +180,9 @@ void mptcp_seq_show(struct seq_file *seq
  int mptcp_subflow_init_cookie_req(struct request_sock *req,
  				  const struct sock *sk_listener,
  				  struct sk_buff *skb);
+struct request_sock *mptcp_subflow_reqsk_alloc(const struct request_sock_ops *ops,
+					       struct sock *sk_listener,
+					       bool attach_listener);

  __be32 mptcp_get_reset_option(const struct sk_buff *skb);

@@ -274,6 +275,13 @@ static inline int mptcp_subflow_init_coo
  	return 0; /* TCP fallback */
  }

+static inline struct request_sock *mptcp_subflow_reqsk_alloc(const struct request_sock_ops *ops,
+							     struct sock *sk_listener,
+							     bool attach_listener)
+{
+	return NULL;
+}
+
  static inline __be32 mptcp_reset_option(const struct sk_buff *skb)  { return htonl(0u); }
  #endif /* CONFIG_MPTCP */

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
@@ -483,7 +483,7 @@ do_reset:
  	mptcp_subflow_reset(sk);
  }

-struct request_sock_ops mptcp_subflow_request_sock_ops;
+static struct request_sock_ops mptcp_subflow_request_sock_ops __ro_after_init;
  static struct tcp_request_sock_ops subflow_request_sock_ipv4_ops __ro_after_init;

  static int subflow_v4_conn_request(struct sock *sk, struct sk_buff *skb)
@@ -536,6 +536,16 @@ drop:
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


Patches currently in stable-queue which might be from matthieu.baerts@tessares.net are

queue-5.15/mptcp-remove-mptcp-ifdef-in-tcp-syn-cookies.patch
