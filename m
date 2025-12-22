Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D54791F5821
	for <mptcp@lists.linux.dev>; Mon, 22 Dec 2025 16:49:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766422141; cv=none; b=jnJPoki0bQioDS/BNm/9budOCUMoDPSim8VVLzp89JwEIYoqTJ1g+xeseMf1so9TQV1NbPyzf6ZWwZKjQdikNcb7V/uBp54gcyiBAwGP6jABcPLGGJMvRZhS6WFS2xUPTWmJ/gAZq8a7wKLClrJw0Z3gQ8XWMWP+7IedZObHTdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766422141; c=relaxed/simple;
	bh=IRtBnTSPxMYaSliYgMwFZy+mo7142MCroNmS+70/5uQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=OePTYleA45QU1la1otYEU0IAF5LR7eBHLbsJ7HPoW38EnxJdy2t3YHb8ZTzu9lndS47E0udGE6G0yNLZYjRa7xWO6oNoQCI3nmsRDucTrl5GKdNPRGgIXg/fqgf1qSbChCWA9YSr5Ll7bzye4Tzz87gun/XFO5ZmVa+W7L0MQ0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q9wWcAB0; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q9wWcAB0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14E8CC4CEF1;
	Mon, 22 Dec 2025 16:49:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766422141;
	bh=IRtBnTSPxMYaSliYgMwFZy+mo7142MCroNmS+70/5uQ=;
	h=From:Date:Subject:To:Cc:From;
	b=q9wWcAB0PsKBoVESyfNVTdyzJbCvQIqY8ZrTHsbkFxNMBy5MvcBiBJhPOTGqO2Odp
	 h+4oda4KO2R5/GF9o17HHgzJMvqqIw/vv8BmgAvX5LWfxG3Q/DzUPtzWn8oPyHsyZ8
	 ZJcKurJ/i8/FlsEHUVVY5iRZ0M/Q7pObKVAbcNfR7sydsbjmVj0KwxS8RqIyGzBbT7
	 +DI1Lxu40p16S4ubhwEG8yajTgc3tsvtevHdw0tJ6TqaVMIAz+67AKt7Cw58XUm7hz
	 /bG5cqs5PtVS/iU0ichUR+wvXWtsX1WDbDLuDgvbViVHoQyvJphyDcw0m2gBWEqerZ
	 QUS/eV3MXg+Fw==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Mon, 22 Dec 2025 17:48:54 +0100
Subject: [PATCH mptcp-net] selftests: mptcp: join: fix local endp not being
 tracked
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251222-sft-5-15-signal-race-test-v1-1-a9b67c49af15@kernel.org>
X-B4-Tracking: v=1; b=H4sIAHV2SWkC/x3MwQqDMAyA4VeRnBewgeK2VxEPJUYNbF1pwhDEd
 7d4/A7/f4BJVTF4dwdU+avpLzeERwe8pbwK6twM1FMMRIS2OEYMEU3XnD5YEwu6mKNwePLQz/S
 KCVpfqiy63+8RvsW5YBaH6TwvLJwFo3YAAAA=
X-Change-ID: 20251222-sft-5-15-signal-race-test-ec18c70d295a
To: MPTCP Upstream <mptcp@lists.linux.dev>
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2243; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=IRtBnTSPxMYaSliYgMwFZy+mo7142MCroNmS+70/5uQ=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDI9y2qibFVUtDfXFL3oP/qvz5rFTmzXb8n+bD0Fr6Qps
 2bqCAh3lLIwiHExyIopski3RebPfF7FW+LlZwEzh5UJZAgDF6cATMQwm5FhnoSHZfgqVaYzZheO
 z762lzmo2POj0g7zFYIzjFRvvngRysiwrX/1pxcXsq+9fbHldoLXWr3du+793CPw8Eibjuv0Pbv
 r2QE=
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

When running this mptcp_join.sh selftest on older kernel versions not
supporting local endpoints tracking, this test fails because 3 MP_JOIN
ACKs have been received, while only 2 were expected.

It is not clear why only 2 MP_JOIN ACKs were expected on old kernel
versions, while 3 MP_JOIN SYN and SYN+ACK were expected. When testing on
the v5.15.197 kernel, 3 MP_JOIN ACKs are seen, which is also what is
expected in the selftests included in this kernel version, see commit
f4480eaad489 ("selftests: mptcp: add missing join check").

Switch the expected MP_JOIN ACKs to 3. While at it, move this
chk_join_nr helper out of the special condition for older kernel
versions as it is now the same as with more recent ones. Also, invert
the condition to be more logical: what's expected on newer kernel
versions having such helper first.

Fixes: d4c81bbb8600 ("selftests: mptcp: join: support local endpoint being tracked or not")
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 tools/testing/selftests/net/mptcp/mptcp_join.sh | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index b2e6e548f796..f1a0d812e642 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -2329,17 +2329,16 @@ signal_address_tests()
 		ip netns exec $ns1 sysctl -q net.mptcp.add_addr_timeout=1
 		speed=slow \
 			run_tests $ns1 $ns2 10.0.1.1
+		chk_join_nr 3 3 3
 
 		# It is not directly linked to the commit introducing this
 		# symbol but for the parent one which is linked anyway.
-		if ! mptcp_lib_kallsyms_has "mptcp_pm_subflow_check_next$"; then
-			chk_join_nr 3 3 2
-			chk_add_nr 4 4
-		else
-			chk_join_nr 3 3 3
+		if mptcp_lib_kallsyms_has "mptcp_pm_subflow_check_next$"; then
 			# the server will not signal the address terminating
 			# the MPC subflow
 			chk_add_nr 3 3
+		else
+			chk_add_nr 4 4
 		fi
 	fi
 }

---
base-commit: fab1280894b693ae0b9bb08f21f74852f112db79
change-id: 20251222-sft-5-15-signal-race-test-ec18c70d295a

Best regards,
-- 
Matthieu Baerts (NGI0) <matttbe@kernel.org>

