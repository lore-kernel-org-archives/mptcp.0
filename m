Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7973B4E1DE
	for <mptcp@lists.linux.dev>; Sat,  3 Feb 2024 08:45:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706949945; cv=none; b=e2yJiR6qPRUMkvZ9nmeE0tOa8uHavI5HitRkhiuhEAwlWX0o5owNXKsPG/7G+yxgYn+glBXSYGRkjnRx2/TafwkMhzicNskrs53COYxnZN439J5gVCkG9ocwivbOOSRB9pjlNqiSlvqkFMdqidqDzireNfxWZlgZoJ/ScfRrBBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706949945; c=relaxed/simple;
	bh=W6HdXJ0+DTQOTyOHEC70ak6zcqlldRLD3+jIcln6j8k=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=FDBByG0fW+kTyRl0hHebwO0e4LayDmHzVSCn98b0rqRXa6JW6Tgx6BwjjjMIBb/XCB6ch8prczVIgT7jtxnAOBeR3JqaBxlY+3lGWzL3VZOiyYWb2wUeS3JftjDEWDOTH/ja9wjrO6NDcF/i3AVqIrnD9fOo0fLJeacB4sd34T8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Hc4ZSeMc; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hc4ZSeMc"
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-783da8920e5so184206085a.1
        for <mptcp@lists.linux.dev>; Sat, 03 Feb 2024 00:45:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706949942; x=1707554742; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lNgI3cm/4zxDm3qBcr6TdmQFFqtDQKD8YfuZ5dfXMj4=;
        b=Hc4ZSeMceuA4Q0sgbwfS5CAYYcHolQtrSGp7H3jCJi7huG+y44X4ECCAwn4Nu5hdS8
         j3A6kWQRftqfInuHincCvx10cuPdjfiXP+fIm7KHwb3EtMAcF6UdbLpSacI7Zn8jJM98
         mQJZwqa5LifpUXMw0Ajy1s/zS4x463JjZz1RbwTwhKpWiu2nZzFOFze1R8wRoLHqpOqo
         Ku0RT35rZStBWS/xotO5ndXCqcdpCPo+UaxZuaBVGkfjstzF2l3UTFgJQ5DogGT37XVt
         QFlpXecgRmS0M04FHwHlROMjCeWm+jfKhiCP3grSjBYKP1uH1XArnZnmW6ZERy0s1qfl
         6l0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706949942; x=1707554742;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=lNgI3cm/4zxDm3qBcr6TdmQFFqtDQKD8YfuZ5dfXMj4=;
        b=JmIoJuIdyD0mGXGAx90TFkoKX86/o+AcksE5tFvzEukEP3ISlRa1BEzHLcOJeJX5xN
         +bMsnv69z+lX8xj5IDJVofhDtwhnVof0StlB6uD5d74/SCBcf8AeszNid+8uvAQCHnkj
         94JLkAlkblR8B3kZLWMEIaIEztfbfxlRIhYxsP9Om1Uwyiu4tj0RHEtZQrlzBQ9HyF91
         GPChCFU833Ctj5oKjaNgPJNfkWdIXQUn2RC6q7/UCm+6n/Z6nToahIoxza3R+bc/id+3
         NBYqxmaxpp5VhGRa8djuL+vRP9LxP3V4NZlZNJIfYGNUN1bGT/qwxsON93UB1OnT2rcn
         99fw==
X-Gm-Message-State: AOJu0YxgLTkrSoDUqV6MHYXANZP6W6ti0SL4ftn0kgZwxse/7srqxuJj
	/DF8qgSrJ3RK15E5kB+5z3Gk6smf6lPrMIfQcR45afMPclFv+w62xe4Hfbc=
X-Google-Smtp-Source: AGHT+IH9U/+r+O85kb54kxtzDuc0YHY/x0+jE9umke8W2xgXY+YNA9mzepCZPHZjXYU8zZX2ZO8/dA==
X-Received: by 2002:ae9:e203:0:b0:785:45c7:db3a with SMTP id c3-20020ae9e203000000b0078545c7db3amr4821791qkc.20.1706949942118;
        Sat, 03 Feb 2024 00:45:42 -0800 (PST)
Received: from [127.0.0.1] ([172.183.39.72])
        by smtp.gmail.com with ESMTPSA id l20-20020a05620a28d400b00783e3b030e7sm1332534qkp.33.2024.02.03.00.45.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Feb 2024 00:45:41 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <tanggeliang@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <e86da7508219125aed45d869cc02161acee418aa.1706946547.git.tanggeliang@kylinos.cn>
References:
 <e86da7508219125aed45d869cc02161acee418aa.1706946547.git.tanggeliang@kylinos.cn>
Subject: Re: bpf, btf: Check btf for register_bpf_struct_ops: Tests Results
Message-ID: <737c570e-9e41-db23-4875-42a870a0fe9f@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Sat, 03 Feb 2024 08:45:41 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Geliang,

Thank you for your modifications, that's great!

Our CI (GitHub Action) did some validations and here is its report:

- KVM Validation: normal:
  - Unstable: 1 failed test(s): =
packetdrill_regressions =F0=9F=94=B4:
  - Task: https://github.=
com/multipath-tcp/mptcp_net-next/actions/runs/7765613105

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/ab6eec4814bc


If there are some issues, you can reproduce=
 them using the same environment as
the one used by the CI thanks to a =
docker image, e.g.:

    $ cd [kernel source code]
    $ docker run -v =
"${PWD}:${PWD}:rw" -w "${PWD}" --privileged --rm -it \
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
