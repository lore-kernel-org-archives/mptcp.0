Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A2B028E2
	for <mptcp@lists.linux.dev>; Fri, 18 Feb 2022 15:17:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1645197454;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=aCpK9pKKU/TSVm+7KGPAZKzrLPVATbu7aT2mbTOZbO8=;
	b=Yn3iSq/l79wC4aAkktC1qI0HE0FR7BC8WvPkSSR4P6hXjcjCRtO8p0CjTmG9PLsm4R/hs+
	TylGN0BvfeT9vndkngDCU8YLFk7lEXGqsFSWhkABSBLrx766Iz9lLBajstoIWOknmVFToY
	eEiFOqwiurfGY1/igJDE1PH5XoIFt5c=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-50-RmvuEb0nMYKcDG0rGmOQAA-1; Fri, 18 Feb 2022 10:17:31 -0500
X-MC-Unique: RmvuEb0nMYKcDG0rGmOQAA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B5CA9801AC5
	for <mptcp@lists.linux.dev>; Fri, 18 Feb 2022 15:17:30 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.39.192.232])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 2D6117CADB
	for <mptcp@lists.linux.dev>; Fri, 18 Feb 2022 15:17:29 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Subject: [PATCH mptcp-net 0/2] mptcp: fix ioctl on fallback
Date: Fri, 18 Feb 2022 16:17:19 +0100
Message-Id: <cover.1645196974.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
	auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pabeni@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"

The first patch fixes the issue, hopefully closing:

https://github.com/multipath-tcp/mptcp_net-next/issues/260

the 2nd patch is self-test cleanup

Paolo Abeni (2):
  mptcp: accurate SIOCOUTQ for fallback socket
  selftests: mptcp: do complete cleanup at exit

 net/mptcp/protocol.c                               | 11 +++++++++++
 tools/testing/selftests/net/mptcp/mptcp_connect.sh |  4 ++--
 2 files changed, 13 insertions(+), 2 deletions(-)

-- 
2.34.1

