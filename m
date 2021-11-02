Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A36EA2C9F
	for <mptcp@lists.linux.dev>; Tue,  2 Nov 2021 20:49:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1635886148;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=JHCUyd526fcgWDDlLsaiZWD/PZD0dP35uoFkwdxdx3Q=;
	b=JAPPI7U0hdHzFPO5rARxbkLHU0bsAi3X9cb+4jERzV2a9n/xNT8NjAMM/gVIDsd01GP4bZ
	SsrQKnfY2jFcFdhna5UEOseU9KQ8P7BLXmhAfXR9PdrtFERQy7cCVNdf99D2ocKLh9Atcy
	WwixdPz75TIcPRmgJaUcxuKtbZIiGX4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-568-lkMMeG2rM-KdoS_MoirhFw-1; Tue, 02 Nov 2021 16:49:05 -0400
X-MC-Unique: lkMMeG2rM-KdoS_MoirhFw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9707C1922961
	for <mptcp@lists.linux.dev>; Tue,  2 Nov 2021 20:49:04 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.39.192.20])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 08E7A60CC4
	for <mptcp@lists.linux.dev>; Tue,  2 Nov 2021 20:49:03 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Subject: [PATCH v2 mptcp-net 0/2] mptcp: fix MPJ 3rd ack retransmissions
Date: Tue,  2 Nov 2021 21:48:57 +0100
Message-Id: <cover.1635885975.git.pabeni@redhat.com>
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

The first patch is from Eric, thus is correct ;)
The 2nd one is much more doubtful, starting from the author ;)
The individual commit messages should be descriptive enough. With these
2 patches the related, pending pktdrill test:

https://github.com/multipath-tcp/packetdrill/pull/70

now complete successfully

v1 -> v2:
 - fix from delegated action invocation in patch 2/2 (Mat)

Eric Dumazet (1):
  mptcp: fix delack timer

Paolo Abeni (1):
  mptcp: use delegate action to schedule 3rd ack retrans

 net/mptcp/options.c  | 32 ++++++++--------------------
 net/mptcp/protocol.c | 50 ++++++++++++++++++++++++++++++++++++--------
 net/mptcp/protocol.h | 17 ++++++++-------
 3 files changed, 59 insertions(+), 40 deletions(-)

-- 
2.26.3

