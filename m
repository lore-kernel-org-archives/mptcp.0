Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF95C2E8E10
	for <mptcp@lists.linux.dev>; Wed,  9 Jul 2025 15:13:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752073992; cv=none; b=TcwjO8uJZl4XhNVUJuffRIj3EOeiOYqBcMP7hWVPoCI3/R+4kTyNM02CayyGXhgmKAnbrxocVG0rm+B1T/f/QPrfZ8BbXCM/rh51jskpNaJLXkG5qzYGtbBfpDACkAlGB+6bU/wVjRs9KgpGay4EB2m5lVBo3eiWbIO/VgHZilU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752073992; c=relaxed/simple;
	bh=+NuMgX0OpPSAp4JlNmnrPZGlR8mw+6U/dWuyn+Nqk8M=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:content-type; b=J1kytzzGfAHIv/ySlC9SFhDgO6sMpg2QyHIuEUWNVMO6s3Mw7PFB7+bOgXuS2FBhVRaYBfOQAKGirYlhwX2FSy7OzMkZGoA6sy1QTWupSc8RCqb/diSk7d5ilTphVz/L0cOvPDECtTJGAesoaEYgVD9fj8Y6/yX3+R5BBo38BMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CxIBkgIj; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CxIBkgIj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752073986;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=iTeY6AdNzvZkaFWOEjdel6TOnWmch88iTsGAIImh250=;
	b=CxIBkgIjEyw5ePB5eBkEpXjceamBquPvupQKp73KYeCbOzsQJvrRX6M9eoVcEQTiniimPO
	7SWEiqMxh76dvhdTroTQcVnqGVHqUYTcXe3M3j3dyler1XdK3sQ/69v+7lt/1MrdfX9YE4
	k9ULKndQrr5HptaPvB/h4JJ7MiiBP5Q=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-9-ihkFEEjZMlKeM0pKDdwoyQ-1; Wed,
 09 Jul 2025 11:13:05 -0400
X-MC-Unique: ihkFEEjZMlKeM0pKDdwoyQ-1
X-Mimecast-MFC-AGG-ID: ihkFEEjZMlKeM0pKDdwoyQ_1752073984
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 34B72190FBCF
	for <mptcp@lists.linux.dev>; Wed,  9 Jul 2025 15:13:04 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.44.33.4])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 5770D19560A0
	for <mptcp@lists.linux.dev>; Wed,  9 Jul 2025 15:13:02 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Subject: [PATCH v3 mptcp-net 0/5] mptcp: fix fallback-related races
Date: Wed,  9 Jul 2025 17:12:49 +0200
Message-ID: <cover.1752073685.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: abbm88sU72xCSWmYMJtOMbi3tf_0hhQ_y3v3eKkpZY4_1752073984
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

