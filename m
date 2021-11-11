Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E0742C81
	for <mptcp@lists.linux.dev>; Thu, 11 Nov 2021 09:37:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1636623440;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=1J4Hkczg07QVsxkpKTn8eFrg+rb32UJpeCz7ZqKG7hE=;
	b=D3Zgu9lpJdSbwz6IUU75VL0/dJk9MymNWHFxxfLw/VsiqxpmW0ih1DOUn7na1kt961pcAM
	kLa/uDyrTMbGA6koNgytioXJac6dB8b01tF/TYRZiumZ70TaURzsuyghN4o+f7uuWYQZs9
	3vw4ZC3SjBe6IejS3ZLZvRYTq+qOvbw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-218-hVPPz_AEMvGXHMT5byBylw-1; Thu, 11 Nov 2021 04:37:11 -0500
X-MC-Unique: hVPPz_AEMvGXHMT5byBylw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C9D7F10066F3;
	Thu, 11 Nov 2021 09:36:53 +0000 (UTC)
Received: from dcaratti.users.ipa.redhat.com (unknown [10.40.195.43])
	by smtp.corp.redhat.com (Postfix) with ESMTP id F1F4D18A68;
	Thu, 11 Nov 2021 09:36:47 +0000 (UTC)
From: Davide Caratti <dcaratti@redhat.com>
To: pabeni@redhat.com,
	aclaudi@redhat.com,
	Matthieu Baerts <matthieu.baerts@tessares.net>,
	Stephen Hemminger <stephen@networkplumber.org>
Cc: mptcp@lists.linux.dev,
	netdev@vger@kernel.org
Subject: [PATCH iproute2] mptcp: fix JSON output when dumping endpoints by id
Date: Thu, 11 Nov 2021 10:35:48 +0100
Message-Id: <474b741a13ba1058dd991c4f68f68b99610dda2b.1636623282.git.dcaratti@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
	auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=dcaratti@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"

iproute ignores '-j' command line argument when dumping endpoints by id:

 [dcaratti@dcaratti iproute2]$ ./ip/ip -j mptcp endpoint show
 [{"address":"1.2.3.4","id":42,"signal":true,"backup":true}]
 [dcaratti@dcaratti iproute2]$ ./ip/ip -j mptcp endpoint show id 42
 1.2.3.4 id 42 signal backup

fix mptcp_addr_show() to use the proper JSON helpers.

Fixes: 7e0767cd862b ("add support for mptcp netlink interface")
Signed-off-by: Davide Caratti <dcaratti@redhat.com>
---
 ip/ipmptcp.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/ip/ipmptcp.c b/ip/ipmptcp.c
index 0f5b6e2d08ba..857004446aa3 100644
--- a/ip/ipmptcp.c
+++ b/ip/ipmptcp.c
@@ -305,7 +305,11 @@ static int mptcp_addr_show(int argc, char **argv)
 	if (rtnl_talk(&genl_rth, &req.n, &answer) < 0)
 		return -2;
 
-	return print_mptcp_addr(answer, stdout);
+	new_json_obj(json);
+	ret = print_mptcp_addr(answer, stdout);
+	delete_json_obj();
+	fflush(stdout);
+	return ret;
 }
 
 static int mptcp_addr_flush(int argc, char **argv)
-- 
2.31.1

