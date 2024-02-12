Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A2D245C14
	for <mptcp@lists.linux.dev>; Mon, 12 Feb 2024 19:52:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707767553; cv=none; b=Oi5CKMLxzD5M1RIm2wiuX942rLWKME29SwYVpdoZMz/Yk9kRDY8iSa+zdDEXLuNe5CIVe7s/aBbiBtxk/uALqKWvo/LtlkABW85QLJJvm85cOTf+gRvW9MV27Lwl47IjABop4hGdLX7H8ZBczMasbznj9gugjECD3sIeKHwcFrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707767553; c=relaxed/simple;
	bh=Rdorl+Le6E0/hkhYR9AvJUtralFyWWcF8CUVkLdygy0=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=inQkxl6jdTRZkcx9tKG0NuypODZvWGp8CKwnAZxjVco8puRTa86+ps5TFYNTLXXooSmMKZWI1CW5PKQ/WlmRBq14E0QhNQhZ+II5yjF8gfXGP7GdNl22DyU72tpCNL5RYXA8MyVYCY76l5vdJNnTniT1fPahuwP2PBF0r9H4NX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kPaaJbFj; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kPaaJbFj"
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-6e0f4e3bc59so304294b3a.0
        for <mptcp@lists.linux.dev>; Mon, 12 Feb 2024 11:52:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707767551; x=1708372351; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Phs5VnMP5mzkPT1WUDzzqGmnMCSQLOXH73cB3AzQxbU=;
        b=kPaaJbFj81YPq+fveDeLXicPQp514VrDqeMOwS4/oaCC64D+CkeO8/kl+zsv9XzNLb
         UC03Xy6208ylQOeFcoiyIiUizbxTT/TzujbZ2Bb99ZJQHsUowRMejTYNi682JDc0//Xt
         Qo5Y4M0zGF7LHLGjDVwUk+ou2obP/tJSxSHdAiZ1jAAmiYP9r6mNeyTW59p9pNXl0Bn4
         A2+XBavwUcamJMAikp1kVBrH0Jpx5Pc8PjjB46FxSzkPxp+BdWNT6ihqbhEUw/g6gyFl
         a8wLYRa1ki9VTVUeLP+BdimLRC2f3aE1fx+/UOTvcRJxysTjN0QQpjl964AMkQ2QJSn+
         EfAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707767551; x=1708372351;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Phs5VnMP5mzkPT1WUDzzqGmnMCSQLOXH73cB3AzQxbU=;
        b=cEyaxsuKTQCTYkCq0+WzRbt6Akx7/fBmDpFQNk2CCioCnJf7fdX3fEroN1CfIXjy94
         9Aa3QLPLQvWHkpk5rf5UeSehhGoSyHpVqiA5sBpe/MSOpmR6J5nS6nHHbOghitL8n6U3
         Qi4LJ3p7nruSJ4YDaeeSbEkyEpAjKwQKYKg1zFAGHGxFBVUmJEBPZ+Ytm1ZbhHRs9GSS
         Tl0bO8FMONz98JPVB7ar2XX2P8AnVJBuvC9EqcKzGvx122WFMvEuYsuE02vGRkoeTAEs
         Hbm9xOQq+lsaMYr1UgyGqg9c/p8ViQZsrrcTcujkYKX4zhbKzA8OwcJ3QPYu/5Xb3Xvq
         Hnzw==
X-Gm-Message-State: AOJu0YzqQWS7a/rHxxw4rFOv5JVzed/GXfKoS1CwZVvjuZ7PoTcLo9C7
	mzaYozMjo7GnLBm74MZuuHijojacXYzccKmrLT8Dz9hxr6v7Sf0=
X-Google-Smtp-Source: AGHT+IEqyo3gnR3NyB3oQvdg+vvIsozbV5qTaTJG/zv8GxeaUAhHO+3UGe3CBB5GgmL9dbKb3mHqoQ==
X-Received: by 2002:a05:6a00:2f59:b0:6e0:a9bc:ef6a with SMTP id ff25-20020a056a002f5900b006e0a9bcef6amr5508675pfb.9.1707767550943;
        Mon, 12 Feb 2024 11:52:30 -0800 (PST)
Received: from [127.0.0.1] ([13.88.99.130])
        by smtp.gmail.com with ESMTPSA id m24-20020a638c18000000b005dbd0facb4dsm812131pgd.61.2024.02.12.11.52.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Feb 2024 11:52:30 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <20240212-kconfig-debug-enable-net-v1-1-fb026de8174c@kernel.org>
References:
 <20240212-kconfig-debug-enable-net-v1-1-fb026de8174c@kernel.org>
Subject: Re: configs/debug: add NET debug config: Tests Results
Message-ID: <6f4e728c-2764-6e38-422b-435bf6691548@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Mon, 12 Feb 2024 19:52:29 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Matthieu,

Thank you for your modifications, that's great!

Our CI (Cirrus) did some validations with a debug kernel and here is its =
report:

- KVM Validation: debug (except selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/6122764210274304
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/6122764210274304/summary/summary.txt

- KVM Validation: debug (only selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.com/task/5559814256852992
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/5559814256852992/su=
mmary/summary.txt

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/00e075ae7c82


If there are some issues, you can reproduce them using the same environment=
 as
the one used by the CI thanks to a docker image, e.g.:

    $ cd [kernel source code]
    $ docker run -v "${PWD}:${PWD}:rw" -w =
"${PWD}" --privileged --rm -it \
        --pull always =
mptcp/mptcp-upstream-virtme-docker:latest \
        auto-debug

For more details:

    https://github.com/multipath-tcp/mptcp-upstream-virt=
me-docker


Please note that despite all the efforts that have been already=
 done to have a
stable tests suite when executed on a public CI like here, =
it is possible some
reported issues are not due to your modifications. =
Still, do not hesitate to
help us improve that ;-)

Cheers,
MPTCP GH Action bot
Bot operated by Matthieu Baerts (NGI0 =
Core)
