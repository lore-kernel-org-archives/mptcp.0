Received: from mail-il1-f180.google.com (mail-il1-f180.google.com [209.85.166.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B2F223ABB1
	for <mptcp@lists.linux.dev>; Thu, 31 Jul 2025 21:26:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753997182; cv=none; b=P0m+w6zJtT72opH8XrjglsC5DZnmuowCpbISgIZyWgxi3JnZG2GQzvNyVn6v/qMmUvQKyw8ZDhOpImaAOz75KiAE+Z0pzvbUwR+MRlZ2wXTIX2I7oEZjGNvmtzVDmY5Xoeb7NCaJkBPt4REx2/Anp75+mzGI8VCk9/qdJEs5BO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753997182; c=relaxed/simple;
	bh=FYpqQChL+Oj5nYw0SI8tdyA6pPCBAuNa0gLhqtdddyc=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=GoGwi7HVTN0r0Qjz/abyZOar/c7k3sKOBFoSQdWNZWOhKlZIzBtoAvdphdz2mXdMjZlpRI/yp3ifX3wtSkbrJMvUzQtXTXyi2dqknjGpSP9ynrVBqPHYid6cBh4rrSGiRySj48zC6dOjrqGa79NbA7j2v8/c/d0WijacZxswQxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UxLdfqWn; arc=none smtp.client-ip=209.85.166.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UxLdfqWn"
Received: by mail-il1-f180.google.com with SMTP id e9e14a558f8ab-3e40212e6ceso6208845ab.0
        for <mptcp@lists.linux.dev>; Thu, 31 Jul 2025 14:26:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753997180; x=1754601980; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uZKaw+nSdAbcnf2E4GbsSwu4JazF3aS/iuVoxogPSJw=;
        b=UxLdfqWnTuClHSswbGoFD5HgXQiIg2zSO6Q78e9Vn4cIFcTPD6Y4YeBAMS6JNnEcjn
         +hEmPp3EotXqxEPjVITaor7G7trKz38wNbLTx4FHaQsd/qwuOmTAGus3eiRImi7lbFS2
         umTSszGbKj9ljCtstLLmXkbIISa4xWIsAJ2RZS8g+m3ITnWysK2fvK3zwexEdzl+rSFT
         Lza7ijecaZMMnWx67Nxx5AnlED8yTUFj8T306nfvpFSqB8ZZvPKoESx988IQkFQfG2ws
         pCD6KMqYrN8b9VAqQFnmtsS9tZMBncaWo19pwd09uAIxkbHaVcye9r5V1+PCiBk+Prnn
         9HvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753997180; x=1754601980;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=uZKaw+nSdAbcnf2E4GbsSwu4JazF3aS/iuVoxogPSJw=;
        b=lptUiGMQ617qf2LXnKW7FnLLPzOqVjin3knZlV+6sAHkD6GfdQS/vq4/8U3UWYPUEc
         xjnCutmphdpVODJEL9B4XQq7VkQhRVcf2X17WJDYdOqmbW/A8G1i2PBMmHioDfvkDm+t
         JKuTz8cOiiKzxb2zozVlpEuXYCRZAnainQHP8iQR6KWZ8udJRRbH3swrdN2CtqiUrKPg
         axybkfvhtjL0fvkWZkXTm+13ofApdIsRWiLZ6t/iE6lVMNeTy+fmDr5N78WuisEIedt+
         WC7dsciIi6NKoeAfXmUm5RayEpbrY7VXP75W6wbSaVtv0qBscq2QNoCZg/goeoeIoS+9
         EO2g==
X-Gm-Message-State: AOJu0Yyp2M/jf81S7K1ijfCl2LFVkabk7S7wRsbVt29FDnJ9ok94z2Tt
	fioAXQt4UqEzKfR/b1nT7sEhIdY8OJ32YEJJdWu1MTQ34PxkolXF7tA=
X-Gm-Gg: ASbGncvLJ8pM7idar2a1wAJ0cZfK/sieXPnSXi7aI/ayV+G70Cvymi6rEpd3Dx77yjn
	gcc/KL2czpjYuQSudqgwAW5Ra2YSKFlrd0/ilDbvmf1yBuxpKca1jcvBhuRspwp587Yfp2gFVv8
	a0+QfwFn6B7nJa+IcA0XrNBrAti9wmu3EEzCj0XWJ9EYAxME9sK1xH6jZBfAoSWSaJVPJMofCUt
	0kwRPLwNzb5eAj3Ol0QaJhHfV6/hW6MnDGHh+CWhgGeIMLjn/KcuoYjryFJgh2Fl1Hl7LJpEI8s
	nFFZC87VTQoufrA3thrOdWOefPhfDe2rqPznVs5nrPWX2S0uA9E1chiInYLtVAZuhigdf5udDW/
	Ww7jbZ2cO98WIZYBm31FVMDO0pLdCiZbIewtU
X-Google-Smtp-Source: AGHT+IF2rFK229xfHGmAVCBEqapmzBVnYasHWg6mXMlEiyUGiOilhZHzmtCQG9q9syC4u++5nD7oeg==
X-Received: by 2002:a05:6e02:378a:b0:3e3:d093:2069 with SMTP id e9e14a558f8ab-3e3f6252f8bmr154054695ab.12.1753997180336;
        Thu, 31 Jul 2025 14:26:20 -0700 (PDT)
Received: from [127.0.0.1] ([52.176.138.176])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-50a55da432fsm792283173.79.2025.07.31.14.26.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Jul 2025 14:26:19 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Eric Biggers <ebiggers@kernel.org>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20250731195054.84119-1-ebiggers@kernel.org>
References: <20250731195054.84119-1-ebiggers@kernel.org>
Subject: Re: [PATCH net] mptcp: use HMAC-SHA256 library instead of
 open-coded HMAC
Message-ID: <d954dc12-4e4f-7749-ab81-b033a7bd31d6@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Thu, 31 Jul 2025 21:26:18 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Eric,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal: Success! =E2=9C=85
- KVM Validation: debug: =
Success! =E2=9C=85
- KVM Validation: btf-normal (only bpftest_all): Success=
! =E2=9C=85
- KVM Validation: btf-debug (only bpftest_all): Success! =
=E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/r=
uns/16658838455

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/d5f8f0fd881e
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?series=3D987466


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
