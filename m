Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C9873859DE
	for <mptcp@lists.linux.dev>; Sat, 16 May 2026 08:29:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778920146; cv=none; b=rmlCavM+TovS223w3vL+FyIS+0vM4PuFU7JKssLKp8oKNcVcG/8HvBGoBKOAOOQMPb1CKSCLRH7oMo0flV7eGnyzQ+vmF5NxyVkm62GfHiJJabm0/VNWAtxEpjVpleBo2YdqF1SMh/b+xZONoPRwasp6AtWoeyXIcQ5bgmc76Ys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778920146; c=relaxed/simple;
	bh=44yqZNHggru7StIPnN+9PMMvG9n4S89wyuuffMJeonM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Jc1BBoQ+cXERlBhf/vjQ/6F7xDbfBGM3QLP1uVjPWfHEsLrxlwXHy2P/rSX6ODdugVRthVK4a9vQdJCQqjqcr8o19PnlS7/013oliraNN3qhStKaseAMwQRbQQwr0wxV0Zi/Vne8cUAyPBmwb2XxK4ZzKcfKjAJdQ2pgtSnou4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gzji5TQ0; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gzji5TQ0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8001C2BCB7;
	Sat, 16 May 2026 08:29:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778920146;
	bh=44yqZNHggru7StIPnN+9PMMvG9n4S89wyuuffMJeonM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gzji5TQ09UFkp9wAa5Zx9DLdpv2aN4c/Tk/loU8bWGTqekokuLFE4Tv+qLva47b9g
	 P5105vCDjVIudPWBYY8IxfQJhRU58T3K2O2AAYBgCep2hOLrKAdU4+nrwUxlAQnjNS
	 ze3B/zNOChuo4SMXW5MM2cZgX6nJp1Dt8xdIkJnyab/o0w1eipjRjkIukftfUx+79V
	 9+Zm1Rov0BQOeyUZZCof5ZhJuxDgeOD4Q5ba8KI4OgWVb5eURdiygotmEOuP5N+/AF
	 7t7I7BtkkojEkV8UTvDG+dxCkMYGUTdechtvi+TgYelf4DuNeujorUAcZZSN7VDN+b
	 MZ/nZJNHsMjfg==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>,
	Hannes Reinecke <hare@suse.de>,
	zhenwei pi <zhenwei.pi@linux.dev>,
	Hui Zhu <zhuhui@kylinos.cn>,
	Gang Yan <yangang@kylinos.cn>
Subject: [RFC mptcp-next v10 9/9] selftests: mptcp: nvme: add iopolicy tests
Date: Sat, 16 May 2026 16:27:57 +0800
Message-ID: <1d36e5b833250836db9f24e32473bf19431156cd.1778919284.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1778919284.git.tanggeliang@kylinos.cn>
References: <cover.1778919284.git.tanggeliang@kylinos.cn>
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

Cc: Hannes Reinecke <hare@suse.de>
Co-developed-by: zhenwei pi <zhenwei.pi@linux.dev>
Signed-off-by: zhenwei pi <zhenwei.pi@linux.dev>
Co-developed-by: Hui Zhu <zhuhui@kylinos.cn>
Signed-off-by: Hui Zhu <zhuhui@kylinos.cn>
Co-developed-by: Gang Yan <yangang@kylinos.cn>
Signed-off-by: Gang Yan <yangang@kylinos.cn>
Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 .../testing/selftests/net/mptcp/mptcp_nvme.sh | 67 ++++++++++++++++++-
 1 file changed, 64 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_nvme.sh b/tools/testing/selftests/net/mptcp/mptcp_nvme.sh
index 1bd76e245a18..465a7c9cf4ce 100755
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
@@ -21,10 +23,12 @@ usage()
 
 Usage:
 
-	$(basename "$0") [trtype] [path]
+	$(basename "$0") [trtype] [path] [iopolicy] [loss]
 
 	trtype   Transport type (tcp|mptcp) - default: mptcp
 	path     Number of multipath (1-4) - default: 1
+	iopolicy I/O policy (numa|round-robin|queue-depth) - default: numa
+	loss     Enable packet loss (0|1) - default: 0
 
 EOF
 exit 0
@@ -46,6 +50,16 @@ validate_params()
 		echo "Warning: path count ${path} > 4, limiting to 4"
 		path=4
 	fi
+
+	if [[ ! "${iopolicy}" =~ ^(numa|round-robin|queue-depth)$ ]]; then
+		echo "Error: Invalid iopolicy ${iopolicy}."
+		usage
+	fi
+
+	if [[ ! "${loss}" =~ ^[01]$ ]]; then
+		echo "Error: Invalid loss value ${loss}. Must be 0 or 1"
+		usage
+	fi
 }
 
 # This function is invoked indirectly
@@ -107,6 +121,7 @@ cleanup()
 	wait "$monitor_pid_ns2" 2>/dev/null
 
 	unset -v trtype path nqn ns port trsvcid
+	unset iopolicy loss
 }
 
 init()
@@ -135,8 +150,10 @@ init()
 					dev ns2eth"$i" metric 10"$i"
 
 		# Add tc qdisc to both namespaces for bandwidth limiting
-		tc -n "$ns1" qdisc add dev ns1eth"$i" root netem rate 1000mbit
-		tc -n "$ns2" qdisc add dev ns2eth"$i" root netem rate 1000mbit
+		tc -n "$ns1" qdisc add dev ns1eth"$i" root netem rate 1000mbit \
+			$([ "${loss}" -eq 1 ] && echo "delay 5ms loss 0.5%")
+		tc -n "$ns2" qdisc add dev ns2eth"$i" root netem rate 1000mbit \
+			$([ "${loss}" -eq 1 ] && echo "delay 5ms loss 0.5%")
 
 		tc -n "$ns1" qdisc show dev ns1eth"$i"
 		tc -n "$ns2" qdisc show dev ns2eth"$i"
@@ -196,6 +213,43 @@ run_target()
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
@@ -242,6 +296,11 @@ run_host()
 	echo "nvme list"
 	nvme list
 
+	if ! set_io_policy "${nqn}" "${iopolicy}"; then
+		echo "Failed to set I/O policy to ${iopolicy}"
+		return 1
+	fi
+
 	sleep 1
 
 	echo "fio randread /dev/${devname}"
@@ -286,6 +345,7 @@ run_test()
 {
 	export trtype path nqn ns port trsvcid
 	export loop_dev temp_file
+	export iopolicy loss
 
 	if ! ip netns exec "$ns1" unshare -m bash <<- EOF
 		mount -t configfs none /sys/kernel/config
@@ -298,6 +358,7 @@ run_test()
 	fi
 
 	if ! ip netns exec "$ns2" bash <<- EOF
+		$(declare -f set_io_policy)
 		$(declare -f run_host)
 		run_host
 		exit \$?
-- 
2.53.0

