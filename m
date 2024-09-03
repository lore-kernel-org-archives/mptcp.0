Received: from mail-vs1-f43.google.com (mail-vs1-f43.google.com [209.85.217.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE2541C7670
	for <mptcp@lists.linux.dev>; Tue,  3 Sep 2024 08:59:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725353991; cv=none; b=i4apjWRGn+4Dre+027nxzfGiJgSdrVTeA8WffOpCRXsGmtsxNoxgzEoyq7sb+GF7wB+AWSnZ1y385w76mgs89ZPXC+Xz1TXTPbM7yYH2o3aRE77OFBtSVo9TIeoFeUEGy+d6GnjhiqlJ1+kWvEBoiB2Sz9xFBZGq8Hb5Az7bfvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725353991; c=relaxed/simple;
	bh=NsDg/LgDvSN2xaEh+OXgz57rgIvcKfVLd6aOA3UyoZs=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=D4/bWAev8+ofs6vTgsquYr1V7655musNhtPSpZ/5TFrb1vhtmmg1lxGLifTh7MUM5THccMyjoEKR1GJOBqZrs6zDqxAoYKMCPOr4BFcaPgIx1QiTjRJyp0e7OT0aYlIUwuaKlpRR1DKoh49cY3HlkDMloMjn5mbvRfRbRO6f6nQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Rmpw2Edi; arc=none smtp.client-ip=209.85.217.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rmpw2Edi"
Received: by mail-vs1-f43.google.com with SMTP id ada2fe7eead31-498cffc6a9fso1923994137.1
        for <mptcp@lists.linux.dev>; Tue, 03 Sep 2024 01:59:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725353989; x=1725958789; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mIcsY7z/atqwCqjwIC+Z2SvjUd49MyJlUUH9KDX7R/A=;
        b=Rmpw2Edi6NoWGbRjrdvy6ur5rTVMD5tfEXDHu/W3J7dGtPZjAxCF9A4Ni21FCe8C07
         9sTKJtCLo0j0ZF/f0ZQsDfm0L4yB3wcSzhTVwMjBKzUwsIfzQRVhlDuSSlLg+jGnZzPq
         ryaMOTQjgEMF1eNzJGHf/rCGIGOrSZiWsB2F1jsXYmZVfs2jV7+sVlIvQ+bDsMP2PNGM
         7inVO5BbDpKRaCEo3LfjdXTA+Z1tF69SoQ2UEj0quqBUC6Ete+2BEbgBuI98d++xmMl5
         QWDe4NwCnbtw9eyups4/ISKoM5bLGL17FrlQQ2oKdxFoGDKZzw6kfU7tVVs6i7MsNXSa
         6bow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725353989; x=1725958789;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=mIcsY7z/atqwCqjwIC+Z2SvjUd49MyJlUUH9KDX7R/A=;
        b=ojqG/w8Thpmf4sZoir4cfhwdTzFGucacx8PnQuR4BXalwNbTqJiuS2IADUOZ3kh3hk
         oDxIEC877vz5W0qaz11TFqMUFBu7dGacgex1q7dVnEMtsooZMX/oqsADiD6VsrpNEIEp
         dBbw+iYr/E+WXohbaNfQAAov/Xh9MpM66UZyAWV0FkQFDExikCsy/woDS0Fwrb6LhOCd
         kGqs3+HffRiWzWB1rF1kFG1eztIsXI9cV8+VjIiNc8jeQe6zusQA370faCePkfC8gJsi
         OPCPGNl0T6wi4icYJHfJj1nPV00n1yc9OBTJbAGDv5PEBwMI5Q4k/ppLPf65Dj2wafCi
         Xflg==
X-Gm-Message-State: AOJu0YxRtLispuHnITVmDh4qnNqO1SJCKw59so1sWkCWLBJH3cLq+/U4
	yu2qkuaGp95DDE7ofrMJHt/80FWy9QDizRDZazy0jfHyCUPNmByqbdvm
X-Google-Smtp-Source: AGHT+IGVprf0pPzZwiIKP1/fZsmVxisZ9kl5/hux5HlEkfasm2l3gAZ12Ek+Km+f2LoOQccgI5mG/w==
X-Received: by 2002:a05:6102:441d:b0:48f:4bba:778c with SMTP id ada2fe7eead31-49a774f6011mr11382944137.8.1725353988653;
        Tue, 03 Sep 2024 01:59:48 -0700 (PDT)
Received: from [127.0.0.1] ([172.190.111.200])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a806c4cb8asm504129985a.67.2024.09.03.01.59.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Sep 2024 01:59:48 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <tanggeliang@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <cover.1725350462.git.tanggeliang@kylinos.cn>
References: <cover.1725350462.git.tanggeliang@kylinos.cn>
Subject: =?UTF-8?Q?Re=3A_=5BPATCH_mptcp-next_v7_0/4=5D_fixe?=
 =?UTF-8?Q?s_for_=22new_MPTCP_subflow_subtest_v4=22?=
Message-ID: <ef6f32d9-8464-3585-c8ff-a872e63d64ad@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Tue, 03 Sep 2024 08:59:47 +0000
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
uns/10679196481

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/3c23712662e4
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?series=3D886143


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
