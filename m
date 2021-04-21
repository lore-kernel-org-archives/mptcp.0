Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBEFE2F83
	for <mptcp@lists.linux.dev>; Wed, 21 Apr 2021 20:20:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1619036430;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=/NEl27SnEOQ/tg04M9mUWgMnKGnlYbXQ11HUCxxEZgo=;
	b=EwqLDeBXURTCzPYHaYBmfFzT/dRAyaG49Q0QZuYrzbYCoNAy1B7zWsJ8x89VCXsPPVUaal
	fwUmELd+7jT+ovp+medbQq/RYz0saXZD1bW51vbGGdXzQ+QDACgN7S9K5/9asXLRlsOgFW
	i9TJMO30bCnY0x5xg5TjzUkJXM70nqY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-102-ADo59QoqNU6r91Pv5QiqCA-1; Wed, 21 Apr 2021 16:20:27 -0400
X-MC-Unique: ADo59QoqNU6r91Pv5QiqCA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C2490107ACCA;
	Wed, 21 Apr 2021 20:20:26 +0000 (UTC)
Received: from gerbillo.redhat.com (ovpn-112-15.ams2.redhat.com [10.36.112.15])
	by smtp.corp.redhat.com (Postfix) with ESMTP id E3D436085A;
	Wed, 21 Apr 2021 20:20:24 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliangtang@gmail.com>
Subject: [PATCH v3 mptcp-next 00/21] mptcp: data checksum support
Date: Wed, 21 Apr 2021 22:17:49 +0200
Message-Id: <cover.1619035356.git.pabeni@redhat.com>
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

Changes from v2:
 - implement RFC behavior WRT csum failure and csum mismatch
 - cope with zero win probe and re-injection
 - fix csum computation for DSS with data_fin flag set

I kept the changes from the previous iteration in squash-to
patches to hopefully simplfy the review process.

There are at still least a couple of rough edges:
- csum computation in the rx path for DSS with data fin set
  is likely uncorrect
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

Paolo Abeni (7):
  Squash-to: "mptcp: generate the data checksum"
  Squash-to: "mptcp: send out checksum for MP_CAPABLE with data"
  Squash-to "mptcp: send out checksum for DSS"
  Squash-to: "mptcp: receive checksum for MP_CAPABLE with data"
  Squash-to: "mptcp: receive checksum for DSS"
  Squash-to: mptcp: validate the data checksum
  mptcp: tune re-injections for csum enabled mode.

 Documentation/networking/mptcp-sysctl.rst     |   8 +
 include/net/mptcp.h                           |   7 +-
 include/uapi/linux/mptcp.h                    |   1 +
 net/mptcp/ctrl.c                              |  14 ++
 net/mptcp/mib.c                               |   1 +
 net/mptcp/mib.h                               |   1 +
 net/mptcp/mptcp_diag.c                        |   1 +
 net/mptcp/options.c                           | 147 +++++++++++++-----
 net/mptcp/protocol.c                          |  39 ++++-
 net/mptcp/protocol.h                          |  22 ++-
 net/mptcp/subflow.c                           | 136 +++++++++++++---
 .../selftests/net/mptcp/mptcp_connect.sh      |  13 +-
 .../testing/selftests/net/mptcp/mptcp_join.sh | 107 ++++++++++++-
 13 files changed, 420 insertions(+), 77 deletions(-)

-- 
2.26.2

