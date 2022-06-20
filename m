Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBF7F2562
	for <mptcp@lists.linux.dev>; Mon, 20 Jun 2022 16:19:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1655741967;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=mAwT/4d89Rwzkct7lup/OjrROHG/B/gzwXf/mB5pA2M=;
	b=RXB55SEbMEmaoJ/9/SowBlsejF1BPBxF1m2b/MRYkGrL+4OQ5HoKDktKolYkm/TWxK6LSy
	8rGpdL+2HMaZTiq/jmyqnRtMAGv8n5NtF5mosV8S2MD51ymLOllnwivmmg01gd+t5VKPQN
	i1JY4Rdp/aEsbGOj9vMk/l2i1VPGi5I=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-669-7sd0LuexNzeXp4qrKJ4KbA-1; Mon, 20 Jun 2022 12:19:26 -0400
X-MC-Unique: 7sd0LuexNzeXp4qrKJ4KbA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 17C6F1C04B70
	for <mptcp@lists.linux.dev>; Mon, 20 Jun 2022 16:19:26 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.39.195.59])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 9C6954011A3E
	for <mptcp@lists.linux.dev>; Mon, 20 Jun 2022 16:19:25 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Subject: [PATCH net-next v3 1/3] mptcp: never fetch fwd memory from the subflow
Date: Mon, 20 Jun 2022 18:19:03 +0200
Message-Id: <630f7e13d7226f8c37a9cc0c66008a298c1e6b9e.1655741931.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.11.54.1
Authentication-Results: relay.mimecast.com;
	auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pabeni@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"; x-default=true

The memory accounting is broken in such exceptional code
path, and after commit 4890b686f408 ("net: keep sk->sk_forward_alloc
as small as possible") we can't find much help there.

Drop the broken code.

Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
This is possibly for net, but makes sense only on top of recent
net-next patches, so whatever ;)
---
 net/mptcp/protocol.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 6d2aa41390e7..0d4b2c010da0 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -328,15 +328,10 @@ static bool mptcp_rmem_schedule(struct sock *sk, struct sock *ssk, int size)
 
 	amt = sk_mem_pages(size);
 	amount = amt << PAGE_SHIFT;
-	msk->rmem_fwd_alloc += amount;
-	if (!__sk_mem_raise_allocated(sk, size, amt, SK_MEM_RECV)) {
-		if (ssk->sk_forward_alloc < amount) {
-			msk->rmem_fwd_alloc -= amount;
-			return false;
-		}
+	if (!__sk_mem_raise_allocated(sk, size, amt, SK_MEM_RECV))
+		return false;
 
-		ssk->sk_forward_alloc -= amount;
-	}
+	msk->rmem_fwd_alloc += amount;
 	return true;
 }
 
-- 
2.35.3

