Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3383AD4A
	for <mptcp@lists.linux.dev>; Fri, 13 Jan 2023 18:21:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1673634067;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=wDBXvsnX4wJAb8WokouxoMSFEa/A/HlAR+ilXCTrOMk=;
	b=I0GtL5ydrb4q9601xodPHsrrxvcUVegLjxlebCeO+lEqpP/blCGlN2jFoAbHUBSjr2z0yl
	CRfZsDuEazHn6bQlNvKSUB4VYJaYpjL5n2jTwm8hmpgpKyZ+npo+S8VwucgRSjBuUHeTXa
	e0HhfiXaBLDdj7lOSZGmjJNsYTzEi1M=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-611-mtbtVpZANv-0y0VF3CRYjw-1; Fri, 13 Jan 2023 13:21:06 -0500
X-MC-Unique: mtbtVpZANv-0y0VF3CRYjw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D3385101B44F
	for <mptcp@lists.linux.dev>; Fri, 13 Jan 2023 18:21:05 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.39.194.89])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 61B474078903
	for <mptcp@lists.linux.dev>; Fri, 13 Jan 2023 18:21:05 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Subject: [PATCH mptcp-next 0/9] mptcp: refactor first subflow init
Date: Fri, 13 Jan 2023 19:20:47 +0100
Message-Id: <cover.1673629755.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"; x-default=true

This is the needed refactor for the selinux fixes, as discussed on
the ML.

The main change, introduced by patch 6/9 consist in moving the first
subflow initialization from the msk init callback into the mptcp
syscall needing such data (namely: bind, listen, connect). 

Patch 4 and 5 allow making such change smaller.

Patches 7, 8, 9 are not strictly needed, but are some nice to have
follow-up, cleaning-up the related code.

Specifically patch 8 closes issues/290, but requires some additional
pre-req (patches 1-3), which in turn are also nice to have IMHO.

Sharing after little testing to get feedback and let the bot massage
the new code: patch 1 and 7 can have subtle effect, I would like to
have syzkaller digest them for a while.

I'll rebase the selinux patches on top and share them soon.

Paolo Abeni (9):
  mptcp: refactor passive socket initialization.
  mptcp: drop unneeded argument
  mptcp: drop legacy code.
  mptcp: avoid unneeded __mptcp_nmpc_socket() usage
  mptcp: move fastopen subflow check inside mptcp_sendmsg_fastopen()
  mptcp: move first subflow allocation at mpc access time
  mptcp: do not keep around the first subflow after disconnect.
  mptcp: fastclose msk when cleaning unaccepted sockets
  mptcp: refactor mptcp_stream_accept()

 net/mptcp/options.c    |   9 +--
 net/mptcp/pm.c         |   4 +-
 net/mptcp/pm_netlink.c |   4 +-
 net/mptcp/protocol.c   | 159 ++++++++++++++++++++++-------------------
 net/mptcp/protocol.h   |   4 +-
 net/mptcp/sockopt.c    |  18 ++---
 net/mptcp/subflow.c    |  40 +++++++----
 7 files changed, 132 insertions(+), 106 deletions(-)

-- 
2.38.1

