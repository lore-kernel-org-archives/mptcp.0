Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BADA6F
	for <mptcp@lists.linux.dev>; Wed, 24 Mar 2021 21:12:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1616620356;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=yHaug5LbQxFPqTsQaNQZzim3zar+xmNtHkAI1VcREDA=;
	b=aT6erWPe22K+4PPLYSgGz+rgpzuTdKs9wFwbaUKXX2LYnGvSBi82e5Hn4NkL7bF3gdxpVH
	7Zcn79nWpf4d5PeJ9TMEWY4UCVg+ezXQ/RPu4+HbSCUpBF4mUn6R/q045xwOHw6bwYLgvT
	Sv2Ba6K+kYEDFo+otuZIr50MFZseQvo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-134-LiRvFmgjOAW03QqkYPWRbw-1; Wed, 24 Mar 2021 17:12:32 -0400
X-MC-Unique: LiRvFmgjOAW03QqkYPWRbw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx01.redhat.com (Postfix) with ESMTPS id F3FEC1007476;
	Wed, 24 Mar 2021 21:12:30 +0000 (UTC)
Received: from computer-6.redhat.com (unknown [10.40.193.247])
	by smtp.corp.redhat.com (Postfix) with ESMTP id C9CE75D9D0;
	Wed, 24 Mar 2021 21:12:29 +0000 (UTC)
From: Davide Caratti <dcaratti@redhat.com>
To: mptcp@lists.linux.dev,
	mptcp@lists.01.org
Cc: Matthieu Baerts <matthieu.baerts@tessares.net>
Subject: [RFC PATCH net-next] mptcp: drop all sub-options except ADD_ADDR when the echo bit is set
Date: Wed, 24 Mar 2021 22:12:18 +0100
Message-Id: <aeb4b7f3044e2f869ae026f950eb70c4398dad63.1616620119.git.dcaratti@redhat.com>
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
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

Notes:
    hello,
    
    maybe this is a known issue, maybe not. In case it is, TLDR:
    
    while working on packetdrill with REMOVE_ADDR, I noticed that the following
    inbound packet:
    
     +0.0      <   .  1:1(0)  ack 101  win 256  <nop, nop, TS val 705 ecr 305, add_address addr[saddr] hmac=auto>
    
    had wrong length TCPOLEN_ADD_ADDR_V4_HMAC (18 Byte) in the IPv6 case, so the
    address carried in the option was something that probably can't be used by the
    client, because it doesn't belong to the same address family of the source
    address used by the (client) kernel socket.
    
    So, I wrote a fix for packetdrill and now it selects the correct ADD_ADDR length
    both for IPv4 and IPv6 inbound packets.
    
    However, matching the subsequent outbound echo-ed ADD_ADDR became problematic:
    the IPv4 echoed ADD_ADDR has a trailing DSS option that's not existent in the
    IPv6 equivalent of the test (because it does not fit the max TCP option space).
    Is there a reason for not saving the DSS option space in the IPv4 case? If not,
    can we harmonize at least echo-ed IPv4 and IPv6 ADD_ADDRs?
    
    any feedback appreciated, thank you in advance!
    
    davide

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

