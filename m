Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D7401DE8BB
	for <mptcp@lists.linux.dev>; Fri,  7 Nov 2025 00:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762474259; cv=none; b=hdhYDQHHjsqMY0/in8dVkUUhAvwgJxtY56x2MAoKq4G8XOpnZ69yb164fF4Q6rGB+mkitYDF7qw6AxmdwsGJDwcO+pMIuiADFjDMw0d5cm1Jd3AiajcJeLt9HREbx1L5IpIXvotccctH8kYsORBHjLnM1iG0QTQp4Gsu5aCbCsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762474259; c=relaxed/simple;
	bh=fx0JC+6uuq3erkSA25JU/Z2ThXQqAbjWSgfZBpcGZgk=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:content-type; b=Qa44Yw5OBEBZVN8d0tXSdA8xP8uuKHT7S/B5W3RysEGIFpB3K7mbKhljTnsI9gKcs+RisSMOW27BzqHImV194/ofVyJfeF3sjht4irSAqDOkFaTkJnhUvl9qQpPqehT2CM1GSDlOJKy3j/aNrE0jib4MRwi/MqyOZ/JPIbUHotw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=g4z0NyRy; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="g4z0NyRy"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762474256;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=lAF6R7GSsGospSNpI7Xnish+883xby3ddw7VVT8l3Jc=;
	b=g4z0NyRyOsrny2JzTYj1kXpuwoe8XuVpjSIo3zRytX31mzoPKzIG3wNuGwncJYqbeofDTj
	dgJzjKcWDUBbXbFZ+YbAh/IDskwz3v7k7+Awvs4RrecFhbexW7saj6MQ6/NcRnnt51oB9k
	l8pYk/1mG8KVQ9spyEiWI7/bYsP3mYs=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-75-kTBfmvmdMnm0b3fZgrteTA-1; Thu,
 06 Nov 2025 19:10:55 -0500
X-MC-Unique: kTBfmvmdMnm0b3fZgrteTA-1
X-Mimecast-MFC-AGG-ID: kTBfmvmdMnm0b3fZgrteTA_1762474254
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 456A1180120E
	for <mptcp@lists.linux.dev>; Fri,  7 Nov 2025 00:10:54 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.45.224.143])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 67A141800362
	for <mptcp@lists.linux.dev>; Fri,  7 Nov 2025 00:10:53 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Subject: [PATCH mptcp-net] mptcp: fix ack generation for fallback msk
Date: Fri,  7 Nov 2025 01:10:38 +0100
Message-ID: <14a868192851deb4145a90e3b7eec616544da262.1762474159.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: NSXEBTyEj0DzNcJHWmReVai7vpqrEZyM-GfiiqFc2DA_1762474254
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

mptcp_cleanup_rbuf() need to know the last most recent, mptcp-level
rcv_wnd sent, and such information is tracked into the msk->old_wspace
field, updated at ack transmission time by mptcp_write_options().

Fallback socket do not add any mptcp options, such helper is never
invoked, and msk->old_wspace value remain stale. That in turn makes
ack generation at recvmsg() time quite randomic.

Address the issue ensuring mptcp_write_options() is invoked even
for fallback sockets, and just update the needed info in such a
case.

The issue went unnoticed for a long time, as mptcp overshot the
fallback socket receive buffer autotune significantly.

Fixes: e3859603ba13 ("mptcp: better msk receive window updates")
Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/594
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
 net/mptcp/options.c | 22 +++++++++++++++++++++-
 1 file changed, 21 insertions(+), 1 deletion(-)

diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index ad51dcf18984..8d3b0f9754dc 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -838,8 +838,11 @@ bool mptcp_established_options(struct sock *sk, struct sk_buff *skb,
 
 	opts->suboptions = 0;
 
+	/* Force later mptcp_write_options(), but do not use any actual
+	 * option space.
+	 */
 	if (unlikely(__mptcp_check_fallback(msk) && !mptcp_check_infinite_map(skb)))
-		return false;
+		return true;
 
 	if (unlikely(skb && TCP_SKB_CB(skb)->tcp_flags & TCPHDR_RST)) {
 		if (mptcp_established_options_fastclose(sk, &opt_size, remaining, opts) ||
@@ -1351,6 +1354,20 @@ static void mptcp_set_rwin(struct tcp_sock *tp, struct tcphdr *th)
 	subflow->rcv_wnd_sent = rcv_wnd_new;
 }
 
+static void mptcp_track_rwin(struct tcp_sock *tp)
+{
+	const struct sock *ssk = (const struct sock *)tp;
+	struct mptcp_subflow_context *subflow;
+	struct mptcp_sock *msk;
+
+	if (!ssk)
+		return;
+
+	subflow = mptcp_subflow_ctx(ssk);
+	msk = mptcp_sk(subflow->conn);
+	WRITE_ONCE(msk->old_wspace, tp->rcv_wnd);
+}
+
 __sum16 __mptcp_make_csum(u64 data_seq, u32 subflow_seq, u16 data_len, __wsum sum)
 {
 	struct csum_pseudo_header header;
@@ -1643,6 +1660,9 @@ void mptcp_write_options(struct tcphdr *th, __be32 *ptr, struct tcp_sock *tp,
 				      opts->reset_transient,
 				      opts->reset_reason);
 		return;
+	} else if (unlikely(!opts->suboptions)) {
+		mptcp_track_rwin(tp);
+		return;
 	}
 
 	if (OPTION_MPTCP_PRIO & opts->suboptions) {
-- 
2.51.0

