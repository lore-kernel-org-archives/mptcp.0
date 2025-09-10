Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7425B2AE99
	for <mptcp@lists.linux.dev>; Wed, 10 Sep 2025 08:57:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757494638; cv=none; b=SddgT5yTC2xbzxww7TBhhvRTyaNVAr2eeW2yv4IlVfhtjUSDi3sxl7h6n9fWm72TCV+vLaK4yNA/igZ4YjtwBrKZ4l43eJWVzbD4+EGzHqReGv2RFyNE9Pu+G+Oxn+y/I9DJfcZHGtlRKtmtcicGUP+W9d+KHq+/uLS09RrumWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757494638; c=relaxed/simple;
	bh=i7361sApF7zHr7JlkvivSn9yNsYsSA3QDBkFh+4Jc8g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=K28x2bhOhtN1wdeYfxVtAAP38HUR7TV8wMaxPjVZGW7nbeXSOEwWg/OMV5Jocd6qI+fRUGchxzM4rsIKcOylVzvaeQ4BbCBgDV3JjUiXmJQNeE0LQML8RFqc1Kwo0kNMKVJNzJgnHkVan18txiYOhRXWYqk+G/xwH+dkA4CoZYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ue0SC3Q7; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ue0SC3Q7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E6D6C4CEFB;
	Wed, 10 Sep 2025 08:57:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757494637;
	bh=i7361sApF7zHr7JlkvivSn9yNsYsSA3QDBkFh+4Jc8g=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=ue0SC3Q7d41fTM7709vNKOrd7HeeyeKQqzc18ZiqLHMBKvtcOXiF6rN+2bNrtusOk
	 zetPUi2AENN5xfUmle38RXh7lvKR3elCTn3kn6hQEuEjiC6l1mVzusECJT5VjMgxeS
	 931DgHiEJ0aDRHRdkFrmPSCBzPH4URvpqROdVMpX4BdGmnShu1C5KrjMLa5M6o+LnS
	 8eOY6pJbvxbpnWQVsqcmSA+3Z3f4pb/53bl9f8Q1Nvovme/xkVCL0y6jr1eS2HZf8z
	 PwZWBBYLUwy41airo8sT+1An/9tq6vfAOAUIAazAW+CU+t5+kdr83ykbwYvauEv+yD
	 vY6bwo+d6QM4A==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Wed, 10 Sep 2025 10:55:50 +0200
Subject: [PATCH mptcp-net v3 4/5] selftests: mptcp: print trailing bytes
 with od
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250910-sft-mptcp-disc-err-v3-4-6799fa467d77@kernel.org>
References: <20250910-sft-mptcp-disc-err-v3-0-6799fa467d77@kernel.org>
In-Reply-To: <20250910-sft-mptcp-disc-err-v3-0-6799fa467d77@kernel.org>
To: MPTCP Upstream <mptcp@lists.linux.dev>
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1412; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=i7361sApF7zHr7JlkvivSn9yNsYsSA3QDBkFh+4Jc8g=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDIO2qbXFUpLLzxmMfnGj+WzGxgd+5uS37fs+Cyb8teU2
 SJ065blHaUsDGJcDLJiiizSbZH5M59X8ZZ4+VnAzGFlAhnCwMUpABNpymZk+GTOsMr2PHvJV5cS
 5Y+eJV/UtVYuvsWX/n7Nog/CK48ozmRk6PdoWFdoXLu4RUFO/PHZE6ozCuT3cvkpaNwpkTthua+
 CFQA=
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

This is better than printing random bytes in the terminal.

Note that Jakub suggested 'hexdump', but Mat found out this tool is not
often installed by default. 'od' can do a similar job, and it is in the
POSIX specs and available in coreutils, so it should be on more systems.

While at it, display a few more bytes, just to fill in the two lines.
And no need to display the 3rd only line showing the next number of
bytes: 0000040.

Suggested-by: Jakub Kicinski <kuba@kernel.org>
Suggested-by: Mat Martineau <martineau@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
v2: switch to 'od', and no more check for its presence (Mat)
v3: mention there are more bytes (Geliang)
---
 tools/testing/selftests/net/mptcp/mptcp_lib.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_lib.sh b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
index 09cd24b2ae466205dacbdf8289eb86c08534c475..d62e653d48b0f2ef7a01e289fa0be8907825667d 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_lib.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
@@ -384,7 +384,7 @@ mptcp_lib_make_file() {
 mptcp_lib_print_file_err() {
 	ls -l "${1}" 1>&2
 	echo "Trailing bytes are: "
-	tail -c 27 "${1}"
+	tail -c 32 "${1}" | od -x | head -n2
 }
 
 # $1: input file ; $2: output file ; $3: what kind of file

-- 
2.51.0

