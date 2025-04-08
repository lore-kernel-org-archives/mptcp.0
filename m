Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4D5B134B0
	for <mptcp@lists.linux.dev>; Tue,  8 Apr 2025 01:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744077427; cv=none; b=GE/uw29JenK8eoHgFKA+l+bhLRK/0YNT88OevN+f4phwWcAQI0HTMHfDQxBW4uGZtGBP1X8cUglwABZj9oy07bg1y8pTN18kaSiWWbHrOehGV4E0F68E0I8H3tWrZYnqjO6RxEUJUyZ5JGWHwdX0TBNJ3c/nPwvJFy1vxqM7o6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744077427; c=relaxed/simple;
	bh=kcB2f0Qs9Wa/seNDMOxconPX8DmtC6XKdy27WzFahb4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u8PUIouJ0U0zeLJkebxSKJoSTgoYbqZ2EARUsXrX9v9D5OYtMFwThQTQ13GI/a8b3iW5z5Thn6cz4bdSEoAd2qPo1x/VF0aur3RHbJYN2qdoM2ZOpQVm5RgN9P6KtbMCogedfmBHmU1QiIiIRMz1f6aOB8CiDNhtID9B8fAiKd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: be6fe6a0141c11f0a216b1d71e6e1362-20250408
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.45,REQID:271326ea-ca8e-49ab-827e-718c3190ec13,IP:10,
	URL:0,TC:0,Content:0,EDM:0,RT:0,SF:-9,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:1
X-CID-INFO: VERSION:1.1.45,REQID:271326ea-ca8e-49ab-827e-718c3190ec13,IP:10,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:-9,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:1
X-CID-META: VersionHash:6493067,CLOUDID:104789770266ea34cf3438cb4a42c8a3,BulkI
	D:250407102123BAO098A4,BulkQuantity:1,Recheck:0,SF:17|19|24|45|64|66|78|80
	|81|82|83|102|841,TC:nil,Content:0|50,EDM:-3,IP:-2,URL:1,File:nil,RT:nil,B
	ulk:40,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:
	0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD,TF_CID_SPAM_FSI,
	TF_CID_SPAM_ULS
X-UUID: be6fe6a0141c11f0a216b1d71e6e1362-20250408
X-User: yangang@kylinos.cn
Received: from localhost [(223.70.159.239)] by mailgw.kylinos.cn
	(envelope-from <yangang@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 675325205; Tue, 08 Apr 2025 09:56:53 +0800
Date: Tue, 8 Apr 2025 09:56:49 +0800
From: Gang Yan <yangang@kylinos.cn>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: mptcp@lists.linux.dev
Subject: Re: [PATCH 1/2] BCC: Python: Support 'fmod_ret' method for eBPF
Message-ID: <20250408015649.GA21239@yangang-pc>
References: <cover.1743988616.git.yangang@kylinos.cn>
 <766ea5e9772f92d97100f8b52e70b2895c3de628.1743988616.git.yangang@kylinos.cn>
 <851297ad-5e66-4374-9914-cd48868c4c7b@kernel.org>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <851297ad-5e66-4374-9914-cd48868c4c7b@kernel.org>

On Mon, Apr 07, 2025 at 11:07:41AM +0200, Matthieu Baerts wrote:
Hi Matt,


> Hi Gang,
> 
> On 07/04/2025 04:37, Gang Yan wrote:
> > In kernel, there exists a lot of 'fmod_ret' functions, such as
> > 'update_socket_protocol'. But it cannot be attached in BCC-python
> > directly, so this patch provides an interface for Python to use
> > 'fmod_ret' attaching method.
> > 
> > Signed-off-by: Gang Yan <yangang@kylinos.cn>
> > ---
> >  src/python/bcc/__init__.py | 43 ++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 43 insertions(+)
> > 
> > diff --git a/src/python/bcc/__init__.py b/src/python/bcc/__init__.py
> > index 8bc85516..96de3d40 100644
> > --- a/src/python/bcc/__init__.py
> > +++ b/src/python/bcc/__init__.py
> > @@ -461,6 +461,7 @@ class BPF(object):
> >          self.raw_tracepoint_fds = {}
> >          self.kfunc_entry_fds = {}
> >          self.kfunc_exit_fds = {}
> > +        self.fmod_ret_fds = {}
> >          self.lsm_fds = {}
> >          self.perf_buffers = {}
> >          self.open_perf_events = {}
> > @@ -1157,6 +1158,21 @@ class BPF(object):
> >              return True
> >          return False
> >  
> > +    @staticmethod
> > +    def support_fmod_ret():
> > +        if not BPF.support_kfunc():
> > +            return False
> > +
> > +        kernel_version = platform.release()
> > +        major, minor, _ = kernel_version.split(".")
> > +
> > +        if int(major) > 5:
> > +            return True
> > +        elif int(major) ==5 and int(minor) >= 6:
> 
> Was it not introduced in v5.7 instead of v5.6?
> 
>   return int(major) > 5 or (int(major) == 5 and int(minor) >= 7)
> 
I think v5.7 is right, the 5.6 is from the bcc repo:

bcc/example/cpp/KModRetExample.cc:
	 * Kfunc modify_ret support is only available at kernel version 5.6 and later.

Maybe this is also need to be fixed later?

> 
> https://lore.kernel.org/20200304191853.1529-1-kpsingh@chromium.org
> 
> 
> But also, it feels wrong to look at the kernel version, in case of
> backports, etc. Can you not look at something else? e.g. kallsyms?
>

Do you think we can do this after making a PR first?

> Cheers,
> Matt
> -- 
> Sponsored by the NGI0 Core fund.
> 
> 
