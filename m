Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2338101C8;
	Wed, 15 May 2024 23:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715815946; cv=none; b=KcAcIu6bkdLoZBlD8rBSAWqaF2gvzIFRDA4DswtEunUWZDQoCwCTDPG69IJ956wcFAKhDZ3uyZA8XC69voRgfCC3mh1fa40cJskeeuF0Ae227YDkNjXI+VSJL9TLE0ryYGOdJeG+9LQKb/afElx8IGgVOQMbsfTrE6VG7UdJr5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715815946; c=relaxed/simple;
	bh=xlzcoyehhMejb6OGH4fNOhekpsMwsi1xxWKpJVJfn4s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nMXKZE+6KCycdouRSXVfEiQeV+ADdkubBMd1C4qAq/8FISj75etKfWjxI2bjgUxueBatAKgZrybnfWm9ERN8anTU9w/3K7SkaR6u2Bo4FavCGLz0XDpzE2qLRZIk20KuVdMa5LInl9OsTDa0vAk3zdUhHySJARPt4InFdxmG8IA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u2GMg7pd; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u2GMg7pd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABC43C116B1;
	Wed, 15 May 2024 23:32:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715815946;
	bh=xlzcoyehhMejb6OGH4fNOhekpsMwsi1xxWKpJVJfn4s=;
	h=From:To:Cc:Subject:Date:From;
	b=u2GMg7pd2TGcixAAjezr79nevd7i62BtCC180NKlspwonerc41QnjYhasSPAbVf5e
	 StzfbQQ6Wryqx6G5E/qc65fMi6lhQ73X1D52ZHzRvqzrRL0xMHT5/yKwPNXEq1jjVo
	 yJ4ehJCHsMGLvqw4UonjC/Kdl72txGu+a9p94Z4rrExfnFYFGdhbBDdjKaarOGEp/O
	 7LxF4xPHGGTe2nEI9Ii1VBPKxpTK6aFVkWn+wWySPLiNIOlRh1bKWuwR4pe5p7jzp+
	 kkClyOtYELuz1Xg4Xvv5pOiSs4enWfzdudspq9F6zu2/mzw7p65l7+kLDwbXJqGJ3o
	 M1y1FsIVzDvdA==
From: Geliang Tang <geliang@kernel.org>
To: Andy Whitcroft <apw@canonical.com>,
	Joe Perches <joe@perches.com>,
	Dwaipayan Ray <dwaipayanray1@gmail.com>,
	Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc: Geliang Tang <tanggeliang@kylinos.cn>,
	linux-kernel@vger.kernel.org,
	mptcp@lists.linux.dev
Subject: [PATCH v2] checkpatch: skip warnings for symbol links
Date: Thu, 16 May 2024 07:32:19 +0800
Message-ID: <8e5cdb8e4eb6d964ec3ffe961ab8e65b8788584f.1715815795.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

If there is a symbol link in the given patch, like the following one:

$ cat 0001-selftests-bpf-Add-mptcp-pm_nl_ctl-link.patch

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

checkpatch.pl reports two inaccurate warnings:

 '''
 WARNING: Missing or malformed SPDX-License-Identifier tag in line 1
 #65: FILE: tools/testing/selftests/bpf/mptcp_pm_nl_ctl.c:1:
 +../net/mptcp/pm_nl_ctl.c

 WARNING: adding a line without newline at end of file
 #65: FILE: tools/testing/selftests/bpf/mptcp_pm_nl_ctl.c:1:
 +../net/mptcp/pm_nl_ctl.c
 '''

And three checks if run it with strict option:

 '''
 CHECK: spaces preferred around that '/' (ctx:VxV)
 #65: FILE: tools/testing/selftests/bpf/mptcp_pm_nl_ctl.c:1:
 +../net/mptcp/pm_nl_ctl.c
   ^

 CHECK: spaces preferred around that '/' (ctx:VxV)
 #65: FILE: tools/testing/selftests/bpf/mptcp_pm_nl_ctl.c:1:
 +../net/mptcp/pm_nl_ctl.c
       ^

 CHECK: spaces preferred around that '/' (ctx:VxV)
 #65: FILE: tools/testing/selftests/bpf/mptcp_pm_nl_ctl.c:1:
 +../net/mptcp/pm_nl_ctl.c
 '''

This patch fixes this by adding a new variable $symbol_link in checkpatch
script, set it if the new file mode is 120000. Skip "missing or malformed
SPDX-License-Identifier tag", "adding a line without newline at end of
file" and "spaces preferred around that '/'" checks if this variable is
set.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
v2:
 - fix warnings with strict option too.
---
 scripts/checkpatch.pl | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 9c4c4a61bc83..bed03c80190c 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -2694,6 +2694,8 @@ sub process {
 
 	my $checklicenseline = 1;
 
+	my $symbol_link = 0;
+
 	sanitise_line_reset();
 	my $line;
 	foreach my $rawline (@rawlines) {
@@ -3564,6 +3566,11 @@ sub process {
 # ignore non-hunk lines and lines being removed
 		next if (!$hunk_line || $line =~ /^-/);
 
+# Check for symbol links
+		if ($line =~ /^new file mode 120000$/) {
+			$symbol_link = 1;
+		}
+
 #trailing whitespace
 		if ($line =~ /^\+.*\015/) {
 			my $herevet = "$here\n" . cat_vet($rawline) . "\n";
@@ -3756,7 +3763,8 @@ sub process {
 				}
 
 				if ($comment !~ /^$/ &&
-				    $rawline !~ m@^\+\Q$comment\E SPDX-License-Identifier: @) {
+				    $rawline !~ m@^\+\Q$comment\E SPDX-License-Identifier: @ &&
+				    $symbol_link =~ 1) {
 					WARN("SPDX_LICENSE_TAG",
 					     "Missing or malformed SPDX-License-Identifier tag in line $checklicenseline\n" . $herecurr);
 				} elsif ($rawline =~ /(SPDX-License-Identifier: .*)/) {
@@ -3867,7 +3875,8 @@ sub process {
 		}
 
 # check for adding lines without a newline.
-		if ($line =~ /^\+/ && defined $lines[$linenr] && $lines[$linenr] =~ /^\\ No newline at end of file/) {
+		if ($line =~ /^\+/ && defined $lines[$linenr] && $lines[$linenr] =~ /^\\ No newline at end of file/ &&
+		    $symbol_link =~ 1) {
 			if (WARN("MISSING_EOF_NEWLINE",
 			         "adding a line without newline at end of file\n" . $herecurr) &&
 			    $fix) {
@@ -5293,7 +5302,7 @@ sub process {
 					 $op eq '*' or $op eq '/' or
 					 $op eq '%')
 				{
-					if ($check) {
+					if ($check && $symbol_link =~ 1) {
 						if (defined $fix_elements[$n + 2] && $ctx !~ /[EW]x[EW]/) {
 							if (CHK("SPACING",
 								"spaces preferred around that '$op' $at\n" . $hereptr)) {
-- 
2.43.0

