Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2058158D7E
	for <mptcp@lists.linux.dev>; Fri, 17 May 2024 17:41:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715967671; cv=none; b=FIr+7Gx0gf32TZn3hj2vquvprmv9vct4SxRwIYKQ0QdgaQaZumcRLBEG98P+LOkx+OlEsl/2qwEVDFrij0botWvezgKe/buKNipjsQRLF7jNpEK9T5Fl49/WmX8lfsUfKBb+Epa5mZSjV894qL4nKwIOV13/Kdlwt/JI5aiuZmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715967671; c=relaxed/simple;
	bh=3gm2Uf9xQQmepglmxe6UbEr1eW1MN3QblnjEz01QPfI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GTHYskuHVOP5nVpUU4pDrZTf15dDgIwFRxxpw8IkRZ8V7tExw9onBs298mdbpAg892PAjfrlwLhk8EV8cmFZThdxXszgkOhNfc8oKL4jsqWSPE9kdRnqvVpSkm5NBA5uPic+UnWisq8F6dnagSvRkmvcqMk7QAbNMxhK8IS6YFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t+osDyjI; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t+osDyjI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4774C2BD10;
	Fri, 17 May 2024 17:41:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715967671;
	bh=3gm2Uf9xQQmepglmxe6UbEr1eW1MN3QblnjEz01QPfI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=t+osDyjIiV8EDH0XqbnwUx+1X07QmD9OHUblgFLtoRVBDKHGlhD5IJrS9JFl7DCWf
	 lbzKZmQUsydBfBuravkILGv5xsiU8aRWWHmOhDapzukKtdaj4ijHdV9CYc3t/Ez8Aa
	 +/wCfv19xqEpoy6hf9xMaqwqvB3X+WJj210k/X3UsxtEg1RiSiK6PUYWfX/7ZYK1RJ
	 8hom34QpavDcJDf1MohAKkVxOtgxk7A9AVZQthIPD08jX5Abquv88eHsyssvnT89O/
	 SSewNUoDdhH1x+ujs7drX+Wix6/3rCZ0ywmWFc0AVqx2XSvjM5jZhwVWLd58cb/EDi
	 9gJEqK/Rv6tNQ==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri, 17 May 2024 19:40:45 +0200
Subject: [PATCH mptcp-next 2/3] doc: mptcp: alphabetical order
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240517-mptcp-doc-v1-2-fc1ef063584e@kernel.org>
References: <20240517-mptcp-doc-v1-0-fc1ef063584e@kernel.org>
In-Reply-To: <20240517-mptcp-doc-v1-0-fc1ef063584e@kernel.org>
To: mptcp@lists.linux.dev
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3857; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=3gm2Uf9xQQmepglmxe6UbEr1eW1MN3QblnjEz01QPfI=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBmR5azL4eAYqSG0mHxCuRgp9cgM12e+P1e/vLe4
 b4HKwDAAhGJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZkeWswAKCRD2t4JPQmmg
 c2nFD/45GeCn8FCK92968ZUbYh9tsfJxarLrK+08Mgk6VPY9vgxYc3ZrOJvtE3oJj0FZamguLzF
 okPVdvq5V9kziu8jMb2KLVZb10T/OGwDK0W2vhfgG3XhkNBg+5kb/Fih6J/gDRBCjj7ane3xMrV
 KNahVUkOINDy+LMtVnJOxZivP0I9HCV9Rl7hKlEpQEFORObuxIdWKJa2+MksxD2VqNgj7GDCUux
 FovXvTalxdJOUVKo18DWVnn4RqBW7RHpT21wotJYoNgvw6T6xMi/pEOz2VfmfGScb0kqY9ldd5n
 NFhxI/uvHtaQGBSO9v5w76IrJrGJpor3RWfU2AfNUboWKnjCdEmuvAVhoplB6EfrhCyShX+nluo
 A6Plwjjw+3P1X8rEVE5VcB5qNdPPSKe99avXD6/i3WqGkZ2YJBdQ3ws9MZ7mj61dSheO53d3dyN
 X88JPttPRsf/kGvdr2QvOOn/lPddXex2wsTiRae9yGQeYQDuJbkeFsRaxhV2R3GykJh0xGRAv7z
 Jl7zTOipxQUZIB+SYANMHxN3DeznB0Pcwd9poZqQ2qB35PceYyLd+UABZ2NYvOb5xikAPIHboji
 +JYK87BZoyA8d2BndyCc9+QGrFYb934xDp02bkjr7821FyEGz1lgzDLJd+vMPhWR3nFTomfpdlZ
 1m+BZUIBkMbuZGg==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

Similar to what is done in other 'sysctl' pages.

Also, by not putting new entries at the end, this can help to reduce
conflicts in case of backports.

Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 Documentation/networking/mptcp-sysctl.rst | 78 +++++++++++++++----------------
 1 file changed, 39 insertions(+), 39 deletions(-)

diff --git a/Documentation/networking/mptcp-sysctl.rst b/Documentation/networking/mptcp-sysctl.rst
index 102a45e7bfa8..fd514bba8c43 100644
--- a/Documentation/networking/mptcp-sysctl.rst
+++ b/Documentation/networking/mptcp-sysctl.rst
@@ -7,14 +7,6 @@ MPTCP Sysfs variables
 /proc/sys/net/mptcp/* Variables
 ===============================
 
-enabled - BOOLEAN
-	Control whether MPTCP sockets can be created.
-
-	MPTCP sockets can be created if the value is 1. This is a
-	per-namespace sysctl.
-
-	Default: 1 (enabled)
-
 add_addr_timeout - INTEGER (seconds)
 	Set the timeout after which an ADD_ADDR control message will be
 	resent to an MPTCP peer that has not acknowledged a previous
@@ -25,25 +17,6 @@ add_addr_timeout - INTEGER (seconds)
 
 	Default: 120
 
-close_timeout - INTEGER (seconds)
-	Set the make-after-break timeout: in absence of any close or
-	shutdown syscall, MPTCP sockets will maintain the status
-	unchanged for such time, after the last subflow removal, before
-	moving to TCP_CLOSE.
-
-	The default value matches TCP_TIMEWAIT_LEN. This is a per-namespace
-	sysctl.
-
-	Default: 60
-
-checksum_enabled - BOOLEAN
-	Control whether DSS checksum can be enabled.
-
-	DSS checksum can be enabled if the value is nonzero. This is a
-	per-namespace sysctl.
-
-	Default: 0
-
 allow_join_initial_addr_port - BOOLEAN
 	Allow peers to send join requests to the IP address and port number used
 	by the initial subflow if the value is 1. This controls a flag that is
@@ -57,6 +30,37 @@ allow_join_initial_addr_port - BOOLEAN
 
 	Default: 1
 
+available_schedulers - STRING
+	Shows the available schedulers choices that are registered. More packet
+	schedulers may be available, but not loaded.
+
+checksum_enabled - BOOLEAN
+	Control whether DSS checksum can be enabled.
+
+	DSS checksum can be enabled if the value is nonzero. This is a
+	per-namespace sysctl.
+
+	Default: 0
+
+close_timeout - INTEGER (seconds)
+	Set the make-after-break timeout: in absence of any close or
+	shutdown syscall, MPTCP sockets will maintain the status
+	unchanged for such time, after the last subflow removal, before
+	moving to TCP_CLOSE.
+
+	The default value matches TCP_TIMEWAIT_LEN. This is a per-namespace
+	sysctl.
+
+	Default: 60
+
+enabled - BOOLEAN
+	Control whether MPTCP sockets can be created.
+
+	MPTCP sockets can be created if the value is 1. This is a
+	per-namespace sysctl.
+
+	Default: 1 (enabled)
+
 pm_type - INTEGER
 	Set the default path manager type to use for each new MPTCP
 	socket. In-kernel path management will control subflow
@@ -74,6 +78,14 @@ pm_type - INTEGER
 
 	Default: 0
 
+scheduler - STRING
+	Select the scheduler of your choice.
+
+	Support for selection of different schedulers. This is a per-namespace
+	sysctl.
+
+	Default: "default"
+
 stale_loss_cnt - INTEGER
 	The number of MPTCP-level retransmission intervals with no traffic and
 	pending outstanding data on a given subflow required to declare it stale.
@@ -85,15 +97,3 @@ stale_loss_cnt - INTEGER
 	This is a per-namespace sysctl.
 
 	Default: 4
-
-scheduler - STRING
-	Select the scheduler of your choice.
-
-	Support for selection of different schedulers. This is a per-namespace
-	sysctl.
-
-	Default: "default"
-
-available_schedulers - STRING
-	Shows the available schedulers choices that are registered. More packet
-	schedulers may be available, but not loaded.

-- 
2.43.0

