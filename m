Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D98D62F25
	for <mptcp@lists.linux.dev>; Fri, 17 Jun 2022 10:06:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1655460400;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=cEMe7wKQO1z3Y03BYprfXxtLlB8WU02lDgmUxhUEiu8=;
	b=flq4Neo4JyFhokZTsy7fOP6zsCUfbOR/js5S4eUfzl5/H7joESHh/lRxqsVXgt86xXNEN1
	awDOM0q0vOkT2ZtypgjTj+LVZc0geOA/D/b/QCLoAqB0snYZGbVx1b7AkoBSCh0WI9G4ik
	I+TlNWCXMjpyQF7jIO0TFXJaiYpGOA8=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-113-vYL7Iqg4OdGTPnlbe30bWQ-1; Fri, 17 Jun 2022 06:06:39 -0400
X-MC-Unique: vYL7Iqg4OdGTPnlbe30bWQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E887E3C0D866
	for <mptcp@lists.linux.dev>; Fri, 17 Jun 2022 10:06:38 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.39.194.194])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 784DC4010E4D
	for <mptcp@lists.linux.dev>; Fri, 17 Jun 2022 10:06:38 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Subject: [PATCH mptcp-net v3 0/6] mptcp: mp_fail related fixes
Date: Fri, 17 Jun 2022 12:05:14 +0200
Message-Id: <cover.1655460262.git.pabeni@redhat.com>
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

