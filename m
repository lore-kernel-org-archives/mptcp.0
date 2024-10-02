Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F4251D042F
	for <mptcp@lists.linux.dev>; Wed,  2 Oct 2024 15:10:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727881851; cv=none; b=XQ/2ITRVHmZau4gOPQJ2jfmgMY6T2mEH83uN5kjXu3B2xGm7JurD9B6msV6mo+A0Ty6uTUXupsNDvsqnfrEufgwIEzbPnBl+xvmv4EIhvxZC2ksjYI5KEITFo1PkcgYrT4/QIaYMn7Ay6v5Aok8llNTEY0LaB2j+sshkto8swkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727881851; c=relaxed/simple;
	bh=zBbq4mZuhfjPEMw+zD6Da8u+cPyQOp3rsqrUlWy58gc=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=c54WtiEhCQDf39dQdxQE+Ymrb073l7CSs6xwWv4Wf7wlVx/V5C+WnpLa/ceVzzGbWbtiLr8ZdLyGkLXVefYRrN3KT+tyu2nO4k1t0JpUIEtiz4d0w+9Gf/Iep9VsElRZD2GNSgo1SyBLJ40WWQ3B2VfVLwdWJzwY+/ZbyjbDhO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=F8sw6nsk; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="F8sw6nsk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1727881849;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=xFWlycuqdqXO4TjCLAQp0QWIH+CiddFNIciBHdRXUPY=;
	b=F8sw6nskv44i8+dKN+wnUqqvf+dgZUbHmRSq4hIuNqlDlWcs+Szf+4u42AvUgSQZZqKv83
	OTAGtmNv6Nxwkk83zqNgdrmtVdzDriMCFdbMki76NbT1ijM1biJVatdWryQyHuBFO69WaT
	CRtd+DLVchYthqRy7FawfSuKVwFD9ho=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-36-GXXIYRtrMhaoJf6DF_n4dQ-1; Wed,
 02 Oct 2024 11:10:47 -0400
X-MC-Unique: GXXIYRtrMhaoJf6DF_n4dQ-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 057941956080
	for <mptcp@lists.linux.dev>; Wed,  2 Oct 2024 15:10:47 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.45.224.250])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id E59C03000197
	for <mptcp@lists.linux.dev>; Wed,  2 Oct 2024 15:10:45 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Subject: [PATCH mptcp-net] Squash-to: "mptcp: handle consistently DSS corruption"
Date: Wed,  2 Oct 2024 17:10:41 +0200
Message-ID: <dfce01586ff42d63cffce0a2ca10149e30ec71fe.1727881810.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"; x-default=true

Instead of re-inventing the wheel, use the flag we already
track to easily check if fallback is allowed.

Note that we could not check conn_list in a reliable way,
as the call side is not under the msk socket lock.

Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
 net/mptcp/protocol.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index ba5f4f44f4b3..fd1c2e866e8e 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -622,7 +622,7 @@ static bool mptcp_check_data_fin(struct sock *sk)
 
 static void mptcp_dss_corruption(struct mptcp_sock *msk, struct sock *ssk)
 {
-	if (list_is_singular(&msk->conn_list) && msk->first == ssk) {
+	if (READ_ONCE(msk->allow_infinite_fallback)) {
 		MPTCP_INC_STATS(sock_net(ssk),
 				MPTCP_MIB_DSSCORRUPTIONFALLBACK);
 		mptcp_do_fallback(ssk);
-- 
2.45.2

