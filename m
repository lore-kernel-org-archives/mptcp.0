Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 993AF199FBB
	for <mptcp@lists.linux.dev>; Thu,  7 Nov 2024 07:56:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730966177; cv=none; b=irqdchvPAOPORi002VhhwOTUQ7nnqcq+qLsCtSg5NLh7na4hG/6MqykVlXsLC5dHsKdBxe+XDiHzid4+KsZ+5Jw1F4NUQxbcY+2YbgUC8VyijKx95wDwRl1Qwlh9n4keSEIALp8P10Res4oT6Uuph15lp87+yBzccOZdRXnbDUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730966177; c=relaxed/simple;
	bh=8Zt6Q5HDpBQqbUtpFQOrYviPA/G7z9DPu+JOvwReoFo=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=GVG231TDL27Nx42p1nR4yn+RTmhMmN+wYG4Xm2rhQkmtHBISzPPwVL9BPeF6OoLQsV2aDRgsD4MPDG1vF71cBG4aDPaNSy/Xh51WGJ9aSkStJM5s3Apo6BXaOzEn0elI2B1qhS6DHV7Kko3iRivDF0EQ+85IflCbW2sY4Lor+4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JSWCLqYl; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JSWCLqYl"
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-460e6d331d6so4096681cf.2
        for <mptcp@lists.linux.dev>; Wed, 06 Nov 2024 23:56:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730966174; x=1731570974; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eB981zUkNTMSFFE32VQ51Cuh4/AzsAxY4MeUcnVr5hU=;
        b=JSWCLqYlSZ87R5AR9Q0SxogLfmwssgYKouXBupsLLL5oVxg2HPv+CahdOR2kDqFlU/
         oNcapmV4xRkQUjm2iCWNvv06G11BkxWundp2VCMfaG32dXNoRIhcWppNXTr0f6XCPRfG
         jCPc4MqztgpUxvvO+uifHbdKlqmz529cid4y60gS/iRNa7DQFzpdwd8lNJa+Is3wnmOg
         jC62M+YZoGc9/wm2Gg0DHe5sND6CS/TxOtGCQIROzEB+KLqEA4SlQLJnVTpNCbFJuLb6
         sehsJeHMTAEkEm21TZcuLnStBm/8mqOq1tMSe2Uw6b7yz3DxX74fEFvUDliTf+QwONWv
         e4LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730966174; x=1731570974;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=eB981zUkNTMSFFE32VQ51Cuh4/AzsAxY4MeUcnVr5hU=;
        b=TnN+vJgBx1xOSJ6g4u6c2U5Oy6eQD7Plw6nYovzSxl46nkecx9lQZ/j11HnovQgI+s
         JNKdH5UnfKAjxE6e/AkA6U0rOuPGURETjjvXpvczyuCHaC4KW/nIOH6EeXzZmWK2pwki
         xCaaKo9QnVpLS9WqvLadEH9P4Xu8GHcHPPE3Eob6TQ2CdHSVB4R6Q91sP7I0jrKmlYd+
         JJ5o7fzienisDLmOsbcASJ/jRQSyK9EnBF9sW5jwRhLB+faF9aOXOa6RNz3Ir9tkyH2A
         VhLitejZO2evfEu6nICClCksCdEtPqSnLgrnc3Yc6T8SuiklxAd9iKEDPcj6YNvijmVw
         7NNA==
X-Gm-Message-State: AOJu0YzXyCREXCJaTr/NsCUtpZOtTzf4hyKVENHP6q/lE3NqA2jwGhGe
	vJfr8wLvTQClo0dXgkkaovTxELVWllsX5PE+6E07VwJ5+xYZ+ula40hh
X-Google-Smtp-Source: AGHT+IE6ItqZrrU3gUsvBNmqKgdNF8QjNWfTcwPDBJDFRhUc6Qs7uWb/Ioxq88KFYZ7ljJhQA9BeRA==
X-Received: by 2002:a05:622a:1988:b0:45f:8ee:1859 with SMTP id d75a77b69052e-4613be77e58mr631178371cf.0.1730966174532;
        Wed, 06 Nov 2024 23:56:14 -0800 (PST)
Received: from [127.0.0.1] ([172.183.154.246])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-462ff3df017sm4867751cf.17.2024.11.06.23.56.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Nov 2024 23:56:13 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <tanggeliang@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <cover.1730961809.git.tanggeliang@kylinos.cn>
References: <cover.1730961809.git.tanggeliang@kylinos.cn>
Subject: Re: [PATCH mptcp-next v3 0/9] BPF path manager, part 1
Message-ID: <e3c7c283-bb41-03d4-9761-e3aa67b4f243@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Thu, 07 Nov 2024 07:56:12 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Geliang,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal: Unstable: 1 failed test(s): =
selftest_mptcp_connect =F0=9F=94=B4
- KVM Validation: debug: Success! =
=E2=9C=85
- KVM Validation: btf-normal (only bpftest_all): Success! =
=E2=9C=85
- KVM Validation: btf-debug (only bpftest_all): Unstable: 1 =
failed test(s): bpftest_test_progs-cpuv4_mptcp =F0=9F=94=B4
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/runs/117181=
16131

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/c83e8073fbae
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?series=3D907218


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
