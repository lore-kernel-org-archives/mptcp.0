Received: from mta0.migadu.com (out-69.mta0.migadu.com [91.218.175.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D00C72931D5
	for <mptcp@lists.linux.dev>; Tue, 18 Aug 2026 09:48:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787046515; cv=none; b=fICAfje1cgdom2gMplL/WuOWG6onpIoWjrlQMG5b7V8gqH2Xn0oqMFxGaGHMf4w+v2uIhz8XYmdM16m62hMQyBlsGdT4NfTC90SdiUMIxhD/A+Q1bofGN6arGVuuAj5OgI5BYE3E7vBpE9lZFRytFzo6RBJJiD/nreWF+cDHqlM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787046515; c=relaxed/simple;
	bh=6S9zW0R0Cv8IhcDyx51H5z/yRyjt/cM3azWG1GaLbm4=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=OYacKLDFOmBpgP4h9cqiyygmOkYE9sW4Wq0MlZRsthgGTHhwLbBQoKg4j7FJomXgsh8jXW4DT0e/uwu2DSxZOyulR/3KqtEW+/K0kMx1T8CNFKW8TTid9afU4BGRfKKQ4PK4SZ/nj+3jdLO98xJz3YH9Jr2v/gQ0X5evA/zDTuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=XLIgPe+8; arc=none smtp.client-ip=91.218.175.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="XLIgPe+8"
X-Envelope-To: mptcp@lists.linux.dev
DKIM-Signature: a=rsa-sha256; bh=6S9zW0R0Cv8IhcDyx51H5z/yRyjt/cM3azWG1GaLbm4=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1787046511; v=1; x=1787651311;
 b=XLIgPe+8j+pVi+/sWEpuE9tXkAX+K3o744Xk+pYWrvpkPv+eg4dz03gAbhQ+PQd5ZNLS+KY9
 R2u0bDoMBhTmb8b82KnaRJsgG8PFhKrquU0QTLgQMNn796AcZM+9C2vrjwPCbLkxhRFiLPa+MSI
 rscDv0cKP/S0BcV6SM7JZyWk=
X-Envelope-To: mptcp@lists.linux.dev
Received: from thinkbook16p.. (223.70.159.239)
	by smtp.migadu.com with ESMTPS id 9a1026d60928f965;
	Tue, 18 Aug 2026 09:48:31 +0000
X-Migadu-Flow: FLOW_OUT
From: Gang Yan <gang.yan@linux.dev>
To: mptcp@lists.linux.dev
Subject: [PATCH mptcp-next v2 0/5] mptcp: avoid data-races around the sysctls
Date: Tue, 18 Aug 2026 17:48:20 +0800
Message-ID: <20260818094825.48446-1-gang.yan@linux.dev>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Gang Yan <yangang@kylinos.cn>

Changelog:
v2:
  - Split the code around bpf to patch 4 and patch 5.
  - Put WRITE_ONCE(pernet->pm_type, pm_type) into patch 3 and add
    tag of Tao Cui.
v1:
  Link: https://patchwork.kernel.org/project/mptcp/cover/20260817012452.7519-1-gang.yan@linux.dev/


Gang Yan (4):
  mptcp: sched: change scheduler sysctl atomically
  mptcp: pm: change path_manager sysctl atomically
  Squash to "mptcp: pm: init and release mptcp_pm_ops"
  Squash to "bpf: Add mptcp packet scheduler struct_ops"

Matthieu Baerts (NGI0) (1):
  mptcp: use READ_ONCE() over sysctls

 net/mptcp/ctrl.c     | 116 ++++++++++++++++++++++++++++++-------------
 net/mptcp/pm.c       |   3 +-
 net/mptcp/protocol.c |   5 +-
 net/mptcp/protocol.h |   6 +--
 net/mptcp/sched.c    |   2 +-
 5 files changed, 91 insertions(+), 41 deletions(-)

-- 
2.43.0

