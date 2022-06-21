Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1B084C94
	for <mptcp@lists.linux.dev>; Tue, 21 Jun 2022 17:23:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1655832214;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=ap9Md5qsiG5LutVacWgtpVwd6X7LOxY8idmS/bsJTs0=;
	b=BSTLADKVifvPOy3VVgeohE1CSjgC4kak6e0NDlmcLoMlNRfgUgQ0Qpiw+sIi2SYhYUy8jD
	3he1+1Yolksryovj4AzRsvQaZeWylOf+t8xdtyt0q+ikFe4MTDv9mSWP6KHsStNhQJcmzz
	iTdf5rMGFkCmgDRPAmeULP0MOcjTOjM=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-468-pdvhQN8ONPSNRC1RRwGGBQ-1; Tue, 21 Jun 2022 13:23:33 -0400
X-MC-Unique: pdvhQN8ONPSNRC1RRwGGBQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2CE71811E76
	for <mptcp@lists.linux.dev>; Tue, 21 Jun 2022 17:23:33 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.39.193.164])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 6334C40CFD0A
	for <mptcp@lists.linux.dev>; Tue, 21 Jun 2022 17:23:32 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Subject: [PATCH v5 mptcp-net 0/6] mptcp: mp_fail related fixes
Date: Tue, 21 Jun 2022 19:23:11 +0200
Message-Id: <cover.1655829222.git.pabeni@redhat.com>
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

While cooking a follow-up for "mptcp: invoke MP_FAIL response when
needed" I stumbled upon a few other MP_FAIL related issues hit my
the self-tests while mangling the above.

All the patches for for the -net tree, and should be applied in-order
around to the squashed-to patch.

v4 -> v5:
 - hopefully fix for real lockdep annotaiton in patch 6/6 (still mat)

v3 -> v4:
 - fix a couple of typos in 3/6, fix lockdep annotation in 6/6 (mat)

v2 -> v3:
 - do not schedule mp_fail timeout on closed socket in patch 3/6 (mat) 

v1 -> v2:
 - take care of UaF in mptcp_worker with new patch 6/6

Paolo Abeni (6):
  mptcp: fix error mibs accounting
  mptcp: introduce MAPPING_BAD_CSUM
  Squash-to: "mptcp: invoke MP_FAIL response when needed"
  mptcp: fix shutdown vs fallback race
  mptcp: consistent map handling on failure
  mptcp: fix race on unaccepted mptcp sockets

 net/mptcp/options.c  |   8 +--
 net/mptcp/pm.c       |   5 +-
 net/mptcp/protocol.c |  57 ++++++++++++++++----
 net/mptcp/protocol.h |  25 +++++++--
 net/mptcp/subflow.c  | 121 +++++++++++++++++++++++++++++++++++--------
 5 files changed, 172 insertions(+), 44 deletions(-)

-- 
2.35.3

