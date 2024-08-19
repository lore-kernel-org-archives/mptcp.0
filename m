Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67324158A12
	for <mptcp@lists.linux.dev>; Mon, 19 Aug 2024 20:27:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724099275; cv=none; b=cwlXV6G4P59MDpXGDa/3i18oms/f1Lsh4ta0nRrlVufGvTUm/vUW27Yfjp4puFwNl/CQEGDFUyO33iTLb9e1/EWV3/m3+gIekvHvvYII4ekN5iIhocL98Fw+YNEsupF881lV1y7nq7J+uinRen0NYR08qLxB5GDvSLIZhwPYcIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724099275; c=relaxed/simple;
	bh=BX1T+qAEOcQUT8ve2IsV+WG0iEiy/ymCCMWqKwtA4bw=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=njVoA27VNsODaPfIjbVgBlgHDdDfLv2dZYjh2iE/TcT48NaLlotI2o2RSs66AtIc2SqgYbBRo5IuFGkAg3zsP3EwPAvcFZyUH5ojD6cm2eLI6YYH2Mw2zieyJvqaw88GbztcrqGwWYKwbsz7A0ExxOAUzu99VoWRYOBVONA2sC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z+AFLT7m; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z+AFLT7m"
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-70f5ef740b7so4250333b3a.2
        for <mptcp@lists.linux.dev>; Mon, 19 Aug 2024 13:27:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724099273; x=1724704073; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gxazWL2Rv74f5LGCEmGuy14/xvCtt/hhX+cDnwmf5TA=;
        b=Z+AFLT7mXbISAy2dqutr7C1wSgx81YRwZ8Wg4yt4qPE79HWFLk5GXIBLniheQkVBNQ
         Ux6RKT5bibD6hKjlHTuObEjARq4MsQf7tWmHaLDECeRr/Xl5UNJAi8HDb5A1dDfa9+H3
         Dz76A+FbBIXhD2jaRUZp2CAP9VLZVM8UFy/lDtPOQeoBcBtvQGua1HswnKoRqqLS4m/F
         ZLHxIdcHX/mt5jEfB5cgUJTa0xcg/9wn4uGMgHzVVWLJyeJTXb4RkYieFFDjWzaCqHm1
         pVhWE/YYXcl8Y+7SFq5ipXyEER0KPCq6UXAs+Jg4shJ/v8S6j27Z9PpN/NzDSCerFjzA
         zuOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724099273; x=1724704073;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=gxazWL2Rv74f5LGCEmGuy14/xvCtt/hhX+cDnwmf5TA=;
        b=BYHm22HxaEyN2RkG21OaFmIfUBQAbsJ48hygxTgGbx+hf8MHMCRze2leQWlIvWvIHz
         7cvPNIxqOZ/Kuy3OOiy3yHkQu6DJWG+tjOVtBcWwkUw/uB31faMR5xKeJPw7E8Ncreaj
         hFZZ8XvfUGLwK/GXL+QVlvCtq6WEXg7wWmRoQlDalYs4J4P8EAJRzoMk9r5RJ6lGmF44
         XGnJzXiWZT/RJBP2fEAvYG7SyZuF0kVr/8Dlh4xZGICkU0Pgl2c+EOOs2M+Vz/9FE4mM
         3i/QBm9XmdoJ+vM1hNo6xL161uaZU32Ecx97qCu0ImioPgdfoxuSAzSDTrpEsHATqEYU
         iNoA==
X-Gm-Message-State: AOJu0YwM74/zAULnO/71WGvrR3v5rfl/SDszvj1r8x+bQIHlJNsoPQKG
	voStLAlLIFcXQFNqKoLhccI90W8GQE8QUi82mUYEYWZ9jxyoKrbFVfhU
X-Google-Smtp-Source: AGHT+IElr3YjSXS+0FUDPd3Nl9mkH5t7xLBpQezjax+brYKMh0sWC5nucju1K/jO1nPMMK9fZV2krw==
X-Received: by 2002:a05:6a20:8411:b0:1c4:919f:368d with SMTP id adf61e73a8af0-1c905053573mr17437632637.49.1724099273517;
        Mon, 19 Aug 2024 13:27:53 -0700 (PDT)
Received: from [127.0.0.1] ([13.91.68.148])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-201f02fa51bsm65968295ad.53.2024.08.19.13.27.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Aug 2024 13:27:53 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20240819-mptcp-pm-events-v1-1-c31d472471be@kernel.org>
References: <20240819-mptcp-pm-events-v1-1-c31d472471be@kernel.org>
Subject: Re: [PATCH mptcp-next] selftests: mptcp: pm_nl_ctl: remove
 re-definition
Message-ID: <cb9397a6-f804-c9ee-b99d-457d37ce3069@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Mon, 19 Aug 2024 20:27:52 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Matthieu,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal: Success! =E2=9C=85
- KVM Validation: debug: =
Success! =E2=9C=85
- KVM Validation: btf (only bpftest_all): Success! =
=E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/r=
uns/10454345821

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/d1fc17f8aaea
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?series=3D880916


If there are some issues, you can reproduce them using the same =
environment as
the one used by the CI thanks to a docker image, e.g.:

    $ cd [kernel source code]
    $ docker run -v "${PWD}:${PWD}:rw" -w =
"${PWD}" --privileged --rm -it \
        --pull always =
mptcp/mptcp-upstream-virtme-docker:latest \
        auto-normal

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
