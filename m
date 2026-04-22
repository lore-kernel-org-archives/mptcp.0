Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 605B827713
	for <mptcp@lists.linux.dev>; Wed, 22 Apr 2026 13:16:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776863765; cv=none; b=qcVIcZzj8ocCHwQVz3iJOvxhKEfA4V3Gmrl0ByruVQAHi3aWkXvLdKmLsplGr9CNQ18SPfVapOH58Oa20TD2WNHulYawPeAI8RDXIS2mXjMXZlsQyY3UQxrqknsdYONkVfsCWPyz7+zg153ZxNDkBWxlPwVXUTSk5vMXFbLksrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776863765; c=relaxed/simple;
	bh=4ZdtPlRofaQMPq2QNylCZ8KJToF//PVvXMNSAq0Sr00=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-ID:Date:
	 MIME-Version:Content-Type; b=lod+p/vi9CNcgT8RZZV2dcjAWeEfylb3ziZO3mQj8bwGc3e1AkUVw2WFKgETcfFV56RjVvOAkcT1eM7O8w/WfoEJ5zJITX6k54kR6wflMnYmwlsw7QLJZWRzv9u3MV7hPeWJus9tBFN9W9Krrg2nrP7N8coVCPmTvs/gFq/RDwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aFcVBChm; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aFcVBChm"
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-505a1789a27so26991021cf.3
        for <mptcp@lists.linux.dev>; Wed, 22 Apr 2026 06:16:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776863763; x=1777468563; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P10M/zrsEeDrWB+feQwa7TmrxbxMzpE4aua19QHMIdM=;
        b=aFcVBChmNfB090Tyq2PS2UNz3kQjrsDhdIuIdhWKL1vT+ponR6t352u3+kEX2G2gGq
         OWH3vy6zDTdYwtjns98UBu+hCFb+UyMJZZCFiFuxThPdBcVItFIXV8LIiBRrB1XCwDqi
         F3m7/3b8l2UxWfnP0yhzgQcQbTbV24mZC3EOqEnQNBZe2fidTJAf7Mho8I0sRk4ShaSu
         AHLlzQ1Bzp3C7NDQr5M65JBsMXHkzAUU8h32XOcMq4AoZfGAH6HszSUGHNeuaN2umknx
         V2l9E6yEYBcy1yghdd+jrLI1LcL0tdt1V4Vqz5coo01XJHKcavfAsgU1QihiOjEXvDac
         tzgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776863763; x=1777468563;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=P10M/zrsEeDrWB+feQwa7TmrxbxMzpE4aua19QHMIdM=;
        b=gsXfYzITvqgbVvMtf0OgDcON6hFfXH5laO+twUxNU2trE6e97e8WbucWnjxXLPJ5dp
         w46qdBiBoX0M0nx3gUn+iiXN4pocKS2JsztxOZ1hsJhfkh3SOPPbXy4ITjEfWy8brv6+
         kJsj1bo4fhSmfx4VJZ0/7bBKDPeNcoymzcETIiZrDcBUisdPwWIAZ8cQXMQQl2EyVPyG
         9DSq/zo4GSscm/9d6LtRUNkz1j8DiXZ2TlRK2Ux3yIarghRcoGlp7fNZiJhWJNdNsDGo
         yueCnTZPQREB7HPUF7klLLVF6dG+y3SklEBETRD6asPDEqTPCCBwuYqvSr3pTCL9dG0G
         ET/w==
X-Gm-Message-State: AOJu0YxJy5G0L3vFZIIRrUUPEPuOxvuWgTHTzFJdHPynBRxURrjWDQlk
	c+9ktU7+PVIQM988Zejp9ff3wtDGJpoedPq+/AgPhZaEfsV3X4yMXT4=
X-Gm-Gg: AeBDiesYXFeluD8hX0J+klT0B6NAOp/9vsxi11SrtWpPEm32ALojDfWMPmBPVEeJ85S
	qF84c2qwtXW/p1ovaPaj30DKhEyYpAUjrTtL2CtJq847DZUp887Xr5xfWZP8pwgONMFwdnWC48+
	XbIVWmYugkIglJkNjJ+BR1WbQ8ljneKrvrejuxo3s5SqMz5uwqnSxUtovlpTOkAE30KOUSZQnr9
	6Hssx3nkY56bzgmFGRCYuE3pUEBpSIa6c0q32mA2T4QxENJ1UZWk2Usgn2Q1/fTjfFwBQy/9a3k
	WM5leHwRZBPcrwD2mZd1f2kqRLZCC3IxHlAUVPD7NQirtRw8fLnMIoVQC/sO1RBiY/RJg+B/llJ
	zz5bhM4xonYm4dP54v89JsMSV/jWnKlT335CokHuBTNIGbtTsZ5+0yZXOZhcvM39UONwzGF0t/p
	PNbalRIKU7Q9EQiSfrYqlfWZWzQ2flRp5N9D9yi1fwf3u0O5Za+A==
X-Received: by 2002:a05:622a:65c5:b0:50e:5a87:6bfc with SMTP id d75a77b69052e-50e5a87750bmr113375151cf.24.1776863759863;
        Wed, 22 Apr 2026 06:15:59 -0700 (PDT)
Received: from [127.0.0.1] ([172.183.157.177])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-50e3945ae5bsm138756441cf.23.2026.04.22.06.15.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Apr 2026 06:15:59 -0700 (PDT)
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Shardul Bankar <shardulsb08@gmail.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20260422120954.8877-1-shardul.b@mpiricsoftware.com>
References: <20260422120954.8877-1-shardul.b@mpiricsoftware.com>
Subject: Re: [PATCH] mptcp: do not drop partial packets
Message-ID: <4e9538e7-3a09-4423-4b81-6c9bc663f0af@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Wed, 22 Apr 2026 13:15:58 +0000
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

- KVM Validation: normal (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: normal (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (except selftest_mptcp_join): Unstable: 1 failed =
test(s): packetdrill_dss =E2=9A=A0=EF=B8=8F=20
- KVM Validation: debug =
(only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: btf-normal=
 (only bpftest_all): Success! =E2=9C=85
- KVM Validation: btf-debug (only =
bpftest_all): Success! =E2=9C=85
- Task: https://github.=
com/multipath-tcp/mptcp_net-next/actions/runs/24778310704

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/46be5a27087c
Patchwork: https://patchwork.kernel.=
org/project/mptcp/list/?series=3D1084260


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
