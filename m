Received: from mail-qk1-f193.google.com (mail-qk1-f193.google.com [209.85.222.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB36632C936
	for <mptcp@lists.linux.dev>; Wed,  3 Dec 2025 19:43:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764790992; cv=none; b=avH5WhIYcO8BGxntFyfNeEc9iyaYTyP+OmgefsacP31WZXxBWTkpBLqCIwBuLHPQGeKYCZkZPktQZT92hmqeSrSmbvljSPj7eK/VLetOolwwa5kQZt8PNjDYbkkUE9CQqmFUyxNqqtbh97oSVDNl9r/k7U9zmYUCQ/RDGxJoheQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764790992; c=relaxed/simple;
	bh=18hjzc4OEKkbJLeVwj84hwArO10IIhq85EA1WIGRQBc=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=cPSABwbpQucXmcZDcrx1K0CpRlVocefU2HyXBG/ZSIAfrysNPOaDe1cE3Bkrkqfamgg62cPXahX6Vt1WOJ0AcN+3cAQXU6oEqID9V+z8Di9GBnkA+cNty6uWF94fs4ZSdU4KtipY6kJjnvM7rlKmdQgyKBa/EDgo9nw4dnjVkPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nRYtDoT9; arc=none smtp.client-ip=209.85.222.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nRYtDoT9"
Received: by mail-qk1-f193.google.com with SMTP id af79cd13be357-8b2dcdde698so14530985a.3
        for <mptcp@lists.linux.dev>; Wed, 03 Dec 2025 11:43:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764790990; x=1765395790; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nhgZqf4+Tz/jM7VE7PrwQ3tjBB1B2vPIJtaLwU8MBrI=;
        b=nRYtDoT9pLfiU8CmBFFn1+BLP3Pu1p81sAe2uo4Pz3zPno8xIcpKpPLOXaRyPjVKsB
         emI7rEXfvk8oBoKoEW6vfwqs48ByERZ7dpj5SewoS+14gdlYgrXbpyY5tPqQGTCZQXJS
         AjVJz/LC3kkyI9WYB4vMqorMV1tNuVsNoO9UuYSJCTkpxukij3kpRcVEWENQFx86Uj8v
         QQLyjckCJO41mwWWHZAMenfn1VJ+2rj3ZeV4hrUOvk80rnjf/9c9Tnii5CgJThVGMKbR
         yydyh7pELmV3WSfHZHMwcaxHUFSMMtEJOaIqUZAMj3aPXXNaaU+Fa+hODeLSOYHXMWa0
         S3BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764790990; x=1765395790;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nhgZqf4+Tz/jM7VE7PrwQ3tjBB1B2vPIJtaLwU8MBrI=;
        b=Y8nF9XhLDYUs9mZ5HYaHprI6RiCJObofoQVRznLp+3aRkgXj4CVK1cB2M1yEXgl0lB
         EEws4cqjmo2vFHQ+sdVSg4TeknX+GMP7mDuvK/jFCa/DltyMh1MypKNJeVUAFqFSRZY6
         SDykNzPCmZmv1pqXz3suapcALTzilAoqF9DXpydCqYcsXogjGZ8sy9IAWz+Ve5/d1ddl
         NtcvMN4vYSYlP7DZjOSUjHR3/bjia6/M316lwnfxbdImkGTeJG+uw3afjdbpnB47kGX5
         9hMiPCpUVJtt0CWQYQkvz1z0qxyaN5GTJFynEJx55kYYhA+QTmOvUXlXy13H5GOxqvBl
         yeTQ==
X-Gm-Message-State: AOJu0Yy2VP0U5r+I5MKGVIEUVglmNQTo+Tx2L4f9b+jex+KQjgxHQ/wi
	5stZNwu2x3Rgi+3brxwN9xEeE4jLjOsyb+M6l7qPzv8tOtr9FLuPtByCuRKl8ao=
X-Gm-Gg: ASbGncvK3lkkxV3YElgc9zmNAVv7Y7FSx6RfpkqpSJuS4rW0KFCSA1cN/ynGry/G7cA
	h4jEcpU087yYPkdIanqrs4xsREtWz0wpJxv497vSfaVn9njD2TKu4jChuhBAo81Dp8XJcouZ3+x
	aH+RBWe8Kr/C4jw3on+oKfVynOlrfS6Fv30vx7Fm7PBLItcpsD+/XVIH4jZAGjJAcd9LUADtP5d
	QY6e8oeGU76s+aZ+8EPCEtuHlMBW4Or/aMCmEI6anOef8ax1ANxPPRK5HStGlTB/4XsVQOVylLs
	IX/T3PeywAcRrPOk/DnabLUxWC7/Qt934xr87TmRIgi1uy+rGOmEiQI95/O5zGv4VlclmsX9lNJ
	t2DH6p1/0YxO3lLzGtVPGbtCAKlNmThWmy1LwidW4+Vwe69L3Y9Z08gsBgCO73wIZhBRAszUsmq
	Zg6JQE6fVEAbO0Uq66DjtlQg==
X-Google-Smtp-Source: AGHT+IFzwvFu8qcfe5hwDv11Dwd/O6VxxFJ/4E45xL+DejetKY6kIHDecDNvZoFSfKfZUonociYIcg==
X-Received: by 2002:a05:620a:7104:b0:892:ce2b:f84d with SMTP id af79cd13be357-8b5e592817fmr442182785a.33.1764790989596;
        Wed, 03 Dec 2025 11:43:09 -0800 (PST)
Received: from [127.0.0.1] ([20.81.183.86])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8b529993d81sm1403462685a.2.2025.12.03.11.43.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Dec 2025 11:43:09 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <cover.1764786151.git.pabeni@redhat.com>
References: <cover.1764786151.git.pabeni@redhat.com>
Subject: Re: [PATCH mptcp-net v2 0/2] mptcp: fix warn on bad status
Message-ID: <52b8adb6-06a9-53f6-381c-976d4acffadd@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Wed, 03 Dec 2025 19:43:08 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Paolo,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal (except selftest_mptcp_join): Unstable: 2 failed =
test(s): packetdrill_syscalls selftest_simult_flows =F0=9F=94=B4
- KVM Validation: normal (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (except selftest_mptcp_join): Unstable: 2 failed =
test(s): packetdrill_dss packetdrill_syscalls =F0=9F=94=B4
- KVM Validation: debug (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: btf-normal (only bpftest_all): Success! =E2=9C=85
- KVM Validation: btf-debug (only bpftest_all): Success! =E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/runs/199049=
02424

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/69c10e2bde35
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?=
series=3D1030201


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
