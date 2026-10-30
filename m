Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793357105;
	b=IHHh6DumUl1SqCSEVUlvQDT67xrzicbQYJLfJnO4dpGYULLUXtM84u4MpKgQ8kNwz5Us
	 x2mnLgI75RCMWPIfxMgShQh1nRspNrW6PPjG+QRIb9kI5hycY8oY4CgwevEaXIJMGbdJB
	 U/1S5/bqwBUBlMjKITnQuR+oY8fYwk5gIsAXI8bqf1XgXCWqf/KjxubGJgwPM7pnxSm8W
	 pqwYC0nNXb2235u8DctvbVrzLC2CjeV5Eut9cnTAfBW768KFNzJTJ4kNI7LJ4Eux3ZemS
	 KVuBt/b2cnjspuevy9EsjvEOEfmjjk73CHZOV0dAaaclw/x/Lemmei/eGvqgiMR5WNA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793357105;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Reply-To:
	 In-Reply-To:References:Subject:Message-ID:Content-Transfer-Encoding:
	 Date:MIME-Version:Content-Type;
	bh=qLA9dMKMjKiBdQyn0XI9p7xHd552F3HM2vpTqzFHSHc=;
	b=Df7LIPgPc/BXxPKVB6BceUBU8/bFVZBk9V3mEcXL/34L89gvumMdU/Td9w0gXxuUWERj
	 EkgiWXI2P/M2eW56XxGruy04y/vXsmkAtziJpwRn38dt1Jfi/tr3y3u71lVO5+L5S6GU9
	 J9/k0lunuaR4U30we0Q4qa11P6ab4o8A5I22T1sCl77yq1eEdTLnAwOaLVH8JDxmL9jgL
	 vNuJUHsEftJRrk3DmZ86ZcExKpz7S3CUsrezCNYq/pCgnU4k8nkH+eAiFBfnmeNQhCWs+
	 XSh9G6yoe1wKvdOKsfueNhUG/blWxk6xLB3tTs64ianqYhAxGI/TkvJ8c1/b035UMiQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=sASHcdSc;
	arc=none smtp.remote-ip=209.85.210.54
Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBDA1606A31D
	for <mptcp@lists.linux.dev>; Fri, 30 Oct 2026 10:45:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EBDA1606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=sASHcdSc
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-8253bc5a613so423434a34.0
        for <mptcp@lists.linux.dev>; Fri, 30 Oct 2026 03:45:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793357103; x=1793961903; darn=lists.linux.dev;
        h=content-type:mime-version:date:content-transfer-encoding:message-id
         :subject:references:in-reply-to:reply-to:cc:to:from:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=qLA9dMKMjKiBdQyn0XI9p7xHd552F3HM2vpTqzFHSHc=;
        b=sASHcdSc/WKCXJkBf5fhXaiMWvxV1oDxK+g/sEKG+bbx3i9nIELlq+zn9/R2BAgcSN
         d2gPpByNHiu24AW//FSrV/0YfteyiJ7ZT0s0+ZPgYlGVVlia8K3e0uLBtzq6UPmIkTBw
         vFHa7gYmP3KCzK7HHzd1wMeKIH/XNeAygpV+ibncM2VzqZ7Yu1K/b1gwyspi2y4BtcPf
         kaFHYS5zsOvZHe/EcmeNRTHY6RuXW3ichup0jxDvLCTaZGBYQca/8wO3AsnyAt5XktN2
         WqiTHHJXWQr2Jw8WYe+2WjsZTi13C/x9YDDseavSKq5npN8SdM3Hbj/mRDNDjxnzScEp
         A4Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793357103; x=1793961903;
        h=content-type:mime-version:date:content-transfer-encoding:message-id
         :subject:references:in-reply-to:reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=qLA9dMKMjKiBdQyn0XI9p7xHd552F3HM2vpTqzFHSHc=;
        b=quRMg7mOPVIb2e5+6K+i06J/0FOOw3SCttU/i16koLXFGNsUS5P+VvH7v+OkPWZUtr
         gbl5W8GkBYSJ+h9PS9UPvmMRXJhEGgTj75E0wnt28osxo5z0iR8bpq0iKe8SqOXBsMsr
         EynPk5hj31wjXXF9ZSD/VQPkqRk5HzMpk+MGrxvwSiF1sSO3jomEYlpvxtPC6+KbC9RM
         6Ws0J4BJIer02fTqS6a2QgL77zqNhHB4ZjKJrd0L2KsFjy8IF4Z0OWWdgCz2GFkTwDTA
         jQUHRbtHKdOW0Zar/MEYucuzx/iX0Z6CD46OiVvb19gjr81rHJTJgeZojfqwhus0Khgl
         wqrw==
X-Gm-Message-State: AFq9FYIKp/Lb5ghNW8avNKttU7d89G3GurFU9uc7xExBHiYaFO6c9fvw
	6qEWoOG14hbK+Tx/CeoTz4Q6LDnBTIo625vnXuj3bUc5ztYiBqbyK/U=
X-Gm-Gg: AYBFou1MQwYkqvmhNksomqYncysKIdyha3iqgnAv9OPXUlqHZB0i/KALXvgIUFvZoO3
	ulqPCtwM2yTW51+yQhX2GW6FMTigX3pvJSkNbLQMly8mxmBrm2sN+hy4J/SVx7/T/3sdtsv8RBq
	2GypqtskHdy12rx/GsyCKQyxdG+HoP7Z99Q4ST87WvITN2D+pY9dg2BgP1IBCB+NSMCbTFiFHyA
	UnLtrkNbkpEfvQo5OdGPoteH+ltFE0d4JFFCXCmBRPd1MiEBGlbyn4q7GbVE6MIQ+jcGljWS8bm
	dyG8Fj56tOIhdenb1K3hRqmWNTklhgKh9LYJEle/GZeWKvM1RjQmCa19o8NhMPxbSO3AHuGDss5
	63RtgnAQOdjtQc3vZBJ9Rj5Rq1LO43H7VOjCm12BrY1/hK6R1yCdAQfEHO6MIysNURd+Skx4HI2
	s8FMMr7jsBVJe+2gFHhZBsuLvcZfLdO4/NWlp+2eFQ3hhWRKgzEuExCJqWb196lsUhygfrCrEKV
	YXz59Xp5BW9bQr8Ka0rwTTFvXgkL0wYC12TJ2NNcUhMctlYhCSHp+RUGUZPHtbBJNoV9ZUCgFDz
	vnxt5/phGVeYQAVlALZW4yPbe/Xe/kS52fT/633g3HI=
X-Received: by 2002:a05:6830:4116:b0:81a:9522:f007 with SMTP id 46e09a7af769-85d3649508amr1305418a34.5.1793357103563;
        Fri, 30 Oct 2026 03:45:03 -0700 (PDT)
Received: from github.com ([172.202.55.228])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-85d354cd9bbsm1653509a34.16.2026.10.30.03.45.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2026 03:45:01 -0700 (PDT)
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <cover.1793349369.git.geliang@kernel.org>
References: <cover.1793349369.git.geliang@kernel.org>
Subject: Re: [PATCH mptcp-next v18 0/5] Reduce the differences between TCP
 and MPTCP for TLS usage
Message-ID: <bbb9a9f0-d0d0-4019-3d20-b267df87c94a@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Fri, 30 Oct 2026 10:45:00 +0000
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Post: <mailto:mptcp@lists.linux.dev>
List-Help: <mailto:mptcp+help@lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
List-Owner: <mailto:mptcp+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8

Hi Paolo,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal (except selftest_mptcp_join): Unstable: 1 failed =
test(s): selftest_simult_flows(2) =E2=9A=A0=EF=B8=8F=20
- KVM Validation: normal (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: btf-normal (only bpftest_all): Success! =E2=9C=85
- KVM Validation: btf-debug (only bpftest_all): Success! =E2=9C=85
- Perf: Success! =E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_n=
et-next/actions/runs/41030711574

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_net-next/commits/81f9c2ee23=
3f
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?=
series=3D1196971


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
