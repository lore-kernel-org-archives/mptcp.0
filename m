Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A514843D501
	for <mptcp@lists.linux.dev>; Fri, 14 Aug 2026 13:38:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786714723; cv=none; b=f1leEG4oklm0RRey6nDsHG8Crbrc5mKyQ2LnCZXkwseS/QstapwGgtmjG7oqMp8ZQWHgPcnOap2l+K4BRRRq6ElzgJrNkrDbQSovRYI3zUWx6bfUFc8VI4idCtIykx503k1pRXd5bbILl5YGSu6TWgk95fK/Of/wgN+xidatPuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786714723; c=relaxed/simple;
	bh=S4Jy9kXq4zyZDYgEG1MWwO2idTZz8zIunAPh6OESQYo=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=K1txcoxrBdso5/J3bme4PEPhQJyPVVnRyNiAg+ONoOTyzx71QwVN46Jw4/hjN39xJY2VzuTo42PHZIQ4bLSZVbLaLime5FJa+OvowQSU8RzajHeZar6vPN4zsGDe6G6c3qpkpBSG0RiXuxw0A5397hQ0eju1KA8dhK/nw86Kbew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IDLc048L; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IDLc048L"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1786714720;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=o2MdFdNU7PStgkd8Yi7t4hlCuD6mRkrOcjrmSc7BMUY=;
	b=IDLc048LdT/NvLvgfoRZlkn9YUSmDiY6SV5tHUJtPiTm4AmZk1sac80d3c7YtXhs30/Zum
	UBCP5zYHMUsqUfZBAJMs3+XiiOfrBfE60QawnBLznGQxztC24XvX5qKFBq9qflNRa6RiRd
	y3e+yk/k5oDJveun0N7he7tMZWTys8k=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-607-HkA38gC3PLWZgpiMm168Ww-1; Fri,
 14 Aug 2026 09:38:36 -0400
X-MC-Unique: HkA38gC3PLWZgpiMm168Ww-1
X-Mimecast-MFC-AGG-ID: HkA38gC3PLWZgpiMm168Ww_1786714715
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 308B818001E2
	for <mptcp@lists.linux.dev>; Fri, 14 Aug 2026 13:38:35 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.44.48.145])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 720CF180034F
	for <mptcp@lists.linux.dev>; Fri, 14 Aug 2026 13:38:34 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Subject: [PATCH resend mptcp-net 3/4] mptcp: remove unneeded READ_ONCE() annotation
Date: Fri, 14 Aug 2026 15:38:22 +0200
Message-ID: <904e519f63b9ddbebb474dfea2672ac18c6d6f4f.1786713351.git.pabeni@redhat.com>
In-Reply-To: <cover.1786713351.git.pabeni@redhat.com>
References: <cover.1786713351.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: txUP9cZhPzvRIw2cG1tZQP5xEnqRPZahxCYagYZPQAc_1786714715
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

The subflow->fully_established flag is always written under the subflow
socket lock. Reading such value under the same lock does not require any
ONCE annotation.

Fixes: 581c8cbfa934 ("mptcp: annotate data-races around subflow->fully_established")
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
 net/mptcp/options.c  | 4 ++--
 net/mptcp/protocol.c | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index 1bb486daf56a..8a299a8ef5e0 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -529,7 +529,7 @@ static bool mptcp_established_options_mp(struct sock *sk, struct sk_buff *skb,
 		return false;
 
 	/* MPC/MPJ needed only on 3rd ack packet, DATA_FIN and TCP shutdown take precedence */
-	if (READ_ONCE(subflow->fully_established) || snd_data_fin_enable ||
+	if (subflow->fully_established || snd_data_fin_enable ||
 	    subflow->snd_isn != TCP_SKB_CB(skb)->seq ||
 	    sk->sk_state != TCP_ESTABLISHED)
 		return false;
@@ -980,7 +980,7 @@ static bool check_fully_established(struct mptcp_sock *msk, struct sock *ssk,
 	/* here we can process OoO, in-window pkts, only in-sequence 4th ack
 	 * will make the subflow fully established
 	 */
-	if (likely(READ_ONCE(subflow->fully_established))) {
+	if (likely(subflow->fully_established)) {
 		/* on passive sockets, check for 3rd ack retransmission
 		 * note that msk is always set by subflow_syn_recv_sock()
 		 * for mp_join subflows
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 2ee23e9411be..b311fe30c785 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -3912,7 +3912,7 @@ static void schedule_3rdack_retransmission(struct sock *ssk)
 	struct tcp_sock *tp = tcp_sk(ssk);
 	unsigned long timeout;
 
-	if (READ_ONCE(mptcp_subflow_ctx(ssk)->fully_established))
+	if (mptcp_subflow_ctx(ssk)->fully_established)
 		return;
 
 	/* reschedule with a timeout above RTT, as we must look only for drop */
-- 
2.55.0

