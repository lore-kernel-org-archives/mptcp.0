Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17D15A47
	for <mptcp@lists.linux.dev>; Mon, 17 Mar 2025 18:07:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742234865; cv=none; b=fvVxtvPINaXeFHL3eUqDEaZLrZp///sjFC/Y6cvE54BvrEKJyZGMsk6wc2zOgKfjV/d/nc8ZWZxWUfPc5aXmN73NWqViu1sHW/RXG08aE74TWPeo8UVVZwc1fkJBXr/QBMRtkvqdHvW47FtnukuBdmgVbPRNGZDYGJhEOVIymLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742234865; c=relaxed/simple;
	bh=UTaQJd1TWayNM4xK5iDBy9/ni7/AXYTif4OphwfjWQM=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=fpZPmb5vX2s39jCSEFBM2AQOfVMS5Rwmv17iMgwrr4bXdV9zD/31kwOk743yaeFLdu4rP3H7NldfMoPKh4GkdvtEZZjuX5o5PtZu1vF1bfk6zIE2f5GUL14hqIVjkWj5jqlyElkfKzrNnaQm6dbV+G6gi37Q5Gt9dUTEG5MEEvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jKbfEjVL; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jKbfEjVL"
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-3014cb646ecso2767395a91.1
        for <mptcp@lists.linux.dev>; Mon, 17 Mar 2025 11:07:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742234863; x=1742839663; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6kCj0gdPr4p3V61SRWv1XCg1znTzTCp06xfRBoWoRPw=;
        b=jKbfEjVLEMS4bJfCiLj7i3OK1hywsgb04K5Jpv3LteB5f6M1MIFRJbG/0IZTVWZ3mu
         VMpVvk7ogfbYfW8uDXgbd5OSThA4dT7V5OouAgGkScxuDhkN9pjK20s2Ym+IhTWHaVQ3
         /AKyCb3/yLPOZdfrT/4HZ0T1l7O8MGQ22tFY0dqbWaZDg+XMqRQt1lPMurplELHz2ty2
         2+8mn1cmQXAJWnguYbfniCuJHtYqybU34d7NiCc01H+IfahlXpuOreeo2oZzgjy/vOOz
         sIWa701p8DZSROV2iL1TH3WdLLgg+LLfl40CLQBIrAL/8J/WtkKXux3tu/J04OnTQBSI
         Vlfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742234863; x=1742839663;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6kCj0gdPr4p3V61SRWv1XCg1znTzTCp06xfRBoWoRPw=;
        b=g9t4Rf4OkHy+DAJUk66OEjtt7KOq02JynrYehIPYQy8S2I3CT3LOwGsaYXOPLSpRQJ
         JRyQRS+WgOXtB9AsFejMo3Wwx4rZE4oXUGh2huGFzjcZlOeLMSuPVy6aBugyf+9v34wo
         eYDRUPiqWGq06bxWjWinVfA3+tODxB59aBEMPoFABPDb+Xpr17GkB2df7hi6thz0OqcB
         Ha1+HQohXlNKkaBaL3G73xVK6maVjyfPjHkTpJ3LZkyMbjsJ1k66pLyDG4nfzfFmvzyD
         EDdL9r52YgC8qFDzls8glamXxXRFZpGjiIGQrypnscjLKU/fAA/7QpDhz/sgZ/ju03o3
         +8PA==
X-Gm-Message-State: AOJu0YwlHJdTdQ0F/sT/fmwlooh1smClN87FO6hRQzNi9DuUz6JjY1Rg
	OhYoLPKMbHM2Apxzb8VRq4ZyUaTZPYUXNluRtq9zX0YuC8+4f3M=
X-Gm-Gg: ASbGncsFPqTCeARG2BYSYy1U6Bp63KS9L3aHo2G6a82+k22f+A/W136nZk1k99Mv/dt
	LqHzyLFOW968ersMfz7a0yKv0H9ar+kKr6G/DCAyjxAvtLM9g0O5CJ5eG09GZtWKn+EPbadud5x
	RGr2xalGnsgf4dmSrngS51Q4I6lggsn1OnfuWfPhpKjR+gN4PzEHouS4rnspmN9cyjS+/FBKNUe
	lmk6dmlsOR7hDUSyPCBMxX6Aun5RqaCmwvSqGtVqK1UNvW/0mwSn0VgA6aA0CLs9/LQ0U2cFjcR
	nZfwEb6QN/2AFJj1myCyD+ogwfK0by1MT3drfIrdIn/tEzTyWsG3Eqkd0g==
X-Google-Smtp-Source: AGHT+IHAHakZUPhZ5fBQEbqfYRhHf+9hW2lFBmgT3yTpePjRGJXYYXVnhbnKtX+90MLEuTcmWjSJGQ==
X-Received: by 2002:a17:90a:e18f:b0:2ee:b6c5:1def with SMTP id 98e67ed59e1d1-30151ce1224mr16786219a91.8.1742234863202;
        Mon, 17 Mar 2025 11:07:43 -0700 (PDT)
Received: from [127.0.0.1] ([52.155.58.136])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3015351a054sm6429550a91.20.2025.03.17.11.07.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Mar 2025 11:07:42 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20250317-mptcp-sft-diag-ignore-v1-1-d1e7ec9ff89a@kernel.org>
References: <20250317-mptcp-sft-diag-ignore-v1-1-d1e7ec9ff89a@kernel.org>
Subject: Re: [PATCH mptcp-next] selftests: mptcp: ignore mptcp_diag binary
Message-ID: <14bd122a-1866-5d27-3169-f9a0264e73ec@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Mon, 17 Mar 2025 18:07:42 +0000
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
- KVM Validation: btf-normal (only bpftest_all): Success=
! =E2=9C=85
- KVM Validation: btf-debug (only bpftest_all): Unstable: 1 =
failed test(s): bpftest_test_progs-no_alu32_mptcp =F0=9F=94=B4
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/runs/139056=
53117

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/1a75ef49f70a
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?series=3D944785


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
