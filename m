Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DBBE1A5B9E
	for <mptcp@lists.linux.dev>; Thu,  6 Aug 2026 12:31:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786019487; cv=none; b=SfVmPJVwuvQZ1SYOJLpcZ7rvyiUuV4UMrc2oQe+QCoJlBmtA0Wf/yEbsLXfbSXrXMJ4Wd28Knq2b6D07hr7dlQEnm7tZZOWr4hSWe0dMj0Z1RubPbGON6MnDLEeKr7S2b51XxKeo0D8yIysGWumoOxYrPZZuZF7EYH7htGR4iUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786019487; c=relaxed/simple;
	bh=Cy5e32ZIdAfRjpAemfrlj7BQdcwjIP7aPIIQSFEV2vc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-ID:Date:
	 MIME-Version:Content-Type; b=aOsRgt815aqBc8uExKLLBkM+vNrCh8GavWkxWJWYofwwk+IAMT0Kml/G77stckaDdwgZ5TKyI7p5KCFgeXBBqnn6+neMKvmGh/7PTFGuJNLwk6nXhWFEVyE9r6SyCnpLS50PKAdHeATggTa4IzAPawHNMAFlgLGCSKzw6mSdQXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jZA6tleY; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jZA6tleY"
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-8fcc43c48f7so22715226d6.2
        for <mptcp@lists.linux.dev>; Thu, 06 Aug 2026 05:31:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786019485; x=1786624285; darn=lists.linux.dev;
        h=content-type:mime-version:date:content-transfer-encoding:message-id
         :subject:references:in-reply-to:reply-to:cc:to:from:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=z1m95pvIWdojmTRl25HWnqIFX6OX9M4fRT7K/mbN3+Y=;
        b=jZA6tleYyPVLnqaP85WkNe1CuPvh6S2d3aGBW0f7D82GXSNyqvm2b951F86zXJBf50
         MwdyF/LpxQHl5Tp5Gwx81jUXcUUYZwjz24I31Np63jdQy3dMjHn8NG9Jxwa3sRh4By2b
         +AUgwR3rA8pFokisDaySi00a/5KYzOdvY52C0Ov7tDmk4XGBY8bM6azVyiqX4LxvhG4T
         pW1KAGSRuON1XAISLY+mUWnb1rZaelSV/kIxxlsvfatV2zGfmywiFc0xeRFZG2NVmwgr
         I15xDFf930owMnyvstumagmT6YdYSb8UvfFU3TuK7P/WL9/QZWCVN2PDktgbBJOvM+UH
         3dNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786019485; x=1786624285;
        h=content-type:mime-version:date:content-transfer-encoding:message-id
         :subject:references:in-reply-to:reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=z1m95pvIWdojmTRl25HWnqIFX6OX9M4fRT7K/mbN3+Y=;
        b=GjOCYMkE2MD+DpFjW2UjmMDpjdvbdIq8ZRmAfNpMnQ7MKXlF3wL2rX3BbQvcTSRO4u
         d4ZSdyhlQoJpDPVyhU5n4qjU+7B3Wmx/yHLZ6ez9h0lHVe3RTDkwKpQFGdCHIC7bG9Tg
         +cMmot7UpOdrXllZNsUQhDQXk/Urzimg/xeHm8wQxV+iqZHyrOxnWkrWnSfuR0UGHlIf
         Ajgu9tPpLK7A9Dhx5N0Z0kZpTuxDlMvahQCHOWlhwkrPcVskxeQXw+pywpgq448UFZfe
         s6lwbGA+u9kCkCYxtXsMhEKJSSxSqhDTwapwW19cKjOg6oknrAw0yglJbmBKVdcK4Nn0
         3LUQ==
X-Gm-Message-State: AOJu0Yxxpw+SzqYLw4O5vXRpU6XfxhSV0Qpxzzzrtg4c60dhaopLkss9
	NkUNgBHcrobWEHLWt7BXuhApnkApy3sTGyZQVlgGHQLhNbbm6FqM3X8=
X-Gm-Gg: AR+sD12xxiknxf9tDMcEKD177+sKq4IC6C7URw5/U+2TBWQNBet3Lp8FKSDvppdeRzB
	H2Tue3m3bbL9aSUJ7wbkkApHNOVG9EbVut6bx3eHibuQzL3j0gPqZc+51XbEClmXBUnFGRWV2Sv
	lCFIjfGffgjDUqVEQ44kygQPZAdvtRQvH0KbsE+lhSa9FJtZhfgPf5xEQlK/qiDeVW3fbHjxK/9
	hWBV/MG7wN3DH3IQYearrxcOIAwvRKbTNgRYdebNxPxFPrpsBjD8hZ/XIAGu38qGujlQmSLz4k1
	Cfgpojuno/GmEaT9vUnOlf8bTAx8jbJYrInRQikA/xyCVExdWpbMVUysFyYMla5xeiDWkASlatN
	4Dbk9oGsZJivWDvFVhYsKXH4npsNsoSjq+zkilmv/slqqo7ox09u407nIWJMZhrEq7Dh/Yw+4Lg
	LadzxC0PT3su2YZB2+rimRsi1v6zEW42MjXONoAX+6yWr2niKJn9dKgHUsix4wPQ7/qIQf39l+v
	Wdw
X-Received: by 2002:ad4:4ee5:0:b0:8ea:1b3:ff5f with SMTP id 6a1803df08f44-9088126d788mr165052776d6.21.1786019484970;
        Thu, 06 Aug 2026 05:31:24 -0700 (PDT)
Received: from [127.0.0.1] ([145.132.102.251])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-9087fece5e9sm50568636d6.0.2026.08.06.05.31.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Aug 2026 05:31:24 -0700 (PDT)
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Ruide Cao <caoruide123@gmail.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <cover.1785995291.git.caoruide123@gmail.com>
References: <cover.1785995291.git.caoruide123@gmail.com>
Subject: Re: [PATCH net v3 0/2] mptcp: fix request migration ownership
Message-ID: <5347c8dd-91b0-854f-2e27-e3b1479bddd4@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Thu, 06 Aug 2026 12:31:23 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8

Hi Ruide,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: normal (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: btf-normal (only bpftest_all): Success! =E2=9C=85
- KVM Validation: btf-debug (only bpftest_all): Success! =E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/runs/310983=
02528

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/f809c35b85ca
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?=
series=3D1141434


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
