Received: from mail-dl1-f49.google.com (mail-dl1-f49.google.com [74.125.82.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4F1F30594F
	for <mptcp@lists.linux.dev>; Wed,  3 Jun 2026 11:44:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780487064; cv=none; b=NULBNnf5Lf2m942si8tRZqhTAIAfSkK7XXJB5fszPrIqQGrWiwj4RI5MGKBIqW/UtcCjTV3Unvbx4D6h2ZMCFSlcOTd/5BZoy80i0s0MxB6dTIbXRtxfKlDThwWcseZVEJR0aEaC7oZSKR1/nZNdQUQC98WvyFd1DN/mGILXOWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780487064; c=relaxed/simple;
	bh=wkY2+B+6XPSeX26uPMYDUSu1sFJMF/IJQtZ8mhBEIwY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-ID:Date:
	 MIME-Version:Content-Type; b=FZluynjbJV7lbfsici9ZKEEcbQG0SpYDiC1BoDqJNeC59gR0DVLRrVCIfLSHsieN7spzSkUisij097tuBMAgbeis3O2lNrlP+n/ctqGWRQ9ZwhosxJdxS6D8w1chR21YgNoYacqeYp6oUrDPzllont2k3n5FcvL3a3n0tRtl1M0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mI6uoLYL; arc=none smtp.client-ip=74.125.82.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mI6uoLYL"
Received: by mail-dl1-f49.google.com with SMTP id a92af1059eb24-13721dfd471so12299077c88.1
        for <mptcp@lists.linux.dev>; Wed, 03 Jun 2026 04:44:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780487062; x=1781091862; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oeicA9FYmOVA5yIZednS3Z7cC04ilZM1emkoSY7r8KA=;
        b=mI6uoLYLytrrghkEyqW58gdUu3cay+zsSM2F9FCEsnbBb8wZEmIyLtkipIZRfaXjws
         FqeNWloSqVtFQejWiEy1SJJlRR1Tuaw6Ydy+3qsS6y4WNoM0Mj1J6p08EsihzJNvH2Nc
         aCB4t5SVFfdert2Zps++qxQVHU88i00m9Oq5OKuYuTBp52A5Wj98W50MBuBnITLnM+Cw
         2kLer99J4A2SHKZspkWvpQrjp/O9Q1i4FqKkNeDkEHScvedrFqDgqe2cob6DLoum1Byf
         bPK62v98gAToWT10jlxyDkS5Uqd03ChKImtdM5CNisvukT6gZPxzLV6m7Rck541jY5dS
         PXYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780487062; x=1781091862;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oeicA9FYmOVA5yIZednS3Z7cC04ilZM1emkoSY7r8KA=;
        b=X+ACvjb4Hb5ls3PWkzHbtGh+yEAkYS4f72F/PebteMIZ+gEg2Hak0T4csT0nHOpOXz
         eozG5J6zfI+OnisD5f1sYyWylAKGilRpag2snkDWIxyEXWrYjBbkSWx3K5+Cr4x0a3Z9
         7qJ3d4znnmBmeEF5CpctQKhojc7WV2xmp1kzv5l6XdWEEHMaLNjwhGUrWaxd9+DRvzc/
         9NrzvIwKeER3iVcQHNmW/OKvKujNsKs3F2p3lKNPOlQDee4d29Hs7qBe/+Pk3HGrepGf
         ecFAdwGOKz+vkSCaCMKKkInNnyi6EJjgsJuw5TUrxoUQ+z38DlPZBeWP30qndKTz9WBE
         pS8w==
X-Gm-Message-State: AOJu0YwZ+9RROzu5J6TS8VTKjaJlNhEM7pEb+cD22iV3LePVzAPr1osB
	B0xJGCRnfTlQ5ZYBAZKe0n8e5dKaSSvY2SujjX9Wzuewf11vRDHf+I8EHFc1UhM=
X-Gm-Gg: Acq92OGq9ZUbwRi2XO1YbaZjLt5A5J5iE2g2yFfR7sbbU+xV0J3C6SIOelRb4g5Mh12
	AxX/M/ucZQNUn5iJgvFXGRGL9uvjyk6Zd0D19/htvcVAfpvXwFzsSBWufPAr5hW/YAVa0sP/YhM
	9a27oi/Q/ThmeRWHtnEWYha3DvdFV0iUpD2wr04xaRzzwrnJ7Cz8NyFWgoFJch3cPu9hKyN+vVT
	klvcqWCxDfFp+MGzCP9JibTUSwaeQtCIBU/aDaqN6reU9pyg3UyJU71L2aPkEugrU5J2q3lwTkQ
	J9s2wCjBjjtTJi0JaJzz4rM95tzhiSgdu8X6hSVOQff9ghajbgLLOD7Ly0XLC2c3NZsKQ6ye4ss
	ufrjrEYhxJrbqbmDbz6Fato77/lgj8LFtGwJ7DoNBlApHQEcKjSTHYRTBmNKka0nV0QpvNzA0z/
	K3zXvM5HkED4UGeMMNnFFUJxQy0VoXF35qhw6VWZMAT27RXmBM
X-Received: by 2002:a05:7300:e8a4:b0:304:b14:ec53 with SMTP id 5a478bee46e88-3074fbd4634mr1377875eec.27.1780487061752;
        Wed, 03 Jun 2026 04:44:21 -0700 (PDT)
Received: from [127.0.0.1] ([20.168.115.115])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3074deaab1asm2061377eec.17.2026.06.03.04.44.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jun 2026 04:44:21 -0700 (PDT)
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <cover.1780479980.git.pabeni@redhat.com>
References: <cover.1780479980.git.pabeni@redhat.com>
Subject: Re: [PATCH v12 mptcp-next 0/2] mptcp: address stall under memory
 pressure
Message-ID: <54008a98-0768-c671-b63c-d7eed6715d03@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Wed, 03 Jun 2026 11:44:20 +0000
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
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/runs/268786=
25741

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/dad30f253e0b
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?=
series=3D1105193


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
