Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C91C1851
	for <mptcp@lists.linux.dev>; Fri, 29 Apr 2022 17:29:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1651253365;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=rHlAIXgOVd6JVjWy2VFL+bJzksNqdi2UGvbZy9mkgwM=;
	b=aN5NZiaB/ERcopBvd7VxGX6cUV0jAWZSgjSAq5b+RyOgDMeIw37aGtNTraflNtcwqfv7r6
	XHfH9yOnpVbXFcOcIW9MpvRtg8zjkgXCI3tEWHUSEDx2KmIl6IYjArgmgFqQKV5LKghted
	3qjFOiBhgCYDP+/KUiVdCWrSAIA9nRg=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-511-heooFJjmM3iqJuVdAYjRtw-1; Fri, 29 Apr 2022 13:29:24 -0400
X-MC-Unique: heooFJjmM3iqJuVdAYjRtw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 1CAA318E0043
	for <mptcp@lists.linux.dev>; Fri, 29 Apr 2022 17:29:24 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.39.193.69])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 99012414A7E7
	for <mptcp@lists.linux.dev>; Fri, 29 Apr 2022 17:29:23 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Subject: [PATCH mptcp-net v2] net/sched: act_pedit: really ensure the skb is writable
Date: Fri, 29 Apr 2022 19:29:17 +0200
Message-Id: <26445210b10b18b39129c4ede9d7fde0e37fe21f.1651253087.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.11.54.2
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

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
v1 -> v2:
 - fix build issue
 - account for the skb hdr offset, too

this almost solves issues/265 here. I'm still getting some rare
failure with MPTcpExtMPFailTx==0: sometimes the transfer completes
before we are able to use the 2nd/failing link. The relevant fix
is a purely seft-test one

Note that a much simpler alternatives would be simply replacing
skb_unshare() with skb_ensure_writable(skb, skb->len), but that
really could causes more visible regressions
---
 include/net/tc_act/tc_pedit.h |  1 +
 net/sched/act_pedit.c         | 23 +++++++++++++++++++++--
 2 files changed, 22 insertions(+), 2 deletions(-)

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
index e01ef7f109f4..301ad7f19da9 100644
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
@@ -228,6 +228,20 @@ static int tcf_pedit_init(struct net *net, struct nlattr *nla,
 		p->tcfp_nkeys = parm->nkeys;
 	}
 	memcpy(p->tcfp_keys, parm->keys, ksize);
+	p->tcfp_off_max_hint = 0;
+	for (i = 0; i < p->tcfp_nkeys; ++i) {
+		u32 cur = p->tcfp_keys[i].off;
+
+		/* The AT option can read a single byte, we can bound the actual
+		 * value with uchar max. Each key touches 4 bytes starting from
+		 * the computed offset
+		 */
+		if (p->tcfp_keys[i].offmask) {
+			cur += 255 >> p->tcfp_keys[i].shift;
+			cur = max(p->tcfp_keys[i].at, cur);
+		}
+		p->tcfp_off_max_hint = max(p->tcfp_off_max_hint, cur + 4);
+	}
 
 	p->tcfp_flags = parm->flags;
 	goto_ch = tcf_action_set_ctrlact(*a, parm->action, goto_ch);
@@ -308,9 +322,14 @@ static int tcf_pedit_act(struct sk_buff *skb, const struct tc_action *a,
 			 struct tcf_result *res)
 {
 	struct tcf_pedit *p = to_pedit(a);
+	u32 max_offset;
 	int i;
 
-	if (skb_unclone(skb, GFP_ATOMIC))
+	max_offset = (skb_transport_header_was_set(skb) ?
+		      skb_transport_offset(skb) :
+		      skb_network_offset(skb)) +
+		     p->tcfp_off_max_hint;
+	if (skb_ensure_writable(skb, min(skb->len, max_offset)))
 		return p->tcf_action;
 
 	spin_lock(&p->tcf_lock);
-- 
2.35.1

