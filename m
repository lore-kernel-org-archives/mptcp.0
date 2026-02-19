Received: from mail-oa1-f45.google.com (mail-oa1-f45.google.com [209.85.160.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 675C034B194
	for <mptcp@lists.linux.dev>; Thu, 19 Feb 2026 17:11:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771521068; cv=none; b=myAg/anCGM7Ql8vG8+44zqmvk86DEHjRyUUfRuTZkeKlFTr4TG+DRPhHwmbXZJoUrAzhJ36ouPSVuy9wfpaEpzKe9rBNm9n1W63NP9TK7gTPb1E6De1iFZH4SkONa/xI+t6RsFC3Wcck2KGIskvCn+cckdJx5E7F13tVv6j9RhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771521068; c=relaxed/simple;
	bh=p+0yoUYOgqdCSsNYmHj7zM+lo5ChPaixfv+pRNVOGdU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gpjVnYtA7F1RI2VqLOeHIuNwjTiykpX+qCgdAnL3luTzeRM9VHknXyRA3Mjmn0ycRU19VrArCkMYLycirtzqTWd0SV7KDDZNNA7DP3KtBaEAdbnuC3X5MDrdTAb6INatA5+APY5YUrZxwXFhT+OAww07ybz1bRcTocsTNoCIymg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b=KLjXywJq; arc=none smtp.client-ip=209.85.160.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="KLjXywJq"
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-40946982a78so412173fac.2
        for <mptcp@lists.linux.dev>; Thu, 19 Feb 2026 09:11:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1771521065; x=1772125865; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dyrjZBaOYWnsTcDoFAVLra9VVv9NrS1xfuVC945Eoh4=;
        b=KLjXywJqAux5MV7/YjDk1l0+Jk3D87QRMw/wYJXT+V759DJDTNCGFCKY1pyVRy5LII
         qJYuyspxUGPkVFnVnp4ABukb9VQdeaOVoTrv0FInqy9ASDS4JEjS4V374t8BZojJ5cDP
         yScFggGMrTpaeEoL5SzrAH/arI8EgLO4y+t1eD+5+qAqQ6kGQuKoE9Bg734rg9fLjajQ
         D1OrQ58dXRJqAUvffiDi05774aJomdtdWnkKfBlhQKAH8zY9DdtZN8bTQO4DBXXniWf6
         w9j+pJIaExgIaQbpXfYlrrLJmWFPr2l7S4cvaJ7OCvVSslYdvAi3+5Be+ol6hje518Ju
         u2jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771521065; x=1772125865;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=dyrjZBaOYWnsTcDoFAVLra9VVv9NrS1xfuVC945Eoh4=;
        b=OEsOwZ/cFhGwwxh+miJTqMTemVH3wwvq8CeevQ754UMC2bpjViWt5JYp2wGmm5fIgq
         6Zu9GxoDfXAC1ud7Q0H+oIrWvvYlP4UJ5Ien8VLGb8a45a3XS62vB94gl0TON7CZLHly
         gE0wXv0Cg3dgo5kmVeF0U3mTll3nc5aGAScvnj0VHudOczBTLOOqWWed/w04diHqNqCW
         dZCQ3vhysmzEvORZu3NMjmHUpB2WGWOr6XEB/Ne5lPv723XtGYOaG7IZIGS33BuUhYKH
         HnjFIClTYUMy9PK3CXWw18DCrQsz4yxqLH6xxJUBXNnJbhK+R+0rarw6WrXXowsBiWkF
         PT2g==
X-Forwarded-Encrypted: i=1; AJvYcCWXm79e2+EuYnraDDf6vuFfS91scwd4DC3ifkby2uynDKZI+4r19oXa1WutS35o/O+Z+ZBZEA==@lists.linux.dev
X-Gm-Message-State: AOJu0YyvBymaRlJExt5vCqc8kmErLEcRRFuhprcLqkimG3A42Mp54msr
	D0FRDNiC8tSSKJDnuUAsf1ZFCdLkcOuSJ++qNQkrjCy4Qh8pzkjCEb7ZEP0REmz9upg=
X-Gm-Gg: AZuq6aKxiW14qqDvQcsBdcqrfTCg6fPyEzZCHpzbHY3Z+mx9y5lP95n9qw4hL61nMwu
	+RE7BiVUGi38aJoa+lUGspMap4PMsbxkU740iSTx7k2ciGqMFSv4qezm0luHo6iMjfJaKbytOR6
	5fYv7a6BK7hMly/p21gGvoOp3mYhzr0Tf6PVHbVxuv+OPP7MklpP82iqPWvIavwwKyZjfbMZeMu
	ZYF/sBbG1aA/hBcEXO6WukgvSdljHbP+eRoltMr+5iq1/PzYRVZId0dM93EZDX8jcYV7eIxlYAU
	3V9n3o67f012gT1vr24CnOmp9TLHydYuwN+ffaQEtR2dT0Le2VFYDYm6OkPwntjXtL0MnFeGsvN
	3I8owE8YtPDxTSWaHckCnP3K+Km+8lfGhUJq2ftDDsc8D6i/HT9QSF4n/4IuHqKKsYj4Oxa9/hF
	Y5Ol741nYhcD73lUjCkyYWR09j1TI3ymyhAZV1Ldmuk4JYA6P98PSdcUYZo8wugVPw
X-Received: by 2002:a05:6871:7508:b0:3fa:df3:b198 with SMTP id 586e51a60fabf-40ef3b771famr12402059fac.3.1771521064925;
        Thu, 19 Feb 2026 09:11:04 -0800 (PST)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-40eaf178c1fsm24492608fac.17.2026.02.19.09.11.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Feb 2026 09:11:04 -0800 (PST)
Date: Thu, 19 Feb 2026 09:11:01 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: David Ahern <dsahern@kernel.org>, netdev@vger.kernel.org,
 mptcp@lists.linux.dev
Subject: Re: [PATCH iproute2 1/2] mptcp: monitor: also show iface name
Message-ID: <20260219091101.551377a9@phoenix.local>
In-Reply-To: <a44c1f27-e9f0-4f33-beda-e5f611197e35@kernel.org>
References: <20260211-mptcp-color-v1-0-01832777611d@kernel.org>
 <20260211-mptcp-color-v1-1-01832777611d@kernel.org>
 <20260218103155.486d20ee@phoenix.local>
 <a44c1f27-e9f0-4f33-beda-e5f611197e35@kernel.org>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 18 Feb 2026 20:03:20 +0100
Matthieu Baerts <matttbe@kernel.org> wrote:

> Hi Stephen,
> 
> Thank you for the review!
> 
> On 18/02/2026 19:31, Stephen Hemminger wrote:
> > On Wed, 11 Feb 2026 13:03:17 +0100
> > "Matthieu Baerts (NGI0)" <matttbe@kernel.org> wrote:
> >   
> >> @@ -530,7 +541,7 @@ static int mptcp_monitor_msg(struct rtnl_ctrl_data *ctrl,
> >>  	if (tb[MPTCP_ATTR_TIMEOUT])
> >>  		printf(" timeout=%u", rta_getattr_u32(tb[MPTCP_ATTR_TIMEOUT]));
> >>  	if (tb[MPTCP_ATTR_IF_IDX])
> >> -		printf(" ifindex=%d", rta_getattr_s32(tb[MPTCP_ATTR_IF_IDX]));
> >> +		print_iface(rta_getattr_s32(tb[MPTCP_ATTR_IF_IDX]));
> >>  	if (tb[MPTCP_ATTR_RESET_REASON])
> >>  		printf(" reset_reason=%u", rta_getattr_u32(tb[MPTCP_ATTR_RESET_REASON]));
> >>  	if (tb[MPTCP_ATTR_RESET_FLAGS])  
> > 
> > 
> > The whole monitor message output format here is divergent from what other
> > iproute2 commands do. If you look at ip monitor there are no '=' signs
> > in the output.  
> 
> Indeed, the output is different from 'ip monitor' (but similar to 'ip
> ioam monitor').

IMHO ioam monitor is outlier as well. Should have seen that during review.

> 
> > Please fix the whole function.  
> 
> Doing that would likely break scripts parsing 'ip mptcp monitor' output,
> are you sure we should still change this output format?

I doubt scripts are parsing this weird format. That is one more reason for JSON
