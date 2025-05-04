Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88083156C6F
	for <mptcp@lists.linux.dev>; Sun,  4 May 2025 11:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746357035; cv=none; b=HXpjMZZCkJKEx0LFUAom286cHYNwyGPZ6PWGqgluomWJp9/EVhFpHOBTEWrRM7ZKn1AV3Ic95+xriUocAWBQ2ZLNOpogYZz/AGMJrB9zm1Wkyejv++e9Hl/Ab1U8n4sSIQzo1p6htNklSTSdKjYIPADc2o/o7Mh0C0qwDsv3SxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746357035; c=relaxed/simple;
	bh=Z6PNcfuXoJL/2Rn0g+jA/be0oLYmmAPmCnK9qaqoatM=;
	h=Message-ID:Date:Subject:From:To:Content-Type:MIME-Version; b=bgKIdOVcnDxmnZHsVMrjWNyAkzZg/S0gNxMGT+2lQM+24n03ejqVoDG3EVs3/zxYX9py8hRtpcdWaSAhVHwMhzHf2McaMqqVDPG1MuBUuxNSHVLXQ0QVRfVtiHH6H3IV4+n/0G2uzvNo0QcF7iY3e7Uvd2T7jRULTFUpczhpjFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GJdJNRCt; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GJdJNRCt"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-43cef035a3bso20734255e9.1
        for <mptcp@lists.linux.dev>; Sun, 04 May 2025 04:10:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746357031; x=1746961831; darn=lists.linux.dev;
        h=mime-version:content-transfer-encoding:to:from:subject:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Z6PNcfuXoJL/2Rn0g+jA/be0oLYmmAPmCnK9qaqoatM=;
        b=GJdJNRCtPrhaNV8fLc0TFW3kK3uSqLpKEf5LSv5230uj8y1gS8jQrQDKe84OGUpe2z
         aqyCilC7zqR8lsAA2M8HnFyj44JQaQQTEs/Yafe1ReQzXZctXUbbQZLvoebOUA98uufn
         g82/QkdsGun56ZDktX2pM++4IvoKta3zov6Kb3uWjA2of9X2OZ/1XdKJsTGljhrWc0CZ
         1UZu4VIeTxcF4HjBgrJ/AFcGlSnQMiiwMfEqfsFUyFKd3zOg8ldG0N+7MNZWkhm4Ouo5
         RWH0JMeLn3YiKvb/5jBOsHWI6IrULK34i9OE69v3LTLev73WRJ5+rb+vtt16hl3dQ7kS
         aIdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746357031; x=1746961831;
        h=mime-version:content-transfer-encoding:to:from:subject:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Z6PNcfuXoJL/2Rn0g+jA/be0oLYmmAPmCnK9qaqoatM=;
        b=Ah+PC/l8Hfa8liW9HTZFTBZFP4dIhRQvVuyaWmCKJtR2zvw/eLdikSmUuNFTxhK8BP
         0gGQTwG2PL6fPD1pfghZlQ9jqu8QNkVXszID54NaNxegQYp/4Z3czUAJmm/jlbtvHMEV
         Jinh64M0LocKoUFT3popcU4M21KOTAwj6wLuP4/iBB4vD0H0zKusvBaw678wzlVbCoji
         XZzb7wLxzfvMGpp6y4v+cJQieThb56Ld3JEVukA6cNG9mCf9m1O+unpusdDY5a7bfp+d
         +rOI3zRdMkzJZucdv/9VDEYuNEHxC9uTmrcSFwO2/UsHStEk3l21VozTWy+EZtWMxBUM
         exsQ==
X-Gm-Message-State: AOJu0Yz1wX67hjXONgN9DP0AOn945fA2BaOARYR4m8QhHuSc40nD1MQJ
	ThiVyK0MGlr6eqcjo6xu7PjyXrsCVlZmxSq5yNoAkIgcbRnuop9I4JZa9g==
X-Gm-Gg: ASbGnctv+3JIkjFkEeVSxme7KmN2LQcTUgtvfgxgmAwHImusb+TxIqou7qQDZwUPXU0
	HmQlmTiO/humtN29qdnq+4ki7Xj3kEmJyNgw1GyrCnyQFIpV8rzRmSWQxkT/ugXRisR84EJQ55R
	CI+P6n1V287mKVEOIm8ZsB8Jifgf6VrDmhp6tQrb6DaoPPFPxIBcknrqDjby/bsGYMpnO0B0SRe
	3TrKHE/1+3GUF6izxqb7OSiFEb2ErrdcsPSeTMMqy1uJSeRu4qWpO21/k3CaAVi6PRbj4hEdGQX
	fTCi+ryBx+mSmPDJdGtPacTGLy2LPkHLSH9NseRRNvAS7THIGtp1GWc0vWjABr3KZIY9IA==
X-Google-Smtp-Source: AGHT+IGFBfD1BaFM5imzWw24hkvdKsa2cbrWzEzS231q0CZkvDHo0IseJohC4NrbCoYbmjv/+Te7YQ==
X-Received: by 2002:a05:600c:820d:b0:43d:fa5d:9314 with SMTP id 5b1f17b1804b1-441c49472dcmr22569395e9.32.1746357031430;
        Sun, 04 May 2025 04:10:31 -0700 (PDT)
Received: from [127.0.1.1] ([39.51.123.71])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-441b8a31695sm100304735e9.40.2025.05.04.04.10.30
        for <mptcp@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 May 2025 04:10:30 -0700 (PDT)
Message-ID: <68174b26.050a0220.21299b.244f@mx.google.com>
Date: Sun, 04 May 2025 04:10:30 -0700 (PDT)
Subject: Security Vulnerability!
From: shhresearchers2023@gmail.com
To: mptcp@lists.linux.dev
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Team,

I am an Independent Security Researcher running a vulnerability identificatio=
n service, and I accidentally found some vulnerabilities in your infrastructu=
re.

And it can cause damage to your website. I want to share the vulnerability de=
tails with you (includes POC, screenshots, and suggested solutions).
So tell me, may I report here? Is there any appreciation reward for a valid r=
eport/bug?

Kindly respond as soon as possible :)

LinkedIn handle: https://www.linkedin.com/in/huzaifah-s-948a26bb?utm_source=
=3Dshare&utm_campaign=3Dshare_via&utm_content=3Dprofile&utm_medium=3Dios_app

Regards, =20
Huzaifa Shahid
