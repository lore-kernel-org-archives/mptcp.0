Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4B2C433B1
	for <mptcp@lists.linux.dev>; Thu, 24 Apr 2025 11:53:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745495615; cv=none; b=k9wcSsDXQrIqLI4HEi+cCNAm81N3LrznqGHhpTPhGn07zOKSbzc+dPEaOpl3TLwKRo+3YFj7aGMnvFX7Osfh+mzqdsjdEcZC6rEgYOcs5AtDvJ/djbFuvAxCSdBze3SCoQVCGtscdBQ7ZaGMQdBPOa/7xzc4u9Rja1d3q3dK0P4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745495615; c=relaxed/simple;
	bh=EMiunERA3W7MQi2WIgExPE+bA/TjxPcCIhajkiugfD0=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=i0U5lNutUMrb75Y7PgXa9x27EN/qCpFXldKpLQCx6txNVGGpPMeHVLlOfTUVI7o7+PCtf517DRKY7Wgc6F3ejrrf7H0PW2dKfxthbbPcui2FIawVYfV/3PbNkm2b0C3KuyOPLFS2L/jT/heKDKqGc9EiCJ3RYtmxY1gEs0AgPEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=etAR2CgO; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="etAR2CgO"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2260c91576aso7018805ad.3
        for <mptcp@lists.linux.dev>; Thu, 24 Apr 2025 04:53:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745495613; x=1746100413; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KcZt5z46vrUef69lXkNIlGN+F7G3V7dgXsdqyHtMrA8=;
        b=etAR2CgOhrioq4MIAFMK8q26Bi04PRz48R6L6JS0DiOu2P/ibvXb6/MJ7gwl0Z9bEm
         rEKzsgu374Bkc1/vviigPjGVttIz3NcCGskge/H5ONqw5C9UMIo6W/zZp6iJ5gHRH3x1
         26Se+Tm49S3Td8YQC4GRM+X8kLFXDEyrB8d5w+yrsTxBEO6TjCE2AmdCmF8z0303xTn5
         8dQPuJ4XjiePLr6HO8k+/j+sdTxBZLktJACS2/gYMUY9z0hpHTb1EXx4Srafe6LtwvPM
         8VFEvzKAFLzziSH7LXe4+BNqu2twSpsBi4ei2HLitcij+dKzkMm/RBCoDdHbZ0qZ4ziv
         +CQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745495613; x=1746100413;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=KcZt5z46vrUef69lXkNIlGN+F7G3V7dgXsdqyHtMrA8=;
        b=EjQ+G6YiUigOvMpn/q3Gvs4ei5z6GYMxCTy3CCPhXdo80qBZYwO305ze1vl1/3BlaG
         91Fq8y2pj8WGoB0UgMKKqWvuwbAKr3+JgxnGZ92HYB2kRzRTYCwV+1Dcu7GjdUqewGm7
         KS5ahvY0lx5yAIdr+HM4/TfvS325VZ6fVpkgl3Y2WQIt599eD8NlhuaPvh2Y5yqYNeBF
         RG1hGaovlcJ8q6IGELtT0fV/y6V02SxY1Ov+iZ5TGIaO61YvxSat1mDR0V6p5CvMGhn5
         dkwJWAyQdHwHSVekpVCmQqWNhUhxhbhdmD9ZwkJv6vcm9U95UOh6dxYYwfO9G2GxJGCJ
         JJsQ==
X-Gm-Message-State: AOJu0Yw/UKDc/ajEWUHDRpFnNQFHfnMDUajkUOWjiOLNzbxerZ8GRq3z
	jbA730Ty0lhFAbRvvrvURq74kZjOShKgCi6D3On13Ssrl4YT2EC1pGBp
X-Gm-Gg: ASbGncv8zBl+63nOJj9GAKFTVF/991w/KuiqEqLXisp0OgC77NkCc4jtoP++XL+MBr7
	QdBkDuGjsRd9FUIDONQPuKbtVc9Kqu51B6BVHaFj7xTHGozWz69HkvtkQo7MBbfNTukA4FCjwhj
	lNBUN3UGjAKZPYBIXMkd3lXv1CkzXGNLa77+fgqQzWk+112V4J8siae3O1ZaGaOxnWPuYoUjpSe
	E9OCkZhpSv0lJ4JRe6PBLtZ96YeRhAm9d/UZBCZvoV8Qb54qrYKs5NHb/NqGvK4/ZSD2cnQerul
	18pAKgZ4dHJpJNptkXw9MzdGvJj33w5jui5RGZiRqZfzz8jhwA==
X-Google-Smtp-Source: AGHT+IF8xuRUe81rZ6y25YOWIZ4OigTB3F3ZN5dX9j4UYV34o0tpud4t9JLiLCDK5goBWvOpjKyCOw==
X-Received: by 2002:a17:903:3d05:b0:224:76f:9e59 with SMTP id d9443c01a7336-22db3bb695cmr36244935ad.10.1745495612513;
        Thu, 24 Apr 2025 04:53:32 -0700 (PDT)
Received: from [127.0.0.1] ([20.172.4.1])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22db4dbbdfbsm11240825ad.62.2025.04.24.04.53.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Apr 2025 04:53:31 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <tanggeliang@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <2fffe8798ad6d171110d5677b02579dab9f4cecc.1745478757.git.tanggeliang@kylinos.cn>
References:
 <2fffe8798ad6d171110d5677b02579dab9f4cecc.1745478757.git.tanggeliang@kylinos.cn>
Subject: Re: [PATCH mptcp-next] mptcp: sockopt: drop redundant
 tcp_getsockopt
Message-ID: <f9b9797c-2a23-1493-07e4-95542d29b122@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Thu, 24 Apr 2025 11:53:30 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Geliang,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal: Success! =E2=9C=85
- KVM Validation: debug: =
Critical: Global Timeout =E2=9D=8C
- KVM Validation: btf-normal (only =
bpftest_all): Success! =E2=9C=85
- KVM Validation: btf-debug (only =
bpftest_all): Success! =E2=9C=85
- Task: https://github.=
com/multipath-tcp/mptcp_net-next/actions/runs/14639391824

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/ece539c873cb
Patchwork: https://patchwork.kernel.=
org/project/mptcp/list/?series=3D956476


If there are some issues, you can=
 reproduce them using the same environment as
the one used by the CI thanks=
 to a docker image, e.g.:

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
