Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CDA638F65D
	for <mptcp@lists.linux.dev>; Mon,  1 Jun 2026 10:09:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780308580; cv=none; b=jq9wcDmW7YnMjkCpOw/86xT+a3oolT+KvePh0IfY4Age0sQxypdhCHCXouWKvQeJ3YSfsZ57uyO3M21IfyYfYBEo+FqnFuzkQJX8VN0YU2Jb5yzqKrT3FV85JIcSdZdFPb5HQa2OCSoixE3XK/BnFaP69WNRbvZSIynwHedyqXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780308580; c=relaxed/simple;
	bh=7SdKU5ROn7xKK1UBcWSeOBVS+X7FE1tefhrztJoATK8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-ID:Date:
	 MIME-Version:Content-Type; b=WcOe6YdBmTcXJX4T020iTvO0xvFJBu2xwXli5heZcq7p3BrmxZ7+suJt6q/P8EtHIiKaYNIESIJo1NdZGhnt/KFpRPuNM+lsHezciWSRScmwBafPoRDHIV2wkS2yBIbGdtdinfEBB82g2ewgNn+XeOQgkfu1zUihsC3y1jKudyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kUrW0gFA; arc=none smtp.client-ip=209.85.219.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kUrW0gFA"
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-8ccf887de87so21252036d6.0
        for <mptcp@lists.linux.dev>; Mon, 01 Jun 2026 03:09:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780308569; x=1780913369; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OawBOOggdW2l8UFP07VRzJ5cPvocLLdVIZL0HbjPYTU=;
        b=kUrW0gFASNAlfzHmuDMNP9fnMCTSlxEewxMsgMJE92lR59Ms2nrOBGo29Kz9KBfD+9
         u/z7Zv40DpN7mml6RXQj3l3AnNUU36GFs9ZPXWeclqWx778MI3+2yKzaHF5Z5xUprGZG
         8OAlGivX1a6+I7BrPe5gLlWAmNOJgBfdSCDZETS1bzoWSmldtItCTGDZAohWa0SoN7as
         O0d4nvKI/a3WXu+kqj6nNZjwNEfdCnkeu7evcWLwuq21D5c9awy9mMlvwvivd2/DoRcr
         fhZ4XLMluZvq0fS/g55MMlFc9KpJgMdkWslcHt32QwZzKkfLlCZ7B1pWk5v5KxmDL0g1
         HU2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780308569; x=1780913369;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OawBOOggdW2l8UFP07VRzJ5cPvocLLdVIZL0HbjPYTU=;
        b=N4Ks7njC9/WZEJQ3NvzTUZ6sRHwFZZxIQc0bHlm683cfF2OA44Ro67CLlmwus/aPhk
         6gRas36uI9si99kfRQYhlw+O0/pCsyz10IaE2ZTYLqzaSjCFJjXsM2sbmceJKMv17bma
         8tkkmsZGcFKdMHJDqcURRSRz+3IBm4gs1b3ftg/X6dqdPfUGR56OjRU7sLSFTJnTS/cI
         3Aa+caziTzBVwmtfwUPAvKJMjmwg5l7lOKyl2odKkaF8qAaJx8exletvZYN0Iwje4VCC
         9mlxhtXiZpKVd0+DMuGOx44UTeDDSNl0B+UVuscw+u92KrBNBb5uu7/uBWJKA7ndx5jl
         9mew==
X-Gm-Message-State: AOJu0YwaU8fGhPb0oSxAxun5dnJLYhaFyuZvlj4o2UoGpYfphkPOngje
	oEUlj1PV0zZTTLPwj6y65oVQFpY1CxNou3ThTQVldp8PeuHxJfPJj9A=
X-Gm-Gg: Acq92OFD69Laa/Kr4xNeHwB/yoqXtniQ0RC3vOSpgnLLi+aGV1nWKTf+V7osponrwhZ
	0whifzrCxT7meSrewZu96gCCk8pHCpbsRyM2UuKCC7acBfwcSMf+i+Ro+tesDYU+V1+pWXvIqvm
	iET0Xwpoaj8BFq93dyGtIa1rFy7AlGtjwrwpVPkBOeIV2/x+xEHzZEWUKWD4c1iaTmBgAYqQ/kT
	vTfj7FSMcUs9XWgu7oxgrmBtKwa+F3T3D+CgXWBT4msptm1OFXm3QMStBp2VpEriR3ULY3dQMR1
	PEyrPp4dwGzl60qm5R7RziIqyI/SZiiNZ1JkHU6it24EaDY+lEXOM9od6To/2DE6ENo3ugiwPUc
	3MuM+gmTfuHU9EzXiP/LgwLleGTCLcbaJeZw08afO1bjKn1RbCRFrNK/GzO7Rvtvqkc7baXpC1J
	7OQpkxWSkF0Wm9sLEde1KilEyIi4E2lj2yI99CUouyjgLe/S5+
X-Received: by 2002:a05:6214:410b:b0:8ce:aafb:451f with SMTP id 6a1803df08f44-8ceaafb45bfmr67831446d6.38.1780308569225;
        Mon, 01 Jun 2026 03:09:29 -0700 (PDT)
Received: from [127.0.0.1] ([20.102.103.120])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8ccea0635b1sm90234046d6.11.2026.06.01.03.09.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jun 2026 03:09:28 -0700 (PDT)
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Eric Dumazet <edumazet@google.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <7a377984-5a2e-4981-96dc-c76076f93f4a@kernel.org>
References: <7a377984-5a2e-4981-96dc-c76076f93f4a@kernel.org>
Subject: Re: [PATCH net-next] mptcp: change mptcp_established_options() to
 return opt_size
Message-ID: <bf94b7b8-6ecd-db14-c814-d74a6de5c3ad@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Mon, 01 Jun 2026 10:09:28 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8

Hi Eric,

Thank you for your modifications, that's great!

But sadly, our CI spotted some issues with it when trying to build it.

You can find more details there:

  https://github.com/multipath-tcp/mptcp_=
net-next/actions/runs/26748250142

Status: failure
Initiator: Matthieu =
Baerts (NGI0)
Commits: https://github.com/multipath-tcp/mptcp_net-next/comm=
its/4514016d2e89
Patchwork: https://patchwork.kernel.=
org/project/mptcp/list/?series=3D1103913

Feel free to reply to this email =
if you cannot access logs, if you need
some support to fix the error, if =
this doesn't seem to be caused by your
modifications or if the error is a =
false positive one.

Cheers,
MPTCP GH Action bot
Bot operated by Matthieu =
Baerts (NGI0 Core)
