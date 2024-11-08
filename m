Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 415CD1E3DF9
	for <mptcp@lists.linux.dev>; Fri,  8 Nov 2024 10:59:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731063542; cv=none; b=h8YhRX5cLFbK+ZdVr6arrjbrCprGcjdiMpxoPPiKzqxyHePXamy3gJbvakSmX2jv4b8/uWee56DIhx4v5J8GIEdVpW1+aBfl2eotlgImkyRRw5QsG8AQF+KL7J3SwJB7cXtzCamuKcr6kLT5bD+6jPp1FRsJvDlACnIVNDp4Dnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731063542; c=relaxed/simple;
	bh=HnlIv0shPYlrmFHUiRovfXGGOpfl3wKy7+j8e+K5FkI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qlvPPycYYBSn6DbOWLNtiutRrpRGPDmxDu6SbZ37zjnXO6/TzjpXZfn4O1C/t4SJPx6icq1Mx390myirOXOfqZhDzSA3//OYKVRop2WgRTe76hq8BflpNbXunriVTWF8vN/pM4/c2yIZRc+An9UqfRO8Pbwqoxi88yJ3QvlMpns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TNPHwcZ2; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TNPHwcZ2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1731063540;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iR/x+dH77F1MdZ4GlNiB8vuIlGOSlBv4jBLCMBeFDpU=;
	b=TNPHwcZ2HHeq6jH1E5W0gMRQGCXDDSex7iPt1PI/DvtQ7zn1fMZ/ayUXk5huGo+molVEtn
	4vXKcnaVZZQyJNvbPvbgNsB06a7zCSmcqkKjSE1W6G2/MRf6RoB3y0u2YSRhVhbnlL0POH
	BB0duBZ2Nt7SvUlziewe5B3AAlnz4+0=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-499-8HrvlfFJOmyBmB4juogIgw-1; Fri,
 08 Nov 2024 05:58:56 -0500
X-MC-Unique: 8HrvlfFJOmyBmB4juogIgw-1
X-Mimecast-MFC-AGG-ID: 8HrvlfFJOmyBmB4juogIgw
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 1DFD21944DF3;
	Fri,  8 Nov 2024 10:58:55 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.39.193.90])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 2B9641956054;
	Fri,  8 Nov 2024 10:58:51 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: netdev@vger.kernel.org
Cc: Matthieu Baerts <matttbe@kernel.org>,
	Mat Martineau <martineau@kernel.org>,
	Geliang Tang <geliang@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Simon Horman <horms@kernel.org>,
	mptcp@lists.linux.dev
Subject: [PATCH net 2/2] mptcp: cope racing subflow creation in mptcp_rcv_space_adjust
Date: Fri,  8 Nov 2024 11:58:17 +0100
Message-ID: <02374660836e1b52afc91966b7535c8c5f7bafb0.1731060874.git.pabeni@redhat.com>
In-Reply-To: <cover.1731060874.git.pabeni@redhat.com>
References: <cover.1731060874.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

Additional active subflows - i.e. created by the in kernel path
manager - are included into the subflow list before starting the
3whs.

A racing recvmsg() spooling data received on an already established
subflow would unconditionally call tcp_cleanup_rbuf() on all the
current subflows, potentially hitting a divide by zero error on
the newly created ones.

Explicitly check that the subflow is in a suitable state before
invoking tcp_cleanup_rbuf().

Fixes: c76c6956566f ("mptcp: call tcp_cleanup_rbuf on subflows")
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
 net/mptcp/protocol.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 95a5a3da3944..48d480982b78 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -2082,7 +2082,8 @@ static void mptcp_rcv_space_adjust(struct mptcp_sock *msk, int copied)
 				slow = lock_sock_fast(ssk);
 				WRITE_ONCE(ssk->sk_rcvbuf, rcvbuf);
 				WRITE_ONCE(tcp_sk(ssk)->window_clamp, window_clamp);
-				tcp_cleanup_rbuf(ssk, 1);
+				if (tcp_can_send_ack(ssk))
+					tcp_cleanup_rbuf(ssk, 1);
 				unlock_sock_fast(ssk, slow);
 			}
 		}
-- 
2.45.2

