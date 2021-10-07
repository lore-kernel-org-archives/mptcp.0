Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [216.205.24.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B82442C83
	for <mptcp@lists.linux.dev>; Thu,  7 Oct 2021 11:26:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1633606011;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Oj+I4VVJKrKcUD7J12zVEhFLgxnj7ZDff0WgtSf0YXc=;
	b=DFQtpFnK78U69t+zduf8uZ984Up89X5NWb1jo2GFqFNCC3c1mDNv613rT6bwOUDUsije0J
	4NE0lweETZBNXPE2WxeU0ITRPKCazc38X1WUyBxbRxkV9nLVj1zRVpF8hD+Upp73aLH+Ma
	1euh8TwFAPOKYxTn8TxYKxGRp2UTMNs=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-513-qFKdUu7xMPSsVJR3vU6JDg-1; Thu, 07 Oct 2021 07:26:49 -0400
X-MC-Unique: qFKdUu7xMPSsVJR3vU6JDg-1
Received: by mail-wr1-f70.google.com with SMTP id e12-20020a056000178c00b001606927de88so4421106wrg.10
        for <mptcp@lists.linux.dev>; Thu, 07 Oct 2021 04:26:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=Oj+I4VVJKrKcUD7J12zVEhFLgxnj7ZDff0WgtSf0YXc=;
        b=NIZncxb0z+30Cu7XdNsBPOIH0a+Iy0DWaRd3x3FJYBeaWirKJi/rJP//Uu9hZsbYd8
         ibBm6dg3/IJ+4temOFMVZ/MZgChsPTTQ5eOlAdCgikn5b+ie9WBAxdfVJqt8R7V8lWa9
         jQ9IK8eYW6nS6gLXxxABd2vkkVsHFiE5YnjpSyvJgolTxnlFMRUii+j7NQJL9oQ1pg+L
         FGvaHfw75OiPrTECMnpKadZrP46d+Cs3IS90qJJyJ3yXdps56LJytGVHC4UIG46U/bwq
         mVVp4ZBH0pMjxW5mRChYALJEBVN0H8RqJ4zPX6fW7jz0XITtYoZrpnWsTaCtqEapXYFf
         qjog==
X-Gm-Message-State: AOAM533bStRVp1XHWqt1v3gyoJoMcSIIK4h1n3lCNMHlMYKr61gYEd2v
	SIO5Ot3yn1ggARLo6MPdBm+Dy6Bi51qdnHf1gccEUovMzW7D3NKyumIjBw6zRur5VZTfCmBF/Bs
	xDJ4hy9iu6Ztdtd0=
X-Received: by 2002:adf:97d4:: with SMTP id t20mr4584566wrb.174.1633606008100;
        Thu, 07 Oct 2021 04:26:48 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw79Ewd8Hrve6PPgtPh5ZhsOXMpZBWRN0FTs64oBPoASh2JKO506eH1LFG9ObAY2irJIiU6fA==
X-Received: by 2002:adf:97d4:: with SMTP id t20mr4584553wrb.174.1633606007939;
        Thu, 07 Oct 2021 04:26:47 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-225-183.dyn.eolo.it. [146.241.225.183])
        by smtp.gmail.com with ESMTPSA id f1sm27079035wri.43.2021.10.07.04.26.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Oct 2021 04:26:47 -0700 (PDT)
Message-ID: <927307c6be705ab82341f8923842eb6687c253cc.camel@redhat.com>
Subject: Re: [RFC PATCH 0/4] mptcp: Update netlink interface for userspace PM
From: Paolo Abeni <pabeni@redhat.com>
To: Florian Westphal <fw@strlen.de>, Kishen Maloor <kishen.maloor@intel.com>
Cc: mptcp@lists.linux.dev, mathew.j.martineau@linux.intel.com
Date: Thu, 07 Oct 2021 13:26:46 +0200
In-Reply-To: <20211007083218.GA7333@breakpoint.cc>
References: <20211007043656.261552-1-kishen.maloor@intel.com>
	 <20211007083218.GA7333@breakpoint.cc>
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

On Thu, 2021-10-07 at 10:32 +0200, Florian Westphal wrote:
> Kishen Maloor <kishen.maloor@intel.com> wrote:
> > This patch series marks the beginning of an attempt to update the MPTCP
> > netlink interface with commands to support the offloading of path management 
> > decisions to userspace path managers.
> > 
> > Specifically, the commits in this series introduce the following commands:
> > 
> > * MPTCP_PM_CMD_ANNOUNCE: Issue an ADD_ADDR advertisement over the selected MPTCP
> >   connection.
> 
> Looks like you guys are further ahead than me.
> I've pushed my work here:
> 
> iproute2:
> https://git.breakpoint.cc/cgit/fw/iproute2.git/log/?h=mptcp_sf_03
> 
> kernel:
> https://git.breakpoint.cc/cgit/fw/mptcp_net-next.git/log/?h=netlink_cmd_07
> 
> I had planned to work on packetdrill tests next but to avoid
> further duplicate work I will refrain from doing so.
> 
> Feel free to take what you need and/or mangle and discard this at will.

It looks like your patch:

mptcp: netlink: allow userspace-driven subflow establishment

implements feature not available here, while:

mptcp: netlink: allow userspace to perform address announcements

overlaps with this effort.

I think we can merge the 2 series into a single one dropping only the
later patch, if there is agreement.

Cheers,

Paolo

