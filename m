Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59B666D24
	for <mptcp@lists.linux.dev>; Thu, 19 Aug 2021 15:16:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1629386193;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=5d6Kpq0bKpSIObdHA3NfrVheFjSH9QxLKFkd1saHND8=;
	b=gVbqsnuGVNfm+fl3jRvHtDbV/0ESwENnZsZUej15OqlCmOg7OL6NUn5sd9M+J1ZhJHnScW
	j12r73IYiqXHmOjNcDidKlyLF5SwsbyF4QAXqgS+rWzk7oKinHEsB0dyag0W9IfYyx6Ph/
	kdNX47UjPPc9TzXv46kndcPpuT0QDs4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-602-niMzDbXzMVGetGAxhMau1w-1; Thu, 19 Aug 2021 11:16:30 -0400
X-MC-Unique: niMzDbXzMVGetGAxhMau1w-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 93E96801A92
	for <mptcp@lists.linux.dev>; Thu, 19 Aug 2021 15:16:29 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.39.194.179])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 0DE9E6F97F
	for <mptcp@lists.linux.dev>; Thu, 19 Aug 2021 15:16:28 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Subject: [PATCH v2 mptcp-next 0/4] mptcp: minor receive path optimization
Date: Thu, 19 Aug 2021 17:16:13 +0200
Message-Id: <cover.1629386016.git.pabeni@redhat.com>
Precedence: bulk
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

This series aims at closing:

https://github.com/multipath-tcp/mptcp_net-next/issues/42

The relevant code is introduced by patch 4/4.

Do do the above in hopefully clean way, the series needs some
changes to the input options struct. That means a lot of
noise in the option-related code in the previous patches,
anyhow no functional change is intended here.

v1 -> v2:
 - fixed = -> |= (Mat)
 - fixed bug in ADD_ADDR processing (still in 3/4)

Paolo Abeni (4):
  mptcp: do not set unconditionally csum_reqd on incoming opt
  mptcp: better binary layout for mptcp_options_received
  mptcp: consolidate in_opt sub-options fields in a bitmask
  mptcp: optimize the input options processing.

 net/mptcp/options.c  | 140 +++++++++++++++++++------------------------
 net/mptcp/protocol.c |   4 +-
 net/mptcp/protocol.h |  36 ++++++-----
 net/mptcp/subflow.c  |  40 +++++++------
 4 files changed, 104 insertions(+), 116 deletions(-)

-- 
2.26.3

