Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B062E287277
	for <mptcp@lists.linux.dev>; Tue, 29 Jul 2025 10:24:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753784693; cv=none; b=mRu06JgSocShAEyduDzITN0OYAX1xGqpY+UQ5hSeVko5fIkvm89lBkvAaSL5HniHDxWYm6kjQo0H1xIXFQbXsdJIwgIEqJasdjxluCYaGOhZP24D/CC9ihNNW4c4ZeDqte6cUQVIgwarcbcmZ0JocaztyfJbdOTuAt1uDmbJLUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753784693; c=relaxed/simple;
	bh=99lfJhLDGHRm2mq/HNYIzTgUvNaPwYaPpf7V+MejLxA=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=c+WooKc5RK4RWy1HcbfVwld1SL5Pfy3WoxwnedegYJBgZkrFpS3XokFaTl152nfgQGEH4H+Gw66LrfM03EIWbQ6SXuMDe9G/kROuZmgPCotENVc3CugsTSo4UdGtz+1l0c8D3l+FA5wGMFOoxO5IcGMs7FDfCLbdCZqwNjJBbFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WS9d29Fv; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WS9d29Fv"
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-7dfd667e539so575380885a.2
        for <mptcp@lists.linux.dev>; Tue, 29 Jul 2025 03:24:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753784690; x=1754389490; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s3Me0CIAmeq93kyb5+5DzV6PqResCSof9KegYhIQi5c=;
        b=WS9d29FvaconqqjpS2NJAPPkFKmePQXq5KgB+dKcXdHP76E9h/yvxKSiZou5vWcSGf
         eiuU1sl/GCNL1cHF2szGOGFjE7TLn71eravHMRLJxpcovUs+Wt7CrFxsATGrZEg0iQfF
         u4eUrqhuOlXrKpz1F5GmJ5LDV2rFFDw3GagUZdHw0nZPDS8fsqXKXWT9W/FkKJFXlnUr
         ZTETt8JvxWnDvhWUu2pMoU91hl/pVH8x36dfpvnoUQPIdYYB2SOw6stwZRvnDOJwIs2l
         /3XJRWfcUjW49KcGMHJ7fxGnc9x7nhJ7/2H8XZW8PPguIpv6oRLRzQMzASBjmVlOw/wA
         RWTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753784690; x=1754389490;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=s3Me0CIAmeq93kyb5+5DzV6PqResCSof9KegYhIQi5c=;
        b=evACe1nzFgMNxHNEL5gxTHs9yS1JMK276m73Cqar4MO/ND87ka+WSq02xDCuiCRusa
         5nXQkAWPbHIr+c3H6oxL4ZqVaYb3KkNMq4N8SFL+/UsJH0dC4eP7lY8fzgH13dN5TRAZ
         Ht08Yv4S7oN1QpWhMXIRejY1ynoRRMdbss/dpzXELmYSHcbZtp2srlrq7Fr2DnRO2f/v
         GswEzI7Arhl/kDTgm+pmrDWDpkzO1DrMnvtgFZ23IlbWH8hVZDExVjIRVkKKXk/ziZLj
         ObExqgpF3625mJzWbEVpPdQLXXj+sDTtCbp5bthsiXqQ53wW9UiJLQEiO7cCYHI4L66e
         0Uew==
X-Gm-Message-State: AOJu0Yy8wT+OkMmJmpgVOaKiwo69FLIRBOhl31PL9RHATwyCpGJJun5+
	yCKFMWaTky2cZiH7Jtd0MPkkQAw2ghTJ/jVctHC9bexDZegADvvBp/OZei5THFU=
X-Gm-Gg: ASbGncv6ObkD1jrxPa8p5+iCG/eDkoRArd+2ZaMysbeXllf4NQV59j2jBp0lS7E0ngd
	0x5Xk1z7WLMqVL7HaOYs670L/m37hZKygJdwdR78A/JASGfDvoHUEW6SRv5BsI84vbo96PwPhFj
	YzNC+e8PRo3nK/WhWUhoPj5xs0HoNi0CuF/fjuU8mXaqdXCV+zHNGps3haOwsrADqDLqmrgLX/W
	g6ZxpP2EwlhUixYV7AY9U0dDndtv3h2EaTuA1urq9AZnypLpJXWuTQrrI5RZLboQbDwOiGlbl4M
	ZRY705Ucn4ahCnvv3khK9xovDaY69EmOyv6kOnCXS9Qi01Z3hCjm9l4YDXRa+DQY4LXTMb3mSxp
	C9vBxGjOAx94bj3I7n9c/yZjCxf6+BVYdriiC
X-Google-Smtp-Source: AGHT+IFEbAGYfFWjG5EKwI4+2ekMpYezpUZeu9ExIvx6PNFVLGlgRIudH7xFzsnVo0ek3YHpLDiVQg==
X-Received: by 2002:a05:620a:720b:b0:7d3:90ab:814a with SMTP id af79cd13be357-7e63bf60f26mr1652321985a.24.1753784690539;
        Tue, 29 Jul 2025 03:24:50 -0700 (PDT)
Received: from [127.0.0.1] ([68.154.119.209])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7e6432939cesm403468485a.22.2025.07.29.03.24.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Jul 2025 03:24:49 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <tanggeliang@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <cover.1753777199.git.tanggeliang@kylinos.cn>
References: <cover.1753777199.git.tanggeliang@kylinos.cn>
Subject: Re: [PATCH mptcp-next 0/3] mptcp: improve ADD_ADDR timeout
 handling
Message-ID: <bf590aa7-5a40-8e88-6d16-a878b2becb4e@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Tue, 29 Jul 2025 10:24:49 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Geliang,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal: Unstable: 2 failed test(s): packetdrill_add_addr =
selftest_mptcp_connect =F0=9F=94=B4
- KVM Validation: debug: Unstable: 3 =
failed test(s): packetdrill_add_addr packetdrill_sockopts =
selftest_mptcp_connect_checksum =F0=9F=94=B4
- KVM Validation: btf-normal =
(only bpftest_all): Success! =E2=9C=85
- KVM Validation: btf-debug (only =
bpftest_all): Success! =E2=9C=85
- Task: https://github.=
com/multipath-tcp/mptcp_net-next/actions/runs/16591166379

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/4e382e2fda74
Patchwork: https://patchwork.kernel.=
org/project/mptcp/list/?series=3D986638


If there are some issues, you can=
 reproduce them using the same environment as
the one used by the CI thanks=
 to a docker image, e.g.:

    $ cd [kernel source code]
    $ docker run -v "${PWD}:${PWD}:rw" -w "${PWD}" --privileged --rm -it \
        --pull always mptcp/mptcp-upstream-virtme-docker:latest \
        auto-normal

For more details:

    https://github.=
com/multipath-tcp/mptcp-upstream-virtme-docker


Please note that despite =
all the efforts that have been already done to have a
stable tests suite when executed on a public CI like here, it is possible =
some
reported issues are not due to your modifications. Still, do not =
hesitate to
help us improve that ;-)

Cheers,
MPTCP GH Action bot
Bot operated by Matthieu Baerts (NGI0 Core)
