Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793703371;
	b=P4k/xBdQ0quPXGW5kdFz2GTHLSAvCEnQ67+4waGrDmBXmSaPBbwzn+95652pxfVNwv/S
	 t9QEHomlXmsDZznrSGzshnBasjja6wrIXtCMB9sOKX3EaAnCI2OvK6H8tiFOFAAcVBCqn
	 gCPPw67u1fX9Qs8LQWfXU79oPJy0rqzbDjZAYQ9Ldtsw4p3q8gItPntH7Sp9NxA7TNepU
	 zqA05sj0w7kcuhLj8YQxyhFK8mwRyGu+IPOUe/X7NlKic6ye4uZEGKCufhSI0IYa3dhDl
	 bcTK6O7YNlwXcQkMHLPEQkDxWrLrB1jvQ22t/NIPhc69uLdB7Lzg8qqR3TCrZ23UCRg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793703371;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Reply-To:
	 In-Reply-To:References:Subject:Message-ID:Content-Transfer-Encoding:
	 Date:MIME-Version:Content-Type;
	bh=LRQ+ZRXY34sBy4J/+5+Z1mMpvw6fim8aUfWxHCiuy9M=;
	b=yP7n2rIDBSwwpEjzfzhE3HTi0CzbhpedvgSGpx9UH2RE0VU3yJSDSChFlz8KtO5weG9W
	 CFwJWcBBGK6oePk2IA37AKU4j59/bGSDoLUvNCzTIMUao2tcHAGPG9U/odntrSQtYL5c0
	 xgrkVZzY2T4i+FQ/BaciHl8O7ix+bVvKozWFXpZcotC3S+YY1eXIyAq6g/szcgB0PqGBn
	 hWlu/P9dpf3Kb8KAqivLcBViMOkAVziYpdH6A3we1a8D4hyAZPAT4bhiwmVWy6/CDdgcW
	 ndsagq53Zq1xTeSCAZNQWOwYVA0wn/7k9ltHGbSc6uYPhl2rWIL08FbP9mpiSFIGXrw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=QjgXGhR0;
	arc=none smtp.remote-ip=209.85.210.47
Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15655606EEA8
	for <mptcp@lists.linux.dev>; Tue,  3 Nov 2026 10:56:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 15655606EEA8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=QjgXGhR0
Received: by mail-ot1-f47.google.com with SMTP id 46e09a7af769-82109f51565so2000839a34.2
        for <mptcp@lists.linux.dev>; Tue, 03 Nov 2026 02:56:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793703370; x=1794308170; darn=lists.linux.dev;
        h=content-type:mime-version:date:content-transfer-encoding:message-id
         :subject:references:in-reply-to:reply-to:cc:to:from:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=LRQ+ZRXY34sBy4J/+5+Z1mMpvw6fim8aUfWxHCiuy9M=;
        b=QjgXGhR08/G4iKp57ebpHGQ17AjeDiU8IZ4UjZeWe/YVmbkkJ8gPNULrqcUV91G3sH
         aYVqibG5wv+lx8LZUgyYcYelL/AzUK8yAr+8LQnuJHxih4ru9fc2IW2SBVaTmhd++wxJ
         UFn8ib98F43ohnbBcuxBxNvnig2BBBAImfYvLmn4BZySBgQDxtXnj7V0d87o0PP619sM
         s2nilHPosxqWqMwrh8dLFqRx06EsTkuoN7LMwiNtxlN3xri2KZUns5BHMSKVjiP+p1aD
         vcbdZVvKi/RFHAV0MxvCaltdS5Y0r+xk9Xg1eNV/D/SWSacRa1XmAqBYhsjbmDXHjEz7
         5wTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793703370; x=1794308170;
        h=content-type:mime-version:date:content-transfer-encoding:message-id
         :subject:references:in-reply-to:reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=LRQ+ZRXY34sBy4J/+5+Z1mMpvw6fim8aUfWxHCiuy9M=;
        b=PBb2Tt52nTpnYZZWhnk3FJk6cTcySFXOqrCnIYm1u8TpA7r4oKWQ6oxTigp0ZUpkRn
         egSN5ud5WDMZgv3Eca107LQ/wSVoKTLXWGKyYxd669GwcX4fVq6sX0uSgTNm1ditU+AT
         k16jGeEM5wizf9s6GlEm80M5ZXby9b2OqHWg+tBblgeT9yYUMPPHN3+HNtgpmLQp9w7K
         SQ2h+cHxc7vbgP352vmgmU/U34ZNe5uaFdUGO4lQHxrrWqRWyjqnf/olOYBfPwMoONz1
         t2gb6qvzyYmppLV6xDNaSTWVB+Lyw74SzIM00YGx9nsdSAcrGOjh3kIx0vLAaePhzTOL
         crnw==
X-Gm-Message-State: APuU4Z8RPuy5+sEIceZQxGEvk9JIIlejCYppyO5TLGWkT1g0ijxRFmDm
	kXpyKw6BpKb63n2GWo1uG2BhbKYOvYn1WVeSVQ+wbYAZRF6mB0UTt9NL271EIqlmhQ==
X-Gm-Gg: AYBFou2Lpg0x1cNi5iKEbGfoOMkf4S1y9IMijY2DK8jr3mDOl9t32RX1fKE7rsCHmTY
	ZZ72WQzwKyij0duoOJyqfhyYZcUZzpryOuaJIaAWg6//lDJP+/p4rmnEzfdEOTf/EFZLrBueIm0
	Q+I8Bsk9qFutNAtP2ulCjnS8vBkj9aD27j+FQqmLcO1FH3aHr0VW3g37Pjo7XoRXw1RXQjupbZG
	5VMcqDiA8S8Zioxl0NBpPu6YEw2dMhXBPbj3r1FZnj2E3f3EIohZ4e4xOnQergWg5H324lY7H+X
	E/gT8hF3EvavPm7BweLR5yODwAXAPal4jJ0ZHWUfrBD3mEBjJ4wKCEGBPm/zohw15JSv65d4KSw
	Y0m7feuwFCOowJVBVP6ug1A/kwTYbBq1t/c0s2KtLc0+KEd8nXwbPH8QUzDf5+OvRQojvYEAMTz
	XC4nGV8+UO/As66Nl4UGZIIKdlRGTb+Lj/pQZnA07hcUnWiIFV8+NZrDYx8/gL5QdHGLRcG0zyF
	msiCepj75xVkacAWHV9MrbXclgIKz3lx324qk9fm/gsX/rmZme1AAbF4UHC+M0KUFFm2+0S4TfI
	ofxMmABHS0v3MjxoKBMVREIiX1KQ+HrRTiHl/GWkiQ==
X-Received: by 2002:a05:6808:192a:b0:504:5fe1:c8d4 with SMTP id 5614622812f47-5640de7456amr9280858b6e.59.1793703369900;
        Tue, 03 Nov 2026 02:56:09 -0800 (PST)
Received: from github.com ([158.23.93.163])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-5640fe423fasm10681949b6e.16.2026.11.03.02.56.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 02:56:08 -0800 (PST)
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Anil Kaushik <anilkaushikwireless@gmail.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20261103085244.23064-1-anilkaushikwireless@gmail.com>
References: <20261103085244.23064-1-anilkaushikwireless@gmail.com>
Subject: Re: [PATCH mptcp-next v15 0/7] mptcp: pm: in-kernel: retry
 subflows closed after an error
Message-ID: <429b2de6-d3d6-e353-5976-044ff40bf61e@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Tue, 03 Nov 2026 10:56:07 +0000
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

Hi Anil,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal (except selftest_mptcp_join): Unstable: 1 failed =
test(s): selftest_simult_flows =E2=9A=A0=EF=B8=8F=20
- KVM Validation: normal (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: btf-normal (only bpftest_all): Success! =E2=9C=85
- KVM Validation: btf-debug (only bpftest_all): Success! =E2=9C=85
- Perf: Success! =E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_n=
et-next/actions/runs/41609998274

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_net-next/commits/d3511b76cc=
ff
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?=
series=3D1200003


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
