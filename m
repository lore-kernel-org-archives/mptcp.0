Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 079CC20764E
	for <mptcp@lists.linux.dev>; Fri,  7 Mar 2025 11:39:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741347564; cv=none; b=a9uFN7vTWwiajyj8KlLo7eb2sl9TuU39XfeSM7W5vWYr4cc3coGZoyXJKkPApACgYLhM4EwwnLr6TrLvWpserDGt3vtYy4mUU9A3z8WYBr0U/YrbyWV9DvYKG7ESPAK0lumHFXuKZ/knRDWB/FSje7s0Wc7LTW5OhDErYYQKo3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741347564; c=relaxed/simple;
	bh=qQU6D4I/vtAoabkkYKM5pOw6hqHJfy48INy0JEJV0aU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nnVqffJtDylh2ulC/OEYoB7oGJXLSliSD7gkgqokulJWgrS6fSVUFqc8EEtbdn3x5D/eM6Pgt9HoRtT3YuWoCFE9XCVz/2V24EfsY+5GyYcIS2i6O+n0X5BCVhFP10RUwa+PjgoicDB4hVb8zc4EiNnVL74wztVPwkbYj0NcsG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d5IcfCFB; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d5IcfCFB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8FD0C4CEE5;
	Fri,  7 Mar 2025 11:39:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741347563;
	bh=qQU6D4I/vtAoabkkYKM5pOw6hqHJfy48INy0JEJV0aU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=d5IcfCFBvT+TUvsa6zbzy7I28EK6itT82xuVbgYaueso/BjKsD8/p8oADj6FA6A4o
	 a7znoYYrGQ1A+oW9nqoa6GnLkNm9lsPrYCOx3ihWnB0uUF6hYw/hjnFPzZI+OlyCW5
	 lHVbgBHIWPJ5qBdolCJ0/oZ1NmcGZuRR2Xfj+kN3Y819l8H7/Nw/rUxYLxCtCbwXnW
	 6h4hCGmrpOCZtEx7k7XfxnaG9b3JkZbONX59D2w8XP4pav7wOeBGeu7zPesWVFyGUM
	 hNx+olCPWps4b/fljf0TF8nN0v2mL7NAuhU7qplysBF8ja/ufESdMQp9CF/yeJsZBA
	 L3p4BcifHElRQ==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v1 1/2] Squash to "mptcp: sysctl: set path manager by name"
Date: Fri,  7 Mar 2025 19:39:14 +0800
Message-ID: <3ee604f983ceb48eb9f2443967a740f121f019c4.1741347453.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1741347453.git.tanggeliang@kylinos.cn>
References: <cover.1741347453.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

Name mptcp_pm_ops variable as "pm_ops", instead of "pm" in
mptcp_set_path_manager().

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 net/mptcp/ctrl.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/net/mptcp/ctrl.c b/net/mptcp/ctrl.c
index 14c32d06f51e..e6e8b4dde5bc 100644
--- a/net/mptcp/ctrl.c
+++ b/net/mptcp/ctrl.c
@@ -183,12 +183,12 @@ static int proc_blackhole_detect_timeout(const struct ctl_table *table,
 
 static int mptcp_set_path_manager(char *path_manager, const char *name)
 {
-	struct mptcp_pm_ops *pm;
+	struct mptcp_pm_ops *pm_ops;
 	int ret = 0;
 
 	rcu_read_lock();
-	pm = mptcp_pm_find(name);
-	if (pm)
+	pm_ops = mptcp_pm_find(name);
+	if (pm_ops)
 		strscpy(path_manager, name, MPTCP_PM_NAME_MAX);
 	else
 		ret = -ENOENT;
-- 
2.43.0

