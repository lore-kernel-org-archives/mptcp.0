Received: from mail-oi2-f13.google.com (mail-oi2-f13.google.com [74.125.231.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5634E38F65B
	for <mptcp@lists.linux.dev>; Thu, 17 Sep 2026 03:25:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789615537; cv=none; b=O5tH9YYll4O/ErlcJtYlgnLPK9+ltwElNq1dCCEpetvlYFISpzGWYa5aKYScat6Km62PrGluLH5DGLnDAgq19EFwwS/VNb2hTbYZ6vJh2UT5WzTOHM0G6VPQdtpfWUHISMB5wx8VMvPrt9KcdP5u+mN3uRYnOAGthvfTXqjr2LA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789615537; c=relaxed/simple;
	bh=pz8bARLGJ/BgL6WvpEiGowEybLRzRvOjZvgE4/lum9M=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-ID:Date:
	 MIME-Version:Content-Type; b=hyH8aTOP5uQ+enBVWlnOf4v0+vGDMRrsBtelAQJgKWkNzulIo1f6L1+f6WS9DRRRbdR1TIFQA+sUApM7tcaI0TXMaQJiX859h/6fyD3/2utkui/5Wdrx4wGJmpb8g/NOaBdDr0COZL0ur/FgdF1NwCb+pA/FDX0a1mOrqL49BPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A7cMyEQ7; arc=none smtp.client-ip=74.125.231.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A7cMyEQ7"
Received: by mail-oi2-f13.google.com with SMTP id 5614622812f47-4c206dc8b0dso287073b6e.0
        for <mptcp@lists.linux.dev>; Wed, 16 Sep 2026 20:25:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789615535; x=1790220335; darn=lists.linux.dev;
        h=content-type:mime-version:date:content-transfer-encoding:message-id
         :subject:references:in-reply-to:reply-to:cc:to:from:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=4ERBCurgzzsk/2RyJ1sVaNcMIHOdvvbaKvTqUEiGyjA=;
        b=A7cMyEQ7AFm7+rixg+ZNO+OtY0AO7wnLq+hAgDvOjGUJDafTQKNVV7XnEcDgWwmZMr
         /Mq0ymOd/1XOic8dCG5rkeY7VU+iqYdW8Z2gI8mrAi++vMKDqX0j1+EY5htVIMPOKqug
         EdYPeX0/w78rgvsJEe9k7pN1pbCWxNJ9Am7UMms6Vd/I1CvRDOkp+j43tiWuKINTd4+0
         VCahqKXfhniS2HAWO4Q5NxXsq8QTk9gT/8l+ZXgmRdEcn6POlCM06ZXhNZCO2ql5/4ZD
         tQBXymsvWZv65WszWfp3vUggOJQsitu/fD/HmMpCuX0DgBteaZzeTYDPo2MvjRI9BoHZ
         vn+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789615535; x=1790220335;
        h=content-type:mime-version:date:content-transfer-encoding:message-id
         :subject:references:in-reply-to:reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4ERBCurgzzsk/2RyJ1sVaNcMIHOdvvbaKvTqUEiGyjA=;
        b=vyTJBQzugMji6T2dFxZMLWzH0mjKuKgiLR5MyFsDDp88epQlF6t9WIC08It3t8FQ0a
         bu6qOARoNLX10ShDCrvF03Y7lUAx39OqghzS/x3FQ9lHFlt3xVUbbO0uH1tne1xKUy4J
         GXAKe9YLTgtAe/3Ois0FMefChImLqV1PEAJ2p+/6gMjKWElDat6IWvebhsvBcGOIbLxv
         kkhibV1y6CfPuSf/S9URl/Iwk1cMOuDeJydpxFyqW8hHZaaJfEgopq9H80GgEVmm82Br
         +OTVkCW5ZBOwsWSPQ0yqN26O8VaqEyPo5GtNkt8eDeHLbeKI6z04/k9k8cpf9zk78wXw
         1EYw==
X-Gm-Message-State: AFuF++kEa4rq2PzaO4+bXTiPdE/eNGZidEvtdg7+mIN8SxkyZqQVOaSE
	1vi6HWTIZS1p8mdtJQ3cU7mMj3h0S9Uo7KvAfjgIiykjRiTANoIt3RlFp080
X-Gm-Gg: AYBFou2TeZtP+ZqOQMlNr1KasDY5om6lzqjaAYmwtpP1Z1KalQOsN2G7t02vEl1xBeR
	6KIfwE2FIWG583iaFAS/pUz3YNdv2V2cl+osEA8Kf4fjIFOobxekOUATWWJMLflMU9Ff88+kjgi
	ymh8Dp+hzNU+PMjU79wwtnAiHVJGVnKRekFPgVtZ0ihOYEs3ZfpFPpwxTyz83m9cxKh86/KJJmU
	6gLWiYK0QLAm+AWFO4wFI9UnVGUmFWfHfKN8kCux8Gph1Qb6/6kaRhnfX4WHoap5kVpa5PI4wWf
	I/i93M3QNppKCJc9qS7HhyCv2Jf44Mtx70pvimDaPqjiGOTOIX8EYJjThXSDXZoeZZ5HLXirGJ+
	LENwwr7UGIOKgzrdy0wRN8gIkNghZm3WOlNB9DeS+L8uppFH2QY4nNSojsQqhnqqETRtGyAfkW4
	g1oT9PHHkJCfNoq7Wij9vVtewuCkBlSoEGTznoO946NEK33qSTj4Po+xQG3VG0oMoiuTKMEf5gt
	P3VaNNBKdVh
X-Received: by 2002:a05:6808:4fdf:b0:4b9:e65b:8c33 with SMTP id 5614622812f47-4ca4c8c4526mr6235981b6e.33.1789615535035;
        Wed, 16 Sep 2026 20:25:35 -0700 (PDT)
Received: from [127.0.0.1] ([172.171.13.49])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-4cb6a3d7a4fsm1633179b6e.2.2026.09.16.20.25.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Sep 2026 20:25:34 -0700 (PDT)
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Hangbin Liu <liuhangbin@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20260917-selftest_config-v1-1-bf25ccbfb18e@kylinos.cn>
References: <20260917-selftest_config-v1-1-bf25ccbfb18e@kylinos.cn>
Subject: Re: [PATCH net] selftests: net: update netfilter netlink config
Message-ID: <520d28e7-3efb-b479-86b8-6641379aa790@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Thu, 17 Sep 2026 03:25:32 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8

Hi Hangbin,

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
et-next/actions/runs/35175050231

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_net-next/commits/a1c252f7ef=
90
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?=
series=3D1167024


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
