Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3578F84A48
	for <mptcp@lists.linux.dev>; Tue,  5 Mar 2024 15:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709652037; cv=none; b=BwLgSgQ+fbIaxoIgfQUvhwF3qttTMFj5fZ0vIRf8KaqLK3/nCwyYTGnzvdH9tC9/2/SCHXXMqoJFbzKr3v+Wwehr3nSSmdrpOBvp8wgDqt9Vexh0L5LbH6gkrLMxToP8vua2VGITB/kDqw1RicSs6NIht/zhbgTAnGR28A1d6XA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709652037; c=relaxed/simple;
	bh=SdnfepDwQdpnVF5ARXNjVZV2T3QdKf6A11Pc207J5iY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=gE2PqVdiTLCFSa4YcBPDSkLOVuiuyy5qv73QUZhDjzoYH/VhHQFHkPgVjFNoYvjb9MCLszDOec90PdzXEkiHCgdpQkMh6+Yx9sTkK6Nls+BrDuyvpieBUDWnGZIYtibaF3HeQCffzTHiTphq0KPBvnBbItIE7g41YCnccU+44kM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=E334+1dC; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="E334+1dC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709652035;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=zWj0jP67SZZx9Y2ZYQaP9LVB3RuOjFRgRLM4EzhCY0Q=;
	b=E334+1dCS7HzJlwMoUBBLcc9HSmhdWKIKFbJnp0lt0wL/f1hF1FZI67QCCCXyeAOUeyrTf
	5BHEYwl2sjKPx8ibm3NxLz43FmUMUysTs/oYfuAKbRu9n17zWaeCUEQOHIj11cfaEh52xy
	QjON5zEB87ZHcAxtgqrZMYsDtJ3P/1c=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-267-HoNwUw5YPuygAMLBVrRy2A-1; Tue, 05 Mar 2024 10:20:33 -0500
X-MC-Unique: HoNwUw5YPuygAMLBVrRy2A-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 309B980026C;
	Tue,  5 Mar 2024 15:20:33 +0000 (UTC)
Received: from dcaratti.users.ipa.redhat.com (unknown [10.32.181.200])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 87C93492BCD;
	Tue,  5 Mar 2024 15:20:32 +0000 (UTC)
From: Davide Caratti <dcaratti@redhat.com>
To: Matthieu Baerts <matttbe@kernel.org>,
	Mat Martineau <martineau@kernel.org>
Cc: Christoph Paasch <cpaasch@apple.com>,
	mptcp@lists.linux.dev
Subject: [PATCH mptcp-net v2] mptcp: don't account accept() of non-MPC client as fallback to TCP
Date: Tue,  5 Mar 2024 16:19:56 +0100
Message-ID: <be9176dac04b292242d6afc2eefc0c931d21b0cd.1709651670.git.dcaratti@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"; x-default=true

currently, inbound TCP connections increment MPTcpExtMPCapableFallbackACK
when the server accepts them. As Christoph reported, this is "surprising"
because the counter becomes greater than MPTcpExtMPCapableSYNRX when many
non-MPC TCP connections are accepted.
Change the semantic of MPTcpExtMPCapableFallbackACK to increment when the
subflow context of an inbound MPC connection attempt is dropped.

v2: fix reporter name

Reported-by: Christoph Paasch <cpaasch@apple.com>
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

