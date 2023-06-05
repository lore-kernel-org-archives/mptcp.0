Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D279525E
	for <mptcp@lists.linux.dev>; Mon,  5 Jun 2023 11:06:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1685963197;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=l+JqkYVP/pUi820UHdf+daI8wqb2xinoQdLQvH/PS6o=;
	b=Cp9OZ+Wwvn8oDEpLwWrz77WKXuMeJoFwBOBzyiR0vqvihegl/XdQNBeaZs/UH5n/Yl4vDl
	jDd/JOKTkdwDl14e3yKZB3qME2EYxtWafvKUfyh/wI/1nlY9RTYAd4JbyJk1BoU9djKHdf
	RgSMrLp5fy1lXH3vhc66DMKZ2q42lrA=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-520-6UDrYv5cO_euG6ATuDKPcg-1; Mon, 05 Jun 2023 07:06:34 -0400
X-MC-Unique: 6UDrYv5cO_euG6ATuDKPcg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2BF68185A78F;
	Mon,  5 Jun 2023 11:06:34 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.39.194.47])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 8B8DEC154D1;
	Mon,  5 Jun 2023 11:06:33 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Cc: Christoph Paasch <cpaasch@apple.com>
Subject: [PATCH mptcp-net 1/2] squash-to: "mptcp: track some aggregate data counters"
Date: Mon,  5 Jun 2023 13:06:28 +0200
Message-Id: <829e91b37a2fc12a9a43f20204d26adc0572a7d3.1685963110.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"; x-default=true

Similar to TCP, we can't acquire the socket lock if msk is in
TCP_LISTEN status or we risk deadlock.

Note that the state test is safe since mptcp_listen() moves the msk
socket into the listener status before acquiring the listener hash
locks and such test is under the listener hash losk scope, so we
always observe up-to-date status WRT listener sockets.

Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
this should close both 407 & 408
---
 net/mptcp/sockopt.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/mptcp/sockopt.c b/net/mptcp/sockopt.c
index bfbe0378e997..f12b289a7d9d 100644
--- a/net/mptcp/sockopt.c
+++ b/net/mptcp/sockopt.c
@@ -900,6 +900,9 @@ void mptcp_diag_fill_info(struct mptcp_sock *msk, struct mptcp_info *info)
 	info->mptcpi_add_addr_accepted = READ_ONCE(msk->pm.add_addr_accepted);
 	info->mptcpi_local_addr_used = READ_ONCE(msk->pm.local_addr_used);
 
+	if (inet_sk_state_load(sk) == TCP_LISTEN)
+		return;
+
 	/* The following limits only make sense for the in-kernel PM */
 	if (mptcp_pm_is_kernel(msk)) {
 		info->mptcpi_subflows_max =
-- 
2.40.1

