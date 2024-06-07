Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15A556FC6;
	Fri,  7 Jun 2024 01:12:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717722766; cv=none; b=J/xcHASvgJeW44cjD8dvpIgpMW+rsuIi2mfJel3lwQylt12fxruOsyaXfWnAsd0nDZbTUnKn/YJ9F/eiAeji9ETow+AthYS+1ydBjuc6zeN2B6aKwpQpxA/Sx+th0DQFpIlVjBVE9/xD2xRI8eZInQtCiMJ398VPBovlCon6CRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717722766; c=relaxed/simple;
	bh=XPOYOcI/jkb4WsiKptpzNp3hFHwQDejsMNU9oEnBh2I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CYBFnnVv20yS/KEKy8rK2ImxfNPc8pPLom9MRFm44S55cPXXLKpLzbVtCkb+5wYz8mXg7DVrl45u1mCNqgC5Om4Pn+DeP8V8wvP3t0LolxiUEDD4pr/CPiG38A4TxOmV/7dxBk5UV0czyK/G2AdPTnqCn+Fv0LRiK3ic3uelP3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B6RUjqGp; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B6RUjqGp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5762C2BD10;
	Fri,  7 Jun 2024 01:12:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717722765;
	bh=XPOYOcI/jkb4WsiKptpzNp3hFHwQDejsMNU9oEnBh2I=;
	h=From:To:Cc:Subject:Date:From;
	b=B6RUjqGp14o1q+EAIu1WudbyK+OxfNZStmmgDx+M8j9JyFX4R9ERRxVKez+IZTQ/j
	 Jwv5ZwHZrhHbJvkgMZhY39nIGgujq5MaGh7u3fcpNCTAzcseql/XDDnbUd9xPp+bJw
	 SrwzBM31qsmw1WQTQ1g+K/ubYO3FFaquGLus5n4Jbhxkd98NH9HjJ2+o04YqtSVg0q
	 qenclr7a77BufpzGe8qOOs5bG73pMT+jtqTrAep9fuZbTXPZcyT+SajU37x1ci6qIl
	 Ldac0S/N28f3im7l6UqhD+yMFATKFj6by4H/3GT0dJY70lv3w4oV59M8qqSE5BkzkG
	 +0+pjo7cls2Pw==
From: Geliang Tang <geliang@kernel.org>
To: Andy Whitcroft <apw@canonical.com>,
	Joe Perches <joe@perches.com>,
	Dwaipayan Ray <dwaipayanray1@gmail.com>,
	Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc: Geliang Tang <tanggeliang@kylinos.cn>,
	linux-kernel@vger.kernel.org,
	mptcp@lists.linux.dev
Subject: [RESEND PATCH v2] checkpatch: skip warnings for symbol links
Date: Fri,  7 Jun 2024 09:12:37 +0800
Message-ID: <dc502b1b45cb27fda48d72d73e3267a32db023d8.1717722648.git.tanggeliang@kylinos.cn>
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
index 2b812210b412..1f3ce5ffe914 100755
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

