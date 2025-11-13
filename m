Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 523A12673BA
	for <mptcp@lists.linux.dev>; Thu, 13 Nov 2025 01:21:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762996893; cv=none; b=KA0Dt+wssjymQbGMvZErx53xF/gy+xMv+rXhofNBahNxAiIzjVL0853jxE2B/V2LD/VM/BAT9C0ndSrv1cmfQMyZJpTgsI2eck3W4IlnnT4srtrJ/Jjn8I5ot7JpFYUSD5B8rQRp53Fp01A1Ao9Jfw7/9mC0ydw1mZBq8eLzTEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762996893; c=relaxed/simple;
	bh=jXohz5mqYdmwHR6jx3fwk5v0ojAJtP7KWhRC/JODlMI=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=U+di5TFDsNeo5wTgaxEu07xN1tgz0DWISO1Z6e7K1kpOQr7FkBpgnDJUEGSSUgDd9b0jFdKV3l0ty/1q3/xWF6DggtuBEFFkhJe4TPqbOHDv6hRBZPP2GLdYvNnqlxq5Dk60y0spOXYuY5Gd9XciGUn+BzTRJz5t7Sx1A4UPnCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MN9q0krr; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MN9q0krr"
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-8823cde292eso3217216d6.2
        for <mptcp@lists.linux.dev>; Wed, 12 Nov 2025 17:21:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762996891; x=1763601691; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zD3CmhRrbnh0g9Cwg5Dl2TjEz9bg1VdRMPWEqodsKyc=;
        b=MN9q0krrl9UqlfGxWZn/spCeOYMuGHto9qrDfoiKF1UXTG5h0E/EHB10LTAWjXstgn
         fBCU3zIKlDeEXASra86orE7Df6vBdJpSUr1CTaX+JxZ5usAF3qqfXgMfPnDZHWcDgxo8
         jtYHCBLeDYL1fsedm6WReIVd4mX0l0T9D7ydEETMgJ/ISIyrgLE0U3/eqTOghxBPD95E
         +ZLYXAvsMjqXD/OTlWMKmyyhk8ge2jaTLaAixqOUqHqqS+dn8yK2iQlVCa48KgzmkSHv
         HAamuY7I2OjCA9zqPgP8uq/Az4v6B1iVqDxaQzbcxbB13LWlGPBKogFsf0arG02DkvQA
         kGzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762996891; x=1763601691;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zD3CmhRrbnh0g9Cwg5Dl2TjEz9bg1VdRMPWEqodsKyc=;
        b=Obdv2Jyhd9jZTDoeJr/lYkl0dMtP8ooi82HKsUxUiTKOTzWh4vM9R9p2suhV6zYurK
         n4bYK1Meo2FsmFxcwBNr9uK3tasgb6h1MeqcveGSTysDQOs3O2KJESQcTNC6ko245XVU
         4gSge7gaxQ8eP2pzPK3/E6tVebgjeS0a1KYvV190ogW7Rj2IEy+G36da5S6Fc36YHZ+1
         IK8XLkMvNJnhfp5nFnc6ahGbFBRjTLQymR+5qRlCRf269HuEjAnAOzRRb8PUFYwEjDrK
         pcIK3PbzX95hUf4DlHcEfWMwtMtDD1IkxPsGh1xqpiy4Ccq7nmQC4cBHNUxTa2qv+cfB
         u6Ug==
X-Gm-Message-State: AOJu0YwSBG7hBfYSD/T9C62ReBRi77bj85yo5PTcqgzV5yOIRzOlEPjx
	Hk0VwSVyqcNP3BrQ8o4KC4gSLY2BK0w51qA57+6jsdhXItnWfZtQmjQ=
X-Gm-Gg: ASbGncv/nbnMQ+1qSIG1yTuvHFljPcMugZQ63+V3TQY4LPbAHRVtQrQE1rGpKCcoZ8W
	6M2J9ChnULDUz0OkS+cYStB0xs8hi6v3y+9v979QapTvW9BeOJ+SVn+BM53l9JiLIElUlkZ72JF
	qVWM4FFXHLYG95zA1TMlvTQxmbenhJO80dGZ/HrGiQby2iOwtRmxfVFtat3KV96BXRyCgSp8uup
	tSnD6paTVBufj92DfKrtvnfbSW3rKuQNz9/ZWRgAudZ3FhWCX3KmkqmrEI3jJ9i9uhQOXMXAyzD
	TJtWjqtVmzmOe5lgqlFicFFiCzWpuzPj6F31b+5r31Xi9J/zdbPYhXIG/C3drRzP53SU2FIRJQb
	gsS1VQl4BnnS3oSqoLrPRuB80JGP018Q2QwyExum/SLKRF0yOBQPY3jtoAdo4nNLdOu/FacbzZP
	JCkYEfRhnlDEo=
X-Google-Smtp-Source: AGHT+IEYWJ4f65bdjNHTeyQQbWch2QaijoZ8hwT6iGdk/klBzKbhszAaIuc5qT8B33MMbOmWF2LD1Q==
X-Received: by 2002:a05:6214:258f:b0:882:3c65:1cbe with SMTP id 6a1803df08f44-88271988109mr90754756d6.28.1762996891174;
        Wed, 12 Nov 2025 17:21:31 -0800 (PST)
Received: from [127.0.0.1] ([20.49.14.182])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8828652b392sm2485166d6.35.2025.11.12.17.21.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Nov 2025 17:21:30 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <cover.1762992570.git.pabeni@redhat.com>
References: <cover.1762992570.git.pabeni@redhat.com>
Subject: Re: [PATCH v3 mptcp-net 0/3] mptcp: cg and backlog follow-up
Message-ID: <3d4c8576-6527-ed24-4c91-b93a919be5bf@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Thu, 13 Nov 2025 01:21:30 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Paolo,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: normal (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: btf-normal (only bpftest_all): Success! =E2=9C=85
- KVM Validation: btf-debug (only bpftest_all): Success! =E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/runs/193163=
83216

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/42d108656927
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?=
series=3D1022713


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
