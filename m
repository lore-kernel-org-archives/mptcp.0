Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [216.205.24.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7088C168
	for <mptcp@lists.linux.dev>; Thu, 30 Sep 2021 15:19:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1633015179;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=+5+u6ZvBHS0L9a3SN/PDZ2qEIz0CiXjQSggz4/0Z7Ic=;
	b=RjKZMGMPPjR8fOepGlJpqJokFg9nWesuJRJpTb8YvcZULnswt/djX4uqzzzPuo6bMkYOoZ
	F+dqHtXm9ytza7ZyiHLo0hqIxAyw3UA3FvzorOB319foNGBNzAEBN3OrylGpY1CRr3DBSx
	OhzjcjkCXvjsjeMOrLFCXQeQX38OkBA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-451-MqcfVoCtNM-FfKSor13Pnw-1; Thu, 30 Sep 2021 11:19:38 -0400
X-MC-Unique: MqcfVoCtNM-FfKSor13Pnw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BF92B8145E7;
	Thu, 30 Sep 2021 15:19:36 +0000 (UTC)
Received: from dcaratti.station (unknown [10.40.193.26])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 5377B5D6D5;
	Thu, 30 Sep 2021 15:19:35 +0000 (UTC)
From: Davide Caratti <dcaratti@redhat.com>
To: aclaudi@redhat.com,
	pabeni@redhat.com,
	Stephen Hemminger <stephen@networkplumber.org>
Cc: mptcp@lists.linux.dev,
	netdev@vger.kernel.org
Subject: [PATCH iproute2] mptcp: unbreak JSON endpoint list
Date: Thu, 30 Sep 2021 17:19:25 +0200
Message-Id: <b526544bc745535f72c76752bbd850df5a0ac2e4.1633004460.git.dcaratti@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15

the following command:

 # ip -j mptcp endpoint show

prints a JSON array that misses the terminating bracket. Fix this calling
delete_json_obj() to balance the call to new_json_obj().

Fixes: 7e0767cd862b ("add support for mptcp netlink interface")
Signed-off-by: Davide Caratti <dcaratti@redhat.com>
---
 ip/ipmptcp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/ip/ipmptcp.c b/ip/ipmptcp.c
index bc12418bd39c..25d7d6784f89 100644
--- a/ip/ipmptcp.c
+++ b/ip/ipmptcp.c
@@ -262,7 +262,7 @@ static int mptcp_addr_dump(void)
 		return -2;
 	}
 
-	close_json_object();
+	delete_json_obj();
 	fflush(stdout);
 	return 0;
 }
-- 
2.31.1

