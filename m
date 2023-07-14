Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A57D311CB0
	for <mptcp@lists.linux.dev>; Fri, 14 Jul 2023 11:30:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1689334204;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=R/viohNaCGpZg6Ug7HQvJkvWKxqGxBc1fzuotFp8KL4=;
	b=QVdDdK2eloA9AruVIzRnzQ5WNDjFS9yObEZsRfRIxtkY+HLJ9OSzraoDtnDSv7Mu2fsRJ/
	clUojfLMwdSN0Fc+uNd1p5nAB8ofdO3RL7DVDMXVe9SmKgMCq4RHIgy2pdrTc0kaADM6S+
	RoM42GU4M7DBkIcR0TzIv4qVZaXApBo=
Received: from mimecast-mx02.redhat.com (66.187.233.73 [66.187.233.73]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-136-V_I5lMoiMxyLFZGVapldew-1; Fri, 14 Jul 2023 07:30:03 -0400
X-MC-Unique: V_I5lMoiMxyLFZGVapldew-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2B2DF3C01D8C
	for <mptcp@lists.linux.dev>; Fri, 14 Jul 2023 11:30:03 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.45.225.62])
	by smtp.corp.redhat.com (Postfix) with ESMTP id AE27C2166B25
	for <mptcp@lists.linux.dev>; Fri, 14 Jul 2023 11:30:02 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Subject: [PATCH v2 mptcp-next 08/13] mptcp: avoid additional indirection in mptcp_poll()
Date: Fri, 14 Jul 2023 13:29:39 +0200
Message-ID: <911ac5beb00f45e6c63764a01507ad9164e55d5d.1689334116.git.pabeni@redhat.com>
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
the additional indirection at poll() time. Instead access
directly the first subflow sock.

No functional changes intended.

Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
 net/mptcp/protocol.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 4d9775f45dd6..bed379bea8e3 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -3886,12 +3886,12 @@ static __poll_t mptcp_poll(struct file *file, struct socket *sock,
 	state = inet_sk_state_load(sk);
 	pr_debug("msk=%p state=%d flags=%lx", msk, state, msk->flags);
 	if (state == TCP_LISTEN) {
-		struct socket *ssock = READ_ONCE(msk->subflow);
+		struct sock *ssk = READ_ONCE(msk->first);
 
-		if (WARN_ON_ONCE(!ssock || !ssock->sk))
+		if (WARN_ON_ONCE(!ssk))
 			return 0;
 
-		return inet_csk_listen_poll(ssock->sk);
+		return inet_csk_listen_poll(ssk);
 	}
 
 	shutdown = READ_ONCE(sk->sk_shutdown);
-- 
2.41.0

