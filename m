Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77DA5335A7
	for <mptcp@lists.linux.dev>; Tue, 10 Sep 2024 07:02:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725951732; cv=none; b=pWEt6FKbfdUzw1TOkL6rFRtiC0n3O6viOoxjCZKC2/nW4sKQbPgwCczq/vN8Xuykj9R8Yzcv7pfqy25576cdzolGXEcGyG5C+JDfTiwKrlQ9CWPrYHFTOMUcdGcawDh+FyHW+PBrMdKIv1Vn4g28LG+8kGvG1hZE5iAFhRenFFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725951732; c=relaxed/simple;
	bh=RaIMb6VSeNemocyc4DhyYsDL034PFQou7dd56qTzJbE=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=LKVhJNgilSlgByacE2Jo6CWqhhPwWBI+RnYrLrSDCUv7fl59LNs1bkn3CraWaPRCBSVC2/9rI09972mdFQXmwmyYrypZcu+NWbsKIZVC3bptMUvoZmDGt8erUlVeppkLGz9Hp8imqwQ5VSIYIx20J86RexNnV02j0pFWsweAYDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V3tYwOXF; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V3tYwOXF"
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-7a99de9beb2so212243185a.3
        for <mptcp@lists.linux.dev>; Tue, 10 Sep 2024 00:02:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725951729; x=1726556529; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mD+/FK8TXypMQDMSZsS9Epr9lFzr328NKwpaoV5JIm4=;
        b=V3tYwOXFHaRInWl/zaw+X6Pb7lYuChPir45DxDqVhg+W4/oKQCynXtS3KwsuUaYfla
         s8+OQnxuYyPb189vetuC5OWO2vMSJgXBLxDpnBWiwx9/l5ETocgsuMDlIWeT28E/hnmr
         saPu1KCaLWSYG7nQrgqHtZUWVyTzXKzeSd2HtMzxSaJWChmXnIUwInQru/9xRuEG4cZL
         H1ofUEzR0iwh9yJxHetJSdLTMe04JxV3uuTzrIM7LcTDPYTEz3X5O1dyZukKRFBGYKNi
         SMTnnqdv0Mb4cGKzEslD9WY+DkEbYyOSxks6xH0OzsT0FFictaVnYPmyPzz3XdqZtBcq
         DDrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725951729; x=1726556529;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=mD+/FK8TXypMQDMSZsS9Epr9lFzr328NKwpaoV5JIm4=;
        b=eb+lRdzPUjRa0L+7UYwNai60jBvmib8YTCozoRbPgo+Lobh+DHfmpUzRDZ/gwucDEn
         pleBkRo2VHBLEaGRjCgaMgwlEVZVeT2BnBCaL4Vl3ho+1mo+Hr0tlRT9iIrz0nWTMhsO
         TT9S4DX92X6dlx2ClFLlJJv53S3ZSS3kMdNZBVGkCpwhI4thG2lTQABa+OreYphhLkCg
         OltWjAxoWRS+4RV4j1kPjbv38sJxe3n15W3XqrwuW9kHPWXIFG5qv74dCrXNKCsThCcv
         QkOWxIzpNWSR2l1Ppr58zWjWw5PkEkuZp0KmLEtiG2PkK16xmXlKdFlkhE89hxP4VwR8
         2Oig==
X-Gm-Message-State: AOJu0Yy46VMSlBG97X+iZqxJ3zA2KvFQ6hVzldf+kEZnwIsEj9qMQRTm
	VpzkHntsZCIYmdk+OVRmesp9DzZtY1buGBFlD+g6w0MHvXaFlv2nAm5r/h0=
X-Google-Smtp-Source: AGHT+IFkr0KNAx3xA1PBr0+9SZdLMExh2Kolx+LGyXBC0510P/kex2v5JWgHSPybZLSQvYXCIalKcg==
X-Received: by 2002:a05:620a:1724:b0:7a9:b9c6:ab4d with SMTP id af79cd13be357-7a9b9c6bb10mr771198385a.51.1725951729127;
        Tue, 10 Sep 2024 00:02:09 -0700 (PDT)
Received: from [127.0.0.1] ([4.227.175.176])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a9a7948814sm284732085a.14.2024.09.10.00.02.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Sep 2024 00:02:08 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <tanggeliang@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <bae090f6945a2621f9ed4de2cb0e29d772a0e760.1725948163.git.tanggeliang@kylinos.cn>
References:
 <bae090f6945a2621f9ed4de2cb0e29d772a0e760.1725948163.git.tanggeliang@kylinos.cn>
Subject: =?UTF-8?Q?Re=3A_=5BPATCH_mptcp-next=5D_Squash_to_?=
 =?UTF-8?Q?=22selftests/bpf=3A_Add_bpf_scheduler_te?=
 =?UTF-8?Q?st=22_-_drop_has=5Fbytes=5Fsent?=
Message-ID: <ae8709d8-09e1-351a-a00e-d0d17848a83a@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Tue, 10 Sep 2024 07:02:08 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Geliang,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal: Unstable: 1 failed test(s): packetdrill_add_addr =
=F0=9F=94=B4
- KVM Validation: debug: Success! =E2=9C=85
- KVM Validation: btf (only bpftest_all): Success! =E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/runs/107868=
55759

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/baeab60c0af2
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?series=3D888718


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
