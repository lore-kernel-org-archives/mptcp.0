Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 190351AE029
	for <mptcp@lists.linux.dev>; Fri,  2 Aug 2024 18:17:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722622679; cv=none; b=RGcsW/DPJxchBgGIXdjohOo8oJ9p0DhXzcn8rapS/q5OffOop7+ypmKjCePOcprRfxdXbgkkOgTNbVJcJPCRrT2S0J4gRdStDrUz/+CxHRhkt/VK3yC9QqKakSwseiJ82qlvLY9BShPVPNYbfOMlT22b7HbDZtAZxelCiLPAAf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722622679; c=relaxed/simple;
	bh=tf/wGOPhQYLV/T6rpzCr5ZuOds7ZUF/LJXfJO8rTvMY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mxS3irqfGTbHQQmwUV8z8rrcnNjbRg3sXcR1KuEIO6L1LrduCmgCuzGzLYa4noCGkAO3rh1b4Q/pyDKAsXgfQtDM2pW6AzQdB84AV4JpR0r3y7zJEHdEMKO+CZlH97YrS4FM7w7f4ZtNH9j9l5JsxDMrEu8iK6PVPU6+Gpvy5qg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E5FNJAyY; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E5FNJAyY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3ADBCC4AF09;
	Fri,  2 Aug 2024 18:17:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722622679;
	bh=tf/wGOPhQYLV/T6rpzCr5ZuOds7ZUF/LJXfJO8rTvMY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=E5FNJAyYoA6TUoBpxErtk/fvyXoJ6AM0EuOI38VkCZniOUbyT5TATGfgzSHlg9Xjn
	 FFu1p29Kvi/pQgaSXQywWn8OZ4S9RXh17Om34yRI1oDL4Tn+f9sV1nML7E4WV1ASgN
	 EA2QNCjPNR5tLOS6YQonx1+iPvHhFcHuV+aAS1/PaqiMVj0fqUMhX3rBREPULPJlCg
	 HIy8I+4yxKOgMDj5fydlwPyZnuWtAI1Zx+9LsUWR6UUixRx7Yfvmxhma8fOAoKGOdJ
	 WDdTO56AxMdDQwsoDkqJaebjD7oJE8S4wiowH8GTTn5FfrSl3rnCg1I9Tl4bf0T0jp
	 OY58fdchXUoBA==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri, 02 Aug 2024 20:17:45 +0200
Subject: [PATCH mptcp-net v6 08/11] selftests: mptcp: join: check re-adding
 init endp with != id
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240802-mptcp-pm-avail-v6-8-964ba9ce279f@kernel.org>
References: <20240802-mptcp-pm-avail-v6-0-964ba9ce279f@kernel.org>
In-Reply-To: <20240802-mptcp-pm-avail-v6-0-964ba9ce279f@kernel.org>
To: mptcp@lists.linux.dev
Cc: Mat Martineau <martineau@kernel.org>, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=2666; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=tf/wGOPhQYLV/T6rpzCr5ZuOds7ZUF/LJXfJO8rTvMY=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBmrSLLV4TPmUKAVIvLt4fw96WIi8sWP60NEXMBH
 ZzfZG0r04SJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZq0iywAKCRD2t4JPQmmg
 c6+kEADcEcXmGUVg3BNeI/x1Fe+CxutLqQ9VMDJvX9WNhO54YplJX/7HyKHiLlQo32vuy+1cK/g
 +VMfWdNb+rGkHifANM8AUE2VRrRByeHkTs886MEDzaC3MJ38LKeVIvJwDk09Z/B4sB782Cww3gu
 7KTcdooh0nBIbHx+W1gLa3lGSGOCV5PaCzIWedctE7L4NB64YeezwABxohm/88/1F5rtTJknif4
 VMY8XI1DVD4ttSrBY8XnOqJmJWukccSEKpd8SJ+59I7p2egNL/Ssntd3dWRkHkkoL5foEPC4KID
 SKMYfFQ9bWYhZEZOVKzjldVW8Z4NCBGQ8O0rPBBU3s8dDDEC6Lb8JC8N7xQ/EzO4qWBIjUlHDRq
 SIyQv9G8hEB8zY0YqmHBKM8rh+gTJ2LzM6Xo5xoEQDlE269BwwpotWEcFx1xv8VJyivazPKYctr
 fcuopu+GTM+GZIjqlckUpUZ8xLUUBjhoa3J7a8QrSUCPXGUheYr8wBmKSmWl3SNL6CyrHaZJzmf
 syph/oA3gxHpNkIms43SiYF/uMI+OL1nHFe1q4rAuDDBKWl+A8FOvO4pWn1ayp02/9W/GQnlR6x
 Jmo8UX+E+fzMVDRjiFHHV9hQQB1nTf+fezq0qeifAnD6gGlfaZRWZOliiF/363q7/FKdJdPcMCF
 n/OR9YI6aA/8aTg==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

The initial subflow has a special local ID: 0. It is specific per
connection.

When a global endpoint is deleted and re-added later, it can have a
different ID, but the kernel should still use the ID 0 if it corresponds
to the initial address.

This test validates this behaviour: the endpoint linked to the initial
subflow is removed, and re-added with a different ID.

Note that removing the initial subflow will not decrement the 'subflows'
counters, which corresponds to the *additional* subflows. On the other
hand, when the same endpoint is re-added, it will increment this
counter, as it will be seen as an additional subflow this time.

The 'Fixes' tag here below is the same as the one from the previous
commit: this patch here is not fixing anything wrong in the selftests,
but it validates the previous fix for an issue introduced by this commit
ID.

Fixes: 3ad14f54bd74 ("mptcp: more accurate MPC endpoint tracking")
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 tools/testing/selftests/net/mptcp/mptcp_join.sh | 21 ++++++++++++++++-----
 1 file changed, 16 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 03d92852de8c..ea954ba85969 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -3599,11 +3599,12 @@ endpoint_tests()
 	# remove and re-add
 	if reset "delete re-add signal" &&
 	   mptcp_lib_kallsyms_has "subflow_rebuild_header$"; then
-		pm_nl_set_limits $ns1 0 2
-		pm_nl_set_limits $ns2 2 2
+		pm_nl_set_limits $ns1 0 3
+		pm_nl_set_limits $ns2 3 3
 		pm_nl_add_endpoint $ns1 10.0.2.1 id 1 flags signal
 		# broadcast IP: no packet for this address will be received on ns1
 		pm_nl_add_endpoint $ns1 224.0.0.1 id 2 flags signal
+		pm_nl_add_endpoint $ns1 10.0.1.1 id 42 flags signal
 		test_linkfail=4 speed=20 \
 			run_tests $ns1 $ns2 10.0.1.1 &
 		local tests_pid=$!
@@ -3625,11 +3626,21 @@ endpoint_tests()
 		wait_mpj $ns2
 		chk_subflow_nr "after re-add" 3
 		chk_mptcp_info subflows 2 subflows 2
+
+		pm_nl_del_endpoint $ns1 42 10.0.1.1
+		sleep 0.5
+		chk_subflow_nr "after delete ID 0" 2
+		chk_mptcp_info subflows 2 subflows 2
+
+		pm_nl_add_endpoint $ns1 10.0.1.1 id 99 flags signal
+		wait_mpj $ns2
+		chk_subflow_nr "after re-add" 3
+		chk_mptcp_info subflows 3 subflows 3
 		mptcp_lib_kill_wait $tests_pid
 
-		chk_join_nr 3 3 3
-		chk_add_nr 4 4
-		chk_rm_nr 2 1 invert
+		chk_join_nr 4 4 4
+		chk_add_nr 5 5
+		chk_rm_nr 3 2 invert
 	fi
 
 	# flush and re-add

-- 
2.45.2

