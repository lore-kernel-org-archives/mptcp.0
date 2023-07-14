Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33AF1125A2
	for <mptcp@lists.linux.dev>; Fri, 14 Jul 2023 11:30:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1689334201;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7oCiXHlSeCgXFkps8zR82HjhZbnE6ljSkiKnD9X0nrw=;
	b=FWFR4JjgQ7aIFluiczwDuqs/myd7sRuOMzeiVW6eHhUhmOsC1BydIqClkGmaiuUb2fVADf
	xwOr0mGCO/CrSlySBzJfZ8gtBqHeFzM1ATjyaJTNAsP0DbUg9SUqKQagLpb5FYxgSfYwsX
	xR/vVIKJYlz8UYokwP3IIzgx47/SbDw=
Received: from mimecast-mx02.redhat.com (66.187.233.73 [66.187.233.73]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-133-msDvRzLFNBO-5c2ndVLxaQ-1; Fri, 14 Jul 2023 07:29:59 -0400
X-MC-Unique: msDvRzLFNBO-5c2ndVLxaQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 71B4A3C01E05
	for <mptcp@lists.linux.dev>; Fri, 14 Jul 2023 11:29:59 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.45.225.62])
	by smtp.corp.redhat.com (Postfix) with ESMTP id EAC842166B25
	for <mptcp@lists.linux.dev>; Fri, 14 Jul 2023 11:29:58 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Subject: [PATCH v2 mptcp-next 03/13] mptcp: avoid subflow socket usage in mptcp_get_port()
Date: Fri, 14 Jul 2023 13:29:34 +0200
Message-ID: <b413fde9099753b2243a845764877a6f07433e0e.1689334116.git.pabeni@redhat.com>
In-Reply-To: <cover.1689334116.git.pabeni@redhat.com>
References: <cover.1689334116.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
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
index 8eaf19c01c64..ba26c16eaecd 100644
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

