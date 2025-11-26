Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD5CF315D32
	for <mptcp@lists.linux.dev>; Wed, 26 Nov 2025 10:40:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764153643; cv=none; b=Hwd1cs9qJjqslKyXM6U0ATmejZBFc0MuZdcmTWg/z2/pRH661DDdBf2H2uiOnrxFtmbWZM9qgLaiJSIVzTsoXLPr56WBJw6e01LsEblUEnf7wRs4g10FHVLI42/HF6Vh9ON+k73DTWdpla2NSsAepL8c9gko4Tdelh5DmtfLuAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764153643; c=relaxed/simple;
	bh=dlYaBnzAl12Sh2T2GTr08YjQU4JrBld5k3SNPL+Q0PA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rSSM5xOaaiuFx5pZc+hmRb0puo0yVNevxuR52v9Uv2/goOLFyhEqFNA1CsWwsD6cXejTpvEI4DLq2EqdsRDy2aU2LcWDU7Vk7h4syQRjgkdKUPMcA83R6yNVBmOWf/2V+HLgoqrlU+rbaT2FkSId7JCFgPGLS2Lk1kJl74k2TvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WFuP127l; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WFuP127l"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60894C16AAE;
	Wed, 26 Nov 2025 10:40:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764153643;
	bh=dlYaBnzAl12Sh2T2GTr08YjQU4JrBld5k3SNPL+Q0PA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WFuP127lmC8kP8fpwFx1sd8gZhqh3xXeTkxYcUSHuoEVminPl8WYlAf29HNgyCqjS
	 EKCdfn6cWEy+54sVNkg+juagIspkVb0tj7fq5z/uLrwDZneLF+9TyHwFN9vVb99/xn
	 36ZuwIyLsI9W0ToLcpBu6bxRcdbwlW6kZfQrT5QsB0LFXDMOaV17oaphmGeBLyzG0X
	 4Roajvlj1eHBoIMjOJ/s4ph/LKo+luf7CTvJrwFJT5Tn1o0WvJQPVdoLlRIiSb0XQK
	 wrGckerOxhp39AFK8/ojOr2sOJMewUULuTOgr+UxiJ2DGe2eUYio3yBxPhJd4BCA+n
	 jxQVfmIHCmHSQ==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev,
	hare@suse.de,
	hare@kernel.org
Cc: Geliang Tang <tanggeliang@kylinos.cn>,
	Hui Zhu <zhuhui@kylinos.cn>,
	Gang Yan <yangang@kylinos.cn>,
	zhenwei pi <zhenwei.pi@linux.dev>
Subject: [RFC mptcp-next v2 7/7] selftests: mptcp: add NVMe-over-MPTCP test
Date: Wed, 26 Nov 2025 18:40:04 +0800
Message-ID: <846c2a8fad0ecd98edb5d3fe5e5356c6a709d858.1764152990.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1764152990.git.tanggeliang@kylinos.cn>
References: <cover.1764152990.git.tanggeliang@kylinos.cn>
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

Co-developed-by: Hui Zhu <zhuhui@kylinos.cn>
Signed-off-by: Hui Zhu <zhuhui@kylinos.cn>
Co-developed-by: Gang Yan <yangang@kylinos.cn>
Signed-off-by: Gang Yan <yangang@kylinos.cn>
Co-developed-by: zhenwei pi <zhenwei.pi@linux.dev>
Signed-off-by: zhenwei pi <zhenwei.pi@linux.dev>
Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 tools/testing/selftests/net/mptcp/config      |   7 +
 .../testing/selftests/net/mptcp/mptcp_nvme.sh | 120 ++++++++++++++++++
 2 files changed, 127 insertions(+)
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
index 000000000000..1c24198003e2
--- /dev/null
+++ b/tools/testing/selftests/net/mptcp/mptcp_nvme.sh
@@ -0,0 +1,120 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+
+trtype="${1:-mptcp}"
+traddr="${2:-127.0.0.1}"
+ns=1
+port=1234
+trsvcid=4420
+nqn=nqn.2014-08.org.nvmexpress.${trtype}dev
+final_ret=0
+
+#ip mptcp monitor &
+
+cleanup()
+{
+	rm -rf /sys/kernel/config/nvmet/ports/${port}/subsystems/${trtype}subsys
+	rmdir /sys/kernel/config/nvmet/ports/${port}
+	echo 0 > /sys/kernel/config/nvmet/subsystems/${nqn}/namespaces/${ns}/enable
+	echo -n 0 > /sys/kernel/config/nvmet/subsystems/${nqn}/namespaces/${ns}/device_path
+	rmdir /sys/kernel/config/nvmet/subsystems/${nqn}/namespaces/${ns}
+	rmdir /sys/kernel/config/nvmet/subsystems/${nqn}
+	losetup -d /dev/loop100
+	rm -rf /tmp/test.raw
+}
+
+check_error()
+{
+	if dmesg | grep -E -q "starting error recovery|Buffer I/O error"; then
+		cleanup
+		exit 1
+	fi
+}
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
+echo
+echo "nvme discover"
+echo
+nvme discover -t ${trtype} -a ${traddr} -s ${trsvcid}
+
+echo
+echo "nvme connect"
+echo
+devname=$(nvme connect -t ${trtype} -a ${traddr} -s ${trsvcid} -n ${nqn} | awk '{print $4}')
+lret=$?
+if [ $lret -ne 0 ]; then
+	final_ret=${lret}
+fi
+check_error
+
+sleep 0.5
+echo
+echo "nvme list"
+echo
+nvme list
+lret=$?
+if [ $lret -ne 0 ]; then
+	final_ret=${lret}
+fi
+check_error
+
+echo
+echo "fio randread"
+echo
+fio --name=global --direct=1 --norandommap --randrepeat=0 --ioengine=libaio \
+    --thread=1 --blocksize=4k --runtime=10 --time_based --rw=randread --numjobs=4 \
+    --iodepth=256 --group_reporting --size=100% --name=libaio_4_256_4k_randread \
+    --filename=/dev/${devname}n1
+lret=$?
+if [ $lret -ne 0 ]; then
+	final_ret=${lret}
+fi
+check_error
+
+echo
+echo "fio randwrite"
+echo
+fio --name=global --direct=1 --norandommap --randrepeat=0 --ioengine=libaio \
+    --thread=1 --blocksize=4k --runtime=10 --time_based --rw=randwrite --numjobs=4 \
+    --iodepth=256 --group_reporting --size=100% --name=libaio_4_256_4k_randwrite \
+    --filename=/dev/${devname}n1
+lret=$?
+if [ $lret -ne 0 ]; then
+	final_ret=${lret}
+fi
+check_error
+
+sleep 0.5
+echo
+echo "nvme disconnect"
+echo
+nvme disconnect -n ${nqn}
+lret=$?
+if [ $lret -ne 0 ]; then
+	final_ret=${lret}
+fi
+check_error
+
+cleanup
+echo "final_ret=${final_ret}"
+exit ${final_ret}
-- 
2.51.0

