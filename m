Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F102235202D
	for <mptcp@lists.linux.dev>; Fri, 29 May 2026 12:00:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780056038; cv=none; b=tcJhyuij/mGUbTslya9Q7iimhHOTmfJ+dTLEy2GnGOiKWJrFsUV3j8AOPdZGdMg4CLzj6j+cuJR1EoW3CpikTXXb1UR+mQCJ5unCZmfV0FDYNMh4xU8pjF1jeYBSVWPA4xO6TPzJtvKl5J7nVjxJ8P/8UprvR5y+4B4puwhi3Ko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780056038; c=relaxed/simple;
	bh=mYeaWW2AlSNsdQfS4rWH4XlaVDD4ZOrTY6j+TqJmjVA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-ID:Date:
	 MIME-Version:Content-Type; b=riT9bqJqnQZzQcrSZfCYABI4Qk0RqZ/lgklnaqeFXu7wDpNxXaAz3auLFMT5h7rc8gKfJ3IO1sTIqt78y+kZvww3o+3lQZmw7TakguL8X9z6m2wS8BkFLfZ7oYExoADYQ6KD7SfxBdv5JS2UBsn6vnpBKanF92ig1FkM/sS/Pps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rD+/ZGHu; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rD+/ZGHu"
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-50e5bea4045so108036651cf.3
        for <mptcp@lists.linux.dev>; Fri, 29 May 2026 05:00:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780056036; x=1780660836; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZagP2RE4Vj4jNBBZAYzbGG6a5gNNDNC91fmqslPQG1k=;
        b=rD+/ZGHu10rJvbpEGPMNLtO1OWvIYU2+hHdkilZPGS9UpIg/6ef87f4KSTQ7IPDy6+
         wUhnyaNznFLI7g5mAhH8T2cb6DAo+RUxARy7w5k6lI2GemXjdNA4aoJ1MBu6bsLEfP/w
         qSYSNdVPcEFyxRuzBcngONuuvOwpTvCMmb6exCCoSlrOZwZP7UtIDQnQo+5gJuHfnKzJ
         IEaks7tWkDAkySeY0kUy/ROhXfW7Q+TH7jKZUXwZ9U6borqONIzuotQgnC54mnPwsvMQ
         Kb1KBIVELnSbaoxA1uMlcyEndGlWafOY4p0qWZrkPPFYOLRTqdq9XX/2OiixaPcejGsc
         7c4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780056036; x=1780660836;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZagP2RE4Vj4jNBBZAYzbGG6a5gNNDNC91fmqslPQG1k=;
        b=HmBw/H3E31TMjALVwl+yQmQE+a3GuZEwgNd0qR8b0S7JqYP8OmdB0WAehfWDF982u6
         OaeTnnyRGfrdPWLMQKX6BS73DRACCtwtCxblR6JOBhS916nRtvtGJrJG9//ZlGkf5P2S
         BBfyRt8hsYYpY25torYMgrqheEJrj/BqytD3Ud6GzWwfSvhglRZXQH+JHebfa5vhwSfx
         pdZanHjF63A/sN4ksz4E+9WQLWbwVXNyG/8SRpAxuMxIgSSLntkJ+i284vwBqOGiVTsp
         tE+DIQxHqzBnq50REbY5gkGBB6rHrruWrYYF96vH62qKMzdOIanCESNAb3KsDkiBdbVt
         pOfQ==
X-Gm-Message-State: AOJu0YzqChm3of6HO0O3vDAA4t5gVhAA+BpRUaByWwpIOqhIL/zCQ96p
	3X0eGFlQYzrvb2RMONoghIlKEY12IvIFayJC66z+HZKZZTCiR89hx+8=
X-Gm-Gg: Acq92OEqHMuvYxZBcoiY8iJAqUNBVuahptkqhh0jkFTtTkXWlwmeDMGNjlAc4WftMDt
	vuThA+wvnyDTQmZyPwLvj0dz9HGyruuPq9IkGssqw/UtM+2donqJbFLa8mOlsIi/s+Pya6yXB9+
	1td2byUeD4+BdhGhClNj/ciZQwdXlgNjP0r/d/KFxrE0m2ek6LRVBIqjO13TvXYBiJH0O7mVBmd
	EOCLESR5rSACTcfUjU/pf2yDPS5HG2m6weJnHoZiBFSCZQkwmoF0JRp+Nleb5cpc5yk23FJMFgp
	ENALs4b8EKG5LCZtgaxJEVap5GLFUHH5n2X9Ez2wMMT1G/8C08fHrzyXgiE5z2J1jfaTfF/8d18
	nluBzXHtN0gI+owoLLGXajoj4duUyfsGlkzyz4SlFzVRBOvb1KnOILLtxcOFgPcl83U2xmwAUJx
	g6KhP8aeF9Tv+IdCZlte/hHH3eX4yjFep+GySJYLcG2vGYY5t50+4AYoC8NlY=
X-Received: by 2002:ac8:584f:0:b0:50f:ba44:ce4e with SMTP id d75a77b69052e-5172dc18bb7mr31484521cf.6.1780056027356;
        Fri, 29 May 2026 05:00:27 -0700 (PDT)
Received: from [127.0.0.1] ([74.235.102.248])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5172e9e5715sm18423351cf.9.2026.05.29.05.00.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 May 2026 05:00:26 -0700 (PDT)
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <cover.1780049797.git.pabeni@redhat.com>
References: <cover.1780049797.git.pabeni@redhat.com>
Subject: Re: [PATCH v10 mptcp-next 0/3] mptcp: address stall under memory
 pressure
Message-ID: <dbb33390-5b3e-d71a-0d3e-b2efe28c4e6a@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Fri, 29 May 2026 12:00:26 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8

Hi Paolo,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: normal (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: btf-normal (only bpftest_all): Success! =E2=9C=85
- KVM Validation: btf-debug (only bpftest_all): Success! =E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/runs/266337=
50821

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/8aeb83d616d6
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?=
series=3D1102825


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
