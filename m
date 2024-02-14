Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com [209.85.219.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8070318E0C
	for <mptcp@lists.linux.dev>; Wed, 14 Feb 2024 20:33:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707942815; cv=none; b=mrRZuO3MQNJaSkbWFX1Oh/GfIHmzKqT13IOaQg12QKlHkuI2zocwgN85mxvF1a39orJLb5b6a162vWM7zsYcn6LKHfaVCJNBaDhGR2D8K25Ig70CvdrFDzCQXhulInJrBcnD8a1dtMnXTxGUiAMgtugAvesEGQeLhjs5TF0Ugm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707942815; c=relaxed/simple;
	bh=Czgzx7rgJ1j2B1Nq/Fsd6ogUalSXr8SJsfxOLi7RmPg=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=Ai6d39zQaf3ZlnM+0I9CSl/xUfHOMnyagA2XuJrPfO65qMaJU1tLmKbo7VCiF8B9LsihJJYqm+kRuyFg5EeKxIb+swq0uZecdSEtZIwjRulnSRN/n29P4F4gQ/U++EkvYt4fhZoJPfkKMRr5GcYFZieyjgQYDRxc9FLL2m3hmZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=En3VCFmI; arc=none smtp.client-ip=209.85.219.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="En3VCFmI"
Received: by mail-yb1-f172.google.com with SMTP id 3f1490d57ef6-dcbef31a9dbso71154276.1
        for <mptcp@lists.linux.dev>; Wed, 14 Feb 2024 12:33:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707942813; x=1708547613; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zlpRdFtyBRjlqJOS/mn1JmKCAMMUCgYv0nA5nN05Ji8=;
        b=En3VCFmIUqTZUK5mLzehuJi1nJs1C7WK0rdqC4BT2kiVchgW5Hvq15rlh6JdbUS1ut
         /uDo/ijLDNMciqNxK3y1doVarvPdnisaqO2x44bY980JOjFWMmGJPMhqBJqn4FPNeWdS
         fyHj01oOIajflh5POXCCCk2AvwH+n/y4cKp0Lw1VFIBcYil2OztZHSzAb61nJhNam2j9
         yx6C2oH6HgvaAqgj51Dg/4oZ0IKoQuLwDtKpnxBtwhf4YLkKtAw6o+70XoB2I4hWP3AI
         i3IOR1oGvvwRLgAu5wBoE8lgDlKf360rPSZSzAHzFyAbGH6iYrsgrZqcg/HSXz4aATdh
         KreQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707942813; x=1708547613;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=zlpRdFtyBRjlqJOS/mn1JmKCAMMUCgYv0nA5nN05Ji8=;
        b=PjKaxaPX+huzadC5k2nNG5UVhmNXgMHCT0tBD1wY8PfH4+nlaAtlh6K0g+NFclAKtM
         SGMvjOPw9njxLeY7GBh5BRRJlUYImu+tMi43vbW8fY69t6ds4WIePKrBhH3K1XSzxGPo
         Dh+ziqsFg0jDpQ7sgTRQjNpcSOp/KPnyZmORmAp9QChmGkQ2B0jQn/XWwOrQnIlUncPq
         kH+UL5BAS2WfqhWhsQacilQfvMUiO3fNTGecNZ4ocSucUEHLpcvf165YZw6T1MIbedkg
         kXbbEu7cFiU3NFSUwDdUwd+cZd15R2IVdfkIj4f1a3mijpG4GhBc40Zcw5mi5rwa5nmn
         /pwg==
X-Gm-Message-State: AOJu0YyYR++P9eTlKwdy+m8o08j7gOBI0eCSuthyu22K5BG5t8ggZPx6
	fNynz1RH5ru/9V3EStrP2CYL5dTtadN84/y7iS/a8ovOHS3n9wk=
X-Google-Smtp-Source: AGHT+IFIWf8TV+H7uEzG1Cs5m6v+1xsd/xfc8Vp3bejrU3ciUDoqFcQjV4NqNUyBJiJWfmaEWu5bgw==
X-Received: by 2002:a25:b206:0:b0:dbe:a688:8ab8 with SMTP id i6-20020a25b206000000b00dbea6888ab8mr3682600ybj.0.1707942813380;
        Wed, 14 Feb 2024 12:33:33 -0800 (PST)
Received: from [127.0.0.1] ([20.55.118.212])
        by smtp.gmail.com with ESMTPSA id 15-20020a25090f000000b00dcd56356c80sm533918ybj.47.2024.02.14.12.33.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Feb 2024 12:33:32 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <20240207-selftests-mptcp-iptables-nft-v1-1-108de489316e@kernel.org>
References:
 <20240207-selftests-mptcp-iptables-nft-v1-1-108de489316e@kernel.org>
Subject: Re: selftests: mptcp: stop forcing iptables-legacy: Tests Results
Message-ID: <c95f6bdf-ee97-337d-a14e-7e502911d655@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Wed, 14 Feb 2024 20:33:32 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Matthieu,

Thank you for your modifications, that's great!

Our CI (Cirrus) did some validations with a debug kernel and here is its =
report:

- KVM Validation: debug (except selftest_mptcp_join):
  - Unstable: 1 failed test(s): selftest_diag =F0=9F=94=B4:
  - Task: https://cirrus-ci.com/task/4859875667214336
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/4859875667214336/su=
mmary/summary.txt

- KVM Validation: debug (only selftest_mptcp_join):
  - Unstable: 1 failed test(s): selftest_mptcp_join =F0=9F=94=B4:
  - Task: https://cirrus-ci.com/task/5985775574056960
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/5985775574056960/su=
mmary/summary.txt

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/f4e0ec263c41


If there are some issues, you can reproduce them using the same environment=
 as
the one used by the CI thanks to a docker image, e.g.:

    $ cd [kernel source code]
    $ docker run -v "${PWD}:${PWD}:rw" -w =
"${PWD}" --privileged --rm -it \
        --pull always =
mptcp/mptcp-upstream-virtme-docker:latest \
        auto-debug

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
