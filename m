Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 070448BF6
	for <mptcp@lists.linux.dev>; Wed, 23 Aug 2023 08:18:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1692778733;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=PcpVutAG+BCAVnZj4NuMp+ByKy/CRpb9b0Alsz38WAM=;
	b=V/2suGPFVuKyGHoFtzZ+PCSTzVgkFEv/geZgeCoQp6bMf0/DgkdqAqg/vCfavr/Q3yzUBI
	k+m9H/bBXA/8vyfGeyuvpjjLtcS6N8qUkAE3mykh04W3BH/6EcjaFBgvDqrBDeqRdH4BTu
	fJ+yCWmCaMLr/z78uFSbvabZfeqtYtg=
Received: from mimecast-mx02.redhat.com (66.187.233.73 [66.187.233.73]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-193-K1pkZclBPLuE72ykaLT__A-1; Wed, 23 Aug 2023 04:18:50 -0400
X-MC-Unique: K1pkZclBPLuE72ykaLT__A-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8037829AA2C4
	for <mptcp@lists.linux.dev>; Wed, 23 Aug 2023 08:18:50 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.45.224.138])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 0E7C9140E950
	for <mptcp@lists.linux.dev>; Wed, 23 Aug 2023 08:18:49 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Subject: [PATCH mptcp-net] mptcp: fix bogus receive window shrinkage with multiple subflows
Date: Wed, 23 Aug 2023 10:18:45 +0200
Message-ID: <0c7094b27ef199973d1fb3a8c5b29ebe0b48a659.1692778671.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"; x-default=true

In case multiple subflows race to update the mptcp-level receive
window, the subflow losing the race should use the window value
provided by the "winning" subflow to update it's own tcp-level
rcv_wnd.

To such goal, the current code bogusly uses the mptcp-level rcv_wnd
value as observed before the update attempt. On unluckly circumstances
that may lead to TCP-level window shrinkage, and stall the other end.

Address the issue feeding to the rcv wnd update the correct value.

Fixes: f3589be0c420 ("mptcp: never shrink offered window")
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
 net/mptcp/options.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index c254accb14de..cd15ec73073e 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -1269,12 +1269,13 @@ static void mptcp_set_rwin(struct tcp_sock *tp, struct tcphdr *th)
 
 			if (rcv_wnd == rcv_wnd_old)
 				break;
-			if (before64(rcv_wnd_new, rcv_wnd)) {
+
+			rcv_wnd_old = rcv_wnd;
+			if (before64(rcv_wnd_new, rcv_wnd_old)) {
 				MPTCP_INC_STATS(sock_net(ssk), MPTCP_MIB_RCVWNDCONFLICTUPDATE);
 				goto raise_win;
 			}
 			MPTCP_INC_STATS(sock_net(ssk), MPTCP_MIB_RCVWNDCONFLICT);
-			rcv_wnd_old = rcv_wnd;
 		}
 		return;
 	}
-- 
2.41.0

