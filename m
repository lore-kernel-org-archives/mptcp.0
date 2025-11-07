Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07D4013D891
	for <mptcp@lists.linux.dev>; Fri,  7 Nov 2025 03:38:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762486693; cv=none; b=XNofY3NJy1WRi40jCViKOYjnuFTaN8nS3eHZy5KbaX5tEdtjY4+nt8bmc4SMibWBQdhia0DkL0+qGTP9KHEjVPcVDxqbTz6qdEbCYkRP6LvLjOVVJ2HBDLUpILTefaP0KetaTr81GBMCaY973MkA/4aN/T0NwA6WX3m1/PPMn7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762486693; c=relaxed/simple;
	bh=9MUfi1cF/g48GvPD7NmsgtRoRPVrEqVhQtc+Z8NHTqc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Vlq4NbOGEelgd2IzJGrN1Qg6e+gQqkg2xCsqd2HIUBAMsH87mtygQjm96eqmy22tqLLW4pQvQaJE1JIShoG43Wy0RCOUwA6JoJf51iOwuOGma4mivOCo5bD/6nhUXawjOhXEgEbhMthn6od0A5F5I19A3mocuqI4hutVERyvvOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u7vSjlDb; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u7vSjlDb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A1E8C19424;
	Fri,  7 Nov 2025 03:38:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762486692;
	bh=9MUfi1cF/g48GvPD7NmsgtRoRPVrEqVhQtc+Z8NHTqc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=u7vSjlDbFzmytHzG9aqb5qi/piB4oqUtD3jSW1tejFAesJbx+EMXVD9mleU2LsCVj
	 CuJnpUKTsEHyUcREB+NIWqeOdlxucVuWTY+o7gp5hIosDhrmYTuaZE1FTveMX0ZbiF
	 RahQbry28Fn6HLfe4ggawVcC+A0b5rbGUnetARTzBBFFU8lIinly8RLTzXGmi092KC
	 PQE1YsTJjzqZKtJQg87MGgK63zYjugm/RcGZyBoG5syc9TkRXEjB4UNknrc1x8ZshT
	 A72f2gmYLcvM1Lk1x6nDwPtEYPZ62KtffhdJ33RXzs78Y95HGwrrG2OiWKieTmqNCG
	 os6OfzFiN7Ckw==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev,
	hare@suse.de,
	hare@kernel.org
Cc: Geliang Tang <tanggeliang@kylinos.cn>,
	Hui Zhu <zhuhui@kylinos.cn>,
	Gang Yan <yangang@kylinos.cn>,
	zhenwei pi <zhenwei.pi@linux.dev>
Subject: [RFC mptcp-next 5/6] selftests: mptcp: add NVMe-over-MPTCP test
Date: Fri,  7 Nov 2025 11:37:36 +0800
Message-ID: <aae526f547430896b473f6b6d254f9b706c01ad6.1762485513.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1762485513.git.tanggeliang@kylinos.cn>
References: <cover.1762485513.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

This patch introduces a new selftest that evaluates NVMe-over-Fabrics
performance when using MPTCP as the transport protocol. The test:

1. Sets up a local NVMe target configuration using:
   - A loopback device as storage backend
   - MPTCP as the transport type
   - IPv4 addressing

2. Performs standard NVMe operations including:
   - Discovery and connection
   - Device listing
   - Random read/write performance tests using fio

3. Cleans up all test resources

The test script (mptcp_nvme.sh) accepts parameters for transport type
and target address, defaulting to MPTCP and localhost. It measures
performance using fio with:
- 4 parallel jobs
- 256 I/O depth
- 4KB block size
- 10 second runtime
- Both random read and write patterns

Required kernel config options are added to the MPTCP selftest config
file to support NVMe-over-TCP functionality.

This test helps validate MPTCP's suitability for storage networking
workloads and provides a benchmark for performance comparisons.

Co-Developed-by: Hui Zhu <zhuhui@kylinos.cn>
Signed-off-by: Hui Zhu <zhuhui@kylinos.cn>
Co-Developed-by: Gang Yan <yangang@kylinos.cn>
Signed-off-by: Gang Yan <yangang@kylinos.cn>
Co-Developed-by: zhenwei pi <zhenwei.pi@linux.dev>
Signed-off-by: zhenwei pi <zhenwei.pi@linux.dev>
Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 tools/testing/selftests/net/mptcp/config      |  7 +++
 .../testing/selftests/net/mptcp/mptcp_nvme.sh | 57 +++++++++++++++++++
 2 files changed, 64 insertions(+)
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
index 000000000000..329169fac4ca
--- /dev/null
+++ b/tools/testing/selftests/net/mptcp/mptcp_nvme.sh
@@ -0,0 +1,57 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+
+trtype="${1:-mptcp}"
+traddr="${2:-127.0.0.1}"
+ns=1
+port=1234
+trsvcid=4420
+nqn=nqn.2014-08.org.nvmexpress.${trtype}dev
+
+dd if=/dev/zero of=/tmp/test.raw bs=1M count=0 seek=512
+losetup /dev/loop100 /tmp/test.raw
+cd /sys/kernel/config/nvmet/subsystems
+mkdir ${nqn}
+cd ${nqn}
+echo 1 > attr_allow_any_host
+cd namespaces
+mkdir ${ns}
+cd ${ns}
+echo /dev/loop100 > device_path
+echo 1 > enable
+cd /sys/kernel/config/nvmet/ports
+mkdir ${port}
+cd ${port}
+echo ${trtype} > addr_trtype
+echo ipv4 > addr_adrfam
+echo ${traddr} > addr_traddr
+echo ${trsvcid} > addr_trsvcid
+cd subsystems
+ln -s ../../../subsystems/${nqn} ${trtype}subsys
+
+echo "nvme discover"
+nvme discover -t ${trtype} -a ${traddr} -s ${trsvcid}
+
+echo "nvme connect"
+devname=$(nvme connect -t ${trtype} -a ${traddr} -s ${trsvcid} -n ${nqn} | awk '{print $4}')
+
+sleep 0.5
+echo "nvme list"
+nvme list
+
+fio --name=global --direct=1 --norandommap --randrepeat=0 --ioengine=libaio --thread=1 --blocksize=4k --runtime=10 --time_based --rw=randread --numjobs=4 --iodepth=256 --group_reporting --size=100% --name=libaio_4_256_4k_randread --filename=/dev/${devname}n1
+
+fio --name=global --direct=1 --norandommap --randrepeat=0 --ioengine=libaio --thread=1 --blocksize=4k --runtime=10 --time_based --rw=randwrite --numjobs=4 --iodepth=256 --group_reporting --size=100% --name=libaio_4_256_4k_randread --filename=/dev/${devname}n1
+
+sleep 0.5
+echo "nvme disconnect"
+nvme disconnect -n ${nqn}
+
+rm -rf /sys/kernel/config/nvmet/ports/${port}/subsystems/${trtype}subsys
+rmdir /sys/kernel/config/nvmet/ports/${port}
+echo 0 > /sys/kernel/config/nvmet/subsystems/${nqn}/namespaces/${ns}/enable
+echo -n 0 > /sys/kernel/config/nvmet/subsystems/${nqn}/namespaces/${ns}/device_path
+rmdir /sys/kernel/config/nvmet/subsystems/${nqn}/namespaces/${ns}
+rmdir /sys/kernel/config/nvmet/subsystems/${nqn}
+losetup -d /dev/loop100
+rm -rf /tmp/test.raw
-- 
2.43.0

