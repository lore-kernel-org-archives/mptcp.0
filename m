Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0BB02D662E;
	Fri, 22 Aug 2025 13:45:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755870328; cv=none; b=WLkyj4zRVk+uKZ9muvP5ddR4C0S4H2BUgJnk4Pjf58UwLgQyuNaaV4Stt2qSYC45bgzhp9h88RGdrvqqRXhDymku1lYIuf69ZBwJySrzxHEVE1CIm5cYFIn1ly00aoUT/m0mENd7ElSN/w0PXHv25cDt5GMZC7tkA5G+KKB/4b8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755870328; c=relaxed/simple;
	bh=WFNpCzTBZcc6BX2NMdeAohk9XCl5NlL3w/87tj52M9U=;
	h=Subject:To:Cc:From:Date:In-Reply-To:Message-ID:MIME-Version:
	 Content-Type; b=ewoMEON+Gt1vdHz/IVdORwGGj/ssyAu8byHIX3qCF7QVRauKhvIKPCDM7gPRe7FXVZUAnVmqBllMGx1ru+5ZM30t9blam0DC6h8nP3sWaeoyXCoc9fWJQNDa454vnqwA3JeK3aEoq/FItl/AuDnPx8S2breLe+KiOhyhoNtzpXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=xLjDHUCf; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="xLjDHUCf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4FF5AC4CEED;
	Fri, 22 Aug 2025 13:45:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1755870327;
	bh=WFNpCzTBZcc6BX2NMdeAohk9XCl5NlL3w/87tj52M9U=;
	h=Subject:To:Cc:From:Date:In-Reply-To:From;
	b=xLjDHUCfpRiBc50GICKFHd5fJ8WN1cVmhLGSzc5uwsVhCVV+j39fmyHfmg0XQ20Iy
	 EfNm0T0GhzJRLmEEl2SAz9XLwvcv5WwnLy0QI223v2ismO/lTGE0OrFEkZbxk87MrK
	 3lpFEScf2TIhweTD6/FkH5ZZtAsUGIDOSL71ZR/g=
Subject: Patch "selftests: mptcp: connect: also cover alt modes" has been added to the 5.15-stable tree
To: geliang@kernel.org,gregkh@linuxfoundation.org,kuba@kernel.org,matttbe@kernel.org,mptcp@lists.linux.dev,sashal@kernel.org
Cc: <stable-commits@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Fri, 22 Aug 2025 15:44:35 +0200
In-Reply-To: <20250730102806.1405622-7-matttbe@kernel.org>
Message-ID: <2025082235-twisted-snuff-6c61@gregkh>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-stable: commit
X-Patchwork-Hint: ignore 


This is a note to let you know that I've just added the patch titled

    selftests: mptcp: connect: also cover alt modes

to the 5.15-stable tree which can be found at:
    http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary

The filename of the patch is:
     selftests-mptcp-connect-also-cover-alt-modes.patch
and it can be found in the queue-5.15 subdirectory.

If you, or anyone else, feels it should not be added to the stable tree,
please let <stable@vger.kernel.org> know about it.


From stable+bounces-165497-greg=kroah.com@vger.kernel.org Wed Jul 30 12:28:53 2025
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Wed, 30 Jul 2025 12:28:09 +0200
Subject: selftests: mptcp: connect: also cover alt modes
To: mptcp@lists.linux.dev, stable@vger.kernel.org, gregkh@linuxfoundation.org
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, sashal@kernel.org, Geliang Tang <geliang@kernel.org>, Jakub Kicinski <kuba@kernel.org>
Message-ID: <20250730102806.1405622-7-matttbe@kernel.org>

From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>

[ Upstream commit 37848a456fc38c191aedfe41f662cc24db8c23d9 ]

The "mmap" and "sendfile" alternate modes for mptcp_connect.sh/.c are
available from the beginning, but only tested when mptcp_connect.sh is
manually launched with "-m mmap" or "-m sendfile", not via the
kselftests helpers.

The MPTCP CI was manually running "mptcp_connect.sh -m mmap", but not
"-m sendfile". Plus other CIs, especially the ones validating the stable
releases, were not validating these alternate modes.

To make sure these modes are validated by these CIs, add two new test
programs executing mptcp_connect.sh with the alternate modes.

Fixes: 048d19d444be ("mptcp: add basic kselftest for mptcp")
Cc: stable@vger.kernel.org
Reviewed-by: Geliang Tang <geliang@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Link: https://patch.msgid.link/20250715-net-mptcp-sft-connect-alt-v2-1-8230ddd82454@kernel.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
[ Drop userspace_pm.sh from TEST_PROGS ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 tools/testing/selftests/net/mptcp/Makefile                  |    3 ++-
 tools/testing/selftests/net/mptcp/mptcp_connect_mmap.sh     |    5 +++++
 tools/testing/selftests/net/mptcp/mptcp_connect_sendfile.sh |    5 +++++
 3 files changed, 12 insertions(+), 1 deletion(-)
 create mode 100755 tools/testing/selftests/net/mptcp/mptcp_connect_mmap.sh
 create mode 100755 tools/testing/selftests/net/mptcp/mptcp_connect_sendfile.sh

--- a/tools/testing/selftests/net/mptcp/Makefile
+++ b/tools/testing/selftests/net/mptcp/Makefile
@@ -5,7 +5,8 @@ KSFT_KHDR_INSTALL := 1
 
 CFLAGS =  -Wall -Wl,--no-as-needed -O2 -g  -I$(top_srcdir)/usr/include
 
-TEST_PROGS := mptcp_connect.sh pm_netlink.sh mptcp_join.sh diag.sh \
+TEST_PROGS := mptcp_connect.sh mptcp_connect_mmap.sh mptcp_connect_sendfile.sh \
+	      pm_netlink.sh mptcp_join.sh diag.sh \
 	      simult_flows.sh mptcp_sockopt.sh
 
 TEST_GEN_FILES = mptcp_connect pm_nl_ctl
--- /dev/null
+++ b/tools/testing/selftests/net/mptcp/mptcp_connect_mmap.sh
@@ -0,0 +1,5 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+
+MPTCP_LIB_KSFT_TEST="$(basename "${0}" .sh)" \
+	"$(dirname "${0}")/mptcp_connect.sh" -m mmap "${@}"
--- /dev/null
+++ b/tools/testing/selftests/net/mptcp/mptcp_connect_sendfile.sh
@@ -0,0 +1,5 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+
+MPTCP_LIB_KSFT_TEST="$(basename "${0}" .sh)" \
+	"$(dirname "${0}")/mptcp_connect.sh" -m sendfile "${@}"


Patches currently in stable-queue which might be from matttbe@kernel.org are

queue-5.15/mptcp-drop-unused-sk-in-mptcp_push_release.patch
queue-5.15/selftests-mptcp-connect-also-cover-alt-modes.patch
queue-5.15/mptcp-drop-skb-if-mptcp-skb-extension-allocation-fails.patch
queue-5.15/selftests-mptcp-connect-also-cover-checksum.patch
queue-5.15/selftests-mptcp-make-sendfile-selftest-work.patch
queue-5.15/selftests-mptcp-initialize-variables-to-quiet-gcc-12-warnings.patch
queue-5.15/mptcp-pm-kernel-flush-do-not-reset-add_addr-limit.patch
queue-5.15/mptcp-do-not-queue-data-on-closed-subflows.patch
queue-5.15/selftests-mptcp-add-missing-join-check.patch
queue-5.15/mptcp-fix-error-mibs-accounting.patch
queue-5.15/mptcp-introduce-mapping_bad_csum.patch
