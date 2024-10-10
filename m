Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E398619D897
	for <mptcp@lists.linux.dev>; Thu, 10 Oct 2024 04:38:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728535115; cv=none; b=YJl+G/dn7PBcy4trRIV+rq2un9Ds9MFfgbrVMMqwl5SUIfrF/6EatLcYrDqIVmRrPf9Kv2zBZEqP/+eRHjJJ75g1BdrfiLzmKtvLkz9uNXG0q0NIS+TIEALBkWudUfX3RTQZxX/n9tM+ucNbNVE5Fvp8wzUd/6cdkFhioC7QXCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728535115; c=relaxed/simple;
	bh=gUzhSmU2mepoXeBpXB2QF71LfprCPAhY6az2dKmivUc=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=sO8iNUyW2chnDTE1Xp54DN1uTnBoyLVHc2y2kr2RN1SJreLfDm6aTqmcgCcsBWDug1tFYjw1nJEYcU+wnLnL18pj9nIlvSnHMCUmTc3Z7b2X7NhVj1624EZVaMljYuqU2Xw6LYiizBYWBVzqj3lTtbY9Hz9MR+8/dci5DusXBZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Vw9Jyl+v; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vw9Jyl+v"
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-7afc591c69cso28243485a.0
        for <mptcp@lists.linux.dev>; Wed, 09 Oct 2024 21:38:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728535113; x=1729139913; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MclexD9FS139QMPKyLcnkqOdBfzdChHnJL7mj07Tjuw=;
        b=Vw9Jyl+vU6XfgivkRJwqECqg7TXXpJeiPuDf3CveXS6s2uXetaJFwza8m7zU2Obdyf
         /yIoCmr4EsRRHGLpXvjsV2TJE8+zfBMRKoin/3ll+TsfosTy8pX34Kor0SXy32dMSagd
         wqjGjv37lTZtckEaoxpLFHNlCNdr55cPfel2/cj4mrAc0d6aSrqNI5YqSkubJW/d8v9v
         7A3n8MKM5XyOGc3vmcJlCbkc586f/bI4DLQzvCpvmj4x/89OBOT0vC055KOsfvx1naQm
         bKIC/7RYofbQHpI1RYaGtd9T43uBoBZqiPhrXA9nxRfTMO9UN12+s+JS0u7GE1Axk1ff
         N7UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728535113; x=1729139913;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=MclexD9FS139QMPKyLcnkqOdBfzdChHnJL7mj07Tjuw=;
        b=miIihMweix2aIg9yQcXx1VndMo8BEF3DUrPU2kE7csHIzaYp/9/xhsgWZTxYJnEZKI
         q8gM77gxD/KAWirJDEx4Pjqt8gWngldtLVZl/wzWPCbO1CyKG22V6WI8H3qxmxi6mny0
         f2IDegw2C3bW+8p6y8U7KR66NmZLDO2lM6l7HWmy0c/HvkX+TgJVITE5JILQPW9FO7m5
         P6x9DanZXLx6uJO/5pJ2UFIGg4hT+W/MXfx0fm5u3W4QYUxAyqidfFLkeM3SPDYh0yq2
         3cQigTmryZ6D9wCJDg9/QUsQ44rIX31l0RoPxNazm2D8zCQV6DvZWLP3yAqPgVATNNS/
         m+dw==
X-Gm-Message-State: AOJu0YxtRzsda2990CpU6KJpgvJ98zwCyDNu79hDqj7WltLy2oX38btc
	Cshpg//QLUMfukxZQ2fj0HEee7eimVRBJ4fq168CMghUuG43ejwqZwxX
X-Google-Smtp-Source: AGHT+IGDpeBcUT+dnlDKgrMvsRnO8hBMHUHBjDgurtrNjzE5lKxDbezmoXDN6CtVDYSDKc93oegmtQ==
X-Received: by 2002:a05:620a:2492:b0:79d:759d:4016 with SMTP id af79cd13be357-7b111ccb906mr300041785a.11.1728535112543;
        Wed, 09 Oct 2024 21:38:32 -0700 (PDT)
Received: from [127.0.0.1] ([172.183.91.53])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-46042804a7esm2056951cf.51.2024.10.09.21.38.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Oct 2024 21:38:31 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <tanggeliang@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <cover.1728530836.git.tanggeliang@kylinos.cn>
References: <cover.1728530836.git.tanggeliang@kylinos.cn>
Subject: Re: [PATCH mptcp-next v3 0/1] add netns helpers
Message-ID: <4e8a0a18-d9d0-2b8f-d401-9c079947dfd3@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Thu, 10 Oct 2024 04:38:29 +0000
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
Success! =E2=9C=85
- KVM Validation: btf (only bpftest_all): Success! =
=E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/r=
uns/11267085466

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/ff5b50d17a96
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?series=3D897427


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
