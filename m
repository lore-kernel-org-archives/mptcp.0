Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 176E67A
	for <mptcp@lists.linux.dev>; Mon, 14 Feb 2022 15:39:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1644853165;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=p3+YES67ERC0f0GEmr3fVwp4N85SAGZ2m/6uixOJ9hA=;
	b=XzCzwn7xnSICOqD7eDpVPa/qp3MShMPgZg9EqkATGlGrRZyLXteoMRNcaePK/2egeUVbs7
	1gFUoubuRbo/lnwK+RGp6dBMlc0zs7AT1GPS0s+JPt88StDLbSf0GQwOFxVTtOG0H0ujL3
	THv1xCSp58XodZJpC47EOin5iIzC9tE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-249-woaxMu3WNCqHSpAxvNz1Cw-1; Mon, 14 Feb 2022 10:39:23 -0500
X-MC-Unique: woaxMu3WNCqHSpAxvNz1Cw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D3B0A100C611
	for <mptcp@lists.linux.dev>; Mon, 14 Feb 2022 15:39:22 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.39.194.152])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 45ED52B598
	for <mptcp@lists.linux.dev>; Mon, 14 Feb 2022 15:39:22 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Subject: [PATCH v4 mptcp-next 0/3] mptcp: more self-tests improvements
Date: Mon, 14 Feb 2022 16:38:54 +0100
Message-Id: <cover.1644852970.git.pabeni@redhat.com>
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

This iteration tries to address the feedback from Mat on v3.

patch 1/3 is a somewhat related cleanup (to be squashed into existing
patch)
patch 2/3 should address the self-test failure
patch 3/3 avoids RFC breakage reported into the previous iteration,
leveraging the previois one

Patch 2/3 would probably deserve some additional self-tests. My plan is
to add them after that the existing ones are stable enough.

Paolo Abeni (3):
  Squash-to: "mptcp: constify a bunch of helpers"
  mptcp: more careful RM_ADDR generation
  mptcp: strict local address ID selection.

 include/uapi/linux/mptcp.h |  1 +
 net/mptcp/pm_netlink.c     | 59 ++++++++++++++++++---------------
 net/mptcp/protocol.c       |  3 ++
 net/mptcp/protocol.h       |  3 +-
 net/mptcp/subflow.c        | 67 +++++++++++++++++++++++++++++++++-----
 5 files changed, 97 insertions(+), 36 deletions(-)

-- 
2.34.1

