Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D733288CA8
	for <mptcp@lists.linux.dev>; Wed,  7 May 2025 14:57:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746629829; cv=none; b=tD3Im2V/6Rjevn4j2sYUmdUGAAQ09BRjKiJW7rt1G9+rlYZrnwH57cbfpGXMtDxfTclKigD0PKGyuAwsNJbUEf1mHnXzQfd6a9Ly6ZZKRRYbXKeNGgE1dFI16ECuqDbKFCihAqKuj1rxyxhaH+mHCJ6M+PF16FLfg5b/o0rZtZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746629829; c=relaxed/simple;
	bh=iOX77fTG9vPULsbHclFrhu0mdetHhYTWViIQmjKNCeg=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=TgnGljsAbxYGJ3Nczo4Viu+GFgE5bF2RgfYIZXe4+NSSC/X8UvTjXPjNSW8SdaE6HE2UulkbU1sICZswB2ME7FL0ka0RvLlqIFNQbpnklpV8BBTzv8L+LVt9z0fx5jwJSLxsx5El+0I41DcTpaKf9HS/AzHSo1C2T7GVpw7Xzuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W4N2ilhb; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W4N2ilhb"
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-6f0cfbe2042so14108096d6.1
        for <mptcp@lists.linux.dev>; Wed, 07 May 2025 07:57:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746629826; x=1747234626; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mNk1Sqy48mx1ZCMt/gApuwrLiBnlTRsZE/cdWRKo4nk=;
        b=W4N2ilhbX0kEIDDbf4RSu4GemWAg24aiO8mhegcYeclYTQGoFMOy2vL2d01aV0rfry
         5X5DaTu4oe2WNe+kWm++BDfIgVu7bpUSUZHuMhid0i6k8r6J74qf4p5uXsv7kWFowt6p
         LaAqhYpd4dn9BqAVbHclS3YoNc3x3Z68z0Dz+pd10RCYPeWSHnh68b+LS7fCBz0K4Fo3
         xw3Lx+q3vMbnSuWs6FwNcDduNFKF1PuzyVZRWzlmhA7F43nPazv+MM0abtHHXr4sMWc8
         d9PEJLlbq3rk6MlR/GJaMT3pzW04IjUvgP89Z2l6qsQHXcwFeTRcgLPOIMw7ypS4biWF
         0K6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746629826; x=1747234626;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=mNk1Sqy48mx1ZCMt/gApuwrLiBnlTRsZE/cdWRKo4nk=;
        b=wql5MX7b7V7wjZ6Xwax6Kj4eYx1A6VtTni7Ozm5WLFkHhPiOvhF6yyHfoS4KbkkLAd
         orBYGwC0xQZohyT0X4jWVgHX3hgoR0mwRA17ElSOB9QMc65SOdRKnvG4zbCr9NoXu6NZ
         ayfkM0yxjWEuKPUyFGWkoL+/Bmoc9dS52WqGt1T2N9Bx5SETkCQYDmq/pVpuMJ1ze5D4
         1tdH1ill5ny5UxpoO/SNTcsbJomk0ZcSkii5oAHi4flacHZWBaWKmKftJPQjcjQnkPcY
         eULRra2HyH6dq/+gOFZR5at/hMr8zbrXhfQiJJSOkvaWwIdS7jPykEU6Jh4TNDnw/BxB
         Jhaw==
X-Gm-Message-State: AOJu0YygnEsBWeu9K56DTa1dwxOHxp4irmLQeIlqcNt4Ly6ida46NAlU
	Lm1Vwrx+ko1wUnFDx92+kdVHiL3bl2NsZ8eRJRRIzm3XvGWUZbo=
X-Gm-Gg: ASbGncu7YruMR4LyNzr4Xtp6PzKQLQHAqfZV2wPx2XxAc32sl2JK5ay33+XEmoZdpRB
	C+mxghhWVyvxtvvndPz/n8bXaKKurZtTxd3hPXqtIpr/QC2w8M8+dFQ6FHKs6dxHZhEPJaPmAIl
	vmBCoY7tpRQMd3ePkSvbSZ1mUOH1hiKo0lSWY2WcpTlcWrx9a/zVhQRDUpjHO60drc7fhkZ11F/
	pOOhvpvB69aJ2IX91Ur1r6IxTDvtlSaJWRMxz8rxSIkjCyxTD+hKVohXofhhIFktJg5GZFjs1lc
	OVzCYxbQ+IxNcUK3u+T1dlUhOZqd6/ibX6h5YFsaI6WZo3f1+PG1Nto=
X-Google-Smtp-Source: AGHT+IHgADVUjOZwnmsA7V0W4UDdGMvN26e96kPTSnpniNwQPBfdSRyMjf1FGbrc5Y11mRnVTZ3dHw==
X-Received: by 2002:a05:6214:2625:b0:6e8:903c:6e5b with SMTP id 6a1803df08f44-6f541883334mr65325336d6.9.1746629826312;
        Wed, 07 May 2025 07:57:06 -0700 (PDT)
Received: from [127.0.0.1] ([172.183.94.148])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6f542780ec4sm14580966d6.80.2025.05.07.07.57.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 May 2025 07:57:05 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Hangbin Liu <liuhangbin@gmail.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20250507131856.78393-1-liuhangbin@gmail.com>
References: <20250507131856.78393-1-liuhangbin@gmail.com>
Subject: Re: [PATCH net-next 0/6] selftests: net: configure rp_filter in
 setup_ns
Message-ID: <7bde49a2-43ae-2adf-73d5-6b471d5306f5@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Wed, 07 May 2025 14:57:05 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Hangbin,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal: Success! =E2=9C=85
- KVM Validation: debug: =
Success! =E2=9C=85
- KVM Validation: btf-normal (only bpftest_all): Success=
! =E2=9C=85
- KVM Validation: btf-debug (only bpftest_all): Success! =
=E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/r=
uns/14884715455

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/80adefa07a0f
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?series=3D960467


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
