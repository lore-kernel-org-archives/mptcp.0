Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82A3278F4C
	for <mptcp@lists.linux.dev>; Thu, 13 Mar 2025 17:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741887633; cv=none; b=lRQ3GNPU43hwAzVsQ3ahVzOg5190SbicwDduSRDFY+BZp+kaaiH6W32AFGSB/a5ixkfRVe/HuUv6f+fD91/2s1GjlkZBW3Lp73GCpRBPn6Egh+/l6byvl3xaNzQl5nJ/4rv4RbvfM56NvqgMiR7raf+xNQPFsrseTAKSB1tbKVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741887633; c=relaxed/simple;
	bh=h7Gpw31WvX4vUZGpu4kCpafOEBexz74srlTm7h4O6Fo=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=lDP2JhZR1XLNSqVLF7V/BkZUEdv24L6F+d/pMacjR54sUofOvC0g6Y30tcq2dJLzXBMGBrJGqyiysVq7X7eLUC7gI9q75S2dEgZZxoIaILplMY36i0wOAeN3vsz10htLlBYWeMv17M0jKlfKLsgIFg9B6CX/Uy677tQG9BRYijA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EDBRSrIV; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EDBRSrIV"
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-476964b2c1dso20489931cf.3
        for <mptcp@lists.linux.dev>; Thu, 13 Mar 2025 10:40:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741887630; x=1742492430; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dRD8WMDe/Vb3xrez7+Fp4EB1Ae7kxp3Xe7PYhYYzTIM=;
        b=EDBRSrIVjSrofGRHdnBiia5z+flw/OCTkWpBxbQXTurQ8pX4z7MlcxuhZL9tSJ5twN
         eW+9RC6I9WgJB5Ws+92wP4AoA3QidEgLRKaX1TpDuuDGcs3pTT46EOk+KXmqUPk/zOvh
         GB5huun9R5rWx2lEgLCwQvvw8lIfOC+xdogKbNAR4OIjSNHuSVy6izOygQWVvQrZ7WPm
         GjxMxSSG9ikQLe5uhd+o2Myt+ghkOWJfeogVWIRUzNcF2drpUhXhCvici5wamtQ5HLio
         3uUd0se36D1AUUJ78O8rM3sbSFdzOCcG72x9h/h5NQ44e1y4zrfiEcrqya0t3HGKjzmW
         OS4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741887630; x=1742492430;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=dRD8WMDe/Vb3xrez7+Fp4EB1Ae7kxp3Xe7PYhYYzTIM=;
        b=tHE0s/p1Syjz2SPCLksj0hb48TMDEwRHPwo+meaKyLW8HZG6N6HBzYvt5Yowz38Uyy
         wUU5yJjx1vxTs3BK7ashBZz3wAM6Ycgv3kodAKNEyS3Z96Tx2Vkx1ufHjFwbzfGH6MkJ
         b2cvjbXBvwARAmmVr/AULX0N0/D+zfKmAJpUu1i+tGz8eI0OYE4q1e33E6f9PP9QrcBa
         6N+rYEXjGvNTcz0Zpyx3QC2DRf0SXGykDXWxhL6priD1FXY/vEylENhSPD6ZvGb9Dvxb
         0vr8u/H3fPIkVa4HLSxpJiMsTw9UG8wlDgLj3X+1bbcu6XGTsSJo3TW03MkPlpBgW5Pt
         V6Fw==
X-Gm-Message-State: AOJu0YyaQAs5IxLEF3lEVR4t+WgPs5MX0btcmEnhhTI2GKA86bMlDx6M
	Y/NwJLJia5VS2diWsnOEXijR0dRP3+6T6ogSFtx/MjL2tASBqYO/laRj
X-Gm-Gg: ASbGnctGgKv7lCnQoGjiQHSONBiQWOj9jRPU7xVNdqDurtFQquTIiuUIjWizNmXa3wQ
	JgvAGheYbU2VW0bjTAmbVpDZU+0FydceitAbCLk98xPiFsM6meN/lv/8c7eGDe+6Y93Rlu0p7ru
	b6bk7XV2B6THiUuyRT5kkBUIlsv67JZ6CNtyhWx8k8EFbF2nwohnL9rQsabF5an3T469t9/UBUP
	JjkTHsLfZN3onfWdTADX/X5Q+p2qnI91E6nC66TYdBa0na/WB2PTI68NzlBfuhXyZrdgU/6KIhN
	xJS/HMUFYmwORFRamBtjzLoQP5w3OgP3InEyGha4Sqt1LvD7rPXHDpDSvnjn
X-Google-Smtp-Source: AGHT+IEaMn0xppG2/Y42O8JRTu4n45YUN3mRz2DrtgfEiDBu0+jyTK+P5/OxmrupxDE1CmL/d0+PPg==
X-Received: by 2002:a05:622a:528a:b0:476:a713:f792 with SMTP id d75a77b69052e-476c6479841mr4081921cf.49.1741887630118;
        Thu, 13 Mar 2025 10:40:30 -0700 (PDT)
Received: from [127.0.0.1] ([172.200.183.145])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-476bb824a8csm11405601cf.65.2025.03.13.10.40.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Mar 2025 10:40:29 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Arthur Mongodin <amongodin@randorisec.fr>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <81b2a80e-2a25-4a5f-b235-07a68662aa98@randorisec.fr>
References: <81b2a80e-2a25-4a5f-b235-07a68662aa98@randorisec.fr>
Subject: Re: [PATCH net] mptcp: Fix data stream corruption in the address
 announcement
Message-ID: <e4e16674-1cc9-bbf8-a7c6-f773b31b3b0a@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Thu, 13 Mar 2025 17:40:29 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Arthur,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal: Success! =E2=9C=85
- KVM Validation: debug: =
Unstable: 1 failed test(s): packetdrill_mp_join =F0=9F=94=B4
- KVM Validation: btf-normal (only bpftest_all): Success! =E2=9C=85
- KVM Validation: btf-debug (only bpftest_all): Success! =E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/runs/138401=
23263

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/2bcfc4be9905
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?series=3D943623


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
