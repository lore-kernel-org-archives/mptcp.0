Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [216.205.24.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 270332FB9
	for <mptcp@lists.linux.dev>; Wed, 11 Aug 2021 09:26:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1628673966;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=c556LoEdODSWyQkeYVApkSVQaaJHaBhiGlYU44TsWa0=;
	b=iWzHLJ0lJEcPyhIve+8PKLjBeMqmYxRzFrG0NDFFGog1/5eLIT1MZbtTKQgmjbNcchozpb
	fcKNXw7scD1NRzN5JEGxeuyfC70vSSK+v27Lc35LGShEm1eD8m63rBbiPP+2et4+uRaw+Z
	d9BmdUgb4/koyaTxbL542VkcqUBUZcM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-441-z5oLkqPrNrOJu8pFnIUjxg-1; Wed, 11 Aug 2021 05:26:05 -0400
X-MC-Unique: z5oLkqPrNrOJu8pFnIUjxg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 11CF987D541
	for <mptcp@lists.linux.dev>; Wed, 11 Aug 2021 09:26:04 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.39.194.5])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 7A44A5C1B4
	for <mptcp@lists.linux.dev>; Wed, 11 Aug 2021 09:26:03 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Subject: [PATCH mptcp-next 2/2] Squash-to: "mptcp: move drop_other_suboptions check under pm lock"
Date: Wed, 11 Aug 2021 11:25:52 +0200
Message-Id: <eb682dddcd1d3d1e486cbdab8e1e72b67d17d715.1628673891.git.pabeni@redhat.com>
In-Reply-To: <cover.1628673891.git.pabeni@redhat.com>
References: <cover.1628673891.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
	auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pabeni@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"

MPJ ACK is a pure TCP ack on an established TCP connection, so is
eligble to carry MPTCP ADD_ADDR option. If that happens, the MPJ
subopt will be stripped and the MPJ handshake will be broken.

Avoid adding ADD_ADDR subopt if the current packet is MPJ ACK (or
MPC ACK, just to be safe: the added check it's cheap).

This fixes issues/221

Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
 net/mptcp/options.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index b2af81515f20..b3d5547fdb61 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -678,7 +678,11 @@ static bool mptcp_established_options_add_addr(struct sock *sk, struct sk_buff *
 	bool port;
 	int len;
 
+	/* add addr will strip the existing options, be sure to avoid breaking
+	 * MPC/MPJ handshakes
+	 */
 	if (!mptcp_pm_should_add_signal(msk) ||
+	    (opts->suboptions & (OPTION_MPTCP_MPJ_ACK | OPTION_MPTCP_MPC_ACK)) ||
 	    !mptcp_pm_add_addr_signal(msk, skb, opt_size, remaining, &opts->addr,
 		    &echo, &port, &drop_other_suboptions))
 		return false;
-- 
2.26.3

