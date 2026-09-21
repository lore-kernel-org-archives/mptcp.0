Received: from mail-oa2-f41.google.com (mail-oa2-f41.google.com [74.125.231.105])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2427848EC75
	for <mptcp@lists.linux.dev>; Mon, 21 Sep 2026 18:21:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.105
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790014883; cv=none; b=Hou30U4EjS2lffnjk17SjO5DiyzOP6I1Xwism8tMrXPlrXJ/E65k/0xXK42x+LW/pySRq0Tm7RxmeySlbCu+iimgpUsqXkryV1St9wM4lAz78DjZCB9D1LsZktcCibnNSG/dJj30Ju9NdWF+qZ58GNNHcl9MoH9z+Jet1TaPKY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790014883; c=relaxed/simple;
	bh=1hc8TKjRVn46Ed1CE4wA6Krz9vhETiv1g3Su/ihGjaI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-ID:Date:
	 MIME-Version:Content-Type; b=ZgktbveDO5aXacE1cVtfEpG+K1slxoDsKYujLL+Rn8Gt4YxmUAmJF8yKj/ieE2LxV1SElN26O40xnM0YIu+C3lCdNX5GZWzSDmGQprhaXOet6MJqMrOMcBlHcWTuWcaJnOlJToD8yvwi0WI2/OjpQTE0uZx0kEq/hzNrb5aSHLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k/s3ONir; arc=none smtp.client-ip=74.125.231.105
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k/s3ONir"
Received: by mail-oa2-f41.google.com with SMTP id 586e51a60fabf-47bc923fe6aso2456607fac.3
        for <mptcp@lists.linux.dev>; Mon, 21 Sep 2026 11:21:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790014881; x=1790619681; darn=lists.linux.dev;
        h=content-type:mime-version:date:content-transfer-encoding:message-id
         :subject:references:in-reply-to:reply-to:cc:to:from:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=/K964WF4wD4Kj2dcsvQrdSWJd/nNLHxeVrbRWCjXpRM=;
        b=k/s3ONirBS96ZXFPIq04Y+02HQUQdnwF60eq/Fz7RpEuHiFljzMS7NM0Rl3o3J3hQI
         hmWRyZcUAGz5rTujHqv5PATd5AD7fi0uVuZRkqYqv8z9y2z6WJoZkMgwY9Dr0JWuA8nL
         A8UiFrxFUH5q6+uCBN5REWEQ3pnpmOQ1VYIswOlArdhLCgpySRb8t6W811eddPFEfEvx
         Ak9mT/qIjyDU3MzXpf7RRhsXmbgKVctoseh8ywFeBYByOUAqUkRKzIBEAlvRRyWwaZSH
         JrxkXASKirgu9CbAEOojG/A5kx8u0v5U/+wP0WzP18tvDC5xXCXgiRjmNNSugqDboNy+
         +23Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790014881; x=1790619681;
        h=content-type:mime-version:date:content-transfer-encoding:message-id
         :subject:references:in-reply-to:reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/K964WF4wD4Kj2dcsvQrdSWJd/nNLHxeVrbRWCjXpRM=;
        b=xCadlSuTq6rV8a/M9HfYSx6RytBFpkKkmVyQ2LfSo64sMSCVOnhkbTOZNOSeKnwugX
         594lWOcTOMGk+WaioiSFyj0e/p8q7lP+PmaNG0ukYPIbX80gVmWWUurCiEdDhRD0SKzs
         LfuDoUBXOtTN90mz0cHRn3F7TKpvdGnyicW+bKdLsjLGbRFXDhm/5piciDKBNz98vUr7
         /BA2B9lE2rF2/k28kuR69Dnr1YEKTrayOvr1fOZQrNoHWDylPj/u8yhgO9fu/ANhWz5p
         TqfuGxflwxu9WhW1/GPfy9hAdHN0OzL/hDO4SIpXSPZqQ8YJ1iQuO5DWWtHYoP4q6imm
         FNKg==
X-Gm-Message-State: AFuF++ke6B3bUJ22guXNKjiW5WmFEcn1mQ3R1TrNxFhfB0HN7Y1VWub5
	9zIF4GXqWBkQnXqDRZIQOyJoYzCyUGF8UY2em+x7Mt7ZBM/TPFGpHjPaXybN
X-Gm-Gg: AYBFou1gN3erPq6mcPbwBrkc6YEzosg62FmyT6YXNZwcQ+PDWUzeCGHqRhHxvsasB/9
	B350zYQS3abmXizPneQ97FN1tf8K4C5uqXYolino99vk6p77piqO9uRrBDBShy65eDwFjr8U799
	gfNCzxN32KybcJGBtR99r/OUCb4jk5y7GOvl4XAVqkT33yi+UYqy2ExmeI0gA92ZcwhaYkTTxNh
	f1aQDRp2Z1M3Ijd+y2ZrcHgXZTv54FGwy0CB/DbGNMuSRa2HuV790FmRswy2csq9Q0K3lOKs7gE
	5ypo+T/i6AznA14HJ67pyms55G2bEWUKTRxAeODLshgYN6VTSHN4DxujF7+2aB4kcO8oafmbTbR
	+fjUHXumKbl2AAbqY8gFivcXtaHQuDDTBRHtddJQY5tV1FPmcCVsfAl4UALWKadROOExK6qGBl1
	EERI54I96IkO+mYtiylqJREHRfxxX14m2ApU9Sk98+6Qk6mhCDDQQdYoCmPww2IjZ/c54Crz8L+
	jj952rfHneAeQ==
X-Received: by 2002:a4a:ee0b:0:b0:6bd:f79e:501c with SMTP id 006d021491bc7-6ca9ab437d8mr10289601eaf.16.1790014880736;
        Mon, 21 Sep 2026 11:21:20 -0700 (PDT)
Received: from [127.0.0.1] ([172.214.156.87])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-6d1827d9e5csm461eaf.10.2026.09.21.11.21.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2026 11:21:20 -0700 (PDT)
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <0342bcf7f4bc6c4598ecbe58cfd8ec75505c328e.1790009113.git.pabeni@redhat.com>
References:
 <0342bcf7f4bc6c4598ecbe58cfd8ec75505c328e.1790009113.git.pabeni@redhat.com>
Subject: Re: [PATCH mptcp-net] mptcp: fix subflow bitfield misuse
Message-ID: <adbe1ee9-e975-221d-1cc9-5a3f32c46f05@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Mon, 21 Sep 2026 18:21:19 +0000
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

- KVM Validation: normal (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: normal (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: btf-normal (only bpftest_all): Success! =E2=9C=85
- KVM Validation: btf-debug (only bpftest_all): Success! =E2=9C=85
- Perf: Success! =E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_n=
et-next/actions/runs/35632757495

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_net-next/commits/ce82aea56e=
f1
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?=
series=3D1170553


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
