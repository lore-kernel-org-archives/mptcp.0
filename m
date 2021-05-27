Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53C9E70
	for <mptcp@lists.linux.dev>; Thu, 27 May 2021 16:53:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1622134395;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=d9h7zK08RZFpCpnPnZQOw5UeyzAza1c35guESfJ3Zhw=;
	b=QvRMD2C7Va3CGZHh3GEDzj01gsD5GpmtihxMJGSK1nwKjtCz1nqvKQRmanS+d7452UtEi8
	bK0c8FCkiV2TGV14+orpqI62fLr24UR0P6jRI5/1v2iDo7jKPT8/Y6S7vsMDmJmuT71oCd
	Y/2hyB0b+CBIS416+1pCjbY3XeoVIAU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-554-tndshrPIPhqcq84ATecINA-1; Thu, 27 May 2021 12:53:13 -0400
X-MC-Unique: tndshrPIPhqcq84ATecINA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A15F0180FD65
	for <mptcp@lists.linux.dev>; Thu, 27 May 2021 16:53:12 +0000 (UTC)
Received: from gerbillo.redhat.com (ovpn-114-53.ams2.redhat.com [10.36.114.53])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 142B5510ED
	for <mptcp@lists.linux.dev>; Thu, 27 May 2021 16:53:11 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Subject: [PATCH mptcp-next 0/2] mptcp: some smaller cleanup
Date: Thu, 27 May 2021 18:53:03 +0200
Message-Id: <cover.1622132917.git.pabeni@redhat.com>
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Authentication-Results: relay.mimecast.com;
	auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pabeni@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"

This are 2 smallish pre-req for the RX path refactor.

I think they can live of their own merit, so sending them
out now.

Paolo Abeni (2):
  mptcp: don't clear MPTCP_DATA_READY in sk_wait_event()
  mptcp: drop rendundant test in move_skbs_to_msk()

 net/mptcp/protocol.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

-- 
2.26.3

