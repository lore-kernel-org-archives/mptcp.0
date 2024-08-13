Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32642368
	for <mptcp@lists.linux.dev>; Tue, 13 Aug 2024 15:23:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723562586; cv=none; b=ngWP/isfu91WJoQxKcF8Nl0SuMzqQgHS+Cwp24lFtvVpUciw6uY0mVi420bhquH+NPAMhyStWXXR0kPzA+Xw/PCWQdbGj1qVncyopcu1Pzq1YMVYEQJdKoG4A40jzTE7f8nhzbxGGmjATxWIjN5vGIuqcCHH0glvUzmgipz9E/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723562586; c=relaxed/simple;
	bh=34D4m7poAsdwKsB+btWylw+uQgGNyf3PKPJhiqVpsHM=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=RVa8Tf+p1yVth02XtRXCZ0oej7+NG87ZKKhNtDH0fuEGdy35IsJqjE0ZJPCyLCX6CshF/CwDBsRlKpPkChoICtJrvYGoAOl3SWwLT0J/h839w83aACvpKe2eRqPQN8gnSPkTsrfx5HR/cZSPbnJggSrCASbsSStnMKOpzu5NlII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kIp5ZF0a; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kIp5ZF0a"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1fc587361b6so45961905ad.2
        for <mptcp@lists.linux.dev>; Tue, 13 Aug 2024 08:23:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723562584; x=1724167384; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nZYicelUWdUmyaMihzamPKNyQaqpABStp5O8xINhNfk=;
        b=kIp5ZF0aWBf1/UZgxvXC/gfncQbqs4bl453kTWyriWBMhdGbq7dK9/RiXom0t64lIU
         Jqai8WYdQyU0fC/klJPOc7pL7H93+LP2fDcGW1KtYSqfBhL7s5CNzsIcP0sQwC336xMf
         bIfF+qOespE2vtnjwSxxJqDD5IRbDzFzqyZPCey24J++wP2QtT5SmmammN1LkmZlL9n4
         T3TedrguFW+RupnCep/srARz/16PH8pIlesm0Qm8XjLc3S+5VjI22loPzyyjHoEtXFVL
         5v76Syf/+q4qyuieyADT3glL5rPPUio7IGjGLo7P23tT9dRGyQLmQlfetY6Pn7g/sCE0
         TwsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723562584; x=1724167384;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=nZYicelUWdUmyaMihzamPKNyQaqpABStp5O8xINhNfk=;
        b=ubVd27TParqA50P9p82akglpD51bHQhbHto9xWjvx+f+45cP4QYvjpy2HwGYLzBRpm
         1Rrn8P5vAdOQ0ER/nVAXIeWFzbM3MArs3hNXb1YRYbHsUChEr+GJJOIK1u98rjRu2yfj
         pyVMdJryiZ7sy5QNHLF/riG75eMWYMXb+dRpeHHjKc6/NOPRTzdXxe8osWuoR321pf3S
         3OpQKq73hrnSownbTPFkjm4uZNsOEpEqNrIJb+l0QqFUhM7Dkrw957yoKRDreUlqptdy
         8CqxZHYnz7QvtvvAxTMeNNq0znRhBe3gTEaBqcxJnDOor2zoPD523eeKDlPyJT5r4w0+
         eu8g==
X-Gm-Message-State: AOJu0Yx++6w0ILIjvZMlR2VFkDqi4O2ijONUEvvl8G3teqaX1tJ9UKcE
	r7Uvn0U4m+vepzZH8IetaeMbIvUG9J2Oxm3ID9J/3UIivKIlx88=
X-Google-Smtp-Source: AGHT+IH/2XOk8cWpB4EhbjJNzle/PJPoX6/SfucWi2wfJ1B2Ef4KD33jJ+fSvLKL5+WJqwGJ5PwLpA==
X-Received: by 2002:a17:903:22ce:b0:1fd:a412:5dff with SMTP id d9443c01a7336-201ca1b045bmr50133675ad.43.1723562584376;
        Tue, 13 Aug 2024 08:23:04 -0700 (PDT)
Received: from [127.0.0.1] ([20.172.25.73])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-201cd1c4556sm14754925ad.248.2024.08.13.08.23.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Aug 2024 08:23:03 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <20240813-mptcp-sched-retrans-bkp-v1-1-78914a88c2c6@kernel.org>
References: <20240813-mptcp-sched-retrans-bkp-v1-1-78914a88c2c6@kernel.org>
Subject: Re: [PATCH mptcp-net] mptcp: sched: check both backup in retrans
Message-ID: <6a73eefd-566a-cbae-831f-e24b865cfa1c@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Tue, 13 Aug 2024 15:23:02 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Matthieu,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal: Critical: Global Timeout =E2=9D=8C
- KVM Validation: debug: Success! =E2=9C=85
- KVM Validation: btf (only =
bpftest_all): Success! =E2=9C=85
- Task: https://github.=
com/multipath-tcp/mptcp_net-next/actions/runs/10369004703

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/6ac41d97714a
Patchwork: https://patchwork.kernel.=
org/project/mptcp/list/?series=3D879179


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
