Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC8A4A923
	for <mptcp@lists.linux.dev>; Tue, 13 Feb 2024 04:14:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707797682; cv=none; b=Vreuhr9yVSeaWIEtY03pmksEDCaQLVppghPgnawV3wp0iKS48pPQ4Sp3hOxee40u1JJNJYh+bU7WDuNrE2VyWk/sL7UJSLTOZFEzOI4ELPe36a10WFj2fwYzdgqd+rWbP6TU9l9rstE6ON4fvNkznuXgNv0NXEp804VR3kFFt38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707797682; c=relaxed/simple;
	bh=3BsDj69c+6JGJClU6Gt7cE7AFv3uJrGBrc61MwrVxwU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Eznay8oWiwan3rFpmPvkmqTu4pAb+3EbEglFk6+qRhfzlgxaoEOjIjZDP7Vl0TNC974g8Wche5KavOjFwKHg8aeOtR4LzVsxahkm5ChPlXyUsUnDPzbHdy6nCSBdLmeXVYCvOchzrYkZ1AmvIpaGts0ssYB1BdftRjOh9UNM0PI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=utBMwWIC; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="utBMwWIC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92242C43394;
	Tue, 13 Feb 2024 04:14:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707797682;
	bh=3BsDj69c+6JGJClU6Gt7cE7AFv3uJrGBrc61MwrVxwU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=utBMwWICe4ZGqaKRCodpwtrdtbHow2zmy1/CEnr6DrNXXkw4VVhHivIabnMZ7XSzm
	 d3GVpOXSOd3F0W0lnbs+JRpmsvzmQ0aLeFkBdMqg5R/6VsVXY5lSqptWqPBXZVRnrg
	 3bGhY/I7+iEHfN3CVN+h9QOlQz6V8zbP6Qw1tpK65ITHLLeQMV1olDkpLay2d9J1Fk
	 ftFralf4X9ds+S/5uMsighbVA+4aExxGI6inAwwsIJRHG+TSl/OGr189re5rv4ovtW
	 vEQvvq5euCGcVvJsKFcflPdru+99YUknFFvFKc3IrNV7xRBTDH/gmV5xpc6e4wT9Bc
	 1NLtMljBc1hCA==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-net 2/5] selftests: mptcp: simult flows: define missing vars
Date: Tue, 13 Feb 2024 12:14:25 +0800
Message-Id: <daf8c52d209822d296ee64c2485ee4d4bf14d176.1707797566.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1707797566.git.tanggeliang@kylinos.cn>
References: <cover.1707797566.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

The variables 'large', 'small', 'sout', 'cout', 'capout' and 'size' are
used in multiple functions, so they should be defined as global variables.
This patch redefines them at the beginning of simult_flows.sh.

Fixes: 1a418cb8e888 ("mptcp: simult flow self-tests")
Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 tools/testing/selftests/net/mptcp/simult_flows.sh | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/tools/testing/selftests/net/mptcp/simult_flows.sh b/tools/testing/selftests/net/mptcp/simult_flows.sh
index 619be0e1acf5..3a003d47fccb 100755
--- a/tools/testing/selftests/net/mptcp/simult_flows.sh
+++ b/tools/testing/selftests/net/mptcp/simult_flows.sh
@@ -16,6 +16,12 @@ test_cnt=1
 ret=0
 bail=0
 slack=50
+large=""
+small=""
+sout=""
+cout=""
+capout=""
+size=0
 
 usage() {
 	echo "Usage: $0 [ -b ] [ -c ] [ -d ]"
-- 
2.40.1

