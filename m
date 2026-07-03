Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37147305666
	for <mptcp@lists.linux.dev>; Fri,  3 Jul 2026 18:18:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783102726; cv=none; b=snOJtGy7jAJdJfbcthCozi+EInSq7074JGy0wr415P7Ei/8K47mxmHVJF5r3jUH/WcQesTkiUqWGkBOf0nsyZagHfa+OZIcuvd0GrXe6zXWeOAH+RrxdLnsJ2j6rt8ca6mVlAQPt8DzOhKbtSa9zb9Rko33/sNSH0Vz3B6A8pD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783102726; c=relaxed/simple;
	bh=3trxmfJJzrU7jKuFuulb/9+CbpwavueKqCDAkbs1WDo=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-ID:Date:
	 MIME-Version:Content-Type; b=LUxtc8OH/4Hj6PkmyWeHrRHsgl0sf8V70kGl1HZ8Gc8qpsGqipTde2m8sYy0lt6ot2ChtJlPeOHB6GNm9Z0S789eC7NMJAjSsAssB6fVtMI3Z5dsR1z++3aRHPO6araqf7Y8dVzpnY6e9QeLKl1Fo/6HuTdvMT0lDVCK5TdLvHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KmWLedow; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KmWLedow"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2caced6038eso9154445ad.0
        for <mptcp@lists.linux.dev>; Fri, 03 Jul 2026 11:18:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783102724; x=1783707524; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Zvpj4tOMELPp9DIHH2azUD3sy2LSW+n62guFqhj21j4=;
        b=KmWLedowOpbklZKBVbD+38icHNP2WYn68UAoeqtXT59/3HEYG5HpPLN23QppMyZagb
         oYwA9LlklXWNrENfkS3CuQJKZIB64oDDhhgpzy23IRQEJQs8Nju0zm8VJ6ppYr7vEcFS
         AGNE2n8uPdKgvZuZLoDNq44IBFkw5LGNmfdr1KTUybQ4qQSCURq5w9ZDszuuraY2CRgr
         aMXbqwXNMrVL6bmnuMOQ4agL0aGW/A4BK2rnM/6g2Ivg4w0xkGsrXfqxXVtzudXy26bu
         mbm2kGe08DgpnLEh3qq9fnAmkJCM6tKVPnEAwV2uQh9prx5qKmEDp5A+Ehx3htzFMz/h
         l36A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783102724; x=1783707524;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Zvpj4tOMELPp9DIHH2azUD3sy2LSW+n62guFqhj21j4=;
        b=EXnAi1VPJI9vlGPGReoQ13XaeyrvwATNpt5ro9FqfWL3K4Zi0iMJAShSuUYSXtXugw
         PAY9MdyGduZmv5e399wPhkQMfqOB8zAeC9igYBXFmz6/6J1UYUDRueMCSc42vLzCBeN8
         r3DVuR53pmEn3PSopN65IN+36apRxMGttgSQRYdJqFnWWiRN6nVVXAKbcg+UBhkkyXtN
         lXt8tVJJIzSuXcka+jNiQkXAH66MwFI3lJ78ulwVbPotw7+BTzRk8uHrqNhsuCbSb+rb
         n0acAno3bsaeKeRXv1CU+s72pkH3NN20/4ASD3juLqweWNJUbmxE4s3q2dQ3xYx6f8mf
         1bzQ==
X-Gm-Message-State: AOJu0YzM0e5JYSpQfa6G8rccVGowckgi3iibt2G8sqk5JmniZqW0QTWk
	Dm416/LYXa0eZ9Ed4vgZVkmWL4gycAYtx9jsl3vewaiRZqfUc9fGBwM=
X-Gm-Gg: AfdE7ckXxtuF3h6cJquOG9Z2EE1mO4trYKwh1PxwwvEMP9KB+PfAH7V0WPkjPrGUgag
	Kiqg2ZC2FN8KkNJxE0iZDFocGezLsqOXpGe1u5W9f9MXBdJT1j9IdIqc8iA4kjOZaTAgK1bQtIp
	uFV7BsMQDCH5SlVy13axPAyBdN5yIOmqFs+nvnYuJOuvzHbONJE8njMB0DG75WX68yR1CMywxKs
	QSZtNTAwBlC0d2KrtlzFN0sM/Ae/7+LKsnafKE6n6lNTNiCjsLlH9997ogJ+cZPU7+1fbJAlLGF
	R2fF2YQ42S6uhaulSAlbfEpUvYJj1KdFvBGJ8z1hlv+NnxI6Vznr+euOYq2/zNjq+Ho4SdKYI4D
	R/wQf2PDpqgG5iT0lTBr68X9NzabxV70PorDXlxiz/k6C9Bgoen7bsqXtoz8nInSWkrV9eeKIin
	72v7v25WRBOp+4rVkYRyUKQDgUGE/y7KgFx/dy3Vo=
X-Received: by 2002:a17:902:da4f:b0:2ca:d034:ee7d with SMTP id d9443c01a7336-2cad034f41emr43134035ad.4.1783102724240;
        Fri, 03 Jul 2026 11:18:44 -0700 (PDT)
Received: from [127.0.0.1] ([172.184.239.226])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13b3ececfe4sm24864233c88.8.2026.07.03.11.18.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jul 2026 11:18:43 -0700 (PDT)
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Shardul Bankar <shardul.b@mpiricsoftware.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <20260703-mptcp_bpf_kfunc_fixes-v2-0-87ae3c64dc7e@mpiricsoftware.com>
References:
 <20260703-mptcp_bpf_kfunc_fixes-v2-0-87ae3c64dc7e@mpiricsoftware.com>
Subject: Re: [PATCH mptcp-next v2 0/5] mptcp: bpf: fix scheduler kfunc
 socket type confusion
Message-ID: <f7dd2c6f-53a6-004c-83db-d8e922c46793@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Fri, 03 Jul 2026 18:18:43 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8

Hi Shardul,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal (except selftest_mptcp_join): Unstable: 1 failed =
test(s): selftest_simult_flows =E2=9A=A0=EF=B8=8F=20
- KVM Validation: normal (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: btf-normal (only bpftest_all): Success! =E2=9C=85
- KVM Validation: btf-debug (only bpftest_all): Success! =E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/runs/286748=
88575

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/89669fffbd45
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?=
series=3D1121285


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
