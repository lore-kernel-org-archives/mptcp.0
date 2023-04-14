Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A618120F6
	for <mptcp@lists.linux.dev>; Fri, 14 Apr 2023 14:19:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1681481984;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=t4/Y6TJOlwRsbVn3uxgmUzjQqHhBaElK0c56DGheTLQ=;
	b=AxC54HLUulm42z8guPiqyLW0vwpXlzD7Bp8bextZxY2NTdul0wB5mTw4i/VNZnXEAlszxc
	ehIi6+yB++N4eNv+fYMb6pNYsE9A02aqlEnEFsTre1GuZpzekr5mA8RhlpyiI3h1SclRux
	h5nk/W2f8jbBt15BuCkzSAvsJ+HTgZ8=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-354-CShG_fzkMhOczxThWbL6aQ-1; Fri, 14 Apr 2023 10:19:43 -0400
X-MC-Unique: CShG_fzkMhOczxThWbL6aQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 96905280D59F
	for <mptcp@lists.linux.dev>; Fri, 14 Apr 2023 14:19:38 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.39.194.98])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 029D22166B2C
	for <mptcp@lists.linux.dev>; Fri, 14 Apr 2023 14:19:37 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Subject: [PATCH v2 mptcp-next 0/3] mptcp: add more mibs
Date: Fri, 14 Apr 2023 16:19:31 +0200
Message-Id: <cover.1681481877.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"; x-default=true

dumb cover letter for CI's sake.

Slould be applied only after the current tree has been crunched
by syzkaller for a little bit, as this will likely change quite
a bit the timings of some critical path, possibly hiding old races
and make more easy to reach other ones

Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/378

v1 -> v2:
 - fix mpj self-tests failures

Paolo Abeni (3):
  mptcp: introduces more address related mibs
  selftests: mptcp: add explicit check for new mibs
  selftests: mptcp: centralize stats dumping

 net/mptcp/mib.c                               |   6 +
 net/mptcp/mib.h                               |  18 +++
 net/mptcp/options.c                           |   5 +-
 net/mptcp/pm.c                                |   6 +-
 .../testing/selftests/net/mptcp/mptcp_join.sh | 112 +++++++++---------
 5 files changed, 91 insertions(+), 56 deletions(-)

-- 
2.39.2

