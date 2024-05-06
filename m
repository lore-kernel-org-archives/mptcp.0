Received: from mail-oa1-f45.google.com (mail-oa1-f45.google.com [209.85.160.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8171A13C69F;
	Mon,  6 May 2024 19:23:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715023428; cv=none; b=rT4OpAiZJZ/0HsMOBAj/w+JrGqQv0cLdOkQVwZDNOes9tmz8w0SUpk6QYZBJPmfT0h1QFQWCfUTF3ShLml/LYKNf2IeXLyJLArJe3SMvnOaO06VXLJYIRztOIkv7PseI3SRY10PvuyUi85K07fYhTyJn0TopsHm5dpzw/XWaEfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715023428; c=relaxed/simple;
	bh=VjKGuE2C0thOxnAgsCwVrGWxtDbyC3SnKsv1KFItiOk=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=bauFyQlaLraV6Z81ZrpUStqYOfrSCTmxAKQbNojHXR4/EXsnMHQzmnimlYxtOCxaowbR/Glr0c4MCtnvqbpJWCyuf4Sa6kUWnIPyhJ/F4nnBM0rFv7C31pwvldmRbFk7qGZdqdckOObaTlX5SkGGJiRIQ7lHchuANAHsm05UtvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dNFlwJYk; arc=none smtp.client-ip=209.85.160.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dNFlwJYk"
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-23d1c4c14ceso1594143fac.0;
        Mon, 06 May 2024 12:23:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715023426; x=1715628226; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HMEDQp7jecrc8iXiBOXlaMlkv7t0FOpm2f19JeLxtsA=;
        b=dNFlwJYk2bgeXwaqpEAURmRoP/39i+EmVcZA5+aArDLZdmh08Z3xRwmf41YTgvu73S
         wNjynVMhjCIVumjEAGFKxQUfeK9iWHAA+f/e2P9liVG9FLU3obEsY4OzBOq64SLgPKge
         jZEt/VFgwhfbFg9naUg3ivg2tN+xBpDaPC/yELc0sdpXe8KPW/b7OHkFMvWsFHSmay12
         a20Bu0GxSAOwBktgrNmNFQ9CWTrUNTLtwGfUC6qBoK/aZPZ06jr6pJz6YJHVDxBqCvCy
         0fkyEGhUDJR+qWPMdjIxlbBJiRXqOj6UheoiGlVCC7S8ZzQuasga1TkJEwgfmTjUD916
         P30w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715023426; x=1715628226;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=HMEDQp7jecrc8iXiBOXlaMlkv7t0FOpm2f19JeLxtsA=;
        b=BbmI+GvtGAwSAGi8ejtSgHmXPrwP1HCBDZqBtl5QXefe5AxLAhjJBLHNxpijQsZT+u
         jcoi9JrFGD+/tdD6LOftTTBzC8RSi2JTXC+xKKlq0zq9+TktLfEr5F89EY3ub4skIdFO
         Wh0lbbqDpFE0tI5/8/ZKibfz8qzleffyvln4gS0Ci1nvCBguU1nLGwVaKc75jor6+r1O
         0UbFSz2T1RUKBmjWsFwXyZvpWa1G+Qlxns6OLgThtZRv1AwUvTJDPtPmt4mKNLngR/I8
         IeMz1KG9DWeLQ/8H2IQDUb3XhFG32VjmNh8cLQpibe1PpQmIAffFNb8ANhxTUapb6HRG
         m2Rg==
X-Forwarded-Encrypted: i=1; AJvYcCXUT4Fwzy89QNPKWleOtucbXgNslJM9RbEQeLBrz5kgItq9HIdQPr07t6w+q2N4hiXAHQ0KhxW5hQGs3QWuvZ3+UZwNWvWAzh0xNxOQVlo0tfMG39dcdtc8za3+
X-Gm-Message-State: AOJu0Yyf3UzO8IIMj4eIITqMuQ0+3okQ0ZMTqFJScedKZHC/ErPQEgiv
	m0HNlh/98IU0xD/CvuUwczPEjhUYb0QqXeA6JbdvB/sGPejBLbuV
X-Google-Smtp-Source: AGHT+IHf/3INeYWfNXb4/rpQGjmxAqtkFZ5EKMg8ufpMcJVGnz6iF9K1N+nuOnOSpdZrqR2k0xN2tg==
X-Received: by 2002:a05:6870:8898:b0:22e:b96a:375 with SMTP id m24-20020a056870889800b0022eb96a0375mr13017922oam.30.1715023426523;
        Mon, 06 May 2024 12:23:46 -0700 (PDT)
Received: from localhost (164.146.150.34.bc.googleusercontent.com. [34.150.146.164])
        by smtp.gmail.com with ESMTPSA id m24-20020ae9e718000000b0078d5e60b52esm4137182qka.114.2024.05.06.12.23.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 May 2024 12:23:46 -0700 (PDT)
Date: Mon, 06 May 2024 15:23:45 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: John Hubbard <jhubbard@nvidia.com>, 
 Shuah Khan <shuah@kernel.org>
Cc: "David S . Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, 
 Steffen Klassert <steffen.klassert@secunet.com>, 
 Herbert Xu <herbert@gondor.apana.org.au>, 
 =?UTF-8?B?QW5kcmVhcyBGw6RyYmVy?= <afaerber@suse.de>, 
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
 Matthieu Baerts <matttbe@kernel.org>, 
 Mat Martineau <martineau@kernel.org>, 
 Geliang Tang <geliang@kernel.org>, 
 Pravin B Shelar <pshelar@ovn.org>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 Alexander Mikhalitsyn <alexander@mihalicyn.com>, 
 zhujun2 <zhujun2@cmss.chinamobile.com>, 
 Petr Machata <petrm@nvidia.com>, 
 Ido Schimmel <idosch@nvidia.com>, 
 Hangbin Liu <liuhangbin@gmail.com>, 
 Nikolay Aleksandrov <razor@blackwall.org>, 
 Benjamin Poirier <bpoirier@nvidia.com>, 
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
 Dmitry Safonov <0x7f454c46@gmail.com>, 
 netdev@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, 
 linux-actions@lists.infradead.org, 
 mptcp@lists.linux.dev, 
 dev@openvswitch.org, 
 Valentin Obst <kernel@valentinobst.de>, 
 linux-kselftest@vger.kernel.org, 
 LKML <linux-kernel@vger.kernel.org>, 
 llvm@lists.linux.dev, 
 John Hubbard <jhubbard@nvidia.com>
Message-ID: <66392e41e6889_55f25294dc@willemb.c.googlers.com.notmuch>
In-Reply-To: <20240506190204.28497-1-jhubbard@nvidia.com>
References: <20240506190204.28497-1-jhubbard@nvidia.com>
Subject: Re: [PATCH v2] selftests/net: fix uninitialized variables
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

John Hubbard wrote:
> When building with clang, via:
> 
>     make LLVM=1 -C tools/testing/selftest
> 
> ...clang warns about three variables that are not initialized in all
> cases:
> 
> 1) The opt_ipproto_off variable is used uninitialized if "testname" is
> not "ip". Willem de Bruijn pointed out that this is an actual bug, and
> suggested the fix that I'm using here (thanks!).
> 
> 2) The addr_len is used uninitialized, but only in the assert case,
>    which bails out, so this is harmless.
> 
> 3) The family variable in add_listener() is only used uninitialized in
>    the error case (neither IPv4 nor IPv6 is specified), so it's also
>    harmless.
> 
> Fix by initializing each variable.
> 
> Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
> Signed-off-by: John Hubbard <jhubbard@nvidia.com>

Reviewed-by: Willem de Bruijn <willemb@google.com>

Thanks!
