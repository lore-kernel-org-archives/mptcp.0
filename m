Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com [209.85.167.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F14DC18E374
	for <mptcp@lists.linux.dev>; Tue, 20 Aug 2024 10:17:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724149050; cv=none; b=uC37t2ofQadL0+tgubUlpup3twmmQ/yOqr3uXHSa5Z1i9l966gRFbd/7F7nd3wsnQ8/RBeJgBS5mDqTABrAz8e3gb1DBWUNj0id3SVQmWxDBFUtdfSVrUUdpW+pGqsgy9sCh+TRsgcTrmrZGNQQky6Ul8NXsfngZQ6FDWepknZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724149050; c=relaxed/simple;
	bh=COBCxRWKg+FGcsWbwWs75r6oFFIsjHKJfpT2+l/Wv0s=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=oGla3RyoftgE8wbjf7cg9joJ/yTuvI/iZIjQcYxtLjzOEepB8d8jGXxkIE8GOh2Hv4thioExcbeI56KLW0WBu4OXRVEF3yysvYiDwGpg6XG/lOWZBvqsiVXKKTt+KyfR04RR2+YkL6PdPV1gZbsCixiWo1IKcI5U+H67WYNPoLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J+HVA3Ql; arc=none smtp.client-ip=209.85.167.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J+HVA3Ql"
Received: by mail-oi1-f174.google.com with SMTP id 5614622812f47-3db1e4219f8so2956690b6e.3
        for <mptcp@lists.linux.dev>; Tue, 20 Aug 2024 03:17:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724149048; x=1724753848; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MSFXv+15utUrJUR/mb0exYv+y5gD94yQk5O4zgDruoQ=;
        b=J+HVA3QlevlzZyPwjw52gQLqaedR0wOW0Ylb06SZj2djjF/jWFi80otLWZ9RaPliDl
         Xhqe6ynSbXsnVy6ffnMuA7NeFEG1cHUgfiEJM+98pwY57RUEwji5BCaVdICc/8pg8G2P
         OeAbvMLPo9hQRPZY2m32/V+UhR69THEuHKlH2nDHr5Ar9/bmatFTHJCNLgPvks5iUZku
         ppC1FvrIbNmYU1QGUQJ2ER+zZnyayN+E8pv8kIrGN8U40s8cfhvU9z2AAWKID429tWeB
         Ptn3Nkg2fCgcKo8YYlysmV58M1H8STzNZ3HtTti2XNTajte0AWkEe6+Ki+giIX8zr2dN
         irYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724149048; x=1724753848;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=MSFXv+15utUrJUR/mb0exYv+y5gD94yQk5O4zgDruoQ=;
        b=bCSiTLLBYKlXziAQMZZPjoLOSUbMRRShowiI/TacH2TUBaoZEZLC+MhgyDlB+I7zEt
         BIokKgyndfaMg9arEv7+RZII+OON58FbYdWG8IKSRBnbzacmQXB0kcN1QihUfkI5EKtP
         kZKvJvLdtb17oWOyRhVflg0uVOpzXXsLqLJPmGeUg6lt8el+fyl5lH3sG3Y9IVIaVsrF
         qfDndQOEjBF7ay6g6s2eVsSFwvDFCOOkpJbK2XT1DjsXX6P39qacriigINILDjA0dmPW
         9zCKWv+FHdWoq5pKfQA3vJrjFRYVB1zM/77T25KU+5aOxliKp0T5DxUEr1AOnsqMEj7s
         mhAA==
X-Gm-Message-State: AOJu0YxNKxnoUFG2EZUG3ggAXNxS2RAstDoyW3+CCEerNuCfedN+nAq0
	4b8U3JCx5Z28hs6bO6/Wd0crK/wn7O7Nfus8rEl0nKpM8+gQEq+iTgqL
X-Google-Smtp-Source: AGHT+IGJd2za7qyIPe6raanbx/ZvwR+dPdDV1iO1S1WEOFT1brVv918xY2A9HKUNouixjItWe+ZBwg==
X-Received: by 2002:a05:6808:2f07:b0:3dc:15b9:334a with SMTP id 5614622812f47-3dd3acadfc1mr15536347b6e.6.1724149047723;
        Tue, 20 Aug 2024 03:17:27 -0700 (PDT)
Received: from [127.0.0.1] ([52.234.33.247])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7c6b61c6730sm9089673a12.26.2024.08.20.03.17.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Aug 2024 03:17:27 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <tanggeliang@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <d3b644bf82543591f2f59b37d1c1b26a2b9f88e0.1724145512.git.tanggeliang@kylinos.cn>
References:
 <d3b644bf82543591f2f59b37d1c1b26a2b9f88e0.1724145512.git.tanggeliang@kylinos.cn>
Subject: =?UTF-8?Q?Re=3A_=5BPATCH_mptcp-next_v2=5D_Squash_t?=
 =?UTF-8?Q?o_=22selftests/bpf=3A_Add_mptcp_subflow_?=
 =?UTF-8?Q?subtest=22?=
Message-ID: <5600c3fb-989b-18f3-f908-41243918272b@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Tue, 20 Aug 2024 10:17:26 +0000
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
uns/10469116099

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/2c330e82cbb3
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?series=3D881246


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
