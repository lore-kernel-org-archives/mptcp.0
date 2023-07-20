Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FC7B20E6
	for <mptcp@lists.linux.dev>; Thu, 20 Jul 2023 06:34:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1689834875;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/ZZFlzKfH0NWsyCVDsz5sXXbtea4wzmHcKSxIxan5KE=;
	b=VHMEoAlN42Wr5UfSnA4BHBUL8nm50omk62stpWs9bajTj6RUdBO/R/NbXPqspIEqI1lUUc
	Cpl+KCfPP/ChFf/NXRxJ8isx8wgg0/7qNd5gm46YluLJ1dDQzYKnN5rop9xWiafPvANOB6
	wBjCzol6zEbSY6VuNiVldCMdipz5Mow=
Received: from mimecast-mx02.redhat.com (66.187.233.73 [66.187.233.73]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-612-UEi5BR-wPvm6TQk09C6Phw-1; Thu, 20 Jul 2023 02:34:33 -0400
X-MC-Unique: UEi5BR-wPvm6TQk09C6Phw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 6893F1C0E0C0
	for <mptcp@lists.linux.dev>; Thu, 20 Jul 2023 06:34:33 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.45.224.225])
	by smtp.corp.redhat.com (Postfix) with ESMTP id EBDFC1454142
	for <mptcp@lists.linux.dev>; Thu, 20 Jul 2023 06:34:32 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Subject: [PATCH mptcp-next 1/2] Squash-to: "mptcp: avoid unneeded mptcp_token_destroy() call"
Date: Thu, 20 Jul 2023 08:34:25 +0200
Message-ID: <d79bc96a1272a1645bfd0a23035a066fb569e8c5.1689834758.git.pabeni@redhat.com>
In-Reply-To: <cover.1689834758.git.pabeni@redhat.com>
References: <cover.1689834758.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"; x-default=true

Replace commit message with:

"""
the mptcp protocol currently clears the msk token both at
connect() and listen() time. That is needed to deal with failing
connect() calls that can create a new token while leaving the sk
in TCP_CLOSE,SS_UNCONNECTED status and thus allowing later connect()
and/or listen() calls.

Let's deal with such failures explcitly, cleaning the token in
a timely manner and avoid the confusing early mptcp_token_destroy()
"""

Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
 net/mptcp/protocol.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index c6cd817ee103..9e48dfbd102f 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -3656,6 +3656,8 @@ static int mptcp_connect(struct sock *sk, struct sockaddr *uaddr, int addr_len)
 	 * subflow_finish_connect()
 	 */
 	if (unlikely(err && err != -EINPROGRESS)) {
+		/* avoid leaving a dangling token in an unconnected socket */
+		mptcp_token_destroy(msk);
 		inet_sk_state_store(sk, inet_sk_state_load(ssk));
 		return err;
 	}
-- 
2.41.0

