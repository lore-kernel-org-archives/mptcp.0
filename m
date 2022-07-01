Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54BCD1855
	for <mptcp@lists.linux.dev>; Fri,  1 Jul 2022 10:05:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1656669940;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=omJcDEkURcSK4UY9y/M1fWybvbWyeOf+wnsFav0uXLA=;
	b=i1c1zeVOUoNSQTR5PkWl0LLBhLBftxUkES/uNnZKDlY6bsktESI15cAuBSqvCaTFiDOGEP
	QF216B/9PaqEG5zYV+7bTIz+AptRV6N5tbdvefMqhX8q52vR85AivbYKlf6naZz1vKaFTy
	pYwa5ZLOYB7uH5Onjvn4Le41k5XcyO0=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-659-1-Xs3zE7PUyOcr_DCcLnMg-1; Fri, 01 Jul 2022 06:05:39 -0400
X-MC-Unique: 1-Xs3zE7PUyOcr_DCcLnMg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 107FD1C06EC5
	for <mptcp@lists.linux.dev>; Fri,  1 Jul 2022 10:05:39 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.39.193.185])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 94B42400DEFC
	for <mptcp@lists.linux.dev>; Fri,  1 Jul 2022 10:05:38 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Subject: [PATCH mptcp-next 0/6] mptcp: support for MPC prio exchange
Date: Fri,  1 Jul 2022 12:05:20 +0200
Message-Id: <cover.1656669391.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.11.54.1
Authentication-Results: relay.mimecast.com;
	auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pabeni@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"; x-default=true

This series introduces the ability to control the MPC subflow for
the in kernel PM.

Patch 1 and 5 are actually a related bugfixes.

patch 2 && 3 refactor a bit the endpoint lookup and MP_PRIO generation
code, to simplify the next patch.

patch 4 introduces the new feature quering the backup status of the
endpoint used by the MPC subflow and eventually generating the needed
MP_PRIO option.

changes vs RFC:
 - rebased on top of Mats' patches
 - added patch 3/6 clarifying the endpoint id lookup semanthic
 - added self-tests (patch 6/6)

Paolo Abeni (6):
  mptcp: fix local endpoint acconting.
  mptcp: introduce and use mptcp_pm_send_ack()
  mptcp: address lookup improvements
  mptcp: allow the in kernel PM to set MPC subflow priority
  mptcp: more accurate MPC endpoint tracking
  selftests: mptcp: add MPC backup tests

 net/mptcp/pm_netlink.c                        | 129 ++++++++++--------
 net/mptcp/protocol.c                          |   2 +-
 net/mptcp/protocol.h                          |   2 +-
 .../testing/selftests/net/mptcp/mptcp_join.sh |  30 ++++
 4 files changed, 105 insertions(+), 58 deletions(-)

-- 
2.35.3

