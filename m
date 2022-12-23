Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 807E633CE
	for <mptcp@lists.linux.dev>; Fri, 23 Dec 2022 19:00:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1671822024;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=uCKDzIZ3OpW96WTogc6cqzZ7ZoouyZXmrT1BkSaxGOk=;
	b=HA64lfeLQN6v+FPxtg//rsN3MyYWiQnkCqAFzaYgNIv3bAhl2cCnaRDpeiKVoqn4kiShqN
	jwOTsBhiaGg70z61tUPQiHBFdtxopP28rWZB4Le7DMUHGQlbF7HJHmlO8J3yW8dtrIy6f4
	CYZTvxOhCKimha6b5GnO8BaOqRIR4OE=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-278-FAE05ldrMCShl_qkmcTflw-1; Fri, 23 Dec 2022 14:00:22 -0500
X-MC-Unique: FAE05ldrMCShl_qkmcTflw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 6E6593C0DDB1
	for <mptcp@lists.linux.dev>; Fri, 23 Dec 2022 19:00:22 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.39.192.156])
	by smtp.corp.redhat.com (Postfix) with ESMTP id F3FAF40C1073
	for <mptcp@lists.linux.dev>; Fri, 23 Dec 2022 19:00:21 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Subject: [PATCH v2 mptcp-next 0/3] mptcp: add support for mixed v4/v6
Date: Fri, 23 Dec 2022 20:00:11 +0100
Message-Id: <cover.1671821017.git.pabeni@redhat.com>
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

The core MPTCP implementation is just a few bits of to support such
feature, we just need to allow specifying the subflow family explicitly
(patch 1/3) and remove the artificial constraint currently enforcing
no mixed subflow in place (patch 2/3)

Some self-tests added on patch 3/3

Merry Xmas ;)

v1 -> v2:
 - only allow mixing family for ipv6 mptcp socket with no IPV6_ONLY
   option (all the functional changes in 2/3 plus self-tests adaptation)

Paolo Abeni (3):
  mptcp: explicitly specify sock family at subflow creation time
  mptcp: let the in kernel PM use mixed ipv4 and ipv6 addresses
  selftests: mptcp: add test-cases for mixed v4/v6 subflows

 net/mptcp/pm_netlink.c                        | 68 ++++++++++++-------
 net/mptcp/protocol.c                          |  2 +-
 net/mptcp/protocol.h                          |  3 +-
 net/mptcp/subflow.c                           |  9 +--
 .../testing/selftests/net/mptcp/mptcp_join.sh | 53 ++++++++++++---
 5 files changed, 94 insertions(+), 41 deletions(-)

-- 
2.38.1

