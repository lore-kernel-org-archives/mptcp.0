Received: from mail-oo1-f48.google.com (mail-oo1-f48.google.com [209.85.161.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13BF084A51
	for <mptcp@lists.linux.dev>; Wed, 31 Jan 2024 14:41:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706712088; cv=none; b=o8Tu9+skRKZkdxrD/5D1zKCWuUF9bPxzyTr0081JXi4IwTYug3GGpyiegeq+EFlqZJCvgPpSAEf8udKuscVOHQS//SX1Uk24su8qa1ryKbd9UviZM3vVh+S1YPKb0ckuWtwyEAiPY4pv0WaFDpnIAbLiG40O0GzgTFDPy84YEpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706712088; c=relaxed/simple;
	bh=EL0pLcEaoOEqbnRWb66YysNIgLs+S1QSUEB/ip0hgeE=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=aDcXyOz2oR51vjSnQO/kvjXXtxNDlf2QcBLelQ+tJo1GccyqmBrzi1LOPQedvZydMEW38RP6rvYnSRMBEAlv9yquTUSHpkD+oDV/TV3rb2O1xOn4sKnK/jFOd1QDMCcx/HFQ+xdjVDA5KOw5/S5A2MkbEracixIcpwJMkxoVGUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L6/RE/hR; arc=none smtp.client-ip=209.85.161.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L6/RE/hR"
Received: by mail-oo1-f48.google.com with SMTP id 006d021491bc7-59a7a6a24b1so760088eaf.2
        for <mptcp@lists.linux.dev>; Wed, 31 Jan 2024 06:41:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706712086; x=1707316886; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XI2TM6XWlxEBIayel3dH9WJz+tBrFF+w3Oekg6Em0gY=;
        b=L6/RE/hR8/VMKwkcZl8BBHqzsuCPRoQRaw/D6aWpVTd+DazvGt78WKZ4+Jr3Blu5oJ
         ZMoqRATIaloNoErb4eF4bJ9OgNrkVAzeTWbRfrJSvMhjv9MQOFaRqq2feqm8t0h+vtPT
         7WqrMWvBhtlaIOF79SMfJLFNvKhuRor7ePAcMpSQWIckdiIwdkuES7TeE25mD9tXTxRJ
         QG/6e+Sgs+7cudH4QMBYuOjD3xAqzuzLiGULUvxZurhodzMM8eN4a9tMTuwU4Qw8oO2I
         1k4X45NHBhG5PMc1MlQRFO2P3jWXZfhO5mW2noHuL7kVEBveQtumvNaq2Nm/FEC1vFIb
         Oapw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706712086; x=1707316886;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=XI2TM6XWlxEBIayel3dH9WJz+tBrFF+w3Oekg6Em0gY=;
        b=aQjhPn8Wdhn79q7IDd+C/tzfu6BeWK3XAvUGBAXtnRB2fBC2f/UExlJisl1BYNGrUz
         DD6/Cd9YdF5ismsFhdK8sDogYYra+zzOfr3H8iB58R/KWLN9D/2y3Zj72Pm6O4B6SGjS
         OaY4c6srhfB63gC18aufUHNaTonpDnFFDBZTzlypPT9b6lahtVgtuiOFWxZHl6GYkpj5
         E8L0g+CtiLxHFILqCpQN7DXMXB5jXWagxO4FZ7VM5J2USUCCUdFySGusxmuKzwoHUMWo
         s3AkXZVuXVbQ7UDMMZb94pXAgn8k7Rpay7jjt8pztuYX9o/2GqT3cTmlqikXGimeFipo
         nhHA==
X-Gm-Message-State: AOJu0YxdnQHJC2oFdGxoA8wkftmrxoEMuj6tUJcELwxxlXjsAGW3pkUI
	X05uXPsyXc171wCoSSKqmAOSi5KXnGI56pRC1YmUqGGeEazbm4g=
X-Google-Smtp-Source: AGHT+IF1eclvlj2PdikY+CS1cFr63lE7ZJEihLYLQusKkDeOxL4rR20olwviMCyBi8fLzNwS/IPK6A==
X-Received: by 2002:a05:6820:1c8e:b0:599:49ec:6d15 with SMTP id ct14-20020a0568201c8e00b0059949ec6d15mr2316065oob.1.1706712085966;
        Wed, 31 Jan 2024 06:41:25 -0800 (PST)
Received: from [127.0.0.1] ([20.49.63.241])
        by smtp.gmail.com with ESMTPSA id mb6-20020a056214550600b0068c5e3d86bdsm1834571qvb.48.2024.01.31.06.41.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jan 2024 06:41:25 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20240131134421.1045648-2-matttbe@kernel.org>
References: <20240131134421.1045648-2-matttbe@kernel.org>
Subject: Re: mptcp: bpf: fix compilation error without BPF_JIT: Tests
 Results
Message-ID: <3dda4fc6-31d4-4d53-8d3b-76c0b88b87ff@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Wed, 31 Jan 2024 14:41:24 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Matthieu,

Thank you for your modifications, that's great!

Our CI (GitHub Action) did some validations and here is its report:

- KVM Validation: normal:
  - Success! =E2=9C=85:
  - Task: https://github.=
com/multipath-tcp/mptcp_net-next/actions/runs/7727148307

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/0192755fd7f4


If there are some issues, you can reproduce=
 them using the same environment as
the one used by the CI thanks to a =
docker image, e.g.:

    $ cd [kernel source code]
    $ docker run -v =
"${PWD}:${PWD}:rw" -w "${PWD}" --privileged --rm -it \
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
