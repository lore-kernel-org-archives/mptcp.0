Received: from mail-dy1-f169.google.com (mail-dy1-f169.google.com [74.125.82.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 208EB2F069D
	for <mptcp@lists.linux.dev>; Fri, 24 Apr 2026 16:29:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777048148; cv=none; b=afG5TwnSnMGepZXKGxD7lghu/YRSZwqHymgKhxWpbPbEApRSDB+YXZOBQhxEgvuKSMcQnsSdBrg554yiuSVFYg4aRhrCXt8QrhcomlRRxDny8yq/awoLoO9zkqEQSC+6OHLJpAVhgj1FbNN1I+6GoRFjkpfe4EKk2gXc3hxvK0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777048148; c=relaxed/simple;
	bh=IKqvRZBmjXyGFtPMcLo0ZhQcRHfl1zDRdUsJFdzO6Mw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-ID:Date:
	 MIME-Version:Content-Type; b=MMjuQ7jrjqB23OurKAoAG9O18hLdIW1KIar6Wsq4AE+OpgHYXOTx8u8EVslEpC/JNCgQWjFXsm2/w9tRIoZxpOk4deFdlHzk2MwySFY0P8GMHWTpGG9khSwtfP0mU/NIpq/iDNYdRuMa30YU8xwEwCKGEHhPO2EkNJTVmj3aEeg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZsR4Xs3A; arc=none smtp.client-ip=74.125.82.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZsR4Xs3A"
Received: by mail-dy1-f169.google.com with SMTP id 5a478bee46e88-2b4520f6b32so11090674eec.0
        for <mptcp@lists.linux.dev>; Fri, 24 Apr 2026 09:29:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777048146; x=1777652946; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=981YdN5yKDyDTgFIxvLMvQl8hZHOsB827AvE2TaiImM=;
        b=ZsR4Xs3AucNRGKPCnlvyvAVPWQioo8gGanPNfWUfzhuerIO/Esj6O8pWKL4b/CHDNR
         KDgiT9/ztV6V4SklXpSaKeXEWCWqzOq0oz6bkvufKg38zLCMLtocDGUzUbh81wjB1wjE
         9EqSsCTf62Ujcvuvz7dZbARaDqsdSbCPmdedYKPGKGaLt/bQIdkscXfx9rprN6rYvwDh
         nEAYL6D1CVZTxc1yn3ChlKMH4Uds2inQOpiRYxIBn4FwE9rxdkqadNfJN7PyXbaxyHqP
         aJp91F7VpgiXvLK/HoShamfAJ804+oczW6BnAG0v2hTJFHw249kWLFe2ERoKwlpc5isl
         cvpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777048146; x=1777652946;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=981YdN5yKDyDTgFIxvLMvQl8hZHOsB827AvE2TaiImM=;
        b=SrrctBw/yY9sap8HDMSJI/obxTkDdJIh0R197XblS8DA0HzHIS+0/6dsPAYwZzqDS3
         XIHm6YrzjNe29z1FGHin9tsWtlAXXqZ3gEOIZKOaGnxo+EpZrKJ7H0mTlPgLObYtbIt2
         RUEwEMvfMBv0kNZxEm/LHkhbBFnn/RJ4tbKvivMzadG8LUnRL41bDqtB5bUoJyAvZ6qP
         y0rjzaao5WD02URAyIRnI7PurLsVb/VuALnbWWc2oFuLQ8tYKh81SeiQwK8ahtj7WWlO
         21NQmtz4LWRt2O++TxOrnB57CzOweKZPRZvYkoHn9bV3+Ng1MO3BvqbkdVBOVC54ofIT
         Lg/A==
X-Gm-Message-State: AOJu0Yx7pQrtffaYQEzR6u5QpPn6OJt9IqP+Pbk94xmIM1XUwMN3uH3n
	wZfS+q8uKWDaPGkO18ltrLMU3oeMvC/mSsOsKFSjUkq8Jheomsh+QpoBbCqV
X-Gm-Gg: AeBDieuyo0UDm77odDwWgBKx0HJViYLJkRYxQLxwDqRT7Dv+v4JOtGadmawG+5ksFrt
	Wz8PEWa/t5c1fR0CCyVaMhoY8HONN31h+HZh+yBDCnckU7cbkfAMNgGdUXEOEk/t1oGCqTWdK7t
	/EUTpGcI5jlXHt5hYURJNeN/bt9QVTbiSjZe5JlcdPpRjxsDNVC9Se1ZYcHUwSStAhKC2/D0WgA
	DAH4JlWqnLQHzG1vX5n5gKqEplrC3M4SuNjW90zGj9VgTph2Ei6mxu5FecvyvpEfxUW+WDPvfTm
	K3NswtY1GvIOgMrgsSXMcQ36P1uXyWRh82vYcbZ1hukN1f2PtAMDD09Jq5pCtKVg5PpHWy3dWHs
	Z13nqG/ziLbFnHMJ7byfnQvMsg9nm+Hj3mrO9mNgQkkzKnnpahYq+HFLqxCcfX3UnAnNggdzsAV
	UHnEJcBgfwKcLo+preaI+ss8Fim4ALDkruzDVTAjAwjirHQDg=
X-Received: by 2002:a05:7301:4185:b0:2e0:1f09:d924 with SMTP id 5a478bee46e88-2e464ea9aeemr17349076eec.5.1777048145824;
        Fri, 24 Apr 2026 09:29:05 -0700 (PDT)
Received: from [127.0.0.1] ([128.24.161.40])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2e53d2cff04sm31570079eec.23.2026.04.24.09.29.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Apr 2026 09:29:05 -0700 (PDT)
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <cover.1777038888.git.pabeni@redhat.com>
References: <cover.1777038888.git.pabeni@redhat.com>
Subject: Re: [PATCH mptcp-next v1 0/9] mptcp: address stall under memory
 pressure
Message-ID: <d27f110f-a796-39a7-9517-03e115d252b6@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Fri, 24 Apr 2026 16:29:04 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8

Hi Paolo,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal (except selftest_mptcp_join): Unstable: 7 failed =
test(s): packetdrill_fastopen packetdrill_regressions =
selftest_mptcp_connect selftest_mptcp_connect_checksum =
selftest_mptcp_connect_mmap selftest_mptcp_connect_sendfile =
selftest_mptcp_connect_splice =E2=9A=A0=EF=B8=8F=20
- KVM Validation: normal (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (except selftest_mptcp_join): Critical: 2 Call =
Trace(s) - Critical: Global Timeout =E2=9D=8C
- KVM Validation: debug (only=
 selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: btf-normal =
(only bpftest_all): Unstable: 2 failed test(s): bpftest_test_progs-no_alu32=
_mptcp bpftest_test_progs_mptcp =E2=9A=A0=EF=B8=8F=20
- KVM Validation: btf-debug (only bpftest_all): Success! =E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/runs/248949=
34320

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/cceb6849cdf8
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?=
series=3D1085225


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
