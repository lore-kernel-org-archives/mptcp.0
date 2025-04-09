Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38076259CB8
	for <mptcp@lists.linux.dev>; Wed,  9 Apr 2025 07:23:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744183410; cv=none; b=edarxoFswwYMzh8pFxDBIETADa2vfNP2I9fFungJCQx+vQ71QE64QuZZkw0Tqvqe+b/BqTvTBE+AuqoI2VMVeLskLTYDZ+x8tinVcjrdyW7mLR4IG5C3Um+q2SVOAcybShmHDeSIj2d0MItgIJ6/0LdbSC2aY3e+JuGcnE4eM44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744183410; c=relaxed/simple;
	bh=ypzjL9rVa6Zs/DPvQUg1YtBxatzHYaxyfolMtGt9LpE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ttcDdHew98/Il2tu4zvgTQA6+TKa7xDkxLjCYMcujNpyz1KaWeF+QCwpFXKpz6kiPhmmB5UhFWoOW1FrwqtAE/I2QA/yHIhkw8nmMOQDK2fCQUc5aUws7le2norH9+rzTXlp0rSWvzX4VTJsX0oyYYHv2wnXpqnB/qaCwmyyT+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: c9b57128151211f0a216b1d71e6e1362-20250409
X-CTIC-Tags:
	HR_CC_AS_FROM, HR_CC_COUNT, HR_CC_DOMAIN_COUNT, HR_CC_NAME, HR_CTE_8B
	HR_CTT_MISS, HR_DATE_H, HR_DATE_WKD, HR_DATE_ZONE, HR_FROM_NAME
	HR_SJ_DIGIT_LEN, HR_SJ_LANG, HR_SJ_LEN, HR_SJ_LETTER, HR_SJ_NOR_SYM
	HR_SJ_PHRASE, HR_SJ_PHRASE_LEN, HR_SJ_WS, HR_TO_COUNT, HR_TO_DOMAIN_COUNT
	HR_TO_NO_NAME, IP_TRUSTED, SRC_TRUSTED, DN_TRUSTED, SA_TRUSTED
	SA_EXISTED, SN_EXISTED, SPF_NOPASS, DKIM_NOPASS, DMARC_NOPASS
	CIE_BAD, CIE_GOOD, CIE_GOOD_SPF, GTI_FG_BS, GTI_RG_INFO
	GTI_C_BU, AMN_T1, AMN_GOOD, AMN_C_TI, AMN_C_BU
	ABX_MISS_RDNS
X-CID-O-RULE: Release_Ham
X-CID-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.45,REQID:69afe325-d834-4790-aa20-0d55cde1cb0a,IP:10,
	URL:0,TC:0,Content:-5,EDM:0,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACT
	ION:release,TS:-10
X-CID-INFO: VERSION:1.1.45,REQID:69afe325-d834-4790-aa20-0d55cde1cb0a,IP:10,UR
	L:0,TC:0,Content:-5,EDM:0,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:-10
X-CID-META: VersionHash:6493067,CLOUDID:dc80e578fcda34b3bc8936d91ac2c537,BulkI
	D:250409150031B6J4XXF3,BulkQuantity:2,Recheck:0,SF:17|19|24|44|66|78|102,T
	C:nil,Content:0|50,EDM:-3,IP:-2,URL:11|1,File:nil,RT:nil,Bulk:40,QS:nil,BE
	C:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_FSD,TF_CID_SPAM_FSI,TF_CID_SPAM_ULN,TF_CID_SPAM_SNR,
	TF_CID_SPAM_FAS
X-UUID: c9b57128151211f0a216b1d71e6e1362-20250409
X-User: yangang@kylinos.cn
Received: from localhost.localdomain [(223.70.159.239)] by mailgw.kylinos.cn
	(envelope-from <yangang@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1594134112; Wed, 09 Apr 2025 15:18:08 +0800
From: Gang Yan <yangang@kylinos.cn>
To: mptcp@lists.linux.dev
Cc: Gang Yan <yangang@kylinos.cn>
Subject: [Patch, v2, 0/2] BCC: python: support fmod_ret
Date: Wed,  9 Apr 2025 15:17:51 +0800
Message-Id: <cover.1744182834.git.yangang@kylinos.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Support fmod_ret, and add a useful tool for mptcp, also
the interface can be verified with this function.

------
Changelog:
  v2:
    - change the name of the tool to 'mptcpify'
    - fix the code style problems in mptcpify.py
    - modify 'support_fmod_ret' in __init__.py, add some comment and
      ask for suggestions to BCC devs.

Hi Matt:

So nice to recieve your reply. Do you think we can create a PR with v2
patch to BCC now? The description of PR is attached below, Can you help
me to take a look?

'''
Multipath TCP (MPTCP) serves as an enhancement to the conventional TCP
protocol, enabling a single transport-layer connection to leverage
multiple network interfaces. This capability makes MPTCP advantageous
for applications requiring bandwidth consolidation, seamless failover
mechanisms, and more robust connectivity solutions.

Linux kernel starts to support MPTCP since v5.6, and it provides a
fmod_ret interface 'update_socket_protocol' to force applications using
MPTCP instead of TCP without modifyiing its code.

So these patches provide a tool named 'mptcpify' which can achieve this.
Using python-BCC is a more easy way for future development, so it is so
important to support 'fmod_ret' in python-BCC.

@matttbe from the MPTCP kernel team had a look at the new tool.
'''

Gang Yan (2):
  BCC: Python: Support 'fmod_ret' method for eBPF
  BCC: python: add a useful tool for mptcp

 src/python/bcc/__init__.py | 34 ++++++++++++++++
 tools/mptcpify.py          | 80 ++++++++++++++++++++++++++++++++++++++
 tools/mptcpify.txt         | 22 +++++++++++
 3 files changed, 136 insertions(+)
 create mode 100644 tools/mptcpify.py
 create mode 100644 tools/mptcpify.txt

-- 
2.25.1

