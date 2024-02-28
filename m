Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C75853FBB5
	for <mptcp@lists.linux.dev>; Wed, 28 Feb 2024 17:50:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709142620; cv=none; b=YdLXtnau9XhPf3juvYQC/cXZqKmcZPFIIg1DbF/xSeofAzl34Rj5jodZwgsDGOpRNK7AzO91VDHwf2Y7BATEdVqxTv20uEhBfNZNtkPK2GJra5VaZnCjqPeiIMIt0j7fUq6GB9jzH+GZH52TW/VeCArm5IyMce5zHQt9VvsfJQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709142620; c=relaxed/simple;
	bh=2JQM3Fm18J1rcCTm1/wQSCe/Q54s/5na9KipditUbyY=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=Qfrfb0acjkJsjCUYpbBcQFa7UKgsQigZs8AYtAa6t8AwZ1ig7WxPgKYlQqi6Gwbnjy7LBQeijdDHsnCt59ZUp0Hjqcpo7cIVVroUK/EvdN7O+RSPGwNkX7RPA+9YmXpQCTtm5QLDNcu06TgwqzivOHmiEsmTisIqyStcHgmgqoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Kjh7Z03V; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Kjh7Z03V"
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-787bb013422so1930285a.0
        for <mptcp@lists.linux.dev>; Wed, 28 Feb 2024 09:50:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709142618; x=1709747418; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Zcio3HA3Ui1LRFWSrJs7QhIJrz1R9vaorVINMR5pIL8=;
        b=Kjh7Z03V7bFKCT3Ousx56l7BYHwD3eIHZPOp3kf09BrhH4i9jbHMiXLZekw2vQza82
         oeQIZGV2scfL2comgQDpV3yKMAaL4NIqH429SOIHQta3A4ptUrHOExhbtfxyXS8BXiHy
         FzmZ4GsgpKZKWJhT6InQh5xjyovGtHbcudQPPRkPCA5I4WwebkXfam2WGl/qkuhXz400
         W7CtEQliwpDeTIqWFTee10dJtyi/6lstHF5zJ/OOHdhr87wsAYtgV2ns0hSrP9tn5glY
         eCwEXyJFKhu/shIHin3bMyLHU2yiCpiS48B6fZ8/ww41/3B7TkKdlTR9XYu2h/VbFeaj
         li9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709142618; x=1709747418;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Zcio3HA3Ui1LRFWSrJs7QhIJrz1R9vaorVINMR5pIL8=;
        b=o5ohY7edrH0c9CEptjbPBKrqKGM2asfgV+8Vxl7C4lwTcTo694SiF+p1S7AlokBYut
         Bm0AOh0wa+6m6r+EpdSZlKP4jNZpsb7in9qDlC638ZKTFiW3EI+CtQQeQjKyhZNVTVRx
         FH9nbwU2ApztTPioFUJO0lmyCyx4EM90R2qkm0PfbJ5qLA6+L54vtlWMIPdmrGYZoD6q
         ltZ21fOuRR4Lpsy9lHr5xeF91fYLgrMAb3eGAGlFyi3gxYPo864vDc/RbpCsllcuzEGf
         0T38xZTJygfKdONSIY5gyoyIFStU3Yr7s05ctq0pdN1C+6yKnxbqIhqE0nmbi9fDbObX
         MDPw==
X-Gm-Message-State: AOJu0YyU2T26Bht9PxADhbvb0L/FJ4e6eVLRIYtorlBbyGiF6rOXGcwm
	XcjFhGb2+A8AP/u2gAUXnKpM8imwAVEJPAses+k4f3Hpmt/WNsY=
X-Google-Smtp-Source: AGHT+IFJ0HupP1ToLCd3PYXa9Iw2Yg68O5Uj2VO4BBh3WXfuR9bzNH4MPDAA9E0hXNtjm9ANX75Jlw==
X-Received: by 2002:a0c:cd0f:0:b0:68f:2b21:a44d with SMTP id b15-20020a0ccd0f000000b0068f2b21a44dmr4868139qvm.33.1709142617685;
        Wed, 28 Feb 2024 09:50:17 -0800 (PST)
Received: from [127.0.0.1] ([172.183.82.156])
        by smtp.gmail.com with ESMTPSA id mx2-20020a0562142e0200b0068f2d2f64d1sm6980qvb.32.2024.02.28.09.50.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Feb 2024 09:50:17 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20240228172121.243458-2-matttbe@kernel.org>
References: <20240228172121.243458-2-matttbe@kernel.org>
Subject: Re: mptcp: continue marking the first subflow as UNCONNECTED:
 Build Failure
Message-ID: <93ca7844-0319-c904-2452-1b832f2838b2@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Wed, 28 Feb 2024 17:50:16 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Matthieu,

Thank you for your modifications, that's great!

But sadly, our CI spotted some issues with it when trying to build it.

You can find more details there:

  https://patchwork.kernel.=
org/project/mptcp/patch/20240228172121.243458-2-matttbe@kernel.org/
  https://github.com/multipath-tcp/mptcp_net-next/actions/runs/8084822552

Status: cancelled
Initiator: MPTCPimporter
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/2c89af223cba

Feel free to reply to this email if you cannot access logs, if you need
some support to fix the error, if this doesn't seem to be caused by your
modifications or if the error is a false positive one.

Cheers,
MPTCP GH Action bot
Bot operated by Matthieu Baerts (NGI0 =
Core)
