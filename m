Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07F0953804
	for <mptcp@lists.linux.dev>; Tue, 19 Mar 2024 08:13:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710836022; cv=none; b=iOaEnD9aSXb8gwu8bBy503ZI7dxWWsAyGa+0H97jrCHRzq6VzSpy1c8wPBUEWfmVEpVZGocvcGBhwExHdIQFB+RjU7BuelPNl0o9vl2UVsTPPHTtrzkm2Nj6Lkynyh49rqYdityxpzmegegRSII7K+nWNSCkAtq8se3eoU9k8sU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710836022; c=relaxed/simple;
	bh=59qDRR1DBckDHBEHJOVy+JahhKimOxbxR9i8VIXw/js=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Q0vqbVVRmy2sU3Xgp9cP/VmaQjlQVrh/yK8dncHOGSc201CnEYVZ2N9uuB9o7xjCtC8TGkuWUb2JH1+mYQ4hJk5MzVWiyjbCTmYIHSIJod93qy2c1vedlULP+m25uvBMw8heHpUHAK3zi24l6HuZaF3E1qkcF01nCjNjnEan1+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l2BRPcjA; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l2BRPcjA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 748A6C433C7;
	Tue, 19 Mar 2024 08:13:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710836021;
	bh=59qDRR1DBckDHBEHJOVy+JahhKimOxbxR9i8VIXw/js=;
	h=From:To:Cc:Subject:Date:From;
	b=l2BRPcjAUnooFiWNLLXoSpmuGdJ9soABuc4G5YEOmWsyhU1mkpQFriEUTnIjF+Dy9
	 cNcY92Fcsfu3G+3rd75nei/u0oUted1VNiKRkh5+p+4Lq6BRMUsVlI6TAbl9M/lg0n
	 s6sjlhYGdfJi/SAjaKuAlKc3K8LhZYAZF9xJUN/WaHQfF69NeckJkEsCq/Egb4qDma
	 EppSqM87wOI47QlBUO0z/J2zUiPSXohtYc8j/6wZ5r0v/xNKT7Lm7od87wLiaKA5nl
	 qsPFh6VelP8jC3SavzQ2PCnyOM0+c3c/J1lkCIvFLiQcevTBA49iHv7FXpCTqvr+nl
	 M18Ar6kt+py5Q==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next] Squash to "selftests: mptcp: add get_endpoint helper"
Date: Tue, 19 Mar 2024 16:13:35 +0800
Message-Id: <1babce1397309da3dd9f581b9c4ee846fff23a36.1710835995.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

Fix shellcheck errors.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 tools/testing/selftests/net/mptcp/pm_netlink.sh | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/net/mptcp/pm_netlink.sh b/tools/testing/selftests/net/mptcp/pm_netlink.sh
index 155847c720cf..2757378b1b13 100755
--- a/tools/testing/selftests/net/mptcp/pm_netlink.sh
+++ b/tools/testing/selftests/net/mptcp/pm_netlink.sh
@@ -71,6 +71,7 @@ format_endpoints() {
 }
 
 get_endpoint() {
+	# shellcheck disable=SC2317 # invoked indirectly
 	mptcp_lib_pm_nl_get_endpoint "${ns1}" "${@}"
 }
 
-- 
2.40.1

