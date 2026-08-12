Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7871343712F
	for <mptcp@lists.linux.dev>; Wed, 12 Aug 2026 17:08:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786554509; cv=none; b=AQYQrtOw/7bLj3YvhKNA5wNhRcfl/gj+zaqWnH/ZKn5x8c8+UZMdlRv1V/BWIjMDXdOsADkjNCY6M/NY8cAoOKOSPrqtOF2/kjHlGP74+AWFZZL4cdJXsToStd/8aHPvK7GOCErlVLO7UvyKbirwzjQsHmipFb1jgEPTWeTSOdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786554509; c=relaxed/simple;
	bh=GCizGrrASMEFESVA+b+Od4cEStG29o3n23jY+8xCSjA=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:content-type; b=EvoMjjyLwkW4y0hSRIRgPqF5BjV0ZS33ovCdeNKg+9y/O1emfuKSdaVOFODBQk6lC5C+sTFlb6GShHaC7aOFFyzqkAQe9hz3CH+u91khrGRKZ1Uh4GXDoaJZiaetCEd/bLZyGExR8eaNGP0KeVY5UpYHwVw8dDspDEyHBzJiwGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=i/Xeu2wS; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="i/Xeu2wS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1786554505;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=k74UrvnUgKN6/Rs079QqSOhb5qXYJLzs/NCrS6JK5oE=;
	b=i/Xeu2wS9X6vqrC90aNQ00p1kVSAbxKMZureWLM3nhsPy4ExBQCBzsOmfwrYevJ42hJOTu
	xHLs5mPDXteS8UQzEmq4wtsBzNB72QyNHgssp3+poGgyi9em+dxsw9me8Ztz648dhJQZwB
	nVMRI8xJA5Jmi9P1o177j9NKU//V3lQ=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-145-1cKkKlQxMxu6fnN13Nha7w-1; Wed,
 12 Aug 2026 13:08:24 -0400
X-MC-Unique: 1cKkKlQxMxu6fnN13Nha7w-1
X-Mimecast-MFC-AGG-ID: 1cKkKlQxMxu6fnN13Nha7w_1786554503
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 354DB180064C
	for <mptcp@lists.linux.dev>; Wed, 12 Aug 2026 17:08:23 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.44.32.162])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 51D46180034F
	for <mptcp@lists.linux.dev>; Wed, 12 Aug 2026 17:08:21 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Subject: [PATCH mptcp-net 0/4] mptcp: a few fixes
Date: Wed, 12 Aug 2026 19:08:12 +0200
Message-ID: <cover.1786553006.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: OrT1JKJFijfseOShd2n-Cq57xiXQKczhetCLRbsYaK0_1786554503
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

This is mostly a follow-up to the recent OoO queue pruning series.
Explicitly targeting net as we have already a lot of patches pending for
net-next, and no need to rush IMHO.

First 2 patches addresses explicit comments from sashiko, 3rd one is a
somewhat unrelated cleanup I stumbled upon while implementing patch 4.

The last patch fixes another thing implided by sashiko while reviewing
the mentioned series.

Paolo Abeni (4):
  mptcp: being below memory limit is a likely() condition
  mptcp: avoid pruning for OoW data
  mptcp: remove unneeded READ_ONCE() annotation
  mptcp: do not reschedule the RTX timer for fallback sockets

 net/mptcp/options.c  |  4 ++--
 net/mptcp/protocol.c | 27 ++++++++++++++++-----------
 net/mptcp/protocol.h |  1 +
 3 files changed, 19 insertions(+), 13 deletions(-)

-- 
2.55.0

