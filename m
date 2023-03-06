Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CDD52F23
	for <mptcp@lists.linux.dev>; Mon,  6 Mar 2023 18:30:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1678127430;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aKzd26WHuykUzomNGc0w92bJKsv/tjR5luKYqhaSYgQ=;
	b=V7pXWoiQrVsbrIHE7VZWsggIPDWDjYzX9S/feZuMsDnqaZTD1uoZUL77DAH8hzL42BcLSR
	Z5QMgtQd56ss1JgtgcBPLF7IIMww1rNC1xmglKmZFrXj9LjWqa5J+sLWTvcQUHvE8zaqQr
	LbWwkK6bPyTnqFqtlDWB1wcT54Q6ggk=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-629-vRnUZJGtMjqSPAZelNL6uw-1; Mon, 06 Mar 2023 13:30:29 -0500
X-MC-Unique: vRnUZJGtMjqSPAZelNL6uw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A885A811E9C
	for <mptcp@lists.linux.dev>; Mon,  6 Mar 2023 18:30:28 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.39.195.34])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 38264175AD
	for <mptcp@lists.linux.dev>; Mon,  6 Mar 2023 18:30:28 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Subject: [PATCH mptcp-next 1/2] mptcp: avoid unneeded address copy
Date: Mon,  6 Mar 2023 19:30:20 +0100
Message-Id: <e341fae478d52cb3233e56496aa1d331e40d7073.1678122760.git.pabeni@redhat.com>
In-Reply-To: <cover.1678122760.git.pabeni@redhat.com>
References: <cover.1678122760.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"; x-default=true

In the syn_recv fallback path, the msk is unused. We can skip
setting the socket address.

Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
 net/mptcp/subflow.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index 1ca8d30e9276..f0758b23c6b2 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -821,8 +821,6 @@ static struct sock *subflow_syn_recv_sock(const struct sock *sk,
 				goto dispose_child;
 			}
 
-			if (new_msk)
-				mptcp_copy_inaddrs(new_msk, child);
 			mptcp_subflow_drop_ctx(child);
 			goto out;
 		}
-- 
2.39.2

