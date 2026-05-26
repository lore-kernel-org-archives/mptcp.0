Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0839438D006
	for <mptcp@lists.linux.dev>; Tue, 26 May 2026 10:41:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779792096; cv=none; b=Vxawwt/5x9eqampE42twdbkGltw8gvp1OLRGk00jbwt4j2Lu1R8XgaRf0cggNxFctwOuOT4ebvK3CRX+W6Zace7BcsRxMftoIaNDq6S2Difjg/MJqGHdLj0LEFEOQDEbffOinE4F+c7teWS4gcvxV6+NmHgIRXKdm+Umj1PKOXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779792096; c=relaxed/simple;
	bh=oOUSZrWllrT/tfmw58ult5Hlf1m378X6dJuRbHmcykA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-ID:Date:
	 MIME-Version:Content-Type; b=XNjvsEvoBHJn4mJb2aDGJx26cFzu4rX1B+9NzR5pIStXT6k42EEJackmrXkjVS14kzRtSMWk2bBn76fgnixvM+Y7aAEPNJaScmGSVMDNdI7kBMOQ4IKgSP5ZOYNF1Cg3mQETvHgSU4/tv9rq3Rb/3vyv9AgFSJnzeRNDK1oPpac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DckilVNb; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DckilVNb"
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-512f09ecc67so72248931cf.3
        for <mptcp@lists.linux.dev>; Tue, 26 May 2026 03:41:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779792094; x=1780396894; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Erqg4EzXOlz1VsloD5UmvrUzrDYGqZhQhQOaBb2Df3Y=;
        b=DckilVNbPbENvAzgVIi1U03sP2PBnIQfEjChgDfJ6+tOVdTnIripeG1Oik/dREVcl0
         xAYMMXvDUew1DbYTmOOMUXHi4dH45H5PCN8COi1AmP2fnl2zM6+qe/tT47+QDTiPZQbf
         Gc61aO5k01XQSdErbs7ZhNpDeGxJZX6wvQopC6oob8yi0lnvgD78u7aOu0zq7ups2NM8
         93/eQw5XiuV5bfxIV8D9CSW2DR8fYbwLuJz37zos+ZXhP6K5+uhEBy/LfWuoPt31f35i
         RbIVdQsECiWU9iK2hiFubWWsr1JOG8EjJzqY8nyl8F07/IO7HKSQtSHEAWZZ7GWJEeSg
         rPPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779792094; x=1780396894;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Erqg4EzXOlz1VsloD5UmvrUzrDYGqZhQhQOaBb2Df3Y=;
        b=O+18fk95jyvgqArm74ytSQG5YQTu999KrbwXRSSx0w8pTBk9VFlfw/oLsF5weXdXwf
         GV1fvYwQXZEqGRIsmimLeke9lvcjZpn5x2xYhoHLUxWYcaWdOMLRvpTy1F5W9Ti7657T
         P6nvjVWYdBX4TJ6jIfr13NePP09ssTMtKtcHc3KkpGW6wXZC4XHF7ItgWTVPPtmsy4TP
         OsX/zx/p43ztMXFAQEiV64YOXwIVZUY3ruArGpCnjTCGcAV4bTu5qNZaMmEPIemIrX9x
         8Fbatm4Jy4E/In9ezoOyVXcA3b9Bds++Rb7cF2r4Iv/8AUNXuqfXmfw7zoBGzrphXKzM
         Bk2w==
X-Gm-Message-State: AOJu0YxsvczHzqtnnuNxiviM5Jp3DXvZg9gNXMgtFb5XpfdEfLGF+ZY9
	BGjua5g/+dMMAeQ8i1a91dZoNTzgS8ekeiq2YPsBlLGxN/wLNOkzY+KHCjOv
X-Gm-Gg: Acq92OH1O/BE752/PYKUk/wgf3j+xT0Q4uBycqN/ta0nQbBE0Lx6sMVO0lZu3cHJq5q
	EWuMldXiTEt1MAuPBzm1XURoHWtL/dQDeXqSfwnxPamBopt2JI/clUGWjoPldZZL5xLIMelUfHC
	bqcNILWZQl6cASAXTNb4fm0q/mSf6EMsY3AuI0NzrShDM7AOKDAQA5V9Z77hveXzsMCag1XF6K2
	ApxutU6uIzhTtA7G31pMEAFeCfbfGh571ueBbVP1OpKZVVTcqL4Flu7DaHquYGdaRvm7M5Qubni
	oevVBt7Q+G/75Obj2H2PuOB2fbYc95r77Mk+WWxQa1GUNfWz86H7RYlJd2y72aCCgPsOUBQ/Do7
	A2Gv/aFFNYJAIkrmZp+VzG1BpL2sgbNQbvC1FEOjGssEUQccII3RQthQr6hCgkvEZXKVP/6oRge
	bF/fTgwMOc9448o80fGWkEfrXrmo2N0EU83bvzOSL9wz14GJk=
X-Received: by 2002:a05:622a:9011:b0:50d:6b13:bb14 with SMTP id d75a77b69052e-516d436db29mr198368301cf.34.1779792093786;
        Tue, 26 May 2026 03:41:33 -0700 (PDT)
Received: from [127.0.0.1] ([52.237.143.50])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8cc80df081asm137822716d6.18.2026.05.26.03.41.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 May 2026 03:41:33 -0700 (PDT)
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <tanggeliang@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <59640df9a7c0528688419655e53cb4efc50aff41.1779786007.git.tanggeliang@kylinos.cn>
References:
 <59640df9a7c0528688419655e53cb4efc50aff41.1779786007.git.tanggeliang@kylinos.cn>
Subject: Re: [PATCH mptcp-next] mptcp: remove unused data_ack from struct
 mptcp_ext
Message-ID: <2e380381-048a-7850-bf42-922af9bad706@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Tue, 26 May 2026 10:41:32 +0000
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
- KVM Validation: debug (except selftest_mptcp_join): Unstable: 1 failed =
test(s): packetdrill_dss =E2=9A=A0=EF=B8=8F=20
- KVM Validation: debug =
(only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: btf-normal=
 (only bpftest_all): Success! =E2=9C=85
- KVM Validation: btf-debug (only =
bpftest_all): Success! =E2=9C=85
- Task: https://github.=
com/multipath-tcp/mptcp_net-next/actions/runs/26444090803

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/7312cf56b3ce
Patchwork: https://patchwork.kernel.=
org/project/mptcp/list/?series=3D1100810


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
