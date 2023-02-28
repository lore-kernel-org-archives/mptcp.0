Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0B5163C5
	for <mptcp@lists.linux.dev>; Tue, 28 Feb 2023 16:19:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1677601179;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/iXq/NoS2p3qbS9IpXKB31grijKZXXoSaALoxwvnKZA=;
	b=DyQ7/0+E/Ia0yxtxhS/69AvQKhytiedMIvMHUVoZYffOF75ou4kf7O5I0c809FdlL3P7A3
	ppTSaoHP9nS1Bcd8hjGQl4jBGfX0TSh5fzVV/vbHv8+IiM5/4YDtMSMxnfQeQBHi1K0zzQ
	83+S6Ue8U0n5YuQ/8vaWeBd0+LNwn4Q=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-605-sb3zeOixNjir1IU32pW0YQ-1; Tue, 28 Feb 2023 11:19:37 -0500
X-MC-Unique: sb3zeOixNjir1IU32pW0YQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 252A3380673F
	for <mptcp@lists.linux.dev>; Tue, 28 Feb 2023 16:19:37 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.39.192.235])
	by smtp.corp.redhat.com (Postfix) with ESMTP id A9F072026D4B
	for <mptcp@lists.linux.dev>; Tue, 28 Feb 2023 16:19:36 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Subject: [PATCH mptcp-net 2/2] Squash-to: "mptcp: fix UaF in listener shutdown"
Date: Tue, 28 Feb 2023 17:19:20 +0100
Message-Id: <b3b1b34e6bde7a43e0bea07318740385e26916f4.1677600530.git.pabeni@redhat.com>
In-Reply-To: <ee3e0181ffd7e4d81ed43d27f18401da3d5927d6.1677600530.git.pabeni@redhat.com>
References: <ee3e0181ffd7e4d81ed43d27f18401da3d5927d6.1677600530.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"; x-default=true

This just removes left-over code that should have been
dropped already by the squash-to target.

Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
 net/mptcp/protocol.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 467989c2b0ec..c19e48e57779 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -2421,11 +2421,9 @@ static void __mptcp_close_ssk(struct sock *sk, struct sock *ssk,
 		mptcp_subflow_drop_ctx(ssk);
 	} else {
 		/* otherwise tcp will dispose of the ssk and subflow ctx */
-		if (ssk->sk_state == TCP_LISTEN) {
-			tcp_set_state(ssk, TCP_CLOSE);
-			inet_csk_listen_stop(ssk);
+		if (ssk->sk_state == TCP_LISTEN)
 			mptcp_event_pm_listener(ssk, MPTCP_EVENT_LISTENER_CLOSED);
-		}
+
 		__tcp_close(ssk, 0);
 
 		/* close acquired an extra ref */
-- 
2.39.2

