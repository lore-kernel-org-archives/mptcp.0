Received: from mail-dl1-f66.google.com (mail-dl1-f66.google.com [74.125.82.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0240C2EDD58
	for <mptcp@lists.linux.dev>; Tue, 13 Jan 2026 08:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768294205; cv=none; b=NEEA3kZ4CF35A8vVWCKn0FB3Sj2JfNxpjVnNoXzeGKH3D8fEyQ1cyApVUwfuOtUY8yLk9u7v5SV8fD5urmY7Ns4epjfsZovFDGaX3zxJW5ASb959cFdczM4PmWOMqe1lNPZmFzkO2SH/tJ1/lssc+0hCgGOuu3SulRxWU3k0fYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768294205; c=relaxed/simple;
	bh=QLHn2meCfaSeFz983vfRBGnnCafWdAksqhAV4jZI7zk=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=lScedxe/AL2dw4kumanhBnWtKEEfSgFHbkpTODMSyeb/LSYOc48GgcNFY3Q56ISDwf2r8Z5X6ScGJVAbcZH0T1VFZ0ZtZewjKcrDQhOVKGb4BCap9u05Trxfg+7XdIDNEB/DH6Lbn44c+QeB5xbVJth2s9hcPdB2f7uQxq5gs4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gaPBVZTd; arc=none smtp.client-ip=74.125.82.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gaPBVZTd"
Received: by mail-dl1-f66.google.com with SMTP id a92af1059eb24-121b14d0089so8062580c88.0
        for <mptcp@lists.linux.dev>; Tue, 13 Jan 2026 00:50:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768294203; x=1768899003; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MG6sTvZRmu90pQo7r0A6h+5Ru71Uq4yWRC7K2h57+sE=;
        b=gaPBVZTdn0DgGOvm7lv9MMm2w6shxBkhKVOH2LOMMEq/C2BXGyVMtbVY3mmGMRNhpE
         IU2nGXmJuLBsQaneXbsGchZ3hp4gmoLz8uturb22Me+eqNHCWg1ZyR+7CK8HeV4FKnie
         bC+Dm7cDn4XI7YtzRRHLjb+NAdK9HkyqlpFyErDp82SGFsnW77FPQS+8z0wJv182kWkk
         FyCMCKRScSnqAku42Sn2uklcJztAVLzqH2GbQsiPpmXKz025s4dL+0G5z1AUkNQLRtBA
         LSbb8b3m+xaYR8lcYaexLFeCiVfJ+wtKphX8WEMM44FUhKCtRMwwASU1dUu/+49xC2X0
         8BVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768294203; x=1768899003;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MG6sTvZRmu90pQo7r0A6h+5Ru71Uq4yWRC7K2h57+sE=;
        b=kJaRFKJeZtu+pN8Xx6uVqVgmkkjji3SFtZwC8sYLlgr8bJYU415mnCPXyd2R2gALMI
         yjTJgrIeXlTyzEr5Hj1hLSNo71ZiFW7i+zp3WwD9/XnlmNKpnQZcwWcuWDhwHG88z6Ic
         aIVm3uh+nUCkZ1WjkNrhDeFfVQV3JIbdFbBR53wGpaE2nIy1/eRN+HdDRP47IVUy69cN
         Y6zH4gy8mYtMXuN6Suv57kHzfmvJVKu1AX2vjqKYDJmY2UEJWTuWXiPptMUxjspB58WW
         xtev4PNYu5XH3RZTG86fWyt3ztD01nTqrSqulR466SldYNuVw8G02ZMoR8yEJq7UFEUP
         ZHHw==
X-Gm-Message-State: AOJu0YwX1Ek8GaMi8FPvQ5VArCf/BGaUqNrIcB57yM1xylDQlLEDLX+X
	n/2M0Y4att8E5s3NgJe8EyJnNcLbjDHJEDBfjwWZINFd3sLW79J5Dj0qeUs6BJU=
X-Gm-Gg: AY/fxX4ottKLipZqRPBtB3aab/3FXBgTcOswPvunH0IkGW5z089kWCZF+cUNfP4KrVl
	evR7a6xoFtxafELKLjX9Mh8KD+yjuftMt3wAJIR2UGtZKXRy0nYwX8nTwft4p1Er7VsvEdd1fqE
	WrbJVfhU2sihTQovBfEX0SoVi8aNFZq/6ygUGuUkGGNk/x5YXskMpzh6q7LtZNW1GAbM6vVwvNQ
	J98w23mLQFYQ0bt/mIMzGblhNbIuCMe5juBRq8pix8TiWKCpa2ctA3bbhLFaXr9W8fFdzI/obQc
	b1EAo41hDmxqkdVSXDJfW9YrxSfHex2C+PDUkQlgaxrqhCLiCxe9XCHRe4dZ/i4+TBQbd0VdfRI
	UgC7u6eJKWsaKX+x49sty/KvrAlhRgonN54+DRWcHKEMy1xS4yDSbRSTG+wZnC6lnVTdjTWeZ8o
	esfKkvFThLEEEYxyCP3AFZOnsnkg==
X-Google-Smtp-Source: AGHT+IH2Z0vHvaIotNgxTv/3jnwhOn1v1ViKWfTL1o1Ib2b01cDjb3gUjfFDSQXMkycCr8Zy5iJj3w==
X-Received: by 2002:a05:7022:238b:b0:11b:a892:80a5 with SMTP id a92af1059eb24-121f8b0e101mr18623924c88.13.1768294202903;
        Tue, 13 Jan 2026 00:50:02 -0800 (PST)
Received: from [127.0.0.1] ([172.182.226.226])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-121f243ed62sm27634711c88.5.2026.01.13.00.50.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jan 2026 00:50:02 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <tanggeliang@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <95151965c8e5b49c6246c8cbb5f543177c0737de.1768289171.git.tanggeliang@kylinos.cn>
References:
 <95151965c8e5b49c6246c8cbb5f543177c0737de.1768289171.git.tanggeliang@kylinos.cn>
Subject: =?UTF-8?Q?Re=3A_=5BRFC_mptcp-next=5D_Squash_to_=22?=
 =?UTF-8?Q?tls=3A_add_ops_in_tls=5Fcontext=22?=
Message-ID: <56f2d1cf-ed2e-3df0-3235-829a244957f2@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Tue, 13 Jan 2026 08:50:02 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Geliang,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal (except selftest_mptcp_join): Unstable: 1 failed =
test(s): packetdrill_add_addr =F0=9F=94=B4
- KVM Validation: normal (only =
selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (except =
selftest_mptcp_join): Unstable: 1 failed test(s): packetdrill_add_addr =
=F0=9F=94=B4
- KVM Validation: debug (only selftest_mptcp_join): Success! =
=E2=9C=85
- KVM Validation: btf-normal (only bpftest_all): Success! =
=E2=9C=85
- KVM Validation: btf-debug (only bpftest_all): Success! =
=E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/r=
uns/20948722188

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/b2e4c337dc61
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?=
series=3D1041596


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
