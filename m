Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com [209.85.167.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B62D156960
	for <mptcp@lists.linux.dev>; Mon, 15 Apr 2024 21:20:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713216060; cv=none; b=I7uOm81QW0i2PeqAdVSREEtAEv+MD0uiz32ZbONxbu8Fr6Sy7uYmUDmrWACyn9gB1ax09oa+5wu81QohzBnu7vOroxofuG30OrDuRMTYv0AXUDa3UlcNBL0lKRMp7RWdK2njiMzlN3jEgEmXMbnOislfFDYIhF+dfFw6zGPoW1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713216060; c=relaxed/simple;
	bh=xZSv6NyUSaE/O4xpJO5uVyFXdeZh8D++hVbAhmB1oPM=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=R0M67j8nOFy0gxTrzW9n96bOwoLrOl/WR9UV2HRtXr877OIkbuaPvZJJz3g2FIxZPKIK5w79hBNsTF+iDmTbMNAv55sDnQKn6EUDPov/Qf9mH8xD/PR1v969Q9LjuRWPrGHTlKndsR9eJMsNjCDeGLSLWYBNcpmW5YxwZ1BgIVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DBYcg3xE; arc=none smtp.client-ip=209.85.167.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DBYcg3xE"
Received: by mail-oi1-f179.google.com with SMTP id 5614622812f47-3c709618b59so480820b6e.0
        for <mptcp@lists.linux.dev>; Mon, 15 Apr 2024 14:20:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713216058; x=1713820858; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n6qPWOtE1F2fJzpk05PTus7n1k1QxIfT8WlgdxR6hvQ=;
        b=DBYcg3xEvIl8oK8m7Zw6S/ZmGqQ0BaER7aSIF4ioDytIphcikbKj7yFgAPGUlEAa8e
         VZTQ58dY3WDyj/Q2pRiXp5s89kpu1WrAHT37738PHtllW5q4QzfdCP7hro8vdwo8IZ60
         UOOMJNIQJe9dRpkls32E0xDsKy+XvcEMfklam76doFFoBlCoLf07/PwVslJKSB6U2XN2
         Mmt+xUXOH+YO/OIoBthBqq/0Hb7m+hHxE+FtNc8DucvTZdGGykkArOV3HiWXyBUKfXmD
         OR4mVyyiIcxYYuRLo4G+rxZEa/2q733Nf9bKIw2sJdw/PTAI326XpWPCXrerjdrFddW9
         besQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713216058; x=1713820858;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=n6qPWOtE1F2fJzpk05PTus7n1k1QxIfT8WlgdxR6hvQ=;
        b=UwsO4K+2WOYvk0bgjny7830Fpc7Mk2YS1jXxzNoUqfxcB6d5yuZd3if1smEKGd/3rY
         Y2f+udGsAkSbpqUv7/oVvyQI/pshLfcttcZwYtsRwCRmVibD6T46nun2NYZvuzhjOyEb
         Zq6zK++lirH62/5GcuWz3hdumWU30K3g0LYWtnxRd4hmTsasTZeZz05/tOFyKAE3w6xM
         YdNjPAehxEe8MAQMkylouQnzPZLCDRHQt5IrYn1vI79Kr+iS5yyfgiAovAfpQcWpybQC
         /MvG05xs4yN3kn0yD7MwDmE6QcWVq8MtoSLmahltOlA30ncSWRQY6OrSn0RUgkur1Hxq
         /KwQ==
X-Gm-Message-State: AOJu0Yy54ZFOCgDNzP/kgJKJn8YVAsNYgZmMDkLW8p/NC2KWJ8wZj3vC
	OqW5G/EwRDH5AGgl8I70ODuWqESzzTqSA1JESOFanDGMQcBYg10=
X-Google-Smtp-Source: AGHT+IHfamPa7XC0+r1OH9ZcrPiLjvmL2HeqgeEZhGMpRHWvtXHm/Ori0m2+b2XlBmS59wrQlQ6d7w==
X-Received: by 2002:a05:6808:2785:b0:3c6:9c5:7b6 with SMTP id es5-20020a056808278500b003c609c507b6mr11720881oib.23.1713216058208;
        Mon, 15 Apr 2024 14:20:58 -0700 (PDT)
Received: from [127.0.0.1] ([172.183.52.223])
        by smtp.gmail.com with ESMTPSA id n17-20020a05620a295100b0078d5ffa723asm6812192qkp.94.2024.04.15.14.20.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Apr 2024 14:20:57 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <864efc65050c64f3876e75376bbe587bdf42e2eb.1713189887.git.pabeni@redhat.com>
References:
 <864efc65050c64f3876e75376bbe587bdf42e2eb.1713189887.git.pabeni@redhat.com>
Subject: Re: [PATCH mptcp-net v2] mptcp: ensure snd_una is properly
 initialized on connect
Message-ID: <52e0b873-de2c-b796-1ca8-0032699513f4@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Mon, 15 Apr 2024 21:20:57 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Paolo,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal: Success! =E2=9C=85
- KVM Validation: debug: =
Success! =E2=9C=85
- KVM Validation: btf (only bpftest_all): Success! =
=E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/r=
uns/8695857032

Initiator: Matthieu Baerts (NGI0)
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/d56bd52a5ffe
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?series=3D844661


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
