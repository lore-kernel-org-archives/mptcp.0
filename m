Received: from mail-dy1-f169.google.com (mail-dy1-f169.google.com [74.125.82.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F93A3C07A
	for <mptcp@lists.linux.dev>; Sat, 11 Apr 2026 05:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775883641; cv=none; b=F6XIPdxxP+m5+n4bBzmlfJTiEf2gkY57153w0nJV5D8dnpKJgtgpvaolbwbNwslbE+W/Zm0LXI0MUvQgYdLMCKTm+YOJIqPPBN7szfbCEioy7da63kBYZYlr97z7dCKYPTdZ59fu9k0JK/UAgeHCjBL4QMckIPYuDV9+/zlcmv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775883641; c=relaxed/simple;
	bh=ykh76M9n2JYDPo7Dn0bTdGHOkO418uOoap3eliMwOl8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-ID:Date:
	 MIME-Version:Content-Type; b=PrOI7EerrFS7ClZqQpXnrEUl8N7syZpYhG2i7KP0m1bDZxGjrZ+OhQ55Sl690e0f+Vcykq683kLM5Jno8EqEmL2L+T9tvI3qPLTgDcKshU6ioxNCb8XhY7wPVI2auflqSuBHIsdQlTB4N0t1JjN9rqauNQ5QFuy2XmSQsT1RpDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aMgmJjsJ; arc=none smtp.client-ip=74.125.82.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aMgmJjsJ"
Received: by mail-dy1-f169.google.com with SMTP id 5a478bee46e88-2c156c4a9efso3952740eec.1
        for <mptcp@lists.linux.dev>; Fri, 10 Apr 2026 22:00:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775883640; x=1776488440; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xsURKGnmbM6kXngKz/J1aSiLPDXCmExQ1ZU082i1dYs=;
        b=aMgmJjsJ/e7JDh/G41H9ONl/FVTQRe942B2SzJ4De234gfITaRUYYdWQapi6AvV8S+
         kmF6XNUkqRdqfMsgb8vKmKTTSouXxX7kklD/Bb2n6Cc70PNy6iG+RtqsC9RPbF49vf3i
         PBlGLW9djZg8kS7fUbyV2fYB9d0/oenmlV2wgaJsO8Cn8B604ee/oAK1Galg3A6zRcuR
         OmxJA93DcpsEQbllNM584FUokPsU1mY7i/lSrXorP60eh+ulin3RHWMXu7uxrS/UVICr
         n49Impqk6R795fyDCobTtqxAWk+tjEb1p/xesWEynie/dgJDl02BxGN44M3c1utzJGiG
         b6mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775883640; x=1776488440;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xsURKGnmbM6kXngKz/J1aSiLPDXCmExQ1ZU082i1dYs=;
        b=HkvSo4qkLPcSgwUwBl0xpxknMen5Sqh3ffI67X2qqvCTBzEJNmT1N2VLVU7pyLVD/B
         mDIJzr8aT2sHLckaNc00Vh3h/YVc+y8SR0Gwu04Cy53vUeK1GKqwQwKQw6gQxjtaq/zn
         BVgvWvc4u+r05h7KslczvJdSJN2CHHhfLEoGV+0iScTDpAcXxknl4yt8q07zUNUOCJ3d
         PAJtBWl4swfW4OwRk5nwFuAdUeOXHUntoPrx6AEvPqHV2Ifa4K9EpCp0q/smRoHkabKD
         rO0ZAWyYRVTrmfvH5xJO5PNZM82jGYB/FzXNWKUfATu6v6BTC76H1rokCMhwpmqpAe2Y
         nurQ==
X-Gm-Message-State: AOJu0Yyq7+yeqKEolS+Sqn8xwW4DZldv/CPJwjJbhBLTNNj3ZVSGmDX2
	/Xd4HrPy/ILjYhDWZdu6SmpO/DG5yZtrmr3Ga/JoW4OaErkKD55a6IY=
X-Gm-Gg: AeBDieseBefOnycVpgakiYhfTdmaqhs9WKZQSMyWzeH9eOkKAdxKprUrp93TExkfcFr
	qO/gays0nnvgA12I/bjzgm4qBIrKTxY22cmyGdI+2B33BURku/DpMJOkUNE5NY9a4Nn2pVHj+zZ
	jMymat/PHjyFxbEk1X8wWVVeWbnRsNAIb5s5UXK8AttkICjqf3+4Rh7+tsjHmZtGeYWWIcCfmNN
	GNBJNSeenTbMggXmj5TyNvql7AJtbEwhQ3NjR/zATcePzDR9plBDaZVwTfOb5Fc9hWwecsiRarP
	qwt/tQ8H9r6GMWfY3AmAG7Yb4k4gUpwPb31XTp9TiIbMGsoe+ix3IymCoBjhA3bv95RJQynAVcx
	SHMhADmPQhuq4QXij0b/rSU6wCQRSQve7m92X05zBioSrvHhN153LuwkAA6/l6O+p3j1Bva1aK+
	mk0FHRVRyy1i0Er8QBOXnZ2N1/AIV+4gw4qa2RqNI=
X-Received: by 2002:a05:7301:1f10:b0:2c0:ba91:48b6 with SMTP id 5a478bee46e88-2d5898ad1a3mr3773735eec.26.1775883637742;
        Fri, 10 Apr 2026 22:00:37 -0700 (PDT)
Received: from [127.0.0.1] ([172.182.200.148])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2d55faa42dasm7409756eec.7.2026.04.10.22.00.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Apr 2026 22:00:37 -0700 (PDT)
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Gang Yan <yangang@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <cover.1775878944.git.yangang@kylinos.cn>
References: <cover.1775878944.git.yangang@kylinos.cn>
Subject: Re: [PATCH mptcp-net v4 0/2] mptcp: sync the msk->sndbuf at
 accept() time
Message-ID: <ddb8c55d-d3a4-dc9d-4bd3-cab6cc4d1512@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Sat, 11 Apr 2026 05:00:36 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8

Hi Gang,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal (except selftest_mptcp_join): Unstable: 1 failed =
test(s): packetdrill_mp_reset =E2=9A=A0=EF=B8=8F=20
- KVM Validation: normal (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: btf-normal (only bpftest_all): Success! =E2=9C=85
- KVM Validation: btf-debug (only bpftest_all): Success! =E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/runs/242743=
65063

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/414e68b0e64e
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?=
series=3D1080031


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
