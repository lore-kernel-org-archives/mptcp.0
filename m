Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 605A67BB03
	for <mptcp@lists.linux.dev>; Wed, 31 Jan 2024 13:44:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706708694; cv=none; b=QMV5s8B1u7br3zBmMGzQzDlXzQfWmQEw7nd/kXUCL/8FaZjYIdLCtJlxF2zKUQEicaoIuE8PudE5v5Oejzq1dp2g858NgQtXfUcF4NrWW0ZVFC47PVZI7WdUXnGWlajz60g+iVe2OzeXqdaUqNEurbbAmuM/3hStcp1BoMaJw7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706708694; c=relaxed/simple;
	bh=ngn/dH6TuTzd70KcL5lOHuiIhe9KC73e9hnFHFOqRAk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ipby8VANWs1M6rRuoBF6ZXSQ6tptIMVyGjMtVTkTtt7xO2iKZ7giypHiW/S+CyxniHSfcWkIASyJT0RUE6Fti7y5c2RT8d9Wda1AsD7s/WMICdeGmPr0rU+3UJcK9saNkfB66Ae30i+J+rx0ZAxNOi7M08yGx5GcCGEJMIeg/oc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UCPA0RZB; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UCPA0RZB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB4A2C433F1;
	Wed, 31 Jan 2024 13:44:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706708693;
	bh=ngn/dH6TuTzd70KcL5lOHuiIhe9KC73e9hnFHFOqRAk=;
	h=From:To:Cc:Subject:Date:From;
	b=UCPA0RZBTxaUALnExLjhdXGzLjK768cM80+BHAOLn7nCytoB39/dHY9iwTNKbRsbs
	 JyzXbcgHnMwPHA0CdX/+X/9GZF3es4CwUX7HydU3mbEX25hJzVcPMDr0NTFQdTKN5d
	 nX4L+m3YZwf/PsK1d7E7RE6QPmomtKuUEPqDuB84uNvl/JS4RdZpFfdqeMEkQt6ngh
	 o1WO1noFmJBiLL13WY1Bk7b3aBqOVfCklXvhEH+ppk8fWirYxeLKWx2x+490Ouz1jb
	 HAcjnXhmp+VXRuA5+UAXnmYyOBLPGKq02TbJKlvFpy7BhrTHwq3I79+mbKBL2WR558
	 FUzgaoBdPHbNg==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@linux.dev>,
	"Matthieu Baerts (NGI0)" <matttbe@kernel.org>,
	kernel test robot <lkp@intel.com>
Subject: [PATCH mptcp-next] mptcp: bpf: fix compilation error without BPF_JIT
Date: Wed, 31 Jan 2024 14:44:22 +0100
Message-ID: <20240131134421.1045648-2-matttbe@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1229; i=matttbe@kernel.org; h=from:subject; bh=ngn/dH6TuTzd70KcL5lOHuiIhe9KC73e9hnFHFOqRAk=; b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBluk61Lmw5Fp2wPPvYjoI9oHmDG4ghmJI42ctXL TnQIzSDSUiJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZbpOtQAKCRD2t4JPQmmg c6/yD/wOoh/QvCdnRJeSUYcRTBL0u/vQ6AYndqy7spxO71A9V0DuO9JfGJFT+9nN78HUDkcSWqw oETmABhMtZwJHQVRUO+QUyqnKGW/Jh5B9rm4rIqnZTmGgoZo11Eie0UBb4YeC0JXYuSBnXFZtz+ JWBAgDyuSgA6mLp4/KphXSlqhp5XyrtfxFaeMdB6ptsF5yaF6MbgQPwH75fimyObMStdGf5AgQO dCWftTz4mw17FLFcofeJnCFe+h+xwfeQAvgVKOOmtdxbC/UffALo/P6eDq0evUYaKQEKqn2fDZk wBwNbAq30p4U03CjM9L1kYJPXHpsfXct7mouayBlJqDROt5rzI+p0Igf8FXwu2LodcNSXeyVvNR +DaIYKaNKR1DSoQ1NmPE0srwOzCS0PNFpMPFTAg0HNb0j0IoPT/u/LXB6Mp1X1TG5Wfa0VXBb+o 8zrFohHjraBW4HL7LDBDpeq5g6oqrwSwG+zad4ncQt9XUQfhI4Udyfx0bXbuFZFVVTZ7eILZGHl YhLXgdqYYP8TDf8F7Oq5Y9A8MS7JlywSaMI+lsPHle+UdstZYP7oID8yqUm34zrV2/1z4NGdivE G5pocARQ/pelS/+GUSkL92fHcpvlAJ+2j2fF6WEXHEQOWMbUuUk4Ae+VhQ7IxLMtlZql8g6i3fA l9rjhYbDxhMDu/g==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp; fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073
Content-Transfer-Encoding: 8bit

'bpf_mptcp_sched_ops' is only declared is CONFIG_BPF_JIT is set.

I guess we don't want to define it if we don't need it. We could add a
new helper doing nothing if BPF_JIT is not enabled, but it is probably
enough to just add a ifdef here, in the init function.

Fixes: 8ac5b9528258 ("mptcp: bpf: adapt code to match upstream changes")
Fixes: e76812a9ec49 ("bpf: Add bpf_mptcp_sched_ops")
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202401312020.oG1MfzT1-lkp@intel.com/
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/bpf.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/mptcp/bpf.c b/net/mptcp/bpf.c
index 55a65899b179..6ba531032fce 100644
--- a/net/mptcp/bpf.c
+++ b/net/mptcp/bpf.c
@@ -238,7 +238,9 @@ static int __init bpf_mptcp_kfunc_init(void)
 	ret = register_btf_fmodret_id_set(&bpf_mptcp_fmodret_set);
 	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_STRUCT_OPS,
 						&bpf_mptcp_sched_kfunc_set);
+#ifdef CONFIG_BPF_JIT
 	ret = ret ?: register_bpf_struct_ops(&bpf_mptcp_sched_ops, mptcp_sched_ops);
+#endif
 
 	return ret;
 }

base-commit: 2710fa51b8b5cdfc0bd517cfd6e1cb3d52fc8cd8
-- 
2.43.0

