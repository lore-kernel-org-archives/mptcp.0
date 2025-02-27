Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 158BC26FA7E
	for <mptcp@lists.linux.dev>; Thu, 27 Feb 2025 20:08:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740686939; cv=none; b=RR6wjVfFsWl37mWP8qih7Q+VrNGuZ+g6XrOwszRCrqt4es5P5qKi8WZZ8R0G78nW64RB31HXFscrjEut7Xa0CXeFxZvb3xlSJUZUP32kCCONFfHjDSRGdhNGW87SaWUJi5u6gcpBlH3G7eclFjjYTWkm2XYwIbv4SslpWTZ4OPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740686939; c=relaxed/simple;
	bh=PlNvfCTxZO9iioaLFbqLJwVVmhWfNrgtHAN0e82K7E8=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=iLNRnhErM/61r/y4ankaqvlufbPKOpL4ki8sAMXE4opLKWtg/774NHLI8XPyl4pK1E0z3rE5rH12ZrVM4Z2xY30lcN9c92H94durt2oLvPbPAjePyq7X5+LVn6Me+RbnE1v2GFQqBcyDKLejZv8/0en9ei0B1x+F2xy/9c0VeB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cl+wqhD3; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cl+wqhD3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C732BC4CEDD;
	Thu, 27 Feb 2025 20:08:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740686938;
	bh=PlNvfCTxZO9iioaLFbqLJwVVmhWfNrgtHAN0e82K7E8=;
	h=From:Subject:Date:To:Cc:From;
	b=cl+wqhD3ZmYVwTEi64eTxIGJvMGWVmKwsBFQVMGl3Mp2YD9tO30pO7e+D90FXwMIn
	 fWZaAbYlrhhex/DcM+Li+8cV8RW3k2g+8sPO936pSKRumjl5zGjKJUkR8ySbaCh/yo
	 lCacX7vj/W1c4WNA7yS+g1WrrmS00hGOgBy6PicelLNkXsuBYaEQHCm78v1f5YadS0
	 kvK94I0POeeDolbugb7dfjcY8q0agWMMuKlrVOiGx6JtNF7xWukGix/vlsuWMalGSN
	 2HMPe3lBvWd3ZJnWxB6LsNhNeHM16F7YckiBNjZuHkukg6jrrpZva59yMbTXVK9zXN
	 DTsiGUsCUhoDg==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Subject: [PATCH mptcp-next 0/7] mptcp: pm: code reorganisation
Date: Thu, 27 Feb 2025 21:08:47 +0100
Message-Id: <20250227-mptcp-pm-reorg-code-v1-0-cb4677096709@kernel.org>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAE/GwGcC/yWMSQqAMAwAvyI5G2grRfAr4kHbqDl0IRURxL9b9
 DgMMzcUEqYCQ3OD0MmFU6yg2wbcPseNkH1lMMpYZUyPIR8uYw4olGRDlzyh7qqxnVq8slDLLLT
 y9V1H+INI1wHT87weGgC5cQAAAA==
X-Change-ID: 20250227-mptcp-pm-reorg-code-13227530bd05
To: mptcp@lists.linux.dev
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, 
 Geliang Tang <geliang@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2081; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=PlNvfCTxZO9iioaLFbqLJwVVmhWfNrgtHAN0e82K7E8=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBnwMZYX6h52Y12/jZ/jZskZWJ1oZO5Jrgw8NzxA
 JI2Z4Syf5CJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZ8DGWAAKCRD2t4JPQmmg
 c2yuD/0Z2UpyclkYhUBw7rfGB2MynGCTs6i8UPlcxeIEjEVmeKMVRRVwSvvuqL7I5RYvkhVQFVE
 2Qfk+8XfL90/qhdDED7836T9kT7FVjJGedgu3tJKybeUt3PhfQXNNQfZp9JBrpaUUGzvggTL7nD
 4++PC/Xqy057457FykFXcT5vODCcYM/QoQSWaL9eQD2KazdbltMGIasm+cS+/z1H4DsFEXU/cyv
 +vKqqRpBA7ud34nZgFDFIRcdLo/zswOpOljyLRgCIVpkuFEetYs6022o77CuYpGd5WeThuz1smS
 WG8rGRZOd3QjnERUhPrUPEacZO23mjtlN23S8+37seZmb/IjHFWj4Opz2bXD3P7US2lbiZfc39l
 lZssejnLJlktLiJOlsM+ATam7w1i3Uo1dDFieR7mlkc/08Q/JmIprwljOBYXKdS34NQelm2iFdz
 Om6pLrPAmNjCI0y9SjDb4QFpceZu/83GxTJImwMKBB/o19+UeCwtgCazthibzWmocbMUGKInCuZ
 q0RNuCixOnhJvkytdnSRsSLs9vu1CeYBvkicNx+gxgyRVeJOsJ3ApGAN7yM/gWqUUjX89gBbsMS
 lMH2ktKfwJ791wmXPeFgzXeBASEz3qmk+BuzU0MgNB9ezvo1WMvGJU0wlMfCUhr+7rI6Z1ZkUTm
 FJ/pGdRm9clj3Tg==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

I have been thinking about that during the past couple of months, but
now, with the recent modifications done by Geliang, and the associated
reviews, I really think it is time to reorganise the code around the
path-managers to avoid confusions, and a mix of code used in different
conditions.

Here is a first proposition, feel free to comment! :)

Please look at the last patch for more details about the why and why
now.

I hope this will not cause too many issues with the in-progress patches.
I tried only to move the code around, and minimise the functions
renaming. Then, to switch to the new code, it might be easier to simply
copy your modified code from the old place to the new one. In other
words, duplicate the net/mptcp directory, then do a rebase, resolve the
conflicts with 'git restore --ours', then reapply the modifications by
copying your old code to the new place. If it is too difficult, please
let me know.

Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
Cc: Geliang Tang <geliang@kernel.org>

---
Matthieu Baerts (NGI0) (7):
      mptcp: pm: remove '_nl' from mptcp_pm_nl_addr_send_ack
      mptcp: pm: remove '_nl' from mptcp_pm_nl_mp_prio_send_ack
      mptcp: pm: remove '_nl' from mptcp_pm_nl_work
      mptcp: pm: remove '_nl' from mptcp_pm_nl_rm_addr_or_subflow
      mptcp: pm: avoid calling PM specific code from core
      mptcp: pm: worker: split in-kernel and common tasks
      mptcp: pm: code reorganisation

 net/mptcp/Makefile       |    2 +-
 net/mptcp/pm.c           |  685 ++++++++++++----
 net/mptcp/pm_kernel.c    | 1410 +++++++++++++++++++++++++++++++++
 net/mptcp/pm_netlink.c   | 1934 ++--------------------------------------------
 net/mptcp/pm_userspace.c |   11 +-
 net/mptcp/protocol.c     |    5 +-
 net/mptcp/protocol.h     |   37 +-
 7 files changed, 2051 insertions(+), 2033 deletions(-)
---
base-commit: 6b32949274eb9e32fe867ba9a8f8cb98587ecf36
change-id: 20250227-mptcp-pm-reorg-code-13227530bd05

Best regards,
-- 
Matthieu Baerts (NGI0) <matttbe@kernel.org>

