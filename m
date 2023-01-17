Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 996961FA7
	for <mptcp@lists.linux.dev>; Tue, 17 Jan 2023 07:37:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1673941034;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=SUM+1svv3Ce0SOUUq4yadPPrxUMh9x1YyscDu2hAXHw=;
	b=LANE/kecyW4tRco4L3xmKwk8G2h59d5lK40u+lEkIaHBZV+xagfPFLhXD1/VG8I3LYfOxq
	JYY+JtTf/k/PjyHYMLNu3tZUiMh8fc3j6Jn3J59PM4x6K0vCddoVtrygSRzH0T8rqHHhaj
	yHQW9Jz6oOC8Q9DFx4SfqGxut+MsHy8=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-624-z-swclqVOFWuCzD6s_sluA-1; Tue, 17 Jan 2023 02:37:12 -0500
X-MC-Unique: z-swclqVOFWuCzD6s_sluA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 7C1841C04336
	for <mptcp@lists.linux.dev>; Tue, 17 Jan 2023 07:37:12 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.39.192.87])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 0B66140C2004
	for <mptcp@lists.linux.dev>; Tue, 17 Jan 2023 07:37:11 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Subject: [PATCH mptcp-next v2 00/13] mptcp: refactor first subflow init
Date: Tue, 17 Jan 2023 08:36:20 +0100
Message-Id: <cover.1673940640.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"; x-default=true

This is the needed refactor for the selinux fixes, as discussed on
the ML.

Patch the first 2 patches address old, currently not so relevant bugs
which will become more serious once the refactor is applied.

Patches 3-7 are pre-reqs for the bulk changes, but also IMHO nice to
have even stand-alone.

The main change, introduced by patch 8, consists in moving the first
subflow initialization from the msk init callback into the mptcp
syscall needing such data (namely: bind, listen, connect). 

Patches 9, 10, 11 are not strictly needed, but are some nice to have
follow-up, cleaning-up the related code.

Specifically patch 10 closes issues/290

Finally patches 12 && 13 address the LSM issue. They really target the
LSM subtree, and are added here just to allow verify the fix in our
tree before the LSM submission.

Sharing after little testing to get feedback and let the bot massage
the new code: a couple of patches can have subtle effect, I would like to
have syzkaller digest them for a while.

Paolo Abeni (13):
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
  mptcp: refactor mptcp_stream_accept()
  security, lsm: Introduce security_mptcp_add_subflow()
  selinux: Implement mptcp_add_subflow hook

 include/linux/lsm_hook_defs.h |   1 +
 include/linux/lsm_hooks.h     |   9 ++
 include/linux/security.h      |   6 ++
 net/mptcp/options.c           |   9 +-
 net/mptcp/pm.c                |   4 +-
 net/mptcp/pm_netlink.c        |  14 +--
 net/mptcp/protocol.c          | 163 ++++++++++++++++++----------------
 net/mptcp/protocol.h          |   4 +-
 net/mptcp/sockopt.c           |  29 +++---
 net/mptcp/subflow.c           |  48 +++++++---
 security/security.c           |   5 ++
 security/selinux/hooks.c      |  16 ++++
 security/selinux/netlabel.c   |   8 +-
 13 files changed, 198 insertions(+), 118 deletions(-)

-- 
2.39.0

