Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A836C2C82
	for <mptcp@lists.linux.dev>; Tue, 23 Nov 2021 16:37:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1637685455;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=7UqYbY0sugTamfHJPVEdwLZ0Zb52IEDyLo87DaliwU4=;
	b=N+dKMM2fQdkJ9K6I2Ft18fyux4yJYt+dNDkvMJPZGU0ybp8aTxCYsrzBRa96mWRw1w0Hxv
	JX3Em4MU23PsgU5fq/zCPJjUAqPP2li7LLMTJ/hRtYSxE3V5yLyXPeGmyLc1zOclj6KK/k
	9Ht4ROrv5HUZtC0i6xcr7i0PkCuVRBU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-564-KsQaMdisN_2rbv_vRAkH-w-1; Tue, 23 Nov 2021 11:37:32 -0500
X-MC-Unique: KsQaMdisN_2rbv_vRAkH-w-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 04F8087D541;
	Tue, 23 Nov 2021 16:37:31 +0000 (UTC)
Received: from gerbillo.fritz.box (unknown [10.39.194.149])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 29B1D1981F;
	Tue, 23 Nov 2021 16:37:29 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Cc: Phil Greenland <phil@quantulum.co.uk>
Subject: [PATCH mptcp-next 0/3] mptcp: improve subflow creation on errors
Date: Tue, 23 Nov 2021 17:37:09 +0100
Message-Id: <cover.1637684792.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Authentication-Results: relay.mimecast.com;
	auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pabeni@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"

Currently when a subflow connection fails - either the TCP
connection is reset by the peer, or the MPJ handshake never
completes - the in kernel PM don't perform any further action.
Notably no additional subflow creation is attempted.

This series is aimed at improving the in-kernel path manager
behavior in the above scenario: on failure we try to move
to the next subflow, if any.

The first patch is minor cleanup, the feature is implemented
by patch 2/3. The last patch adds a specific self-tests.

This should possibly address/close:
https://github.com/multipath-tcp/mptcp_net-next/issues/235
https://github.com/multipath-tcp/mptcp_net-next/issues/242

@Phil: could you please have a spin in your testbed and
see if this is enough to fit you?

Paolo Abeni (3):
  mptcp: clean-up MPJ option writing.
  mptcp: do not block subflows creation on errors
  selftests: mptcp: add tests for subflow creation failure

 net/mptcp/options.c                           | 63 ++++++++++++-------
 net/mptcp/protocol.h                          |  1 +
 net/mptcp/subflow.c                           | 12 +++-
 .../testing/selftests/net/mptcp/mptcp_join.sh | 10 +++
 4 files changed, 61 insertions(+), 25 deletions(-)

-- 
2.33.1

