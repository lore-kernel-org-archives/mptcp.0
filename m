Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF0BF27A915
	for <mptcp@lists.linux.dev>; Fri, 11 Jul 2025 09:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752226200; cv=none; b=qqe/Zi7yUKnfSutOm9/K945s2B0wCariWgrvwiMFumGlUJqKpUFLeGC59vcav70POE0hoaDbBFt7za/tWxO3IwdpW/NxJ8P+FBKlNkO82FCnKZtkjsybN/UmcvVHmgZGi4OXj8b3OXhk6GWoLuX2xF1YnjItpx0Pi7dqRX350WM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752226200; c=relaxed/simple;
	bh=sU3mpPl7sK2j1m32ntos1YLuyK5q36Rs/WELxr0FDuY=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:content-type; b=gtOKfbgcb61OIsHxM3cg+XSx5d2AJNJ4QxMI7Wc0tp/oGGvDW8dukS+eW/kWLjhadMuXhrEvPGGD8Odp6vlbEEy788Onx4tdYMc/xm5z+KGo3YLIdWyrDi1ySp9O/elE8DghA97YTsgb1Ln7zqSNsBdE5dunqvSV+EAd1qa9Fz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=I2/BY3bU; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="I2/BY3bU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752226196;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=wPeU8HjB5E8ol+ouf8ApcNm6O9ijkLTDu0vvpW4CJrk=;
	b=I2/BY3bUoVyAPPEObgHAeQOdgpGYsSKRuQAzudLXxJs0sJyF7wHS7nrzfuX12Xl7YxQ8I6
	bNXRKvGySW4SQig9iMzbj2bBcfxpkDSxJ+c29K+b50wWknxW8o5Z7lGwBWiYPR1OPdkABb
	dC+gJSlmTzTjLGDWWG8SIf7xy5HikCc=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-650-PYu1ynz0PPK51aYwxlbYqg-1; Fri,
 11 Jul 2025 05:29:54 -0400
X-MC-Unique: PYu1ynz0PPK51aYwxlbYqg-1
X-Mimecast-MFC-AGG-ID: PYu1ynz0PPK51aYwxlbYqg_1752226193
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id CCC041955DB2
	for <mptcp@lists.linux.dev>; Fri, 11 Jul 2025 09:29:53 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.44.33.145])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id EF22318002B5
	for <mptcp@lists.linux.dev>; Fri, 11 Jul 2025 09:29:52 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Subject: [PATCH v4 mptcp-net 0/5] mptcp: fix fallback-related races
Date: Fri, 11 Jul 2025 11:29:40 +0200
Message-ID: <cover.1752221786.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: ConMh37AZXVlrmGwNZW5-wzAAtgTxvkpl2_GReNjTv0_1752226193
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

This series contains 3 fixes somewhat related to various races we have
while handling fallback and 2 small follow-up likely more suited for
net-next.

The root cause of the issues addressed here is that the check for
"we can fallback to tcp now" and the related action are not atomic. That
also applies to fallback due to MP_FAIL - where the window race is even
wider.

Address the issue introducing an additional spinlock to bundle together
all the relevant events, as per patch 1 and 2.

Note that mptcp_disconnect() unconditionally
clears the fallback status (zeroing msk->flags) but don't tuch the
`allows_infinite_fallback` flag. Such issue is addressed in patch 3.

Patch 4 cleans up a bit the fallback code, introducing specific MIB for
each FB reason, and patch 5 drops the, hopefully now redundant
pr_fallback().
---
v3 -> v4:
 - fic MIB exposed names

v2 -> v3:
 - mptcp_do_fallback  -> mptcp_try_fallback
 - refactored patch 3/5
 - changed mibs names, increment fail only when the protocol mandate it
 - fix W=1 warn in patch 5/5

Paolo Abeni (5):
  mptcp: make fallback action and fallback decision atomic
  mptcp: plug races between subflow fail and subflow creation
  mptcp: reset fallback status gracefully at disconnect() time
  mptcp: track fallbacks accurately via mibs
  mptcp: remove pr_fallback()

 net/mptcp/ctrl.c     |  4 +-
 net/mptcp/mib.c      |  5 +++
 net/mptcp/mib.h      |  7 ++++
 net/mptcp/options.c  |  6 ++-
 net/mptcp/pm.c       |  8 +++-
 net/mptcp/protocol.c | 97 ++++++++++++++++++++++++++++++++++----------
 net/mptcp/protocol.h | 35 ++++++++--------
 net/mptcp/subflow.c  | 40 ++++++++++--------
 8 files changed, 140 insertions(+), 62 deletions(-)

-- 
2.50.0

