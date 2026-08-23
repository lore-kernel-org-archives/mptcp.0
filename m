Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8100835F5F7
	for <mptcp@lists.linux.dev>; Sun, 23 Aug 2026 02:15:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787451314; cv=none; b=OxtAlauvKYUFFhXcsw+6pBwAGZ6vBjWIaL/UbOeKM7V2OGK/1Zns5jcVRlNfmYSuRMpwE4eIcWRVAktV2XIYLFlUPn4jIrezoHy+CUd7pVU8L80/7GBZ+WSCfu3ZdkxxWhs8rY6ykvi2nn5Q4Dwla7itNxVg82nYo22RQ2Ci3Uw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787451314; c=relaxed/simple;
	bh=uf4PJR21/hyPoWX+RoJOSnaJRlYa+9TFgN2N3hsX2G8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-ID:Date:
	 MIME-Version:Content-Type; b=FbH8rz74TNRLhKXTCdyADlpat94ZkpcgXYJS4pKihApYmHunPXtgy8/9Svt3gFiaeEdp5ffRan1aUzZ10ds01to+2m7s6tefJR0qporLIcKeDNQBmpwiyqP++EdkaU4WuZF7XCs0yLaYcjfIPgsDGk/5rYZg/j4NldLrMwLFvHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JSoFV3l5; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JSoFV3l5"
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-38e347638adso2011803a91.0
        for <mptcp@lists.linux.dev>; Sat, 22 Aug 2026 19:15:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787451313; x=1788056113; darn=lists.linux.dev;
        h=content-type:mime-version:date:content-transfer-encoding:message-id
         :subject:references:in-reply-to:reply-to:cc:to:from:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Ju40dlmhoVLV3j8Be7jqp7IlBKZLxjc4zdydPaaweBc=;
        b=JSoFV3l5QSXX8AjoiJeq8XZ1LWfRs85O5vvwxZG1rIMSpLsMgv/+xCxTklV1OlS5x7
         XFcqE1Yw0AGT1HADI9GnNaf2OeGwC4ltL2lf5ik9x/D8SFY9NgtfCZ4j214kVH3h53ls
         utFD0Od5cZ8VaS+2q9FT+LriPioqBxpJRAOwZxPXk8Wj10wul3piWo5sSWsTrd/4OOr5
         7yO4b7ZCotiSTD1UiQjXuMEljPRww/RNbq2TRzcF1vnLvd/ndQdA+Wzy4h9VdwwZGaU0
         xLDeNMgEjqhND4O57OrbtX+IWXQx/2mnakX4B5zGlt15S4BM48qn723dPdefpdrTRaTl
         E7qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787451313; x=1788056113;
        h=content-type:mime-version:date:content-transfer-encoding:message-id
         :subject:references:in-reply-to:reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Ju40dlmhoVLV3j8Be7jqp7IlBKZLxjc4zdydPaaweBc=;
        b=VUZXXZYCnX1NETK0R1TuF/PpJk80xjW5MuihR+Jhg0YwmyrfzFjDEsDuQmUVbFRxvf
         6ig4k8KWx6mC7ZKPt5RNX6ooTsYvqTxJ3C/JBXGra9i1i6Uht6eZ8bTLODfcNEL76Wot
         i6blfP6IX1BkDBYWLG7zzzlN25zDDrMRyNH3WocNiom89lmAU2c5HRfC3ZURbenVczpj
         5j8Q71FBQ6SsQbQXZC7ItcGZ/ozioW7i9YE9Ba4mB2Ubcq8aZG3wgR8X2X5f57YNk9JE
         YNu+ShzxINjYXauWW9mTAFU+nJ8oVuAeUtbKg8/K2rSALD2w5BattXJ9TuIa06MCIVg+
         /YJA==
X-Gm-Message-State: AFuF++mS6nqrAWy4GLoktpnII+zpEmiGSjDBtGSEKcY6Lu8BDlCz3URq
	BCuysp8O2yDYxTTP6Re2IV0DcU2p6v1iti2An4/4Ldhi0Vw2VrhiYgCLjaKa
X-Gm-Gg: AR+sD138HIu+B09ymL+nfFzWuL5f7ymKpT2nrwuidgT9/M5BQ33LW4aB1Wbgx3XiEb9
	wlt7ILNZBJC/MX3jhAoYNveb066xlSXCsW7m2jTy6v1axPV3RSfBnIZBkrTIQ721PbblgDXPIe9
	K/IPOCtWpMlq0npSPCJWRp/ywrJ2y5Pn3O4NzcAc9mSikmChpZG32x27Rxavq75m2O4IrwxqOoU
	o/OiTEKU2Kew0aqBfD5XGeulmu1WqX1+oB8d9ibl1u/WlvxSi08YW3W5wJK44tXofz1aYzuOiBz
	GUlmjwlcyZYLPyR3IgS4/uN5THfaXlb7MblaRC/HzVA5CZK3p7BCckLhtlYx393MShi7rgJBMXE
	3h3RaoFzCHeLhcQR+XvdHSuUdQH9i/kWNh+cFqnot8JlRV4sMxyz9J5OHM/u9RVrt9y4mgRlM0j
	gLARaN+2KomdeFaxz/PbaivR5T0umU6wTLG+JGFBoX3pcp3Ru9mQ0pcDBdg4Cib2ZWyuwjoU+Rn
	O4A
X-Received: by 2002:a17:90a:fc47:b0:380:105f:8ffd with SMTP id 98e67ed59e1d1-395df5e76b5mr16904603a91.16.1787451312664;
        Sat, 22 Aug 2026 19:15:12 -0700 (PDT)
Received: from [127.0.0.1] ([172.184.219.166])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-14186183c0esm19728741c88.12.2026.08.22.19.15.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Aug 2026 19:15:11 -0700 (PDT)
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <tanggeliang@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <cover.1787446274.git.tanggeliang@kylinos.cn>
References: <cover.1787446274.git.tanggeliang@kylinos.cn>
Subject: Re: [PATCH mptcp-next v6 0/7] Reduce the differences between TCP
 and MPTCP for TLS usage
Message-ID: <ab9d66a6-55c2-0795-da56-c3585b04d37b@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Sun, 23 Aug 2026 02:15:10 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8

Hi Geliang,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: normal (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: btf-normal (only bpftest_all): Success! =E2=9C=85
- KVM Validation: btf-debug (only bpftest_all): Success! =E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/runs/326103=
12176

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/097e1411fd4a
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?=
series=3D1150287


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
