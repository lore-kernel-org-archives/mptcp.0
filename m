Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B59AB7E7
	for <mptcp@lists.linux.dev>; Thu,  4 May 2023 16:40:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1683218409;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Q1dKMcLvhcsc0NRCsBG22Oon1AFKxkq1XKFdKfFqVgY=;
	b=Tl+gyQ//5dYrqpSbAALD7eHoD1YDC2ihxpVOxaA/W1BQdKYEG+joaUOkwmqeFhfijOZRct
	Od3zG05j0JQHc2+skCjnp2lPEWi5FbmcoaEH+2uc+AfsNq10qlVPgOv1Y1a5wKcx/Z8x/T
	+j0FSwUcHKU4iAPY5wWbgK79Sk4TAWQ=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-657-h7hZspM8OpWmouarMviICg-1; Thu, 04 May 2023 12:40:07 -0400
X-MC-Unique: h7hZspM8OpWmouarMviICg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 718B93813F3E
	for <mptcp@lists.linux.dev>; Thu,  4 May 2023 16:40:07 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.39.193.75])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 03B0A1121331
	for <mptcp@lists.linux.dev>; Thu,  4 May 2023 16:40:06 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Subject: [PATCH mptcp-next 0/4] mptcp: add some more diag info
Date: Thu,  4 May 2023 18:39:58 +0200
Message-Id: <cover.1683212362.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"; x-default=true

This is a follow up to the topic discussed in recent pubblic mtg.

Introduces unique id for accurate subflow stats tracking and
aggregate mptcp counters, plus some minimal self-tests.

The tests themself do not take in account support for running on
older kernel.

This is on top of "selftests: mptcp: centralize stats dumping" - 
that is should land not on top of the current export branch head.

That in turn will cause some non trivial conflicts with:

"mptcp: use get_retrans wrapper"

the resolution should like the following (for brevity only reporting
the lines affected by the conflict resolution)

---
@@ -2574,16 +2569,17 @@ static void mptcp_check_fastclose(struct mptcp_sock *msk)
 static void __mptcp_retrans(struct sock *sk)
 {
 	struct mptcp_sock *msk = mptcp_sk(sk);
+	struct mptcp_subflow_context *subflow;
 	struct mptcp_sendmsg_info info = {};
 	struct mptcp_data_frag *dfrag;
-	size_t copied = 0;
+	u16 already_sent, len = 0;
 	struct sock *ssk;
-	int ret;
+	int ret, err;

	// ...
@@ -2602,32 +2598,48 @@ static void __mptcp_retrans(struct sock *sk)
	// ...
 
-	release_sock(ssk);
+	already_send = max(dfrag->already_sent, len);
+	msk->bytes_retrans += already_sent - dfrag->alread_sent;
+	dfrag->already_sent = already_sent;

	// ...

Paolo Abeni (4):
  mptcp: add subflow unique id
  mptcp: move snd_una update earlier for fallback socket.
  mptcp: track some aggregate data counters.
  selftests: mptcp: explicitly tests aggregate countes

 include/uapi/linux/mptcp.h                    |  8 +++++++
 net/mptcp/options.c                           | 14 ++++++++++-
 net/mptcp/protocol.c                          | 20 ++++++++++------
 net/mptcp/protocol.h                          |  9 +++++++-
 net/mptcp/sockopt.c                           | 23 +++++++++++++++----
 .../selftests/net/mptcp/mptcp_sockopt.c       | 20 ++++++++++++++++
 6 files changed, 80 insertions(+), 14 deletions(-)

-- 
2.40.0

