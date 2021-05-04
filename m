Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [216.205.24.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 595DC2F80
	for <mptcp@lists.linux.dev>; Tue,  4 May 2021 21:29:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1620163788;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=k95rf9e+/75iwOY6EuVakFjHOfUJUQdIyZHJfcUf6P4=;
	b=eJU2dNJaSd3yVuofCO5pgQcYQt2Zt2ivWwRHaCUFVpRvmXVtVrzqNalXIibEVkh/J5Sxan
	JHDoVNTUaez/g13zmygC4KWXuyFanKqbeiH2nhthguarNroNmAjiQMW76dh+7bYbYln2Iu
	LKWLaGdqFQB67oSva1Wuaoa+H9TPFGc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-491-jP3OmR_1PyCFZ1FMu5ktAQ-1; Tue, 04 May 2021 17:29:44 -0400
X-MC-Unique: jP3OmR_1PyCFZ1FMu5ktAQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A10A518B9ECA;
	Tue,  4 May 2021 21:29:43 +0000 (UTC)
Received: from gerbillo.redhat.com (ovpn-114-126.ams2.redhat.com [10.36.114.126])
	by smtp.corp.redhat.com (Postfix) with ESMTP id B06836090F;
	Tue,  4 May 2021 21:29:42 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliangtang@gmail.com>
Subject: [PATCH v5 mptcp-next 00/21] mptcp: data checksum support
Date: Tue,  4 May 2021 23:29:10 +0200
Message-Id: <cover.1620162984.git.pabeni@redhat.com>
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
	auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pabeni@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"

Changed from v4:
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

Geliang Tang (13):
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
 net/mptcp/ctrl.c                              |  14 ++
 net/mptcp/mib.c                               |   1 +
 net/mptcp/mib.h                               |   1 +
 net/mptcp/options.c                           | 165 +++++++++++++-----
 net/mptcp/protocol.c                          |  28 ++-
 net/mptcp/protocol.h                          |  23 ++-
 net/mptcp/subflow.c                           | 146 +++++++++++++---
 .../selftests/net/mptcp/mptcp_connect.sh      |  13 +-
 .../testing/selftests/net/mptcp/mptcp_join.sh | 107 +++++++++++-
 11 files changed, 436 insertions(+), 77 deletions(-)

-- 
2.26.2

