Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 552458613B
	for <mptcp@lists.linux.dev>; Tue,  5 Mar 2024 14:09:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709647758; cv=none; b=d88R+5Y5tCeGuWNdODIMlJ+6NYu/ecBz8x70rGnYFcYeSgWIGWhCSWJBrB9kK/I/NNIH718/ML0BGT7SH6MyLAa7nAi+D9LTKpBJ7yS7qfXImrXrXheYZwZhBxcP7kAvS3LjEIXx3D81cRwsHeZvZO8C7TjO79m8eLZNV0SboDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709647758; c=relaxed/simple;
	bh=7BRjaivhGwnRdjugq6qn9vn/K/QQJts7eWC0wqd5alI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=SGL0OKv33ZsaxnIeztGAdaumaqqQMp01E+J3H7jhSXnzUQzotxU8hIFVAewkID6IMcgYrOYNq1oQC3o9pZaQvKgB9FlilQM2r6VzRi0u6QKQaiNmOSe7i5Iqw2OBrIKXvqkvRkESLURqan+MKlnubVXfipa7nMELI1efwalo0II=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LCiZ3BlG; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LCiZ3BlG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709647756;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=LltrrlR0KLUZKWUI8Smc+IrOPNRUEzptSFBfoLFQ5yg=;
	b=LCiZ3BlGc40IhNVZVDmkjaqM+0nAsDWqYHmSdzgYiIX+/4cmdsRjOoAlxtoPl14/7+xNl/
	8ISPcryOnfYSIWHMs/4C9POlBCphed8fbRVhrjuE1unCGUxdLVKD2Mvrr/MpWoKc6lBu6G
	3ruHcY5OcxuOwJnp000G0uqeAxpvnzY=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-657-RFErOhbqO7aB_3dY7CrXjA-1; Tue,
 05 Mar 2024 09:09:12 -0500
X-MC-Unique: RFErOhbqO7aB_3dY7CrXjA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 9B2863800089;
	Tue,  5 Mar 2024 14:09:12 +0000 (UTC)
Received: from dcaratti.users.ipa.redhat.com (unknown [10.32.181.200])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 1A8BD36FF;
	Tue,  5 Mar 2024 14:09:11 +0000 (UTC)
From: Davide Caratti <dcaratti@redhat.com>
To: Matthieu Baerts <matttbe@kernel.org>,
	Mat Martineau <martineau@kernel.org>
Cc: mptcp@lists.linux.dev
Subject: [PATCH mptcp-next] mptcp: don't account accept() of non-MPC client as fallback to TCP
Date: Tue,  5 Mar 2024 15:07:25 +0100
Message-ID: <cf0fb6eb68466bef37d685cc8a52cad3b69c4e7a.1709647631.git.dcaratti@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"; x-default=true

currently, inbound TCP connections increment MPTcpExtMPCapableFallbackACK
when the server accepts them. As reported by Cristoph, this is inaccurate
because the counter becomes greater than MPTcpExtMPCapableSYNRX when many
non-MPC TCP connections are accepted.
Change the semantic of MPTcpExtMPCapableFallbackACK to increment when the
subflow context of a inbound MPC connection attempt is dropped.

Reported-by: Cristoph Paasch <cpaasch@apple.com>
Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/449
Signed-off-by: Davide Caratti <dcaratti@redhat.com>
---
 net/mptcp/protocol.c | 2 --
 net/mptcp/subflow.c  | 2 ++
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index cdf9ec67795e..556b3b95c537 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -3937,8 +3937,6 @@ static int mptcp_stream_accept(struct socket *sock, struct socket *newsock,
 				mptcp_set_state(newsk, TCP_CLOSE);
 		}
 	} else {
-		MPTCP_INC_STATS(sock_net(ssk),
-				MPTCP_MIB_MPCAPABLEPASSIVEFALLBACK);
 tcpfallback:
 		newsk->sk_kern_sock = kern;
 		lock_sock(newsk);
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index 1626dd20c68f..6e3fe38f057d 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -905,6 +905,8 @@ static struct sock *subflow_syn_recv_sock(const struct sock *sk,
 	return child;
 
 fallback:
+	if (child)
+		SUBFLOW_REQ_INC_STATS(req, MPTCP_MIB_MPCAPABLEPASSIVEFALLBACK);
 	mptcp_subflow_drop_ctx(child);
 	return child;
 }
-- 
2.43.0

