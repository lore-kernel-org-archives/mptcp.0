Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D66A91852
	for <mptcp@lists.linux.dev>; Fri, 29 Apr 2022 15:52:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1651247551;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=d0EYtuplUKATUj+pDa3zzZxtvw/RDBedsgt0bpG+Bxg=;
	b=FQiBqmc+/htmlvO8RebGZqu684Ag0s1fhjRtMb05qZPm6dqEwN+2xdR80F5VbT8c63JJe9
	6aoUeRP206pgE782NyxVLZQJJiV5opqPh6SGsPHOlc2DcKNG8G0Cn2Itoubwcz/QxT0Qh8
	8cF3MKl0gM2DkyczAVxXULmTIm2CFbA=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-231-3RlPp5gKPEaKTKvgnu8bBQ-1; Fri, 29 Apr 2022 11:52:30 -0400
X-MC-Unique: 3RlPp5gKPEaKTKvgnu8bBQ-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C2F9A3C0E198
	for <mptcp@lists.linux.dev>; Fri, 29 Apr 2022 15:52:29 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.39.193.69])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 4EBD6469A52
	for <mptcp@lists.linux.dev>; Fri, 29 Apr 2022 15:52:29 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Subject: [PATCH mptcp-net] net/sched: act_pedit: really ensure the skb is writable
Date: Fri, 29 Apr 2022 17:52:22 +0200
Message-Id: <f64ef5eff420a2bb55103bbbb52c9dd527411da4.1651247530.git.pabeni@redhat.com>
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

Address the issue keeping track of the (estimated) highest skb
offset accessed by the action and ensure such offset is really
writable.

Note that this may cause performance regressions in some scenario,
but hopefully pedit is not critical path.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
this almost solves issues/265 here. I'm still getting some rare
failure with MPTcpExtMPFailTx==0: sometimes the transfer completes
before we are able to use the 2nd/failing link. The relevant fix
is a purely seft-test one
---
 include/net/tc_act/tc_pedit.h |  1 +
 net/sched/act_pedit.c         | 14 ++++++++++++--
 2 files changed, 13 insertions(+), 2 deletions(-)

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
index e01ef7f109f4..5ff37da2f9c3 100644
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
@@ -228,6 +228,16 @@ static int tcf_pedit_init(struct net *net, struct nlattr *nla,
 		p->tcfp_nkeys = parm->nkeys;
 	}
 	memcpy(p->tcfp_keys, parm->keys, ksize);
+	p->tcfp_off_max_hint = 0;
+	for (i = 0; i < p->tcfp_nkeys; ++i) {
+		u32 cur;
+
+		/* AT reads a single byte, we can bound the offset with UCHAR_MAX,
+		 * each key will touch 4 bytes
+		 */
+		cur = p->tcfp_keys[i].off + p->tcfp_keys[i].offmask ? UCHAR_MAX >> p->tcfp_keys[i].shift: 0;
+		p->tcfp_off_max_hint = max(p->tcfp_off_max_hint, cur + 4);
+	}
 
 	p->tcfp_flags = parm->flags;
 	goto_ch = tcf_action_set_ctrlact(*a, parm->action, goto_ch);
@@ -310,7 +320,7 @@ static int tcf_pedit_act(struct sk_buff *skb, const struct tc_action *a,
 	struct tcf_pedit *p = to_pedit(a);
 	int i;
 
-	if (skb_unclone(skb, GFP_ATOMIC))
+	if (skb_ensure_writable(skb, min(skb->len, p->tcfp_off_max_hint)))
 		return p->tcf_action;
 
 	spin_lock(&p->tcf_lock);
-- 
2.35.1

