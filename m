Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [216.205.24.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1EB370
	for <mptcp@lists.linux.dev>; Fri, 23 Jul 2021 08:49:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1627030157;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zDY/W/s3BJnzq4r5SGNTPtzGODuTbLXsjHl14EsZPHo=;
	b=Ko1acpLH16zql3HjyZpb6Dtlt4CIVyEUfEEqXMQeGbEmT0MS5cI9ZnzrjAyy4wkbtbBAWl
	QMenf/ZBNHUxgwwDC97bkGdpbMDkRzLbuFun2N3UyGigGBm6G6mRZmExZPHWC1C4evuZLn
	xHYv3wf2t0zrUNfgbFw8oSA6u7GPcAQ=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-275-e0OaXzXtO2ivgN-7fRrxMQ-1; Fri, 23 Jul 2021 04:49:15 -0400
X-MC-Unique: e0OaXzXtO2ivgN-7fRrxMQ-1
Received: by mail-wr1-f69.google.com with SMTP id d18-20020adfe8520000b02901524df25ad7so732245wrn.8
        for <mptcp@lists.linux.dev>; Fri, 23 Jul 2021 01:49:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=zDY/W/s3BJnzq4r5SGNTPtzGODuTbLXsjHl14EsZPHo=;
        b=C7MsvFI9A7Ja/G5rj13jGBtLdt7Kihf85cTOGYn7+r7mI6Mk5WQl3nSmmKMro6uKkl
         UAewIdGenxuFBqHBGfNSs4I1SM2VFgusltdG1vtWLc0xuVEKGsBRzqOKOrTsYmEWrHa9
         020FjM7eXRwyXpvVHx1qIzKzj3jSdsFB/7bWjyL6zx5/zKT8WxSsR2/lI/VD3CFFbJek
         b8mynczCo8Wxnia84/CNL/gnTlkNlP+1t/NTQoetMxbcqBRsAxiFtaHa6iU8YgOtfY3Z
         0rSaxPtKm8OSdX7T91mZafff+NDN7Ioyq7cldSPpz8ZrtN7RR78O5BC053qveBHznKYs
         m3Cg==
X-Gm-Message-State: AOAM5319Nvyo0TQnGlcDWui8fBvLO95Eml2/0i/PjuuiEQuXlUy3jIMa
	u4FMc2o0LpQyxCN8weLuYs0kM8+D6H5Cr+3yelXSKpIZSaqYhUe9bfjYNZCoTFawf+MSj8vP8r3
	sqLpOHchW+9l4TVw=
X-Received: by 2002:a7b:c301:: with SMTP id k1mr1483374wmj.165.1627030154616;
        Fri, 23 Jul 2021 01:49:14 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxToy1m8quQILqaogL5vzzesUyCOF4pTgJxEgmnaqP4mAQN9TbZ0H8sLXXvSGL7M8hHR7btNA==
X-Received: by 2002:a7b:c301:: with SMTP id k1mr1483355wmj.165.1627030154349;
        Fri, 23 Jul 2021 01:49:14 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-97-57.dyn.eolo.it. [146.241.97.57])
        by smtp.gmail.com with ESMTPSA id t5sm32709902wrw.38.2021.07.23.01.49.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Jul 2021 01:49:14 -0700 (PDT)
Message-ID: <a065d16447194006a098e27238be655c901feef7.camel@redhat.com>
Subject: Re: [RFC] mptcp: add MPTCP_INFO getsockopt
From: Paolo Abeni <pabeni@redhat.com>
To: Florian Westphal <fw@strlen.de>, mptcp@lists.linux.dev
Date: Fri, 23 Jul 2021 10:49:13 +0200
In-Reply-To: <20210722150154.10608-1-fw@strlen.de>
References: <20210722150154.10608-1-fw@strlen.de>
User-Agent: Evolution 3.36.5 (3.36.5-2.fc32)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
	auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pabeni@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Thu, 2021-07-22 at 17:01 +0200, Florian Westphal wrote:
> Its not compatible with mptcp.org kernel one:
> 1. mptcp.org defines 'struct mptcp_info', but we already have this for
>    inet_diag.
> 
> 2. 'struct mptcp_info', as defined by mptcp.org has different layout for
>    32/64 bit arches.
>    This is a problem for 32bit binaries on 64bit kernels.


I think the lack of binary compatibility with the OoO tree kernel is
nto a big deal - and anyhow is unsolvable, so we have to consider it
not a big deal ;)

I think it could *possibly* be nice to tie togethar mptcp_info
and mptcp_info_opt - e.g. pulling the second into the first and
unifying the handling, as tcp does for diag and GET_INFO. But perhpas
is just too much code/overhead?!?

> For those reasons a new 'struct mptcp_info_opt' is added which contains
> aligned_u64 fields to store the userspace buffer addresses.
> 
> 'struct mptcp_sub_info' is added as per mptcp.org kernel, but I don't
> like this structure.  I think 'src' and 'dst' are confusing terms.
> 
> AFAICS 'src' really is 'local address' (getsockname) and 'dst' is peer
> (getpeername).

+1 for 'local' and 'remote'

> Given mptcp-next has IPPROTO_MPTCP, this adds SOL_MPTCP.
> This also gives ample space to add mptcp specific sockopts.
> 
> In light of this, I wonder if it would make more sense to split the
> functionality.
> 
> Examples:
> 
> getsockopt(fd, SOL_MPTCP, SUBFLOW_ID, subflow_ids, &count);
> 
> sa.sa_family = subflow_ids[0];
> getsockopt(fd, SOL_MPTCP, SUBFLOW_GETPEERNAME, &sa, &len);
> ..
> sa.sa_family = subflow_ids[0];
> getsockopt(fd, SOL_MPTCP, SUBFLOW_GETSOCKNAME, &sa, &len);
> 
> tcp_info.tcpi_state = subflow_ids[0];
> getsockopt(fd, SOL_MPTCP, SUBFLOW_TCP_INFO, &tcp_info, &len);
> 
> ...
> 
> and so on.

+1 to fetch all the subflow info with a single syscall

+1 to pass back the user 2 sizes: one with
the "this is how much I copied to the buffer" and another with
"this is how much i would have copied".

> Alternatively one could overload e.g. the upper 8 bit:
> 
> getsockopt(fd, SOL_MPTCP, subflow_ids[0] << 24 | SUBFLOW_FOO, ...);

What about using:

struct mptcp_subflow_info {
	u32 	id;
	struct tcp_info info;
};

mptcp_subflow_info.id = id;
getsockopt(fd, SOL_MPTCP, &mptcp_subflow_info, ...);

?

Cheers,

Paolo

