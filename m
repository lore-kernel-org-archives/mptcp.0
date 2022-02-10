Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B0C62C9C
	for <mptcp@lists.linux.dev>; Thu, 10 Feb 2022 18:49:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1644518969;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=9j6k3Lbik3hF8cFADqtdI01SS9fyB6GxqOtZs1yuY38=;
	b=TGow4FKbOftg2pRjonlQmYiXEXCRDwqg/j7nX2BT+OzSOFeGHsf5X4vC8vPzeqqSFUh1Lu
	9VSyZ524iPXjz7IIMD13/dU9N14e8dDBz1IaEGfmjg8zdTA9Cc4tLGb2x/FVbgJB3vrGBZ
	hHWNUlXAeOvFPy1/OH4mW/OJwYe5KRY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-332-W7kjFCk3PUKurukH6QEMig-1; Thu, 10 Feb 2022 13:49:28 -0500
X-MC-Unique: W7kjFCk3PUKurukH6QEMig-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4B2BA51086
	for <mptcp@lists.linux.dev>; Thu, 10 Feb 2022 18:49:27 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.39.194.220])
	by smtp.corp.redhat.com (Postfix) with ESMTP id A442A106C0D2
	for <mptcp@lists.linux.dev>; Thu, 10 Feb 2022 18:49:26 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Subject: [PATCH v3 mptcp-next 0/3] mptcp: more self-tests improvements
Date: Thu, 10 Feb 2022 19:49:14 +0100
Message-Id: <cover.1644518737.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
	auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pabeni@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"

This is the new iteration of "mptcp: strict local address ID selection."
should hopefully fix the last self-test failure.

patch 1/3 is a somewhat related cleanup (to be squashed into existing
patch)
patch 2/3 should address the self-test failure
patch 3/3 avoids RFC breakage reported into the previous iteration,
leveraging the previois one

Paolo Abeni (3):
  Squash-to: "mptcp: constify a bunch of of helpers"
  mptcp: more careful RM_ADDR generation
  mptcp: strict local address ID selection.

 include/uapi/linux/mptcp.h |  1 +
 net/mptcp/pm_netlink.c     | 44 ++++++++++++-------------
 net/mptcp/protocol.c       |  3 ++
 net/mptcp/protocol.h       |  3 +-
 net/mptcp/subflow.c        | 67 +++++++++++++++++++++++++++++++++-----
 5 files changed, 84 insertions(+), 34 deletions(-)

-- 
2.34.1

