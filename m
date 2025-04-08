Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A25B279C4
	for <mptcp@lists.linux.dev>; Tue,  8 Apr 2025 02:01:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744077684; cv=none; b=rhif/X8eYrCkCm0jyrfppfQQkUwyQbQSLPUt9i3detUO7v3EmSLjfUMj42aSO9t+y/CqUORz+3UO9LrYjQADeHszq9LIcbHYd1zV3MzUqE7HlcFiS/ofslM+h6QKrZf8z92NNWVfSE97twAwJ/FrjNtoBlNtbcfeRFjyobX7jmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744077684; c=relaxed/simple;
	bh=akZtuAGziOm51Xw4IW8ahjwkUsr1KZ53uDNiWu1AGLA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JBHc7WzIvi84qQs6jsaqJXsi1ah+07TQG/r9NBg35wugsCUXSx4ljySAS3GtJrZQ8K3Yt6jMY73gQ5yYa79lJ7H/07/PlTgoixqSEtZxEzfYjAgnlogku9/mfy2ixM333/+Ky38iUmyJuPwBqes2+lOCo7e9zLQabgBkcr66uzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 590cf00e141d11f0a216b1d71e6e1362-20250408
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.45,REQID:61dada56-1f2a-4352-b355-3be4cba28b99,IP:10,
	URL:25,TC:0,Content:0,EDM:0,RT:0,SF:-9,FILE:0,BULK:0,RULE:Release_Ham,ACTI
	ON:release,TS:26
X-CID-INFO: VERSION:1.1.45,REQID:61dada56-1f2a-4352-b355-3be4cba28b99,IP:10,UR
	L:25,TC:0,Content:0,EDM:0,RT:0,SF:-9,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:26
X-CID-META: VersionHash:6493067,CLOUDID:0c2894d2a7f5344850161dd2fe5c23c6,BulkI
	D:2504071023431JOZ129G,BulkQuantity:1,Recheck:0,SF:17|19|24|45|64|66|78|80
	|81|82|83|102|841,TC:nil,Content:0|50,EDM:-3,IP:-2,URL:11|1,File:nil,RT:ni
	l,Bulk:40,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,B
	RR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD,TF_CID_SPAM_FSI,
	TF_CID_SPAM_ULN
X-UUID: 590cf00e141d11f0a216b1d71e6e1362-20250408
X-User: yangang@kylinos.cn
Received: from localhost [(223.70.159.239)] by mailgw.kylinos.cn
	(envelope-from <yangang@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 1430170399; Tue, 08 Apr 2025 10:01:12 +0800
Date: Tue, 8 Apr 2025 10:00:50 +0800
From: Gang Yan <yangang@kylinos.cn>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: mptcp@lists.linux.dev
Subject: Re: [PATCH 2/2] BCC: python: add a useful tool for mptcp
Message-ID: <20250408020050.GB21239@yangang-pc>
References: <cover.1743988616.git.yangang@kylinos.cn>
 <df79879bf4e8c5c73ffcc557cdb6f517e29ccae7.1743988616.git.yangang@kylinos.cn>
 <a4df5346-ecaf-4dda-99ea-9652e2db484c@kernel.org>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <a4df5346-ecaf-4dda-99ea-9652e2db484c@kernel.org>

On Mon, Apr 07, 2025 at 11:09:59AM +0200, Matthieu Baerts wrote:
Hi Matt,

> Hi Gang,
> 
> On 07/04/2025 04:37, Gang Yan wrote:
> > Multipath TCP (MPTCP) is an extension of the standard TCP protocol
> > that allows a single transport connection to use multiple network
> > interfaces. MPTCP is useful for applications like bandwidth
> > aggregation, failover, and more resilient connections.
> > 
> > Linux kernel starts to support MPTCP since v5.6, this patch provides
> > a method which can easily force applications use MPTCP socket without
> > modifing its code.
> > 
> > Signed-off-by: Gang Yan <yangang@kylinos.cn>
> > ---
> >  tools/mptcpboost.py  | 82 ++++++++++++++++++++++++++++++++++++++++++++
> >  tools/mptcpboost.txt | 22 ++++++++++++
> 
> Small detail: what about re-using the "mptcpify" name
>
OK, I'll use this name in v2.

> https://elixir.bootlin.com/linux/latest/source/tools/testing/selftests/bpf/progs/mptcpify.c
> https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git/commit/?id=ddba122428a7
> 
> Once applied on BCC side, we could update our website to point to this
> program:
> 
>   https://www.mptcp.dev/setup.html#force-applications-to-use-mptcp
> 
> >  2 files changed, 104 insertions(+)
> >  create mode 100644 tools/mptcpboost.py
> >  create mode 100644 tools/mptcpboost.txt
> > 
> > diff --git a/tools/mptcpboost.py b/tools/mptcpboost.py
> > new file mode 100644
> > index 00000000..0ddd731a
> > --- /dev/null
> > +++ b/tools/mptcpboost.py
> > @@ -0,0 +1,82 @@
> > +#!/usr/bin/env python
> > +#
> > +# mptcpboost Make the applications to use MPTCP.
> > +#           For Linux, uses BCC, eBPF. Embedded C.
> > +#
> > +# USAGE: mptcpboost -t
> > +#
> > +# Copyright 2025 Kylin Software, Inc.
> > +# Licensed under the Apache License, Version 2.0 (the "License")
> > +#
> > +# 05-Apr-2025   Gang Yan   Created this.
> > +
> > +import ctypes as ct
> > +import argparse
> > +import signal
> > +import time
> > +
> > +from bcc import BPF
> > +
> > +#arguments
> > +parser = argparse.ArgumentParser(
> > +         description="mptcpboost try to force applications use MPTCP")
> 
> detail: 'to' missing: try to force applications *to* use MPTCP
> 
> Maybe clearer if we add 'instead of TCP'?

Thanks for your suggestion, it sounds good.

> > +parser.add_argument("-t", "--targets", required=True, type=str,
> > +                    help="use ',' for multi targets, eg: 'iperf3,rsync'")
> 
> Could it be eventually optional to force all apps from the same CGroup
> to use MPTCP instead of TCP?
> 
> 
> Another idea is to restrict this transformation to the app passed in
> argument, e.g.
> 
>   mptcpify -- iperf3 -s
> 
> (but can be done later if this makes sense)

Yeah, I think this can be done later.

> > +
> > +args_str = parser.parse_args()
> > +args_list = [t.strip() for t in args_str.targets.split(',')]
> > +
> > +if (not BPF.support_fmod_ret()):
> > +    print("Your kernel version is too old,"
> > +          " fmod_ret method is only support kernel v5.6 and later.")
> 
> v5.7?
> 
> > +    exit()
> > +
> > +TASK_COMM_LEN = 18
> > +
> > +class app_name(ct.Structure):
> > +    _fields_ = [("str", ct.c_char * TASK_COMM_LEN)]
> > +
> > +# define BPF program
> > +prog = """
> > +#include <linux/net.h>
> > +#include <uapi/linux/in.h>
> > +#include <linux/string.h>
> > +
> > +struct app_name {
> > +    char name[TASK_COMM_LEN];
> > +};
> > +
> > +BPF_HASH(support_apps, struct app_name);
> > +
> > +KMOD_RET(update_socket_protocol, int family, int type, int protocol, int ret)
> > +{
> > +    struct app_name target = {};
> > +    bpf_get_current_comm(&target.name, TASK_COMM_LEN);
> > +
> > +    if ((family == AF_INET || family == AF_INET6) &&
> > +        type == SOCK_STREAM &&
> > +        (!protocol || protocol ==IPPROTO_TCP) &&
> 
> detail: space missing after '=='

Thanks!

> > +        support_apps.lookup(&target))
> > +        return IPPROTO_MPTCP;
> > +
> > +    return protocol;
> > +
> > +}
> > +
> > +"""
> > +
> > +b = BPF(text=prog)
> > +b.attach_fmod_ret("update_socket_protocol")
> > +
> > +support_apps = b.get_table("support_apps")
> > +for i in args_list:
> > +    app = i.encode()
> > +    name = app_name()
> > +    name.str = app[:TASK_COMM_LEN-1].ljust(TASK_COMM_LEN, b'\0')
> > +    support_apps[name] = ct.c_uint32(1)
> > +
> > +print("MPTCP is been applied in ", args_list);
> 
> detail: MPTCP is being forced for:
> 

OK!

> > +signal.pause()
> > +#while(1):
> > +#   time.sleep(200)
> 
> I guess you can remove the comments.

Sure, that's my fault.
> 
> Cheers,
> Matt
> -- 
> Sponsored by the NGI0 Core fund.
> 
> 
