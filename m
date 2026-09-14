Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B650433E7C
	for <mptcp@lists.linux.dev>; Mon, 14 Sep 2026 10:29:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789381758; cv=none; b=FH3ndSIYtFNgLJtBMp8Idsv+X/PqsZS+P0f9elcNt8nIdVx3NBQ1bp518RSPQYJ0SY7OZaguIggrfQFcxzUEjqyNy3OoZ8e4Q8qjlKZwG71B7biRIeCz27Bgo2STcH9KrH2SZVy8cB6H/RZYcJWMDL5a8mrK5J/9aVTimMRIR2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789381758; c=relaxed/simple;
	bh=6akXqD4amjEFOGJqYCgUXHdc4dsnt7KsZ445MgGmJN4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-ID:Date:
	 MIME-Version:Content-Type; b=RcIvtSfLhuVePK6TRW3dulydiChAyzTkUqC2B/rLk9FyDepoXczUsev9N+X0QVvh48Vak4EKr9aECpOJUXGRnM964gLa3q2XPwJl0h8kgze17/TzA6fgYBrFDR8eoitOK/xTsmKTNU/SkJwKdmm+3VchH82vCPMxZWqH8jelxK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B25ZAGyk; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B25ZAGyk"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2cfbbdfa60bso32365465ad.3
        for <mptcp@lists.linux.dev>; Mon, 14 Sep 2026 03:29:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789381756; x=1789986556; darn=lists.linux.dev;
        h=content-type:mime-version:date:content-transfer-encoding:message-id
         :subject:references:in-reply-to:reply-to:cc:to:from:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=p4DOMfSJ/gQsLDgVszp6dG1ieZ7cOfNLeT/hTRvdN80=;
        b=B25ZAGyktIIwAF85oN89GLaPeZVFnwz1ukOTOKPdDBTOTPg9WrmbefEOsKnojRrC5b
         n6IQKtGlN9N+FxoliiiR1nxjyoU4+/SBvx6ORMl5qoP7XkfJGEJx/Rm2y18mvYJOixls
         7qoGgzPhMlWBMGJgGgn6HFinN2BVu+Q6X8RAZ2hAql+gMAXQ6bM51eNLTaWTI36N1ml6
         gvpt6Ku1Ef7GTg36epKkJVYy3NGMy/0Gj/EnFGejmXOaaRzF6w6OR3fN68Fb20VEZ2C1
         fvdSLDfms7RTBDxSuyIXd9koTyTI0XoKGvpK0rYdH0aCpuCWIQekM5ghgdokPeS/ZCg4
         F0jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789381756; x=1789986556;
        h=content-type:mime-version:date:content-transfer-encoding:message-id
         :subject:references:in-reply-to:reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=p4DOMfSJ/gQsLDgVszp6dG1ieZ7cOfNLeT/hTRvdN80=;
        b=QxTfIH55mCQfeiepSQYHfYM6Mq0zFWqiYtU23axNssNNGYMSgZ7HL15EWfEUOf2ZSP
         LZvBscGBlXGNqVhCjZfPhaOyw7+d1L9uAz3ygw/JqapUUchHVxRdEudvKqSkAY6YzM7V
         w5cBYYQOpcvhS/8FA2LsHP2F/gZLEdeQMCf5AqIeszifR/iocKQ7U6Gg5xN2l6amHMDs
         u2O97frDwoRg02r9wGuloFAA8xgxAxvWKRcjpjzFOc5hU7axIsjsJDgmsvekFnKReysA
         cMKuPbV2Q3htcK6GCU/894ZDtQ4Z0IMxJGpQEKVRwlSNNadZ9eb7SvWoPl+jcx3zgnEO
         F3Cg==
X-Gm-Message-State: AFuF++lzoZiomKsTzPDTWenquhFuMIjTRT9MamtNMPDU0sInByAOlOHB
	zJXQRjGMdB/gP2QnJkwqwlZRcBnJZV76qlel4L1szT6MjDkzLLkhnII=
X-Gm-Gg: AYBFou1i2UmEJ6S59YxQZO0uh4pPHw9mox9oXkx4kLexO/DnpnK+VU7yv7iPnV08UZ3
	oev5GwsNBX7AJ9CG8RVDUohogFnZpks2eJgYngh4nsvTzo/bA6CJdaaJIQwl7tF0YC22fmqKh6F
	Kbfs3GolCVe/bsKFJb3CaGo7Wqe5MUctwdtPIcAZlGZz40BM9o6thr66QOoBqBx5zTKH2wZ9mr0
	d2pva18EV3L1ToSCHtAUqDYaEkvFb2Vmvs6ty7gRXSJjbEaWrde59C7B/OvtlPo6I81WU5OJfx2
	VzcKiuCgNhoIgMPK8kmJN41JDbir8LsN/4px2BBrVyciGBXlDDviyYXU+iq+EsGQavywHVWEbDY
	DUrif0I4fCCrJxaTxpMmPs7kLFl8hVbLvNUrXdIGL3zlkRVi6iGFWkinVDDN0Yehk7N6yY2oH/E
	bL5COA4sfKfEDS7IQeokloegUNeG620AI4HblWG1LnfGenj+WgA9an1Uw+JBSRoNioboXJpC03d
	6/DNcXnxw==
X-Received: by 2002:a17:90b:1d82:b0:398:a2a3:b631 with SMTP id 98e67ed59e1d1-39dec0be84amr4035454a91.19.1789381756429;
        Mon, 14 Sep 2026 03:29:16 -0700 (PDT)
Received: from [127.0.0.1] ([68.220.63.3])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33ba4efc398sm30715715eec.19.2026.09.14.03.29.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Sep 2026 03:29:15 -0700 (PDT)
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Kalpan Jani <kalpan.jani@mpiricsoftware.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20260914092000.1306968-1-kalpan.jani@mpiricsoftware.com>
References: <20260914092000.1306968-1-kalpan.jani@mpiricsoftware.com>
Subject: Re: [PATCH mptcp-next v4 0/2] mptcp: sched: let schedulers mark a
 subflow to avoid
Message-ID: <63eac29c-9bed-3be0-2ad7-abcbf3fd4768@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Mon, 14 Sep 2026 10:29:15 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8

Hi Kalpan,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal (except selftest_mptcp_join): Unstable: 1 failed =
test(s): packetdrill_fastclose =E2=9A=A0=EF=B8=8F=20
- KVM Validation: normal (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: btf-normal (only bpftest_all): Success! =E2=9C=85
- KVM Validation: btf-debug (only bpftest_all): Success! =E2=9C=85
- Perf: Success! =E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_n=
et-next/actions/runs/34828601595

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_net-next/commits/b7129410a6=
77
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?=
series=3D1164353


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
