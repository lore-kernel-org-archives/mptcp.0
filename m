Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8817C1EEFC
	for <mptcp@lists.linux.dev>; Fri,  3 May 2024 20:22:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714767725; cv=none; b=hlf/tXfVAvy6x4znG1LIXWvshIpjFWyn+gw92KQ15QCWN8XS+LoQ9iQSZ8Tnk4BJ0kaXh7XG82L9dgHHoi1ov+7GxfZe3AQdy3gwbovnt8gXGFwFwC7oonbgcVE0Hw5H9wApB2q0a3pVgkqgFVzagj9kTLf6Oq7A0Z6SX36CfaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714767725; c=relaxed/simple;
	bh=wL64uDfWK9i0aBJA6ARrKoGmrN2NAXwpeNvDvTLG8bw=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=sn28uaOkh+eki3zMoElFiCXa3w/WBnWQXKDmFSgaRLvXcxvGOY3EME7YarihM76c4My/DrtKWbZWni+u43/gY9nAMgThHFjTfk330/DAvgW57KUL3YTn5pTwCDN+v26mypj7/SCzAsSQy6TQUK3Ki/pTIYiGe8mJHTXnr08X3q4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H8+VsWIr; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H8+VsWIr"
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-790fb2b780dso3119285a.0
        for <mptcp@lists.linux.dev>; Fri, 03 May 2024 13:22:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714767723; x=1715372523; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qW27YUw7Nw9Exxh5cK51BpQv8FzsJyJGLDRezW7cdUw=;
        b=H8+VsWIrusc1Tx4EZPOrSJQdFm6gZbtYidpBnPptEPZRSR2aSKwsuriQV4IsQEe+MO
         Ae1JE/57SRI4io3U6MORDQqfzxnxsggataaoCfOZk4NwuPMURZwS2miEK88qBNn+1Dwk
         aEEGPsqfIW18+UFYa/+0eEyrxyPC7gtRYTzMpOtVX8xyxOJqfVZ84G1Sqq14ICb95lth
         6CRSxox0WLrk6vWCKVsESBTWDTEW5xqmu4zHwOTl5Hr8Srucl1emFbF3S1Qsg+NjErcw
         BH3K9oxKa7jE7wX3HeFpi3M5zHjmVmnqkSGtsnYRgbHWDvAm2H1vHiFVMREqA4LfTrRl
         QtLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714767723; x=1715372523;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=qW27YUw7Nw9Exxh5cK51BpQv8FzsJyJGLDRezW7cdUw=;
        b=dwOyG3qUjOrTCsqBVWjIHQMOA2yUcmRWOtB0x4u9gOzJGSR8kodD5wJ72SORyPlzsy
         gm+xkPqAGGmCcCVjheP5C23JkDJE+5VeEByXCG/igt0eHG0JkcMQ25+tjtv13Ehz9DAG
         Ysiaq/IdFaM8MjM8rTUfhxVmHmAVsiB9NdnRR6zFNFelY993zK2ugqiR9KlPGYBZIfBq
         N3FJixeCOYPOM2POJYZQYHzEAzTEIJElKp/j3r5tq9NWRqCfJx+YqjYgzIBb5jYq/q3X
         xe2joBfVCjnDl82p5+juSVRJq78IXnOZH975jVTkmEgTYHQwtibiRDx5+yT0WKoFgPkz
         2pjQ==
X-Gm-Message-State: AOJu0YwcYjnMmF4uBOlBF+UWsQ3EHmiAyjs4e0bJ4LZizBZf9FG1jA8g
	J2LCVSnv+d/hAyLjwBiLIyrI2r3w3kwxBFzMCgV0uwHdn3qnZB5c5fXG
X-Google-Smtp-Source: AGHT+IG2+z3E3Mfwol9XcTGfPgtV5zuDryj2ZdO0dGjwFaqYDLuLoAiBTJ0zsleCakETFpi2OXmP0Q==
X-Received: by 2002:a05:620a:460e:b0:790:a3a7:7cab with SMTP id br14-20020a05620a460e00b00790a3a77cabmr4450899qkb.39.1714767723439;
        Fri, 03 May 2024 13:22:03 -0700 (PDT)
Received: from [127.0.0.1] ([172.183.131.196])
        by smtp.gmail.com with ESMTPSA id ow8-20020a05620a820800b00790fedd9262sm1513924qkn.42.2024.05.03.13.22.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 May 2024 13:22:02 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Gregory Detal <gregory.detal@gmail.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20240503-bpf_fix_access-v1-1-5a714318ea64@gmail.com>
References: <20240503-bpf_fix_access-v1-1-5a714318ea64@gmail.com>
Subject: =?UTF-8?Q?Re=3A_=5BPATCH_mptcp-next=5D_Squash_to_?=
 =?UTF-8?Q?=22mptcp=3A_add_bpf=5Fmptcp=5Fsched=5Fop?=
 =?UTF-8?Q?s=22_--_fix_bpf_access?=
Message-ID: <79552ad0-a0b6-ee79-5031-037e159c5b72@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Fri, 03 May 2024 20:22:01 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Gregory,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal: Unstable: 1 failed test(s): selftest_simult_flows=
 =F0=9F=94=B4
- KVM Validation: debug: Success! =E2=9C=85
- KVM Validation: btf (only bpftest_all): Success! =E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/runs/894410=
3225

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/e74739334cc9
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?series=3D850347


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
