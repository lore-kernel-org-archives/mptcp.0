Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0F5112B60
	for <mptcp@lists.linux.dev>; Tue, 19 Dec 2023 08:41:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CpJrLmxa"
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-6cea0fd9b53so2087652b3a.1
        for <mptcp@lists.linux.dev>; Tue, 19 Dec 2023 00:41:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702975293; x=1703580093; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KvC643+BRVHv3PUOhUqOi4lPnfKXw3gSiReMya3+FAc=;
        b=CpJrLmxaeer1upJRaagt6a8z3zcgaVcYhQm74hmADIlnOH402cofVtl0qelxFXwC2v
         eL/7fSeg0tLphp1CfgMzg+UQ+gmz7jOm6OvcZCuBukJcECO+IwkKNl/6i7+yAEUEvt2u
         DkNErg8ow/MFnOOMkfZfEpPVGK01KHl/Mh8hX8AXi15if2Lhl58P+Q3OFmFXrrZtZyV2
         0geDH3KEsjolzed56pTumwmno2KSHByDbFtTgi3wW/0fPGmAmaY3xn5qR2UQQn+0HMGo
         XTydkmw3AngTdlbAPRuAsya8D8xy3HmNrSIpUOjJCeguh9x4mvCm8lthSHAvkIykqXmb
         teJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702975293; x=1703580093;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=KvC643+BRVHv3PUOhUqOi4lPnfKXw3gSiReMya3+FAc=;
        b=OotCX7Zx4/czEZycof9X83tJ4wP+qqeySd2NcoM3zLet+0cFuygtY4uQO9RqxKCy9f
         UCW93lAtaNZz3Dh7tSOZlNEqL/oDw6Z/UcZH0aXUCMzU6i7XblidfnoPhT94i71Qq9rs
         YMvB6q8Il8Mgu4YkHKGIME0U1M/jdyTwFyFea/CqO+9h+sF/H8fs6tTePgQ+Uy+VzDEg
         tTD06A/y5JDqmUgSX1p7h37mTWQIe8YLEsNNQqIAzXDjHmSANf7qU3j4/Ezni7jRl7vc
         tjaI/eeA3kpZaMZtgkAh0mSLEKg08RDx8BMiCEnI53RG/QRIO+aLOQXNMGpgCobAlyki
         5LGA==
X-Gm-Message-State: AOJu0YwmBmj18G+XRxj4y1V34uvT512cF8s25jjH/15q/8ontDR762+K
	8819qLmqk85yzZCmaHq6+2D952KsBA==
X-Google-Smtp-Source: AGHT+IFVVPBs8N26cnDzUJXjWm2PchSG+N5EF96WzOtvlB+0cIkzohfPQd8e4rikuR3eTZu4atgdNA==
X-Received: by 2002:a05:6a21:3398:b0:18f:1db6:bdf9 with SMTP id yy24-20020a056a21339800b0018f1db6bdf9mr9713471pzb.21.1702975293133;
        Tue, 19 Dec 2023 00:41:33 -0800 (PST)
Received: from [127.0.0.1] ([52.157.3.100])
        by smtp.gmail.com with ESMTPSA id i3-20020a17090a2ac300b0028b3539cd97sm1020173pjg.20.2023.12.19.00.41.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Dec 2023 00:41:32 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <geliang.tang@linux.dev>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <9a8034c76311d8871fb8d9e69aefc459b2e607ec.1702973751.git.geliang.tang@linux.dev>
References:
 <9a8034c76311d8871fb8d9e69aefc459b2e607ec.1702973751.git.geliang.tang@linux.dev>
Subject: Re: selftests: mptcp: userspace pm get addr tests: Build Failure
Message-ID: <a2b72c6a-1598-7057-da95-c35324f5cd01@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Tue, 19 Dec 2023 08:41:32 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Geliang,

Thank you for your modifications, that's great!

But sadly, our CI spotted some issues with it when trying to build it.

You can find more details there:

  https://patchwork.kernel.=
org/project/mptcp/patch/9a8034c76311d8871fb8d9e69aefc459b2e607ec.1702973751=
.git.geliang.tang@linux.dev/
  https://github.com/multipath-tcp/mptcp_net-n=
ext/actions/runs/7259311767

Status: failure
Initiator: MPTCPimporter
Commits: https://github.com/multipath-tcp/mptcp_net-next/commits/f1dcab0253=
90

Feel free to reply to this email if you cannot access logs, if you need
some support to fix the error, if this doesn't seem to be caused by your
modifications or if the error is a false positive one.

Cheers,
MPTCP GH Action bot
Bot operated by Matthieu Baerts (NGI0 =
Core)
