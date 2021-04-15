Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [216.205.24.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C33DA29CA
	for <mptcp@lists.linux.dev>; Thu, 15 Apr 2021 16:02:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1618502546;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=ixCVAMUsh5mQMw4iIRrU9+gexJONYf12/PHvd85SHpA=;
	b=IfsvCUML5+0u1ZBPbxhj7KHtfNw1ZNeUgQDzzDj9WEHRCHA63No6YDqyQvQeYxr60EBXUy
	znf32FnOUkkmOJemwWXWiqcPDUUqTW24wmSuDu1JhqaIJmO5UBJNBj00zo8OiVP0bn51Tr
	zIW+XpRRErdHiPsMnNvrRGoGruC+AqE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-213---6z_csfN_OraVZfCtfFQA-1; Thu, 15 Apr 2021 12:02:24 -0400
X-MC-Unique: --6z_csfN_OraVZfCtfFQA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B15D188EF28
	for <mptcp@lists.linux.dev>; Thu, 15 Apr 2021 16:02:14 +0000 (UTC)
Received: from gerbillo.redhat.com (ovpn-115-128.ams2.redhat.com [10.36.115.128])
	by smtp.corp.redhat.com (Postfix) with ESMTP id F174B610F3
	for <mptcp@lists.linux.dev>; Thu, 15 Apr 2021 16:02:13 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Subject: [PATCH net-next 0/3] mptcp: improve MSG_* flags handling
Date: Thu, 15 Apr 2021 18:02:04 +0200
Message-Id: <cover.1618502178.git.pabeni@redhat.com>
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

The current handling is a bit fuzzy. Sometimes we silently ignore,
sometimes we bail on unsupported even on no-op ones.

Let's silently provide a provide a reasonable implementation or 
bail (currently only for MSG_FASTOPEN) for the flags with user-visible
side effects. Finally silently ignore the unsupported flags with no
user visible side effects.

Paolo Abeni (3):
  mptcp: implement dummy MSG_ERRQUEUE support
  mptcp: implement MSG_TRUNC support
  mptcp: ignore unsupported msg flags

 net/mptcp/protocol.c | 29 ++++++++++++++++++-----------
 1 file changed, 18 insertions(+), 11 deletions(-)

-- 
2.26.2

