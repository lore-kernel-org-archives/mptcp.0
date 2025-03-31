Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 744AC2E3371
	for <mptcp@lists.linux.dev>; Mon, 31 Mar 2025 02:22:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743387730; cv=none; b=i6dl4BYxAiRjLD4kBqHEQizsJ5sy/es/8DgqLPkcXXOpAf1c+ORZ8+e77hmZXVAXKXyvJufKa7IH+N2M1F+C7a3uemTqwF1PVC4EhhVbSFcscYwyycRBnTvBeKkRJqGIe6dIAPEUmyucchCIPmL1DbL3+IY8/0EHr2DmEcd+Rvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743387730; c=relaxed/simple;
	bh=Ai1jaL1dC+L7Jg8d378z5BkJUT6rSWxebSU1arbpXIw=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=oZ/DJTD9z9+lUNJvXN7FWlKbTIeRg4HACHEsWrMMCI3mBcV4KemgKQGLMMWgvyucRHU5cfoKczdc8VWZHw82ejAGPeBngtanYuRyoxAsv9i+rHdQJNPFtSDZnzXlKUP56Cb83DPt4KdyGTVjXvUXm9Dw5yllOxdFjdj63IxsnpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: e7b6fda60dd611f0a216b1d71e6e1362-20250331
X-CID-O-RULE: Release_Ham
X-CID-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.45,REQID:f8eef04d-8c8e-42f5-a493-35ebab19682a,IP:10,
	URL:12,TC:0,Content:-5,EDM:25,RT:0,SF:-9,FILE:0,BULK:0,RULE:Release_Ham,AC
	TION:release,TS:33
X-CID-INFO: VERSION:1.1.45,REQID:f8eef04d-8c8e-42f5-a493-35ebab19682a,IP:10,UR
	L:12,TC:0,Content:-5,EDM:25,RT:0,SF:-9,FILE:0,BULK:0,RULE:Release_Ham,ACTI
	ON:release,TS:33
X-CID-META: VersionHash:6493067,CLOUDID:433c25010444d1d5d6fcb4713522cd2d,BulkI
	D:250331102153M28FG0XJ,BulkQuantity:0,Recheck:0,SF:17|19|24|43|66|74|78|10
	2,TC:nil,Content:0|50,EDM:5,IP:-2,URL:11|1,File:nil,RT:nil,Bulk:nil,QS:nil
	,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_FSD,TF_CID_SPAM_FSI,TF_CID_SPAM_ULN,TF_CID_SPAM_SNR,
	TF_CID_SPAM_FAS
X-UUID: e7b6fda60dd611f0a216b1d71e6e1362-20250331
X-User: yangang@kylinos.cn
Received: from localhost [(223.70.159.239)] by mailgw.kylinos.cn
	(envelope-from <yangang@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 424711577; Mon, 31 Mar 2025 10:21:51 +0800
Date: Mon, 31 Mar 2025 10:21:48 +0800
From: Gang Yan <yangang@kylinos.cn>
To: mptcp@lists.linux.dev
Subject: A question about openssh over MPTCP
Message-ID: <20250331022148.GA34015@yangang-pc>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Dear maintainers:

Hello everyone, there exists a method in 'https://www.mptcp.dev'
which can use openssh over MPTCP. But when I followed the guide
to use ssh's tools in two subflows, such as 'scp' and 'git clone <ssh link>', the
speed is the same as the TCP, which is weird. I have checked
the there is one 'msk' and two 'ssk' with 'ss -Mtie', and both subflows
is transferring the data, but the total speed is the same as TCP. 

Do you ever checked the 'scp' before? And maybe there exists a bug here?
By the way, can you provide some ideas to find out the root readson?

Thanks a lot!!!

Cheers!
Gang
