Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AF2431F99B
	for <mptcp@lists.linux.dev>; Fri, 14 Aug 2026 15:22:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786720955; cv=none; b=b/eoeQPFZKPYozHuDEBojSvQ2PCLBBcUEq/wBx+PpcUg5gY9sFMGXuKQ23cAy6bpUjfAo6fvFXPul0Elwz7jzsclP3MXLufjcKzVwozsI6WrnBvPGz+0M57ydE4qy2F9ZbIFmOkvvijeqCYgys/Md4TCmQ/H/wRDCd3a0yrWMzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786720955; c=relaxed/simple;
	bh=NnFM+xDeQlOalsu3SywL5l8hASC1Tjt8rIoP6qPMo4M=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-ID:Date:
	 MIME-Version:Content-Type; b=TFi0G65FJnDYkrM1agXaT3NujBxirEMlobQRnwey8fAWSTGD1X4YnBUdw28SZWT2hz9Cxx06Jy3Ynd/3wq2gTtYkM7R3sSxMqlsQvIbViPXcXrzsKKtEiDjw3jcP/KVmtEVFT2NceZenfFXO4gsFs7b60P4gdTWd4ms9ejHMhd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jBXiPxjG; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jBXiPxjG"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2caced6038eso13435305ad.0
        for <mptcp@lists.linux.dev>; Fri, 14 Aug 2026 08:22:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786720954; x=1787325754; darn=lists.linux.dev;
        h=content-type:mime-version:date:content-transfer-encoding:message-id
         :subject:references:in-reply-to:reply-to:cc:to:from:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Mt/SVcJZ/ErNFulh3CwpffYf2h2XSfSU3o9yR9PDq38=;
        b=jBXiPxjGsPHCLEE8R9S7dvWqCY7CMgE6fLPoiYFNEi7tO+keyRzMlQ6LX4ORBBaOry
         r/GzDKFVlE2UR6YSMeEV6xYZ9Ic7RF7jwK6KpGpDO69iQcZOCAk/QTrKkRndqIIkY4vQ
         4DZBPOdPU7t3jlngF5iOFy7iX2Qov3i0lRbRwERiaJOSh3GDhuzEGf7iwEiMAXMpkivy
         UE1DwxZlKJV4+VEXB7ezp8RcX5FRxpPcphXbFFf7rmbXsXVfqcPrF4SVCcEsYzxYWBE0
         pPBcAtAfvUrXckWivK14LqU/Dv6lyef5anWJ0thRuhmPmoxYqgjZ5GpnB0FKcHqlib0Z
         YrzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786720954; x=1787325754;
        h=content-type:mime-version:date:content-transfer-encoding:message-id
         :subject:references:in-reply-to:reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Mt/SVcJZ/ErNFulh3CwpffYf2h2XSfSU3o9yR9PDq38=;
        b=rYI6nkwbmqRiFV7I8SUmtvi7YSC8calDbrcz+ASa6S9psfqK+7rHASSJOEZL8EmPrW
         dNHBZgBhqMSY3jofDlt9DQTAYj7nlXauCQQl29Mb3YZA4crSsgxes/cU7o5x2M9vPoo/
         7bfqe9SV3GDQUqcddwBIidEKtB1mJrrEnYWJC6zySLK8rhF+Ndh2avwsEwRXNU77nqpZ
         mCQ54EkC1NQWGcRaU3F5p8Vmrv2Itvoa85jMCjS9E/zA3s2drIfFa6E0iub/InA+MXvC
         bH9mir3doMoyKVUEKiivQH/xug6scIk25pqdiVuOdrl3/AYqhw5v1uM0lCN6KudEWR4m
         D1ag==
X-Gm-Message-State: AOJu0YzDxvIFdc8VVUVeNzK2D7V3yG/sAXIK3Dm+1c6PzBjeiZ0yXjZj
	pzAgDvxhJZ/qFPZ0a8uzV0vtR1LeLPB3a5pzyZYp+WJmJFCA896BQ/dgZbZl
X-Gm-Gg: AR+sD10zBDeFXOr5eSLSUIHGozy+Xl90Watr9Iy0oP412Ce/M8Ue+M4vCAah1t2ZOLv
	294MZX0t242Tfmj3WESbgoTtfSJ1iy+hQff7jzFXQUtGgq2Bv2vURTv/mT0HNAGnDCDeJpLGmx5
	LqbiAnNQO+7Zh7tJPd8tXJxg6HWi8popFYj2HkVOfnhuWxJ6+csQSSpsOn3o9+hcpmyWQR9NFZM
	zhTL1Vf8QggGSlB63Ojz4qe70xPg9IQv9vU8gU5li+Y3g6WIfGfUXWRtVvxx/KepC9/FkJ39d6W
	U0Yd8oHVlte2OnGIp6ynbKoyujS/R70cdSUpSwv/rvVmo20WVl6rc0ajIC2qdAOtpIsvMMmrUX6
	ESe0JL10B7h4IlFslepJEWD85sqGf111Gk6OfJWcOdSj4nwUutmnBojvROigZDgAEnGTHWcsaHM
	gbxreLScNYjs/MB+I/gbm3PW4jwCLBSUMzUgixvztMrRIwULT/5tb2lrgoIiO4VG/nJkcGI3GIw
	zY4JNH8R5xmhg==
X-Received: by 2002:a17:903:37c8:b0:2c6:8d95:fd7e with SMTP id d9443c01a7336-2d37f651b22mr150325795ad.6.1786720953532;
        Fri, 14 Aug 2026 08:22:33 -0700 (PDT)
Received: from [127.0.0.1] ([57.151.128.82])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-320ea8fe3cdsm5740229eec.28.2026.08.14.08.22.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Aug 2026 08:22:33 -0700 (PDT)
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Gang Yan <yangang@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20260814141530.102099-1-gang.yan@linux.dev>
References: <20260814141530.102099-1-gang.yan@linux.dev>
Subject: Re: [PATCH mptcp-net v2] selftests: mptcp: fix an UAF in
 mptcp_connect.c
Message-ID: <ad3a6ae1-12c8-cce1-bd46-72ec02bc3651@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Fri, 14 Aug 2026 15:22:32 +0000
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

- KVM Validation: normal (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: normal (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: btf-normal (only bpftest_all): Success! =E2=9C=85
- KVM Validation: btf-debug (only bpftest_all): Success! =E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/runs/318095=
07652

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/6a08e6ae9794
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?=
series=3D1146131


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
