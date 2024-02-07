Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44D6A85C5B
	for <mptcp@lists.linux.dev>; Wed,  7 Feb 2024 19:07:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707332853; cv=none; b=l0YIwwQ5GjtWGSNmhXfny6PRhSLCFseK2LXOyEhRiXFLWit3nUC+i3xq1t3N2MI5Ergc5WT9DgAXIbd+qvekLTaxhP9yvxy61ytNiziajTK1UuUUBeZQ3UMKNxgg29x5RrL7SSHlVSS7BT9dL/QSGM13PlkJC5GDk/NtVNJB2dE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707332853; c=relaxed/simple;
	bh=MqTEvocyFV2hrFIAAQyii1y4U36WGsY99DxTNPcfUFU=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=Rz7KwTkdb8PlryczgXH5/R1cg6ubnjYlX99F8HcXEJlYnLWUWfBzwJ6otQnlAwuI+5Lvyh9NYG5E0lRSx7BYZiZemysTfw1waBsCNnW+0cUMjy8vTzw6TCsPKBmv7jZx2qcqHmEvfsKvUToeqWIVHkTuq7vmggCseOK8TuiYcU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J7CgfyRn; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J7CgfyRn"
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-783d8dff637so57001685a.3
        for <mptcp@lists.linux.dev>; Wed, 07 Feb 2024 11:07:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707332850; x=1707937650; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r8d2Uk5ewInbjc9ioxRdwjaCI1gvGxEp3Yg5N8+AOek=;
        b=J7CgfyRncpmtoTlLgsAauX16txQ4bQA4k454qeCDvBFJJFxaqZRmBZZ9dW/sTNxmGP
         BO8jhd+7pzXBT1G1qJ8zW50a473zuf2cOFZ/dDUUlVPCCCYv4QlY+bSCpRzRpNWoTkAt
         UVLvrFmTlaDo0QZUBa+UJbZeK8nnak9Cy4WZBDQGPmLtdtfu7KWkxYyRVsuyAVCdELig
         NaQRJTmuiZ+Ok+bfYtBVMcfhoYaRPaZAui/pOqSFQHc/0gIpm5PEU6JDqPfx/HF51P19
         hXNicxMlKqm+pRzUfkBzNGAKln6EIRBjRWMcyDzmfou7QuOTMxwUd79e/8yW0ru2ZiKN
         0V0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707332850; x=1707937650;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=r8d2Uk5ewInbjc9ioxRdwjaCI1gvGxEp3Yg5N8+AOek=;
        b=FOoDnznirlrOli3iYOql7C2eBv5eUCbpML7whdDTXNEwzpGG6CKiLnjSM3P4CfFH9D
         JcTE3hBsp6sSWAuSO7TcBfiuFTmBpwIBj5RTQzBmCjveKxRlDCOXOtoM/FvUTFtvBjcE
         YSGxgYFmJ013LUHqsvuuG7wKTmDI18RGP3msdqF0NfnwlngtvzqeShIyfcTDGhfNim+9
         aO/KsWkL0/b6Avlq2+HDRla9m0WY2OmmX59WuLNvqIdxAp7NbQ6nz7twu/KnERTCi5dS
         mx7nhN3anXhPR5TvAw6T98sXjqzX8Ud34JPMcgW2cF91Hg2Ynbf4IzZetkCtrIlh1w87
         vdYQ==
X-Gm-Message-State: AOJu0Yz5V6mfJWVytAHILgPgUrZC1/r42TUsJoJCJlimTjHupIaHnNTF
	XQ9hF0uauvv/+vMIbC2HxC72OxpOd2NUyMXt8RyUyoIVGzFO7kMDeOtN+dA=
X-Google-Smtp-Source: AGHT+IE2cmYAX0wJkGcN65zeTZiBPCLJtEJ53Ygspgkn8AUXcMkRJX7oJmpvEnvLxXLquMW0lHIT+w==
X-Received: by 2002:a05:620a:2105:b0:783:f88b:387e with SMTP id l5-20020a05620a210500b00783f88b387emr6862152qkl.12.1707332850048;
        Wed, 07 Feb 2024 11:07:30 -0800 (PST)
Received: from [127.0.0.1] ([172.183.74.6])
        by smtp.gmail.com with ESMTPSA id h14-20020a05620a13ee00b00783de6b5ccfsm767390qkl.88.2024.02.07.11.07.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Feb 2024 11:07:29 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <20240207-selftests-mptcp-fix-5-15-v1-3-005b0cdb135a@kernel.org>
References:
 <20240207-selftests-mptcp-fix-5-15-v1-3-005b0cdb135a@kernel.org>
Subject: Re: selftests: mptcp: diag: fix bash warnings on older kernels:
 Tests Results
Message-ID: <98efecc1-551a-7b7a-a6d2-a601e6b2b910@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Wed, 07 Feb 2024 19:07:28 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Matthieu,

Thank you for your modifications, that's great!

Our CI (GitHub Action) did some validations and here is its report:

- KVM Validation: normal:
  - Success! =E2=9C=85:
  - Task: https://github.=
com/multipath-tcp/mptcp_net-next/actions/runs/7819509269

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/bb075ba934d0


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
