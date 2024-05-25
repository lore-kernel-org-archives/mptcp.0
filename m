Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13AD7125DC
	for <mptcp@lists.linux.dev>; Sat, 25 May 2024 13:02:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716642141; cv=none; b=pAqkV4zW3po0OVZ36qzPZ1enokIXvj08IEWOBqY3DfRFzPrcnxxdu53R+t3OUDjTbBGJTaxuUUYHyH2NNglnuf1Vag+YtbDQEatyANB+R1tMFH+83/f393JhWp71c9WJcobp6fm0aJtsD95fbBvjZaOZDuEPS4mP/Sxqvo8XWuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716642141; c=relaxed/simple;
	bh=sqRT7u1zqCVp77hX/dnok3dYjaU3tkuOKGGNWeA0Ri8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=c5i8kvu932uyDTfwfpceNWJnE9dT8L/OkOeUs8AnLlLzInGEV8SSz2rZsYs9Q8PD1Et96V3bPim2brYtmM3cSN2eTEe7rQ1P6XnfZLFFS9YkJPoMXeLJ0mdAdM0wO+52a9im15R9Qzga/bcAQETy02TAqdr2noXG6nPFgpegvkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OIDPLRpd; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OIDPLRpd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29C7CC3277B;
	Sat, 25 May 2024 13:02:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716642140;
	bh=sqRT7u1zqCVp77hX/dnok3dYjaU3tkuOKGGNWeA0Ri8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OIDPLRpdcULrgPiecnEVCkwUdBimA3X305gVy3i9SNZISmI3X+Zo8CBCsOUMERmoi
	 X8n4rcz1dQyouUlBGNTILV9jQOk0xXFPzHGGUmcLylh8Y/UCnIomZAwhZqKPmiDcHH
	 7scusukjIYRnM4Ggknwu3tf80RyKbd97GIVQ29kPyF2NYpnGQZ7/m+o8VRk0IZ5afr
	 NJHa029fCa1NBiaXiXA9U/EDUAHg0srLn4bEheptybYSGxxS6hmG1zLioM8wLHP1ZZ
	 ng8rSIsbQJqzskxFoB77UU4T5/gQRZ/iOR/FJ8ROOpNbrRVRzh0xlE4at1FQX0VRcG
	 PINfoZ4qJgztA==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next 4/4] selftests: mptcp: join: print title at the end of reset
Date: Sat, 25 May 2024 21:01:25 +0800
Message-ID: <7dbbb909edef2fecc46bde435fae21be6bc9ed81.1716641976.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1716641976.git.tanggeliang@kylinos.cn>
References: <cover.1716641976.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

init or init_partial may fail sometimes, in that case, titles shouldn't
be printed out.

For example, these errors occur when invalid name is set to setup_ns:

    001 no JOIN
    Failed to setup namespace 'ns_temp': invalid name

"001 no JOIN" shouldn't be printed out in this case. So the patch moves
mptcp_lib_print_title from the front of init to the end of reset().

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 tools/testing/selftests/net/mptcp/mptcp_join.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 2b66c5fa71eb..d20a053eee8f 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -269,8 +269,6 @@ reset()
 		return 1
 	fi
 
-	mptcp_lib_print_title "${TEST_NAME}"
-
 	if [ "${init}" != "1" ]; then
 		init
 	else
@@ -279,6 +277,8 @@ reset()
 
 	init_partial
 
+	mptcp_lib_print_title "${TEST_NAME}"
+
 	return 0
 }
 
-- 
2.43.0

