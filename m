Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7400C2D2497
	for <mptcp@lists.linux.dev>; Fri,  7 Nov 2025 09:57:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762509422; cv=none; b=kulWnWES/n7fAOWd37xmNhM9oIglNusVVpsnjoMJOHdZmCukN99olj8Y2qaRCoTBXtikcIX48B5389FU3dNpjzPRO6YxUjaNbl79/iybPz7BX3alcqc1XFu5KfdJoXIzGLKUJnplVkGFU1x45hAMbRs2/zFgZ1FLTDmHZxc7agE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762509422; c=relaxed/simple;
	bh=H1Atumk1mMcNHC7cmIVBXykCFRI8AilrxfxUWGfrTZo=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=EGkFSe3l72Vj72UbkGwMXWcUh2aRCvRsQWuxFs8GnfwWQ9TZmRLznM9qa5ODE3mkUI/BkvRYLtUch8YKXSaIDxCe3h0XtpFwDwFuzkFZKJ7Lmd5zAlIx2wnILovl06sHrTSfDC8OFZ2CDdGxyKIDUj3hCUNhWa7bZsFe5FXdbdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d89EpnL7; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d89EpnL7"
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-34188ba5801so530603a91.3
        for <mptcp@lists.linux.dev>; Fri, 07 Nov 2025 01:57:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762509421; x=1763114221; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t19w5UniKOY57/C+mee1BAEd/5u/5Doi3dNTK/qB93U=;
        b=d89EpnL7/vlAHxY47gDNLajeCN+uVxqR+FCtSwhwyEHZCSES5TOvWuh/RDik/hzI5J
         ghgV4mjpRXvXCGerwonQPfgHAmtiaNIl6IOLv5oSAVeexko5sk2xKcC2+GgJJKtjzA4o
         kOBMXLYkTZcdgYZoHVb8IejqfiZny7PMB1jKsPNtUq2VBWc8boE5JZOYHTyJQy6h580S
         Lb/8ER96p0qYCpADDn3m4T1suLM0GhQ83QXvKwPYrUPU0hS/oktdoRXCyw+dWFot/eh7
         C+m8UrZSDCSdbz8oiK/Sdia3M/RCRlt4TkhWTsjch0RBeE0+RvJ5ldNfiJzldKrkoyFj
         My1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762509421; x=1763114221;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=t19w5UniKOY57/C+mee1BAEd/5u/5Doi3dNTK/qB93U=;
        b=VwwjFc01Olqo6xPlPcMKPSXRNhmMN4GPNqzvs2BK/OqgNa+J8uvYHYw8Ykp8kJPYpV
         /ux6Mn30PcU/wgvr/EzoCMIFoNDrkXw3hf2vtA9+FYPXcrSP5qcT3/Mkfr0mEhk6JQ5k
         cbfJ6yLj8FMnTgrBT7JylT8oi1IXEEOouwbjLjG9YCSHNtBFaYtNp69B9Rm6V1+R2BOQ
         9btQC19wRsCFsD283RjLMhKuVMJ5ia3Dtb48+BRW3NLwthvDRoAycw4+gSfbS21G/bO6
         uz/I0UFy9ZSS4v9LLB3QNJhpWuDizqQExUa+lo1iREajKv1+vQRkfj+1xFOLezo91JWw
         Szyw==
X-Gm-Message-State: AOJu0YwiGzHrxjnis3qcJqz+mZKBiKy4drJlnLZffOKIbHtM2UD2FbXg
	T9OSvZDqmEOKqupPdWcN86WFvMoGsbAZ50PcxF7ajTKks/NgqtnRpJjs5Dnp
X-Gm-Gg: ASbGncseHFUtbXlXq7c63q7mdEjwUPplpz6GFqBp+x6phzPQpvR7bTC9ib2+FbXldY7
	96HNdlHokYHyK68wt3bdrh5GOSA/GahTh2WdCDLWkXAQzX+fw2xlHWiI2NDhkMCAdIMidmq/IMp
	X1b3zskSbK5F1N7RW7MRG9mNHNZKEWHeC2WybW/AWj2yV/VG1Q+Ail5JlDLOz19fRJ1ZGKCP+H4
	3FmINAb2njGU9Hp2XX6aUn1M/aExF73hvbKfqDAkbR2dOiaRV4Iyg/zr6rrO+IT/iZlFlbV3RpP
	eC7kR+nR6HRMeIApUGhYiN0QCMwaYA/4J9cr1AskCbCRhkkmjukIpI/+yqjlFQQjjgn9QQCLgI+
	5W9DJRefSuNlQT2g/9ciZlzFg5hreWW7AAOWvFi3xkyZHJ/HbBVfYEOj4GcwmQSAKCpe/aFH++A
	o4mFvXxQP6yRDDhg==
X-Google-Smtp-Source: AGHT+IFU1BEVFW7HhczphK0K/bBL2H1cyWzWQIgmhcnZAynWDLw46Rz7jdzdKKEc95i7/2Z6ym/bBA==
X-Received: by 2002:a17:90b:3ec8:b0:335:2eef:4ca8 with SMTP id 98e67ed59e1d1-3434c57f28cmr2882899a91.33.1762509420725;
        Fri, 07 Nov 2025 01:57:00 -0800 (PST)
Received: from [127.0.0.1] ([172.184.211.70])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-341d0adcb11sm2305199a91.2.2025.11.07.01.56.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Nov 2025 01:57:00 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <cover.1762504059.git.pabeni@redhat.com>
References: <cover.1762504059.git.pabeni@redhat.com>
Subject: Re: [PATCH v3 mptcp-next 0/7] mptcp: autotune related improvement
Message-ID: <e1f7830e-86d2-0d6d-4afc-1283b6df1cd7@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Fri, 07 Nov 2025 09:56:59 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Paolo,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: normal (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: btf-normal (only bpftest_all): Success! =E2=9C=85
- KVM Validation: btf-debug (only bpftest_all): Success! =E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/runs/191632=
23705

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/0a48f35af4c5
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?=
series=3D1020786


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
