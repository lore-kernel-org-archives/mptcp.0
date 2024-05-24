Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA3331CD06
	for <mptcp@lists.linux.dev>; Fri, 24 May 2024 06:49:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716533342; cv=none; b=hLxv9YuQnGrdDoo5hHuQztRP/Oh/gEUoe8uBF9gPc2lrrNR+f7xZGhMA804aQkzVSb0/my6yL4Bqjrn9WPg7jPCKnRq5a+eczLG7EyLjggsISNqdMQQ35h6NP27DCuRSR6T9y6ivVCYl3p3yn6cnDGVTu1kNfpgbtKzt4lmHwgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716533342; c=relaxed/simple;
	bh=Qafg1LrrHGL1wxi2rQVV5TA9CrpP6nJeHGwuJSXES6E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZcKpQ4Ruy/d2f/Xb11Vd+Ykimhy77FGFIwaRyEwOLI1P283EMa+yEiQ+o/A0dSrX4KE0VHEbyHuTWIzCmkw+PZALcLaT5tCeSXdRMF0A7E8XgC4xSctz2+lxGs57r+R76XNZzdbfT5BzZdn/S/og88Zqjt9PM3UlTbH+Gc1zxc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DsN/JMh1; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DsN/JMh1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82088C32786;
	Fri, 24 May 2024 06:49:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716533342;
	bh=Qafg1LrrHGL1wxi2rQVV5TA9CrpP6nJeHGwuJSXES6E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DsN/JMh1Rl9W6PaO0UZ9YrYne5SfZtk6vZ4uxBDGUVF5CqtYT/kR6S9vDUAGPK3u/
	 19w09YdNmVdSjYYKNB7D37mpscbvFW5D4EkL/xKb2IF5zgabsQYe5Uadm6QuSk9xSI
	 7KD3o/HYIRrDE+HWNvXsb4RAsTYtdus4yCzzrD403Iz4AXnfoY2jz4DWQ4zLq4x8Mz
	 NY4xLh3flb3gckx5fkS61BGX/HTQV9WW2ClGvPyyezHbQw1sMIzTCUQ2VJqOu8mnlU
	 UfVuNrzcW2TiXOvTGKwXoPHXLAJeboVNRnF5wJvZQry/+xPQ2l0N9dBkuZa5Nzg0UA
	 gpvm/ifulgSmA==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v4 1/6] selftests: net: rename ns in setup/cleanup_ns
Date: Fri, 24 May 2024 14:48:46 +0800
Message-ID: <7a877165562901175b913285b3bb844f2cbc49c9.1716533107.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1716533107.git.tanggeliang@kylinos.cn>
References: <cover.1716533107.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

The helpers setup_ns and cleanup_ns don't work when a namespace named
"ns" is passed to them.

For example, in net/mptcp/diag.sh, the name of the namespace is "ns".
If "setup_ns ns" is used in it, diag.sh fails with errors:

 Invalid netns name "./mptcp_connect"
 Cannot open network namespace "10000": No such file or directory
 Cannot open network namespace "10000": No such file or directory

That is because "ns" is also a local variable in both setup_ns and
cleanup_ns. To solve this, this patch renames the local variable "ns"
as "_ns".

Also a ns_name valid check has been added to setup_ns. If "_ns" is
passed in as a ns_name, setup_ns helper exits.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 tools/testing/selftests/net/lib.sh | 33 ++++++++++++++++++------------
 1 file changed, 20 insertions(+), 13 deletions(-)

diff --git a/tools/testing/selftests/net/lib.sh b/tools/testing/selftests/net/lib.sh
index edc030e81a46..ce611bc73098 100644
--- a/tools/testing/selftests/net/lib.sh
+++ b/tools/testing/selftests/net/lib.sh
@@ -128,7 +128,7 @@ slowwait_for_counter()
 
 cleanup_ns()
 {
-	local ns=""
+	local _ns=""
 	local errexit=0
 	local ret=0
 
@@ -138,10 +138,11 @@ cleanup_ns()
 		set +e
 	fi
 
-	for ns in "$@"; do
-		ip netns delete "${ns}" &> /dev/null
-		if ! busywait $BUSYWAIT_TIMEOUT ip netns list \| grep -vq "^$ns$" &> /dev/null; then
-			echo "Warn: Failed to remove namespace $ns"
+	for _ns in "$@"; do
+		ip netns delete "${_ns}" &> /dev/null
+		if ! busywait $BUSYWAIT_TIMEOUT ip netns list \
+		   \| grep -vq "^$_ns$" &> /dev/null; then
+			echo "Warn: Failed to remove namespace $_ns"
 			ret=1
 		fi
 	done
@@ -159,29 +160,35 @@ cleanup_all_ns()
 # setup_ns local remote
 setup_ns()
 {
-	local ns=""
+	local _ns=""
 	local ns_name=""
 	local ns_list=""
 	local ns_exist=
 	for ns_name in "$@"; do
+		if [ "${ns_name}" == "_ns" ]; then
+			echo "Failed to setup namespace '${ns_name}': invalid name"
+			cleanup_ns "$ns_list"
+			set -e
+			return $ksft_fail
+		fi
 		# Some test may setup/remove same netns multi times
 		if unset ${ns_name} 2> /dev/null; then
-			ns="${ns_name,,}-$(mktemp -u XXXXXX)"
-			eval readonly ${ns_name}="$ns"
+			_ns="${ns_name,,}-$(mktemp -u XXXXXX)"
+			eval readonly ${ns_name}="$_ns"
 			ns_exist=false
 		else
-			eval ns='$'${ns_name}
-			cleanup_ns "$ns"
+			eval _ns='$'${ns_name}
+			cleanup_ns "$_ns"
 			ns_exist=true
 		fi
 
-		if ! ip netns add "$ns"; then
+		if ! ip netns add "$_ns"; then
 			echo "Failed to create namespace $ns_name"
 			cleanup_ns "$ns_list"
 			return $ksft_skip
 		fi
-		ip -n "$ns" link set lo up
-		! $ns_exist && ns_list="$ns_list $ns"
+		ip -n "$_ns" link set lo up
+		! $ns_exist && ns_list="$ns_list $_ns"
 	done
 	NS_LIST="$NS_LIST $ns_list"
 }
-- 
2.43.0

