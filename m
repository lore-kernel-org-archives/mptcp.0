Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3CCE250EC
	for <mptcp@lists.linux.dev>; Sun, 22 Sep 2024 01:54:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726970070; cv=none; b=rp5UC+gYFg5wx7IHbEPRy5Pkuvj+bID9QYgGZDEVIzQuEmrdAIpkMrfdyFHgDo/oEWTtUNmwDDt8R3NsJypN3PZH15wMst26Hudp2hBEZggJILzJ2il1xnGf2fO9zAV2016KBFSAdz1Sv3FhGDuTlBEOcYroR4e/5XLgooRnWYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726970070; c=relaxed/simple;
	bh=n9TbGCDP8pktliYhhaq0IREUL7k0sRCBoI70QQgCZvI=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=XNtlhHy+gxFxUGrTrSauOPq9B9+T/r6d7teiQ2PKblu6/OfDsuVSaS8Ekq7/C2gdliQRuZTdWwdjFeVFB5kSP/4AJC2vH3Uzvv2hiUzLpVkpRgZ43G7KvT8IEWZXBKHsYmleSh5Nvk/ELrBg2YMaXMkaAvLdjpy7G/vHrdypexE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l4ztRIh+; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l4ztRIh+"
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-7a99de9beb2so209518985a.3
        for <mptcp@lists.linux.dev>; Sat, 21 Sep 2024 18:54:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726970067; x=1727574867; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AzAjg87sjc7UrMVq6/VJ8PgyO8bPieDuBwwF+UCBKDc=;
        b=l4ztRIh+oDz/OaWovU4cs1DQJ9jZdTA4yN8qpKUT+24n68oR+Inroyd4FeFWtiH7AL
         VYuNesYUloHFldTkZW14rFEj4S/2o/WFWqACID5rciDY/NlygvHnuUGI49Q8E/6XRYx3
         9F/HJc/LAqAZTyLAXCLkHGxnE/zjlWgYl4XcU06mU1UBBkK1grVQ/TRGUG1MUc/pQoWL
         kCnZjSqqw01bg1cFpQFx8oRSXtJ2bD4JtQV/TNZa7BiRQo9nDW47PMDYkgH460HprN7A
         EBzyXvAVzBhaXMjW9uullbep/iICNobtHPOh6c3ql7J9rDtTxx5K+0Mue+4MUtFb0G87
         bKMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726970067; x=1727574867;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=AzAjg87sjc7UrMVq6/VJ8PgyO8bPieDuBwwF+UCBKDc=;
        b=X0zIC7q1H/BjQQRKb77WOfZ8yQ9f56KtD/J6qeichYjUKcYkqLJ7rHrf63Fd11QjUj
         WCA4Npe0ohxTiZQvHPzzKkWNU7uqblxBJwS4uKvlcOMbCpcbdhu3KGsj77rqXcADZs6N
         yeeXbbJanCci72+ClvLFb4r8DuGTdyMe8ATlRe17QCwEl56VyDpGy1mA6EuD1GgJ4FOa
         qkeCF+ICDqWdpqWv8PsO7+z/tXGfN8Jo4Q6nHJqsuHLgvbVd4TgcnqBh85nM4LXObipA
         Yq8clmb9Z8XTc863WOPlzxPKaokhl4yXNgRo4qfMQYNq7b7+8sl+4VBESkZ63//5RXzQ
         fZ5w==
X-Gm-Message-State: AOJu0YwnikjqqvTzYFlZVsJpqqdSaQ3rJLAqJfCVrujkhxvsAtk91Zwk
	K4O14JDU0XIYZkYGU4GdLGCLRO8njvdDLwydKhZry31w1z/kW/NNb8Kr
X-Google-Smtp-Source: AGHT+IEFY3maJzENAmnIcFo3VKHZbLd+9TQ3zVFdkPVlpySt3mWv9Uh6DOukvCOLL5FprC8rIpAJng==
X-Received: by 2002:a05:620a:448e:b0:7ac:b19c:213e with SMTP id af79cd13be357-7acb8d8c98dmr1288021385a.18.1726970067589;
        Sat, 21 Sep 2024 18:54:27 -0700 (PDT)
Received: from [127.0.0.1] ([172.200.199.182])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7acb08c13a9sm335742885a.80.2024.09.21.18.54.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Sep 2024 18:54:26 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <tanggeliang@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <cover.1726966638.git.tanggeliang@kylinos.cn>
References: <cover.1726966638.git.tanggeliang@kylinos.cn>
Subject: =?UTF-8?Q?Re=3A_=5BPATCH_mptcp-next_v3_0/3=5D_fixe?=
 =?UTF-8?Q?s_for_=22new_MPTCP_subflow_subtest_v6=22?=
Message-ID: <07c81839-b0b9-7ee5-8082-4a8e253be924@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Sun, 22 Sep 2024 01:54:25 +0000
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
uns/10977099962

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/c784e8c47dba
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?series=3D891874


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
