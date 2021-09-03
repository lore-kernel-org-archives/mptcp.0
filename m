Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DB7F3FC1
	for <mptcp@lists.linux.dev>; Fri,  3 Sep 2021 14:49:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1630680593;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=KqoSlox+28Xc6IWPe+MAl7EldR4ii3wl+hTK5Dge7Fs=;
	b=ZT6n0QUuowdF58UeBBvDzQXOUBbI1uSmWua8C/yVHRyjgy8sBVdyLhguzXB9+ToazX3heZ
	WjvEO17mwuAX4Wph6975QXJfFno/svgsr/Rw35xLmg5iQP/nZVOtAYSqclfjop5RPdOXn1
	qj0ZtCXkFgloLxcSSut4/YZ0Fe1T18c=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-416-P-s_erctNZ2NMRt7IbFzoA-1; Fri, 03 Sep 2021 10:49:51 -0400
X-MC-Unique: P-s_erctNZ2NMRt7IbFzoA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2F58DFC89
	for <mptcp@lists.linux.dev>; Fri,  3 Sep 2021 14:49:51 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.39.194.30])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 9B8FF5D9D3
	for <mptcp@lists.linux.dev>; Fri,  3 Sep 2021 14:49:50 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Subject: [PATCH mptcp-next] mptcp: use lockdep_assert_held_once() instead of open-codying it
Date: Fri,  3 Sep 2021 16:49:40 +0200
Message-Id: <837dc50592c4843c4de722a4b9cbad6663458a07.1630680563.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
	auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pabeni@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"

We have a few more places where the mptcp code duplicates
lockdep_assert_held_once(). Let's use the existing macro and
avoid a bunch of compiler's conditional.

Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
 net/mptcp/protocol.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 101e61bb2a80..472319b7e046 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -956,9 +956,7 @@ static void __mptcp_update_wmem(struct sock *sk)
 {
 	struct mptcp_sock *msk = mptcp_sk(sk);
 
-#ifdef CONFIG_LOCKDEP
-	WARN_ON_ONCE(!lockdep_is_held(&sk->sk_lock.slock));
-#endif
+	lockdep_assert_held_once(&sk->sk_lock.slock);
 
 	if (!msk->wmem_reserved)
 		return;
@@ -1117,9 +1115,8 @@ static void __mptcp_clean_una(struct sock *sk)
 
 static void __mptcp_clean_una_wakeup(struct sock *sk)
 {
-#ifdef CONFIG_LOCKDEP
-	WARN_ON_ONCE(!lockdep_is_held(&sk->sk_lock.slock));
-#endif
+	lockdep_assert_held_once(&sk->sk_lock.slock);
+
 	__mptcp_clean_una(sk);
 	mptcp_write_space(sk);
 }
-- 
2.26.3

