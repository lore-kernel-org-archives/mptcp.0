Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [216.205.24.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A60C6D19
	for <mptcp@lists.linux.dev>; Wed, 18 Aug 2021 10:36:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1629282963;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=oD6KLi+8lTGkiQcXdxypZAvO8/0Rdh3O64xeuJHaGfs=;
	b=IFZN2YAInDxs2VXjH6xsHuPYLvYXZwJ7AnjZ2wwbt0mEkc1w7mTasonbYe1U1VniZcM19t
	QUWpuKP7hKbRf/GNI6+eW5M0vjomRnnFnb4h4b9azl9U7kFDBz73dMYBm3eQMdU6un9+jZ
	mCD+uMb+SYJ55nKBxY+EtFjNH9X+mBM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-245-4eWUqJh3MbK0YcoZ4Pildw-1; Wed, 18 Aug 2021 06:36:00 -0400
X-MC-Unique: 4eWUqJh3MbK0YcoZ4Pildw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D12F2801B3D
	for <mptcp@lists.linux.dev>; Wed, 18 Aug 2021 10:35:59 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.39.194.166])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 47155100EBAD
	for <mptcp@lists.linux.dev>; Wed, 18 Aug 2021 10:35:59 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Subject: [PATCH net-next 0/4] mptcp: minor receive path optimization
Date: Wed, 18 Aug 2021 12:35:45 +0200
Message-Id: <cover.1629282605.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
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

