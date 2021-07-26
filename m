Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [216.205.24.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6872177
	for <mptcp@lists.linux.dev>; Mon, 26 Jul 2021 10:55:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1627296944;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=SOQ4XHxdY6lAWbiB2viVS4aJ0ft/Onpghx93ZjhpePA=;
	b=N5ylS0KzHSJYOuc+LfaAXgqywk4z3GhCxLGtflr5erNBgbyhoDniQwIVg320FsoagwbOfM
	AB9Okaex9Ylr4l9psTMxdm+fIwONPWhG5IMYguLg2ss9MGFGXTY3uxhJ/bgtpLXUwlsFz7
	o/QP6X5dznNdjECV1/osEs7pqG9UOdo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-485-KBZwBvtsPL-wqgM_Fk38Zg-1; Mon, 26 Jul 2021 06:55:41 -0400
X-MC-Unique: KBZwBvtsPL-wqgM_Fk38Zg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 864F893920;
	Mon, 26 Jul 2021 10:55:40 +0000 (UTC)
Received: from gerbillo.redhat.com (ovpn-113-71.ams2.redhat.com [10.36.113.71])
	by smtp.corp.redhat.com (Postfix) with ESMTP id C516419D9F;
	Mon, 26 Jul 2021 10:55:39 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliangtang@gmail.com>
Subject: [PATCH v3 mptcp-next 0/3] mptcp: minor out optimization
Date: Mon, 26 Jul 2021 12:55:26 +0200
Message-Id: <cover.1627296764.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
	auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pabeni@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"

This series implements a few ideas discussed in the past mtg,
specifcally:

https://github.com/multipath-tcp/mptcp_net-next/issues/15
https://github.com/multipath-tcp/mptcp_net-next/issues/42

The final goal is shrink the mptcp_out_options struct, which is
always zeroed by the plain TCP protocol in the output path.

This iteration covers the feedback provided by Geliang (many thanks!)
on v1:
 - some code moved to new squash-to patch 1/3
 - some cleanup in 2/3

please see the individual patch changelog for the details

Paolo Abeni (3):
  Squash-to: "mptcp: move drop_other_suboptions check under pm lock"
  mptcp: optimize out option generation
  mptcp: shrink mptcp_out_options struct

 include/net/mptcp.h  |  26 +++--
 net/mptcp/options.c  | 227 +++++++++++++++++++++++--------------------
 net/mptcp/pm.c       |   9 +-
 net/mptcp/protocol.h |   1 +
 4 files changed, 142 insertions(+), 121 deletions(-)

-- 
2.26.3

