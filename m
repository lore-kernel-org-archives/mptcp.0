Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5387E2F6585
	for <mptcp@lists.linux.dev>; Thu, 13 Nov 2025 23:07:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763075252; cv=none; b=jeIQ3SoJXFTuVxo8j5KC6Y3Gw4LgA9ENabVWASNDQbfFYun7NWZSCyFL7xmV0RhfpP4fdWTyBjZMb/ENaLmtCzrnBrJbCbBhCbiZXcIpBvrZ8cE4wOyNGSCEMjxEuZvMQN28GAkZGERk77+VkZAgLN8lC6b7J4x62XzCcm2jzxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763075252; c=relaxed/simple;
	bh=7eSImwNvoMkwDsvwPRk220NhPxqTjrsJEj1kAy6hZWQ=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:content-type; b=h9HaCLQ1D2LCefEfrvk5OVTwCar2bC37TI1qs0YDp2jbJ8o3gxhDGtHaD9os9mLjCLUVilNVjI3mLftO7GvX9z5oMyKrGEp7DcnL7lhCeuDzzz61NFaoOwkZa+he5GG4EGJKi4NJq2xtvnfT3ds2cN3L2pypzeMP8/tNOUhR2Jg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iFA+Ss/S; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iFA+Ss/S"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1763075249;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=65IeVe5ZbsDI7rTor27UnbVAxJDvbIjL/Q0fdg9n1kQ=;
	b=iFA+Ss/SPbwdAC6XyBqFSZ88f9Q8lfcAFvui9NXss0HDsrYHAUujNkjS9j9NRiU5zwKyau
	sMTvVRE6BYKu3pN/ncbRnicXYDeOEGyfuFb+fzlET28zoyN5X5JdSvk95AhdkgoFhv3TY2
	iZNkEkobtwLpmXNh7L+sLZoL9IqY3nc=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-447-cuh9VbKyMoCiobL5BsP1xw-1; Thu,
 13 Nov 2025 18:07:27 -0500
X-MC-Unique: cuh9VbKyMoCiobL5BsP1xw-1
X-Mimecast-MFC-AGG-ID: cuh9VbKyMoCiobL5BsP1xw_1763075247
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id BD69919560A3
	for <mptcp@lists.linux.dev>; Thu, 13 Nov 2025 23:07:26 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.44.33.100])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id AFBAD300018D
	for <mptcp@lists.linux.dev>; Thu, 13 Nov 2025 23:07:25 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Subject: [PATCH mptcp-net 0/3] mptcp: a few random fixes
Date: Fri, 14 Nov 2025 00:05:28 +0100
Message-ID: <cover.1763075056.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: gMeJ3p8mVEXk_kf9HJy4F3RKGGnC3QsOxbydERYbsJc_1763075247
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

The first patch fixes selftest failures in CONFIG_PREEMPT build.
The second patch addresses a recently filed issue, 2nd one is due to
code inspection while investigating the mentioned issue.

v2 -> v3:
  - new patch 1/3
  - check OoO queue in mptcp_try_fallback

v1 -> v2:
  - fix pktdrill failures due to missing rcv_wnd_sent initialization

Paolo Abeni (3):
  mptcp: fix premature close in case of fallback
  mptcp: do not fallback when OoO is present
  mptcp: do not drop partial packets.

 net/mptcp/protocol.c | 37 +++++++++++++++++++++++++++++--------
 net/mptcp/subflow.c  |  3 ++-
 2 files changed, 31 insertions(+), 9 deletions(-)

-- 
2.51.1

