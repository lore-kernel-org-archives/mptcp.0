Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FA2B7C
	for <mptcp@lists.linux.dev>; Fri, 24 Jun 2022 16:38:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1656088697;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=atSN2hIl0bUyQ1HuCimzZtiBGkyoPeBgko1bbeblR1Q=;
	b=KBCv7Y12F8+35z2GsweOq4fL/KgCRJXT7nMeBDU3gfh0rWPJs2MK4T0IkbkeQnwwItIWiF
	IGrLrJkA0c3b6CmRGL+V6udXLqrv9rMa6tBGrFkuzYZcTry7iBBYM6+hiQX8FeXI/m46SY
	2b/OnSW1BqBxU+UVaPlZKEp25tT5jmM=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-438-REJq7XGtPKWc84UPmWXSNg-1; Fri, 24 Jun 2022 12:38:16 -0400
X-MC-Unique: REJq7XGtPKWc84UPmWXSNg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id CC22A811E7A
	for <mptcp@lists.linux.dev>; Fri, 24 Jun 2022 16:38:15 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.39.192.243])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 5C4982026D64
	for <mptcp@lists.linux.dev>; Fri, 24 Jun 2022 16:38:15 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Subject: [PATCH RFC 0/4] mptcp: let the in kernel PM control the MPC
Date: Fri, 24 Jun 2022 18:38:06 +0200
Message-Id: <cover.1656088406.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.4
Authentication-Results: relay.mimecast.com;
	auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pabeni@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"; x-default=true

this is follow-up to the last public mtg and:

https://github.com/multipath-tcp/mptcp_net-next/issues/285

implementing the idea described in the last comment from the above isse
It's just a proof of concept, only compile tested, to better describe
the idea.

While implementing the above I found a fews bugs fixed in patch
1/4, 2/4 and 4/4.

If there is agreement on this kind of changes, next week I plan to cook
a formal submission, including a few additional self-tests.

Paolo Abeni (4):
  mptcp: fix local endpoint acconting.
  mptcp: introduce and use mptcp_pm_send_ack()
  mptcp: allow the in kernel PM to set MPC subflow priority
  mptcp: more accurate MPC endpoint tracking

 net/mptcp/pm_netlink.c | 103 ++++++++++++++++++++++-------------------
 net/mptcp/protocol.c   |  11 +++--
 net/mptcp/protocol.h   |   3 +-
 3 files changed, 65 insertions(+), 52 deletions(-)

-- 
2.35.3

