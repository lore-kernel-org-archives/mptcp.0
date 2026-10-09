Received: from mta1.migadu.com (out-177.mta1.migadu.com [95.215.58.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C7D247207F
	for <mptcp@lists.linux.dev>; Fri,  9 Oct 2026 07:27:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791530862; cv=none; b=htWe9IhPehEoVXUgOjCVq4kdTdHB+n1YqpqO+s06gqsPY2kU9OR0ngiIZUBmm0iOPsqj4CcPXpcErOQh2Ie4igOLSnHu9Bsz4ohu5wx2lI+bNnDRaP0koTHDEsHaKlppOTH5liSyszJL6+of6n9JBXA0to5RWeConiMWAd7d7jo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791530862; c=relaxed/simple;
	bh=mTyMwH5veEOxVxqNipwy3vdKyOvgYtATrbCJMl+U11E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=aXgkv02mi9vUVFgo8gZQ4/RNAOyhKR01zuOwtcRoCGCEYWwXBRM6q8IZjuR+I4qRUjkPWeJ3jGaieHehCpZ6MSVjCNX7qMG5V/4Qtl17bmAReFNyhSA2wzZpMbtQ/WQXkP4JqZUQiRjX2Fl2WOPS7Lc3G13QjmAEelCMXLzsDhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=IW3LGpOo; arc=none smtp.client-ip=95.215.58.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="IW3LGpOo"
X-Envelope-To: mptcp@lists.linux.dev
DKIM-Signature: a=rsa-sha256; bh=mTyMwH5veEOxVxqNipwy3vdKyOvgYtATrbCJMl+U11E=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1791530858; v=1; x=1792135658;
 b=IW3LGpOo3vSJ5V15L3BXjoXhQwroSeOWumaZsl7y21nys6qZB345j1XzK2V6rzGLi+zP8caG
 cKE3nwGdV7Pc98BzwnKtKoh6oMla8pTKbAKA5rKeqOkdw3x1kzz+X9J5OBCdgCh5jBLQE9vsssV
 baHtDC6Xrajn1qrNSHChSM5Y=
X-Envelope-To: mptcp@lists.linux.dev
Received: by mta10.migadu.com with ESMTPS id ebceb9e2f5888489;
	Fri, 09 Oct 2026 07:27:38 +0000
X-Mizu-Trace-ID: ebceb9e2f5888489
X-Migadu-Flow: FLOW_OUT
From: Hangbin Liu <hangbin.liu@linux.dev>
Date: Fri, 09 Oct 2026 15:27:26 +0800
Subject: [PATCH mptcp-next] squash to "selftests: mptcp: convert iptables
 to nftables for mptcp_join.sh"
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261009-mptcp_rm_debug-v1-1-a7b4fdbe1b5f@kylinos.cn>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x2MTQqAIBQGrxJvnWAu+rtKRJh+1ltkohVBdPek5
 cDMPJQQGYn64qGIixPvPkNVFmRW7RcItplJSVVXUnZiC4cJU9wmi/lchGqcA6xpWq0pRyHC8f0
 PB/pd4XEfNL7vB8+o3OdsAAAA
X-Change-ID: 20261009-mptcp_rm_debug-27ffeedc78aa
To: MPTCP Linux <mptcp@lists.linux.dev>
Cc: Hangbin Liu <hangbin.liu@linux.dev>, 
 Hangbin Liu <liuhangbin@kylinos.cn>
X-Mailer: b4 0.14.3

From: Hangbin Liu <liuhangbin@kylinos.cn>

After squash, the new commit description could be:

During the conversion, we retain the same filter and chain names previously
used by iptables/ip6tables. Counters are not added to accept rules because
the test does not inspect them. The syn mark rule is removed as it is
only for debugging, which could be added easily when needed.

After conversion, the generated output matches the original
iptables/ip6tables behavior.

Signed-off-by: Hangbin Liu <liuhangbin@kylinos.cn>
---
 tools/testing/selftests/net/mptcp/mptcp_sockopt.sh | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh b/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
index b4e3eddc9cf2..ef2738720e24 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
@@ -54,11 +54,6 @@ add_mark_rules()
 			add chain $table filter OUTPUT \
 				{ type filter hook output priority 0; policy accept; }
 
-			# just to debug: check we have multiple subflows connection requests
-			add rule $table filter OUTPUT \
-				tcp flags & (fin | syn | rst | ack) == syn \
-				meta mark $m accept
-
 			# RST packets might be handled by a internal dummy socket
 			add rule $table filter OUTPUT \
 				tcp flags & rst == rst meta mark 0x0 accept

---
base-commit: 5ac58fb7c561392ec051c390479ca746c42ca989
change-id: 20261009-mptcp_rm_debug-27ffeedc78aa

Best regards,
-- 
Hangbin Liu <liuhangbin@kylinos.cn>

