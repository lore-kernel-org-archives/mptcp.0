Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50F673A4F4B
	for <mptcp@lists.linux.dev>; Fri, 28 Aug 2026 07:14:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787901272; cv=none; b=KRCIK6Tr5U8ByfOE9ZWuvio1V6uDpRyBC14VdMXQvtnmWzSDtZx0EFoJAjj++qaKb6HzTfDNqphYddvNvU6QEpgspuRUe6JpLxZwTR/taeJtP80uFuCDkxknA2OCz+uFg/Tpjm3moGDHvqz1hHdhIvjp2ImCDB51Ec1beVR6wJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787901272; c=relaxed/simple;
	bh=lnvPWIwgc7R6ipY/hRZMbOdkwgj3FnBmel8PSKe55So=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-ID:Date:
	 MIME-Version:Content-Type; b=sQFQNifwCoPfiOgmxzmzpFmTetbLZXuGkXe5DwynJxojTEbcFdXhI+ThWJZ5XD24V7HmLu4s9zCL3D5c9dLUuuGyynGTeqM8/92jwNdaUlccivlOOWjfORAsjYT8nzB1k8RtEab+rh52QtvaUcNPBqvSnxdeP8VvtR2oPdCK9/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WoBMaUCa; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WoBMaUCa"
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-92e6a434cabso30114985a.1
        for <mptcp@lists.linux.dev>; Fri, 28 Aug 2026 00:14:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787901267; x=1788506067; darn=lists.linux.dev;
        h=content-type:mime-version:date:content-transfer-encoding:message-id
         :subject:references:in-reply-to:reply-to:cc:to:from:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=YVSSGomYsdhsYHiMSOLZZz+9l52QvNFwPvbk83R/ZKQ=;
        b=WoBMaUCaPFuouZwxkGAR6638dEaMBDeUs2DEHLKJ8KtB/VY2YeqCM0N/vis43rQV9M
         scu3xIPzqlT6HBa3HLhOeO2wmt56Em9xfUNNIGoX8rFt3VWn95Rix/yRUXKF0dItho5l
         DzVe0JKb6+GF0omMRDGsWtkI84Qd6nXjTl0YWESHKhkD4NKiFKIsMD2VqyOhPwTrdzjV
         5pJnz/8N5H9QFXIkehedA5lPp/BWi8nuB2jk1Zay8B7YxvcmqK6Ru83iPzGi+W3c94wG
         BuxbYSk+tD9iJ3k94SbtWGH/e8nIpCzNjboj6iHO7tM6fIm8JlhEO4Wr52M1YsEt5Ner
         rvAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787901267; x=1788506067;
        h=content-type:mime-version:date:content-transfer-encoding:message-id
         :subject:references:in-reply-to:reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=YVSSGomYsdhsYHiMSOLZZz+9l52QvNFwPvbk83R/ZKQ=;
        b=Rct3ZwzlUYBlfJ+l2qGbSkIsqNf4RaZlHhHsoY2u3ACA15IZirukIMKQKarYbskFhd
         +4fgZmprMQ8otUtHtaJVAoANLg4vx6kc2RU6LXteOB8Ge4bjMRBNcXtb2pdqzjJrNjAE
         z1PHcpAcobObKB85w2t1ymolW9oM5Tx9K5FZthCz9kpz+X87z5crEz9f+QxQS71U5Tk5
         F48TiWcD1wyNzGJSJEwE+qY0mF0hnJhC4us9ongsHAh8YM/2HntWKMPfcmGrY9cHZXRD
         2W8TptCCbP6uk4lZ2YyUrvqULURs5MSekZPuoxnZtlHwueKlKA6ljrLcvBFqArouo/lc
         Hjiw==
X-Gm-Message-State: AFuF++nv8ThcWWEGQ0/N/by4FdrhBlT9q9f4TucErhcbQ1GogIs0N3xD
	8gUbntDND2wY6ePOQjl9FPX9gc60OuXrwFgNs7q4QOFe43hn7pRI/u9BoQjb
X-Gm-Gg: AR+sD10A5H84y/Wh8vJ+EiDaP4L9rJXBiMiPBVFaAleIEiDx8K98m8F0opPJzAJZzxV
	vM3oP2me2seUPzNyLGwSbuRxQ/ap/cBza9z4uxAQTKEI/4kvs4ZYpnRVop6p/MMfUWblcPsXQAQ
	5Hs998ieGUieq9dSfI4FPLA61p0msmkajBskTm4zJq7Ms2nC+u7Sf4TKzRq9ahrt17E1RW44vJt
	QyhdSoKKNu6/Z8Vs6BiOnyaX49Fy9MXRwMSpuFnakeGczIT2Q4Crq7hQ9XVYCzIrSzdFAJrNsxc
	FzPNmMrgULsdRKWjBEm+xYkmxxYrs+BfuH+2h4PihkuF7EOVE/rz24MmTO/7WY34QDUjpxayrtB
	1l3xzicj1dgq4aVPm7D40i7WMfJvUzugbGiTBME4w36RVr6w4fAKasbhEn1KoeS4Wo+q+1hghtr
	d47vmDRPvGImzOv2eBDlqgqXwVkMnFbzQfO3JgzhBgyN2Kac3eDvhbc8RUjPTn7od2UjvLTN5X4
	g==
X-Received: by 2002:a05:620a:2907:b0:939:df7:6ce3 with SMTP id af79cd13be357-9391390b4c1mr397871785a.26.1787901266844;
        Fri, 28 Aug 2026 00:14:26 -0700 (PDT)
Received: from [127.0.0.1] ([20.161.30.240])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-939173f2758sm82824385a.37.2026.08.28.00.14.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Aug 2026 00:14:25 -0700 (PDT)
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Gang Yan <yangang@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20260828060643.14397-1-gang.yan@linux.dev>
References: <20260828060643.14397-1-gang.yan@linux.dev>
Subject: Re: [PATCH mptcp-next v5 0/6] mptcp: avoid data-races around the
 sysctls
Message-ID: <a8b0eb8d-adcb-4a50-8118-47ad5ed99f8f@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Fri, 28 Aug 2026 07:14:25 +0000
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

- KVM Validation: normal (except selftest_mptcp_join): Unstable: 2 failed =
test(s): packetdrill_add_addr selftest_simult_flows =E2=9A=A0=EF=B8=8F=20
- KVM Validation: normal (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: btf-normal (only bpftest_all): Success! =E2=9C=85
- KVM Validation: btf-debug (only bpftest_all): Success! =E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/runs/331477=
52173

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/12973af4fb8e
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?=
series=3D1152984


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
