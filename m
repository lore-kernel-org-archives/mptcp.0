Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C68A21E2614
	for <mptcp@lists.linux.dev>; Mon,  9 Feb 2026 09:04:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770627891; cv=none; b=klxTqmS/F9I/Pu63/+JCPn/at1EqT0Co1l6h4LRSbnbbPgApBXvoPcyW1Mfw9WubFFRJg04VN2SMc/07SK+5xCkctSCHhqm6tOZWG6OdBmYPUQYQ2jnb72Ii0J6LP9WXDJezEfOcT0C10xPfBDIGPST92IB0ggCC9OWQqUSzi7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770627891; c=relaxed/simple;
	bh=fQ6EIrWkx/fQrUxe1K423djUdSzMM9ycX8P8o+hPhcc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OYJLxPHN7ldhqWRI6sbJAkK8CawUBwDmC9hu96mL2MmAZ1zMBOin0kRMoHsEFm54PSboK52f4m4th4eWGB4wZbHmYZGF1kKi2N4GwamnNEOb8HgxndX9T8yDkhcclMkmISsQJA8rNLwQCgZSgh3vfdjaX+1vploie7n3ZQBLS58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JKE7ZjrY; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JKE7ZjrY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8755FC116C6;
	Mon,  9 Feb 2026 09:04:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770627891;
	bh=fQ6EIrWkx/fQrUxe1K423djUdSzMM9ycX8P8o+hPhcc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JKE7ZjrYvoZlSml9C1cuHNqZq+p/efbLBQzATYkVNz/4dhrhe99C2qd3UDRd44yIb
	 E9v/mHp7w6/EpdUpfHZOkzJY2GPOUAPmBiIFGLXlkNfv8FIRcqmSdKhwxhay/7KbCu
	 iOedRG/zWgI7RU9JEz/3Tbq0h2UxuXEIn536yU5L3jcs2U8YTtosTDl7vm+gVd9b9K
	 y0SzSE4WT5b/qvXbIhFk+10gFvU2ZOckaaoORN7P+0Do66ROFbuZJbGY077Vg0XXis
	 X8oXHuZtJ7nOhUqdA7BKzhz0FfEuGI2QtJNxZA6zCEmjVjTPBdZ3FvC39vcsrFFxfm
	 yIuSbkAz8RtNQ==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>,
	zhenwei pi <zhenwei.pi@linux.dev>,
	Hui Zhu <zhuhui@kylinos.cn>,
	Gang Yan <yangang@kylinos.cn>
Subject: [RFC mptcp-next v3 7/7] selftests: mptcp: add NVMe-over-MPTCP test
Date: Mon,  9 Feb 2026 17:04:22 +0800
Message-ID: <57c6dbf2e50b06c5ec21cb4db0eac51a5b31756b.1770627071.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1770627071.git.tanggeliang@kylinos.cn>
References: <cover.1770627071.git.tanggeliang@kylinos.cn>
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

This test simulats four NICs on both target and host sides, it shows
that 'NVMe over MPTCP' delivered bandwidth up to four times that of
standard TCP.

Co-developed-by: zhenwei pi <zhenwei.pi@linux.dev>
Signed-off-by: zhenwei pi <zhenwei.pi@linux.dev>
Co-developed-by: Hui Zhu <zhuhui@kylinos.cn>
Signed-off-by: Hui Zhu <zhuhui@kylinos.cn>
Co-developed-by: Gang Yan <yangang@kylinos.cn>
Signed-off-by: Gang Yan <yangang@kylinos.cn>
Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 tools/testing/selftests/net/mptcp/config      |   7 +
 .../testing/selftests/net/mptcp/mptcp_nvme.sh | 179 ++++++++++++++++++
 2 files changed, 186 insertions(+)
 create mode 100755 tools/testing/selftests/net/mptcp/mptcp_nvme.sh

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
index 000000000000..14a620040df2
--- /dev/null
+++ b/tools/testing/selftests/net/mptcp/mptcp_nvme.sh
@@ -0,0 +1,179 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+
+. "$(dirname "$0")/mptcp_lib.sh"
+
+trtype="${1:-mptcp}"
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
+	rm -rf /sys/kernel/config/nvmet/ports/${port}/subsystems/${trtype}subsys
+	rmdir /sys/kernel/config/nvmet/ports/${port}
+	echo 0 > /sys/kernel/config/nvmet/subsystems/${nqn}/namespaces/${ns}/enable
+	echo -n 0 > /sys/kernel/config/nvmet/subsystems/${nqn}/namespaces/${ns}/device_path
+	rmdir /sys/kernel/config/nvmet/subsystems/${nqn}/namespaces/${ns}
+	rmdir /sys/kernel/config/nvmet/subsystems/${nqn}
+}
+
+ns2_cleanup()
+{
+	nvme disconnect -n ${nqn} || true
+}
+
+cleanup()
+{
+	sleep 1
+
+	ip netns exec "$ns2" bash <<- EOF
+		$(declare -f ns2_cleanup)
+		ns2_cleanup
+	EOF
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
+		ip link add ns1eth$i netns "$ns1" type veth peer name ns2eth$i netns "$ns2"
+		ip -net "$ns1" addr add 10.1.$i.1/24 dev ns1eth$i
+		ip -net "$ns1" addr add dead:beef:$i::1/64 dev ns1eth$i nodad
+		ip -net "$ns1" link set ns1eth$i up
+		ip -net "$ns2" addr add 10.1.$i.2/24 dev ns2eth$i
+		ip -net "$ns2" addr add dead:beef:$i::2/64 dev ns2eth$i nodad
+		ip -net "$ns2" link set ns2eth$i up
+		ip -net "$ns2" route add default via 10.1.$i.1 dev ns2eth$i metric 10$i
+		ip -net "$ns2" route add default via dead:beef:$i::1 dev ns2eth$i metric 10$i
+
+		# Add tc qdisc to both namespaces for bandwidth limiting
+		tc -n $ns1 qdisc add dev ns1eth$i root netem rate 1000mbit
+		tc -n $ns2 qdisc add dev ns2eth$i root netem rate 1000mbit
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
+	cd /sys/kernel/config/nvmet/subsystems
+	mkdir -p "${nqn}"
+	cd "${nqn}"
+	echo 1 > attr_allow_any_host
+	mkdir -p namespaces/${ns}
+	echo /dev/loop100 > namespaces/${ns}/device_path
+	echo 1 > namespaces/${ns}/enable
+
+	cd /sys/kernel/config/nvmet/ports
+	mkdir -p "${port}"
+	cd "${port}"
+	echo "${trtype}" > addr_trtype
+	echo ipv4 > addr_adrfam
+	echo 0.0.0.0 > addr_traddr
+	echo "${trsvcid}" > addr_trsvcid
+
+	cd subsystems
+	ln -sf ../../../subsystems/${nqn} ${trtype}subsys
+}
+
+run_host()
+{
+	local traddr=10.1.1.1
+
+	echo "nvme discover -a ${traddr}"
+	nvme discover -t "${trtype}" -a "${traddr}" -s "${trsvcid}"
+
+	echo "nvme connect"
+	devname=$(nvme connect -t "${trtype}" -a "${traddr}" -s "${trsvcid}" -n "${nqn}" |
+		  awk '{print $NF}')
+	echo "devname=${devname}"
+
+	sleep 1
+
+	echo "nvme list"
+	nvme list
+
+	echo "fio randread /dev/${devname}n1"
+	fio --name=global --direct=1 --norandommap --randrepeat=0 --ioengine=libaio \
+	    --thread=1 --blocksize=4k --runtime=10 --time_based --rw=randread --numjobs=4 \
+	    --iodepth=256 --group_reporting --size=100% --name=libaio_4_256_4k_randread \
+	    --size=4m --filename=/dev/${devname}n1
+
+	sleep 1
+
+	echo "fio randwrite /dev/${devname}n1"
+	fio --name=global --direct=1 --norandommap --randrepeat=0 --ioengine=libaio \
+	    --thread=1 --blocksize=4k --runtime=10 --time_based --rw=randwrite --numjobs=4 \
+	    --iodepth=256 --group_reporting --size=100% --name=libaio_4_256_4k_randwrite \
+	    --size=4m --filename=/dev/${devname}n1
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
+
+	ip netns exec "$ns1" bash <<- EOF
+		$(declare -f run_target)
+		run_target
+	EOF
+
+	ip netns exec "$ns2" bash <<- EOF
+		$(declare -f run_host)
+		run_host
+	EOF
+}
+
+run_test "$@"
-- 
2.53.0

