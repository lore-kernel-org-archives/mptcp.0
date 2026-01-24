Received: from mail-ot1-f68.google.com (mail-ot1-f68.google.com [209.85.210.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFB7D235045
	for <mptcp@lists.linux.dev>; Sat, 24 Jan 2026 12:09:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769256559; cv=none; b=fdJ5LBvVhZBD4py7xxqRWFzgYYUDeXrHCx16YrMB4/p+E/QTi+NkgJg9vUFOoFkB0hu56EZdlhXwoXfYhO0vwTP52T+Mzp4FrOA35LQ9bCdQOrlWJ2vpXsocS8Q8XmPtSImSreTAFRSaFGfpckILyFftBqBJcbwChDCJcMaPCLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769256559; c=relaxed/simple;
	bh=JCjZFRfwY99I5HsISZt+DZRw5cMJ1l5aPyfCbTDtExs=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=cAVuXqnjZf9/3Z4L2gNZSBSxMAPu3T0oBL6AX3vSStbqqjgs+dq9Nayv4fO9Qos3JKPmjgiGaw3M7IbFXqxg7EWNH5gUnHiPLeewp8QXKi0sUUalxMq2JzDaLCG3UYPhHNAs0dmZbTCe9PnMX+yBuTra4rT0VVFEl5RGGBoSAg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HaXgEPjp; arc=none smtp.client-ip=209.85.210.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HaXgEPjp"
Received: by mail-ot1-f68.google.com with SMTP id 46e09a7af769-7d148dd16edso2652150a34.2
        for <mptcp@lists.linux.dev>; Sat, 24 Jan 2026 04:09:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769256557; x=1769861357; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9ww4PLp+FtTbqUSjP5rFv1djukVtoS+6HQjSGTlMBrU=;
        b=HaXgEPjpdPLykkCOWMf9y6uq3plTv9IRNSepKO/mu5Qg8idivwdvmxhnmIiocQr8w0
         WIoWFqQAgp3by7vuyz5bLBCdX2gU4wHLCz3pdaU/lK11OFpmEKSxuSDhnrQw4dtINkbd
         jp3ly7Bs9T91b7KL60rey/924sSSRPhbPDuuuGV0XIvnEe6r0rqsSDbErIdc/2IF60wg
         hkowBvbbg0S87bSj6qmVn8JkSG1vTKm+/5Hroe01lrnmaVx2J0AFeiLzoahCYD1cBCJ3
         hsDfQ8XA760p26MjT4RmbAl+bFgxmiFgWP6cLUW+kMJ4cKk4VIooW81CXdgGyNrvL/Qo
         YN+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769256557; x=1769861357;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9ww4PLp+FtTbqUSjP5rFv1djukVtoS+6HQjSGTlMBrU=;
        b=AWqE+9FFWf9ArkN0VlRwm+9PkIKgNEzJscRHdaA0PbkUdHtZnE0xKVG7AFVuepTmAM
         0p8Wk4beLbQpjeaL3uPenAmHsA4MEHZ14/24f2iXHBLe3C6tzvLZN4x5sUjogJDsu8vZ
         nudSaiKH12vG5500+RnU+2irnoE/boI0sd15Kic7+Oj6Z/rkKMGYoWF1ywFSxPk1/poO
         SwXy9GrurnAdE3Dgvu+GnBcJovzgw54B17OONVPmq5GZ8D6cFq84ezmOlejAScFBvN+/
         RyZoOHtbE0/3U4J4/WJcqnqc8SCU/wmcPnenYPx0/0NYkQh+CV68V6Mb21kMJYz0cXo1
         omSQ==
X-Gm-Message-State: AOJu0YxE/wEslWc7D17L9Aieg0VKXh8RYgpnznRoPMdFAAqnIP5hmRlS
	8VGSjW+BkD/yoZ60WYK4fis9QE4CUwolQIDZRpq/MHGQqCt/SKFhGj4=
X-Gm-Gg: AZuq6aKKrufWPesRcrRUSTfHbsT4FuN482hPpJxV2f5Th0rED81LTM7oVgymntGxgsi
	N5ATVP+zNdenTD77RENrRlbmWW/e+XG3MI2cQGH4+fEoMoa5JnGzlh20e8CzbC248yy8JCDF94U
	gpaZe+/ceERVXWkpg+QeK2AmdWTkoWyiu07xF5L0MFrlOJn2Epg44reP/lrUAIa3nH16MBIMofC
	63dsYwZ3Iwa1/4uJQo340UfK8FcyZ01PdNuR/4BPDkjgdOSCF9+zATMHITRq+2yjLpus+fJCVm9
	Ej5sERwbsfxZZ6+NV51JXfZcxdoQtIGa8BJSmdfRLbnx0c1T/ys10cz/gPZeUXdKsmfeY9NFrl3
	eHXkK43/BY+cDfyp0NDCrmYIaBRhfiRoc1Lr8dK7JHn0xJ4d17yS1awS87FgV/xd+hzqgydssN0
	M52CrBR0++0MLZh885Z8E80FVV
X-Received: by 2002:a05:6830:3785:b0:7cf:dc0c:8cf6 with SMTP id 46e09a7af769-7d160b30cabmr2882244a34.8.1769256556686;
        Sat, 24 Jan 2026 04:09:16 -0800 (PST)
Received: from [127.0.0.1] ([52.173.219.146])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7d15b346e03sm3832416a34.1.2026.01.24.04.09.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Jan 2026 04:09:15 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Eric Dumazet <edumazet@google.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <20260124-net-mptcp-race_nl_flush_addrs-v3-1-b2dc1b613e9d@kernel.org>
References:
 <20260124-net-mptcp-race_nl_flush_addrs-v3-1-b2dc1b613e9d@kernel.org>
Subject: Re: [PATCH net v3] mptcp: fix race in
 mptcp_pm_nl_flush_addrs_doit()
Message-ID: <9243d04c-1767-7abc-e61d-089e2ccffffc@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Sat, 24 Jan 2026 12:09:14 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Eric,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: normal (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: btf-normal (only bpftest_all): Success! =E2=9C=85
- KVM Validation: btf-debug (only bpftest_all): Success! =E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/runs/213143=
23492

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/43654e21c203
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?=
series=3D1046586


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
