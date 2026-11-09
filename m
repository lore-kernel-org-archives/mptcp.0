Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.173
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794223290;
	b=ZmhoiXlYae9J2pDQpwkRBy3wKbKgTSifxDlJ2KExkmeHRNdm88WIK5FtTJCYsnxv57qc
	 DPrwPZj8w6JTsYiXOq9bGHayhO5ceTExXUOiHE/zN6jdwRrNqY6cLI820/WS2/esPVWY4
	 AEwuKPcj8cxG6OPC8b2ewDsHuBR7F8ZA3qaC4Hi3IL60MIG9eLn+eCidaDzM2OK7t6omN
	 6Ef6lXUN+tch5gT6TiBDjjs5xvw/kIfV4F/6EjYWcJH+rHz6lVl233b9SBJFTfa5YiOT6
	 ShJ4GcogqXQfC9JN+8gO2wZc9Ctp7vunozOLaXW1pLIy80wlX0zWLtj7YVt3X26BNNQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794223290;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Reply-To:
	 In-Reply-To:References:Subject:Message-ID:Content-Transfer-Encoding:
	 Date:MIME-Version:Content-Type;
	bh=WUKoyEdMOFMig1BvKxo1M/BYMu6alxBUyrfz0aCkZU0=;
	b=lXXcc+guYVmuMFR6EpcoV002vuxwjUoMKCI8cdAjL5BVl0APPLpxDwn1Wfnl5aPBpibg
	 VMW+auwqNgZL9Q24yRou0SqN1hOFkNcvQX7YiqicQfKsLjW/yLOa9XUjqnJ8UrA5CRmhg
	 mFodb7ncONJIS3SIpnbHKS8kNi+IXUupr+QpispsIfjaJfU8udId7akboJmsgUIXtctZA
	 mDtEIyvNfEJE4/n5Jv851EBUeBp4DOrGLDfzpgQGKevNhQR14tR5OvurpJjVs5x9/tldK
	 VZLNToPNFAWqzO7DuHILWwlb+paCvOY0eoMHNLm6wMKATwcuDGqWPAcMliuU549qf/Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Q09JALmM;
	arc=none smtp.remote-ip=74.125.82.173
Received: from mail-dy1-f173.google.com (mail-dy1-f173.google.com [74.125.82.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FFF7606A321
	for <mptcp@lists.linux.dev>; Mon,  9 Nov 2026 11:21:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5FFF7606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Q09JALmM
Received: by mail-dy1-f173.google.com with SMTP id 5a478bee46e88-3645f0f3fcdso1453815eec.0
        for <mptcp@lists.linux.dev>; Mon, 09 Nov 2026 03:21:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794223289; x=1794828089; darn=lists.linux.dev;
        h=content-type:mime-version:date:content-transfer-encoding:message-id
         :subject:references:in-reply-to:reply-to:cc:to:from:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=WUKoyEdMOFMig1BvKxo1M/BYMu6alxBUyrfz0aCkZU0=;
        b=Q09JALmMo8FSSlZemDU8uMGCYiqja+o0BWs+VHFMyJd9V0PFFmgibn/hu3ZdbV+X+f
         qyDf30RiGW1+GLwFEK7jXMB+jR8XP7u4n0e2w2ryuVcYMA+uU6f+wibEJ3qSjHY+nO4p
         R8g8re2SAtGfZSct/QkiNOnTt+Yc+kvUddIDQ3bR1wu4O64FYVMDtrR6Mk/SAtgxqC75
         aNqiRS9Y3yQIZSVUo1fTx4kSUoVAaynJEHIbC3754HpudP1Sgqje9vGXkcYpNhCGZsgH
         t/8gPsBUctXpJwT/GgyB9B1K2EEHmOYh0Ys3vbz7QchNPuhISQWeIJY5cF8QMmAjFLPJ
         cBGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794223289; x=1794828089;
        h=content-type:mime-version:date:content-transfer-encoding:message-id
         :subject:references:in-reply-to:reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=WUKoyEdMOFMig1BvKxo1M/BYMu6alxBUyrfz0aCkZU0=;
        b=rmm8KZYr/62d4cIz+haIlPi6Bb448PpY7eYuC6vREeo6xG0SyCz2nsxMMJinWKN1Mx
         bxTf/4QQSZsUY1LrnRoZEwPp1VYYQ1gk9UkVBof6VrDwmO0Fhlw1BbFJbayiicHMc0Cg
         aXWLMsdNzBOSW53wCAHih+LJ5VvBrI3GNeXZ6fqOFulhPADbIQth/s8/1W0mwypuOPpo
         oa3N2YfzVPN2kYrlkEP9Ai/julz/qeGo9NMw1PYSm09qzSL9IrXOdPknY2szGHSM1Ers
         YiWOK9wY5esgQdfz1rOd6a7bgV76jiPfdWBeolfvk0hKPJlj78jUSkTyI0jiWsuvyXf6
         7/Mw==
X-Gm-Message-State: APuU4Z8sdmyJdjyNbN4bc7inOL8st+E47ThoIb0gRTJrH99MJMsErifP
	4CaD3Rw5qj4aBt6HQ2EJiyhbuWGtX+hbjmZGXFwV1h4EVYaihc8dQd2vkkR+
X-Gm-Gg: AYBFou1jDCwQR+BVU+pdJBhO0+vOERhoy+ntVv55ZGkF0RfyuGaJrlWST6mqZ44ER0B
	03058Dd7pxJdo1pzJ+RA0I1Mel1helWFES3O2pgi4lW3T0tBP7GJePbzMV+O2iZoz6CCvBADMNc
	QsI/st/yex4ateJKHEStENk6OeFUP4h8szw4bXJ/Lb9LAEf/7ULuFFr2QXKcWUUNzm3nw/1E0ou
	pdHltN53ztpOmihosd0DXHwdf0gDsXsefVZ/RgAwDNtZCRR5ieLbs3dnRv4qLb4az9/OjeUtgEw
	EutPPxH7/v2aipgzq5UPOnZNepn2QX2l7lK+wKXrzsTZ1KkYzLNsd4KtWYbs03t58abpQGQTWsb
	HPGrV9psBQVurLzodZx6oOxKXvUVW0CSvHxJBJ6mMd6biTc3fTAQhRf0ruG8eBPEf1KdHMB/KaU
	ka1AYGJOIiTUtYmFIOAGoNbcDgbC3qVrBt80qqC+PsJqKM1VCjPuxOf4foLYDvBxYJeDY/Yzt5R
	+6lUbGqJyuhIabchnCJkO5jME0XoavY4s9eVQBJ5Sj7AkEwcMXbjxqUElYwLDUV73HMYZjjyzg6
	qpF8NL7SKROesry89dZm0nK95GmrIUboPOaiiWd2dA==
X-Received: by 2002:a05:7301:530b:b0:36c:da71:37e0 with SMTP id 5a478bee46e88-37252f30000mr6735473eec.2.1794223289132;
        Mon, 09 Nov 2026 03:21:29 -0800 (PST)
Received: from github.com ([128.24.163.66])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-373920a0219sm7445756eec.9.2026.11.09.03.21.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 03:21:28 -0800 (PST)
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <tanggeliang@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <cover.1794215614.git.tanggeliang@kylinos.cn>
References: <cover.1794215614.git.tanggeliang@kylinos.cn>
Subject: Re: [PATCH mptcp-next v24 0/8] Reduce the differences between TCP
 and MPTCP for TLS usage
Message-ID: <59982f40-6d73-db4a-419c-dcfdbb3f80ad@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Mon, 09 Nov 2026 11:21:27 +0000
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

Hi Geliang,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: normal (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: btf-normal (only bpftest_all): Success! =E2=9C=85
- KVM Validation: btf-debug (only bpftest_all): Success! =E2=9C=85
- Perf: Unstable: 3 failed test(s): error:sched-mem-pressure(2) =
validation:sched-baseline validation:sched-weak-secondary =
=E2=9A=A0=EF=B8=8F=20
- Task: https://github.com/multipath-tcp/mptcp_net-ne=
xt/actions/runs/42596050890

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_net-next/commits/5138147a86=
16
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?=
series=3D1205871


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
