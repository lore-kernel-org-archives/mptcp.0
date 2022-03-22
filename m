Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B48DEC98
	for <mptcp@lists.linux.dev>; Tue, 22 Mar 2022 15:46:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1647963964;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dhNM+qyMKv2TxcXMrHqo1XuHwwou9oiV4B3W5y7QTEs=;
	b=Ov5ucP4PFBPpsG/+XSudNdWL9vQpMO6+I1J1UTNebJfjFyHdnhuFiM6KIlohS1L4MZHvlN
	9k96Rt8dtjINDiwII1CwzyPdsOzRGMYt61xWMk3IpwRCB/TM9dmuMzH+l55EIizcEZEpMN
	8jY59Vu2mUdbCQZsvfaXwShhcfGtIzI=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-550-3mwcUCdlPuO_sksz_kWk6Q-1; Tue, 22 Mar 2022 11:46:02 -0400
X-MC-Unique: 3mwcUCdlPuO_sksz_kWk6Q-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C32F8811E80
	for <mptcp@lists.linux.dev>; Tue, 22 Mar 2022 15:46:01 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.39.194.63])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 53CAC56F7F9
	for <mptcp@lists.linux.dev>; Tue, 22 Mar 2022 15:46:01 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Subject: [PATCH v2 mptcp-next 3/3] mptcp:  reset the packet scheduler on PRIO change
Date: Tue, 22 Mar 2022 16:45:51 +0100
Message-Id: <0c46e0f4c83e2f7075b5e43cc82cf126762546ac.1647960598.git.pabeni@redhat.com>
In-Reply-To: <53b59c780c15855fb57ec41e187a19272747c9d8.1647960598.git.pabeni@redhat.com>
References: <53b59c780c15855fb57ec41e187a19272747c9d8.1647960598.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.9
Authentication-Results: relay.mimecast.com;
	auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pabeni@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"

Similar to the previous patch, for priority changes
requested by the local PM.

Reported-and-suggested-by: Davide Caratti <dcaratti@redhat.com>
Fixes: 067065422fcd ("mptcp: add the outgoing MP_PRIO support")
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Reviewed-by: Mat Martineau <mathew.j.martineau@linux.intel.com>
---
 net/mptcp/pm_netlink.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index c1f4befb1e45..10a73898c8db 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -727,6 +727,8 @@ static int mptcp_pm_nl_mp_prio_send_ack(struct mptcp_sock *msk,
 		if (!addresses_equal(&local, addr, addr->port))
 			continue;
 
+		if (subflow->backup != bkup)
+			msk->last_snd = NULL;
 		subflow->backup = bkup;
 		subflow->send_mp_prio = 1;
 		subflow->request_bkup = bkup;
-- 
2.35.1

