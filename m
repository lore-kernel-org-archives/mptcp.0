Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33FA21ADC93
	for <mptcp@lists.linux.dev>; Thu, 10 Apr 2025 17:32:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744306375; cv=none; b=mqDkRZkVbo9tAW5AMJBXRvxkLBhKFwOv+UKvem1QBknsYVB6iutvpc6pJfVo9HxoIWFL5aalt26oBIBYvx72p1CF9swhfQmz+qWZylCHKILruTUc3slfCvIt0glOWIlxlCqU++kwRaC8zMrSFq2Xhe5Sx1jUAN+nozr7AAV811s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744306375; c=relaxed/simple;
	bh=IrcjIVVIBJEs6u8DMeJXB/YByEVF+TjlKGKncBnT+vw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=d+BFEfc366mAPwuxcBfxf2sAe6dsTw4wFGO0T0yL/+z+Oaua63HEM7ScKm/fY4w8ajnA1+F1ptAkr+DSCGZRQqMfc8Nd3I7sDu5zkU/1pygC4tEU/TBgTM2kb4h0QuLinv0IvtQyEP4iP17fhBzUcqxLmZO1UfjZVASi6Ipk9rs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Grzu4tsw; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Grzu4tsw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3BDE8C4CEE8;
	Thu, 10 Apr 2025 17:32:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744306373;
	bh=IrcjIVVIBJEs6u8DMeJXB/YByEVF+TjlKGKncBnT+vw=;
	h=From:Date:Subject:To:Cc:From;
	b=Grzu4tswyNBR7MD4wImY0eWBdG0tzIagNL877DevatgSKQtu+c6kSmvvUWEIJediJ
	 vbFeLOTWhrI5+wMVzZ7nSl5EYNQWeCE5wth4eMaMOsuSgC8ZKfhuvbDpW4HmqJjGxM
	 fVW9mwKgHgagMOAday4yNvooMsKNcgFnMv4Ds6TWjBHktXo2WArIf6+y3Aa7RJnAAQ
	 spPEBQXxyhUYH5kCSvpxFCEVio+XloRHgdmgyfp4/fxs2m1JFfcVRN9ovnpAV2YAaK
	 VEcmBpvqEUda9P6Tj3h0wgWNeNzsKtg46j/Peqgbx2xY8984wqMRmAkcYusimI4FoL
	 82Er4Cj5kE6Rg==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Thu, 10 Apr 2025 19:32:05 +0200
Subject: [PATCH mptcp-next] selftests: mptcp: info: hide 'grep: write
 error' warnings
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250410-selftests-mptcp-grep-close-v1-1-3c360279a856@kernel.org>
X-B4-Tracking: v=1; b=H4sIAJQA+GcC/yXMQQqDMBBG4avIrDuQSLpIryJdpPHXDmgMmVAE8
 e4Gu/zg8Q5SFIHSqzuo4CcqW2qwj47iN6QZLGMz9aZ/GmcNK5apQqvymmvMPBdkjsumYA8Xov8
 4G7yjNsgFk+z3fKB/nbBXep/nBd5280d4AAAA
X-Change-ID: 20250410-selftests-mptcp-grep-close-9e4ac9b41a94
To: mptcp@lists.linux.dev
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1854; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=IrcjIVVIBJEs6u8DMeJXB/YByEVF+TjlKGKncBnT+vw=;
 b=owEBbQKS/ZANAwAKAfa3gk9CaaBzAcsmYgBn+ADE3ePZamrWIiK0DVF9w75a9WHLXR2HZEZcY
 qm+ZOk8p+6JAjMEAAEKAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZ/gAxAAKCRD2t4JPQmmg
 c/RdD/9usX+4qvOhA0eIhf2byiwPvIgi4iOSCqOsmdP8RONySHV/aSZfVBm/EFbEjKzbWpsObIJ
 lCrHuSv46NQi85hFOeOGvkDptKFHv09jJodxweZ+QRmARY/eQEDwoaJgUES7HxwhtuixracdTrs
 fQOxCaf3u5Z0CBvxnOuO8QEYilnus97ZZsJ2EdZiAdfC27v3sEtxLkAjFvCfFgaasaROmTPJ6JF
 pduha1dOYJJm+epkyqYXKcwUEVIb9ZuBKU9Wii5q7V1rqmXtV11+Dz3htdLqQZZD0Y4W9as9wMW
 zZbBLC5sIPpj9xWs2xqq25RSaMNs9aEcovIUu729sVnQ+5/Bf8io4SrUc1AiWKdgngC2taXZm3h
 FqDNtnx487qvHG3tCwsf9DcYfwiiLunwIDytDXcE7Eik9GKGR8qkQRHDdeO9H9EZTHWIi9rK1Lh
 hevnfwoSH8Y2YIJ7RmXKoo3FgtXcXFcplxJNkdzjLR556yKVi0zLizz+R3a4Mqb0MTFSG8OqtpI
 WBC/IxVCIVwW3Q2ya2DL27bR5G1EnNi7bqsPMS1CffJELiwCC/5NBQee1iHOfKgZZ5V/Anjnhsc
 Em4IQfY2vGJ35aapveCHpcPCsYQeIAftsaQMhYD1MIgIYUC5MaC8Uk6LeqolGtyNrtPQuPCpITJ
 1WygH2LyYuLHm3g==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

mptcp_lib_get_info_value() will only print the first entry that match
the filter because of the ';q' at the end. As a consequence, the 'sed'
command could finish before the previous 'grep' one and print a 'write
error' warning because it is trying to write data to the closed pipe.

Such warnings are not interesting, they can be hidden by muting stderr
here for grep.

While at it, clearly indicate that mptcp_lib_get_info_value() will only
print the first matched entry to avoid confusions later on.

Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 tools/testing/selftests/net/mptcp/mptcp_lib.sh | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_lib.sh b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
index 051e289d79676c5feb9f46da67a08116548f4b47..99c87cd6e25563e220263c813223206ef6f4b311 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_lib.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
@@ -331,12 +331,15 @@ mptcp_lib_result_print_all_tap() {
 
 # get the value of keyword $1 in the line marked by keyword $2
 mptcp_lib_get_info_value() {
-	grep "${2}" | sed -n 's/.*\('"${1}"':\)\([0-9a-f:.]*\).*$/\2/p;q'
+	grep "${2}" 2>/dev/null |
+		sed -n 's/.*\('"${1}"':\)\([0-9a-f:.]*\).*$/\2/p;q'
+		# the ';q' at the end limits to the first matched entry.
 }
 
 # $1: info name ; $2: evts_ns ; [$3: event type; [$4: addr]]
 mptcp_lib_evts_get_info() {
-	grep "${4:-}" "${2}" | mptcp_lib_get_info_value "${1}" "^type:${3:-1},"
+	grep "${4:-}" "${2}" 2>/dev/null |
+		mptcp_lib_get_info_value "${1}" "^type:${3:-1},"
 }
 
 # $1: PID

---
base-commit: 244c301d3de6bf2e1bdc5cf7291159cd8e342942
change-id: 20250410-selftests-mptcp-grep-close-9e4ac9b41a94

Best regards,
-- 
Matthieu Baerts (NGI0) <matttbe@kernel.org>

