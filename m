Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9E79336881
	for <mptcp@lists.linux.dev>; Thu,  5 Mar 2026 04:06:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772683568; cv=none; b=jE+dEZol9me0H+KKyZMloLJl6m7eyFkfAilQO8Y3XJeMmacqgp40K4FZ6s/4Nb0BV9peJ8bRJM9HsI/rZXC7Z2SpR0uo0VwPZSfIPXjISdGfd1mlA3L8EiM2Ev6cggBevwhG9m0X5q+Hnu2Jp/KhlayEBI7JwSqhNyuAa6WwSZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772683568; c=relaxed/simple;
	bh=lNyyLL0dxvONAvY9syYgVMAz2DVnefJqocT4+oA+a6k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=InQ81cYV6IS+z8yMnEtM2XiPwLmqD1T1ogD8AWm1s2aLvUJcZLXosVn84lY+yyBxutWmNWgW8DGUArJZFDXSfo49qF3ycfT6txa6dJIjclUC7TWMUV8DzaK2d+Jp2PVokNsj3vxCu4FEIt+gprbGCw7e44BjmiApXYz7wrVySDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zg1uBls5; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zg1uBls5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E5E3C2BC9E;
	Thu,  5 Mar 2026 04:06:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772683568;
	bh=lNyyLL0dxvONAvY9syYgVMAz2DVnefJqocT4+oA+a6k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Zg1uBls5Elnt7zZAYKuD8sAsxpjBreNPG2JmsCHrYRCWXi3Wh+a/CztdxTcpGHn/6
	 krhtBeIK3xbi6i8kUYceANPL24JqMVslD4f1Z03NuT/fOY8HDp/VoL07PrU9SBil84
	 69pkPtiCC/KF+qRH79xU+S+p3f4i9vDcDULYf5KYnkRGWIphChpAjWEnRdP7fFkgpa
	 vfY1kdTEI66xAUbahC1tZXvixv8dsNATKYji0yfk2QF9q6s8/BxSXIbta6poEA9/e4
	 Lx99LIS8/JnTTpeTxPNoxEQYZU4mCWn2nykx2pOveacaTTOvhJQwLtl+MRUOmANcgn
	 Km4dIXa55T33g==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev,
	nilay@linux.ibm.com,
	ming.lei@redhat.com,
	hare@suse.de
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [RFC mptcp-next v4 8/8] selftests: mptcp: nvme: set iopolicy
Date: Thu,  5 Mar 2026 12:05:26 +0800
Message-ID: <31241344d80a577e7e46b584f7ce6e7011cc5d5d.1772683110.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1772683110.git.tanggeliang@kylinos.cn>
References: <cover.1772683110.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

Added NVMe iopolicy testing to mptcp_nvme.sh, with the default set to
"numa". It can be set to "round-robin" or "queue-depth".

 # ./mptcp_nvme.sh mptcp round-robin

Cc: Nilay Shroff <nilay@linux.ibm.com>
Cc: Ming Lei <ming.lei@redhat.com>
Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 tools/testing/selftests/net/mptcp/mptcp_nvme.sh | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_nvme.sh b/tools/testing/selftests/net/mptcp/mptcp_nvme.sh
index 14a620040df2..2e03f47d22da 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_nvme.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_nvme.sh
@@ -4,6 +4,7 @@
 . "$(dirname "$0")/mptcp_lib.sh"
 
 trtype="${1:-mptcp}"
+iopolicy=${2:-"numa"} # round-robin, queue-depth
 nqn=nqn.2014-08.org.nvmexpress.${trtype}dev
 ns=1
 port=1234
@@ -140,6 +141,12 @@ run_host()
 	echo "nvme list"
 	nvme list
 
+	subname=$(nvme list-subsys /dev/${devname}n1 |
+		  grep -o 'nvme-subsys[0-9]*' | head -1)
+
+	echo ${iopolicy} > /sys/class/nvme-subsystem/${subname}/iopolicy
+	cat /sys/class/nvme-subsystem/${subname}/iopolicy
+
 	echo "fio randread /dev/${devname}n1"
 	fio --name=global --direct=1 --norandommap --randrepeat=0 --ioengine=libaio \
 	    --thread=1 --blocksize=4k --runtime=10 --time_based --rw=randread --numjobs=4 \
@@ -164,6 +171,7 @@ losetup /dev/loop100 /tmp/test.raw
 run_test()
 {
 	export trtype nqn ns port trsvcid
+	export iopolicy
 
 	ip netns exec "$ns1" bash <<- EOF
 		$(declare -f run_target)
-- 
2.53.0

