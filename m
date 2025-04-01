Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C623C2C6
	for <mptcp@lists.linux.dev>; Tue,  1 Apr 2025 05:43:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743486186; cv=none; b=hhS3vlx+aYEqEroPpIyDHOHeD1jwIfxREhIu+kiADcI4ZSuvdn1MF6l7nbvDRZITjdkzQzKT5RNsVdifUpzm82GOqe6ibgJcUIfogaLmdAuZIatEol1eJm2EjxO/cPhJewBn5ocag+vZC3G9ASP1HX3Cu6tYxcGnRhiuKBe//eE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743486186; c=relaxed/simple;
	bh=4agGAeZjs0CXf7huMZzsvMExH1uUWf5+n0v2Gs4eGuE=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=RdsloynVo95GpvL5hroLnLe9u1jZh39yP5UNh2X0y4NVv9AMy0EroOBoAPyQ/J+08GYch73kkGjCUrsZ2MI7ya6VA1POiYol68GmqCsD7IWZWc236UDt5r0laSJ0M47AZynJC8KxNQu8bbybDXwIZOa+00XL/OSZKG/RG0soWr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jO1WHwpJ; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jO1WHwpJ"
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-4774ce422easo53863271cf.1
        for <mptcp@lists.linux.dev>; Mon, 31 Mar 2025 22:43:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743486183; x=1744090983; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZyGRbiLcsVXMwWnnbT/hkY/uQvrjIhdZGMGgTjsHlPs=;
        b=jO1WHwpJDYEO/ge4m6MP3N4Z1B3JSDcpILZJgANy6ci2n4UnC5GA5yDxTK5tdnbUMm
         quO4hqmWF+1bZPK1Pg8zkpkO6GAQfZfm2F3oeHJ7r2b3D1G8SeA9W8fLfuGQLH+44vho
         NkWB0kDFAx8go+PREyByVvvjwLAUMEFegL8s6eUtepX5JEar7VJbyn6inAGV/TWa4BD/
         sHVmt3QKESptTVfTYzQTyW4COgoHBBTHOyrfKWWO/LclnXEJZP9Jm2Re662jA4tjT3yb
         HXa9bZVT0rhAAGEP8zXrrxvqht6p6HkT5gS0EVWcK1W4WhgsoUo1A+fl+eK0/GZ2NREe
         zSzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743486183; x=1744090983;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ZyGRbiLcsVXMwWnnbT/hkY/uQvrjIhdZGMGgTjsHlPs=;
        b=a/WfQuquVGjcPmutz5QoNHNV81gqRpvn5gyw6b0i3GBejUGLHIBVXDN0dsxO8U+nwI
         7itIS5/rBNXyCr3/wHvLrfirdn2aitEW5qPdvFouo2MMqCS4tHJWDWSFONlSao1C8FMW
         jDUpkmSX8bRJLR7QgBOAaHHlnJaH931sbu1O5kemGF8UbSYqwvMk+SvIQPpG+uBQ0eLI
         EjUNr+7ty8Wgbc6S8rg4wkzqHkdGh3WRGc8IVpXrBidnvxGWIvhDe0nXTc9FIlSNwoo4
         SZiVBRR1eIGkjE/BCIkzddF7Z25bPML9PWYWeKsxqE/8xEGphNIVNQxj/vW9Rsj0c07X
         rRMw==
X-Gm-Message-State: AOJu0YwL+xSd60ddOASsUSE3uUCUBM2gp8XByzVA282L7llTbmu7XE43
	vVozcsHUAGCREVGExjvJ+akrV3UyEBsRBGEbknJCf7eAmFVCS8K+nFfg6xM=
X-Gm-Gg: ASbGncvINkRIGrKxK81vtURtRYHCE9lLsstcll08Xv5L5/Khex8jJzPPKetsvf5u+l3
	mh8Rbx3d7Gf1gfk8axkNpnSa6HWro9/jyM4bGvuN21mOxsQgvx3OAaJO5OyIKav8FCRP1n70eAJ
	1ka+1gtY3hBiJFbYQccfrEDyrE19jhZi7AEoJ6X5jFlMT0lwRQkzEqQkvop8M86sVtMvkPcTkEE
	bncpEuYG3TE22Js8aSXH/3S99yimiRO53RcVSlwssCHQblsFRi9PVKIDNXBsh0PrLM2ksHtNrc7
	Cbd3XhdjmJJqX1m2CbN+NtWZR4LhMsLnpsu/G7vSguJwN3SgAqd+tEY=
X-Google-Smtp-Source: AGHT+IHqzHe4y+H3flRqe932b2bc9cvTFYQphB1/Qdc+34Cvf7gh/p/a/loHeTuZ1mFvmU4cSLhHdA==
X-Received: by 2002:ac8:5ac2:0:b0:476:a895:7e87 with SMTP id d75a77b69052e-477ed721d9fmr114276951cf.48.1743486183353;
        Mon, 31 Mar 2025 22:43:03 -0700 (PDT)
Received: from [127.0.0.1] ([20.42.17.51])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-47782a1031bsm61223531cf.10.2025.03.31.22.43.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Mar 2025 22:43:02 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <tanggeliang@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <cover.1743481566.git.tanggeliang@kylinos.cn>
References: <cover.1743481566.git.tanggeliang@kylinos.cn>
Subject: Re: [PATCH mptcp-next 0/4] BPF path manager, part 7
Message-ID: <659cc413-bd42-338a-d85e-a0e7fdd3f0e2@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Tue, 01 Apr 2025 05:43:02 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Geliang,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal: Unstable: 2 failed test(s): packetdrill_mp_join =
packetdrill_sockopts =F0=9F=94=B4
- KVM Validation: debug: Unstable: 2 =
failed test(s): packetdrill_mp_join packetdrill_sockopts =F0=9F=94=B4
- KVM Validation: btf-normal (only bpftest_all): Success! =E2=9C=85
- KVM Validation: btf-debug (only bpftest_all): Unstable: 1 failed test(s):=
 bpftest_test_progs-cpuv4_mptcp =F0=9F=94=B4
- Task: https://github.=
com/multipath-tcp/mptcp_net-next/actions/runs/14187422547

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/fc6a4ffc4da4
Patchwork: https://patchwork.kernel.=
org/project/mptcp/list/?series=3D948762


If there are some issues, you can=
 reproduce them using the same environment as
the one used by the CI thanks=
 to a docker image, e.g.:

    $ cd [kernel source code]
    $ docker run -v "${PWD}:${PWD}:rw" -w "${PWD}" --privileged --rm -it \
        --pull always mptcp/mptcp-upstream-virtme-docker:latest \
        auto-normal

For more details:

    https://github.=
com/multipath-tcp/mptcp-upstream-virtme-docker


Please note that despite =
all the efforts that have been already done to have a
stable tests suite when executed on a public CI like here, it is possible =
some
reported issues are not due to your modifications. Still, do not =
hesitate to
help us improve that ;-)

Cheers,
MPTCP GH Action bot
Bot operated by Matthieu Baerts (NGI0 Core)
