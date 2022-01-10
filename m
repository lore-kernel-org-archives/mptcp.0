Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 763CF2CA2
	for <mptcp@lists.linux.dev>; Mon, 10 Jan 2022 11:38:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1641814699;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=F7txGnOSWHejQSH3ujJFP3hwBr7gBrZQZRMfo1z3jac=;
	b=NK86/SdKV8ynliuTFehy9ChfEZ6so3owF/5wej9svKIvN0PWf7kdeZMvtdXHZ7viJkalMu
	G+lbDAyA0K2r3+B0uNWyGf95sx2Obr63bNS0SMYSGzztxdpWkiCxw2L8gBBFb77quR4rkn
	+/vk2pY9eJi3LhrURs447JoTr07at/o=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-161-9e7DKi98O36wICNpgnexNA-1; Mon, 10 Jan 2022 06:38:18 -0500
X-MC-Unique: 9e7DKi98O36wICNpgnexNA-1
Received: by mail-wm1-f69.google.com with SMTP id i81-20020a1c3b54000000b003467c58cbddso8377708wma.5
        for <mptcp@lists.linux.dev>; Mon, 10 Jan 2022 03:38:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=F7txGnOSWHejQSH3ujJFP3hwBr7gBrZQZRMfo1z3jac=;
        b=NxCDCbbQx5Uiaw/Lol742Xff0V/qVNdVfx0GXCX3/amJGfgGIR1GN807giDJhBCxMA
         NYb/ZpP6oKzJ2osfhZy/SOvr6S9KJ9T/xJSqt2BCJYh921ePoLkX7tedayToIsPqOkq/
         SGu3PTopdMcbcPVTGlI3b33GAA+L/+RgzORlIwgoFmoAYDniXdwXs6JT9YM3HLfsmrCf
         g2EHldWsnZIhMWYgU9+Eb9BjVPUes/iNfRoebOeQP7Xc7Nmd+nscB0EUXlHbGB7yBZqY
         DMWEZWPXLKOZIlHdi7F6paPQae8HS+rnClJk6faLi+4q/r2ZI1kmR5t8A6OXZ+OV7PC1
         Iv3A==
X-Gm-Message-State: AOAM533VDfvb1Fff6yBmvlJbRGF3rbfR8PyHtY7hPKioIQ0Xux+2/i3d
	PgeJ995FmRxqG14l4Fi/wqx8g4eTyp2516LJbZQ6t2416Q4b4Q3lCUcDQgiZL7GPnkC+ejl0lR7
	Lex51N7bveysuK6s=
X-Received: by 2002:a1c:a385:: with SMTP id m127mr4574334wme.64.1641814696745;
        Mon, 10 Jan 2022 03:38:16 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwohRQ/NpaE1qPDsicLD4Oqt/0puFY4PvSwqcohTzT/nU4XMsOttgUF6QoNQ+y/buq3B7ljDA==
X-Received: by 2002:a1c:a385:: with SMTP id m127mr4574328wme.64.1641814696554;
        Mon, 10 Jan 2022 03:38:16 -0800 (PST)
Received: from gerbillo.redhat.com (146-241-97-184.dyn.eolo.it. [146.241.97.184])
        by smtp.gmail.com with ESMTPSA id o13sm6621703wrc.111.2022.01.10.03.38.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jan 2022 03:38:15 -0800 (PST)
Message-ID: <1b01c2a797fad9d2971d485b158d2dbd61d14fec.camel@redhat.com>
Subject: Re: [PATCH mptcp-next 2/7] mptcp: add clear_flags in pm_netlink
From: Paolo Abeni <pabeni@redhat.com>
To: Geliang Tang <geliang.tang@suse.com>, mptcp@lists.linux.dev
Date: Mon, 10 Jan 2022 12:38:14 +0100
In-Reply-To: <0132f80c0aa9f62deb00c816dab5d51d4032afb1.1641785106.git.geliang.tang@suse.com>
References: <cover.1641785106.git.geliang.tang@suse.com>
	 <0132f80c0aa9f62deb00c816dab5d51d4032afb1.1641785106.git.geliang.tang@suse.com>
User-Agent: Evolution 3.42.2 (3.42.2-1.fc35)
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

Hello,

On Mon, 2022-01-10 at 11:30 +0800, Geliang Tang wrote:
> Splite set_flags() into two parts, set_flags() and clear_flags(), make it
> easy to add new flags to set or clear.
> 
> This patch added a new PM command MPTCP_PM_CMD_CLEAR_FLAGS, and a new
> function mptcp_nl_cmd_clear_flags().
> 
> Signed-off-by: Geliang Tang <geliang.tang@suse.com>
> ---
>  include/uapi/linux/mptcp.h |  1 +
>  net/mptcp/pm_netlink.c     | 36 ++++++++++++++++++++++++++----------
>  2 files changed, 27 insertions(+), 10 deletions(-)
> 
> diff --git a/include/uapi/linux/mptcp.h b/include/uapi/linux/mptcp.h
> index f106a3941cdf..1ca9b13c2ed0 100644
> --- a/include/uapi/linux/mptcp.h
> +++ b/include/uapi/linux/mptcp.h
> @@ -92,6 +92,7 @@ enum {
>  	MPTCP_PM_CMD_SET_LIMITS,
>  	MPTCP_PM_CMD_GET_LIMITS,
>  	MPTCP_PM_CMD_SET_FLAGS,
> +	MPTCP_PM_CMD_CLEAR_FLAGS,
>  
>  	__MPTCP_PM_CMD_AFTER_LAST
>  };

I'm unsure if this has already been discussed in some mtg I missed. If
so, I'm sorry for the late feedback :(

Looking at the existing netlink interfaces, I *think* the preferred way
of handling this would be adding instead a couple of MPTCP address
flags:

	MPTCP_PM_ADDR_FLAG_NOBACKUP,
	MPTCP_PM_ADDR_FLAG_NOFULLMESH

As e.g. IFA_F_NOPREFIXROUTE, IFA_F_NODAD,...

The above should require a similar amount of code and will make it
clear that we can't/wan't to flip the SUBFLOW or SIGNAL flags.

WDYT?

Thanks!

Paolo

