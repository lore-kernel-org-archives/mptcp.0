Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [216.205.24.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 814653FCD
	for <mptcp@lists.linux.dev>; Tue, 21 Sep 2021 11:39:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1632224382;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cVopC3MwRdoidOVDTHAv0XPH/07fSiWFiO19TOP4P5A=;
	b=NFYMMakBQuPZgfHYEqlcENL7ThmbsQKZucq9nNVP5REN0IN5kpxfb9RYwchyFQZyzhp64q
	52tjX9NfCQS8f/czVWnbqez1QHA+WB2hHnJpqqbUu1KAeIsEVFtOoU69i0TMNVOtDUKcEj
	uVDJC6jr4d2X6tw+MZMaZWTquPVRSlY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-333-zObhymfcM8yiJCOFOZfEsg-1; Tue, 21 Sep 2021 07:39:41 -0400
X-MC-Unique: zObhymfcM8yiJCOFOZfEsg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 99B89BBEE3
	for <mptcp@lists.linux.dev>; Tue, 21 Sep 2021 11:39:40 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.39.195.132])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 1138E60C17
	for <mptcp@lists.linux.dev>; Tue, 21 Sep 2021 11:39:39 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Subject: [PATCH mptcp-next v2 3/3] tcp: make tcp_build_frag() static
Date: Tue, 21 Sep 2021 13:39:27 +0200
Message-Id: <4be7c77b82fd1de877ee60377aeb6afe249797d8.1632217366.git.pabeni@redhat.com>
In-Reply-To: <cover.1632217366.git.pabeni@redhat.com>
References: <cover.1632217366.git.pabeni@redhat.com>
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

After the previous patch the mentioned helper is
used only inside its compilation unit: let's make
it static.

RFC -> v1:
 - preserve the tcp_build_frag() helper (Eric)

Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
Note:
this should _replace_:
"""
Partially revert "tcp: factor out tcp_build_frag()"
"""

I did not opted for a squash to patch, as it would
still require conflicts resolution after the previous
squash-to patch. @matttbe: please let me know if you
prefer otherwise.
---
 include/net/tcp.h | 2 --
 net/ipv4/tcp.c    | 4 ++--
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/include/net/tcp.h b/include/net/tcp.h
index 4a96f6e0f6f8..673c3b01e287 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -330,8 +330,6 @@ int tcp_sendpage(struct sock *sk, struct page *page, int offset, size_t size,
 		 int flags);
 int tcp_sendpage_locked(struct sock *sk, struct page *page, int offset,
 			size_t size, int flags);
-struct sk_buff *tcp_build_frag(struct sock *sk, int size_goal, int flags,
-			       struct page *page, int offset, size_t *size);
 ssize_t do_tcp_sendpages(struct sock *sk, struct page *page, int offset,
 		 size_t size, int flags);
 int tcp_send_mss(struct sock *sk, int *size_goal, int flags);
diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index c592454625e1..29cb7bf9dc1c 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -963,8 +963,8 @@ void tcp_remove_empty_skb(struct sock *sk, struct sk_buff *skb)
 	}
 }
 
-struct sk_buff *tcp_build_frag(struct sock *sk, int size_goal, int flags,
-			       struct page *page, int offset, size_t *size)
+static struct sk_buff *tcp_build_frag(struct sock *sk, int size_goal, int flags,
+				      struct page *page, int offset, size_t *size)
 {
 	struct sk_buff *skb = tcp_write_queue_tail(sk);
 	struct tcp_sock *tp = tcp_sk(sk);
-- 
2.26.3

