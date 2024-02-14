Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82B731B7E2
	for <mptcp@lists.linux.dev>; Wed, 14 Feb 2024 20:50:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707943848; cv=none; b=H/16QW6ZTayfi1YiPayXttcNB1CWAW1fO1KDJd4wCQoAQbpI5jr6n2XXOT2Oo59aUjvssKvcfQg89ai/242ay2i00sUyRXDv5oiAjFFn0mChgz8j6THTwaSmumqnsSYRd/rW5nB4AR3mVA2VsjyUZrPeBaR+7dHwsWM/LrNM3nM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707943848; c=relaxed/simple;
	bh=yHRKx+4pLYDF7q/gBXvBZS2JASXVsrF4xx/jYreKqOc=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=oYLMTeLHOaKsYCix44GOB2s21wr92QfuAatXifBfh7la4EVjxRmX2FDJR06ZBZ8vMPvczzEJY8L22pHl33mFP5kdQIvk9O30J7igw2Zd5UbPlKpLekd4yjFDOJ4pebpdTJv12CWdFCQKnOBUC6vgi5DtH3OZucJ6Jwxgy/ENdfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nHmyRi2K; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nHmyRi2K"
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-6da4a923b1bso192028b3a.2
        for <mptcp@lists.linux.dev>; Wed, 14 Feb 2024 12:50:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707943847; x=1708548647; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=it45f2H38yJylwYRKQFuLsXQjpKOpbWg4YtoUWpyosQ=;
        b=nHmyRi2Kzdw2c7qM+/sOF/bwtNU4CGbKRhRaNZ45dLUeTZUglC//Qc+ZXxNthpaU+q
         58Ht1rn14+3MGdLJyBR+ChtJryJyKYGG9yL+oTLlUbDXHCkF6PY7R9pHKjLxBuxANVoC
         f2J+Q3LpmLYRBcAjbyObybOlpzsrJtvSUBImqnimJsqv2Rl4pPpJ1GVgi2wufEMhH7dd
         tSZJ/J2UjBD0NIggSTyG+kOcKKM4zwIpSBduN6ivM8+N1lYig/6JcU4VJEZvKdynO/7t
         BAQSo+haiKqxMzFG1PFNwH0AHYPuzcC2rxroojVZqUFMtuuCybiX+lSKEwnE02w68DTl
         8/eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707943847; x=1708548647;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=it45f2H38yJylwYRKQFuLsXQjpKOpbWg4YtoUWpyosQ=;
        b=lRYTeVfxvIQ3/+JEDoMH7mJh8Jd1HdHwPewsfGKS2BcPlSQsn8AukD+6mXWIH3N0rz
         57SUgM3k+QPA9+ltBU1txAsBo8VWLMQrMhxR2NGt3qXWvFFm+9nVCIuoQebbQw1MZ1p9
         PeW1U5wFpbdS2m3IVEgg+96cyq3cpLhDonyWE7+iPwi1a8Oey0AYPkl/eKtCrDybQXIF
         LgKfNWcPtQT6t/3sLR5bFKRq/WVRoMFqpFJCoOcai++0gW41b54qxzRiHDd1rwfbhd38
         5C8nlE1mqtV9rxBdet48IXJGLNIbXCAJF7jiplmX0xcIt3DgFXsSmlGwAiXTMaV0e0I0
         z6bg==
X-Gm-Message-State: AOJu0Ywwq4Y0aE6aYZ95sRFER9kp3qWopaDxiH0SndjrQMUeEeni2GOd
	xv1b54xvb0OWPOA+3OPiAULQfEEQ4jmPJXK0LCvntH5FfOWMGeM=
X-Google-Smtp-Source: AGHT+IGy6bGxwNNnUoz2MoY23hj90XdBSNNoViUilKhirTALvdS62byrpYNiyl3g3Y3K7gkqI/jnYA==
X-Received: by 2002:a05:6a00:3012:b0:6e1:1451:2f0c with SMTP id ay18-20020a056a00301200b006e114512f0cmr2272771pfb.3.1707943846637;
        Wed, 14 Feb 2024 12:50:46 -0800 (PST)
Received: from [127.0.0.1] ([20.172.7.2])
        by smtp.gmail.com with ESMTPSA id j25-20020aa783d9000000b006dde0724247sm10045219pfn.149.2024.02.14.12.50.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Feb 2024 12:50:46 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20240214195407.3175-1-kuniyu@amazon.com>
References: <20240214195407.3175-1-kuniyu@amazon.com>
Subject: Re: net: Deprecate SO_DEBUG and reclaim SOCK_DBG bit.: Tests
 Results
Message-ID: <fffdc00c-d359-9fa9-0295-c679d4ed7760@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Wed, 14 Feb 2024 20:50:45 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Kuniyuki,

Thank you for your modifications, that's great!

Our CI (GitHub Action) did some validations and here is its report:

- KVM Validation: normal:
  - Success! =E2=9C=85:
  - Task: https://github.=
com/multipath-tcp/mptcp_net-next/actions/runs/7906812299

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/a36a5e8538ed


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
