Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [216.205.24.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6631F2C81
	for <mptcp@lists.linux.dev>; Wed, 27 Oct 2021 02:42:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1635302521;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:content-type:content-type;
	bh=asDqxeOXX/BF889Q5dTSL86nCSVYy+ce4EqO0O5xPhI=;
	b=RX2sk8dYtUbJ9MzbczSGNcr/9yyQKisJ9cLUyBqLGvv3e9kKg2Aw3L4ui+QZVrwKh0RAwW
	08f0IWJ/nwNb2sQA9Dn4d30CBfhsDotiy2xEL9ajWfYa47XIJFCYL/GEzK58VKUYhOGwr6
	UDp0JAevDBIF7g4zqiSIQRE+a4VjeVo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-259-x5sLghsoMI-MtnvTqBVBCA-1; Tue, 26 Oct 2021 22:42:00 -0400
X-MC-Unique: x5sLghsoMI-MtnvTqBVBCA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E13A31808302;
	Wed, 27 Oct 2021 02:41:58 +0000 (UTC)
Received: from nst.lab.eng.brq.redhat.com (nst.lab.eng.brq.redhat.com [10.37.153.171])
	by smtp.corp.redhat.com (Postfix) with ESMTP id E1D511AC18;
	Wed, 27 Oct 2021 02:41:57 +0000 (UTC)
From: Poorva Sonparote <psonparo@redhat.com>
To: mptcp@lists.linux.dev
Cc: mathew.j.martineau@linux.intel.com,
	matthieu.baerts@tessares.net
Subject: [PATCH mptcp-next v3 0/2] Splitting commits for IP_TOS support in setsockopt()
Date: Wed, 27 Oct 2021 02:41:45 +0000
Message-Id: <cover.1635300034.git.psonparo@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
	auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=psonparo@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="US-ASCII"
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>

- patch 1/2 Add Support for IP_TOS for MPTCP setsockopt()
- patch 2/2 Exposing  __ip_sock_set_tos() in ip.h


Poorva Sonparote (2):
  Exposing __ip_sock_set_tos() in ip.h
  Support for IP_TOS for MPTCP setsockopt()

 include/net/ip.h       |  1 +
 net/ipv4/ip_sockglue.c |  2 +-
 net/mptcp/sockopt.c    | 41 +++++++++++++++++++++++++++++++++++++++++
 3 files changed, 43 insertions(+), 1 deletion(-)

-- 
2.18.2

