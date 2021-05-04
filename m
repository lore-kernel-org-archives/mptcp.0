Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4C7770
	for <mptcp@lists.linux.dev>; Tue,  4 May 2021 21:42:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1620164549;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=vXkc8RlYBZUY1HuJDFsQZ1eCwrMPaZKmXN8+cf1dejc=;
	b=SDNymJZTW93TUnHUzAXmHR6hPKNywwOjPbkuMXv8v2SFXktqQo551ZPBCrR1APB1MzUOJ4
	LIck2aOn71bPDj+H68suGwp2fLk4sKdVn+OAmfp9Lr4N1r0+N2+bgNuGcLwP9oW20/p/3N
	rHBsrOyuKXW0vQD3KVFIrB1H7dN8lcw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-146-ZH91DAGNN6WlvNJdJBm_PA-1; Tue, 04 May 2021 17:42:28 -0400
X-MC-Unique: ZH91DAGNN6WlvNJdJBm_PA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 94654801817
	for <mptcp@lists.linux.dev>; Tue,  4 May 2021 21:42:27 +0000 (UTC)
Received: from gerbillo.redhat.com (ovpn-114-126.ams2.redhat.com [10.36.114.126])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 0CD725C3E0
	for <mptcp@lists.linux.dev>; Tue,  4 May 2021 21:42:26 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Subject: [PATCH v6 mptcp-next 00/22] mptcp: data checksum support
Date: Tue,  4 May 2021 23:41:48 +0200
Message-Id: <cover.1620163861.git.pabeni@redhat.com>
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
	auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pabeni@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"

Changes from v5:
 - none really, added patch lost in previous iteration due to PEBKAC

Changes from v4:
 - cope with odd-aligned csum blocks
 - avoid re-adding multiple times the same skb bits on tx
 - fix pseudo header generation (must be in NBO)

Changes from v3:
 - included Geliang's feedback
 - hopefully fixed wrong csum computation in the rx path
   for DSS+data_fin 

Changes from v2:
 - implement RFC behavior WRT csum failure and csum mismatch
 - cope with zero win probe and re-injection
 - fix csum computation for DSS with data_fin flag set

Only some Squash-to patches has been changes WRT the previous
iteration.

There is still at least a ough edge:
- the csum computation in the tx path is very suboptimal.

Anyhow, I propose to address the above with additional squash-to patches
to avoid complex/extra long review cycles.

Geliang Tang (14):
  mptcp: add csum_enabled in mptcp_sock
  mptcp: generate the data checksum
  mptcp: add csum_reqd in mptcp_out_options
  mptcp: send out checksum for MP_CAPABLE with data
  mptcp: send out checksum for DSS
  mptcp: add sk parameter for mptcp_parse_option
  mptcp: add csum_reqd in mptcp_options_received
  mptcp: receive checksum for MP_CAPABLE with data
  mptcp: receive checksum for DSS
  mptcp: validate the data checksum
  mptcp: add the mib for data checksum
  mptcp: add a new sysctl checksum_enabled
  selftests: mptcp: enable checksum in mptcp_connect.sh
  selftests: mptcp: enable checksum in mptcp_join.sh

Paolo Abeni (8):
  Squash-to: "mptcp: generate the data checksum"
  Squash-to: "mptcp: send out checksum for MP_CAPABLE with data"
  Squash-to "mptcp: send out checksum for DSS"
  Squash-to: "mptcp: receive checksum for MP_CAPABLE with data"
  Squash-to: "mptcp: receive checksum for DSS"
  Squash-to: mptcp: validate the data checksum
  mptcp: cleanup error path in subflow_check_data_avail()
  mptcp: tune re-injections for csum enabled mode.

 Documentation/networking/mptcp-sysctl.rst     |   8 +
 include/net/mptcp.h                           |   7 +-
 include/uapi/linux/mptcp.h                    |   1 +
 net/mptcp/ctrl.c                              |  14 ++
 net/mptcp/mib.c                               |   1 +
 net/mptcp/mib.h                               |   1 +
 net/mptcp/mptcp_diag.c                        |   1 +
 net/mptcp/options.c                           | 165 +++++++++++++-----
 net/mptcp/protocol.c                          |  29 ++-
 net/mptcp/protocol.h                          |  23 ++-
 net/mptcp/subflow.c                           | 146 +++++++++++++---
 .../selftests/net/mptcp/mptcp_connect.sh      |  13 +-
 .../testing/selftests/net/mptcp/mptcp_join.sh | 107 +++++++++++-
 13 files changed, 440 insertions(+), 76 deletions(-)

-- 
2.26.2

