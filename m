Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CD3F3FD12C
	for <mptcp@lists.linux.dev>; Mon, 18 May 2026 12:08:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779106095; cv=none; b=OhAaOuAW3BXqpBkBJI0XqZbJaQH0URUGsMHmNsA35oATfRQgumsuoltvNxl75NEqcaKwkZt9P5FUw3e0tJCclrNanwfzX41HknbWJPs7rX/i17GyD7XELCed0zkx4frwbvQxTzcDWUSj3w2exwyvLdg/1rYxw8BVA2fpmFzfMdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779106095; c=relaxed/simple;
	bh=vf6ULtFHWGoesNS/lFZx8DmSpYxPcl4yCQL6/3i2c58=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kRb8GoFT3KwNecypoJWE6WZbPbOHuDJCizg9/2SMrVOXGTqmxBsO59RJWC5cVVCBdL1obvz5PP+5lG7cjaejbfpL3U+Mvoc4ZrNYzDJ6bkCe4EXiZK4ggDbzCsvQz5RAO98RbOn0KT0Duaq0qb4AVD8IFs94pW8UyuqEqUQ0WTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=koWotbX6; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="koWotbX6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4C28C2BCB7;
	Mon, 18 May 2026 12:08:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779106095;
	bh=vf6ULtFHWGoesNS/lFZx8DmSpYxPcl4yCQL6/3i2c58=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=koWotbX693mpP6Uys3rJ4ws97MHQqjobjDmuFu+m5fQUX0If1OQ4xyvT6ED4B134p
	 E0SRVBvddKlu0bFJMAl4XMPTzs9+NkKCBlktxzvZ1EzwVU1G+rfp15vw1YpEmLd8Pz
	 SkBWdZVNZa2n1EkhzPx+vvA5CwPq4lS8AYZ1wNmBNBlMibooLEPJ2j2OkiiArm0qQJ
	 FIi0N25P4qiqXNw4X6YuIUfW9t0GmHsuYpMQibUANJB4fONu9ttJLvAA5mO+46Ug6J
	 2Y5TreyCGDnel/jg9E3z4Pwhsf66fE7iKL6F4puPHbC1+RB1XNsP3eI/XBYwyQ8Cnv
	 jLrCbJUU7m3pw==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>,
	zhenwei pi <zhenwei.pi@linux.dev>,
	Hui Zhu <zhuhui@kylinos.cn>,
	Gang Yan <yangang@kylinos.cn>
Subject: [RFC mptcp-next v13 09/12] selftests: mptcp: nvme: add iopolicy tests
Date: Mon, 18 May 2026 20:07:34 +0800
Message-ID: <8bf6076a51ac30e6f7d247dc91a1df8789cbb519.1779104752.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1779104752.git.tanggeliang@kylinos.cn>
References: <cover.1779104752.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

Add NVMe iopolicy testing to mptcp_nvme.sh, with the default set to
"numa". It can be set to "round-robin" or "queue-depth".

Test results with 4 NVMe multipath paths and round-robin iopolicy show
that TCP and MPTCP achieve similar bandwidth:

 # ./mptcp_nvme.sh tcp 4 round-robin
   READ: bw=455MiB/s (478MB/s), 455MiB/s-455MiB/s (478MB/s-478MB/s),
		io=4665MiB (4891MB), run=10242-10242msec
  WRITE: bw=455MiB/s (477MB/s), 455MiB/s-455MiB/s (477MB/s-477MB/s),
		io=4633MiB (4858MB), run=10184-10184msec

 # ./mptcp_nvme.sh mptcp 4 round-robin
   READ: bw=445MiB/s (466MB/s), 445MiB/s-445MiB/s (466MB/s-466MB/s),
		io=4575MiB (4797MB), run=10287-10287msec
  WRITE: bw=445MiB/s (467MB/s), 445MiB/s-445MiB/s (467MB/s-467MB/s),
		io=4572MiB (4794MB), run=10267-10267msec

A "loss" argument is added to simulate network packet loss. When loss=1,
each veth interface is configured with "delay 5ms loss 0.5%" using tc
qdisc. Under this scenario, TCP performance is reduced by multiples
compared to MPTCP:

 # ./mptcp_nvme.sh tcp 4 round-robin 1
   READ: bw=144MiB/s (151MB/s), 144MiB/s-144MiB/s (151MB/s-151MB/s),
		io=1909MiB (2001MB), run=13231-13231msec
  WRITE: bw=100.0MiB/s (105MB/s), 100.0MiB/s-100.0MiB/s (105MB/s-105MB/s),
		io=1397MiB (1465MB), run=13980-13980msec

 # ./mptcp_nvme.sh mptcp 4 round-robin 1
   READ: bw=428MiB/s (449MB/s), 428MiB/s-428MiB/s (449MB/s-449MB/s),
		io=4524MiB (4743MB), run=10564-10564msec
  WRITE: bw=431MiB/s (452MB/s), 431MiB/s-431MiB/s (452MB/s-452MB/s),
		io=4513MiB (4732MB), run=10481-10481msec

These results demonstrate that MPTCP has better resilience against
packet loss compared to TCP, as it can leverage multiple subflows to
mitigate network degradation.

Co-developed-by: zhenwei pi <zhenwei.pi@linux.dev>
Signed-off-by: zhenwei pi <zhenwei.pi@linux.dev>
Co-developed-by: Hui Zhu <zhuhui@kylinos.cn>
Signed-off-by: Hui Zhu <zhuhui@kylinos.cn>
Co-developed-by: Gang Yan <yangang@kylinos.cn>
Signed-off-by: Gang Yan <yangang@kylinos.cn>
Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 .../testing/selftests/net/mptcp/mptcp_nvme.sh | 70 ++++++++++++++++++-
 1 file changed, 69 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_nvme.sh b/tools/testing/selftests/net/mptcp/mptcp_nvme.sh
index 2bb20d30e397..b5b4d732140f 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_nvme.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_nvme.sh
@@ -6,6 +6,8 @@
 ret=0
 trtype="${1:-mptcp}"
 path="${2:-1}"
+iopolicy=${3:-"numa"} # round-robin, queue-depth
+loss=${4:-0}
 nqn="nqn.2014-08.org.nvmexpress.${trtype}dev.$$.${RANDOM}"
 ns=1
 port=$((RANDOM % 10000 + 20000))
@@ -17,6 +19,7 @@ loop_dev=""
 
 export trtype path nqn ns port trsvcid
 export loop_dev temp_file
+export iopolicy loss
 
 usage()
 {
@@ -24,10 +27,12 @@ usage()
 
 Usage:
 
-	$(basename "$0") [trtype] [path]
+	$(basename "$0") [trtype] [path] [iopolicy] [loss]
 
 	trtype   Transport type (tcp|mptcp) - default: mptcp
 	path     Number of multipath (1-4) - default: 1
+	iopolicy I/O policy (numa|round-robin|queue-depth) - default: numa
+	loss     Enable packet loss (0|1) - default: 0
 
 EOF
 exit ${KSFT_FAIL}
@@ -44,6 +49,16 @@ validate_params()
 		echo "Invalid path count ${path}. Must be between 1 and 4"
 		usage
 	fi
+
+	if [[ ! "${iopolicy}" =~ ^(numa|round-robin|queue-depth)$ ]]; then
+		echo "Invalid iopolicy ${iopolicy}."
+		usage
+	fi
+
+	if [[ ! "${loss}" =~ ^[01]$ ]]; then
+		echo "Invalid loss value ${loss}. Must be 0 or 1"
+		usage
+	fi
 }
 
 # This function is invoked indirectly
@@ -106,6 +121,7 @@ cleanup()
 
 	unset -v trtype path nqn ns port trsvcid
 	unset -v loop_dev temp_file
+	unset -v iopolicy loss
 }
 
 # $tc_args needs word splitting to pass multiple arguments to netem
@@ -114,6 +130,10 @@ init()
 {
 	local tc_args="rate 1000mbit"
 
+	if [ "${loss}" -eq 1 ]; then
+		tc_args+=" delay 5ms loss 0.5%"
+	fi
+
 	mptcp_lib_ns_init ns1 ns2
 
 	# ns1		ns2
@@ -194,6 +214,48 @@ run_target()
 	done
 }
 
+# This function is invoked indirectly
+#shellcheck disable=SC2317,SC2329
+set_io_policy()
+{
+	local nqn="$1"
+	local iopolicy="$2"
+	local subname
+	local policy
+	local current
+
+	subname=$(nvme list-subsys 2>/dev/null | grep "${nqn}" |
+		  grep -o 'nvme-subsys[0-9]*' | head -1)
+	if [ -z "$subname" ]; then
+		return 1
+	fi
+
+	policy="/sys/class/nvme-subsystem/${subname}/iopolicy"
+	if [ ! -e "$policy" ]; then
+		# NVMe multipath not supported, skip iopolicy setting
+		return 0
+	fi
+
+	if [ ! -w "$policy" ]; then
+		return 1
+	fi
+
+	if ! echo "${iopolicy}" > "$policy" 2>/dev/null; then
+		return 1
+	fi
+
+	current=$(cat "$policy" 2>/dev/null)
+	if [ -z "$current" ]; then
+		return 1
+	fi
+
+	if [[ "$current" != *"${iopolicy}"* ]]; then
+		return 1
+	fi
+
+	return 0
+}
+
 # This function is invoked indirectly
 #shellcheck disable=SC2317,SC2329
 run_host()
@@ -243,6 +305,11 @@ run_host()
 		return 1
 	fi
 
+	if ! set_io_policy "${nqn}" "${iopolicy}"; then
+		echo "Failed to set I/O policy to ${iopolicy}"
+		return 1
+	fi
+
 	sleep 1
 
 	echo "fio randread /dev/${devname}"
@@ -308,6 +375,7 @@ run_test()
 	fi
 
 	if ! ip netns exec "$ns2" bash <<- EOF
+		$(declare -f set_io_policy)
 		$(declare -f run_host)
 		run_host
 		exit \$?
-- 
2.53.0

