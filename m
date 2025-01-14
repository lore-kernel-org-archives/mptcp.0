Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5381E18952C
	for <mptcp@lists.linux.dev>; Tue, 14 Jan 2025 18:50:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736880623; cv=none; b=kGRXi+9qGlE34kUP7ZSupg4M7+z11w7BGrueg+jUpf4evEupwdm1yCu8Y8ovwQTw5EUv/U9htr79d9NlSp/tFX+vXsF745TTgaOSlEC+ZwpsuYP+LHvGE7k/Oj/vbkd8uU3ot+pS8R6yUAq0e6ADqD7zkGQdNVefBXVPj/p7dL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736880623; c=relaxed/simple;
	bh=LxtH2RaaB6f20QHD9+3IdgZ4dPWaBCo70azX+asNtQQ=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=N7OsVySagfrlm+6glQzycnyPIBEFySCnp2n+CzCRJNZhqIyWabiklCbX2Ff6p7sQL9WsACD+1fJLH20kh1BEb/9rWRuJD9RYfJOXRQXx+ZVV1MSgwdTZAasfvFHlDQYPm0yplZIKRqZMpEYBID1Xu8afP5zXTx4zFrQC9vXbBTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fwFITIXt; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fwFITIXt"
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-7b6f95d2eafso619510485a.3
        for <mptcp@lists.linux.dev>; Tue, 14 Jan 2025 10:50:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736880621; x=1737485421; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d3YneaHVyH3lNO3bGb0s/w8CB2AxyYgB6oC+HGX3kRM=;
        b=fwFITIXtxnzwboY1lv9BeORbT2Jnty4Fi6a0mLHXAeYUZaUg5LOlEPxaQDH9+0/XM/
         DKJEHlI3Qedr0JNVwnamu4Rq2kBUgum3GUueLHMvnaXpT0DZkLwSDuUUDETA55tc4ZOs
         sTEsZiwwSFJEArSfw1MPZtRu0bJE2mIPcTFy/m1S2QzJt3eVU18BUs2eMLoZo94+va6/
         r28Lfx1F32W0g7PIw4nHtjj0LOJ4ynKWwK9poARaYIGGCQFWWDAtbr1bS3EutOgkVVQe
         yiJ7wdfxIhmBZz1cXL5YIonKK1g8M/HYuiVWqzeKuNcTyKNlbtE8fvD+KRozhQ4GS4P0
         y12g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736880621; x=1737485421;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=d3YneaHVyH3lNO3bGb0s/w8CB2AxyYgB6oC+HGX3kRM=;
        b=nLEb/H+tZDEjkKwylR2tBU6quoCMdEHKMKbEY04t33Lj9U5eiF+iSHYmhz24y3orgJ
         9E8PqFguzLSP4KSs7mz7ec9yy1pKI8p6qAA2XpjT4IPyqYBmq7G9nkz2zaMq9tqPs2c0
         VOBNLLScl0gNKZ9Xc+/3xFQX98iC/lvgV2bC1DbGDSbCH2g5NDsoy0vrC+egRjQf2FOY
         9fRzCXDwVh7H8Wwnx7OYxKP+wz0SRwJrwLSQEGksdmtBFRoguMehauAbv+f8HU98GO46
         lzj3LVC04jfySLClARSc3rU64FxgIaLKZE/KLrvfoNShA8yD2w+88pUI5tRqZf8aVW2u
         CihQ==
X-Gm-Message-State: AOJu0Yyxd6cxT7FV9e3dshXDikDUpGSKytFcvDc/ejPS+xqlp5LXUggN
	Kejz+ocDp6RRxHgQ6fFweKueOHosLFeUeljQqLCAh03AQupVayA=
X-Gm-Gg: ASbGncv4Jm3WRuB/FZumyUO0qH2lA+rMRLd80NNRnMZa2/zH03FQpV+OAKRcTKlGlnz
	eY9jV9ocx9c3gm+9ug9maNteCF8aU16zmze2SBPxyi57gnA8CSytMBb7qo6GtpvvRBSbBtz53Kt
	jlUG+boyaxcoxF4q0jm2FaYhDsabJcuQIEfM8vpAqPE9GLF8jSeeFQ0S2QkacduxYihusFjCJ0v
	EOm4ejTj7ozLTKGnfDnnfy5Yt+jMiD7Ns4A2EtUUdNS3pjLejh7exnrkaOSCo7SGnbs
X-Google-Smtp-Source: AGHT+IEML1NN66I0R2I3L+bf3AdM4TWomx/gqt6fZ5sqA12BzCBPnvJUt6AlgszbY3aLEawrW3RJTA==
X-Received: by 2002:a05:620a:40c4:b0:7b6:c486:c4f8 with SMTP id af79cd13be357-7bcd97158d9mr758182485a.28.1736880621075;
        Tue, 14 Jan 2025 10:50:21 -0800 (PST)
Received: from [127.0.0.1] ([20.57.78.114])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7bce3516004sm632730385a.101.2025.01.14.10.50.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jan 2025 10:50:20 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20250114-mpc-no-blackhole-v1-0-994bd2a357fb@kernel.org>
References: <20250114-mpc-no-blackhole-v1-0-994bd2a357fb@kernel.org>
Subject: Re: [PATCH mptcp-next 0/3] mptcp: blackhole: sysctl SYN retrans +
 fix conditions
Message-ID: <6ee3df20-d91f-0022-6f86-c25fb435602a@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Tue, 14 Jan 2025 18:50:19 +0000
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
failed test(s): bpftest_test_progs_mptcp =F0=9F=94=B4
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/runs/127734=
81101

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/f4011cb563e8
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?series=3D925349


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
