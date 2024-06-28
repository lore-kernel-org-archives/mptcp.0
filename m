Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2DEA1DDCE
	for <mptcp@lists.linux.dev>; Fri, 28 Jun 2024 15:54:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719590068; cv=none; b=iHaR89FXmg3rfFY4yQigP7PeTaqKmF0oEMxRUQ33h4EjrXlq8bLCckUiWI5nT+LYolmDgamgwXrtQWqlbrqX6Lacj8gMP1wH8LVYGrI71q4B3F24SeDR51nSKNWIF8Tf4RGX+VO65xogZ+yNBiShV1HugleAR77dU9uGnWOJ9bw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719590068; c=relaxed/simple;
	bh=WXkAd+fQZx5fKGECD/sw7xxf3RNUdxEEEugWtnd7feo=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iV2+0gpkQMlD65/BQbdl24bhXRLgdWrDS+ZhBg1dAwPT34fVTWvkAfJqIrkLOFSjIRi3MfQO3ftiiIERACEdfHcUpKVRA4Biq4Py8r8SA/S/TQlLyraYfvXxpYMc1Msdl7X5CI97ElAVd/5pnEQIK7qCb56KpjNzM/E/TNolklA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WPJjryS5; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WPJjryS5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1719590064;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+Yl5RhFH8AWSHhK+gol3+Ogtst/C/7rbxV2pagv348c=;
	b=WPJjryS5OQr7/byIXXIAtq3QFLK+ibsktiGqCwhBE42RcTVcHmWmAx9pfGgXbwgspem5Lc
	M3vuVwYg0jM7qxuG6RNwcsUgFzYey9brFDQr6AluCG54hnB9l3xIgIhaHXYeg/noEW0Yi6
	SIVAP1ZW55AWm5iZ8nKSsWNqVBQQ4Qo=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-591-Jde8RobpMUSbB1blJe084Q-1; Fri,
 28 Jun 2024 11:54:23 -0400
X-MC-Unique: Jde8RobpMUSbB1blJe084Q-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 6E50E1955F03
	for <mptcp@lists.linux.dev>; Fri, 28 Jun 2024 15:54:21 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.45.225.34])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 68D4D19560B2
	for <mptcp@lists.linux.dev>; Fri, 28 Jun 2024 15:54:20 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Subject: [PATCH mptcp-net 3/3] selftests: mptcp: fix error path
Date: Fri, 28 Jun 2024 17:54:08 +0200
Message-ID: <aa0ddd712e2b466b69ea87fba6158f13b850c1b1.1719589916.git.pabeni@redhat.com>
In-Reply-To: <cover.1719589916.git.pabeni@redhat.com>
References: <cover.1719589916.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"; x-default=true

pm_nl_check_endpoint() currently calls an not existing helper
to mark the test as failed. Fix the wrong call.

Fixes: 03668c65d153 ("selftests: mptcp: join: rework detailed report")
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
 tools/testing/selftests/net/mptcp/mptcp_join.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 228fecee61f9..c4593677a567 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -661,7 +661,7 @@ pm_nl_check_endpoint()
 	done
 
 	if [ -z "${id}" ]; then
-		test_fail "bad test - missing endpoint id"
+		fail_test "bad test - missing endpoint id"
 		return
 	fi
 
-- 
2.45.1

