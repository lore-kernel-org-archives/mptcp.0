Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10CEE30BF66
	for <mptcp@lists.linux.dev>; Thu, 23 Apr 2026 08:10:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776931821; cv=none; b=UkxbPir5NzBIq5fiCIRom4MoLAhnHmMbvwOJoNAei1khLUSabpXAPMLUkObdUtCqSqL5gh3yxe88vCxa8YjVwbvBmfrFeBLpWaiDoiHtrUJCnNdr7Vmvkqdkp++oZrXlta0XivFU5WMkItZRfeN2nvuHLx8xLbfiYdKlVZfXYyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776931821; c=relaxed/simple;
	bh=9w5BQQnipbv66xuPQ8Yb2XhOibYfWyoB1RCZ92CSpC8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-ID:Date:
	 MIME-Version:Content-Type; b=KNZ221DNAVMyG3md8ify80LL76NSxmkxb0cjy2u7K3nTU075J9U22YGGOeCNasERHuAsBSIZn6e2Tr+16IEqptiICqnLQv7lwwId7yJTKl/OwD4F3I7iYpzB5z9fbjfKcLjKh7gYmaOgfFxlGVq4vyMeM7k1ZFRN4AD7KnYWMB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P7qCIQxo; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P7qCIQxo"
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-8f0579401c4so152447185a.3
        for <mptcp@lists.linux.dev>; Thu, 23 Apr 2026 01:10:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776931819; x=1777536619; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aUKG0lswSn2OJJOd5VbqXB6p2ber1jAUT7PNo+kcGT4=;
        b=P7qCIQxoauXDsoKxhlge27EifOOUcTD5OFuDEHnzuBCL5F6EOkkfbv/dLdT7fB/HM3
         5HrtwTJuC00VOM3e4RmRn67k6cmTYi+3iiYC1UXfCkS8Nd8cKp2QKOWBIWTuz+EOqJov
         k36mCFNHg7N9syc/KF08TefGMB0N0LC+K8p/CH7lf6irCnm91zrVlU8/rwS6kLM0yU6C
         QmGD/WX0n8cxJCUaPOTGogpVjrE33d9QVPQ6odXK9vs81ndAuqOKoismxfPE9cl6Pn9Z
         +NXslOOVpRBu1jE1RkbYLLptRE3DU3Lah8Us9H/PxEMx6xEzvuZ6YzTt5vZe7vZoFMzp
         sshw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776931819; x=1777536619;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aUKG0lswSn2OJJOd5VbqXB6p2ber1jAUT7PNo+kcGT4=;
        b=FBnkwqGhCy8j0757VRJKmqwDxJcyIP18DXYYho5dbQuVIh52CsvjouV1c51K+Ejz6O
         pylhxN7MCQbgJ98W6HBLpzk7o3y9KnhGOErB+v0OMlzu/U0fcsqO+rsdoRkSOIcRi1Af
         TilnmlIXngYsHIydeCyO4pO5EM5cic3IdB6weahjM1nU1GyrjLp6WypYe4JAqK0zfVFM
         QmVJ8Ugmc4nw7KpAuVtLBAWNW/zJSIYdHjU4JTpSSa5qaFMa/6wRSiQKYVr5LVFCQvyI
         O+aDqYk/bVjv1YoVTEAu28JMTW0EkADpUA+/0FNoKAXYrrRBtvOKYKOeHvUCNnMk34ZG
         Cj8Q==
X-Gm-Message-State: AOJu0YxPZrgy+pSJ2orNvMGX9KgpFQp+O3Ntce4upQzaTxSthGbDpBf7
	oFjU5sUXe4xDMSdH/KNQ0kPkr4FRfvljJqw8N9rm9HENGjIy2mClBs/sryKa
X-Gm-Gg: AeBDiesKDtpLu9W/asYTXybNr3ToMwYdCE+I6+/Zgn6CvQrprPz/2wPY7bPazRhTh79
	KSprIbf4ielPUwK3fmUuAKqn/nrUE8qOAxuDy+6srIhEvwQaZsZIl64M0Y5MlVRxJUR6XkawSa9
	9NKXhropoybcIjuGjukakEqbtXCmi/A3oni/Lj62Li1otExIS6ozo5v6+Sou04fsQorxu8IMBya
	IvTdJiCCA36VIQAkmhxHXTR8yFw/foMvoIp03WuPsWrhyDA/WnOAzrB76WZoxc7Ncb/HKBeX1Nc
	+3eBG9GmiMfUkcL1fc3Xxuf+MjHQZlD6x3rJWuTaUYfUXGg+1MkBzkUsTR25DxPHbxp6GMxNrQJ
	f0aHBrSKBWMH3Q/lTk9NU9D/vyPiI4HtUgwVNpbMDk0E/BWGp8kC3qq8WihvQp8BOFXBJH0kWmp
	vM3GxeMVLuzOS0fO5H/2lsl6o85C0r2LxnXb9seRI/BOuWDPw=
X-Received: by 2002:a05:620a:4504:b0:8cf:ebd2:f8e1 with SMTP id af79cd13be357-8e79217f798mr3677652685a.53.1776931818967;
        Thu, 23 Apr 2026 01:10:18 -0700 (PDT)
Received: from [127.0.0.1] ([20.55.126.246])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8e7d64caf37sm1518797085a.11.2026.04.23.01.10.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Apr 2026 01:10:18 -0700 (PDT)
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <tanggeliang@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <cover.1776924681.git.tanggeliang@kylinos.cn>
References: <cover.1776924681.git.tanggeliang@kylinos.cn>
Subject: Re: [PATCH mptcp-next v16 00/16] MPTCP KTLS support
Message-ID: <f92f5d01-6e15-de6e-9fa3-c9b0ceaf564c@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Thu, 23 Apr 2026 08:10:17 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8

Hi Geliang,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: normal (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: btf-normal (only bpftest_all): Success! =E2=9C=85
- KVM Validation: btf-debug (only bpftest_all): Success! =E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/runs/248217=
49654

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/b924c0c04b41
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?=
series=3D1084528


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
