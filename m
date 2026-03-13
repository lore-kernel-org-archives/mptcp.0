Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3477617A300
	for <mptcp@lists.linux.dev>; Fri, 13 Mar 2026 04:13:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773375209; cv=none; b=MFS2gvj4c8lodPsKMGUw29MgIzzeuyIHPHw+a0KJ55iLQ8/Ea7bzs9fTSZYSXEy7QSbXggqMSou8Bd33lPzeUG/L3f/6NeXJG2E8Xjw4W9Ym05RYbIcRA7Xkh4cCI3TxbQRP/op9wm1bhkfCPTGuH7w7bljflSUh6Rz2c4qdQyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773375209; c=relaxed/simple;
	bh=cEGyVy8n1tJGXZ/PViBX1eqnGOgVTI/bDDBTDVx79R4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BxcmDEqO9zi1XcCakvs/yeuf8BQBfDeVdFBVelmIwHTMZoeTB+bWQ0AsSvr3eF19QsA3jrP41EhU7CgNYrI3c5J9HDvEK0gxOtDrDv5ibKYHJ6PGM9UVLGxHGAyEXuYw8gmoB8KNnST+R+itQ0dqYKgEkrf+T2FWFLAUAwuCuDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ez5w9Wl0; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ez5w9Wl0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 735CBC19421;
	Fri, 13 Mar 2026 04:13:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773375208;
	bh=cEGyVy8n1tJGXZ/PViBX1eqnGOgVTI/bDDBTDVx79R4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Ez5w9Wl0oQhINcIYrhQjsTXrJPYXyf6Ts8V8/n4YmsT+QA3KCD2hcpzoh0o8/PHGx
	 e5JFBfvg8Ve5f0bICo4cT4x2MsBp4gXOlmo14eO8jR5bzAuqskfoBsDQLo+7/3+KYl
	 7Zg2bOBraLLP0APhiykd2J8anNhk8pfBOWJJy+tELs2ARjbaNRzdET2PvUk9836+mL
	 c1M67ytXpZY01x9RonhSH/LcoEqwvVK2gsQIe56oe2N8No2h+2Zqkdbx+do15NawsK
	 ATGEg0sdleLfW5f0yTD0/otPQnfF//18nUZBxue6KucwGEQ6XAHeULujLy1wdR7V89
	 vA/t6XhlNVx1Q==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>,
	Nilay Shroff <nilay@linux.ibm.com>,
	Ming Lei <ming.lei@redhat.com>,
	zhenwei pi <zhenwei.pi@linux.dev>,
	Hui Zhu <zhuhui@kylinos.cn>,
	Gang Yan <yangang@kylinos.cn>
Subject: [RFC mptcp-next v5 7/7] selftests: mptcp: add NVMe over MPTCP test
Date: Fri, 13 Mar 2026 12:12:51 +0800
Message-ID: <11d42b89963a3b1a8a9d39c7044dcee5cd49ffcd.1773374342.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1773374342.git.tanggeliang@kylinos.cn>
References: <cover.1773374342.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

A test case for NVMe over MPTCP has been implemented. It verifies the
proper functionality of nvme list, discover, connect, and disconnect
commands. Additionally, read/write performance has been evaluated using
fio.

This test simulats four NICs on both target and host sides, each limited
to 100MB/s. It shows that 'NVMe over MPTCP' delivered bandwidth up to
four times that of standard TCP:

 # ./mptcp_nvme.sh tcp
  READ: bw=112MiB/s (118MB/s), 112MiB/s-112MiB/s (118MB/s-118MB/s),
		io=1123MiB (1177MB), run=10018-10018msec
  WRITE: bw=112MiB/s (117MB/s), 112MiB/s-112MiB/s (117MB/s-117MB/s),
		io=1118MiB (1173MB), run=10018-10018msec

 # ./mptcp_nvme.sh mptcp
  READ: bw=427MiB/s (448MB/s), 427MiB/s-427MiB/s (448MB/s-448MB/s),
		io=4286MiB (4494MB), run=10039-10039msec
  WRITE: bw=387MiB/s (406MB/s), 387MiB/s-387MiB/s (406MB/s-406MB/s),
		io=3885MiB (4073MB), run=10043-10043msec

Also add NVMe iopolicy testing to mptcp_nvme.sh, with the default set
to "numa". It can be set to "round-robin" or "queue-depth".

 # ./mptcp_nvme.sh mptcp round-robin

Cc: Nilay Shroff <nilay@linux.ibm.com>
Cc: Ming Lei <ming.lei@redhat.com>
Co-developed-by: zhenwei pi <zhenwei.pi@linux.dev>
Signed-off-by: zhenwei pi <zhenwei.pi@linux.dev>
Co-developed-by: Hui Zhu <zhuhui@kylinos.cn>
Signed-off-by: Hui Zhu <zhuhui@kylinos.cn>
Co-developed-by: Gang Yan <yangang@kylinos.cn>
Signed-off-by: Gang Yan <yangang@kylinos.cn>
Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 tools/testing/selftests/net/mptcp/Makefile    |   1 +
 tools/testing/selftests/net/mptcp/config      |   7 +
 .../testing/selftests/net/mptcp/mptcp_nvme.sh | 205 ++++++++++++++++++
 3 files changed, 213 insertions(+)
 create mode 100755 tools/testing/selftests/net/mptcp/mptcp_nvme.sh

diff --git a/tools/testing/selftests/net/mptcp/Makefile b/tools/testing/selftests/net/mptcp/Makefile
index 22ba0da2adb8..7b308447a58b 100644
--- a/tools/testing/selftests/net/mptcp/Makefile
+++ b/tools/testing/selftests/net/mptcp/Makefile
@@ -13,6 +13,7 @@ TEST_PROGS := \
 	mptcp_connect_sendfile.sh \
 	mptcp_connect_splice.sh \
 	mptcp_join.sh \
+	mptcp_nvme.sh \
 	mptcp_sockopt.sh \
 	pm_netlink.sh \
 	simult_flows.sh \
diff --git a/tools/testing/selftests/net/mptcp/config b/tools/testing/selftests/net/mptcp/config
index 59051ee2a986..0eee348eff8b 100644
--- a/tools/testing/selftests/net/mptcp/config
+++ b/tools/testing/selftests/net/mptcp/config
@@ -34,3 +34,10 @@ CONFIG_NFT_SOCKET=m
 CONFIG_NFT_TPROXY=m
 CONFIG_SYN_COOKIES=y
 CONFIG_VETH=y
+CONFIG_CONFIGFS_FS=y
+CONFIG_NVME_CORE=y
+CONFIG_NVME_FABRICS=y
+CONFIG_NVME_TCP=y
+CONFIG_NVME_TARGET=y
+CONFIG_NVME_TARGET_TCP=y
+CONFIG_NVME_MULTIPATH=y
diff --git a/tools/testing/selftests/net/mptcp/mptcp_nvme.sh b/tools/testing/selftests/net/mptcp/mptcp_nvme.sh
new file mode 100755
index 000000000000..bc201a300b72
--- /dev/null
+++ b/tools/testing/selftests/net/mptcp/mptcp_nvme.sh
@@ -0,0 +1,205 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+
+. "$(dirname "$0")/mptcp_lib.sh"
+
+ret=0
+trtype="${1:-mptcp}"
+iopolicy=${2:-"numa"} # round-robin, queue-depth
+nqn=nqn.2014-08.org.nvmexpress.${trtype}dev
+ns=1
+port=1234
+trsvcid=4420
+ns1=""
+ns2=""
+
+ns1_cleanup()
+{
+	mount -t configfs none /sys/kernel/config
+
+	rm -rf /sys/kernel/config/nvmet/ports/"${port}"/subsystems/"${trtype}"subsys
+	rmdir /sys/kernel/config/nvmet/ports/"${port}"
+	echo 0 > /sys/kernel/config/nvmet/subsystems/"${nqn}"/namespaces/"${ns}"/enable
+	echo -n 0 > /sys/kernel/config/nvmet/subsystems/"${nqn}"/namespaces/"${ns}"/device_path
+	rmdir /sys/kernel/config/nvmet/subsystems/"${nqn}"/namespaces/"${ns}"
+	rmdir /sys/kernel/config/nvmet/subsystems/"${nqn}"
+}
+
+ns2_cleanup()
+{
+	nvme disconnect -n "${nqn}" || true
+}
+
+cleanup()
+{
+	ip netns exec "$ns2" bash <<- EOF
+		$(declare -f ns2_cleanup)
+		ns2_cleanup
+	EOF
+
+	sleep 1
+
+	ip netns exec "$ns1" bash <<- EOF
+		$(declare -f ns1_cleanup)
+		ns1_cleanup
+	EOF
+
+	losetup -d /dev/loop100
+	rm -rf /tmp/test.raw
+
+	mptcp_lib_ns_exit "$ns1" "$ns2"
+
+	kill "$monitor_pid_ns1" 2>/dev/null
+	wait "$monitor_pid_ns1" 2>/dev/null
+
+	kill "$monitor_pid_ns2" 2>/dev/null
+	wait "$monitor_pid_ns2" 2>/dev/null
+
+	unset -v trtype nqn ns port trsvcid
+}
+
+init()
+{
+	mptcp_lib_ns_init ns1 ns2
+
+	# ns1		ns2
+	# 10.1.1.1	10.1.1.2
+	# 10.1.2.1	10.1.2.2
+	# 10.1.3.1	10.1.3.2
+	# 10.1.4.1	10.1.4.2
+	for i in {1..4}; do
+		ip link add ns1eth"$i" netns "$ns1" type veth peer name ns2eth"$i" netns "$ns2"
+		ip -net "$ns1" addr add 10.1."$i".1/24 dev ns1eth"$i"
+		ip -net "$ns1" addr add dead:beef:"$i"::1/64 dev ns1eth"$i" nodad
+		ip -net "$ns1" link set ns1eth"$i" up
+		ip -net "$ns2" addr add 10.1."$i".2/24 dev ns2eth"$i"
+		ip -net "$ns2" addr add dead:beef:"$i"::2/64 dev ns2eth"$i" nodad
+		ip -net "$ns2" link set ns2eth"$i" up
+		ip -net "$ns2" route add default via 10.1."$i".1 dev ns2eth"$i" metric 10"$i"
+		ip -net "$ns2" route add default via dead:beef:"$i"::1 dev ns2eth"$i" metric 10"$i"
+
+		# Add tc qdisc to both namespaces for bandwidth limiting
+		tc -n "$ns1" qdisc add dev ns1eth"$i" root netem rate 1000mbit
+		tc -n "$ns2" qdisc add dev ns2eth"$i" root netem rate 1000mbit
+	done
+
+	mptcp_lib_pm_nl_set_limits "${ns1}" 8 8
+
+	mptcp_lib_pm_nl_add_endpoint "$ns1" 10.1.2.1 flags signal
+	mptcp_lib_pm_nl_add_endpoint "$ns1" 10.1.3.1 flags signal
+	mptcp_lib_pm_nl_add_endpoint "$ns1" 10.1.4.1 flags signal
+
+	mptcp_lib_pm_nl_set_limits "${ns2}" 8 8
+
+	mptcp_lib_pm_nl_add_endpoint "$ns2" 10.1.2.2 flags subflow
+	mptcp_lib_pm_nl_add_endpoint "$ns2" 10.1.3.2 flags subflow
+	mptcp_lib_pm_nl_add_endpoint "$ns2" 10.1.4.2 flags subflow
+
+	ip -n "${ns1}" mptcp monitor &
+	monitor_pid_ns1=$!
+	ip -n "${ns2}" mptcp monitor &
+	monitor_pid_ns2=$!
+}
+
+run_target()
+{
+	mount -t configfs none /sys/kernel/config
+
+	cd /sys/kernel/config/nvmet/subsystems || exit
+	mkdir -p "${nqn}"
+	cd "${nqn}" || exit
+	echo 1 > attr_allow_any_host
+	mkdir -p namespaces/"${ns}"
+	echo /dev/loop100 > namespaces/"${ns}"/device_path
+	echo 1 > namespaces/"${ns}"/enable
+
+	cd /sys/kernel/config/nvmet/ports || exit
+	mkdir -p "${port}"
+	cd "${port}" || exit
+	echo "${trtype}" > addr_trtype
+	echo ipv4 > addr_adrfam
+	echo 0.0.0.0 > addr_traddr
+	echo "${trsvcid}" > addr_trsvcid
+
+	cd subsystems || exit
+	ln -sf ../../../subsystems/"${nqn}" "${trtype}"subsys
+}
+
+run_host()
+{
+	local traddr=10.1.1.1
+
+	echo "nvme discover -a ${traddr}"
+	nvme discover -t "${trtype}" -a "${traddr}" -s "${trsvcid}"
+	if [ $? -ne 0 ]; then
+		return "${KSFT_FAIL}"
+	fi
+
+	echo "nvme connect"
+	devname=$(nvme connect -t "${trtype}" -a "${traddr}" -s "${trsvcid}" -n "${nqn}" |
+		  awk '{print $NF}')
+
+	sleep 1
+
+	echo "nvme list"
+	nvme list
+
+	subname=$(nvme list-subsys /dev/"${devname}"n1 |
+		  grep -o 'nvme-subsys[0-9]*' | head -1)
+
+	echo "${iopolicy}" > /sys/class/nvme-subsystem/"${subname}"/iopolicy
+	cat /sys/class/nvme-subsystem/"${subname}"/iopolicy
+
+	echo "fio randread /dev/${devname}n1"
+	fio --name=global --direct=1 --norandommap --randrepeat=0 --ioengine=libaio \
+	    --thread=1 --blocksize=4k --runtime=10 --time_based --rw=randread --numjobs=4 \
+	    --iodepth=256 --group_reporting --size=100% --name=libaio_4_256_4k_randread \
+	    --size=4m --filename=/dev/"${devname}"n1
+
+	sleep 1
+
+	echo "fio randwrite /dev/${devname}n1"
+	fio --name=global --direct=1 --norandommap --randrepeat=0 --ioengine=libaio \
+	    --thread=1 --blocksize=4k --runtime=10 --time_based --rw=randwrite --numjobs=4 \
+	    --iodepth=256 --group_reporting --size=100% --name=libaio_4_256_4k_randwrite \
+	    --size=4m --filename=/dev/"${devname}"n1
+
+	nvme flush /dev/"${devname}"n1
+
+	sleep 1
+}
+
+init
+trap cleanup EXIT
+
+dd if=/dev/zero of=/tmp/test.raw bs=1M count=0 seek=512
+losetup /dev/loop100 /tmp/test.raw
+
+run_test()
+{
+	export trtype nqn ns port trsvcid
+	export iopolicy
+
+	if ! ip netns exec "$ns1" bash <<- EOF
+		$(declare -f run_target)
+		run_target
+		exit \$?
+	EOF
+	then
+		ret="${KSFT_FAIL}"
+	fi
+
+	if ! ip netns exec "$ns2" bash <<- EOF
+		$(declare -f run_host)
+		run_host
+		exit \$?
+	EOF
+	then
+		ret="${KSFT_FAIL}"
+	fi
+}
+
+run_test "$@"
+
+mptcp_lib_result_print_all_tap
+exit "$ret"
-- 
2.53.0

