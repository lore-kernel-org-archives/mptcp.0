Received: from us-smtp-delivery-74.mimecast.com (us-smtp-delivery-74.mimecast.com [170.10.133.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60CDB2568
	for <mptcp@lists.linux.dev>; Thu,  5 May 2022 15:19:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1651763966;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=NjzztI/g3DGpwECMhfn49droPq5TshiT2QY7OqVjf5E=;
	b=UrRCi535VqdRuQ3DLV5Z7+6wlc1ldNxDMyYMbDsP6lSWR8plb1sCioVuS4v4wd2kMu1GS/
	favUunOftsG1Dgvyl3iPBI8lYHumiyAQORpjFHgCsZGAlbyeUpavo2RAVXyhpJMcUUJHf3
	rM7LlAuxjurUw9lsfwW+Jc9KKronthY=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-404-W3OO5NmUN0OoWdehGEHO7Q-1; Thu, 05 May 2022 11:19:25 -0400
X-MC-Unique: W3OO5NmUN0OoWdehGEHO7Q-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D7789299E755
	for <mptcp@lists.linux.dev>; Thu,  5 May 2022 15:19:24 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.39.194.241])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 6B829C15D7D
	for <mptcp@lists.linux.dev>; Thu,  5 May 2022 15:19:24 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Subject: [PATCH net] From 4223a13095ac07a36ecaf0758734e031508529f9 Mon Sep 17 00:00:00 2001 Message-Id: <4223a13095ac07a36ecaf0758734e031508529f9.1651760706.git.pabeni@redhat.com> From: Paolo Abeni <pabeni@redhat.com> Date: Tue, 3 May 2022 05:52:04 +0000 Subject: [PATCH net] net/sched: act_pedit: really ensure the skb is writable
Date: Thu,  5 May 2022 17:18:47 +0200
Message-Id: <f5b98636245e625134dcf8daed5b67389bd8439a.1651763903.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.8
Authentication-Results: relay.mimecast.com;
	auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pabeni@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"; x-default=true

Currently pedit tries to ensure that the accessed skb offset
is writeble via skb_unclone(). The action potentially allows
touching any skb bytes, so it may end-up modifying shared data.

The above causes some sporadic MPTCP self-test failures.

Address the issue keeping track of a rough over-estimate highest skb
offset accessed by the action and ensure such offset is really
writable.

Note that this may cause performance regressions in some scenario,
but hopefully pedit is not critical path.

v1 -> v2:
 - cleanup hint update (Jakub)
 - avoid raices while accessing the hint (Jakub)
 - re-organize the comments for clarity

Fixes: db2c24175d14 ("act_pedit: access skb->data safely")
Acked-by: Mat Martineau <mathew.j.martineau@linux.intel.com>
Tested-by: Geliang Tang <geliang.tang@suse.com>
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
 include/net/tc_act/tc_pedit.h |  1 +
 net/sched/act_pedit.c         | 25 +++++++++++++++++++++----
 2 files changed, 22 insertions(+), 4 deletions(-)

diff --git a/include/net/tc_act/tc_pedit.h b/include/net/tc_act/tc_pedit.h
index 748cf87a4d7e..3e02709a1df6 100644
--- a/include/net/tc_act/tc_pedit.h
+++ b/include/net/tc_act/tc_pedit.h
@@ -14,6 +14,7 @@ struct tcf_pedit {
 	struct tc_action	common;
 	unsigned char		tcfp_nkeys;
 	unsigned char		tcfp_flags;
+	u32			tcfp_off_max_hint;
 	struct tc_pedit_key	*tcfp_keys;
 	struct tcf_pedit_key_ex	*tcfp_keys_ex;
 };
diff --git a/net/sched/act_pedit.c b/net/sched/act_pedit.c
index e01ef7f109f4..0fc07532e6f6 100644
--- a/net/sched/act_pedit.c
+++ b/net/sched/act_pedit.c
@@ -149,7 +149,7 @@ static int tcf_pedit_init(struct net *net, struct nlattr *nla,
 	struct nlattr *pattr;
 	struct tcf_pedit *p;
 	int ret = 0, err;
-	int ksize;
+	int i, ksize;
 	u32 index;
 
 	if (!nla) {
@@ -228,6 +228,18 @@ static int tcf_pedit_init(struct net *net, struct nlattr *nla,
 		p->tcfp_nkeys = parm->nkeys;
 	}
 	memcpy(p->tcfp_keys, parm->keys, ksize);
+	p->tcfp_off_max_hint = 0;
+	for (i = 0; i < p->tcfp_nkeys; ++i) {
+		u32 cur = p->tcfp_keys[i].off;
+
+		/* The AT option can read a single byte, we can bound the actual
+		 * value with uchar max.
+		 */
+		cur += (0xff & p->tcfp_keys[i].offmask) >> p->tcfp_keys[i].shift;
+
+		/* Each key touches 4 bytes starting from the computed offset */
+		p->tcfp_off_max_hint = max(p->tcfp_off_max_hint, cur + 4);
+	}
 
 	p->tcfp_flags = parm->flags;
 	goto_ch = tcf_action_set_ctrlact(*a, parm->action, goto_ch);
@@ -308,13 +320,18 @@ static int tcf_pedit_act(struct sk_buff *skb, const struct tc_action *a,
 			 struct tcf_result *res)
 {
 	struct tcf_pedit *p = to_pedit(a);
+	u32 max_offset;
 	int i;
 
-	if (skb_unclone(skb, GFP_ATOMIC))
-		return p->tcf_action;
-
 	spin_lock(&p->tcf_lock);
 
+	max_offset = (skb_transport_header_was_set(skb) ?
+		      skb_transport_offset(skb) :
+		      skb_network_offset(skb)) +
+		     p->tcfp_off_max_hint;
+	if (skb_ensure_writable(skb, min(skb->len, max_offset)))
+		return p->tcf_action;
+
 	tcf_lastuse_update(&p->tcf_tm);
 
 	if (p->tcfp_nkeys > 0) {
-- 
2.35.1

