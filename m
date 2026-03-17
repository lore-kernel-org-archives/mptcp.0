Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ADE137186D
	for <mptcp@lists.linux.dev>; Tue, 17 Mar 2026 09:41:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773740515; cv=none; b=WB9PjK/Gs39APiNA12tePm3CuZCedQQw5bryOnscQs7YCFtdtCXltTgMFoTxQfnJ1sDUxtSCO/fmvEE9HsloR43VMF8/9gFCiSBgQBO4lS4gNiIwJFMs+mzAXP6YuYrzhDasD7cTkJ6wPSmTLfu3qFe6k1pz/lMZPZD/qxVo3JU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773740515; c=relaxed/simple;
	bh=z5fO9bg/cYr8m0HygbzqjuIVQBLBljSofvsf7SuMMWA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eXhpOOnxju/00uI4c5BZASVFARTREMPBot8sK751TR6AUbbEo9A1vlSmuKgqYZqTMm2mf3Au05cUh9+3KwcO+jitlTDlb0RiVfHtoRaDAaDaaiv0Ud5unLW7tlqpsvt2TPEi4T60rFOveWfAHKe3U1gAvzD6pu5CpBX2w3opiaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bcptMqfk; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bcptMqfk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E499C19425;
	Tue, 17 Mar 2026 09:41:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773740515;
	bh=z5fO9bg/cYr8m0HygbzqjuIVQBLBljSofvsf7SuMMWA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bcptMqfky20krL3bxqbAGug0mRAicuP8Dw8cdg1OqJtRqdXG0KyXSrH8OtnpOIcqy
	 JIXlr2w/ptLd5jv1IED/0JvX7BiHglObVZjAm6RzC7vb0wT370NK5GlSDTygu+5+gK
	 5GOX6kV9N6r5XuhNKvjnopl11VeZkqrQE/UOPwCTFdsHPSoqkXiCkKVwzI2QREPPlo
	 2q/QLYnossaTnQTkAs9oMhUESQRz7e2Y3w4aLvU0Ti6Gijxcf3ASSs6Zvl/e4M9t/W
	 kPQM+hfwOS04HAX7oPP80DuBA3RN2WTa2lOxYjeIQNPWUyjdsnoGyKpwIk40GaMqoV
	 KQYr6OxU1ZhXw==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [RESEND PATCH mptcp-next v2 3/3] selftests: mptcp: connect: trigger splice_eof
Date: Tue, 17 Mar 2026 17:41:28 +0800
Message-ID: <4e535245e10938fe4004b03fedb5f9f31b0be714.1773740361.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1773740361.git.tanggeliang@kylinos.cn>
References: <cover.1773740361.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

Increase the sendfile count by one to ensure the transmission size
exceeds the actual data length. This triggers the splice_eof path
in the kernel, allowing the newly implemented MPTCP splice_eof
interface to be exercised during testing.

The change from 'count' to 'count + 1' forces the sendfile operation
to attempt sending one more byte than available, which activates the
end-of-file handling in the splicing logic and ensures coverage of
the related MPTCP code paths.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 tools/testing/selftests/net/mptcp/mptcp_connect.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect.c b/tools/testing/selftests/net/mptcp/mptcp_connect.c
index cbe573c4ab3a..2aaf3ed11315 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_connect.c
+++ b/tools/testing/selftests/net/mptcp/mptcp_connect.c
@@ -870,7 +870,7 @@ static int do_sendfile(int infd, int outfd, unsigned int count,
 	while (count > 0) {
 		ssize_t r;
 
-		r = sendfile(outfd, infd, NULL, count);
+		r = sendfile(outfd, infd, NULL, count + 1);
 		if (r < 0) {
 			perror("sendfile");
 			return 3;
-- 
2.53.0

