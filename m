Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96C417F6
	for <mptcp@lists.linux.dev>; Mon, 20 Jun 2022 11:26:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1655724405;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=OmRCIzbHOnPi2mAeYklZu3zjY01RiYj4J7HahhzCvHw=;
	b=aow85jKQjsEEBFsO/q51HZvF5PhCg/BoChHV3jiUBVsES6RfGofoyh/Qqjp/tp1fJEx0kj
	waAJB+E/kh7I7Jw9Io4anR2rRVUaV6uOQLG/3tv2F0+EVQ+DcBHnz+ipaXFZkL4/IaTiNf
	WzyYSoKI1nw79BUEkcVKWwgCt2VzwUA=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-352-WmonQLR2P-qbB2CW0U1aNQ-1; Mon, 20 Jun 2022 07:26:44 -0400
X-MC-Unique: WmonQLR2P-qbB2CW0U1aNQ-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id DB0EA8316FB
	for <mptcp@lists.linux.dev>; Mon, 20 Jun 2022 11:26:43 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.39.195.59])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 692B140314B
	for <mptcp@lists.linux.dev>; Mon, 20 Jun 2022 11:26:43 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Subject: [PATCH mptcp-net v4 0/6] mptcp: mp_fail related fixes
Date: Mon, 20 Jun 2022 13:26:30 +0200
Message-Id: <cover.1655723410.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.10
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
 net/mptcp/protocol.c |  57 +++++++++++++++++----
 net/mptcp/protocol.h |  25 +++++++--
 net/mptcp/subflow.c  | 119 ++++++++++++++++++++++++++++++++++---------
 5 files changed, 170 insertions(+), 44 deletions(-)

-- 
2.35.3

