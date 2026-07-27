Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A5BE42D74E
	for <mptcp@lists.linux.dev>; Mon, 27 Jul 2026 17:22:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785172938; cv=none; b=o7ugbhbu+0NWA4YrE5mBBC7xeuKRdvowB9qROhU79hYMU8kSVw1dlk3s/6qEGAp7e8vWKciuXQO0jVU7kBA5MxnOv8NL1BbGBLxGo82jjlCm3Zi+/Bc+K/0JWBJBk6IlTWp5IhqzzXIJl0lQxQta+4JefXKyEQA6j6K8yvN5Y/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785172938; c=relaxed/simple;
	bh=1l2BrGr9D/QMBsvEatr2e8K8+KHsAP3MHOIJ7Ihr8S8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jkWtZyI4iIhGiey1oQ+hNHElgFdChauMnYkQAywJ8JH9lfLl0hdYAasYUUnHDjErAzUNciyFpcJkwoFI44xDUlGPPFFyV1kzQx0hXKHpwpSdD8Z0JFMMy6uziNXlf+09fO1cCmpDHRuwJNEfmtrh0SiHE7CWT8Uv8iW6h1qcwKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I4zmWUNr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I4zmWUNr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 712DF1F00A3E;
	Mon, 27 Jul 2026 17:22:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785172933;
	bh=sHPVh6MsIT/s+4EMlZhmg8CEKL4NWWGYMsxIK5TzmKk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=I4zmWUNrBot5vwTOJ5+yujBjD2lDMkRLwRkMg7uRJdbIzqSonf5idY6X7fbERvptr
	 P87AlXV/WOedtdOYrMDAb3adX3C68UAkrcXGYChs83OvVF/g15f/CcPwRleVcoiaqn
	 wW/dQ9jfJXkmZBNxfrI0u9JwGWdh63g/i5mYeub8yzrphUpk5pXzEQld/YoqXxb8vk
	 pAxWjh2xQEqaHF3+CQtPtmit+be1wAKkJBdi/+utdsjcUig/22l8RrMoz5dFtF5St6
	 +YZIrC6Xhzof5v4C0WRy+Gwx8fia5SU5BGvMF9ATlJxWHr5i/yvaY6skLTLKuhcxuC
	 jAg2AWwNnmfPQ==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Mon, 27 Jul 2026 19:21:54 +0200
Subject: [PATCH mptcp-net 5/6] selftests: mptcp: join: new ID0 subflow from
 the right IP
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260727-mptcp-pm-userspace-id0-case-v1-5-9877f02a9bae@kernel.org>
References: <20260727-mptcp-pm-userspace-id0-case-v1-0-9877f02a9bae@kernel.org>
In-Reply-To: <20260727-mptcp-pm-userspace-id0-case-v1-0-9877f02a9bae@kernel.org>
To: MPTCP Linux <mptcp@lists.linux.dev>
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2087; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=1l2BrGr9D/QMBsvEatr2e8K8+KHsAP3MHOIJ7Ihr8S8=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGLLSJ++bWNOqf+sYg9XfhB2m6Q9Uwk3eqN2e3j/93plfi
 6KXnDc70FHKwiDGxSArpsgi3RaZP/N5FW+Jl58FzBxWJpAhDFycAjCRO/8YGfZvVJX8ckH7pFp/
 fUHasi+6XBW6Kn9VT/qKzgsuLP12+C3D/0S3Ekb/V52yzO0KvkxXZT6kB7JLNG38UDbXdP81B78
 iPgA=
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

In MPTCP, the local address and port used by the initial subflow has the
ID "0". It means that when this address and port are used for some
operations -- e.g. creating a new subflow -- they should be linked to
the ID0, and no other addresses and ports can get this special ID while
the initial IP address and port is used.

Hence, this is not correct here to try to create a subflow with the ID
"0", but from a different IP address. With the first patch of this
series, this action now returns an error.

Instead of simply using the right IP address, continue to also use the
wrong one to check that the kernel is correctly not allowing the
creation of an ID0 subflow with the wrong IP address.

While at it, fix the dumped address: the initial address is not supposed
to be dumped, similar to what is being done with the in-kernel PM. So no
"extra" addresses should be printed there.

Fixes: b2e2248f365a ("selftests: mptcp: userspace pm create id 0 subflow")
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 tools/testing/selftests/net/mptcp/mptcp_join.sh | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 2413c832af03..0dc81eeb0636 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -4143,10 +4143,11 @@ userspace_tests()
 		wait_event ns2 MPTCP_LIB_EVENT_ESTABLISHED 1
 		chk_mptcp_info subflows 0 subflows 0
 		chk_subflows_total 1 1
-		userspace_pm_add_sf $ns2 10.0.3.2 0
+		# from an IP not linked to ID0: failure expected, no new MPJ
+		userspace_pm_add_sf $ns2 10.0.3.2 0 2>/dev/null
+		userspace_pm_add_sf $ns2 10.0.1.2 0
 		wait_event ns2 MPTCP_LIB_EVENT_SUB_ESTABLISHED 1
-		userspace_pm_chk_dump_addr "${ns2}" \
-			"id 0 flags subflow 10.0.3.2" "id 0 subflow"
+		userspace_pm_chk_dump_addr "${ns2}" "" "id 0 subflow"
 		chk_join_nr 1 1 1
 		chk_mptcp_info subflows 1 subflows 1
 		chk_subflows_total 2 2

-- 
2.53.0

