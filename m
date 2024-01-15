Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4632318C01
	for <mptcp@lists.linux.dev>; Mon, 15 Jan 2024 17:05:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Nzw3+85p"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1d5dfda4319so134565ad.0
        for <mptcp@lists.linux.dev>; Mon, 15 Jan 2024 09:05:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705338302; x=1705943102; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k1PBa/swfjlkRYY2T0pNWUSJrSpJiwgXNCAq/fSSh28=;
        b=Nzw3+85pCjrZdXduYNjxdpGqVN2w/HF3tif1yNFl2yPM7keDJPS70vD2SI02oun3d0
         UsgBpTVZ7PgwGC9irTfHPcyboz22Pn4Wr3fn/valhBWT4Luh1PdPMrCSb0HZgIwAURBa
         5uA1Imoy/KKfWaMM7ZyheBQ+ySMJEtdk/XDocW52BZ1MJky1D6x4vuBMMVKkdAZeGN+U
         VHHX3m87Dl56UuuFcrxBS5fGpM5fZjdpMQpSFExma0pUxMvu3kKb1rc7KI8qL9KZOieN
         jG3FoiFTaRga998NIp46nkHBEX5nZpst5kRXtYGyYzbrPx6Osyw3W0en3rU2/afY7Zo+
         Qmig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705338302; x=1705943102;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=k1PBa/swfjlkRYY2T0pNWUSJrSpJiwgXNCAq/fSSh28=;
        b=h7O8kMkXWnhw3WxX9jcqao8HzA6zZsf/nRNJsCDPuj31BPlilbX2dJoaA8mF02KK0z
         W7GS/DSBFPMtRiRBsdGGTH12s2ty4yS94iOhMgnGP6EtlaUq9jnxF+yNhVw2sdTSBpZA
         GTv6mJar4iSK2uQihiTBe7t8ImUdmK4dsec4Wmi+YAYTxtBN+LvfNBkyUjuONBwT07uL
         aOi/QFRtVBFzHa8wvdSWPqqbeLW9RFH4RgBWl+NbhiQuEwfERNnEf3hbILqJ9TUwXfAK
         TKB+aLPrQTW01KUVBeV3Ub+3EB2OMD7ZlHDx16KV1BvfsRLBKYqgjjgjgezc4fTDu68K
         u4ng==
X-Gm-Message-State: AOJu0YzaWGvC1NvaUW6F4v3PLGJ2c+rZ1oRCFo5CdwCzGqX+zxAyTsba
	vdnvqyB9y4RcPBbZvw4gZA==
X-Google-Smtp-Source: AGHT+IHPaUhKThZ4SJ70PSzF3ql2NnBTm4JaRv/EGNKLYUG6fmBSyQO1g8rPrf7Z1TE0nptgf5fzaQ==
X-Received: by 2002:a17:902:da83:b0:1d4:133d:6a96 with SMTP id j3-20020a170902da8300b001d4133d6a96mr3365099plx.75.1705338302488;
        Mon, 15 Jan 2024 09:05:02 -0800 (PST)
Received: from [127.0.0.1] ([4.227.115.98])
        by smtp.gmail.com with ESMTPSA id m3-20020a1709026bc300b001d4a49b30f4sm7776146plt.61.2024.01.15.09.05.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jan 2024 09:05:01 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <4d9707b72d37cec9b4b6725bfcf3ae03010e0d51.1705330501.git.pabeni@redhat.com>
References:
 <4d9707b72d37cec9b4b6725bfcf3ae03010e0d51.1705330501.git.pabeni@redhat.com>
Subject: Re: mptcp: relax check on MPC passive fallback: Tests Results
Message-ID: <efca8725-6b51-dac7-715f-24dd081618e6@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Mon, 15 Jan 2024 17:05:01 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Paolo,

Thank you for your modifications, that's great!

Our CI (Cirrus) did some validations with a debug kernel and here is its =
report:

- KVM Validation: debug (except selftest_mptcp_join):
  - Unstable: 1 failed test(s): packetdrill_sockopts =F0=9F=94=B4:
  - Task: https://cirrus-ci.com/task/5457076986576896
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/5457076986576896/su=
mmary/summary.txt

- KVM Validation: debug (only selftest_mptcp_join):
  - Unstable: 1 failed test(s): selftest_mptcp_join =F0=9F=94=B4:
  - Task: https://cirrus-ci.com/task/6582976893419520
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/6582976893419520/su=
mmary/summary.txt

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/c8255ee720ba


If there are some issues, you can reproduce them using the same environment=
 as
the one used by the CI thanks to a docker image, e.g.:

    $ cd [kernel source code]
    $ docker run -v "${PWD}:${PWD}:rw" -w =
"${PWD}" --privileged --rm -it \
        --pull always =
mptcp/mptcp-upstream-virtme-docker:latest \
        auto-debug

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
