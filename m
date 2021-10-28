Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 670192C83
	for <mptcp@lists.linux.dev>; Thu, 28 Oct 2021 13:08:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1635426523;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=dwCDM/bYXd+8pSuxBQvbT2AHYV8uyCSuU+H48sc0D0o=;
	b=YuOdF5+2DYPEDfMMd1JY1CLSbBTUHMJRKhVaskqQiXEWAX+wkG0B627DmQiUjBl6/8WUUT
	RT9XGcenyeemt3aF7XmAKimEC3zAVuU/54AZZ58mWMD4ImAXAulOe7jxGejiX/TA171RC9
	f+VLd7bdQVi/zAsEXYkMqI4gbxSKEO0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-63-eBzMnxm_OmGPdapute75ug-1; Thu, 28 Oct 2021 09:08:41 -0400
X-MC-Unique: eBzMnxm_OmGPdapute75ug-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1DAEA10B7465
	for <mptcp@lists.linux.dev>; Thu, 28 Oct 2021 13:08:40 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.39.194.218])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 807DF19D9F
	for <mptcp@lists.linux.dev>; Thu, 28 Oct 2021 13:08:39 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp <mptcp@lists.linux.dev>
Subject: [PATCH mptcp-net 0/2] mptcp: fix MPJ 3rd ack retransmissions
Date: Thu, 28 Oct 2021 15:08:31 +0200
Message-Id: <cover.1635426465.git.pabeni@redhat.com>
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

The first patch is from Eric, thus is correct ;)
The 2nd one is much more doubtful, starting from the author ;)
The individual commit messages should be descriptive enough. With these
2 patches the related, pending pktdrill test:

https://github.com/multipath-tcp/packetdrill/pull/70

now complete successfully

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

