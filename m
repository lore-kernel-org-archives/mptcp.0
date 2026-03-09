Received: from mail-dl1-f49.google.com (mail-dl1-f49.google.com [74.125.82.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBDC025487C
	for <mptcp@lists.linux.dev>; Mon,  9 Mar 2026 09:34:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773048858; cv=none; b=IOUOSSXFeJwCSLUuB+IwBXXuv7PSCHGcDk6gUQjgk5uTfVV25pu4/07bFTbE0e8/zy5Dmqst2sTIlgnlOOHlyvgu40lLCYldxgAuCFfsFLDJyeosFpP/GioaIJqMq/dQ/t326oplNfMnRtDUI8NKQ8FnbhHmaPM7hkX3vdpOgac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773048858; c=relaxed/simple;
	bh=7n1dSUg3WusHwhQd2ngZ6nPZg7wRgjLOq/5ROPpn1+U=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=bI/vUF7oloBT+16S6oB26A7saKnVyDXY4Fe7nDjW2yjxaVuEj9tSfjIxJpNlZN0TpsFrd1imaa9yJ7QYOARV1uCpaAxL/ezxGLwFTenJMSHGNOGzJtuisW+VMIa1YBkJJye2QTOweddY1fYUrIVdEBIFekAsizkWk98c45pvSVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cH/NY8Ye; arc=none smtp.client-ip=74.125.82.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cH/NY8Ye"
Received: by mail-dl1-f49.google.com with SMTP id a92af1059eb24-128d2e3082eso2638186c88.0
        for <mptcp@lists.linux.dev>; Mon, 09 Mar 2026 02:34:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773048856; x=1773653656; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q1Q2HiV40qbJ9Ep5Dllet6rLYyAhoAuWelZIPW5yKCA=;
        b=cH/NY8YeHFE3P0xXVvsVFMalXq1cUr2E9nOntf4xOuBiU5vrJsT1nZYHGKxnrr3/nq
         RQ/uIrbtu/h59GkcPqHYBFAfpVY+XQiZXOooB6d+1sGm+2/+/MQTUrZxgYt7Q47tHtvo
         IbEGL8ojogb1l9a/rrhWUga3LEjeygBAwIlisC3hFiPSe8nd9NdNFAoVg4bE/mHAYgRY
         YvUmrUBRVTmpgcCSiliDrLWxn3YPlY35QnX3V3LlJCrpKzY1DhGB8PGWA+3qvxa+cmQ7
         ACzhtM5LXVqqtaZWA84KyUZ7ZRTYvQ6T4P7JyN2DITu7SMRXKcCI0wQYI9OaoQh9V3Fk
         LKiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773048856; x=1773653656;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Q1Q2HiV40qbJ9Ep5Dllet6rLYyAhoAuWelZIPW5yKCA=;
        b=NPMkn4oMOItB3uNpQcczCsiPCdXy3TnTkskM6Ty1jnFmX0gC698EKi2Ceusa5uzqdA
         0r9Kc60F8R4p7K+jVS/M84N2BMUsvSuUoNBlDaf3qXy0fTHUnSfqJrmUosVX5VdR/S+s
         G5nVMaxc6zhqBfrU5XCkje9msZdjUOdV9R79ZTgLN9StJCZcDsDQOgBYbMwYeLcAwlPZ
         EvzwHooZtP58VVItB4TB3cB8+KrtsdI/6uW3kzjazDPwrlmoi4X6+y/0RQ90BVPIUmwk
         2FnKgLmUFDbTZdlwl9TdtcfhDtCNCDfTuO6wPno9iEh4AOeP6KLzl9pNNRuaP4WrQbUS
         ebiQ==
X-Gm-Message-State: AOJu0YyyJkdfsdHdlTO/5NKRjbVWGaOAlK7DTMJtn3gJFC/CN24JfN5J
	QsneVxfqI40w8Ifb3bSfwgIW+AZS26hvm11JEfC+SHC0nwWih2XoYak=
X-Gm-Gg: ATEYQzzpKYkIVPAiGaMAuUyBoDMkfs6zdfgikrlvakn/6aamqgJ2FmxCiEXSxyLXre7
	EBG1OtCt/+sB6uLgEy4LXEcaewKHOK2p9JkL8rS+FkVNfjhq/BbmxIcn04OV+GfpAQfVxpv3WD9
	iyeYHSDK/ltvQ5ODFDMcLxCtAiq/b+15+gnWSRr1TKdcH4w6wLm5CZA1v7P803oMDaSq/RERJdj
	eiQdVWHhis68POyXaxiLJnJ+As04kAA4Hz+sOSPNfwT0q02QysUWd9aR4rnh2WV107KGSMjT3ZZ
	5N0IlBz+dz0KIWLDPhYNLGa42NMqxaJZz0QRuhjCCi3zSoodEwiuk7SvVNXgcB17LmAZhWxvmce
	68Li08axr9Ttg9kb0Csk0ai1Zaj52LSyUB0YLEgQebFGYViolLUigd8yqI7Cmo96Trx5ZQP4hUP
	4vksWyc8xcuzTq1krm/qq7zb5LMrxFCsi4okCs
X-Received: by 2002:a05:7022:609d:b0:11b:9386:7ecc with SMTP id a92af1059eb24-128c2ecd01fmr4528407c88.41.1773048855740;
        Mon, 09 Mar 2026 02:34:15 -0700 (PDT)
Received: from [127.0.0.1] ([128.24.160.243])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-128d83495d2sm2363904c88.16.2026.03.09.02.34.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Mar 2026 02:34:15 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Simon Baatz <gmbnomis@gmail.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <20260309-tcp_rfc7323_retract_wnd_rfc-v3-0-4c7f96b1ec69@gmail.com>
References:
 <20260309-tcp_rfc7323_retract_wnd_rfc-v3-0-4c7f96b1ec69@gmail.com>
Subject: Re: [PATCH net-next v3 0/6] tcp: RFC 7323-compliant window
 retraction handling
Message-ID: <efe74db7-3065-b42f-6431-c94781ef93f1@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Mon, 09 Mar 2026 09:34:14 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Simon,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal (except selftest_mptcp_join): Notice: Boot =
failures, rebooted and continued =F0=9F=94=B4
- KVM Validation: normal =
(only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug =
(except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug =
(only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: btf-normal=
 (only bpftest_all): Success! =E2=9C=85
- KVM Validation: btf-debug (only =
bpftest_all): Success! =E2=9C=85
- Task: https://github.=
com/multipath-tcp/mptcp_net-next/actions/runs/22844479802

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/82f2ad5662fb
Patchwork: https://patchwork.kernel.=
org/project/mptcp/list/?series=3D1063485


If there are some issues, you =
can reproduce them using the same environment as
the one used by the CI =
thanks to a docker image, e.g.:

    $ cd [kernel source code]
    $ docker run -v "${PWD}:${PWD}:rw" -w "${PWD}" --privileged --rm -it \
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
