Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3D624625
	for <mptcp@lists.linux.dev>; Thu, 17 Feb 2022 21:44:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1645134293;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=TkSQjPLht5TZUpodYbOSEi/wzTirLeqKQOHNtT7PI0M=;
	b=N9BdcbEY3J9kOP4iLzRjm2Cdxkc6KkfJ7YBO7yN/aN12x20v+RapZNFwKpN/oP8d8zCD4n
	EtP8w9v6NRiyvCbeMg6EBexr+SWNgaKTfAZja0JavTBWBDBSuJoSlnjJ1bSRZatKPzlwdK
	tfTSNJhaal/W6UWkO61IXoEzsCA67G0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-39-a1VUPJGmP2S87r9n0d-a8Q-1; Thu, 17 Feb 2022 16:44:52 -0500
X-MC-Unique: a1VUPJGmP2S87r9n0d-a8Q-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B68B21091DA0
	for <mptcp@lists.linux.dev>; Thu, 17 Feb 2022 21:44:51 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.39.194.122])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 2776A5E26B
	for <mptcp@lists.linux.dev>; Thu, 17 Feb 2022 21:44:50 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Subject: [PATCH v5 mptcp-next 0/4] mptcp: more self-tests improvements
Date: Thu, 17 Feb 2022 22:44:10 +0100
Message-Id: <cover.1645134065.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
	auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pabeni@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"

This iteration tries to address the feedback from Mat on v4.

patch 1/4 is new and tries to address the problem behind issues/225 with
stricted RFC compliance
patch 2 and 3 clean-up endpoint management as per past discussion
patch 4 introduce new self-tests, as deserved the previous patch

Paolo Abeni (4):
  mptcp: more careful RM_ADDR generation
  mptcp: introduce implicit endpoints
  mptcp: strict local address ID selection.
  selftests: mptcp: add implicit endpoint test case

 include/uapi/linux/mptcp.h                    |   1 +
 net/mptcp/pm_netlink.c                        |  84 ++++++------
 net/mptcp/protocol.c                          |   3 +
 net/mptcp/protocol.h                          |   3 +-
 net/mptcp/subflow.c                           |  67 ++++++++--
 .../testing/selftests/net/mptcp/mptcp_join.sh | 121 +++++++++++++++++-
 tools/testing/selftests/net/mptcp/pm_nl_ctl.c |   7 +
 7 files changed, 234 insertions(+), 52 deletions(-)

-- 
2.34.1

