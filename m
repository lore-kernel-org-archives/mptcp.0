Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 683792D60C
	for <mptcp@lists.linux.dev>; Fri, 24 May 2024 03:11:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716520319; cv=none; b=Ngdc0ya+Era0CTtTo2DUgr6aA1LyDu5q1WITR6sUYHmq/sDGeQQgNMZyaI3zcG/xhs27uIej7tC7fNTkrave0wHsQt/hsDd5Yfqy1/4s4OWTfEpdzUqseGEqBDYWudAu5Eg23PZ5pkNcrJlv1Nt7JMZ7B/A5rjXwstnaTgKGLuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716520319; c=relaxed/simple;
	bh=G1zdUXQnjhKWktScdIwlRJiKgpfmFt8uQbBKK3oanzI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cIkcJ5UjuzyOye1kCVBN1Jd8J6ztTk028e1UVwnMgB/jhgntvb62X73QgSzBIoYUyBBrhVrt9GY1b2DZ2IMGyLw5z7m4hsD76KayCGjLgnpkSqITlqrpwfE/UjxdHiTeMqypTqelXTZAj/6pxagTGCxS3hnuvB9prsOxG86WYbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vRLTIwXZ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vRLTIwXZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C090C32781;
	Fri, 24 May 2024 03:11:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716520318;
	bh=G1zdUXQnjhKWktScdIwlRJiKgpfmFt8uQbBKK3oanzI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=vRLTIwXZk8V6rMRi6pZYpTM2n3iagM4+IH8bYu70x7Q29Q7mqME0At5mRe4LOBx0i
	 wL5bF/pOoO9DvIjn6HyA/mGpsm0ASvv/m8Jw2rmQ/fnZyqStcZsBsPZK6ujAtS14I6
	 LxsuNmSeXZPGJIvsfKQooUe1GqBLXUbevjc4wEJn9IvwlRzV1MHEzsH5cR8ozj0uv6
	 uBfwmIF28iqJ80ueGkYlKn+Kw02Vcs6mHQlvYQsz1KCfNIWPkSUrtzUUWeasroUdIu
	 ckYuyyIvkP1tCJTojRM2betFKeePM0Z7qh8XbWvJvPZrbvHPR09/QFouBSTVD8bX7R
	 Rl8TuEsfWqnKw==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v3 2/4] selftests: mptcp: rename ns to _ns in get_counter
Date: Fri, 24 May 2024 11:11:47 +0800
Message-ID: <da87781342367165e02fe6501cca46a8f2a92cf1.1716519897.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1716519897.git.tanggeliang@kylinos.cn>
References: <cover.1716519897.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

If "setup_ns ns" is used in diag.sh, it fails with errors:

 ./mptcp_lib.sh: line 289: local: ns: readonly variable
 13 ....chk 2 cestab                                  [ OK ]
 14 ....chk 2->0 msk in use after flush               [ OK ]

That is because "ns" is also a local variable in mptcp_lib_get_counter.
To solve this, this patch renames it as "_ns".

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 tools/testing/selftests/net/mptcp/mptcp_lib.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_lib.sh b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
index ad2ebda5cb64..16aa080c8229 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_lib.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
@@ -286,11 +286,11 @@ mptcp_lib_is_v6() {
 
 # $1: ns, $2: MIB counter
 mptcp_lib_get_counter() {
-	local ns="${1}"
+	local _ns="${1}"
 	local counter="${2}"
 	local count
 
-	count=$(ip netns exec "${ns}" nstat -asz "${counter}" |
+	count=$(ip netns exec "${_ns}" nstat -asz "${counter}" |
 		awk 'NR==1 {next} {print $2}')
 	if [ -z "${count}" ]; then
 		mptcp_lib_fail_if_expected_feature "${counter} counter"
-- 
2.43.0

