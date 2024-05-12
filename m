Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D62DCA40
	for <mptcp@lists.linux.dev>; Sun, 12 May 2024 08:42:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715503347; cv=none; b=JuTUhpUAtGrrso1His/UwWbE1rWnb0qR2aO1w/iiDKy9BnRCBovJED5LyGGF7ltq2d3pCaPtqBt7JyhFZWTIBnZkzMfk8lYmI+FWlo+ZJheixb7VPu8DjCWxFH/G8Vpn4L5v6DCM4qSGteQn+EQGfI4XJYfmtbE9746n70PwYRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715503347; c=relaxed/simple;
	bh=RLcAHkS6R/sFZGlW6UTG9IZnwjcZEWyBK590zCPZTAc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EjfyUIz4tfv4gNmlQks9Xqu1IagSwdrIXvqEZVYZSvElD7Y8AXIXwC7l1IlX2d7rZdVKQGlKD1Iz7X1bsXiOZBA8/I0MDrBCBpVLw32r02sUx800Elo6XbyjR7f6BOVUvKpGU3M4xfawMHY0PCgmMjVfOVuUj13BtM7Jdn0hqOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eoTIq6O/; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eoTIq6O/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4FC03C32781;
	Sun, 12 May 2024 08:42:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715503347;
	bh=RLcAHkS6R/sFZGlW6UTG9IZnwjcZEWyBK590zCPZTAc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=eoTIq6O/O0HKTTdTS6p+4KB97uNbGheqNuqBR1SYuOzvunq/BDyiUlGNKcGwmpczt
	 9iXe4+wsAm69mIYxG1l77jnR1GDFwqR0t9OLSJg1ydZ7DWSdPO4Dj2Kh+U+iedviUx
	 wVKK6h763eHklHX71zwlvLPsIXpJhBzmiu27EV1coTkyhFnnbtHKCVpBmIdQvQEi4M
	 8gkzkgL/FGiBCBZgDz1teNEBrzqiIcofJVabGDIigvx5t+YM1JV8ICM2oR0r9bcgOy
	 TnuxXUH4T72XqbzsURe/0TbuNGpwjOEqR/4sza0DeYibwrzTFLpZH4nP918J/sSVxB
	 HY5zYButb/mWw==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v4 3/3] checkpatch: skip warnings for symbol links
Date: Sun, 12 May 2024 16:41:36 +0800
Message-ID: <1628d78e12809ff0f4dd0526f6addbbf00dae66b.1715503185.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1715503185.git.tanggeliang@kylinos.cn>
References: <cover.1715503185.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

If there is a symbol link in the given patch, checkpatch.pl reports two
inaccurate warnings:

$ cat 0001-selftests-bpf-Add-mptcp-pm_nl_ctl-link.patch

 ... ...

 '''
 # diff --git a/tools/testing/selftests/bpf/mptcp_pm_nl_ctl.c \
 #            b/tools/testing/selftests/bpf/mptcp_pm_nl_ctl.c
 # new file mode 120000
 # index 000000000000..5a08c255b278
 # --- /dev/null
 # +++ b/tools/testing/selftests/bpf/mptcp_pm_nl_ctl.c
 # @@ -0,0 +1 @@
 # +../net/mptcp/pm_nl_ctl.c
 # \ No newline at end of file
 '''

$ ./scripts/checkpatch.pl 0001-selftests-bpf-Add-mptcp-pm_nl_ctl-link.patch

 '''
 WARNING: Missing or malformed SPDX-License-Identifier tag in line 1
 #57: FILE: tools/testing/selftests/bpf/mptcp_pm_nl_ctl.c:1:
 +../net/mptcp/pm_nl_ctl.c

 WARNING: adding a line without newline at end of file
 #57: FILE: tools/testing/selftests/bpf/mptcp_pm_nl_ctl.c:1:
 +../net/mptcp/pm_nl_ctl.c

 total: 0 errors, 2 warnings, 16 lines checked
 '''

This patch fixes this by adding a new variable $symbol_link in checkpatch
script, set it if the new file mode is 120000. Skip these two checks
"missing SPDX-License-Identifier" and "adding a line without newline at
end of file" if this variable is set.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 scripts/checkpatch.pl | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 9c4c4a61bc83..b31f13d643a7 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -436,6 +436,7 @@ for my $key (keys %debug) {
 }
 
 my $rpt_cleaners = 0;
+my $symbol_link = 0;
 
 if ($terse) {
 	$emacs = 1;
@@ -3595,6 +3596,10 @@ sub process {
 				      "Do not include the paragraph about writing to the Free Software Foundation's mailing address from the sample GPL notice. The FSF has changed addresses in the past, and may do so again. Linux already includes a copy of the GPL.\n" . $herevet)
 		}
 
+		if ($line =~ /^new file mode 120000$/) {
+			$symbol_link = 1;
+		}
+
 # check for Kconfig help text having a real description
 # Only applies when adding the entry originally, after that we do not have
 # sufficient context to determine whether it is indeed long enough.
@@ -3756,7 +3761,8 @@ sub process {
 				}
 
 				if ($comment !~ /^$/ &&
-				    $rawline !~ m@^\+\Q$comment\E SPDX-License-Identifier: @) {
+				    $rawline !~ m@^\+\Q$comment\E SPDX-License-Identifier: @ &&
+				    $symbol_link =~ 1) {
 					WARN("SPDX_LICENSE_TAG",
 					     "Missing or malformed SPDX-License-Identifier tag in line $checklicenseline\n" . $herecurr);
 				} elsif ($rawline =~ /(SPDX-License-Identifier: .*)/) {
@@ -3867,7 +3873,8 @@ sub process {
 		}
 
 # check for adding lines without a newline.
-		if ($line =~ /^\+/ && defined $lines[$linenr] && $lines[$linenr] =~ /^\\ No newline at end of file/) {
+		if ($line =~ /^\+/ && defined $lines[$linenr] && $lines[$linenr] =~ /^\\ No newline at end of file/ &&
+		    $symbol_link =~ 1) {
 			if (WARN("MISSING_EOF_NEWLINE",
 			         "adding a line without newline at end of file\n" . $herecurr) &&
 			    $fix) {
-- 
2.43.0

