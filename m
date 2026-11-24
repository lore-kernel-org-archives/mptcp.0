Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.182.54
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795515750;
	b=M03Eo7UfHD1TtO7ePiuV3GNR18asbO1lZkTR9IH/VG76qXFYVc5E98PAzklCP9TomWMY
	 TzBoOl/fxBJV6dOn13EnKEfF8GNv6oSLuBLEAY6pQ7+AVoTl63HSrAFRUvttkSx6oZ7Ki
	 T6M/xm++MmBrjqHxrMaxqCGz7t0pKYpaCRTha3k/b0LuTdPdcJ17uwcmRB24QJpYoYmg7
	 hvreEFNJnNTJPtlOjnlNqOWGo/8PiyOkOks5FQ4RFZSs2ChWz4SklbaAIAzeu74Vlxzyf
	 BBQ5XOctnMk0x7MyRUdsncqojjtG5lhfUGu6/eB5N3tqGR/EpBL6wWPfo+Rdrn+BoLA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795515750;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-ZohoMailClient;
	bh=fmJZudSW+re/Gte4tARmGg5h9220OBdubhx05DToHWA=;
	b=uZqs5vlbZ1yg3n4ZKSIR8fWEdhKRuy1AraCGtAxT7ddjPq91G+ftF+hPWFRY85c0Q+od
	 2Rd2OFFOm/uEZwQWVCNIpebRq7O6PTbtxjaUp6aidc845WdVkPLLJhQ3fffQ1MQvbhik5
	 eej2yBnuOam9XI8W0zPYr9zV37VWkIwmd8KU5nX4BJ94isnLVuIS8ZDz999ZQgtZ5dlK8
	 hfD9R2Cho+fljBSnWbxStnXILZ/pIgM5b6z2X73KHvnSkwE3lVrnE+D4Ass2Pwb525YXw
	 fCfT5u4CCOefg1dNBwdbU3j+MNTyBG93yeu46DmDhYwVB1U0mn9e8ZcRDK5/+POOolg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=mpiricsoftware.com;
	spf=pass smtp.mailfrom=mpiricsoftware.com;
	arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.182.54
Received: from sender5-of-o54.zoho.com (sender5-of-o54.zoho.com [165.173.182.54])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2EDE606A31E
	for <mptcp@lists.linux.dev>; Tue, 24 Nov 2026 10:22:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D2EDE606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mpiricsoftware.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mpiricsoftware.com
ARC-Seal: i=1; a=rsa-sha256; t=1795515747; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=i87y8uau2mNZ3aRwvRcWjUMOnut5tCMfRks93bB5FgOB9PL6DmPBXWS3koJWKkQUlY1MDkAwfOIq03dkGZzUUB7cVT9vJvjBh60jkdWvM4N6a9VuLNbXnGSsj7wY+my/akSTwOgLez9s1Bt6qU9Qt+XudYvSGSsNyR9T4kQ8bJc=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1795515747; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=fmJZudSW+re/Gte4tARmGg5h9220OBdubhx05DToHWA=; 
	b=M1coJFH5146izE2e7X19Gh+cLSZiCxdt8FHk7kPyZ4JHCX5yyzeyujqX/tlF4E03/VN5UZ4efcs9Fhdl6kBIUV1hmj0cYr3T2uH3Ftj8wf76zl5iqONfKkDdbUb4ddcks20I1ZT+fR8ErWy+y0PwhFqh4JIX+D1xOBOtqzWGwPI=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=mpiricsoftware.com;
	spf=pass  smtp.mailfrom=kalpan.jani@mpiricsoftware.com;
	dmarc=pass header.from=<kalpan.jani@mpiricsoftware.com>
DKIM-Signature: a=rsa-sha256; b=q8SgG/1sJK5nbtXVGnSAe31FPaUNmYmfUu8aMC6O9acByTX08/Xgb6Z9DQFFiG0KhEQB2QsJDtHg+0jPCSr09C4wpV9lvEMi/dgarxzRE2Oo7uhy1dR5Ef2UBYxtZnIlWO58X0hX/kKD+kaGH7b8O+AOZIncN08vVqq4iS0YG9c=; c=relaxed/relaxed; s=mpiric; d=mpiricsoftware.com; v=1; bh=fmJZudSW+re/Gte4tARmGg5h9220OBdubhx05DToHWA=; h=Content-Description:Content-ID:Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:List-Subscribe:List-Post:List-Owner:List-Id:List-Archive:List-Help:List-Unsubscribe:MIME-Version:Message-ID:Resent-Sender:Resent-Cc:Resent-Date:Resent-To:Reply-To:Resent-Message-ID:Resent-From:Sender:Subject:To:Date:From:Message-Id:Reply-To:Subject:To:Cc;
Received: by smtp.zohomail.com with SMTPS id 1795515744623307.0445198742955;
	Tue, 24 Nov 2026 02:22:24 -0800 (PST)
From: Kalpan Jani <kalpan.jani@mpiricsoftware.com>
To: mptcp@lists.linux.dev
Cc: shardul.b@mpiricsoftware.com,
	janak@mpiric.us,
	kalpanjani009@gmail.com,
	Kalpan Jani <kalpan.jani@mpiricsoftware.com>
Subject: [PATCH mptcp-next v8 0/2] mptcp: add core-enforced subflow avoid flag
Date: Tue, 24 Nov 2026 15:52:12 +0530
Message-ID: <20261124102214.3930527-1-kalpan.jani@mpiricsoftware.com>
X-Mailer: git-send-email 2.43.0
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Post: <mailto:mptcp@lists.linux.dev>
List-Help: <mailto:mptcp+help@lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
List-Owner: <mailto:mptcp+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

The MPTCP scheduler needs a persistent way for BPF schedulers to
mark subflows that should be avoided across scheduling rounds.

This series introduces a scheduler-owned avoid flag in
mptcp_subflow_context, exposes it to BPF struct_ops schedulers
through a kfunc, and exports its state through MPTCP diagnostics.

The MPTCP core enforces the avoid preference for send and
retransmission selection. Non-avoided subflows are preferred while
preserving the existing active/backup selection priorities.
Avoided subflows remain available as fallback candidates.

When a BPF scheduler schedules both avoided and non-avoided
subflows, the core drops the avoided selections. If only avoided
subflows are selected, the core retries through the default selector.

The second patch adds a BPF struct_ops selftest that deliberately
schedules avoided and non-avoided subflows and checks core filtering
and persistent avoid state across scheduling rounds.

Changes since v7:
- Enforce avoid preference in core send and retransmission selection.
- Preserve active/backup priorities and avoided fallback candidates.
- Exercise core filtering and persistent state in the BPF selftest.
- Handle scheduler success without a selected subflow correctly.

Kalpan Jani (2):
  mptcp: sched: add subflow avoid flag for BPF schedulers
  selftests: mptcp: bpf: exercise the subflow avoid flag across rounds

 include/uapi/linux/mptcp.h                    |   1 +
 net/mptcp/bpf.c                               |   1 +
 net/mptcp/diag.c                              |   2 +
 net/mptcp/protocol.c                          |  76 +++++++---
 net/mptcp/protocol.h                          |   3 +
 net/mptcp/sched.c                             | 141 ++++++++++++++++--
 .../testing/selftests/bpf/prog_tests/mptcp.c  |  15 ++
 .../selftests/bpf/progs/mptcp_bpf_avoid.c     |  86 +++++++++++
 8 files changed, 287 insertions(+), 38 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/progs/mptcp_bpf_avoid.c

-- 
2.43.0

