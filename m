Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92B7184FB0
	for <mptcp@lists.linux.dev>; Fri, 24 May 2024 15:14:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716563648; cv=none; b=O5Y3EUh6Ig/L3jTeuqWJIUQ23xfQF8YrrFrbLl/TRNSYSJFAglSmljl89JpAf7ZP5oWjSnKfLOtmv8Dni8ZorOc8LR77uNQo6BoBiX/Cj5eZMeYojnzDaj2sRdUn8rAKTrv5s9uzH8ryv5psJf0YC3jJqH/DbYI2R/2rKXZibn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716563648; c=relaxed/simple;
	bh=DtCExlmNCV5nIVF1XfgLqzZeQrnTvaIAbFhZvqoCSRI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HqVWkOoy5xR89CET4pFN6j2LKb2vWknfPD291jsN2MMgR9686Y+I4xtr8lmY8oMK7GgjoPLalhfSZKBKNye0H2zjVjmdFgRfoXLmLBt6dvg/aF8pTxpqyfcYru947bZBhUFKgDqtMF3dgTFKl+aifg49YnWZTQzH+xqH7/eg9Bo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=raj9qvzM; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="raj9qvzM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83247C4AF08;
	Fri, 24 May 2024 15:14:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716563648;
	bh=DtCExlmNCV5nIVF1XfgLqzZeQrnTvaIAbFhZvqoCSRI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=raj9qvzMQrzZrbJfER06CuucXqwgm0KW35UCQ+jr2T4ep6Iri6mrI18SRmUwooDKi
	 k5nn6lw5ZdWjw1ModRIA7QeFdBUtydMI2ZL/D7CiIIPK4dLV0T2UDfvcQqKzIsKrpm
	 k7fB7uFTREbQqXy6WAp7ZOm/f7yUbPVLG934q3gFO+Sg+JlBoILPIcxoYycC5bTggh
	 nWTKgfqCL2jTWMovHR24FpE0jhEs2XWzWFgYhRpowZlId6Iln/UInxezQdg3V8x8Um
	 2gMfkolFPUBUpVgxLxjGuxE9ZYkGX91E5xw08z2JORxqkR7R7QMdNthBBLuq3x0ENy
	 64nLj2xm8tV1Q==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri, 24 May 2024 17:13:32 +0200
Subject: [PATCH mptcp-next v5 9/9] selftests: mptcp: lib: use
 wait_local_port_listen helper
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240524-selftests-net-lib-fixes-v5-9-b9e0968571a3@kernel.org>
References: <20240524-selftests-net-lib-fixes-v5-0-b9e0968571a3@kernel.org>
In-Reply-To: <20240524-selftests-net-lib-fixes-v5-0-b9e0968571a3@kernel.org>
To: mptcp@lists.linux.dev
Cc: geliang@kernel.org, "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, 
 Geliang Tang <tanggeliang@kylinos.cn>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1366; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=M4yuN0/x24oDKmyONxrmmlEBz0wy8GcFXZxdRY1Nt+4=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBmUK6zSNMHBaCafwtQveN+v2eSY/WbWzNRPBKRe
 B1136Na6JSJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZlCuswAKCRD2t4JPQmmg
 c9DSEACytNz1P9iMB3gjbzRdwm8431KKMdrHrdGoiI/G7VcodD5CxbPXdadajn+m1s+LffeDA6Y
 dqwoObVyLHY+I60E8WdYEjqizsAypnVWFvgM9/Z2i3zSC2QO8sd7WhgWJdo9YiyRmUh+OgN/OS3
 OrAaqyd07GqnaPQITZYMr+dpi5WOqVJLg2qh4RUNC42/OrMUIwlhHckHQfzIb4d+BefDCe0Btii
 AgwBn7TKr11SyP0BT3cW/NeS0IIReKPxVghyeOZGdfIY1wjb+pEtw4NiUaLvdnz9APBg+coWK6U
 T7WQHYizAKbPU+Q1FCETUa8JMpHvXgFhYCnNbKdjmKuyyB1u1yVR92LOY1RTxoYREchEuHFJFm0
 hLVs3Jl4q5C3sMz3Bul03CTl35+SyXOVgQxzg3nt4Vjs82VLgiqC2ikLHk0SJZhNQC6nbEAKbYI
 9fI+7wCJpEwnDtF8X2kLwej3spd5Xr4LVgczBUYg0tIIYLOnIBtFD2ubqn2i0vmTSVhn/Rcvav3
 A1qmQo8gC4z/QQ/XbeBKK7p1Oc7b3BORLg5m724MftLXhgCrJxtIzTdGZ7avi9KjFsvCPV+I0oz
 r0Hi91yI5tuTgC+O2Luht1OAfiTVPv4vaNPQdXOQuNMH53gKcK4nIesIlFugfXyTPKoS5Cet4v8
 mKgdO1iQ41urf3g==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

From: Geliang Tang <tanggeliang@kylinos.cn>

This patch includes net_helper.sh into mptcp_lib.sh, uses the helper
wait_local_port_listen() defined in it to implement the similar mptcp
helper. This can drop some duplicate code.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 tools/testing/selftests/net/mptcp/mptcp_lib.sh | 16 ++--------------
 1 file changed, 2 insertions(+), 14 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_lib.sh b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
index d9e30516dc72..194c8fc2e55a 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_lib.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
@@ -2,6 +2,7 @@
 # SPDX-License-Identifier: GPL-2.0
 
 . "$(dirname "${0}")/../lib.sh"
+. "$(dirname "${0}")/../net_helper.sh"
 
 readonly KSFT_PASS=0
 readonly KSFT_FAIL=1
@@ -363,20 +364,7 @@ mptcp_lib_check_transfer() {
 
 # $1: ns, $2: port
 mptcp_lib_wait_local_port_listen() {
-	local listener_ns="${1}"
-	local port="${2}"
-
-	local port_hex
-	port_hex="$(printf "%04X" "${port}")"
-
-	local _
-	for _ in $(seq 10); do
-		ip netns exec "${listener_ns}" cat /proc/net/tcp* | \
-			awk "BEGIN {rc=1} {if (\$2 ~ /:${port_hex}\$/ && \$4 ~ /0A/) \
-			     {rc=0; exit}} END {exit rc}" &&
-			break
-		sleep 0.1
-	done
+	wait_local_port_listen "${@}" "tcp"
 }
 
 mptcp_lib_check_output() {

-- 
2.43.0

