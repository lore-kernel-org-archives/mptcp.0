Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF91C130E32
	for <mptcp@lists.linux.dev>; Thu, 22 Feb 2024 16:28:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708619298; cv=none; b=LkfWRTsCxcZa4uadsbLL204YG7qu2YUtoG0sNmL0Vni6LmcABLWlJquEkY3dpyaG6XgN4nyx+5F7use0Q5PQMiMEOH8YlfCjpFyzx2I/7yMMfoz6lAU97qGr9aLdnaKU/An9KLs5zAD7xdIs8Js16BKWTrlq8iR/oI6WB6IL+G4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708619298; c=relaxed/simple;
	bh=7wfBIsDFKLIhv3WQTuiEJmSuIVeZe6lt8rHgoUmQ+uY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=klWBw6HZSOfxW0krGTWcS9YNqy86/2qrmKZl7x1kYUNlWaVmnpqMHJQ5Azpj1iEh0JQdCplQo3crwYviJ1PV9puak6kpHnMRJOZYl2a+at8OOIGD6IdVY3N2AITn44SehJhQnO7SHZ9f7Ke+rwu/e80GN46KOoKC70wWGS2BNyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qMAND7RQ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qMAND7RQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E205CC43394;
	Thu, 22 Feb 2024 16:28:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708619297;
	bh=7wfBIsDFKLIhv3WQTuiEJmSuIVeZe6lt8rHgoUmQ+uY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=qMAND7RQOwQFS9megKK/mICD7vj9NZDIIo+Vq392s9XQvi9xfPP4zqRiX62pUfk5y
	 0CoXYOTnU3GuodrYA08wdr/4RjmYgOMMpDaFzvxeLNqyDJWNSrVkpRlXaibj0Iobch
	 HGK8abpLj5j0EArr+z53noA6wpvC2D6J8rnYonqvAf80mTu7AAz6bUg81fGjDfxG7R
	 6gtKdn0xxsY8IPwc/CbJzE8qWRbDxEPnv4HD6Fb/bTpVyoQC0zCeW7D7Knit7znq9s
	 +GUKpmKPu6rZsxmSsQeVaoZlTU65NXG5wXE0rmbJn8H2NxTdjbN2hiRt4MmENByiym
	 PaSa6cACI1j7A==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Thu, 22 Feb 2024 17:28:02 +0100
Subject: [PATCH mptcp-next 6/6] selftests: userspace pm: avoid relaunching
 pm events
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240222-selftests-mptcp-shellcheck-v1-6-fed8ba9e6ca6@kernel.org>
References: <20240222-selftests-mptcp-shellcheck-v1-0-fed8ba9e6ca6@kernel.org>
In-Reply-To: <20240222-selftests-mptcp-shellcheck-v1-0-fed8ba9e6ca6@kernel.org>
To: mptcp@lists.linux.dev
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2381; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=7wfBIsDFKLIhv3WQTuiEJmSuIVeZe6lt8rHgoUmQ+uY=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBl13YaV77N1aP4xvm1POf2HwxjWfYoe7AjE/Y4h
 +wjdaWuYsCJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZdd2GgAKCRD2t4JPQmmg
 cyIgEACdhujqEsSW6yus+CBdH0QgsM8gvU0U8PCKJF0JTVNbT72vMrOq+HU6eoCxOPe0qa+ibL9
 2b0yKVouwUcUvtJpcXiVMomqE25f59b94XujH3Z88P0+bCn03OTqLsA8fHL4vYyBVr5F4HF+j0M
 g5Eyq8NbjW/NuWF4fPmkdGZIych/CdzM7rBnaJBOSrrdA0cWhQYwFXW+IC3JPUuw9Ok1AKAm2zN
 3cHHetErMpjuid4fuxnb1/f9Q+VDaoAx/z1Bnk6W4MlPR7BVaqQAoknZVMadcKyvdbNFsm2UK6r
 8F5/yp4k1nR1KP1/T3NzrdSUGkc5S9vGF5HQL5vepgOnXYDpxlAHymbC/aVNlQ2s/gYVW2UAWBf
 Nz0ir0/bE++xYwRcv0SDhNkHvW2YOisPfQSGz17cotMcePr/4njD9nqa2uYQWZQk/vPOgUw27aP
 HQ8AZvmEgynJ8JtMeUBcM4bVeVRu1uVu9JLnhcg94D6zaCJvq8+EvrMEUq+VmbOxys14VqUsqti
 OVdUC4SjxrlYCso29sCxTADqkxh6tpByqO51+msa8LGbceJq2gHtNu0aE+z08e47A314S95+UEN
 j7WRHSA4+wuh4rxoLCnxcaBGEIe8iRyjPbNvFo+UT9eYLlOk5tVabgzXKoG/w1DSCkd7GDuPtng
 O4Uqf8XPhiqtSCg==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

'make_connection' is launched twice: once for IPv4, once for IPv6.

But then, the "pm_nl_ctl events" was launched a first time, killed, then
relaunched after for no particular reason.

We can then move this code, and the generation of the temp file to
exchange, to the init part, and remove extra conditions that no longer
needed.

Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
Notes:
  - we could backport this to stable, but it also works without issue
    without this patch, and it would be a bit annoying to backport, due
    to the use of the new mptcp_lib_xxx helpers (make file, events).
---
 tools/testing/selftests/net/mptcp/userspace_pm.sh | 29 ++++++++++-------------
 1 file changed, 13 insertions(+), 16 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/userspace_pm.sh b/tools/testing/selftests/net/mptcp/userspace_pm.sh
index 3200d0b96d53..b0cce8f065d8 100755
--- a/tools/testing/selftests/net/mptcp/userspace_pm.sh
+++ b/tools/testing/selftests/net/mptcp/userspace_pm.sh
@@ -149,17 +149,23 @@ ip -net "$ns2" addr add dead:beef:1::2/64 dev ns2eth1 nodad
 ip -net "$ns2" addr add dead:beef:2::2/64 dev ns2eth1 nodad
 ip -net "$ns2" link set ns2eth1 up
 
+file=$(mktemp)
+mptcp_lib_make_file "$file" 2 1
+
+# Capture netlink events over the two network namespaces running
+# the MPTCP client and server
+client_evts=$(mktemp)
+mptcp_lib_events "${ns2}" "${client_evts}" client_evts_pid
+server_evts=$(mktemp)
+mptcp_lib_events "${ns1}" "${server_evts}" server_evts_pid
+sleep 0.5
+
 print_title "Init"
 print_test "Created network namespaces ns1, ns2"
 test_pass
 
 make_connection()
 {
-	if [ -z "$file" ]; then
-		file=$(mktemp)
-	fi
-	mptcp_lib_make_file "$file" 2 1
-
 	local is_v6=$1
 	local app_port=$app4_port
 	local connect_addr="10.0.1.1"
@@ -173,17 +179,8 @@ make_connection()
 		is_v6="v4"
 	fi
 
-	# Capture netlink events over the two network namespaces running
-	# the MPTCP client and server
-	if [ -z "$client_evts" ]; then
-		client_evts=$(mktemp)
-	fi
-	mptcp_lib_events "${ns2}" "${client_evts}" client_evts_pid
-	if [ -z "$server_evts" ]; then
-		server_evts=$(mktemp)
-	fi
-	mptcp_lib_events "${ns1}" "${server_evts}" server_evts_pid
-	sleep 0.5
+	:>"$client_evts"
+	:>"$server_evts"
 
 	# Run the server
 	ip netns exec "$ns1" \

-- 
2.43.0

