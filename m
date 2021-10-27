Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [216.205.24.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 108CC2C9F
	for <mptcp@lists.linux.dev>; Wed, 27 Oct 2021 21:06:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1635368761;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:content-type:content-type;
	bh=dZAPRjm+xH40C/GEiKNlsNj07h5gKFc+ooxkA28Hz/8=;
	b=gv5y9I5iGS14Kyuv2wzPO9WaJc7sWsu+rVzuN3aKnP71XHIZQ2rmB/3niOPLMo9c+UvTFp
	ewJmbO5GXoPdJdgoUx6rr85mmEerH4Fz31B4rRcaPtleBRSCJgS0Psv7pi1Qvf9mo9Fsdd
	xpruUpmJdknjXT3KA+LYWTpsv2MFoYQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-471-jS1Au4aQMK-khPNgitWHYw-1; Wed, 27 Oct 2021 17:05:27 -0400
X-MC-Unique: jS1Au4aQMK-khPNgitWHYw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 70F3810055A7;
	Wed, 27 Oct 2021 21:05:26 +0000 (UTC)
Received: from nst.lab.eng.brq.redhat.com (nst.lab.eng.brq.redhat.com [10.37.153.171])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 771CA7945B;
	Wed, 27 Oct 2021 21:05:25 +0000 (UTC)
From: Poorva Sonparote <psonparo@redhat.com>
To: mptcp@lists.linux.dev
Cc: mathew.j.martineau@linux.intel.com,
	matthieu.baerts@tessares.net
Subject: [PATCH mptcp-next v4 0/2] Splitting commits for IP_TOS support in setsockopt()
Date: Wed, 27 Oct 2021 21:05:04 +0000
Message-Id: <cover.1635367735.git.psonparo@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
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
 net/mptcp/sockopt.c    | 40 ++++++++++++++++++++++++++++++++++++++++
 3 files changed, 42 insertions(+), 1 deletion(-)

-- 
2.18.2

