Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55405173
	for <mptcp@lists.linux.dev>; Wed, 12 Jan 2022 10:03:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1641981830;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vkPiQvgkZrfTwZANMTTpe2/9pPr9VWaREfysuKQtcOw=;
	b=gfAuU8NuNP6tucndNWY3eqwpVoJUup5SrLLnww3SzGvPiThYtB4BA2SSVYKTx60Mf9Fqjj
	Jz+NnuM3byGvufSTsZB/Uy3I3btURkE0ypO1ZFWmlr8MJQ5VtqNQCDBxzg8GDJnPlbESnl
	R6hOEtZVvT7Qqv/M0vMRhPrx7ssckJo=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-596-_ZWjADGSNaqWrvqwtVW8RA-1; Wed, 12 Jan 2022 05:03:49 -0500
X-MC-Unique: _ZWjADGSNaqWrvqwtVW8RA-1
Received: by mail-wr1-f71.google.com with SMTP id g21-20020adfa495000000b001a5fae24294so326688wrb.11
        for <mptcp@lists.linux.dev>; Wed, 12 Jan 2022 02:03:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=vkPiQvgkZrfTwZANMTTpe2/9pPr9VWaREfysuKQtcOw=;
        b=ytqO9kXCd8TlPnCTmIF2ui3cvMdUBL887BlTKL5oFqVwUuyOujV4uQkjxZfs1FUyBq
         0uFYFeOAdlvCal5kvgKTVvNV+TjkbauzcIUbWO7RgBTAyx4POwQ7Q0eDzUaYSMhdkRsf
         qR2E0IOfvHbEMpxhCCi5VVPlUjUIUOqJb3hhDiav+VRHrMrXTDLaxNOSH/STaCpaJLUu
         gLQiwkvmmJR31uC6aVuUD7EcVeGlTLG1x8mqL+lqKloCKrVdEgVE1ovy1ChmC/eYsskq
         tC/dgXo0I5F0Wmuj3NSPwrpmb2WKrZfUTh7YJF3lr8iuddf21LOj8X0eUhCGk+HIwzoI
         vrfQ==
X-Gm-Message-State: AOAM531D8KRRsnUfukT+7tpH4648N+IoXTE/tr8RtZgIw+EMX5WHc5WQ
	G5tkclhtHQJy10JIpp0ryLp4rFP2WbQHzjvD4Iu/pIQJ2p17DBxzps1FtYDo8ocTRcIAQT9cLiP
	wDr/yKwyhckTbkS4=
X-Received: by 2002:adf:9122:: with SMTP id j31mr7142685wrj.540.1641981827859;
        Wed, 12 Jan 2022 02:03:47 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxWWCsculLcvtwIKiYei79V2RmxWkaTvKbKzTFVqq7YL8UcmqQxe4YqOGSCU3qkCUVWKJCaZA==
X-Received: by 2002:adf:9122:: with SMTP id j31mr7142664wrj.540.1641981827549;
        Wed, 12 Jan 2022 02:03:47 -0800 (PST)
Received: from gerbillo.redhat.com (146-241-96-254.dyn.eolo.it. [146.241.96.254])
        by smtp.gmail.com with ESMTPSA id g84sm3804144wme.7.2022.01.12.02.03.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jan 2022 02:03:47 -0800 (PST)
Message-ID: <0fc82e5d1622efb3e1e26affd49ebb13ca32dd6a.camel@redhat.com>
Subject: Re: [PATCH mptcp-next v4 0/4] fullmesh flag setting support
From: Paolo Abeni <pabeni@redhat.com>
To: Geliang Tang <geliang.tang@suse.com>, mptcp@lists.linux.dev
Date: Wed, 12 Jan 2022 11:03:46 +0100
In-Reply-To: <cover.1641978967.git.geliang.tang@suse.com>
References: <cover.1641978967.git.geliang.tang@suse.com>
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

On Wed, 2022-01-12 at 17:33 +0800, Geliang Tang wrote:
> v4:
>  - update patch 1 as Paolo suggested.
>  - put the iproute2 patch into this series too.
>  - depend on:
>   mptcp: fix removing ids bitmap setting
>   mptcp: fix msk traversal in mptcp_nl_cmd_set_flags()
> 
> v3:
>  - drop MPTCP_PM_ADDR_FLAG_NOFULLMESH.
>  - clear both backup and fullmesh flags as Paolo suggested.
>  - depend on:
>   mptcp: fix removing ids bitmap setting
>   mptcp: fix msk traversal in mptcp_nl_cmd_set_flags()
> 
> v2:
>  - add MPTCP_PM_ADDR_FLAG_NOFULLMESH instead of MPTCP_PM_CMD_CLEAR_FLAGS
> 
> Added the fullmesh flag setting support:
>  # pm_nl_ctl set 10.0.1.1 flags fullmesh
>  # pm_nl_ctl set 10.0.1.1 flags nofullmesh
> 
> Geliang Tang (3):
>   mptcp: set fullmesh flag in pm_netlink
>   selftests: mptcp: set fullmesh flag in pm_nl_ctl
>   selftests: mptcp: add fullmesh setting tests
> 
>  net/mptcp/pm_netlink.c                        | 35 ++++++++++++++-----
>  .../testing/selftests/net/mptcp/mptcp_join.sh | 33 +++++++++++++----
>  tools/testing/selftests/net/mptcp/pm_nl_ctl.c |  7 ++--
>  3 files changed, 58 insertions(+), 17 deletions(-)
> 
> Geliang Tang (1):
>   mptcp: add the fullmesh flag setting support
> 
>  ip/ipmptcp.c        | 16 ++++++++++++----
>  man/man8/ip-mptcp.8 |  8 ++++++--
>  2 files changed, 18 insertions(+), 6 deletions(-)
> 
LGTM, thanks!

Acked-by: Paolo Abeni <pabeni@redhat.com>

