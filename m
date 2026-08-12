Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 013FE46EC8B;
	Wed, 12 Aug 2026 14:56:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786546590; cv=none; b=aNv5W6hojmK6Qb+uMJHahWZj8CPDqIjn2bh+z7V4WLgIKUaSFYPlpra3xvE3fCBo8Sev3URPua8sFFMp9MblM6aqgxQAED2Sb+Ok2uq9xuRuVyaNCbNivwdveFHVvJahfOggi1BvJANKaE7aIFIqb3wgar1FtM7eAbeCH/b+I/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786546590; c=relaxed/simple;
	bh=9DWzG4MqvnbfffxHxIao0Il/rNYmDxD1jYc/ee7W/GQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=d/5bECJFc6HRbojShUDhX1GE+0zIC3qof8lC8n+Z9G5Bjva9Xz4/uxCOjH/Bj9q8GXP8ioP1vvjzpAzcdTVmoQ9UAmMdxfYVayB2RjC3JuvY/OaP/Nkm3CoN2H+rMFNH23pnkWFPlizA6By1cNAeb+mM2FG3olzYAMc10kdwu9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XP9r5H/L; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XP9r5H/L"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C83371F00A3A;
	Wed, 12 Aug 2026 14:56:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786546574;
	bh=gW5vkNJ/C6DwDC9a9I8rYyU9QwK6sEUGGymq0Yf8CxQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=XP9r5H/LfPOETGoCrLttsmQJvElVFaux9EWKpylTcPCqUf0/cAG4ojtvkf1YTR0ke
	 3vLYZFy1Z36SJwq4dgeQyUlZPSOd2wv6+GxN2hIPyw/g/vscNcVWYz+zOoS+aDjCfO
	 rXspVFOo6EMUzJbSmnV4BoWUllSfd28/tNUaiq3dDm4NgY8SXMK3v8aAvTGTc2wNVA
	 7l5VDVy5WzcIMX1To7R2S9yYyfC7ZOwfp4IEpeEpHE5/LKe+rBlZLlfuomz/u+OIcj
	 EixpBZb1U2KJj/fqO+k3XoNoTKYqPiXMWrR5YBzKzqwU3V4CuQ+6Pze4QUxkE/hCyg
	 QqdrLPDuNAGCA==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Wed, 12 Aug 2026 16:55:42 +0200
Subject: [PATCH net-next 07/11] selftests: mptcp: connect: test name in
 pcap file
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260812-net-next-mptcp-misc-feat-7-3-v1-7-1905a818f6cb@kernel.org>
References: <20260812-net-next-mptcp-misc-feat-7-3-v1-0-1905a818f6cb@kernel.org>
In-Reply-To: <20260812-net-next-mptcp-misc-feat-7-3-v1-0-1905a818f6cb@kernel.org>
To: Mat Martineau <martineau@kernel.org>, Geliang Tang <geliang@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, mptcp@lists.linux.dev, 
 linux-kernel@vger.kernel.org, "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, 
 Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1565; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=9DWzG4MqvnbfffxHxIao0Il/rNYmDxD1jYc/ee7W/GQ=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGLJqOss52FoWPJ5gMyH5/F+fFudYialM2x8kKM/Jyvfak
 x9ebODRUcrCIMbFICumyCLdFpk/83kVb4mXnwXMHFYmkCEMXJwCMJHLuxgZVj5Onygzqz54ck/8
 gl9fDvAdL47fzDBNVVTo3VHF7nvybQz/9HzbHrbtSQiP9+HU+X+jbdmDb4Hql/4fnDvztMwXkRn
 V3AA=
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

Even if the pcap prefix is printed in the test, it is clearer if this
prefix also include the test name: mptcp_connect.

With this, it is easily possible to find out which pcap was produced by
which test, and easily delete the right ones.

Reviewed-by: Mat Martineau <martineau@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
To: Shuah Khan <shuah@kernel.org>
Cc: linux-kselftest@vger.kernel.org
---
 tools/testing/selftests/net/mptcp/mptcp_connect.sh | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect.sh b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
index d158678fa6ab..5befd8584a4d 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_connect.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
@@ -212,8 +212,8 @@ if $checksum; then
 fi
 
 if $capture; then
-	rndh="${ns1:4}"
-	mptcp_lib_pr_info "Packet capture files will have this prefix: ${rndh}-"
+	capprefix="mptcp_connect-${ns1:4}"
+	mptcp_lib_pr_info "pcap will have this prefix: ${capprefix}-"
 fi
 
 set_ethtool_flags() {
@@ -372,7 +372,7 @@ do_transfer()
 			capuser="-Z $SUDO_USER"
 		fi
 
-		local capfile="${rndh}-${connector_ns:0:3}-${listener_ns:0:3}-${cl_proto}-${srv_proto}-${connect_addr}-${port}"
+		local capfile="${capprefix}-${connector_ns:0:3}-${listener_ns:0:3}-${cl_proto}-${srv_proto}-${connect_addr}-${port}"
 		local capopt="-i any -s 65535 -B 32768 ${capuser}"
 
 		ip netns exec ${listener_ns} tcpdump ${capopt} \

-- 
2.53.0

