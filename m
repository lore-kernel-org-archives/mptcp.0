Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0C107A
	for <mptcp@lists.linux.dev>; Wed, 15 Jun 2022 20:28:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1655324902;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Jj4+w6Vh8DC3BavlBmYscqWFnebssZZainDMqkrkKTg=;
	b=THyGfDauUEGFcxHAkIgtYQatWUmjgK+AgBs9Kyy5nvpcQXn/br8mlEuCIqUasVkzFbz6TE
	VCqRW5zkSRVgxS3gEP3bnwSYNaH56E9M1MileqBLYhA9JLLlgDV/YynD9m5P68wyrhM7Ry
	dprzRoNoPMEKKOes/xIIkPOFyOYHU6U=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-632-trEd2vNcNA--LqNtzLf6rw-1; Wed, 15 Jun 2022 16:28:21 -0400
X-MC-Unique: trEd2vNcNA--LqNtzLf6rw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4D09685A586
	for <mptcp@lists.linux.dev>; Wed, 15 Jun 2022 20:28:21 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.39.193.220])
	by smtp.corp.redhat.com (Postfix) with ESMTP id D1BED40C1288
	for <mptcp@lists.linux.dev>; Wed, 15 Jun 2022 20:28:20 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Subject: [PATCH mptcp-net v2 0/6] mptcp: mp_fail related fixes
Date: Wed, 15 Jun 2022 22:28:07 +0200
Message-Id: <cover.1655324843.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.11.54.2
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
 net/mptcp/protocol.c |  61 +++++++++++++++++++----
 net/mptcp/protocol.h |  25 ++++++++--
 net/mptcp/subflow.c  | 113 ++++++++++++++++++++++++++++++++++---------
 5 files changed, 168 insertions(+), 44 deletions(-)

-- 
2.35.3

