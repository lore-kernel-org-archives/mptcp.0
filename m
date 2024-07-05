Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13EED13C681
	for <mptcp@lists.linux.dev>; Fri,  5 Jul 2024 20:34:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720211655; cv=none; b=cEVM6fPKO1DmhX+TdevXYc9w5spK+45c1xzboJVj4oVupoeVw5CAsqr54MTDpAqTfvd3NR6lSZzuZcx424hf3fnqiNhlQpMN/K4vAS8U9PJwBwrD9KJt6hAfzpCPa6mg9wCN8Yt3ASXlcfi8rC6b7JhQhceFzBTXd68w/fkOACs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720211655; c=relaxed/simple;
	bh=G1L0C8U/ich/c8si1qZJj2FlMJJkNnGECA0b4+0fdoE=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IRJ2GFfhtFdaJ++qRCvo9nwhYyHngsSV4koP2q62qtEHOnZBKPqdZKUTw316SrkQeUsGZRD6qWipdZphjGNnoW31LIDkKJQY8p69A3DTA57WLZy8dwOh/lXiBRukaeyoBfPdiMlFprnN7CKGLcms9jwpvStYEcoAPJ6zkY90KtY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Swe91Ly3; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Swe91Ly3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720211653;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZK3zEb6OM1FvG9zkt7Ge74a9nISNhiG2ihIuB/gnkog=;
	b=Swe91Ly3stUa+aRgqSlyFi4Ig6o9RS+aG7KVSsFF5xodYEQtRgbQqxcbuKs1oA64llyjQb
	w42a1QARR9WFgIymZzwTcr6XuckJ6rwA5lCCa9WENzRXjkeuZbjAMVZdVVreEwaJcG1UyC
	oX4wQXKPuh/Ew4PoTC0Lugpf3aMYC9o=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-44-eK_T7IYgOe-s4mvx6yKZAQ-1; Fri,
 05 Jul 2024 16:34:11 -0400
X-MC-Unique: eK_T7IYgOe-s4mvx6yKZAQ-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4CB9E195608A
	for <mptcp@lists.linux.dev>; Fri,  5 Jul 2024 20:34:10 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.45.224.16])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id F06461955F3B
	for <mptcp@lists.linux.dev>; Fri,  5 Jul 2024 20:34:08 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Subject: [PATCH mptcp-net v2 4/4] selftests: mptcp: fix error path
Date: Fri,  5 Jul 2024 22:33:50 +0200
Message-ID: <9cfbe0fdde1575741512eacc202a3f76062df1d8.1720211515.git.pabeni@redhat.com>
In-Reply-To: <cover.1720211515.git.pabeni@redhat.com>
References: <cover.1720211515.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
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
index 9c091fc267c4..55d84a1bde15 100755
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
2.45.2

