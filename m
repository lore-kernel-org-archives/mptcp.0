Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F62C16FF2A
	for <mptcp@lists.linux.dev>; Thu,  2 May 2024 17:23:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714670600; cv=none; b=JlTzJIzB9TWb2xiju5jV7Ez+szoX+7el0uY5iBNts22BFKm20es6tFfEfrB9V0nifVaKcjh+8t0tRlIdrAPszCkdC+N8d8pVRNaMKCi7XbCBkNKtOZGKA9ZMV8nDhVK7AWYORrcPZAd7KNSPeHrZbpxI0OwKJKfmhHqeAbFKCsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714670600; c=relaxed/simple;
	bh=mvvlH2m409VuiWYpIh3M8K3HaWJsVPp30WQFQLduJ3M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FlL/L2di/epaGfYSnSAY1s5IBfWHzjf36cG6yjcupiVCADgErNE5lX02tarhcqNVZGjb2WuGMJRxVVgBAxyXhcZXue8COaD4Pz2Hu/F/cVsmFqJ+FrCslLYxTLfJjcTncwTwf9y0WM6pXJEHjqQxKtVNX+4wK4g9xRn0GsJ9msY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T3WZZSKr; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T3WZZSKr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B0DAC4AF14;
	Thu,  2 May 2024 17:23:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714670600;
	bh=mvvlH2m409VuiWYpIh3M8K3HaWJsVPp30WQFQLduJ3M=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=T3WZZSKrDBTHDCVylZWPyg2l77aDxwC3heiyR+NLLWALB5JSzh2XnMzWzKeDkBvMn
	 fxZyI19aKaPtYQV9OM/bliwu3y3SVCN+m86OerUlgt5nirm958BtDsAHJQjy5epZdl
	 oJjV4PCifJo0SlsaAyz1wkr3kU+szW0vFwrumgSb33sFbvG+qXuqmJse0r7TOZ0Aef
	 ucfGlyV32nlgK4HnVqscnlF0S8sOYHwDlBygbjzPQJtupABv6sdOJ5KSm4zhk+0P30
	 yL3xOJll2o8aLRP/r6IuEf1nspZMuEh3kk2HSgbDyQIsroll0LLZb3+XIedvU5fkC4
	 jh5KIsDUIcoGQ==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Thu, 02 May 2024 19:23:05 +0200
Subject: [PATCH mptcp-next 2/4] mptcp: move mptcp_pm_gen.h's include
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240502-mptcp-cleanup-clang-checkpatch-v1-2-a2b46c0a6bec@kernel.org>
References: <20240502-mptcp-cleanup-clang-checkpatch-v1-0-a2b46c0a6bec@kernel.org>
In-Reply-To: <20240502-mptcp-cleanup-clang-checkpatch-v1-0-a2b46c0a6bec@kernel.org>
To: mptcp@lists.linux.dev
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1390; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=mvvlH2m409VuiWYpIh3M8K3HaWJsVPp30WQFQLduJ3M=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBmM8wEQwv/bdXEl8+Yzrn4ljpVK/xiP+guMkY9c
 WYWqNG+u+SJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZjPMBAAKCRD2t4JPQmmg
 c0YVEADopF8iPQDeEGObtphjr7Jl15jZNGIiR43a/ildnBob7YBwf8OAAU8vnQF//TV2OAjhy0u
 +yL3e1tzhskdhyPAweJRCdB3o6+RLWRYDiTk1KWwG/WOeyioLotPpTdumSDZdPXTV+W909/Nj44
 cu0du9Mt8zE18EX/KHH95jjP/xWgjvT0l1Xwv2d3ihXKAj8P5hCFWyq4NMXNF5IubxBiaKZA4DQ
 C3UgJM0JXVbOU/oHaX00BjFN3WWfZetbf5b40JUGh/wp9fy8R1jphxg5YFMj3fgKVWIPlvYpTL3
 i9f48YEdSnungbtfKp4uXp9EkFBbBU6SaIM00PaprgYY/1UvEBRtJL00agkRx/6XNZh796sEO2k
 yrDUxq+pCM86DWwVB4mE6KXNKdDLJn/vP0/FnpT0PPfE8ebbn1lcW/Jb6J8VttTZqlUOeYfuw4I
 c0bFcWldG2qclnaBgdB8e+v7inT648JSfvH9DlaAK+XNSx8xBFw+VgD2mfWZpJKYIRbxxunbZHw
 1GhhH86nAGz0KYHH1fll7r6jrCvMg0L7TEoQen05xU9fM+vBENGMyFXICERTvNj35PteKZUYQ3x
 N3FC233CtW8RQ4XLhieE9MFWp4yIhkDMzu/Ni2DcoUZN8rKNodvFN8mkNYIrt6G0Nh/HZmPLXhy
 VsKUYj5iqBYXlZA==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

Nothing from protocol.h depends on mptcp_pm_gen.h, only code from
pm_netlink.c and pm_userspace.c depends on it.

So this include can be moved where it is needed to avoid a "unused
includes" warning.

Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/pm_netlink.c   | 1 +
 net/mptcp/pm_userspace.c | 1 +
 net/mptcp/protocol.h     | 2 --
 3 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index 5c17d39146ea..7f53e022e27e 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -14,6 +14,7 @@
 
 #include "protocol.h"
 #include "mib.h"
+#include "mptcp_pm_gen.h"
 
 static int pm_nl_pernet_id;
 
diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
index 9f5d422d5ef6..f0a4590506c6 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -6,6 +6,7 @@
 
 #include "protocol.h"
 #include "mib.h"
+#include "mptcp_pm_gen.h"
 
 void mptcp_free_local_addr_list(struct mptcp_sock *msk)
 {
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index ffd00fb45433..2d40629e8231 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -14,8 +14,6 @@
 #include <net/genetlink.h>
 #include <net/rstreason.h>
 
-#include "mptcp_pm_gen.h"
-
 #define MPTCP_SUPPORTED_VERSION	1
 
 /* MPTCP option bits */

-- 
2.43.0

