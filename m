Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19B098F5A
	for <mptcp@lists.linux.dev>; Tue,  8 Apr 2025 02:02:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744077753; cv=none; b=jNLqb70GPEAt2z/00GB4z0coN+sVd4dvY6KgZ5rIp3adNG7EnDi3VwItUumZ6O0hikLfDkqe22uGOZVDM49IsmM++vYMHB1F60XGMv8uKNQ2PTfGjhRkZQmRRSJfmSaoVYx+Zr4aRMaFrJS6GWnxSsYLC9G3aLdaicjlf+ikkuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744077753; c=relaxed/simple;
	bh=l4rgFyxCA8X79X1kTtTSirho9XqvSpc+j/Iy1RnutOw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oPwNIOZlD/EAGVNDplcVOpY3vHtWU10b2LHDKBVhHTRLegi7HxkBmX6nv6//NCsn6EzD8XFKwczUuTyA2htFDoSYTyLPPvyrI24Z9l1CdWtjnqNXGuhTZvKm3xjzySGqUMzgREijwSQ3pYy1fjH0T4MxOHyKVIKukTlLjUWA3ag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 848c7722141d11f0a216b1d71e6e1362-20250408
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.45,REQID:560ca447-e870-4e7e-b5f5-223c99c29c03,IP:10,
	URL:0,TC:0,Content:0,EDM:0,RT:0,SF:-9,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:1
X-CID-INFO: VERSION:1.1.45,REQID:560ca447-e870-4e7e-b5f5-223c99c29c03,IP:10,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:-9,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:1
X-CID-META: VersionHash:6493067,CLOUDID:2f35cc2f33492dddf7b4f285bc42bc37,BulkI
	D:250407170713PJMZXSZJ,BulkQuantity:2,Recheck:0,SF:17|19|24|45|64|66|78|80
	|81|82|83|102|841,TC:nil,Content:0|50,EDM:-3,IP:-2,URL:0,File:nil,RT:nil,B
	ulk:40,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:
	0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD,TF_CID_SPAM_FSI
X-UUID: 848c7722141d11f0a216b1d71e6e1362-20250408
X-User: yangang@kylinos.cn
Received: from localhost [(223.70.159.239)] by mailgw.kylinos.cn
	(envelope-from <yangang@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 838833848; Tue, 08 Apr 2025 10:02:25 +0800
Date: Tue, 8 Apr 2025 10:02:23 +0800
From: Gang Yan <yangang@kylinos.cn>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: mptcp@lists.linux.dev
Subject: Re: [PATCH 0/2] BCC: python: support fmod_ret
Message-ID: <20250408020223.GC21239@yangang-pc>
References: <cover.1743988616.git.yangang@kylinos.cn>
 <eee6ec90-65dc-42c3-8ed1-e2bd828eec21@kernel.org>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <eee6ec90-65dc-42c3-8ed1-e2bd828eec21@kernel.org>

On Mon, Apr 07, 2025 at 11:07:04AM +0200, Matthieu Baerts wrote:
Hi Matt,
> Hi Gang,
> 
> On 07/04/2025 04:37, Gang Yan wrote:
> > Support fmod_ret, and add a useful tool for mptcp, also
> > the interface can be verified with this function.
> > 
> > Gang Yan (2):
> >   BCC: Python: Support 'fmod_ret' method for eBPF
> >   BCC: python: add a useful tool for mptcp
> 
> Thank you for looking at this!
> 
> Personally, I don't know how BCC is working internally, but the
> modifications seem to make sense.
> 
> I have a few comments, but apart from that, feel free to create the PR
> on BCC repo.
>

Thanks for the comments!

Can I add your <Reviewd-by> in this PR?

> Cheers,
> Matt
> -- 
> Sponsored by the NGI0 Core fund.
> 
> 
