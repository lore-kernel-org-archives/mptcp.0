Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBBC52F27
	for <mptcp@lists.linux.dev>; Tue,  8 Feb 2022 19:06:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1644347195;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=ZUY+ipCvSAca/F5daHeZ6D5lk8VC4Ze8lY2qJssYf70=;
	b=bsXzGt+mKyVemf862fjOwsg2/sxlKNCYQhOArn9Gv/Hx6I0q+MgJCDT/jVdcgzCDKYwz6y
	KnO8+gtdQqVLxtsSwvSd5JUTsHlVZ1+0AnIGKuDw8xyQITmGePmhVRti33xm4dhPNB/9Qt
	4l8sXGKSwpGfXoGtNUY7fn5Uo4S/WlU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-223-Dt3GXfrSNaWeM3t4twEhVQ-1; Tue, 08 Feb 2022 14:06:32 -0500
X-MC-Unique: Dt3GXfrSNaWeM3t4twEhVQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BDFB9802925
	for <mptcp@lists.linux.dev>; Tue,  8 Feb 2022 19:06:31 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.39.194.58])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 2F2FB60BF4
	for <mptcp@lists.linux.dev>; Tue,  8 Feb 2022 19:06:30 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Subject: [PATCH mptcp-net v2 0/4] mptcp: fix races in add_addr handling
Date: Tue,  8 Feb 2022 20:06:14 +0100
Message-Id: <cover.1644346664.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
	auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pabeni@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"

the patches 1 && 2 fix actual races, even if the race addressed by
2/4 is not exposed by the self-tests, afaics.

patch 3 introduces some mibs to detect critical scenarios we can't
fix without major rework

patch 4 updates the self-test to be graceful in above cases.

Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/254

Paolo Abeni (4):
  mptcp: fix race in overlapping signal events
  mptcp: fix race in incoming ADD_ADDR option processing.
  mptcp: add mibs counter for ignored incoming options
  selftests: mptcp: more robust signal race test

 net/mptcp/mib.c                               |  2 ++
 net/mptcp/mib.h                               |  2 ++
 net/mptcp/pm.c                                |  8 +++--
 net/mptcp/pm_netlink.c                        | 29 +++++++++++++++----
 .../testing/selftests/net/mptcp/mptcp_join.sh | 16 ++++++++--
 5 files changed, 47 insertions(+), 10 deletions(-)

-- 
2.34.1

