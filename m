Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 646FF107B5
	for <mptcp@lists.linux.dev>; Mon, 10 Jul 2023 12:55:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1688993727;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wa/ZlhG+k1IftF5d3O4sL6G2mLk2xt1uCCzpMzVoCPg=;
	b=ALyBzL9Et4i6XGNrieQaGLSg1BwyfmJlSqkyPi1KvpX1xoDuJJv05MAhE2Ea6X/wZWSt1r
	sKD9cPsWx1KaqrbQg8mfZeZpRyu2T2m0m9CWNrHxWopU8Nvb9ko54/4nAmYaDvw1YzwUOP
	j6F5RcFAPehMogK4yvD3Alk1WCDp90M=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-448-hAMIJ-G4PQe5QL3Ygl9KSQ-1; Mon, 10 Jul 2023 08:55:26 -0400
X-MC-Unique: hAMIJ-G4PQe5QL3Ygl9KSQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B47F9185A792
	for <mptcp@lists.linux.dev>; Mon, 10 Jul 2023 12:55:25 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.45.225.74])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 428DDC09A09
	for <mptcp@lists.linux.dev>; Mon, 10 Jul 2023 12:55:25 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Subject: [PATCH mptcp-next 04/14] mptcp: avoid subflow socket usage in mptcp_get_port()
Date: Mon, 10 Jul 2023 14:54:59 +0200
Message-ID: <fa65b0cbd0b4b6781fc84119d9cba7abca5c66c1.1688993569.git.pabeni@redhat.com>
In-Reply-To: <cover.1688993569.git.pabeni@redhat.com>
References: <cover.1688993569.git.pabeni@redhat.com>
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

We are going to remove the first subflow socket soon, so avoid
accessing it in mptcp_get_port(). Instead, access directly the
first subflow sock.

Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
 net/mptcp/protocol.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 7445a3cf8812..fe4232870a37 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -3445,14 +3445,12 @@ static void mptcp_unhash(struct sock *sk)
 static int mptcp_get_port(struct sock *sk, unsigned short snum)
 {
 	struct mptcp_sock *msk = mptcp_sk(sk);
-	struct socket *ssock;
 
-	ssock = msk->subflow;
-	pr_debug("msk=%p, subflow=%p", msk, ssock);
-	if (WARN_ON_ONCE(!ssock))
+	pr_debug("msk=%p, ssk=%p", msk, msk->first);
+	if (WARN_ON_ONCE(!msk->first))
 		return -EINVAL;
 
-	return inet_csk_get_port(ssock->sk, snum);
+	return inet_csk_get_port(msk->first, snum);
 }
 
 void mptcp_finish_connect(struct sock *ssk)
-- 
2.41.0

