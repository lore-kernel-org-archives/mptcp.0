Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A95E4538D
	for <mptcp@lists.linux.dev>; Thu, 26 Jan 2023 21:05:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1674767141;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=0bDNNpZDGFK1PJ4vFf3r8tcE2rUFlRCn3vBPQrZtKqA=;
	b=ikZWd6zX1hLszSqHCU6sbFHC3NWmP9SmvRfoFrW6qvpGr4d+UgBOepEGPxt5HuZ6bCWTXb
	KzIKzh9mieyEwjsRL8em/3vBZHnVx3t0QvQVzjjeImUFitvYYjk+sbA8E2Xxv0EEgFAUDN
	CdBQrJs6MxL3sn31NRuOE9XXEl2Z0mc=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-595-LJqvRnwuPrixBwHMytHAJg-1; Thu, 26 Jan 2023 16:05:39 -0500
X-MC-Unique: LJqvRnwuPrixBwHMytHAJg-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 90AC31C05ACD
	for <mptcp@lists.linux.dev>; Thu, 26 Jan 2023 21:05:39 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.39.192.60])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 261DE492C14
	for <mptcp@lists.linux.dev>; Thu, 26 Jan 2023 21:05:39 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Subject: [PATCH v3 mptcp-next 00/15] mptcp: refactor first subflow init
Date: Thu, 26 Jan 2023 22:05:05 +0100
Message-Id: <cover.1674767058.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"; x-default=true

This is the needed refactor for the selinux fixes, as discussed on
the ML.

Compared to v2 this revision introduces 2 additional patches:
1/15, just another cleanup found while addressing the recent bugs
12/15 factoring out a __inet_listener() helper, as suggested by Mat.

The only other patches with some change is 9/15, adding more
comments and consistently reporting the newly introduced error code
(a bit different from what discussed on the ML, for consistency's sake).

Paolo Abeni (15):
  mptcp: use mptcp_schedule_work() instead of open-codying it
  mptcp: fix locking for setsockopt corner-case
  mptcp: fix locking for in-kernel listener creation.
  mptcp: refactor passive socket initialization.
  mptcp: drop unneeded argument
  mptcp: drop legacy code.
  mptcp: avoid unneeded __mptcp_nmpc_socket() usage
  mptcp: move fastopen subflow check inside mptcp_sendmsg_fastopen()
  mptcp: move first subflow allocation at mpc access time
  mptcp: do not keep around the first subflow after disconnect.
  mptcp: fastclose msk when cleaning unaccepted sockets
  inet: factor out locked section of inet_accept() in a new helper
  mptcp: refactor mptcp_stream_accept()
  security, lsm: Introduce security_mptcp_add_subflow()
  selinux: Implement mptcp_add_subflow hook

 include/linux/lsm_hook_defs.h |   1 +
 include/linux/lsm_hooks.h     |   9 ++
 include/linux/security.h      |   6 ++
 include/net/inet_common.h     |   2 +
 net/ipv4/af_inet.c            |  32 +++----
 net/mptcp/options.c           |   9 +-
 net/mptcp/pm.c                |   4 +-
 net/mptcp/pm_netlink.c        |  14 +--
 net/mptcp/protocol.c          | 158 +++++++++++++++++-----------------
 net/mptcp/protocol.h          |   4 +-
 net/mptcp/sockopt.c           |  31 ++++---
 net/mptcp/subflow.c           |  57 +++++++-----
 security/security.c           |   5 ++
 security/selinux/hooks.c      |  16 ++++
 security/selinux/netlabel.c   |   8 +-
 15 files changed, 215 insertions(+), 141 deletions(-)

-- 
2.39.1

