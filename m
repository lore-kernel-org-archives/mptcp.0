Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com [209.85.219.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17BD1194088
	for <mptcp@lists.linux.dev>; Wed, 10 Jul 2024 14:43:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720622633; cv=none; b=Cswn19oGpiyMDMzc6o+kl2GC8uX+wQIDN0/indFWlg9BgoeT+4aOwaGivYcmpuKzfzxDugtC3blkTmyvUm7eyPnift8ER73OmM9IkC3X62LZe1Zvj4qwAxdKUkEhizPDJpwuMBKnM2V/Kkh5FFAMNzn7qr85NaBaO6CBA738mN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720622633; c=relaxed/simple;
	bh=TXXfWdwdxIqkSft5pBtxZt+XjIoH8JMR047+MZ2ayJE=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=pv0Kh1kq6VQH64gAV8btP/XVd9dzZhbGJmabaKJjFlG+0nEV2fqoVhDUBPjwYLbqTo2AFX3w4PeSgaqTK0Co0rZBampaeBzGj5rJU8ETFvZi9F2h4OYksV2dfGQVOjRLbFS6sMn85QIP81bdwswjLBL86rG+j/kmsMZ+PyFucAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ak0fX6nZ; arc=none smtp.client-ip=209.85.219.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ak0fX6nZ"
Received: by mail-yb1-f169.google.com with SMTP id 3f1490d57ef6-dff17fd97b3so7086688276.2
        for <mptcp@lists.linux.dev>; Wed, 10 Jul 2024 07:43:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720622631; x=1721227431; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nidmLKyJUqsa1KTbCK6hHfA/4ZPK+/WYpijMf2Mf/M8=;
        b=Ak0fX6nZ5A6Vs13DVfw+b9L79+ewJDygZzbI87FxjrBJWg7jrGJ7bn7yXWDgfjAOLL
         OHfB5WubJKDb9H0qqzJrK8QsfqT45tzdLv9MylsgRNxz8ALwWwdgke2++LzkaamUMZSv
         WrpZ3iNCplsek9F27QfVSBEEWcq34aNw6kashiELpJ3PbqzSMEysEdBJ4Q7Gb/9n4KDL
         5doSlfK23WjEsFLA0WrCylxR0qVvn6j9GhT45MY3ZJILUhpIYHwJYCRyDgevD27Qdo56
         FRP85Kvsz3fJLhxvZwEGbVPNEpH40v19WZd7XebbmPwXRHIaGwgaawlkRkNlsXaBAqql
         Kaag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720622631; x=1721227431;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=nidmLKyJUqsa1KTbCK6hHfA/4ZPK+/WYpijMf2Mf/M8=;
        b=PrzaFg74SnP9V+umxucofxNOp+XS/eAEfYjvK/hIETCGJqirLIlYQD2LkCzwO7VCfz
         vh5BvzcO/GXFEy990XuEAYQx/FsgVebXUjL+HxucGP4/wug5XCluTsngcPaYzc1F+Xp8
         0UBd4WYNt0nkXZ3S6VoUS7uY3Bi105558O5aCw/jmNXR51VXuWpASuDQ6AZ7a0pQgk3U
         Pu01am60+fge9GvUECHtiAzPxur/1X/6NLEIZF50NidH0h/dLzaMfn94KeA7bwL717X7
         p0diBsWi7Hmu+fxHc4labLWDOgxpUdLmytzVhN1sDR+RDDhWvllh8D/n2UVR0GcYuB7K
         hwuQ==
X-Gm-Message-State: AOJu0Yx0EHdFayrW4SgdxMg5Jqk2sBRyOOgpMuym/gOCkPYAUkmJoPFx
	QGCi33zdzYcdV9hiKQKWevk1ft4N5/SpUgTCSlCSToMmNdiOpsw=
X-Google-Smtp-Source: AGHT+IGE730LOYWHemRFIQG0VnHuX0G+yzSddAu2BZrkfpbob3QQ8LDaKGpD1ggRJDtEBCOJLzV9FQ==
X-Received: by 2002:a25:8390:0:b0:e05:6455:41b8 with SMTP id 3f1490d57ef6-e0564554e4fmr1921123276.31.1720622630978;
        Wed, 10 Jul 2024 07:43:50 -0700 (PDT)
Received: from [127.0.0.1] ([52.252.110.197])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b61b9c4d9fsm17804476d6.3.2024.07.10.07.43.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jul 2024 07:43:50 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <geliang.tang@suse.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <cover.1720618186.git.tanggeliang@kylinos.cn>
References: <cover.1720618186.git.tanggeliang@kylinos.cn>
Subject: Re: [PATCH mptcp-next 0/3] get msk->snd_nxt with READ_ONCE
Message-ID: <4edd21ec-8118-4d43-310d-9e513848ba86@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Wed, 10 Jul 2024 14:43:49 +0000
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
uns/9875728508

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/f8f3a07b51e8
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?series=3D870130


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
