Received: from us-smtp-delivery-74.mimecast.com (us-smtp-delivery-74.mimecast.com [170.10.129.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99CD97F4
	for <mptcp@lists.linux.dev>; Fri,  6 May 2022 09:21:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1651828886;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=WWJwwH7Z7c6I4hQNbK34IQbG6et0V0n7VjO7O5IA+kg=;
	b=CwxWWlj/xIsq2XKa2wuzNPCXPS7i6CJNrsnLEJOXAHcy8QkcN0MqukEd7RYT5ADNmVTQir
	0dmwLI41+4VcbXPY+rrM9a+bEVueGVEFUTHIZKwTXsKSOyfkGGBDiQFpbXKRJrX1ueMwWF
	tc0DY2mJGbbBhLhmLonLj5+bZM0bCRI=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-609-WlylO9f0Nem_49ejmk0yNA-1; Fri, 06 May 2022 05:21:25 -0400
X-MC-Unique: WlylO9f0Nem_49ejmk0yNA-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E424338C5C46
	for <mptcp@lists.linux.dev>; Fri,  6 May 2022 09:21:24 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.39.195.157])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 72292428F11
	for <mptcp@lists.linux.dev>; Fri,  6 May 2022 09:21:24 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Subject: [PATCH net v3] net/sched: act_pedit: really ensure the skb is writable
Date: Fri,  6 May 2022 11:21:17 +0200
Message-Id: <7ec2ff1bd88c6d87e452afa58f1f6b6c756a2fb0.1651828857.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.9
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
v2 -> v3:
 - release lock on error (Mat)

note: part of the changelog is here, because -net will see only v2
(hopefully)
---
 include/net/tc_act/tc_pedit.h |  1 +
 net/sched/act_pedit.c         | 26 ++++++++++++++++++++++----
 2 files changed, 23 insertions(+), 4 deletions(-)

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
index e01ef7f109f4..d1221daa0952 100644
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
+		goto unlock;
+
 	tcf_lastuse_update(&p->tcf_tm);
 
 	if (p->tcfp_nkeys > 0) {
@@ -403,6 +420,7 @@ static int tcf_pedit_act(struct sk_buff *skb, const struct tc_action *a,
 	p->tcf_qstats.overlimits++;
 done:
 	bstats_update(&p->tcf_bstats, skb);
+unlock:
 	spin_unlock(&p->tcf_lock);
 	return p->tcf_action;
 }
-- 
2.35.1

