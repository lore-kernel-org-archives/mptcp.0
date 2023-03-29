Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E1E35382
	for <mptcp@lists.linux.dev>; Wed, 29 Mar 2023 17:33:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1680111181;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=dXmKyIJL2HDLUcC0xAq8C8U26UPEL1hkVXQKP3C8Uvc=;
	b=Nds5lAbntukocpPCWlpEckYjwONH9ssjPSnvb8kKGO+62tYSIKSyjk5svddNN8F20XGLP0
	cr2wukpgQlfx/ktH/q55zrDhPEyk1BI3g0ma+xKmuKqlQYwuktb+PomtNJd2RgfWBNYirS
	t4yni7/EwdKUdZBCkxVC7vFOFQMCqvY=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-226-zJDPVlTTPFKvmC1FdEmBeg-1; Wed, 29 Mar 2023 13:32:59 -0400
X-MC-Unique: zJDPVlTTPFKvmC1FdEmBeg-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 25188100DEBB;
	Wed, 29 Mar 2023 17:32:59 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.39.194.225])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 94263492C3E;
	Wed, 29 Mar 2023 17:32:58 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Cc: Christoph Paasch <cpaasch@apple.com>
Subject: [PATCH mptcp-net v2 0/2] mptcp: a couple of fixes
Date: Wed, 29 Mar 2023 19:32:49 +0200
Message-Id: <cover.1680110912.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"; x-default=true

dump cover letter to trigger the CI, see the individual
changelog for the details.

Note that patch  2/2 introduces a behavioral change that hits
the packetdrill test close_before_accept.pkt. The msk socket
will be CLOSED after accept if the first subflow is closed
before accept.

Paolo Abeni (2):
  mptcp: stops worker on unaccepted sockets at listener close
  mptcp: fix accept vs worker race

 net/mptcp/protocol.c | 54 ++++++++++++++++++-----------
 net/mptcp/protocol.h |  2 ++
 net/mptcp/subflow.c  | 82 ++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 118 insertions(+), 20 deletions(-)

-- 
2.39.2

