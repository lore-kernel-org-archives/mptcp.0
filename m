Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA7291F1306
	for <mptcp@lists.linux.dev>; Fri,  3 Oct 2025 14:02:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759500128; cv=none; b=W24WV9LWfnoiL89wJky8l7ZtiLTG6ED/JLCsUiBzXAcE4/uEYcdg3YAUCdX+/KrmryDtq1ryjCTGcEmpdwo0jajbf3fUHCJnybdIE1oBPaRM7wyI9jHoA3azHSPuTrJHpP7dODfIJfnUrT799VadjfqGanC012EzzBPDcA/SzHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759500128; c=relaxed/simple;
	bh=7VabBeinxxALiH5p3HdZiZxNb11DPqlBxE8kZRcUqUk=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=SOC1IMccDJnsGP0rANynygcYrpz9J5VCICNaLJrfHpd1rtxZ4pSVmf/pWcOMKUImcZQS4yG44y/RM6w6ehz2hTomWKa+uXBPu5T5RvngSEpk3IrLkIpor02zer3Ec7PJabFgHE2mn6kuiTDyeXQ8WP3hDKT/UxtL3qFggqt0kTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MNQuev0p; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MNQuev0p"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759500125;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vpdef+2OiUkv1+60fG/qup4gGgKhSS8bbflqwnqPxOQ=;
	b=MNQuev0puzPv2F6OBxIHN12oC3uMAQbUBTN0NMvHSt9ONOM5hgwuDMc5nmsuyh5gS8B7OT
	CsoDy2BqOE0i+00XP4GH9Jsi7tKd8lt6zzi/a553XoJ/QhGkM+55lvM/3/6a7eitkx3Xfj
	lO5FC+fupIRc510RL9iQ9aw1F9/ZhUc=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-338-wAkSYL5mOeicMpmc3bchWQ-1; Fri,
 03 Oct 2025 10:02:04 -0400
X-MC-Unique: wAkSYL5mOeicMpmc3bchWQ-1
X-Mimecast-MFC-AGG-ID: wAkSYL5mOeicMpmc3bchWQ_1759500122
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B4E231800299
	for <mptcp@lists.linux.dev>; Fri,  3 Oct 2025 14:02:02 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.44.32.53])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id CE4BE1800576
	for <mptcp@lists.linux.dev>; Fri,  3 Oct 2025 14:02:01 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Subject: [PATCH v4 mptcp-next 6/8] mptcp: do not miss early first subflow close event notification.
Date: Fri,  3 Oct 2025 16:01:44 +0200
Message-ID: <3f9dad349afe9c3fd1302da825e7ed907343c2d5.1759499837.git.pabeni@redhat.com>
In-Reply-To: <cover.1759499837.git.pabeni@redhat.com>
References: <cover.1759499837.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: -XNGuODSi61RAXFa7APibie1M6ZRPjcAksRWQ4Ae_to_1759500122
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

The MPTCP protocol is not currently emitting the NL event when the first
subflow is closed before msk accept() time.

By replacing the in use close helper is such scenario, implicitly introduce
the missing notification. Note that in such scenario we want to be sure
that mptcp_close_ssk() will not trigger any PM work, move the msk state
change update earlier, so that the previous patch will offer such
guarantee.

Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
 net/mptcp/protocol.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index ce1238f620c33..6ae5ab7595272 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -3988,10 +3988,10 @@ static int mptcp_stream_accept(struct socket *sock, struct socket *newsock,
 		 * deal with bad peers not doing a complete shutdown.
 		 */
 		if (unlikely(inet_sk_state_load(msk->first) == TCP_CLOSE)) {
-			__mptcp_close_ssk(newsk, msk->first,
-					  mptcp_subflow_ctx(msk->first), 0);
 			if (unlikely(list_is_singular(&msk->conn_list)))
 				mptcp_set_state(newsk, TCP_CLOSE);
+			mptcp_close_ssk(newsk, msk->first,
+					mptcp_subflow_ctx(msk->first));
 		}
 	} else {
 tcpfallback:
-- 
2.51.0

