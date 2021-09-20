Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [216.205.24.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ADF33FC0
	for <mptcp@lists.linux.dev>; Mon, 20 Sep 2021 17:24:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1632158683;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=1gt1sThQpZWdDplh+33EJcLQE1R69AEBdu+daZ3trKo=;
	b=gdJlQvxmbPZPbcahNgsKOe90J6WufH9OYPRmXnOyMST6iANC040Dv85X5KOZt/paa2Ucea
	X4CvaOcA7Jh9Ri16ivHk4Sp1r6aZtc9Qu01VDiXaf5UNVNbGBgaqZVxdwU74RkpRvhRFhJ
	b4HESk1IW5aJtchrIiMrKDcke6fIFOI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-371-oJXBuBbcMwCA22KLDCxtEA-1; Mon, 20 Sep 2021 13:24:41 -0400
X-MC-Unique: oJXBuBbcMwCA22KLDCxtEA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2E5351923767
	for <mptcp@lists.linux.dev>; Mon, 20 Sep 2021 17:24:40 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.39.193.11])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 9AEC66060F
	for <mptcp@lists.linux.dev>; Mon, 20 Sep 2021 17:24:39 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Subject: [PATCH mptcp-next 0/3] mptcp: tx refactor update
Date: Mon, 20 Sep 2021 19:24:26 +0200
Message-Id: <cover.1632158356.git.pabeni@redhat.com>
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

This are updates to the tx refactor patches as asked by Eric.
Note that patch 3/3 should replace completely the existing
'Partially revert "tcp: factor out tcp_build_frag()"'
patch. I opted for this solution as the git repo mangling looked
easier this way; @matttbe: please tell me if other options are
preferred instead.

Additionally patch "chtls: rename skb_entail() to chtls_skb_entail()"
should be dropped.


 include/net/tcp.h | 2 +-
 net/ipv4/tcp.c    | 6 +++---
 2 files changed, 4 insertions(+), 4 deletions(-)

-- 
2.26.3

