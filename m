Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C4454A97
	for <mptcp@lists.linux.dev>; Fri, 18 Feb 2022 15:17:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1645197454;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gGABeR76OT7boktJeZcpdDVx6P1l3sl/4UkqnNBVzUg=;
	b=WeRxC2ciD74ceBISIrjtfBxuFyHeS4yCJ+5/N1H63LiPcXXdkKpEbUGhN1xmELxwZIEFHw
	oej5/2Fo9fNjszZxfCKQavaLXROOhXlePtzwTIvNBFyVG/E2VLvcdvf/6Y6xRFNPQh0gah
	t3Z6Z3rkUTzymPJ88BMSxWY208iagCE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-281-cJ8IPFskM-qqBE4hqvGEOA-1; Fri, 18 Feb 2022 10:17:32 -0500
X-MC-Unique: cJ8IPFskM-qqBE4hqvGEOA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A1BC11091DA0
	for <mptcp@lists.linux.dev>; Fri, 18 Feb 2022 15:17:31 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.39.192.232])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 1723F7CAD5
	for <mptcp@lists.linux.dev>; Fri, 18 Feb 2022 15:17:30 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Subject: [PATCH mptcp-net 1/2] mptcp: accurate SIOCOUTQ for fallback socket
Date: Fri, 18 Feb 2022 16:17:20 +0100
Message-Id: <925c8780acf59dbcf647eeec18e5884e4cfc119b.1645196974.git.pabeni@redhat.com>
In-Reply-To: <cover.1645196974.git.pabeni@redhat.com>
References: <cover.1645196974.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
	auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pabeni@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"

The MPTCP SIOCOUTQ implementation is not very accurate in
case of fallback: it only measures the data in the MPTCP-level
write queue, but it does not take in account the subflow
write queue utilization. In case of fallback the first can be
empty, while the latter is not.

The above produces sporadic self-tests issues and can foul
legit user-space application.

Fix the issue additionally querying the subflow in case of fallback.

Fixes: 644807e3e462 ("mptcp: add SIOCINQ, OUTQ and OUTQNSD ioctls")
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
 net/mptcp/protocol.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index bf5af6bf8756..a033ffa49fd7 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -3325,6 +3325,17 @@ static int mptcp_ioctl_outq(const struct mptcp_sock *msk, u64 v)
 		return 0;
 
 	delta = msk->write_seq - v;
+	if (__mptcp_check_fallback(msk) && msk->first) {
+		struct tcp_sock *tp = tcp_sk(msk->first);
+
+		/* the first subflow is disconnected after close - see
+		 * __mptcp_close_ssk(). tcp_disconnect() moves the write_seq
+		 * so ignore that status, too.
+		 */
+		if (!((1 << msk->first->sk_state) &
+		      (TCPF_SYN_SENT | TCPF_SYN_RECV | TCPF_CLOSE)))
+			delta += READ_ONCE(tp->write_seq) - tp->snd_una;
+	}
 	if (delta > INT_MAX)
 		delta = INT_MAX;
 
-- 
2.34.1

