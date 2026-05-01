Received: from mail-dl1-f53.google.com (mail-dl1-f53.google.com [74.125.82.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21206325495
	for <mptcp@lists.linux.dev>; Fri,  1 May 2026 07:39:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777621142; cv=none; b=kn7f5wJLt/dPn9dcYbabt7QgCJkNvmHIDQhTAs3/8L1aYvc8/T5WW+STuBBgzPzv4MuXsLtv2iZ/jn0lEEFh9SVdSRskEPDaxYsohIhEnQlQcQYPej8b1hm/TwUJRE4/MdNRP1TqQ6+hyV05eoG+CfT106syV/S99+EKkEar6Ak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777621142; c=relaxed/simple;
	bh=WC9pFGXJftjNZEqaypukiTnDZsVESxIe98qaungsJQA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-ID:Date:
	 MIME-Version:Content-Type; b=CK1Q5l3cpT522lqfZJETWiWD31fZaF+VmFwWg1+4d4n05YT5Woy38Xp82ZEW56raEaz4YnSTR29rz6I5/vryK8lAJNllTtZrDwLHXUtiU46XTQAiGb2MkCvM9cRyEbr7On018NaXOvIe7+q0uEMjsBM9QvIHTB7LDyBSym346MY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ie/WRyZJ; arc=none smtp.client-ip=74.125.82.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ie/WRyZJ"
Received: by mail-dl1-f53.google.com with SMTP id a92af1059eb24-12c726f46baso2783864c88.1
        for <mptcp@lists.linux.dev>; Fri, 01 May 2026 00:39:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777621140; x=1778225940; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UG83NNc+ATzNNVJJGnt8pAyehMpK7x5GplFKKn16BdQ=;
        b=Ie/WRyZJ4x1+I8R9MGcoJ5Zm07qlMAAOtn2r+0SgZFqLaB4CsW9DBpHQXfctZ6k1Uo
         RTpprLLPSfZZAiigDkPIx549snUJFhL1MXk+BmgPfXKsyeVI+/VgduoOVaO0OQulmGLh
         LwedtJBVM3MVpLI6x5aZmm3CUfyLLU8ao9hEnZszbK4yrWQ9DLtFkJJMMkA9G3QY5Bm5
         Zwy5nslaaQH/cXzedHU9xxQonMmyvKJyRNlUYs0XMgk4RSJxmiYwwnkrcXZciDhxkjbh
         IKLLfvQvTZrCpnpQx9YfgB03aJykl9pfZBGfsqVuYzmZoKmWgrWkww4ChETvL3y6infT
         D+ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777621140; x=1778225940;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UG83NNc+ATzNNVJJGnt8pAyehMpK7x5GplFKKn16BdQ=;
        b=A2tMLPAjFqQiMkIO7iiKTjJzTrN01BC+/70Xruo5qT7ve19UNQ7eUJ2kmPAAuT+sVg
         U8+dcXYrZGv5wI7+FiWiot812ov1xLQLsHiqWXA5v1aG3ai8y45NvMLCQUhRc9n+jnNq
         ZOPSEOezm+AkeKYECJ1hmoXWVBFVGiHuOvZghhSRjpSGFQWPuRQREurWETptNxKSwQ50
         x4v5c3B+VVelEnfVEy/TdZourcHPkt7fzMkX+uTiPNUykMHFvNH4JKLDdP4EDCxATuZu
         fFqOYASkWVve18TpUluD7aspB/zHOv98ja96XzF5Jqq6+QrLQm1sH+uWtXyfVu4I6quC
         66Sw==
X-Gm-Message-State: AOJu0YyCLYc7SJsF3Xi8/BTVBxbb2/23/lsdwAGaZWPSYqnsS4q1Jp26
	ZxynOP4lkZ6gYImni8nD8Y8h7WZWy9SE7nVI+DtzgznmArPCZmgsjvib5TRL
X-Gm-Gg: AeBDieuYroUvqsBHKBgT0o0rS2Gp/Tcczz0a+1bdL0BaTEg/tYuIyzr7djJXgN/xuVE
	N3jvC7ut/aZ9IFrOmGQmpX9X44yGtyV8Zc6Uj64VjEEQ/maZ2oBCkOu9kFsgFGIASTImeo5Nkjg
	+c66gpzGBGp/XTjQLessDstuxmZrvsA28oiE0Hx4IUX+JHtQHG+lPBYaAnxb75KOeOzLpwV0CTR
	cTG26RD+NNooWYRMbyxxSdjGSgxLCRqKMdTYH53rgRiPQmrqvbRdxWyq3MIPY+eYWaXitFFqdLu
	WPBWrAmZBGHsp5lTnVVLB6tcypY/VHMDLSgd+cjto1NJUPExamPZIolYKveqBJyFlXOZtaslf0x
	pXxy9pSUZAaP7G0kT8CuMm41mS89Bof87+iP/XS37WpludG8TeN2/tgc7X2SkZBQJQLacBGd8Ke
	S/psz62e/ZOIcG+a0PT1lNMN2bfKREcMJlyk6GpSrV34GS
X-Received: by 2002:a05:7022:ebc2:b0:12d:de3e:86b5 with SMTP id a92af1059eb24-12df82951cdmr945611c88.37.1777621140204;
        Fri, 01 May 2026 00:39:00 -0700 (PDT)
Received: from [127.0.0.1] ([20.169.72.5])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12df8278e7dsm2166963c88.2.2026.05.01.00.38.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 May 2026 00:38:59 -0700 (PDT)
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20260501061939.1808489-1-kuniyu@google.com>
References: <20260501061939.1808489-1-kuniyu@google.com>
Subject: Re: [PATCH v1 mptcp] mptcp: Clear mptcp_out_options.ext_copy in
 mptcp_established_options_dss().
Message-ID: <4d0b5b6e-96da-93f4-557b-8e244f35cd65@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Fri, 01 May 2026 07:38:59 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8

Hi Kuniyuki,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: normal (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (except selftest_mptcp_join): Unstable: 1 failed =
test(s): packetdrill_mp_capable =E2=9A=A0=EF=B8=8F=20
- KVM Validation: debug (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: btf-normal (only bpftest_all): Success! =E2=9C=85
- KVM Validation: btf-debug (only bpftest_all): Success! =E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/runs/252052=
45139

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/72ea78ab2973
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?=
series=3D1088432


If there are some issues, you can reproduce them using =
the same environment as
the one used by the CI thanks to a docker image, e.=
g.:

    $ cd [kernel source code]
    $ docker run -v "${PWD}:${PWD}:rw" =
-w "${PWD}" --privileged --rm -it \
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
