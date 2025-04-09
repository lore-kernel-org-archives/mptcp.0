Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 165AA1DE3AA
	for <mptcp@lists.linux.dev>; Wed,  9 Apr 2025 09:29:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744190987; cv=none; b=IRdjMVM9+Aa69GGeYKX/RaXbP4KxFF296JKl+W341//wCqe2DZ1/9yFQ5jEN+g3G71kau6/Br3wgSWPBSF0d3k67TvCpijI4hMO9kVVXQA9ZFs6j7O7KAAFXWkudkBOkHRGi73GvqrOIiFZFo7dFFJjuEp7Sjd+Fe6Dm3n0Rbsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744190987; c=relaxed/simple;
	bh=RvaVkiPlOYNJ5AnwqqWHsTZWFSfLSwzD6k74lVGK+ns=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D7qeohTLKCxgLl83IRme02VfHeKGjtixVDQxyD/U1et/nM0CPLA3IODsP91M+UOUkjSrwzRT5frLbefrM0XjUbMwtvZQhYHbvFsd8Mjb/JBPAM3SAcHH1MLvfuhIXr1lH9p9NN4MH8MbriqPJXdu8vsmskeFHetK4ZSCF5/q3qs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 26f6ccf8152511f0a216b1d71e6e1362-20250409
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.45,REQID:636309fa-effa-4011-8942-729f9e5e8d01,IP:10,
	URL:0,TC:0,Content:0,EDM:0,RT:0,SF:-9,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:1
X-CID-INFO: VERSION:1.1.45,REQID:636309fa-effa-4011-8942-729f9e5e8d01,IP:10,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:-9,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:1
X-CID-META: VersionHash:6493067,CLOUDID:35c6ee8e582f6ae7f1553cccb17c00fa,BulkI
	D:2504091729364FD2CN82,BulkQuantity:0,Recheck:0,SF:17|19|24|45|64|66|78|80
	|81|82|83|102|841,TC:nil,Content:0|50,EDM:-3,IP:-2,URL:11|1,File:nil,RT:ni
	l,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,
	BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_FAS,TF_CID_SPAM_FSD,TF_CID_SPAM_FSI,TF_CID_SPAM_ULN,
	TF_CID_SPAM_SNR
X-UUID: 26f6ccf8152511f0a216b1d71e6e1362-20250409
X-User: yangang@kylinos.cn
Received: from localhost [(223.70.159.239)] by mailgw.kylinos.cn
	(envelope-from <yangang@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 967230987; Wed, 09 Apr 2025 17:29:36 +0800
Date: Wed, 9 Apr 2025 17:29:33 +0800
From: Gang Yan <yangang@kylinos.cn>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: mptcp@lists.linux.dev
Subject: Re: [Patch, v2, 1/2] BCC: Python: Support 'fmod_ret' method for eBPF
Message-ID: <20250409092933.GA16105@yangang-pc>
References: <cover.1744182834.git.yangang@kylinos.cn>
 <224f2b589ffd6e6f5aa42a213f5f6410c21f9dcf.1744182834.git.yangang@kylinos.cn>
 <1d6bceea-daae-49b5-918f-60df35b0791f@kernel.org>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1d6bceea-daae-49b5-918f-60df35b0791f@kernel.org>

On Wed, Apr 09, 2025 at 10:26:23AM +0200, Matthieu Baerts wrote:
Hi Matt,
> Hi Gang,
> 
> On 09/04/2025 09:17, Gang Yan wrote:
> > In kernel, there exists a lot of 'fmod_ret' functions, such as
> > 'update_socket_protocol'. But it cannot attached in BCC-python directly,
> > so this patch provides an interface for python to use 'fmod_ret'
> > attaching method.
> > 
> > But there exists a question about how to check 'fmod_ret' support in
> > kernel, do you have any suggestion? I already considered checking the
> > kernel version which seems not suitable.
> > 
> > Signed-off-by: Gang Yan <yangang@kylinos.cn>
> > ---
> >  src/python/bcc/__init__.py | 34 ++++++++++++++++++++++++++++++++++
> >  1 file changed, 34 insertions(+)
> > 
> > diff --git a/src/python/bcc/__init__.py b/src/python/bcc/__init__.py
> > index 8bc85516..12ce3ef6 100644
> > --- a/src/python/bcc/__init__.py
> > +++ b/src/python/bcc/__init__.py
> 
> (...)
> 
> > @@ -1189,6 +1205,22 @@ class BPF(object):
> >          self.kfunc_entry_fds[fn_name] = fd
> >          return self
> >  
> > +    def attach_fmod_ret(self, fn_name=b""):
> > +        fn_name = _assert_is_bytes(fn_name)
> > +        fn_name = BPF.add_prefix(b"kmod_ret__", fn_name)
> > +
> > +        if fn_name in self.fmod_ret_fds:
> > +            raise Exception("Fmod_ret func %s has been attached" % fn_name)
> Detail: maybe clearer with this:
> 
>   "Fmod_ret func %s is already attached"
> 
> (...)
>
In BCC's attach_kfunc:
	if fn_name in self.kfunc_entry_fds:
            raise Exception("Kernel entry func %s has been attached" % fn_name)
So I think it's better to keep the same with it.

I agree with your view that mptcpify.py should, by default, enforce the
use of MPTCP for all applications, and this feature will be incorporated
before it is integrated into BCC tools.

The PR link:
https://github.com/iovisor/bcc/pull/5274

Thanks!
Best wishes!
Gang
> Cheers,
> Matt
> -- 
> Sponsored by the NGI0 Core fund.
> 
> 
