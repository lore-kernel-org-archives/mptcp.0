Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FB881FF7A1
	for <mptcp@lists.linux.dev>; Fri,  6 Dec 2024 12:10:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733487049; cv=none; b=Juw22C88Q2AEwLQgqhcVR5OBLSMhbvO1SHtd4RUnqqYSeRcmFJQG5HZNT6tguDFEkskY4c2OZBN6663hChAysIY15Cj+cMIn12KjXatNorLxql0LlZ+Qyol5L8XpFmGGHTEJjh9sV+wYdimlAAlR1MVfGCoKhyRtQWic17Yi+LI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733487049; c=relaxed/simple;
	bh=gQANsrNymzzuRiXAg2YHwp6A1C/OzXBmjJ4b0vcUnxw=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=liX/2kEtaYkOYcSwuQzGksUWqk/dF9XeEpIJQENS0b5op8c4Q+0lQh4cOOzbqJEq+OnHLsOLeJViLst/Py3h0O9b+Bv2ER6Jo4erf0yp/lwLCNs0F/aDVLFhzUO4wajF3YsKgTCDqKrOUmwPLLLBn1VQhgkJCV9qX7YOoNY3jqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Nf83wfcl; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Nf83wfcl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733487046;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lk8Jgnx5qUsYIcDhKvKBMF1KyfJ9lbg9HpKbd3xGwqM=;
	b=Nf83wfcl54rmoChFcZfPLrR055ceUyBf0WY7GCW501I7C5xtD/wdql7A1qxn0GGtN+HvHH
	R71px32+KO2KlbVFWiFWyYY8vdgTxr3Zn4ICP0EQU65YOs1kYIVHGMOvnKsXZO8VCaI/pS
	rkbFhcbNFMuQhAJJBt0ZsrtTKjpXdV8=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-651-4LQVov5LPhKjqmc-dRrInQ-1; Fri,
 06 Dec 2024 07:10:45 -0500
X-MC-Unique: 4LQVov5LPhKjqmc-dRrInQ-1
X-Mimecast-MFC-AGG-ID: 4LQVov5LPhKjqmc-dRrInQ
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id BC4681956089
	for <mptcp@lists.linux.dev>; Fri,  6 Dec 2024 12:10:44 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.39.192.243])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id EFF731955F3F
	for <mptcp@lists.linux.dev>; Fri,  6 Dec 2024 12:10:43 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Subject: [PATCH mptcp-next v2 2/7] tcp: fix recvbuffer adjust on sleeping rcvmsg
Date: Fri,  6 Dec 2024 13:10:41 +0100
Message-ID: <23213d7ff1d80061cbac28414a683fd9d7688cf9.1733486870.git.pabeni@redhat.com>
In-Reply-To: <cover.1733486870.git.pabeni@redhat.com>
References: <cover.1733486870.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: zQxgSRo1Nq9E7JdRu72eKE6ymDrmDRBXxtowb_LrJPw_1733487044
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

If the recvmsg() blocks after receiving some data - i.e. due to
SO_RCVLOWAT - the MPTCP code will attempt multiple times to
adjust the receive buffer size, wrongly accounting every time the
cumulative of received data - instead of accounting only for the
delta.

Address the issue moving mptcp_rcv_space_adjust just after the
data reception and passing it only the just received bytes.

This also remove an unneeded difference between the TCP and MPTCP
RX code path implementation.

Fixes: 581302298524 ("mptcp: error out earlier on disconnect")
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
Not strictly related to the refactor, found while investigating
the CI failure
---
 net/mptcp/protocol.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index fd9593f85a98..bca8c2c046c3 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1940,6 +1940,8 @@ static int mptcp_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
 	goto out;
 }
 
+static void mptcp_rcv_space_adjust(struct mptcp_sock *msk, int copied);
+
 static int __mptcp_recvmsg_mskq(struct mptcp_sock *msk,
 				struct msghdr *msg,
 				size_t len, int flags,
@@ -1993,6 +1995,7 @@ static int __mptcp_recvmsg_mskq(struct mptcp_sock *msk,
 			break;
 	}
 
+	mptcp_rcv_space_adjust(msk, copied);
 	return copied;
 }
 
@@ -2269,7 +2272,6 @@ static int mptcp_recvmsg(struct sock *sk, struct msghdr *msg, size_t len,
 		}
 
 		pr_debug("block timeout %ld\n", timeo);
-		mptcp_rcv_space_adjust(msk, copied);
 		err = sk_wait_data(sk, &timeo, NULL);
 		if (err < 0) {
 			err = copied ? : err;
@@ -2277,8 +2279,6 @@ static int mptcp_recvmsg(struct sock *sk, struct msghdr *msg, size_t len,
 		}
 	}
 
-	mptcp_rcv_space_adjust(msk, copied);
-
 out_err:
 	if (cmsg_flags && copied >= 0) {
 		if (cmsg_flags & MPTCP_CMSG_TS)
-- 
2.45.2

