Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [216.205.24.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC5335F
	for <mptcp@lists.linux.dev>; Fri, 26 Mar 2021 12:28:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1616761720;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=4Jm+WXE61EdoNT0a3bX3vkePKrVwvAeN2uUkFBDv7uE=;
	b=Bjsi4rD/OnVJrGHQvOn7DlhecNQrPGUZoSRGAQw5LTFf9hKHH4P3O1MuzKvDcR1mrmpGt7
	hj0Ogo1Xjuofay7R6ZdaYrZcvLUvVHRDNZKwRoqndR4+r42YU/8Zict7zIl7zN1BHOwFn/
	jtOTlCe6FITgbzj07CpG6VMqLIX24uY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-517-sOHSbSZdPuaK7Pnq_GFaFA-1; Fri, 26 Mar 2021 08:28:38 -0400
X-MC-Unique: sOHSbSZdPuaK7Pnq_GFaFA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B936387A826;
	Fri, 26 Mar 2021 12:28:37 +0000 (UTC)
Received: from computer-6.station (unknown [10.40.194.217])
	by smtp.corp.redhat.com (Postfix) with ESMTP id C42385C737;
	Fri, 26 Mar 2021 12:28:36 +0000 (UTC)
From: Davide Caratti <dcaratti@redhat.com>
To: mptcp@lists.linux.dev
Cc: Matthieu Baerts <matthieu.baerts@tessares.net>
Subject: [PATCH net-next] mptcp: drop all sub-options except ADD_ADDR when the echo bit is set
Date: Fri, 26 Mar 2021 13:28:19 +0100
Message-Id: <aeb4b7f3044e2f869ae026f950eb70c4398dad63.1616761454.git.dcaratti@redhat.com>
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
	auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=dcaratti@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"

Current Linux carries echo-ed ADD_ADDR over pure TCP ACKs, so there is no
need to add a DSS element that would fit only ADD_ADDR with IPv4 address.
Drop the DSS from echo-ed ADD_ADDR, regardless of the IP version.

Signed-off-by: Davide Caratti <dcaratti@redhat.com>
---
 net/mptcp/options.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index c7eb61d0564c..d51c3ad54d9a 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -624,7 +624,8 @@ static bool mptcp_established_options_add_addr(struct sock *sk, struct sk_buff *
 	int len;
 
 	if ((mptcp_pm_should_add_signal_ipv6(msk) ||
-	     mptcp_pm_should_add_signal_port(msk)) &&
+	     mptcp_pm_should_add_signal_port(msk) ||
+	     mptcp_pm_should_add_signal_echo(msk)) &&
 	    skb && skb_is_tcp_pure_ack(skb)) {
 		pr_debug("drop other suboptions");
 		opts->suboptions = 0;
-- 
2.30.2

