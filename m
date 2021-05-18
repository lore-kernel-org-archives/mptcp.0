Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4CB671
	for <mptcp@lists.linux.dev>; Tue, 18 May 2021 17:16:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1621358200;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=xS9d9H1L8u7gi7Bwp1Pgmquu/wSWtKh2FQfFKA82qi0=;
	b=G50OVwl4lsunZyMu4pELizNRPSFisj6j482KAh1QuBjrFiobWCisnxh4n+IJhpIgqjG83F
	ARi4raJQaPyy4t6DPYD1RmPYa8FX57VNB8/DetTJzO5Zft+VLqecJ8jWHjT4gQW7LL0c1g
	VPlZmAnB2boWCZam4dW0dtA8SccirxI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-532-QnPOSUHXPI-MzvEPnFHXgw-1; Tue, 18 May 2021 13:16:26 -0400
X-MC-Unique: QnPOSUHXPI-MzvEPnFHXgw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 570D3802B78
	for <mptcp@lists.linux.dev>; Tue, 18 May 2021 17:16:25 +0000 (UTC)
Received: from gerbillo.redhat.com (ovpn-112-188.ams2.redhat.com [10.36.112.188])
	by smtp.corp.redhat.com (Postfix) with ESMTP id C4A70138E8
	for <mptcp@lists.linux.dev>; Tue, 18 May 2021 17:16:24 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Subject: [PATCH mptcp-net] mptcp: avoid error message on infinite mapping
Date: Tue, 18 May 2021 19:16:15 +0200
Message-Id: <3254d58a6dabd03533816388bd6dcb04f8078e6a.1621358167.git.pabeni@redhat.com>
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
	auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pabeni@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"

Another left-over. Avoid flooding dmesg with useless text,
we already have a MIB for that event.

Fixes: 648ef4b88673 ("mptcp: Implement MPTCP receive path")
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
 net/mptcp/subflow.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index 9befe9fe7bca..02b1ff06c741 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -951,7 +951,6 @@ static enum mapping_status get_mapping_status(struct sock *ssk,
 
 	data_len = mpext->data_len;
 	if (data_len == 0) {
-		pr_err("Infinite mapping not handled");
 		MPTCP_INC_STATS(sock_net(ssk), MPTCP_MIB_INFINITEMAPRX);
 		return MAPPING_INVALID;
 	}
-- 
2.26.3

