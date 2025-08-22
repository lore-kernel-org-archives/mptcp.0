Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39BC022DA02;
	Fri, 22 Aug 2025 13:45:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755870331; cv=none; b=RFdix0NeBP12WHkvhbVz3kjsA4LYvb2E+pVz1Ku0ErW7VF0tzvAXsotXGMYFj4R4StyXkGXdrkNOFPCoGFdsvzELxSisc+yz2bd88Xsd+cYTGZ3Nm2HdELLflSOqrj2EvT332+yvMNxzAoRnUJlZBWgLcnBw5zHHZnBPoi5MHyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755870331; c=relaxed/simple;
	bh=SVFTqD+IcpJf5oUMlEbYIQS2MzMRU4mml73bhkfMaII=;
	h=Subject:To:Cc:From:Date:In-Reply-To:Message-ID:MIME-Version:
	 Content-Type; b=FM0iqBPUIsMRbQmNt1AiQzuv75iFLR1LFywufGbHyUamwGPxY056KnAIw4t6z2HBvIdD2Lpmxyj03WO/efgW6AVgMZIGYAWP1qTu6y060cYrBPT6l74k5lFMEW0mGgHSwJheNzev0sCQZLhZPrgIcSmbTAfWPw/nqRk7pDmFRRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=x6SevCcr; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="x6SevCcr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 931DEC4CEED;
	Fri, 22 Aug 2025 13:45:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1755870331;
	bh=SVFTqD+IcpJf5oUMlEbYIQS2MzMRU4mml73bhkfMaII=;
	h=Subject:To:Cc:From:Date:In-Reply-To:From;
	b=x6SevCcrK20MR8ZeV7DEHBaBVPgry4ef4YiPN2ad4muPPFQuz6jJ8qJgJ3iizVBGe
	 zazsdeoIiuNShgZxNBeoEtBmybV4/Zyou1bu7qyhWCLDm79oWLJOXgqsrw3gUgCpRp
	 FUDtAJ1oQhKF5ebdkK+cgHDy77vxuGIg8QmTIpS8=
Subject: Patch "selftests: mptcp: connect: also cover checksum" has been added to the 5.15-stable tree
To: geliang@kernel.org,gregkh@linuxfoundation.org,kuba@kernel.org,matttbe@kernel.org,mptcp@lists.linux.dev,sashal@kernel.org
Cc: <stable-commits@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Fri, 22 Aug 2025 15:44:35 +0200
In-Reply-To: <20250730102806.1405622-8-matttbe@kernel.org>
Message-ID: <2025082235-lining-basics-6656@gregkh>
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

    selftests: mptcp: connect: also cover checksum

to the 5.15-stable tree which can be found at:
    http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary

The filename of the patch is:
     selftests-mptcp-connect-also-cover-checksum.patch
and it can be found in the queue-5.15 subdirectory.

If you, or anyone else, feels it should not be added to the stable tree,
please let <stable@vger.kernel.org> know about it.


From stable+bounces-165498-greg=kroah.com@vger.kernel.org Wed Jul 30 12:28:54 2025
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Wed, 30 Jul 2025 12:28:10 +0200
Subject: selftests: mptcp: connect: also cover checksum
To: mptcp@lists.linux.dev, stable@vger.kernel.org, gregkh@linuxfoundation.org
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, sashal@kernel.org, Geliang Tang <geliang@kernel.org>, Jakub Kicinski <kuba@kernel.org>
Message-ID: <20250730102806.1405622-8-matttbe@kernel.org>

From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>

commit fdf0f60a2bb02ba581d9e71d583e69dd0714a521 upstream.

The checksum mode has been added a while ago, but it is only validated
when manually launching mptcp_connect.sh with "-C".

The different CIs were then not validating these MPTCP Connect tests
with checksum enabled. To make sure they do, add a new test program
executing mptcp_connect.sh with the checksum mode.

Fixes: 94d66ba1d8e4 ("selftests: mptcp: enable checksum in mptcp_connect.sh")
Cc: stable@vger.kernel.org
Reviewed-by: Geliang Tang <geliang@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Link: https://patch.msgid.link/20250715-net-mptcp-sft-connect-alt-v2-2-8230ddd82454@kernel.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
[ Conflict in Makefile, in the context, because userspace_pm.sh test
  has been introduced later, in commit 3ddabc433670 ("selftests: mptcp:
  validate userspace PM tests by default"), which is not in this
  version. ]
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 tools/testing/selftests/net/mptcp/Makefile                  |    2 +-
 tools/testing/selftests/net/mptcp/mptcp_connect_checksum.sh |    5 +++++
 2 files changed, 6 insertions(+), 1 deletion(-)
 create mode 100755 tools/testing/selftests/net/mptcp/mptcp_connect_checksum.sh

--- a/tools/testing/selftests/net/mptcp/Makefile
+++ b/tools/testing/selftests/net/mptcp/Makefile
@@ -6,7 +6,7 @@ KSFT_KHDR_INSTALL := 1
 CFLAGS =  -Wall -Wl,--no-as-needed -O2 -g  -I$(top_srcdir)/usr/include
 
 TEST_PROGS := mptcp_connect.sh mptcp_connect_mmap.sh mptcp_connect_sendfile.sh \
-	      pm_netlink.sh mptcp_join.sh diag.sh \
+	      mptcp_connect_checksum.sh pm_netlink.sh mptcp_join.sh diag.sh \
 	      simult_flows.sh mptcp_sockopt.sh
 
 TEST_GEN_FILES = mptcp_connect pm_nl_ctl
--- /dev/null
+++ b/tools/testing/selftests/net/mptcp/mptcp_connect_checksum.sh
@@ -0,0 +1,5 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+
+MPTCP_LIB_KSFT_TEST="$(basename "${0}" .sh)" \
+	"$(dirname "${0}")/mptcp_connect.sh" -C "${@}"


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
