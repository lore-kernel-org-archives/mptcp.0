Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4245C7C
	for <mptcp@lists.linux.dev>; Tue,  4 Apr 2023 11:41:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1680608481;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=boyI8rwW8KMSABpvx9coOiTtz3Jvug1owfU3VBALuu0=;
	b=hvc2JChePwgBfpLF6jQ9Czc50BgvqUVCnBWG/wO68W4eX0GWdaje3aKlMNZoyasTC/dE1h
	GeQ/yujzpqCWehEc7TH0y1ln+ThdbglMT2l4tVF0P9ZG9TmmKBdSXLjt42vrOgKXrYXa4s
	w7voNTpdRg0nNaCLFosXrFGAKGzxdJM=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-591-GyM1ANyAOdW1w-IpkxLLrQ-1; Tue, 04 Apr 2023 07:41:20 -0400
X-MC-Unique: GyM1ANyAOdW1w-IpkxLLrQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B6A2E811E7C
	for <mptcp@lists.linux.dev>; Tue,  4 Apr 2023 11:41:19 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.39.192.15])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 4F7DF440BC
	for <mptcp@lists.linux.dev>; Tue,  4 Apr 2023 11:41:19 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Subject: [PATCH mptcp-next 0/3] mptcp: add more mibs
Date: Tue,  4 Apr 2023 13:41:01 +0200
Message-Id: <cover.1680544063.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
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

Paolo Abeni (3):
  mptcp: introduces more address related mibs
  selftests: mptcp: add explicit check for new mibs
  selftests: mptcp: centralize stats dumping

 net/mptcp/mib.c                               |   6 +
 net/mptcp/mib.h                               |  14 +++
 net/mptcp/options.c                           |   5 +-
 net/mptcp/pm.c                                |   6 +-
 .../testing/selftests/net/mptcp/mptcp_join.sh | 112 +++++++++---------
 5 files changed, 87 insertions(+), 56 deletions(-)

-- 
2.39.2

